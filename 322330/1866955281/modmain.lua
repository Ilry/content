local containers = require("containers")
local controller = require("components/playercontroller")

GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local namespace = "trash"
local rpc_client_join = "client_join"
local rpc_send_mod_config = "send_config"
local rpc_shard_clean = "shard_run_clean"
local debugstr = "[" .. namespace .. "] "

local client_display_range = 4
local client_display_item = "xxxx"

-- 范围指示器
local function HelperEntity()
    local helper = CreateEntity()

    --[[Non-networked entity]]
    helper.entity:SetCanSleep(false)
    helper.persists = false

    helper.entity:AddTransform()
    helper.entity:AddAnimState()

    helper:AddTag("CLASSIFIED")
    helper:AddTag("NOCLICK")
    helper:AddTag("placer")

    local scale = math.sqrt(client_display_range * 0.16)
    helper.Transform:SetScale(scale,scale,scale)

    helper.AnimState:SetBank("firefighter_placement")
    helper.AnimState:SetBuild("firefighter_placement")
    helper.AnimState:PlayAnimation("idle")
    helper.AnimState:SetLightOverride(1)
    helper.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    helper.AnimState:SetLayer(LAYER_BACKGROUND)
    helper.AnimState:SetSortOrder(1)
    helper.AnimState:SetAddColour(144/255, 17/255, 17/255, 0)

    return helper
end

-- 左右键显示器
local function LightningRodShowRange(inst)
    if inst.helper_2 == nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        inst.helper_2 = HelperEntity()
        inst.helper_2.owner = inst
        inst.helper_2.Transform:SetPosition(x, y, z)

        inst.helper_2:DoTaskInTime(5, function()
            inst.helper_2:Remove()
            if inst.helper_2 ~= nil then
                inst.helper_2 = nil
            end
        end)
    end
end

-- 放置建筑显示器，显示同类物品范围
local function OnEnableHelper(inst, enabled)
    if enabled then
        if inst.helper == nil then
            inst.helper = HelperEntity()
            inst.helper.entity:SetParent(inst.entity)
        end
    elseif inst.helper ~= nil then
        inst.helper:Remove()
        inst.helper = nil
    end
end

local function RangeHelp(inst)
    if not TheNet:IsDedicated() then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper:AddRecipeFilter(client_display_item)
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end
end

-- 放置建筑图层模型，新放置建筑添加图层
local function placer_postinit_fn(inst)
    local placer2 = HelperEntity()
    placer2.entity:SetParent(inst.entity)
    inst.components.placer:LinkEntity(placer2)
end



----------定义清理逻辑----------

local function ItemRemove(v, cleanuplist)
    local thisPrefab = v.prefab
    -- 不在清理列表 或 不可见
    if cleanuplist[thisPrefab] ~= nil and v.inlimbo == false then
        -- 计算物品清理数量
        local count = v.components.stackable and v.components.stackable:StackSize() or 1
        cleanuplist[thisPrefab].count = cleanuplist[thisPrefab].count + count
        v:Remove()
    end
end

----------查找物品----------
local function RunCleaner(inst, cleanuplist, range)
    -- range==nil 只拆格子物品
    if range == nil then
        return
        -- range== 0 全图清理
    elseif range == 0 then
        for _, v in pairs(Ents) do
            ItemRemove(v, cleanuplist)
        end
        -- 最后执行范围清理
    elseif inst ~= nil and range ~= nil and range ~= 0 then
        local g, h, i = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(g, h, i, range)
        for _, v in pairs(ents) do
            ItemRemove(v, cleanuplist)
        end
        -- 以防万一
    else
        return
    end
end

----------播放结果广告----------
local function DisPlayerMsg(inst, cleanuplist, playername, range)
    for k, v in pairs(cleanuplist) do
        local s = (range == nil and "已销毁") or "已清理"
        local at = ''
        if inst ~= nil and range ~= nil and range ~= 0 then
            local g, h, i = inst.Transform:GetWorldPosition()
            at = string.format("@ (%.2f, %.2f) R: %d", g, i, range)
        end
        local text = string.format("SId:%10s, %s, %s %5d, %s %s", tostring(TheShard:GetShardId()), playername, s, v.count, v.name, at)
        TheNet:SystemMessage(text)
    end
end

----------服务清理方法，需要播放动画----------
local function ServRecFn(player, inst, range)
    local cleanuplist = {}
    local container = inst.components.container

    local hasPlayer = (player ~= nil and player.components.talker ~= nil)
    local playername = (player and player.name) or ""

    if hasPlayer then
        if container:IsEmpty() == false then
            player.components.talker:Say("爽！")
        else
            player.components.talker:Say("自我毁灭？")
        end
    end

    if container:IsEmpty() == false then
        for i = 1, container:GetNumSlots() do
            local item = container:GetItemInSlot(i)
            if item then
                local count = item.components.stackable and item.components.stackable:StackSize() or 1
                cleanuplist[item.prefab] = { name = item.name, count = count }
            end
        end
        if inst.components.prototyper then
            inst.components.prototyper:Activate()
        end
        container:DestroyContents()
        RunCleaner(inst, cleanuplist, range)
        DisPlayerMsg(inst, cleanuplist, playername, range)
    end
    return cleanuplist
end

----------服务RPCRec----------
local function RPCServiceRecFn(player, inst, range, shardRPC)

    if inst == nil then
        return
    end

    local cleanuplist = ServRecFn(player, inst, range)

    if shardRPC == true then
        local playername = (player and player.name) or ""

        local ll = {}
        for k, _ in pairs(cleanuplist) do table.insert(ll, k) end

        local shardlist = {}
        for k, _ in pairs(Shard_GetConnectedShards()) do table.insert(shardlist, k) end

        if #ll ~= 0 and #shardlist ~= 0 then
            SendModRPCToShard(GetShardModRPC(namespace, rpc_shard_clean), shardlist, playername, range, unpack(ll))
        end
    end
end

----------集群RPCRec----------
local function RPCShardRecFn(sending_shard_id, playername, range, ...)
    local cleanuplist = {}

    local arg = { ... }
    for _, v in ipairs(arg) do
        cleanuplist[v] = { name = STRINGS.NAMES[string.upper(v)] or v, count = 0 }
    end
    RunCleaner(nil, cleanuplist, 0)
    DisPlayerMsg(nil, cleanuplist, playername, range)
end

----------格子定义----------

local function box()
    local container = {
        widget = {
            slotpos = {
                Vector3(0, 64 + 32 + 8 + 4, 0),
                Vector3(0, 32 + 4, 0),
                Vector3(0, -(32 + 4), 0),
                Vector3(0, -(64 + 32 + 8 + 4), 0),
            },
            animbank = "ui_cookpot_1x4",
            animbuild = "ui_cookpot_1x4",
            pos = Vector3(150, 0, 0),
            side_align_tip = 100,
            buttoninfo = {
                position = Vector3(0, -165, 0),
            }
        },
        type = "cooker",
        itemtestfn = function(container, item, slot)
            return not (item:HasTag("irreplaceable") or item:HasTag("bundle") or item:HasTag("nobundling"))
        end
    }
    return container
end

----------容器组件绑定----------
-- 改方法用于modinit，游戏载入后无法使用
local function AddComponentContainer(inst)
    if not TheWorld.ismastersim then
        return
    end
    if not inst.components.container then
        inst:AddComponent("container")
        inst.components.container:WidgetSetup(inst.prefab)
    end
end

----------绑定到prefab上----------
-- prefabname 绑定物品名称
-- bottontext 按钮文本描述
-- range 范围 0:全图 nil:仅箱子，4:1个地皮半径
-- shardRPC 是否触发多世界同步，true参数会导致range失效
local function createRpc(prefabname, bottontext, range, shardRPC)
    ----------物品新增格子----------
    local params = containers.params
    params[prefabname] = box()

    ----------按钮触发事件----------

    params[prefabname].widget.buttoninfo.text = bottontext
    AddPrefabPostInit(prefabname, AddComponentContainer)

    AddModRPCHandler(namespace, prefabname, RPCServiceRecFn)
    params[prefabname].widget.buttoninfo.fn = function(inst) SendModRPCToServer(GetModRPC(namespace, prefabname), inst, range, shardRPC) end

end

local function stdanderData(pottedfernrange,researchlab3multi)
    pottedfernrange = tonumber(pottedfernrange)
    if pottedfernrange == nil then
        pottedfernrange = 24
    end

    if researchlab3multi == "true" then
        researchlab3multi = true
    else
        researchlab3multi = false
    end
    return pottedfernrange,researchlab3multi
end

----------服务初始化----------
local function modInit(researchlab2, researchlab3, researchlab3multi, pottedfern, pottedfernrange)

    pottedfernrange,researchlab3multi = stdanderData(pottedfernrange,researchlab3multi)

    print(debugstr .. "researchlab2: " .. tostring(researchlab2))
    print(debugstr .. "researchlab3: " .. tostring(researchlab3))
    print(debugstr .. "researchlab3multi: " .. tostring(researchlab3multi))
    print(debugstr .. "pottedfern: " .. tostring(pottedfern))
    print(debugstr .. "pottedfernrange: " .. tostring(pottedfernrange))


    local pottedfern_eanble = (pottedfern ~=nil and pottedfern ~= "nil" and pottedfernrange ~= nil and pottedfernrange ~= "nil" and pottedfernrange ~= 0 and true) or false

    ----------新增rpc----------
    if researchlab2 ~=nil and researchlab2 ~= "nil" then
        createRpc(researchlab2, "销毁物品", nil, false)
    end
    if researchlab3 ~=nil and researchlab3 ~= "nil" then
        createRpc(researchlab3, "全图打扫", 0, researchlab3multi)
    end    
    if pottedfern_eanble then
        createRpc(pottedfern, "范围打扫", pottedfernrange, false)
    end

    ----------刷新一次最大格子----------
    ----------我只加了4个格子----------
    ----------可以说是完全没必要----------
    ----------但我还是要刷新一次----------

    local params = containers.params
    for k, v in pairs(params) do
        containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
    end

    ----------同步后，对于客户端所有组件刷新一次格子信息----------

    if TheNet:GetIsServer() then
        return
    end

    if pottedfern_eanble then
        client_display_item = pottedfern
        client_display_range = pottedfernrange

        local Prefabs = GLOBAL.Prefabs

        -- AddPrefabPostInit(pottedfern, RangeHelp)
        local old_fn = Prefabs[pottedfern].fn
        Prefabs[pottedfern].fn = function (thsim)
            local inst = old_fn(thsim)
            RangeHelp(inst)
            return inst
        end

        -- AddPrefabPostInit(pottedfern.."_placer", placer_postinit_fn)
        local old_place_fn = Prefabs[pottedfern.."_placer"].fn
        Prefabs[pottedfern.."_placer"].fn = function (thsim)
            local inst = old_place_fn(thsim)
            placer_postinit_fn(inst)
            return inst
        end
    end

    for _, v in pairs(Ents) do
        if v.prefab == researchlab2 or v.prefab == researchlab3 or v.prefab == pottedfern then
            v.replica.container:WidgetSetup(v.prefab)
        end
        if pottedfern_eanble and v.prefab == pottedfern then
            RangeHelp(v)
            v.components.deployhelper:OnEntityWake()
        end
    end

end


----------使用rpc从服务器获取配置----------

local researchlab2_config = GetModConfigData("researchlab2", true)
local researchlab3_config = GetModConfigData("researchlab3", true)
local researchlab3multi_config = GetModConfigData("researchlab3multi", true)
local pottedfern_config = GetModConfigData("pottedfern", true)
local pottedfernrange_config = GetModConfigData("pottedfernrange", true)

----------注册服务器RPCRec接收客户端连接----------
AddModRPCHandler(namespace, rpc_client_join, function(player)
    print(debugstr.."client_join: "..player.userid)
    SendModRPCToClient(GetClientModRPC(namespace, rpc_send_mod_config), player.userid, researchlab2_config, researchlab3_config, researchlab3multi_config, pottedfern_config, pottedfernrange_config)
end)

----------注册ShardRPC----------
AddShardModRPCHandler(namespace, rpc_shard_clean, RPCShardRecFn)

----------注册客户机RPCRec----------
AddClientModRPCHandler(namespace, rpc_send_mod_config, function(researchlab2, researchlab3, researchlab3multi, pottedfern, pottedfernrange)
    modInit(researchlab2, researchlab3, researchlab3multi, pottedfern, pottedfernrange)
end)



if TheNet:GetIsServer() then
    modInit(researchlab2_config, researchlab3_config, researchlab3multi_config, pottedfern_config, pottedfernrange_config)
end

-- 实现逻辑，利用RPC实现配置同步与世界信息同步
-- 
-- 配置同步
-- 服务端：modInit->客户端：创建人物->客户端：rpc_client_join->服务端：rpc_send_mod_config->客户端：modInit
-- 
-- 清理
-- 客户端：send_rpc_to_serv->服务端：rpc_recviver->服务端：rpc_shard_send
-- 
-- 

if TheNet:IsDedicated() then
    return
end

----------载入配置----------
local isfirstIn = true

AddPlayerPostInit(function(inst)
    if isfirstIn then
        isfirstIn = false
        SendModRPCToServer(GetModRPC(namespace, rpc_client_join))
    end
end)

----------左键与检查修改----------

client_display_range,_ = stdanderData(pottedfernrange_config,researchlab3multi_config)
client_display_item = pottedfern_config

local old_OnLeftClick = controller.OnLeftClick
function controller:OnLeftClick (down, ...)
    if (not down) and self:UsingMouse() and self:IsEnabled() and not TheInput:GetHUDEntityUnderMouse() then
        local item = TheInput:GetWorldEntityUnderMouse()
        if item and (item.prefab == client_display_item) then
            LightningRodShowRange(item)
        end
    end
    return old_OnLeftClick(self, down, ...)
end

local old_DoInspectButton = controller.DoInspectButton
function controller:DoInspectButton(...)
    local entity = self:GetControllerTarget()
    if entity and (entity.prefab == client_display_item) then
        LightningRodShowRange(entity)
    end
    old_DoInspectButton(self, ...)
end
