local containers = require("containers")
local containercfg = GetModConfigData("Container Sort")
local itemscfg = GetModConfigData("Items collect")
local hasmultisort = containercfg == -2 or containercfg == true
local haslockbutton = containercfg == -3
local hascollectbutton = containercfg ~= -4
local hasitemscollect = itemscfg ~= -1
local hasitemsstore = itemscfg ~= -2

-- 给容器添加"dcs2hm"标签或容器.dcs2hm = true可以禁用对容器进行的各种功能
-- 不会在下列容器的界面上显示收集和整理按钮
local btnblacklist = {"hh_ui_container"}
-- 不会从下列容器中收集道具
local collectblacklist = {"pandoraschest", "minotaurchest", "terrariumchest"}
-- 不会存放到下列容器
local storeblacklist = {
    "dragonflyfurnace",
    "oceantree_pillar",
    "researchlab",
    "researchlab2",
    "researchlab3",
    "researchlab4",
    "plant_nepenthes_l",
    "iai_rubbishbox",
    "pandoraschest",
    "minotaurchest",
    "terrariumchest"
}

-- 补丁
AddComponentPostInit("container", function(self)
    local oldGiveItem = self.GiveItem
    self.GiveItem = function(self, item, ...) return item ~= nil and item:IsValid() and oldGiveItem(self, item, ...) end
end)

--
-- 下面部分代码来自[码到成功]
-- 
local ac_fns = {
    cmp = function(p1, p2)
        if not (p1 and p2) then return end
        return tostring(p1.prefab) < tostring(p2.prefab) and true or false
    end,
    isInventory = function(inst) return inst.components.inventoryitem and inst.components.inventoryitem.canonlygoinpocket end,
    isEquippable = function(inst) return inst.components.equippable end,
    isStackable = function(inst) return inst.components.stackable end,
    isPerishable = function(inst) return inst.components.perishable end,
    isEdible = function(inst) return inst.components.edible end,
    hasPercent = function(inst)
        if inst.components.fueled or inst.components.finiteuses or inst.components.armor then return true end
        return false
    end,
    isCHARACTER = function(inst)
        local recipes = CRAFTING_FILTERS.CHARACTER.recipes
        if recipes and type(recipes) == "table" then for _, v in ipairs(recipes) do if inst.prefab == v then return true end end end
        return false
    end,
    isREFINE = function(inst)
        if inst.prefab == "bearger_fur" then return false end
        local recipes = CRAFTING_FILTERS.REFINE.recipes
        if recipes and type(recipes) == "table" then for _, v in ipairs(recipes) do if inst.prefab == v then return true end end end
        return false
    end,
    isRESTORATION = function(inst)
        -- 遍历治疗制作栏
        local recipes = CRAFTING_FILTERS.RESTORATION.recipes
        if recipes and type(recipes) == "table" then for _, v in ipairs(recipes) do if inst.prefab == v then return true end end end
        if inst.prefab == "jellybean" then return true end
        return false
    end,
    isSilkFabric = function(inst)
        if inst:HasTag("cattoy") or inst.prefab == "silk" or inst.prefab == "bearger_fur" or inst.prefab == "furtuft" or inst.prefab == "shroom_skin" or
            inst.prefab == "dragon_scales" then return true end
        return false
    end,
    isRocks = function(inst)
        if inst:HasTag("molebait") or inst.prefab == "townportaltalisman" or inst.prefab == "moonrocknugget" then return true end
        return false
    end,
    genericResult = function(...)
        local args = {...}
        local result = {}
        if #args > 0 then for _, tab in ipairs(args) do for _, v in ipairs(tab) do table.insert(result, v) end end end
        return result
    end
}
-- 注意每个ifelse的判定块都必须有一张表存在，不然会丢东西。
---@param slots table[] Prefab
local function preciseClassification(slots)
    local canonlygoinpocket = {}
    local equippable = {perishable = {}, non_percentage = {}, hands = {}, head = {}, body = {}, rest = {}}
    local non_stackable = {perishable = {}, rest = {}}
    local stackable = {perishable = {}, rest = {}} -- 由于扩充表的存在，perishable 算是 rest。
    -- 扩充表内容。注意此处请提前初始化完毕，不然会弄混！
    local stackable_perishable = {
        deployedfarmplant = {},
        preparedfood = {edible_veggie = {}, edible_meat = {}, rest = {}},
        edible_veggie = {},
        edible_meat = {}
    }

    -- 初始化表。注意新加表的时候必须在此处初始化！
    equippable.perishable = equippable.perishable or {}
    equippable.non_percentage = equippable.non_percentage or {}
    equippable.hands = equippable.hands or {}
    equippable.head = equippable.head or {}
    equippable.body = equippable.body or {}
    equippable.rest = equippable.rest or {}

    non_stackable.perishable = non_stackable.perishable or {}
    non_stackable.rest[1] = non_stackable.rest[1] or {}
    non_stackable.rest[2] = non_stackable.rest[2] or {}

    stackable.perishable = stackable.perishable or {}
    stackable.rest[1] = stackable.rest[1] or {}
    stackable.rest[2] = stackable.rest[2] or {}
    stackable.rest[3] = stackable.rest[3] or {}
    stackable.rest[4] = stackable.rest[4] or {}
    stackable.rest[5] = stackable.rest[5] or {}
    stackable.rest[6] = stackable.rest[6] or {}
    stackable.rest[7] = stackable.rest[7] or {}
    stackable.rest[8] = stackable.rest[8] or {}
    stackable.rest[9] = stackable.rest[9] or {}

    slots = slots or {}

    if #slots > 0 then
        for _, v in ipairs(slots) do
            if v ~= nil then
                if ac_fns.isInventory(v) then
                    table.insert(canonlygoinpocket, v)
                elseif ac_fns.isEquippable(v) then
                    local equipslot = v.components.equippable.equipslot
                    if ac_fns.isPerishable(v) then
                        table.insert(equippable.perishable, v)
                    elseif not ac_fns.hasPercent(v) or (ac_fns.hasPercent(v) and v:HasTag("hide_percentage")) then
                        table.insert(equippable.non_percentage, v)
                    elseif equipslot == EQUIPSLOTS.HANDS then
                        table.insert(equippable.hands, v)
                    elseif equipslot == EQUIPSLOTS.HEAD then
                        table.insert(equippable.head, v)
                    elseif equipslot == EQUIPSLOTS.BODY then
                        table.insert(equippable.body, v)
                    else
                        table.insert(equippable.rest, v) -- 剩余
                    end
                elseif not ac_fns.isStackable(v) then
                    if ac_fns.isPerishable(v) then
                        table.insert(non_stackable.perishable, v)
                    elseif ac_fns.hasPercent(v) then
                        table.insert(non_stackable.rest[1], v)
                    else
                        table.insert(non_stackable.rest[2], v) -- 剩余
                    end
                else
                    if ac_fns.isPerishable(v) then
                        if v:HasTag("deployedfarmplant") then
                            table.insert(stackable_perishable.deployedfarmplant, v)
                        elseif v:HasTag("preparedfood") then
                            if ac_fns.isEdible(v) then
                                if v.components.edible.foodtype == FOODTYPE.VEGGIE then
                                    table.insert(stackable_perishable.preparedfood.edible_veggie, v)
                                elseif v.components.edible.foodtype == FOODTYPE.MEAT then
                                    table.insert(stackable_perishable.preparedfood.edible_meat, v)
                                else
                                    table.insert(stackable_perishable.preparedfood.rest, v) -- 剩余
                                end
                            else
                                table.insert(stackable_perishable.preparedfood.rest, v) -- 剩余
                            end
                        else
                            if ac_fns.isEdible(v) then
                                if v.components.edible.foodtype == FOODTYPE.VEGGIE then
                                    table.insert(stackable_perishable.edible_veggie, v)
                                elseif v.components.edible.foodtype == FOODTYPE.MEAT then
                                    table.insert(stackable_perishable.edible_meat, v)
                                else
                                    table.insert(stackable.perishable, v) -- 剩余
                                end
                            else
                                table.insert(stackable.perishable, v) -- 剩余
                            end
                        end
                    elseif v:HasTag("fertilizerresearchable") then
                        table.insert(stackable.rest[4], v)
                    elseif ac_fns.isCHARACTER(v) then
                        table.insert(stackable.rest[7], v)
                    elseif ac_fns.isRESTORATION(v) then
                        table.insert(stackable.rest[6], v)
                    elseif v:HasTag("gem") then
                        table.insert(stackable.rest[1], v)
                    elseif ac_fns.isRocks(v) then
                        table.insert(stackable.rest[2], v)
                    elseif ac_fns.isREFINE(v) then
                        table.insert(stackable.rest[8], v)
                    elseif ac_fns.isSilkFabric(v) then
                        table.insert(stackable.rest[5], v)
                    elseif ac_fns.isEdible(v) then
                        table.insert(stackable.rest[9], v)
                    else
                        table.insert(stackable.rest[3], v) -- 剩余
                    end
                end
            end
        end
    end

    local cmp = ac_fns.cmp

    -- 首先把列表里面的项全按字典序排列一遍
    table.sort(canonlygoinpocket, cmp)
    table.sort(equippable.perishable, cmp) -- perishable
    table.sort(equippable.non_percentage, cmp) -- non_percentage
    table.sort(equippable.hands, cmp) -- hands
    table.sort(equippable.head, cmp) -- head
    table.sort(equippable.body, cmp) -- body
    table.sort(equippable.rest, cmp) -- rest

    table.sort(non_stackable.perishable, cmp) -- perishable
    table.sort(non_stackable.rest[1], cmp) -- hasPercent
    table.sort(non_stackable.rest[2], cmp) -- rest

    table.sort(stackable.perishable, cmp) -- perishable
    table.sort(stackable.rest[1], cmp) -- tag:gem
    table.sort(stackable.rest[2], cmp) -- tag:molebait
    table.sort(stackable.rest[3], cmp) -- rest
    table.sort(stackable.rest[4], cmp) -- tag:fertilizerresearchable
    table.sort(stackable.rest[5], cmp) -- custom: 丝织类
    table.sort(stackable.rest[6], cmp) -- custom: 治疗
    table.sort(stackable.rest[7], cmp) -- custom: 人物
    table.sort(stackable.rest[8], cmp) -- custom: 精炼
    table.sort(stackable.rest[9], cmp) -- custom: 食用

    table.sort(stackable_perishable.deployedfarmplant, cmp)
    table.sort(stackable_perishable.edible_veggie, cmp)
    table.sort(stackable_perishable.edible_meat, cmp)
    table.sort(stackable_perishable.preparedfood.edible_veggie, cmp)
    table.sort(stackable_perishable.preparedfood.edible_meat, cmp)
    table.sort(stackable_perishable.preparedfood.rest, cmp)

    -- 请保证健壮性。如果漏东西，那么问题是会非常严重的。

    -- 2023-03-13-20:08：搞复杂了，没必要。之后简化一下！！！而且其实没这么细！有些交集太多了。但是到底应该怎么设计呢？
    return ac_fns.genericResult(canonlygoinpocket, -- 装备：头部、身体、手部、剩余、无百分比
    equippable.head, equippable.body, equippable.hands, equippable.rest, equippable.non_percentage, -- 不可堆叠：有百分比、剩余
    non_stackable.rest[1], non_stackable.rest[2], -- 可堆叠：人物、治疗、可食用、宝石、鼹鼠爱吃的、丝织类、精炼、剩余、粪肥
    stackable.rest[7], stackable.rest[6], stackable.rest[9], stackable.rest[1], stackable.rest[2], stackable.rest[5], stackable.rest[8], stackable.rest[3],
                                stackable.rest[4], -- 装备：有新鲜度；
    -- 不可堆叠：有新鲜度；
    -- 可堆叠有新鲜度：种子、可食用素、可食用荤、剩余；
    -- 可堆叠有新鲜度的料理：可食用素、可食用荤、剩余；
    equippable.perishable, non_stackable.perishable, stackable_perishable.deployedfarmplant, stackable_perishable.edible_veggie,
                                stackable_perishable.edible_meat, stackable.perishable, -- rest
    stackable_perishable.preparedfood.edible_veggie, stackable_perishable.preparedfood.edible_meat, stackable_perishable.preparedfood.rest)
end
-- 优化一下整理算法。不只是按字母首字母排序。
local function API_arrangeContainer2(inst)
    if not (inst and inst.components and (inst.components.container ~= nil or inst.components.inventory ~= nil)) then return end
    -- 首先先把里面的空洞给处理掉
    local container = inst.components.inventory or inst.components.container
    local slots = container.itemslots or container.slots

    local keys = {}
    for k, _ in pairs(slots) do keys[#keys + 1] = k end
    table.sort(keys)

    -- 这里很强！
    for k, v in ipairs(keys) do
        if k ~= v then
            local item = container:RemoveItemBySlot(v)
            container:GiveItem(item, k) -- Q: 如果超过堆叠上限会发生什么？ A: 会掉落
        end
    end

    -- 新的 slots
    slots = container.itemslots or container.slots

    -- 空洞已经处理完毕，开始排序了
    if inst.components.inventory then
        container.itemslots = preciseClassification(slots)
    else
        container.slots = preciseClassification(slots)
    end

    -- 更 新的 slots
    slots = container.itemslots or container.slots

    -- 此时，已经完全排序好了，开始整理
    for i, _ in ipairs(slots) do
        local item = container:RemoveItemBySlot(i)
        container:GiveItem(item) -- slot == nil，会遍历每一个格子把 item 塞进去，item == nil，返回 true
    end
end
--
-- 上面部分代码来自[码到成功]
-- 

local samecontainers = {
    -- {"inventory", "backpack", "piggyback", "icepack", "spicepack", "krampus_sack"},
    {"treasurechest", "dragonflychest"}
    -- {"tacklecontainer", "supertacklecontainer"}
}

local function issamecontainer(inst, v, incontainer)
    if incontainer then
        if inst.components.inventory and v.components.container and v.components.container.itemtestfn == nil then return true end
        if v.components.inventory and inst.components.container and inst.components.container.itemtestfn == nil then return true end
        if inst.components.container and v.components.container and inst.components.container.itemtestfn == v.components.container.itemtestfn then
            return true
        end
    end
    for _, containerstmp in ipairs(samecontainers) do
        if table.contains(containerstmp, inst.prefab) and table.contains(containerstmp, v.prefab) then return true end
    end
end

-- 跨容器排序
local GROUND_CONTAINER_CANT_TAGS = {"INLIMBO", "NOCLICK", "_inventoryitem", "FX", "dcs2hm"}
local function API_arrangeMultiContainers2(inst, player)
    if not (inst and inst.components and inst.components.container ~= nil) then return end
    local ents = {}
    if player and player.components and player.components.inventory and inst.components.equippable and inst.components.equippable:IsEquipped() then
        -- 糖果袋类背包单独处理
        if inst.components.container.itemtestfn ~= nil then
            API_arrangeContainer2(inst)
            API_arrangeContainer2(player)
            return
        end
        -- 背包则只处理自己和物品栏
        table.insert(ents, inst)
        inst = player
    elseif inst.components.inventoryitem and inst.components.inventoryitem.owner and inst.components.inventoryitem.owner.components and
        (inst.components.inventoryitem.owner.components.inventory or inst.components.inventoryitem.owner.components.container) then
        -- 钓具箱类只处理自己和所处容器内的同类容器
        local hasothercontainers = false
        local container = (inst.components.inventoryitem.owner.components.inventory or inst.components.inventoryitem.owner.components.container)
        for k, v in pairs(container.itemslots or container.slots) do
            if v:IsValid() and v ~= inst and not v:HasTag("dcs2hm") and not v.dcs2hm and v.components.container and v.components.container.canbeopened and
                (v.prefab == inst.prefab or issamecontainer(inst, v, true)) then
                hasothercontainers = true
                table.insert(ents, v)
            end
        end
        if not hasothercontainers then
            API_arrangeContainer2(inst)
            return
        end
    elseif inst.components.inventoryitem then
        API_arrangeContainer2(inst)
        return
    else
        -- 地面同名容器检测
        local x, y, z = inst.Transform:GetWorldPosition()
        local platform = inst:GetCurrentPlatform()
        local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
        local hasothercontainers = false
        for i, v in ipairs(nearents) do
            if v ~= inst and not v.dcs2hm and v.components and v.components.container and v.components.container.canbeopened and not v.components.inventoryitem and
                (v.prefab == inst.prefab) and v:GetCurrentPlatform() == platform then
                hasothercontainers = true
                if v.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(v.Transform:GetWorldPosition()) end
                table.insert(ents, v)
            end
        end
        if not hasothercontainers then
            API_arrangeContainer2(inst)
            return
        end
    end
    -- 首先主容器物品收集
    local container = inst.components.inventory or inst.components.container
    local slots = container.itemslots or container.slots
    local keys = {}
    for k, _ in pairs(slots) do keys[#keys + 1] = k end
    table.sort(keys)
    -- 这里很强！
    for k, v in ipairs(keys) do
        if k ~= v then
            local item = container:RemoveItemBySlot(v)
            container:GiveItem(item, k)
        end
    end
    -- 新的 slots
    slots = container.itemslots or container.slots
    local totalslots = {}
    for key, value in ipairs(slots) do
        if value ~= nil then
            local item = container:RemoveItemBySlot(key)
            table.insert(totalslots, item)
        end
    end
    -- 其次额外的容器物品收集
    local tmpents = {}
    if inst.virtchest and inst.virtchest:IsValid() and inst.virtchest.components.container then table.insert(tmpents, inst.virtchest) end
    for i, v in ipairs(ents) do
        table.insert(tmpents, v)
        if v.virtchest and v.virtchest:IsValid() and v.virtchest.components.container then table.insert(tmpents, v.virtchest) end
    end
    for i, v in ipairs(tmpents) do
        local container = v.components.container
        local slots = container.slots
        local keys = {}
        for k, _ in pairs(slots) do keys[#keys + 1] = k end
        table.sort(keys)
        -- 这里很强！
        for k, v in ipairs(keys) do
            if k ~= v then
                local item = container:RemoveItemBySlot(v)
                container:GiveItem(item, k)
            end
        end
        -- 新的 slots
        slots = container.slots
        for key, value in ipairs(slots) do
            if value ~= nil then
                local item = container:RemoveItemBySlot(key)
                table.insert(totalslots, item)
            end
        end
    end
    -- 用一个大容器来整理,但是火女的余烬存放进去后会用到主人的skilltree,因此余烬要特殊处理
    local tmp = CreateEntity()
    tmp:AddComponent("container")
    if inst == player then tmp:AddComponent("skilltreeupdater") end
    tmp.components.container.ShouldPrioritizeContainer = truefn
    tmp.components.container.CanTakeItemInSlot = truefn
    tmp.components.container:SetNumSlots(#totalslots)
    for _, item in ipairs(totalslots) do tmp.components.container:GiveItem(item) end
    API_arrangeContainer2(tmp)
    -- 分配到各个容器
    local finalslots = tmp.components.container.slots
    local entindex = 1
    local entsnumslots = ents[1].components.container.numslots + (container.maxslots or container.numslots)
    for index, item in ipairs(finalslots) do
        local item = tmp.components.container:RemoveItemBySlot(index)
        if not ents[entindex] then
            ents[1].components.container:GiveItem(item)
        elseif index <= (container.maxslots or container.numslots) then
            container:GiveItem(item)
        elseif index <= entsnumslots then
            ents[entindex].components.container:GiveItem(item)
        else
            entindex = entindex + 1
            if ents[entindex] then
                entsnumslots = entsnumslots + ents[entindex].components.container.numslots
                ents[entindex].components.container:GiveItem(item)
            else
                ents[1].components.container:GiveItem(item)
            end
        end
    end
    tmp:Remove()
end

-- 跨容器排序
local function sortmulticontainer2hm(player, inst)
    if inst and inst.components and inst.components.container ~= nil then API_arrangeMultiContainers2(inst, player) end
end

AddModRPCHandler("MOD_HARDMODE", "sortmulticontainer2hm", sortmulticontainer2hm)

local function sortcontainerbuttonmultiinfofn(inst, doer)
    if inst.components.container ~= nil then
        sortmulticontainer2hm(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "sortmulticontainer2hm"), inst)
    end
end

-- 单容器排序
local function sortcontainer2hm(player, inst)
    if inst and inst.components and inst.components.container ~= nil then
        API_arrangeContainer2(inst)
        if inst.components.equippable and inst.components.equippable:IsEquipped() then API_arrangeContainer2(player) end
    end
end

AddModRPCHandler("MOD_HARDMODE", "sortcontainer2hm", sortcontainer2hm)

local function sortcontainerbuttoninfofn(inst, doer)
    if inst.components.container ~= nil then
        sortcontainer2hm(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "sortcontainer2hm"), inst)
    end
end

local function sortcontainerbuttoninfovalidfn(inst) return inst.components.container ~= nil or inst.replica.container ~= nil end

-- 跨世界传送按钮
local function findcontainerproxyname(inst)
    if TheWorld.PocketDimensionContainers then
        for name, container in pairs(TheWorld.PocketDimensionContainers) do if container == inst then return name end end
    end
end

local function findanotherworldid()
    if ShardList then
        local shardids = {}
        for world_id, v in pairs(ShardList) do
            if world_id ~= TheShard:GetShardId() and Shard_IsWorldAvailable(world_id) then table.insert(shardids, world_id) end
        end
        if #shardids > 0 then return shardids[math.random(#shardids)] end
    end
end

local function processcontainerproxymastersend(inst, player, second, worldid, name)
    if inst and inst.components and inst.components.container ~= nil then
        local containername = name or findcontainerproxyname(inst)
        local world_id = worldid or findanotherworldid()
        local container = inst.components.container
        if containername and world_id then
            if second then
                for i = 1, container.numslots do
                    local item = container.slots[i]
                    if item ~= nil and item:IsValid() then item:PushEvent("player_despawn") end
                end
            end
            local containerdata = container:OnSave()
            if second then
                for i = 1, container.numslots do
                    local item = container.slots[i]
                    if item ~= nil and item:IsValid() then item:Remove() end
                end
            end
            SendModRPCToShard(GetShardModRPC("MOD_HARDMODE", second and "sendcontainerproxyworldsecond2hm" or "sendcontainerproxyworldfirst2hm"), nil, world_id,
                              containername, DataDumper(containerdata, nil, true))
            if player and player.components.talker then
                player.components.talker:Say((TUNING.isCh2hm and ("正在穿越到世界" .. world_id .. "啦") or
                                                 ("Passing through to world " .. world_id .. " ~")))
            end
        elseif player and player.components.talker then
            player.components.talker:Say((TUNING.isCh2hm and "找不到世界和容器穿越哎" or "Pass through can't find another world or container"))
        end
    end
end

local function processcontainerproxymasterreceive(inst, containerdata)
    if inst and inst.components and inst.components.container ~= nil and containerdata then
        local container = inst.components.container
        for i = 1, container.numslots do
            local item = container.slots[i]
            if item ~= nil and item:IsValid() then item:PushEvent("player_despawn") end
        end
        for i = 1, container.numslots do
            local item = container.slots[i]
            if item ~= nil and item:IsValid() then item:Remove() end
        end
        container:OnLoad(containerdata)
    end
end

-- 本世界穿越数据给其他世界,其他世界又穿越数据回来,进行处理
AddShardModRPCHandler("MOD_HARDMODE", "sendcontainerproxyworldsecond2hm", function(shard_id, world_id, name, containerdata)
    if TheShard and tostring(TheShard:GetShardId()) ~= tostring(shard_id) and tostring(TheShard:GetShardId()) == tostring(world_id) then
        local container = TheWorld:GetPocketDimensionContainer(name)
        if container and containerdata then
            local success, data = RunInSandboxSafe(containerdata)
            if success then
                processcontainerproxymasterreceive(container, data)
                if container and container.containerprocesstask2hm then
                    container.containerprocesstask2hm:Cancel()
                    container.containerprocesstask2hm = nil
                end
            end
        end
    end
end)

-- 收到其他世界穿越来的数据,把自己的数据穿越给对方
AddShardModRPCHandler("MOD_HARDMODE", "sendcontainerproxyworldfirst2hm", function(shard_id, world_id, name, containerdata)
    if TheShard and TheShard:GetShardId() ~= shard_id and TheShard:GetShardId() == world_id then
        local container = TheWorld:GetPocketDimensionContainer(name)
        if container and containerdata then
            local success, data = RunInSandboxSafe(containerdata)
            if success then
                processcontainerproxymastersend(container, nil, true, shard_id, name)
                processcontainerproxymasterreceive(container, data)
            end
        end
    end
end)

local function sendscontainerproxyotherworld(player, inst)
    if TheWorld.ismastersim and inst.components ~= nil and inst.components.container ~= nil and not inst.containerprocesstask2hm then
        inst.containerprocesstask2hm = inst:DoTaskInTime(3, function() inst.containerprocesstask2hm = nil end)
        processcontainerproxymastersend(inst, player)
    end
end

AddModRPCHandler("MOD_HARDMODE", "sendcontainerproxyworld2hm", sendscontainerproxyotherworld)

local function sendscontainerproxyotherworldfn(inst, doer)
    if inst.components.container and TheWorld.ismastersim then
        sendscontainerproxyotherworld(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "sendcontainerproxyworld2hm"), inst)
    end
end

local function sendscontainerproxyotherworldvalidfn(inst) return inst.components.container ~= nil or inst.replica.container ~= nil end

-- 换装按钮
local function reskininwardrobe2hm(player, inst)
    if inst and inst.components.wardrobe ~= nil and inst:HasTag("wardrobe") then BufferedAction(player, inst, ACTIONS.CHANGEIN):Do() end
end

AddModRPCHandler("MOD_HARDMODE", "reskininwardrobe2hm", reskininwardrobe2hm)

local function reskinfn(inst, doer)
    if inst.components.wardrobe ~= nil and inst:HasTag("wardrobe") then
        BufferedAction(doer, inst, ACTIONS.CHANGEIN):Do()
    elseif inst.replica.container ~= nil and inst:HasTag("wardrobe") then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "reskininwardrobe2hm"), inst)
    end
end

local function reskinvalidfn(inst) return (inst.components.container ~= nil or inst.replica.container ~= nil) and inst:HasTag("wardrobe") end

-- 跨容器收纳
local getfinalowner
getfinalowner = function(inst)
    return inst.components and inst.components.inventoryitem and inst.components.inventoryitem.owner and getfinalowner(inst.components.inventoryitem.owner) or
               inst
end

local iscontainerowner
iscontainerowner = function(inst, item)
    if not (item.components and item.components.container) then return false end
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if owner == item then
        return true
    elseif owner ~= nil then
        return iscontainerowner(owner, item)
    end
end

local findcontainerincontainers
findcontainerincontainers = function(inst, containers)
    for k, v in pairs(inst.components.container.slots) do
        if v:IsValid() and not v:HasTag("dcs2hm") and not v.dcs2hm and v ~= inst and v.components.container and v.components.container.canbeopened then
            table.insert(containers, v)
            findcontainerincontainers(v, containers)
        end
    end
end

local function collectcontaineritem(inst, container, item, entcontainer, i, data, onlyone)
    if item ~= nil and item:IsValid() and table.contains(data.prefabs, item.prefab) and item ~= inst and not iscontainerowner(inst, item) and
        container:CanTakeItemInSlot(item) then
        if item.components and item.components.stackable and data.itemlackstackables[item.prefab] then
            -- 是所需堆叠,处理需求与供给数目关系
            if data.itemlackstackables[item.prefab] >= item.components.stackable.stacksize then
                -- 需求比供给多,直接给
                local giveitem
                if data.onlyneed and data.onlyneed > 0 then
                    giveitem = item.components.stackable:Get(math.min(item.components.stackable.stacksize, data.onlyneed))
                    data.onlyneed = data.onlyneed - giveitem.components.stackable.stacksize
                else
                    giveitem = entcontainer:RemoveItemBySlot(i)
                end
                data.itemlackstackables[giveitem.prefab] = data.itemlackstackables[giveitem.prefab] - giveitem.components.stackable.stacksize
                if data.itemlackstackables[giveitem.prefab] == 0 and data.extranumslots == 0 then data.itemlackstackables[giveitem.prefab] = nil end
                container:GiveItem(giveitem, nil, onlyone and entcontainer.inst:GetPosition())
                if entcontainer.inst.Transform and not entcontainer.inst.components.inventoryitem then
                    SpawnPrefab("sand_puff").Transform:SetPosition(entcontainer.inst.Transform:GetWorldPosition())
                end
                if onlyone then
                    if data.onlyneed then
                        if data.onlyneed <= 0 then return true end
                    elseif data.itemlackstackables[item.prefab] == 0 then
                        return true
                    end
                end
            elseif data.extranumslots > 0 then
                -- 需求比供给少,但有空间,直接给
                data.extranumslots = data.extranumslots - 1
                local giveitem
                if data.onlyneed and data.onlyneed > 0 then
                    giveitem = item.components.stackable:Get(math.min(item.components.stackable.stacksize, data.onlyneed))
                    data.onlyneed = data.onlyneed - giveitem.components.stackable.stacksize
                elseif onlyone then
                    giveitem = item.components.stackable:Get(data.itemlackstackables[item.prefab])
                else
                    giveitem = entcontainer:RemoveItemBySlot(i)
                end
                data.itemlackstackables[giveitem.prefab] = data.itemlackstackables[giveitem.prefab] + giveitem.components.stackable.maxsize -
                                                               giveitem.components.stackable.stacksize
                if data.itemlackstackables[giveitem.prefab] == 0 and data.extranumslots == 0 then data.itemlackstackables[giveitem.prefab] = nil end
                container:GiveItem(giveitem, nil, onlyone and entcontainer.inst:GetPosition())
                if entcontainer.inst.Transform and not entcontainer.inst.components.inventoryitem then
                    SpawnPrefab("sand_puff").Transform:SetPosition(entcontainer.inst.Transform:GetWorldPosition())
                end
                if onlyone then if not data.onlyneed or data.onlyneed <= 0 then return true end end
            elseif data.itemlackstackables[item.prefab] > 0 then
                -- 需求比供给少且没有新空间
                local giveitem
                if data.onlyneed and data.onlyneed > 0 then
                    giveitem = item.components.stackable:Get(math.min(item.components.stackable.stacksize, data.onlyneed))
                    data.onlyneed = data.onlyneed - giveitem.components.stackable.stacksize
                else
                    giveitem = item.components.stackable:Get(data.itemlackstackables[item.prefab])
                end
                data.itemlackstackables[giveitem.prefab] = nil
                container:GiveItem(giveitem, nil, onlyone and entcontainer.inst:GetPosition())
                if entcontainer.inst.Transform and not entcontainer.inst.components.inventoryitem then
                    SpawnPrefab("sand_puff").Transform:SetPosition(entcontainer.inst.Transform:GetWorldPosition())
                end
                if onlyone then if not data.onlyneed or data.onlyneed <= 0 then return true end end
            end
        elseif data.extranumslots > 0 then
            data.extranumslots = data.extranumslots - 1
            local giveitem
            if data.onlyneed and data.onlyneed > 0 and item.components.stackable then
                giveitem = item.components.stackable:Get(math.min(item.components.stackable.stacksize, data.onlyneed))
                data.onlyneed = data.onlyneed - giveitem.components.stackable.stacksize
            else
                giveitem = entcontainer:RemoveItemBySlot(i)
                if data.onlyneed and data.onlyneed > 0 then data.onlyneed = data.onlyneed - 1 end
            end
            if giveitem.components and giveitem.components.stackable and giveitem.components.stackable.stacksize < giveitem.components.stackable.maxsize then
                data.itemlackstackables[giveitem.prefab] = (data.itemlackstackables[giveitem.prefab] or 0) + giveitem.components.stackable.maxsize -
                                                               giveitem.components.stackable.stacksize
            end
            container:GiveItem(giveitem, nil, onlyone and entcontainer.inst:GetPosition())
            if entcontainer.inst.Transform and not entcontainer.inst.components.inventoryitem then
                SpawnPrefab("sand_puff").Transform:SetPosition(entcontainer.inst.Transform:GetWorldPosition())
            end
            if onlyone then if not data.onlyneed or data.onlyneed <= 0 then return true end end
        elseif IsTableEmpty(data.itemlackstackables) then
            -- 全部堆满,结束收纳
            return true
        end
    end
end

local function collectcontainers(inst, player)
    if not (inst and inst.components and inst.components.container and inst.components.container.numslots > 0 and #inst.components.container.slots > 0) then
        return
    end
    local data = {}
    data.itemlackstackables = {}
    data.prefabs = {}
    local hasnumslots = 0
    for i = 1, inst.components.container.numslots do
        local item = inst.components.container.slots[i]
        if item ~= nil and item:IsValid() then
            hasnumslots = hasnumslots + 1
            table.insert(data.prefabs, item.prefab)
            if item.components and item.components.stackable and item.components.stackable.stacksize < item.components.stackable.maxsize then
                data.itemlackstackables[item.prefab] = (data.itemlackstackables[item.prefab] or 0) + item.components.stackable.maxsize -
                                                           item.components.stackable.stacksize
            end
        end
    end
    data.extranumslots = inst.components.container.numslots - hasnumslots
    if #data.prefabs == 0 or (data.extranumslots == 0 and IsTableEmpty(data.itemlackstackables)) then return end
    -- 识别要收纳的容器,不会收纳自己和自己的父容器
    local ents = {}
    if inst.components.inventoryitem and inst.components.inventoryitem.owner then
        local owner = getfinalowner(inst)
        table.insert(ents, owner)
        local container = owner.components.inventory or owner.components.container
        for k, v in pairs(container.itemslots or container.slots) do
            if v:IsValid() and not v:HasTag("dcs2hm") and not v.dcs2hm and v ~= inst and v.components.container and v.components.container.canbeopened then
                table.insert(ents, v)
                findcontainerincontainers(v, ents)
            end
        end
        if owner.components.inventory then
            for k, v in pairs(EQUIPSLOTS) do
                local equip = owner.components.inventory:GetEquippedItem(v)
                if equip ~= nil and equip.components.container ~= nil then
                    table.insert(ents, equip)
                    findcontainerincontainers(equip, ents)
                end
            end
        end
        for i = #ents, 1, -1 do
            if ents[i] == inst then
                table.remove(ents, i)
                break
            end
        end
    else
        findcontainerincontainers(inst, ents)
        local x, y, z = inst.Transform:GetWorldPosition()
        local platform = inst:GetCurrentPlatform()
        local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
        for i, v in ipairs(nearents) do
            if v ~= inst and not v.dcs2hm and v.components and v.components.container and v.components.container.canbeopened and not v.components.inventoryitem and
                v:GetCurrentPlatform() == platform then
                table.insert(ents, v)
                findcontainerincontainers(v, ents)
            end
        end
    end
    if #ents <= 0 then return end
    local tmpents = {}
    if inst.virtchest and inst.virtchest:IsValid() and inst.virtchest.components.container then table.insert(tmpents, inst.virtchest) end
    for i, v in ipairs(ents) do
        table.insert(tmpents, v)
        if v.virtchest and v.virtchest:IsValid() and v.virtchest.components.container then table.insert(tmpents, v.virtchest) end
    end
    -- 收纳
    for _, ent in ipairs(tmpents) do
        if ent ~= inst and ent.components.container then
            for i = 1, ent.components.container.numslots do
                local item = ent.components.container.slots[i]
                if item and item:IsValid() and collectcontaineritem(inst, inst.components.container, item, ent.components.container, i, data) then
                    return
                end
            end
        elseif ent ~= inst and ent.components.inventory then
            for i = 1, ent.components.inventory.maxslots do
                local item = ent.components.inventory.itemslots[i]
                if item and item:IsValid() and collectcontaineritem(inst, inst.components.container, item, ent.components.inventory, i, data) then
                    return
                end
            end
        end
    end
end

local function collectcontainerready(player, inst)
    -- 混合拾取和收纳时,拾取后短暂时间内不会进行收纳
    if inst and inst.components.container ~= nil and not inst.pickuptask2hm then collectcontainers(inst, player) end
end

AddModRPCHandler("MOD_HARDMODE", "collectbtn2hm", collectcontainerready)

local function collectfn(inst, doer)
    if inst.components.container ~= nil then
        collectcontainerready(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "collectbtn2hm"), inst)
    end
end

local function collectvalidfn(inst) return inst.components.container ~= nil or inst.replica.container ~= nil end

-- 地面范围拾取
local PICKUP_MUST_ONEOF_TAGS = {"_inventoryitem", "pickable"}
local PICKUP_CANT_TAGS = {
    -- Items
    "INLIMBO",
    "NOCLICK",
    "knockbackdelayinteraction",
    "event_trigger",
    "minesprung",
    "mineactive",
    "catchable",
    "fire",
    "light",
    -- "spider",
    "cursed",
    "paired",
    "bundle",
    "heatrock",
    "deploykititem",
    "boatbuilder",
    "singingshell",
    "archive_lockbox",
    "simplebook",
    "furnituredecor",
    -- Pickables
    "flower",
    "gemsocket",
    "structure",
    -- Either
    "donotautopick"
}
local function pickupgrounditem(inst, container, item, data)
    if item ~= nil and table.contains(data.prefabs, item.prefab) and item ~= inst then
        if item.components and item.components.stackable and data.itemlackstackables[item.prefab] then
            -- 是所需堆叠,处理需求与供给数目关系
            if data.itemlackstackables[item.prefab] >= item.components.stackable.stacksize then
                -- 需求比供给多,直接给
                if item.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(item.Transform:GetWorldPosition()) end
                data.finiteuses = data.finiteuses - item.components.stackable.stacksize / 4
                data.itemlackstackables[item.prefab] = data.itemlackstackables[item.prefab] - item.components.stackable.stacksize
                if data.itemlackstackables[item.prefab] == 0 and data.extranumslots == 0 then data.itemlackstackables[item.prefab] = nil end
                container:GiveItem(item)
            elseif data.extranumslots > 0 then
                -- 需求比供给少,但有空间,直接给
                if item.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(item.Transform:GetWorldPosition()) end
                data.finiteuses = data.finiteuses - item.components.stackable.stacksize / 4
                data.extranumslots = data.extranumslots - 1
                data.itemlackstackables[item.prefab] = data.itemlackstackables[item.prefab] + item.components.stackable.maxsize -
                                                           item.components.stackable.stacksize
                if data.itemlackstackables[item.prefab] == 0 and data.extranumslots == 0 then data.itemlackstackables[item.prefab] = nil end
                container:GiveItem(item)
            elseif data.itemlackstackables[item.prefab] > 0 then
                -- 需求比供给少且没有新空间
                if item.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(item.Transform:GetWorldPosition()) end
                local giveitem = item.components.stackable:Get(data.itemlackstackables[item.prefab])
                data.finiteuses = data.finiteuses - giveitem.components.stackable.stacksize / 4
                data.itemlackstackables[giveitem.prefab] = nil
                container:GiveItem(giveitem)
            end
        elseif data.extranumslots > 0 then
            if item.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(item.Transform:GetWorldPosition()) end
            data.extranumslots = data.extranumslots - 1
            if item.components and item.components.stackable and item.components.stackable.stacksize < item.components.stackable.maxsize then
                data.itemlackstackables[item.prefab] = (data.itemlackstackables[item.prefab] or 0) + item.components.stackable.maxsize -
                                                           item.components.stackable.stacksize
                data.finiteuses = data.finiteuses - item.components.stackable.stacksize / 4
            else
                data.finiteuses = data.finiteuses - 1
            end
            container:GiveItem(item)
        elseif IsTableEmpty(data.itemlackstackables) then
            -- 全部堆满,结束收纳
            return true
        end
    end
    if data.finiteuses <= 0 then return true end
end
local function containerpickup(inst, player)
    if not (player and player:HasTag("player") and not player:HasTag("playerghost") and player.components.inventory) then return end
    local hasorangeamulet = false
    local data = {}
    for k, v in pairs(player.components.inventory.equipslots) do
        if v and v.prefab == "orangeamulet" and v:IsValid() and
            ((v.components.finiteuses and v.components.finiteuses.current > 1) or (v.components.fueled and v.components.fueled.currentfuel > 0)) then
            data.orangeamulet = v
            data.beforefiniteuses = v.components.finiteuses and v.components.finiteuses.current - 1 or (v.components.fueled and v.components.fueled.currentfuel)
            data.finiteuses = data.beforefiniteuses
            hasorangeamulet = true
            break
        end
    end
    local activeitem = player.components.inventory.activeitem
    if activeitem and activeitem.prefab == "orangeamulet" and activeitem:IsValid() and
        ((activeitem.components.finiteuses and activeitem.components.finiteuses.current > 1) or
            (activeitem.components.fueled and activeitem.components.fueled.currentfuel > 0)) then
        data.orangeamulet = activeitem
        data.beforefiniteuses = activeitem.components.finiteuses and activeitem.components.finiteuses.current - 1 or
                                    (activeitem.components.fueled and activeitem.components.fueled.currentfuel)
        data.finiteuses = data.beforefiniteuses
        hasorangeamulet = true
    end
    if hasorangeamulet and not inst.pickuptask2hm then inst.pickuptask2hm = inst:DoTaskInTime(0.25, function() inst.pickuptask2hm = nil end) end
    if not (hasorangeamulet and inst:IsValid() and inst.components and
        ((inst.components.container and inst.components.container.numslots > 0 and #inst.components.container.slots > 0) or
            (inst.components.inventory and inst.components.inventory.maxslots > 0 and #inst.components.inventory.itemslots > 0))) then return end
    data.itemlackstackables = {}
    data.prefabs = {}
    data.onlytheseprefabs = {}
    local hasnumslots = 0
    for i = 1, inst.components.inventory and inst.components.inventory.maxslots or inst.components.container.numslots do
        local item = inst.components.inventory and inst.components.inventory.itemslots[i] or (inst.components.container and inst.components.container.slots[i])
        if item ~= nil and item:IsValid() then
            hasnumslots = hasnumslots + 1
            table.insert(data.prefabs, item.prefab)
            data.onlytheseprefabs[item.prefab] = true
            if item.components and item.components.stackable and item.components.stackable.stacksize < item.components.stackable.maxsize then
                data.itemlackstackables[item.prefab] = (data.itemlackstackables[item.prefab] or 0) + item.components.stackable.maxsize -
                                                           item.components.stackable.stacksize
            end
        end
    end
    data.extranumslots = (inst.components.inventory and inst.components.inventory.maxslots or inst.components.container.numslots) - hasnumslots
    if #data.prefabs == 0 or (data.extranumslots == 0 and IsTableEmpty(data.itemlackstackables)) then return end
    if data.orangeamulet and data.orangeamulet.skin_equip_sound and player.SoundEmitter then
        player.SoundEmitter:PlaySound(data.orangeamulet.skin_equip_sound)
    end
    local x, y, z = player.Transform:GetWorldPosition()
    local nearents = TheSim:FindEntities(x, y, z, 30, nil, PICKUP_CANT_TAGS, PICKUP_MUST_ONEOF_TAGS)
    -- local ents = {}
    local istart, iend, idiff = 1, #nearents, 1
    -- -- 优先收集最远的
    -- local furthestfirst = true
    -- if furthestfirst then istart, iend, idiff = iend, istart, -1 end
    for i = istart, iend, idiff do
        local v = nearents[i]
        if v:IsValid() and data.onlytheseprefabs[v.prefab] and v.components.inventoryitem and not v.components.inventoryitem.owner and
            v.components.inventoryitem.canbepickedup and (inst.components.inventory or v.components.inventoryitem.cangoincontainer) and
            not ((v:HasTag("fire") and not v:HasTag("lighter")) or v:HasTag("smolder")) and not v:HasTag("heavy") and
            not (v.components.container ~= nil and v.components.equippable == nil) and
            not (v:IsInLimbo() or (v.components.burnable ~= nil and v.components.burnable:IsBurning() and v.components.lighter == nil) or
                (v.components.projectile ~= nil and v.components.projectile:IsThrown())) and
            not (inst.components.itemtyperestrictions ~= nil and not inst.components.itemtyperestrictions:IsAllowed(v)) and
            not (v.components.container ~= nil and v.components.container:IsOpen()) and
            not (v.components.yotc_racecompetitor ~= nil and v.components.entitytracker ~= nil) and
            (not v:HasTag("spider") or (player:HasTag("spiderwhisperer"))) and
            not ((v:HasTag("spider") and player:HasTag("spiderwhisperer")) and (v.components.follower.leader ~= nil and v.components.follower.leader ~= player)) and
            not (v.components.curseditem and not v.components.curseditem:checkplayersinventoryforspace(player)) and
            not (v.components.inventory ~= nil and v:HasTag("drop_inventory_onpickup")) then
            if pickupgrounditem(inst, inst.components.inventory or inst.components.container, v, data) then return end
        end
    end
    data.finiteuses = math.max(data.finiteuses, 0)
    if data.orangeamulet and data.orangeamulet:IsValid() then
        if data.orangeamulet.components.finiteuses then
            data.orangeamulet.components.finiteuses:Use(data.beforefiniteuses - data.finiteuses)
        elseif data.orangeamulet.components.fueled then
            data.orangeamulet.components.fueled:DoDelta(data.finiteuses - data.beforefiniteuses, player)
        end
    end
end

local function containerpickupready(player, inst)
    if inst and inst.components.container ~= nil then containerpickup(inst, player) end
    if inst.components.equippable and inst.components.equippable:IsEquipped() and player and player.components and player.components.inventory then
        containerpickup(player, player)
    end
end

AddModRPCHandler("MOD_HARDMODE", "pickupbtn2hm", containerpickupready)

local function pickupfn(inst, doer)
    if inst.components.container ~= nil then
        containerpickupready(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "pickupbtn2hm"), inst)
    end
end

local function pickupvalidfn(inst) return inst.components.container ~= nil or inst.replica.container ~= nil end

-- 混合功能,背包双击排序,收拾按钮同时收纳和整理
local function ondoubleclickend(inst, doer)
    inst.doubleclicktask2hm = nil
    if inst.doubleclicktrue2hm then sortcontainerbuttonmultiinfofn(inst, doer) end
    inst.doubleclicktrue2hm = nil
end
local function newsortcontainerbuttoninfofn(inst, doer)
    if (inst.components.equippable and inst.components.equippable:IsEquipped()) or (inst.replica.equippable and inst.replica.equippable:IsEquipped()) then
        if not inst.doubleclicktask2hm then
            inst.doubleclicktask2hm = inst:DoTaskInTime(0.25, ondoubleclickend, doer)
            sortcontainerbuttoninfofn(inst, doer)
        else
            inst.doubleclicktrue2hm = not inst.doubleclicktrue2hm
            inst.doubleclicktask2hm:Cancel()
            inst.doubleclicktask2hm = inst:DoTaskInTime(0.25, ondoubleclickend, doer)
        end
    else
        sortcontainerbuttoninfofn(inst, doer)
    end
end

local function specialCollect(inst, doer)
    pickupfn(inst, doer)
    collectfn(inst, doer)
end

-- 锁定/解锁容器
if haslockbutton then
    AddComponentPostInit("container", function(self)
        local oldOnSave = self.OnSave
        self.OnSave = function(self, ...)
            local data, references, more = oldOnSave(self, ...)
            data.itemtestfnprefabs2hm = self.itemtestfnprefabs2hm
            return data, references, more
        end
        local oldOnLoad = self.OnLoad
        self.OnLoad = function(self, data, ...)
            oldOnLoad(self, data, ...)
            self.itemtestfnprefabs2hm = data.itemtestfnprefabs2hm
            if self.itemtestfnprefabs2hm then self.inst:AddTag("lockcontainer2hm") end
        end
        local oldCanTakeItemInSlot = self.CanTakeItemInSlot
        self.CanTakeItemInSlot = function(self, item, slot, ...)
            return oldCanTakeItemInSlot(self, item, slot, ...) and (self.itemtestfnprefabs2hm == nil or table.contains(self.itemtestfnprefabs2hm, item.prefab))
        end
    end)
end
local function lockcontainer(inst, doer, typelock)
    if not (haslockbutton and inst and inst.components and inst.components.container and not inst.components.container.usespecificslotsforitems) then return end
    local self = inst.components.container
    -- 解锁
    -- if not typelock and self.itemtestfnargs2hm then
    if self.itemtestfnprefabs2hm then
        self.itemtestfnprefabs2hm = nil
        inst:RemoveTag("lockcontainer2hm")
        return
    end
    -- 上锁
    -- if not typelock then
    self.itemtestfnprefabs2hm = {}
    for i = 1, self.numslots do
        local item = self.slots[i]
        if item ~= nil and item:IsValid() then table.insert(self.itemtestfnprefabs2hm, item.prefab) end
    end
    inst:AddTag("lockcontainer2hm")
end

local function lockready(player, inst) if inst and inst.components.container ~= nil then lockcontainer(inst, player) end end

AddModRPCHandler("MOD_HARDMODE", "lockbtn2hm", lockready)

local function lockfn(inst, doer, btn)
    if not haslockbutton then return end
    btn:SetText(inst:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "锁定" or "Lock") or (TUNING.isCh2hm and "解锁" or "Unlock"))
    if inst.components.container ~= nil then
        lockready(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "lockbtn2hm"), inst)
    end
end

local function lockvalidfn(inst) return inst.components.container ~= nil or inst.replica.container ~= nil end

-- 容器按钮插入
if containercfg then
    local function addbuttoninfoforcontainerparams(prefab, container)
        if container and container.inst and not container.inst:HasTag("dcs2hm") and not container.inst.dcs2hm and
            not table.contains(btnblacklist, container.inst.prefab) and not container.usespecificslotsforitems and container.acceptsstacks ~= false and
            container.widget and not container.widget.sortbtninfo2hm and container.widget.slotpos and
            (#container.widget.slotpos > 5 or (#container.widget.slotpos >= 4 and (prefab == "puffvest" or prefab == "puffvest_big"))) then
            -- x相同说明在一条竖线上，y相同说明在一条横线上
            local finalslot = #container.widget.slotpos
            local firstlinelength = 1
            local starty = container.widget.slotpos[1].y
            for i = 2, finalslot do
                if container.widget.slotpos[i].y ~= starty then break end
                firstlinelength = firstlinelength + 1
            end
            local slotpos_1 = container.widget.slotpos[finalslot]
            local endlinelength = 1
            local endy = slotpos_1.y
            for i = finalslot - 1, 1, -1 do
                if container.widget.slotpos[i].y ~= endy then break end
                endlinelength = endlinelength + 1
            end
            -- 一般不可能出现
            if container.widget.buttoninfo and endlinelength < 3 then return end
            -- 模组容器,首行末尾行长度不等,怀疑是尾部设置了特殊格子,重新寻找尾部位置
            if firstlinelength ~= endlinelength then
                if firstlinelength < 2 then return end
                local realfinalslot = firstlinelength
                local finaly = starty
                local finalx = container.widget.slotpos[firstlinelength].x
                for i = firstlinelength * 2, finalslot - 1, firstlinelength do
                    local slotpos = container.widget.slotpos[i]
                    if slotpos.y < finaly and slotpos.x == finalx then
                        realfinalslot = i
                        finaly = slotpos.y
                    else
                        break
                    end
                end
                finalslot = realfinalslot
                slotpos_1 = container.widget.slotpos[finalslot]
                endlinelength = 1
                endy = slotpos_1.y
                for i = finalslot - 1, 1, -1 do
                    if container.widget.slotpos[i].y ~= endy then break end
                    endlinelength = endlinelength + 1
                end
                if endlinelength ~= firstlinelength then return end
            end
            local slotpos_2 = container.widget.slotpos[finalslot - 1]
            local slotpos_3 = container.widget.slotpos[finalslot - 2]
            local position1, position2, position3
            if slotpos_2.x ~= slotpos_1.x and (container.widget.buttoninfo == nil or endlinelength >= 5) then
                position1 = Vector3(slotpos_1.x, slotpos_1.y - 57, slotpos_1.z)
                position2 = Vector3(slotpos_2.x, slotpos_2.y - 57, slotpos_2.z)
                if slotpos_3.x ~= slotpos_1.x and (container.widget.buttoninfo == nil or endlinelength >= 7) then
                    position3 = Vector3(slotpos_3.x, slotpos_3.y - 57, slotpos_3.z)
                else
                    position3 = Vector3(slotpos_1.x, slotpos_1.y - 100, slotpos_1.z)
                end
            else
                position1 = Vector3(slotpos_1.x, slotpos_1.y - 57, slotpos_1.z)
                position2 = Vector3(slotpos_1.x, slotpos_1.y - 100, slotpos_1.z)
                position3 = Vector3(slotpos_1.x, slotpos_1.y - 143, slotpos_1.z)
            end
            container.widget.sortbtninfo2hm = {
                text = TUNING.isCh2hm and "整理" or "Sort",
                helptext = TUNING.isCh2hm and [[排序该容器内道具
背包双击会混合排序物品栏和背包内道具]] or [[Sort Your Items
Backpack Double Click Will Pass Through Inventory]],
                position = position1,
                fn = newsortcontainerbuttoninfofn,
                validfn = sortcontainerbuttoninfovalidfn
            }
            if haslockbutton then
                container.widget.lockbtninfo2hm = {
                    text = TUNING.isCh2hm and "锁定" or "Lock",
                    helptext = TUNING.isCh2hm and [[锁定该容器只能放置当前已有的道具]] or [[Lock the container to limit store current items]],
                    position = position2,
                    fn = lockfn,
                    validfn = lockvalidfn
                }
            elseif hasmultisort then
                container.widget.multisortbtninfo2hm = {
                    text = TUNING.isCh2hm and "跨整" or "MSort",
                    helptext = TUNING.isCh2hm and [[背包会混合排序物品栏和背包内道具
    携带容器混合排序所在容器内的所有同类容器内道具
    地面容器会混合排序周围同名容器内道具,不会跨船]] or "Sort Your Items Pass Through Containers",
                    position = position2,
                    fn = sortcontainerbuttonmultiinfofn,
                    validfn = sortcontainerbuttoninfovalidfn
                }
            end
            container.widget.collectbtninfo2hm = {
                text = TUNING.isCh2hm and "收集" or "Collect",
                helptext = TUNING.isCh2hm and [[携带容器收集携带的容器内同名道具
地面容器收集周围容器内的同名道具,不会跨船
佩戴或手持懒人护符,则拾取周围地上同名道具]] or [[Collect Same Items From Containers
Use Orange Amulet will Pickup Near Same Items]],
                position = (hasmultisort or haslockbutton) and position3 or position2,
                fn = specialCollect,
                validfn = collectvalidfn
            }
            container.widget.exchangebtninfo2hm = {
                text = TUNING.isCh2hm and "穿越" or "PassW",
                helptext = TUNING.isCh2hm and [[与随机其他世界的该容器交换道具]],
                position = haslockbutton and position3 or position2,
                fn = sendscontainerproxyotherworldfn,
                validfn = sendscontainerproxyotherworldvalidfn
            }
            if prefab == "wardrobe" then
                local slotpos_2 = container.widget.slotpos[finalslot - 3]
                local position4 = Vector3(slotpos_2.x, slotpos_2.y - 57, slotpos_2.z)
                container.widget.reskinbtninfo2hm = {
                    text = TUNING.isCh2hm and "换装" or "Skin",
                    position = (haslockbutton or hasmultisort) and position4 or (hascollectbutton and position3 or position2),
                    fn = reskinfn,
                    validfn = reskinvalidfn
                }
            end
        end
    end
    if containers and containers.params then for name, data in pairs(containers.params) do addbuttoninfoforcontainerparams(name, data) end end
    local old_wsetup = containers.widgetsetup
    function containers.widgetsetup(container, prefab, data, ...)
        local result = old_wsetup(container, prefab, data, ...)
        addbuttoninfoforcontainerparams(prefab, container)
        return result
    end
    if TUNING.CHESTUPGRADE then
        AddComponentPostInit("chestupgrade", function(self)
            local UpdateWidget = self.UpdateWidget
            self.UpdateWidget = function(self, ...)
                UpdateWidget(self, ...)
                if self.inst.components.container then addbuttoninfoforcontainerparams(self.inst.prefab, self.inst.components.container) end
            end
        end)
        AddClassPostConstruct("components/chestupgrade_replica", function(self)
            local UpdateWidget = self.UpdateWidget
            self.UpdateWidget = function(self, ...)
                UpdateWidget(self, ...)
                if self.inst.replica.container then addbuttoninfoforcontainerparams(self.inst.prefab, self.inst.replica.container) end
            end
        end)
    end

    local ImageButton = require "widgets/imagebutton"
    local function addbutton(self, container, doer, btnname, btninfo, position)
        local btn = self:AddChild(ImageButton("images/ui.xml", "button_small.tex", "button_small_over.tex", "button_small_disabled.tex", nil, nil, {1, 1},
                                              {0, 0}))
        btn.image:SetScale(0.77, 1.07, 1.07)
        btn.text:SetPosition(2, -2)
        btn:SetPosition(position or btninfo.position)
        btn:SetText(btninfo.text)
        if btninfo.helptext then btn:SetTooltip(btninfo.helptext) end
        if btninfo.fn ~= nil then btn:SetOnClick(function() btninfo.fn(container, doer, btn) end) end
        btn:SetFont(BUTTONFONT)
        btn:SetDisabledFont(BUTTONFONT)
        btn:SetTextSize(33)
        btn.text:SetVAlign(ANCHOR_MIDDLE)
        btn.text:SetColour(0, 0, 0, 1)
        self[btnname] = btn
    end

    AddClassPostConstruct("widgets/inventorybar", function(self)
        local oldRebuild = self.Rebuild
        self.Rebuild = function(self, ...)
            oldRebuild(self, ...)
            local inventory = self.owner.replica.inventory
            local overflow = inventory:GetOverflowContainer()
            overflow = (overflow ~= nil and overflow:IsOpenedBy(self.owner)) and overflow or nil
            local do_integrated_backpack = overflow ~= nil and self.integrated_backpack
            if do_integrated_backpack and self.bottomrow and overflow and overflow.inst then
                local widget = overflow:GetWidget()
                local num = overflow:GetNumSlots()
                if self.backpackinv and self.backpackinv[num] and not widget.buttoninfo and widget.sortbtninfo2hm and widget.collectbtninfo2hm then
                    local pos = self.backpackinv[num]:GetPosition()
                    if hascollectbutton then
                        addbutton(self.bottomrow, overflow.inst, self.owner, "collectbutton2hm", widget.collectbtninfo2hm,
                                  ((haslockbutton and widget.lockbtninfo2hm) or (hasmultisort and widget.multisortbtninfo2hm)) and
                                      Vector3(pos.x + 238, pos.y, pos.z) or Vector3(pos.x + 168, pos.y, pos.z))
                    end
                    addbutton(self.bottomrow, overflow.inst, self.owner, "sortbutton2hm", widget.sortbtninfo2hm, Vector3(pos.x + 98, pos.y, pos.z))
                    -- todo
                    if haslockbutton and widget.lockbtninfo2hm then
                        widget.lockbtninfo2hm.text = overflow.inst:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "解锁" or "Unlock") or
                                                         (TUNING.isCh2hm and "锁定" or "Lock")
                        addbutton(self.bottomrow, overflow.inst, self.owner, "lockbutton2hm", widget.lockbtninfo2hm, Vector3(pos.x + 168, pos.y, pos.z))
                    end
                    if hasmultisort and widget.multisortbtninfo2hm then
                        addbutton(self.bottomrow, overflow.inst, self.owner, "multisortbutton2hm", widget.multisortbtninfo2hm,
                                  Vector3(pos.x + 168, pos.y, pos.z))
                    end
                end
            end
        end
    end)

    AddClassPostConstruct("widgets/containerwidget", function(self)
        local oldOpen = self.Open
        self.Open = function(self, container, doer, ...)
            local result = oldOpen(self, container, doer, ...)
            local widget = container.replica.container:GetWidget()
            if container and not container:HasTag("dcs2hm") and not container.dcs2hm and widget.sortbtninfo2hm and widget.collectbtninfo2hm then
                -- 整理
                addbutton(self, container, doer, "sortbutton2hm", widget.sortbtninfo2hm)
                if container.prefab == "wardrobe" and widget.reskinbtninfo2hm and container:HasTag("wardrobecontainer2hm") then
                    -- 换装
                    addbutton(self, container, doer, "reskinbutton2hm", widget.reskinbtninfo2hm)
                end
                if haslockbutton and widget.lockbtninfo2hm then
                    widget.lockbtninfo2hm.text = container:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "解锁" or "Unlock") or
                                                     (TUNING.isCh2hm and "锁定" or "Lock")
                    addbutton(self, container, doer, "lockbutton2hm", widget.lockbtninfo2hm)
                end
                if container:HasTag("pocketdimension_container") and widget.exchangebtninfo2hm then
                    -- 穿越
                    if not TUNING.DSA_ONE_PLAYER_MODE then addbutton(self, container, doer, "exchangebutton2hm", widget.exchangebtninfo2hm) end
                else
                    -- 跨整和收集
                    if hasmultisort and widget.multisortbtninfo2hm then
                        addbutton(self, container, doer, "multisortbutton2hm", widget.multisortbtninfo2hm)
                    end
                    if hascollectbutton then addbutton(self, container, doer, "collectbutton2hm", widget.collectbtninfo2hm) end
                end
            end
            return result
        end
        local oldClose = self.Close
        self.Close = function(self, ...)
            if self.isopen then
                if self.reskinbutton2hm ~= nil then
                    self.reskinbutton2hm:Kill()
                    self.reskinbutton2hm = nil
                end
                if self.exchangebutton2hm ~= nil then
                    self.exchangebutton2hm:Kill()
                    self.exchangebutton2hm = nil
                end
                if self.lockbutton2hm ~= nil then
                    self.lockbutton2hm:Kill()
                    self.lockbutton2hm = nil
                end
                if self.sortbutton2hm ~= nil then
                    self.sortbutton2hm:Kill()
                    self.sortbutton2hm = nil
                end
                if self.multisortbutton2hm ~= nil then
                    self.multisortbutton2hm:Kill()
                    self.multisortbutton2hm = nil
                end
                if self.collectbutton2hm ~= nil then
                    self.collectbutton2hm:Kill()
                    self.collectbutton2hm = nil
                end
            end
            return oldClose(self, ...)
        end
    end)

    -- 妥协衣柜处理
    local function onopenwardrobe(inst) if inst.components.wardrobe then inst.components.wardrobe:SetCanUseAction(true) end end
    local function onclosewardrobe(inst) if inst.components.wardrobe then inst.components.wardrobe:SetCanUseAction(false) end end
    AddPrefabPostInit("wardrobe", function(inst)
        if not TheWorld.ismastersim then return end
        if inst.components.container and inst.components.wardrobe then
            inst:AddTag("wardrobecontainer2hm")
            inst.components.wardrobe:SetCanUseAction(false)
            if inst.components.channelable then inst.components.channelable:SetEnabled(false) end
            local oldonopen = inst.components.container.onopenfn
            inst.components.container.onopenfn = function(inst, ...)
                if oldonopen then oldonopen(inst, ...) end
                onopenwardrobe(inst)
            end
            local oldonclose = inst.components.container.onclosefn
            inst.components.container.onclosefn = function(inst, ...)
                if oldonclose then oldonclose(inst, ...) end
                onclosewardrobe(inst)
            end
        end
    end)
end

if itemscfg then
    if hasitemscollect then
        -- 指定配方收集
        local function collectrecipetype(inst, recipe_type, neednum)
            if not recipe_type or recipe_type == "" then return end
            if not (inst and inst.components and inst.components.inventory and inst.components.inventory.maxslots > 0) then return end
            local data = {}
            data.itemlackstackables = {}
            data.itemlackstackables[recipe_type] = 0
            data.prefabs = {recipe_type}
            local hasnumslots = 0
            for i = 1, inst.components.inventory.maxslots do
                local item = inst.components.inventory.itemslots[i]
                if item ~= nil and item:IsValid() then
                    hasnumslots = hasnumslots + 1
                    if item.prefab == recipe_type and item.components and item.components.stackable and item.components.stackable.stacksize <
                        item.components.stackable.maxsize then
                        data.itemlackstackables[item.prefab] = (data.itemlackstackables[item.prefab] or 0) + item.components.stackable.maxsize -
                                                                   item.components.stackable.stacksize
                    end
                end
            end
            local item = inst.components.inventory.activeitem
            if item ~= nil then
                hasnumslots = hasnumslots + 1
                if item.prefab == recipe_type and item.components and item.components.stackable and item.components.stackable.stacksize <
                    item.components.stackable.maxsize then
                    data.itemlackstackables[item.prefab] = (data.itemlackstackables[item.prefab] or 0) + item.components.stackable.maxsize -
                                                               item.components.stackable.stacksize
                end
            end
            data.extranumslots = inst.components.inventory.maxslots - hasnumslots + 1
            if data.extranumslots == 0 and data.itemlackstackables[recipe_type] == 0 then
                if inst and inst.components.talker then
                    inst.components.talker:Say((TUNING.isCh2hm and ("物品栏和手持已经满了") or ("Inventory and hand is full.")))
                end
                return
            end
            if data.itemlackstackables[recipe_type] == 0 then data.itemlackstackables[recipe_type] = nil end
            data.onlyneed = neednum
            -- 识别要收纳的容器
            local ents = {}
            local x, y, z = inst.Transform:GetWorldPosition()
            local platform = inst:GetCurrentPlatform()
            local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
            for i, v in ipairs(nearents) do
                if v ~= inst and not v.dcs2hm and v.components and v.components.container and v.components.container.canbeopened and
                    not v.components.inventoryitem and not inst.components.inventory.opencontainers[v] and v:GetCurrentPlatform() == platform and
                    not table.contains(collectblacklist, v.prefab) then
                    table.insert(ents, v)
                    findcontainerincontainers(v, ents)
                end
            end
            if inst.components.rider and inst.components.rider.mount and inst.components.rider.mount:IsValid() and
                inst.components.rider.mount.components.container then table.insert(ents, inst.components.rider.mount) end
            if #ents <= 0 then return end
            -- 收纳
            local tmpents = {}
            for i, v in ipairs(ents) do
                table.insert(tmpents, v)
                if v.virtchest and v.virtchest:IsValid() and v.virtchest.components.container then table.insert(tmpents, v.virtchest) end
            end
            for _, ent in ipairs(tmpents) do
                if ent ~= inst and ent.components.container then
                    for i = ent.components.container.numslots, 1, -1 do
                        local item = ent.components.container.slots[i]
                        if item and item:IsValid() and collectcontaineritem(inst, inst.components.inventory, item, ent.components.container, i, data, true) then
                            return
                        end
                    end
                elseif ent ~= inst and ent.components.inventory then
                    for i = ent.components.inventory.maxslots, 1, -1 do
                        local item = ent.components.inventory.itemslots[i]
                        if item and item:IsValid() and collectcontaineritem(inst, inst.components.inventory, item, ent.components.inventory, i, data, true) then
                            return
                        end
                    end
                end
            end
        end

        local function collectrecipetypeready(inst, recipe_type, neednum)
            if not recipe_type or recipe_type == "" then return end
            if inst and inst.components.inventory ~= nil then collectrecipetype(inst, recipe_type, neednum) end
        end

        AddModRPCHandler("MOD_HARDMODE", "collectrecipetypebtn2hm", collectrecipetypeready)

        local function collectrecipetypefn(doer, recipe_type, neednum)
            if not recipe_type or recipe_type == "" or type(recipe_type) ~= "string" then return end
            if doer.components.inventory ~= nil and not doer:HasTag("playerghost") and doer.components.inventory.isvisible then
                collectrecipetypeready(doer or ThePlayer, recipe_type, neednum)
            elseif doer.replica.inventory ~= nil and not doer:HasTag("playerghost") then
                SendModRPCToServer(GetModRPC("MOD_HARDMODE", "collectrecipetypebtn2hm"), recipe_type, neednum)
            end
        end

        local function SetImageButtonRightControl(self)
            if self.SetImageButtonRightControl2hm then return end
            self.SetImageButtonRightControl2hm = true
            local oldOnControl = self.OnControl
            self.OnControl = function(self, control, down, ...)
                local result = oldOnControl(self, control, down, ...)
                if not self:IsEnabled() or not self.focus then return result end
                if self:IsSelected() and not self.AllowOnControlWhenSelected then return result end
                if control == CONTROL_SECONDARY then
                    if down then
                        if not self.down2hm and not self.down then
                            if self.has_image_down then
                                self.image:SetTexture(self.atlas, self.image_down)
                                if self.size_x and self.size_y then self.image:ScaleToSize(self.size_x, self.size_y) end
                            end
                            TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
                            self.o_pos = self:GetLocalPosition()
                            if self.move_on_click then self:SetPosition(self.o_pos + self.clickoffset) end
                            self.down2hm = true
                        end
                    else
                        if self.down2hm then
                            if self.has_image_down then
                                self.image:SetTexture(self.atlas, self.image_focus)
                                if self.size_x and self.size_y then self.image:ScaleToSize(self.size_x, self.size_y) end
                            end
                            self.down2hm = false
                            self:ResetPreClickPosition()
                            if self.onrightclick2hm then self.onrightclick2hm() end
                        end
                    end
                end
                return result
            end
        end
        -- local function collect_recipe_type(recipe_type) if ThePlayer and recipe_type and recipe_type ~= "" then collectrecipetypefn(ThePlayer, recipe_type) end end
        -- 收集指定素材，且至多收集一组
        local CraftingMenuIngredients = require "widgets/redux/craftingmenu_ingredients"
        local Widget = require "widgets/widget"
        local ThreeSlice = require "widgets/threeslice"
        AddClassPostConstruct("widgets/ingredientui",
                              function(self, atlas, image, num_need, num_found, has_enough, name, owner, recipe_type, quant_text_scale, ingredient_recipe, ...)
            if self.recipe_type and num_need and num_found and not IsCharacterIngredient(self.recipe_type) then
                self.onrightclick2hm = function()
                    collectrecipetypefn(self.owner or ThePlayer, self.recipe_type,
                                        not has_enough and ((num_need * (self.parent and self.parent.parent and self.parent.parent.quantity or 1) - num_found)))
                end
                SetImageButtonRightControl(self)
                local meta = ingredient_recipe ~= nil and ingredient_recipe.meta or nil
                if (meta and not has_enough and meta.can_build) or self.onclick then
                    self:SetTooltip((self.tooltip or "") .. "\n" .. TheInput:GetLocalizedControl(TheInput:GetControllerID(), CONTROL_SECONDARY) .. ": " ..
                                        (has_enough and (TUNING.isCh2hm and "收集更多" or "Collect More") or (TUNING.isCh2hm and "收集" or "Collect")))
                else
                    self:SetTooltip((self.tooltip or "") .. "\n" .. TheInput:GetLocalizedControl(TheInput:GetControllerID(), CONTROL_SECONDARY) .. ": " ..
                                        (has_enough and (TUNING.isCh2hm and "收集更多" or "Collect More") or (TUNING.isCh2hm and "收集" or "Collect")))
                    self.onclick = self.onrightclick2hm
                end
                local ingredientrecipe = AllRecipes[recipe_type] and owner and owner.HUD and owner.HUD.controls and owner.HUD.controls.craftingmenu and
                                             owner.HUD.controls.craftingmenu:GetRecipeState(recipe_type)
                local selffocus, widgetfocus
                if not has_enough and ingredientrecipe and ingredientrecipe.recipe then
                    local crafting_atlas = resolvefilepath("images/crafting_menu.xml")
                    self.ongainfocus = function()
                        selffocus = true
                        widgetfocus = true
                        if self.sub_ingredients == nil then
                            self.sub_ingredients = self.parent:AddChild(Widget("sub_ingredients"))
                            self.sub_ingredients.ongainfocus = function() widgetfocus = true end
                            self.sub_ingredients.onlosefocus = function() widgetfocus = not selffocus end
                            self.sub_ingredients:MoveToBack()
                            self.background = self.sub_ingredients:AddChild(ThreeSlice(crafting_atlas, "popup_end.tex", "popup_short.tex"))
                            self.ingredients = self.sub_ingredients:AddChild(CraftingMenuIngredients(self.owner, 4, ingredientrecipe.recipe, 1.5))
                            self.ingredients.quantity = num_need
                            self.background:ManualFlow(math.min(5, self.ingredients.num_items), true)
                            local pos = self:GetLocalPosition()
                            self.sub_ingredients:SetPosition(pos.x, pos.y - 64)
                        end
                    end
                    self.onlosefocus = function()
                        selffocus = nil
                        if self.sub_ingredients ~= nil and not selffocus and not widgetfocus then
                            self.sub_ingredients:Kill()
                            self.sub_ingredients = nil
                        end
                    end
                end
                if not self:IsEnabled() then self:Enable() end
                self.AllowOnControlWhenSelected = true
            end
        end)
        local function resetpinslottooltip(self)
            if self.craft_button and self.craftingmenu then
                if self.recipe_name then
                    local recipe = AllRecipes[self.recipe_name]
                    if recipe then
                        local name = ((recipe.nameoverride or recipe.name) and STRINGS.NAMES[string.upper(recipe.nameoverride or recipe.name)]) or
                                         (recipe.product and STRINGS.NAMES[string.upper(recipe.product)])
                        self.craft_button:SetTooltip((name or "") .. (name and "\n" or "") ..
                                                         (recipe.placer and "" or
                                                             (TheInput:GetLocalizedControl(TheInput:GetControllerID(), CONTROL_SECONDARY) .. ": " ..
                                                                 (TUNING.isCh2hm and "收集" or "Collect"))))
                    else
                        self.craft_button:SetTooltip(nil)
                    end
                else
                    self.craft_button:SetTooltip(nil)
                end
            end
        end
        AddClassPostConstruct("widgets/redux/craftingmenu_pinslot", function(self, ...)
            if self.craft_button then
                resetpinslottooltip(self)
                SetImageButtonRightControl(self.craft_button)
                local oldOnControl = self.craft_button.OnControl
                self.craft_button.OnControl = function(_self, control, down, ...)
                    if not TheInput:IsControlPressed(CONTROL_FORCE_INSPECT) and not TheInput:IsControlPressed(CONTROL_FORCE_STACK) and
                        not TheInput:IsControlPressed(CONTROL_FORCE_TRADE) and control == CONTROL_SECONDARY and down and self.recipe_name then
                        local data = self.craftingmenu:GetRecipeState(self.recipe_name)
                        local prefab = data ~= nil and data.recipe ~= nil and data.recipe.product or self.recipe_name
                        collectrecipetypefn(self.owner or ThePlayer, prefab)
                    end
                    return oldOnControl(_self, control, down, ...)
                end
            end
            local oldSetRecipe = self.SetRecipe
            self.SetRecipe = function(self, ...)
                oldSetRecipe(self, ...)
                resetpinslottooltip(self)
            end
            local oldOnPageChanged = self.OnPageChanged
            self.OnPageChanged = function(self, ...)
                oldOnPageChanged(self, ...)
                resetpinslottooltip(self)
            end
        end)
        AddClassPostConstruct("widgets/redux/craftingmenu_widget", function(self, ...)
            local oldOnControl = self.OnControl
            self.OnControl = function(self, control, down, ...)
                if self.crafting_hud and self.crafting_hud:IsCraftingOpen() and not TheInput:IsControlPressed(CONTROL_FORCE_INSPECT) and
                    not TheInput:IsControlPressed(CONTROL_FORCE_STACK) and not TheInput:IsControlPressed(CONTROL_FORCE_TRADE) and control == CONTROL_SECONDARY and
                    down and self.focus and self.enabled then
                    if self.recipe_grid and self.recipe_grid.shown and self.recipe_grid.focus then
                        local index = self.recipe_grid.focused_widget_index + self.recipe_grid.displayed_start_index
                        local items = self.recipe_grid.items
                        if index and items and items[index] then
                            local recipe = items[index].recipe
                            if recipe and (recipe.name or recipe.product) then
                                collectrecipetypefn(self.owner or ThePlayer, recipe.product or recipe.name)
                            end
                        end
                    end
                end
                return oldOnControl(self, control, down, ...)
            end
            if self.recipe_grid and self.recipe_grid.update_fn then
                local oldfn = self.recipe_grid.update_fn
                self.recipe_grid.update_fn = function(context, widget, data, index, ...)
                    local recipe = data and data.recipe
                    if widget and widget.cell_root and recipe then
                        local name = ((recipe.nameoverride or recipe.name) and STRINGS.NAMES[string.upper(recipe.nameoverride or recipe.name)]) or
                                         (recipe.product and STRINGS.NAMES[string.upper(recipe.product)])
                        widget.cell_root:SetTooltip((name or "") .. (name and "\n" or "") ..
                                                        (recipe.placer and "" or
                                                            (TheInput:GetLocalizedControl(TheInput:GetControllerID(), CONTROL_SECONDARY) .. ": " ..
                                                                (TUNING.isCh2hm and "收集" or "Collect"))))
                        SetImageButtonRightControl(widget.cell_root)
                    elseif widget and widget.cell_root then
                        widget.cell_root:SetTooltip(nil)
                    end
                    oldfn(context, widget, data, index, ...)
                end
            end
        end)
    end
    if hasitemsstore then
        local storeaction = Action({})
        storeaction.priority = ACTIONS.LOOKAT.priority - 0.5
        storeaction.id = "STORE2HM"
        storeaction.str = STRINGS.ACTIONS.STORE
        storeaction.rmb = true
        storeaction.instant = true
        storeaction.mount_valid = true
        local function processstoreincontainers(act, ents, inst)
            for _, ent in ipairs(ents) do
                if ent ~= inst and ent.components.container and inst.components.inventory.opencontainers[ent] then
                    if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                        if ent.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition()) end
                        return true
                    end
                end
            end
            for _, ent in ipairs(ents) do
                if ent ~= inst and ent.components.container and not ent.virtchest then
                    for i = 1, ent.components.container.numslots do
                        local item = ent.components.container.slots[i]
                        if item and item:IsValid() and item.prefab == act.invobject.prefab then
                            if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                                if ent.Transform then
                                    SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition())
                                end
                                return true
                            end
                        end
                    end
                elseif ent ~= inst and ent.components.container and ent.virtchest and ent.virtchest:IsValid() and ent.virtchest.components.container and
                    (ent.components.container:Has(act.invobject.prefab, 1) or ent.virtchest.components.container:Has(act.invobject.prefab, 1)) then
                    -- 判断是否溢出
                    if act.invobject.components.stackable then
                        local lacksize = 0
                        local itemsnum = 0
                        for i = 1, ent.components.container.numslots do
                            local item = ent.components.container.slots[i]
                            if item and item:IsValid() then
                                itemsnum = itemsnum + 1
                                if item.prefab == act.invobject.prefab and item.components.stackable then
                                    lacksize = item.components.stackable.maxsize - item.components.stackable.stacksize
                                end
                            end
                        end
                        for i = 1, ent.virtchest.components.container.numslots do
                            local item = ent.virtchest.components.container.slots[i]
                            if item and item:IsValid() then
                                itemsnum = itemsnum + 1
                                if item.prefab == act.invobject.prefab and item.components.stackable then
                                    lacksize = item.components.stackable.maxsize - item.components.stackable.stacksize
                                end
                            end
                        end
                        if itemsnum < ent.components.container.numslots then
                            if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                                if ent.Transform then
                                    SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition())
                                end
                                return true
                            end
                        elseif lacksize >= act.invobject.components.stackable.stacksize then
                            ent.components.container:Open(act.doer)
                            if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                                if ent.Transform then
                                    SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition())
                                end
                                return true
                            end
                        elseif lacksize > 0 and lacksize < act.invobject.components.stackable.stacksize then
                            ent.components.container:Open(act.doer)
                            local giveitem = act.invobject.components.stackable:Get(lacksize)
                            if ent.components.container:GiveItem(giveitem, nil, nil, false) and ent.Transform then
                                SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition())
                            end
                        end
                    else
                        local itemsnum = 0
                        for i = 1, ent.components.container.numslots do
                            local item = ent.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        for i = 1, ent.virtchest.components.container.numslots do
                            local item = ent.virtchest.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        if itemsnum < ent.components.container.numslots and ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                            if ent.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition()) end
                            return true
                        end
                    end
                end
            end
            for _, ent in ipairs(ents) do
                if ent ~= inst and ent.components.container and ent.components.container.itemtestfn then
                    if ent.virtchest and ent.virtchest:IsValid() and ent.virtchest.components.container then
                        local itemsnum = 0
                        for i = 1, ent.components.container.numslots do
                            local item = ent.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        for i = 1, ent.virtchest.components.container.numslots do
                            local item = ent.virtchest.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        if itemsnum >= ent.components.container.numslots then break end
                    end
                    if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                        if ent.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition()) end
                        return true
                    end
                end
            end
            for _, ent in ipairs(ents) do
                if ent ~= inst and ent.components.container then
                    if ent.virtchest and ent.virtchest:IsValid() and ent.virtchest.components.container then
                        local itemsnum = 0
                        for i = 1, ent.components.container.numslots do
                            local item = ent.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        for i = 1, ent.virtchest.components.container.numslots do
                            local item = ent.virtchest.components.container.slots[i]
                            if item and item:IsValid() then itemsnum = itemsnum + 1 end
                        end
                        if itemsnum >= ent.components.container.numslots then break end
                    end
                    if ent.components.container:GiveItem(act.invobject, nil, nil, false) then
                        if ent.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(ent.Transform:GetWorldPosition()) end
                        return true
                    end
                end
            end
        end
        storeaction.fn = function(act)
            local inst = act and act.doer
            if not (inst and act.invobject and act.invobject.components.inventoryitem and inst.components.inventory and inst.components.inventory.opencontainers) then
                return
            end
            local prevcontainer = act.invobject.components.inventoryitem.owner
            local ents = {}
            local x, y, z = inst.Transform:GetWorldPosition()
            local platform = inst:GetCurrentPlatform()
            local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
            for i, v in ipairs(nearents) do
                if v and v ~= inst and not v.dcs2hm and v ~= prevcontainer and v.components and v.components.container and not v.components.inventoryitem and
                    not v.components.health and not v.components.locomotor and not v.components.stewer and v.components.container.canbeopened and
                    not v.components.container.usespecificslotsforitems and v.components.container.acceptsstacks and v.components.container.type == "chest" and
                    v.components.container.numslots >= 9 and not table.contains(storeblacklist, v.prefab) and v:GetCurrentPlatform() == platform and
                    v.components.container:CanTakeItemInSlot(act.invobject) then table.insert(ents, v) end
            end
            if inst.components.rider and inst.components.rider.mount and inst.components.rider.mount:IsValid() and
                inst.components.rider.mount.components.container then table.insert(ents, inst.components.rider.mount) end
            if #ents <= 0 then return end
            local prevslot = act.invobject.components.inventoryitem:GetSlotNum()
            act.invobject.components.inventoryitem:RemoveFromOwner(true)
            -- 存放
            local result = processstoreincontainers(act, ents, inst)
            -- 存放失败检查和修正
            if act.invobject:IsValid() and act.invobject.components.inventoryitem and act.invobject.components.inventoryitem.owner == nil then
                prevcontainer = prevcontainer and (prevcontainer.components.container or prevcontainer.components.inventory)
                if prevcontainer then
                    prevcontainer:GiveItem(act.invobject, prevslot)
                else
                    inst.components.inventory:GiveItem(act.invobject, prevslot)
                end
            end
            return result
        end
        -- 添加存放动作
        AddAction(storeaction)
        AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions)
            if inst.prefab ~= "pocketwatch_recall" and inst.prefab ~= "pocketwatch_portal" and inst.replica.inventoryitem ~= nil and
                not inst.replica.inventoryitem:CanOnlyGoInPocket() and doer and not (doer.replica.inventory and doer.replica.inventory:GetActiveItem() == inst) and
                not (inst.replica.equippable and inst.replica.equippable:IsEquipped()) then table.insert(actions, ACTIONS.STORE2HM) end
        end)
        AddComponentPostInit("playeractionpicker", function(self)
            local oldGetInventoryActions = self.GetInventoryActions
            self.GetInventoryActions = function(self, ...)
                if self.inst and self.inst.components.playercontroller and self.inst.components.playercontroller:IsControlPressed(CONTROL_FORCE_STACK) then
                    ACTIONS.STORE2HM.priority = 11
                end
                local res = oldGetInventoryActions(self, ...)
                if ACTIONS.STORE2HM.priority == 11 then ACTIONS.STORE2HM.priority = ACTIONS.LOOKAT.priority - 0.5 end
                return res
            end
        end)
        -- 智能小木牌模组补丁
        AddPrefabPostInit("world", function()
            if TUNING.SMART_SIGN_DRAW_ENABLE then
                local function refreshcontainerminisign(inst) if inst.components.smart_minisign then inst.components.smart_minisign:OnClose() end end
                AddComponentPostInit("container", function(self)
                    self.inst:DoTaskInTime(0.5, function()
                        if self.inst.components.smart_minisign then
                            self.inst:ListenForEvent("itemget", refreshcontainerminisign)
                            self.inst:ListenForEvent("itemlose", refreshcontainerminisign)
                        end
                    end)
                end)
            end
        end)
    end
end
