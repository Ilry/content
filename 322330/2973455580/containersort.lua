local containers = require("containers")
local ImageButton = require "widgets/imagebutton"
local CraftingMenuIngredients = require "widgets/redux/craftingmenu_ingredients"
local Widget = require "widgets/widget"
local ThreeSlice = require "widgets/threeslice"
local Image = require "widgets/image"

local containercfg = GetModConfigData("Container Sort")
local itemscfg = GetModConfigData("Items collect")
local hasmultisortbtn = containercfg == -2 or containercfg == true
local haslockbutton = containercfg == -3
local hassortbutton = containercfg ~= -5
local hascollectbutton = containercfg ~= -4
local craftmenucollectsupport = itemscfg ~= -1
local hasitemscollect = craftmenucollectsupport
local hasitemsstore = itemscfg ~= -2
-- local hidemoveimage = false

-- 客户端专属配置,仅适用于整理,其他按钮都影响太大了
if TheNet:GetIsClient() and TUNING.TEMP2HM then
    if TUNING.TEMP2HM.opensort ~= nil then hassortbutton = TUNING.TEMP2HM.opensort end
    -- if TUNING.TEMP2HM.hidemoveimage ~= nil then hidemoveimage = TUNING.TEMP2HM.hidemoveimage end
end

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
-- 禁止存放拾取的道具,溯源表
local itemsblacklist = {"pocketwatch_portal", "pocketwatch_recall"}
if ACTIONS.BEIZHU and ACTIONS.BEIZHU.str == STRINGS.SIGNS.MENU.ACCEPT then itemsblacklist = {} end
-- 优先存放容器
local prioritystoreents = {saltbox = 1, icebox = 2}
-- 道具存取特效,以及持续高亮展示
local function stopthighlightcontainer(inst)
    inst.cshighlight2hm = nil
    inst.AnimState:SetMultColour(1, 1, 1, 1)
end
local function starthighlightcontainer(inst)
    if inst.AnimState then inst.AnimState:SetMultColour(1, 0.6, 0, 1) end
    if inst.cshighlight2hm then inst.cshighlight2hm:Cancel() end
    inst.cshighlight2hm = inst:DoTaskInTime(60, stopthighlightcontainer)
end
local function showmovefx(inst, needparent)
    if inst.disablecsfxtask2hm then return end
    if needparent then
        -- 存放到骑乘的牛里时给骑乘者加特效
        local owner = inst.parent and inst.parent:IsValid() and inst.parent or inst
        if owner.Transform then
            SpawnPrefab("sand_puff").Transform:SetPosition(owner.Transform:GetWorldPosition())
            return
        end
    end
    if inst.Transform then SpawnPrefab("sand_puff").Transform:SetPosition(inst.Transform:GetWorldPosition()) end
end
local function delayshowmovefx(inst)
    if inst:IsInLimbo() then
        showmovefx(inst, true)
        return
    end
    if inst.disablecsfxtask2hm then return end
    inst:DoTaskInTime(0.32, showmovefx)
    starthighlightcontainer(inst)
end
-- 地面容器反向过滤检测标签列表
local GROUND_CONTAINER_CANT_TAGS = {"INLIMBO", "NOCLICK", "FX", "dcs2hm"}
local GROUND_NOTITEM_CONTAINER_CANT_TAGS = {"INLIMBO", "NOCLICK", "_inventoryitem", "FX", "dcs2hm"}
-- 拾取道具过滤用标签
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

-- 容器无效道具拦截补丁
AddComponentPostInit("container", function(self)
    local oldGiveItem = self.GiveItem
    self.GiveItem = function(self, item, ...) return item ~= nil and item:IsValid() and oldGiveItem(self, item, ...) or false end
end)

--
-- 单容器排序算法,下面代码来自[码到成功]
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
-- 上面代码来自[码到成功]
-- 

-- 容器整理
local function dosort(inst)
    if not (inst.components.container and inst.components.container.acceptsstacks and not inst.components.container.usespecificslotsforitems or
        inst.components.inventory) then return end
    local container = inst.components.inventory or inst.components.container
    container.ignoresound = true
    container.ignoreoverstacked = true
    local totalslots = {}
    for k, v in pairs(container.itemslots or container.slots) do
        if v then
            local item = container:RemoveItemBySlot(k)
            if item ~= nil and item:IsValid() then
                item.prevslot = nil
                table.insert(totalslots, item)
            end
        end
    end
    totalslots = preciseClassification(totalslots)
    for i, item in ipairs(totalslots) do container:GiveItem(item) end
    container.ignoresound = false
    container.ignoreoverstacked = false
end
local function sortfn(player, inst)
    if inst.components.container ~= nil then
        dosort(inst)
        if inst.components.equippable and inst.components.equippable:IsEquipped() then dosort(player) end
    end
end
-- 容器跨整
local function domultisort(inst, player)
    if not (player.components.inventory and inst.components.container and inst.components.container.acceptsstacks and
        not inst.components.container.usespecificslotsforitems) then return end
    -- ents是除inst外其他要一起处理的容器,inst不需要放在里面
    local ents = {}
    if inst.components.equippable and inst.components.equippable:IsEquipped() then
        -- 糖果袋类和无限类的背包单独处理
        if inst.components.container.itemtestfn ~= nil or inst.components.container.infinitestacksize then
            dosort(inst)
            dosort(player)
            return
        end
        -- 装备的背包则一起处理自己和物品栏
        table.insert(ents, inst)
        inst = player
    elseif inst.components.inventoryitem and inst.components.inventoryitem.owner and
        (inst.components.inventoryitem.owner.components.inventory or inst.components.inventoryitem.owner.components.container) then
        -- 携带的或存在容器内的钓具箱类容器只处理自己和自己所处容器内的同类容器
        local hasothercontainers = false
        local container = (inst.components.inventoryitem.owner.components.inventory or inst.components.inventoryitem.owner.components.container)
        for k, v in pairs(container.itemslots or container.slots) do
            if v:IsValid() and v ~= inst and not v:HasTag("dcs2hm") and not v.dcs2hm and v.components.container and v.components.container.canbeopened and
                v.components.container.acceptsstacks and not v.components.container.usespecificslotsforitems and v.components.container.itemtestfn ==
                inst.components.container.itemtestfn and v.components.container.infinitestacksize == inst.components.container.infinitestacksize then
                hasothercontainers = true
                table.insert(ents, v)
            end
        end
        if not hasothercontainers then
            dosort(inst)
            return
        end
    elseif inst.components.inventoryitem and not inst:HasTag("heavy") then
        -- 地面背包或地面钓具箱则只处理自己,支持带有heavy标签的装备容器
        dosort(inst)
        return
    else
        -- 地面容器则只处理同类且同名的容器
        local x, y, z = inst.Transform:GetWorldPosition()
        local platform = inst:GetCurrentPlatform()
        local nearents = TheSim:FindEntities(x, y, z, 36, nil, GROUND_CONTAINER_CANT_TAGS)
        local hasothercontainers = false
        for i, v in ipairs(nearents) do
            if v ~= inst and v:IsValid() and v.prefab == inst.prefab and not v.dcs2hm and v.components.container and v.components.container.canbeopened and
                v.components.container.acceptsstacks and not v.components.container.usespecificslotsforitems and v.components.container.itemtestfn ==
                inst.components.container.itemtestfn and v.components.container.infinitestacksize == inst.components.container.infinitestacksize and
                v:GetCurrentPlatform() == platform then
                hasothercontainers = true
                showmovefx(v)
                table.insert(ents, v)
            end
        end
        if not hasothercontainers then
            dosort(inst)
            return
        end
    end
    local totalslots = {}
    -- 首先主容器物品收集
    local container = inst.components.inventory or inst.components.container
    container.ignoresound = true
    container.ignoreoverstacked = true
    local slots = container.itemslots or container.slots
    local keys = {}
    for k, _ in pairs(slots) do keys[#keys + 1] = k end
    table.sort(keys)
    for k, v in ipairs(keys) do
        if k ~= v then
            local item = container:RemoveItemBySlot(v)
            container:GiveItem(item, k)
        end
    end
    slots = container.itemslots or container.slots
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
        container.ignoresound = true
        container.ignoreoverstacked = true
        local keys = {}
        for k, _ in pairs(slots) do keys[#keys + 1] = k end
        table.sort(keys)
        for k, v in ipairs(keys) do
            if k ~= v then
                local item = container:RemoveItemBySlot(v)
                container:GiveItem(item, k)
            end
        end
        slots = container.slots
        for key, value in ipairs(slots) do
            if value ~= nil then
                local item = container:RemoveItemBySlot(key)
                table.insert(totalslots, item)
            end
        end
    end
    -- 用一个大容器容纳上面所有道具一起整理
    local tmp = CreateEntity()
    tmp:AddComponent("container")
    -- 火女的余烬存放进去后会读取主人的skilltree
    if inst == player then tmp:AddComponent("skilltreeupdater") end
    tmp.components.container.ShouldPrioritizeContainer = truefn
    tmp.components.container.CanTakeItemInSlot = truefn
    tmp.components.container:SetNumSlots(#totalslots)
    if inst.components.container and inst.components.container.infinitestacksize then inst.components.container:EnableInfiniteStackSize() end
    tmp.components.container.ignoresound = true
    for _, item in ipairs(totalslots) do tmp.components.container:GiveItem(item) end
    dosort(tmp)
    tmp.components.container.ignoresound = true
    tmp.components.container.ignoreoverstacked = true
    -- 分配到各个容器
    local finalslots = tmp.components.container.slots
    -- 第一个容器准备放入
    local entindex = 1
    local entsnumslots = ents[1].components.container.numslots + (container.maxslots or container.numslots)
    for index, item in ipairs(finalslots) do
        local item = tmp.components.container:RemoveItemBySlot(index)
        if not ents[entindex] then
            ents[1].components.container:GiveItem(item)
        elseif index <= (container.maxslots or container.numslots) then
            -- 在放入第一个容器前,优先分配给inst容器
            container:GiveItem(item)
        elseif index <= entsnumslots then
            -- 准备放入的容器还未放满
            ents[entindex].components.container:GiveItem(item)
        else
            entindex = entindex + 1
            if ents[entindex] then
                -- 准备放入的容器已放满,下一个容器准备放入
                entsnumslots = entsnumslots + ents[entindex].components.container.numslots
                ents[entindex].components.container:GiveItem(item)
            else
                ents[1].components.container:GiveItem(item)
            end
        end
    end
    tmp:Remove()
    container.ignoresound = false
    container.ignoreoverstacked = false
    for i, v in ipairs(tmpents) do
        v.components.container.ignoresound = false
        v.components.container.ignoreoverstacked = false
    end
end
local function multisortfn(player, inst) if hasmultisortbtn and inst.components.container ~= nil then domultisort(inst, player) end end
-- 整理按钮和跨整按钮
AddModRPCHandler("MOD_HARDMODE", "sortbtn2hm", sortfn)
local function sortbtnfn(inst, doer)
    if inst.components.container ~= nil then
        sortfn(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "sortbtn2hm"), inst)
    end
end
AddModRPCHandler("MOD_HARDMODE", "multisortbtn2hm", multisortfn)
local function multisortbtnfn(inst, doer)
    if inst.components.container ~= nil then
        multisortfn(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "multisortbtn2hm"), inst)
    end
end
local function doublesortbtnfn(inst, doer)
    inst.doubleclicktask2hm = nil
    if inst.doubleclicktrue2hm then
        multisortbtnfn(inst, doer)
        inst.doubleclicktrue2hm = nil
    end
end
local function realsortbtnfn(inst, doer)
    if (inst.components.equippable and inst.components.equippable:IsEquipped()) or (inst.replica.equippable and inst.replica.equippable:IsEquipped()) then
        if not inst.doubleclicktask2hm then
            inst.doubleclicktask2hm = inst:DoTaskInTime(0.25, doublesortbtnfn, doer)
            sortbtnfn(inst, doer)
        else
            inst.doubleclicktrue2hm = not inst.doubleclicktrue2hm
            inst.doubleclicktask2hm:Cancel()
            inst.doubleclicktask2hm = inst:DoTaskInTime(0.25, doublesortbtnfn, doer)
        end
    else
        sortbtnfn(inst, doer)
    end
end
local function defaultbtnvalidfn(inst)
    return (inst.components.container ~= nil or inst.replica.container ~= nil) and not inst:HasTag("dcs2hm") and not inst.dcs2hm
end

-- 末影箱穿越
local function exchangedestroydata(inst)
    if inst.components.container then
        local container = inst.components.container
        for i = 1, container.numslots do
            local item = container.slots[i]
            if item ~= nil and item:IsValid() then item:PushEvent("player_despawn") end
        end
        container:DestroyContents()
    end
end
local function exchangesenddata(inst, rpcname, world_id, name, confirm)
    if inst.components.container and world_id and name then
        local rpc = GetShardModRPC("MOD_HARDMODE", rpcname)
        if confirm then
            SendModRPCToShard(rpc, nil, world_id, name)
        else
            local containerdata = inst.components.container:OnSave()
            containerdata.time2hm = os.time()
            inst.exchangetmpdata2hm = containerdata
            exchangedestroydata(inst)
            SendModRPCToShard(rpc, nil, world_id, name, DataDumper(containerdata, nil, true))
        end
    end
end
local function exchangeapplydata(inst, containerdata)
    if inst.components.container and containerdata then
        exchangedestroydata(inst)
        inst.components.container:OnLoad(containerdata)
    end
end
local function exchangetaskend(inst)
    if inst.containersendtask2hm then inst.containersendtask2hm = nil end
    if inst.sendcontainerproxyplayer2hm then
        local player = inst.sendcontainerproxyplayer2hm
        if player and player:IsValid() and player.components.talker then
            player.components.talker:Say((TUNING.isCh2hm and ("穿越世界超时中止(可暂停穿越=25秒)") or
                                             ("Exchange timeout invalid~(Pause game then exchange wait 25s)")))
        end
        inst.sendcontainerproxyplayer2hm = nil
    end
    if inst.containerreceivetask2hm then inst.containerreceivetask2hm = nil end
    if inst.sendcontainerproxydata2hm then inst.sendcontainerproxydata2hm = nil end
    if inst.exchangetmpdata2hm then
        exchangeapplydata(inst, inst.exchangetmpdata2hm)
        inst.exchangetmpdata2hm = nil
    end
end
-- 另一世界的确认请求被确认
AddShardModRPCHandler("MOD_HARDMODE", "exchangeconfirm2hm", function(shard_id, world_id, name)
    if TheShard and tostring(TheShard:GetShardId()) ~= tostring(shard_id) and tostring(TheShard:GetShardId()) == tostring(world_id) then
        local container = TheWorld:GetPocketDimensionContainer(name)
        if container and container:IsValid() and container.components.container and container.exchangetmpdata2hm and not container.containersendtask2hm and
            container.containerreceivetask2hm and container.sendcontainerproxydata2hm then
            container.exchangetmpdata2hm = nil
            container.containerreceivetask2hm:Cancel()
            container.containerreceivetask2hm = nil
            exchangeapplydata(container, container.sendcontainerproxydata2hm)
            container.sendcontainerproxydata2hm = nil
        end
    end
end)
-- 所在世界的穿越请求被确认,更新数据,且确认对方的确认请求
AddShardModRPCHandler("MOD_HARDMODE", "exchangeconfirmdata2hm", function(shard_id, world_id, name, containerdata)
    if TheShard and tostring(TheShard:GetShardId()) ~= tostring(shard_id) and tostring(TheShard:GetShardId()) == tostring(world_id) then
        local container = TheWorld:GetPocketDimensionContainer(name)
        if container and container:IsValid() and container.components.container and container.exchangetmpdata2hm and container.containersendtask2hm and
            not container.containerreceivetask2hm and container.sendcontainerproxyplayer2hm and containerdata then
            local success, data = RunInSandboxSafe(containerdata)
            if success and data and data.time2hm and os.time() - data.time2hm < 400 then
                container:DoTaskInTime(FRAMES * 1.5, exchangesenddata, "exchangeconfirm2hm", shard_id, name, true)
                container.exchangetmpdata2hm = nil
                container.containersendtask2hm:Cancel()
                container.containersendtask2hm = nil
                exchangeapplydata(container, data)
                local player = container.sendcontainerproxyplayer2hm
                if player and player:IsValid() and player.components.talker then
                    player.components.talker:Say((TUNING.isCh2hm and ("成功穿越世界" .. world_id .. "啦") or
                                                     ("SUCCESS to exchange with world " .. world_id .. "~")))
                end
                container.sendcontainerproxyplayer2hm = nil
            end
        end
    end
end)
-- 另一世界收到穿越请求,确认请求
AddShardModRPCHandler("MOD_HARDMODE", "exchangesenddata2hm", function(shard_id, world_id, name, containerdata)
    if TheShard and tostring(TheShard:GetShardId()) ~= tostring(shard_id) and tostring(TheShard:GetShardId()) == tostring(world_id) then
        local container = TheWorld:GetPocketDimensionContainer(name)
        if container and container:IsValid() and container.components.container and container.virtchest == nil and not container.containersendtask2hm and
            not container.containerreceivetask2hm and containerdata then
            local success, data = RunInSandboxSafe(containerdata)
            if success and data and data.time2hm and os.time() - data.time2hm < 350 then
                container.containerreceivetask2hm = container:DoTaskInTime(3, exchangetaskend)
                container.sendcontainerproxydata2hm = data
                container:DoTaskInTime(FRAMES * 1.5, exchangesenddata, "exchangeconfirmdata2hm", shard_id, name)
            end
        end
    end
end)
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
-- 所在世界进行穿越请求
local function exchangefn(player, inst)
    if TheWorld.ismastersim and inst.components.container and not inst.containersendtask2hm and not inst.containerreceivetask2hm and inst.virtchest == nil then
        inst.sendcontainerproxyplayer2hm = player
        inst.containersendtask2hm = inst:DoTaskInTime(1.5, exchangetaskend)
        local name = findcontainerproxyname(inst)
        local world_id = findanotherworldid()
        if world_id and name then
            exchangesenddata(inst, "exchangesenddata2hm", world_id, name)
        elseif player and player:IsValid() and player.components.talker then
            player.components.talker:Say((TUNING.isCh2hm and "找不到世界和容器穿越哎" or "Can't find another world's container to exchange."))
        end
    end
end
-- 穿越按钮
AddModRPCHandler("MOD_HARDMODE", "exchangebtn2hm", exchangefn)
local function exchangebtnfn(inst, doer)
    if inst.components.container and TheWorld.ismastersim then
        exchangefn(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "exchangebtn2hm"), inst)
    end
end
local function exchangevalidfn(inst) return defaultbtnvalidfn(inst) and inst:HasTag("pocketdimension_container") end

-- 容器收集
local function getfinalowner(inst)
    return inst.components.inventoryitem and inst.components.inventoryitem.owner and getfinalowner(inst.components.inventoryitem.owner) or inst
end
local function iscontainerchild(inst, container)
    if not container.components.container then return false end
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if owner == container then
        return true
    elseif owner ~= nil then
        return iscontainerchild(owner, container)
    end
end
local function findcontainersincontainer(inst, result)
    for k, v in pairs(inst.components.container.slots) do
        if v and v:IsValid() and not v:HasTag("dcs2hm") and not v.dcs2hm and v.components.container and v.components.container.canbeopened then
            table.insert(result, v)
            findcontainersincontainer(v, result)
        end
    end
end
local function givecontaineritem(container, item, src_pos)
    if item.components.stackable then
        local slotsize = item.components.stackable.originalmaxsize or item.components.stackable.maxsize
        if slotsize and item.components.stackable.stacksize > slotsize then
            local size = item.components.stackable.stacksize
            local totalsize = size + slotsize
            for i = slotsize, totalsize, slotsize do
                local giveitem = item.components.stackable:Get(slotsize)
                giveitem.currplayer2hm = item.currplayer2hm
                container:GiveItem(giveitem, nil, i > size and src_pos or nil)
                if giveitem and giveitem:IsValid() then giveitem.currplayer2hm = nil end
            end
            return
        end
    end
    container:GiveItem(item, nil, src_pos)
    if item and item:IsValid() then item.currplayer2hm = nil end
end
-- data必选参数:prefabs,leftnumslots,lacksize
-- data可选参数:infiniteprefabs,neednum,fastresult,currplayer2hm --返回时data参数:entfx
-- infiniteprefabs 代表contaienr组件可以无限收集某些实体
-- neednum 代表只收集固定数额后就结束收集,返回true
-- fastresult 代表只收集一次实体后就结束收集,返回true
-- prefabfn是container组件要收集的特定实体
-- prefabs是container组件要收集的实体表
-- leftnumslots是container组件的空白格子数目
-- lacksize是container组件每个要收集的堆叠实体的重叠格子的剩余空间
local function collectentcontaineritem(inst, container, item, ent, entcontainer, i, data)
    if (data.prefabfn and data.prefabfn(item) or (data.prefabs and table.contains(data.prefabs, item.prefab))) and item ~= inst and
        not iscontainerchild(inst, item) and container:CanTakeItemInSlot(item) then
        if data.infiniteprefabs then
            if data.infiniteprefabs[item.prefab] then
                -- 无限需求堆叠道具,所以可以无限给予
                container:GiveItem(entcontainer:RemoveItemBySlot(i), nil, data.entpos)
                if not data.entfx then data.entfx = true end
            elseif data.leftnumslots > 0 then
                -- 非堆叠道具或新加道具则只能放到有限的空格
                data.leftnumslots = data.leftnumslots - 1
                local item = entcontainer:RemoveItemBySlot(i)
                if container:GiveItem(item, nil, data.entpos) and item:IsValid() and item.components.stackable and item.components.stackable.maxsize ==
                    math.huge then data.infiniteprefabs[item.prefab] = true end
                if not data.entfx then data.entfx = true end
            end
        elseif data.neednum then
            -- 收集配方时的收集固定数目需求,则获得固定数目道具后结束
            if item.components.stackable then
                if not data.realneednum then
                    data.realneednum = true
                    local slotsize = item.components.stackable.originalmaxsize or item.components.stackable.maxsize
                    local leftsize = (data.lacksize[item.prefab] or 0) + slotsize * data.leftnumslots
                    data.neednum = math.min(data.neednum, leftsize)
                end
                local givenum = math.min(item.components.stackable.stacksize, data.neednum)
                data.neednum = data.neednum - givenum
                local giveitem = item.components.stackable:Get(givenum)
                giveitem.currplayer2hm = data.currplayer2hm
                givecontaineritem(container, giveitem, data.entpos)
            else
                if not data.realneednum then
                    data.realneednum = true
                    data.neednum = math.min(data.neednum, data.leftnumslots)
                end
                data.neednum = data.neednum - 1
                local giveitem = entcontainer:RemoveItemBySlot(i)
                giveitem.currplayer2hm = data.currplayer2hm
                container:GiveItem(giveitem, nil, data.entpos)
                if giveitem and giveitem:IsValid() then giveitem.currplayer2hm = nil end
            end
            if not data.entfx then data.entfx = true end
            if data.neednum <= 0 then return true end
        elseif data.fastresult then
            -- 收集配方时的收集更多需求,则拿到本道具后就结束
            if item.components.stackable then
                local slotsize = item.components.stackable.originalmaxsize or item.components.stackable.maxsize
                local giveitem = item.components.stackable:Get(slotsize)
                giveitem.currplayer2hm = data.currplayer2hm
                container:GiveItem(giveitem, nil, data.entpos)
            else
                local giveitem = entcontainer:RemoveItemBySlot(i)
                giveitem.currplayer2hm = data.currplayer2hm
                container:GiveItem(giveitem, nil, data.entpos)
            end
            if giveitem and giveitem:IsValid() then giveitem.currplayer2hm = nil end
            if not data.entfx then data.entfx = true end
            return true
        elseif data.lacksize[item.prefab] and item.components.stackable then -- 有限需求
            -- 有限需求,处理需求与供给数目关系
            if data.lacksize[item.prefab] >= item.components.stackable.stacksize then
                -- 重叠格子用不完,直接给
                data.lacksize[item.prefab] = data.lacksize[item.prefab] - item.components.stackable.stacksize
                if data.lacksize[item.prefab] <= 0 then data.lacksize[item.prefab] = nil end
                local giveitem = entcontainer:RemoveItemBySlot(i)
                container:GiveItem(giveitem, nil, data.entpos)
                if not data.entfx then data.entfx = true end
            elseif data.leftnumslots > 0 then
                -- 重叠格子会用完,但还有空白格子
                local slotsize = item.components.stackable.originalmaxsize or item.components.stackable.maxsize
                local leftsize = data.lacksize[item.prefab] + slotsize * data.leftnumslots
                if leftsize <= item.components.stackable.stacksize then
                    -- 重叠和空白格子都会被该道具堆满,(额要收集的容器有问题,堆叠数目似乎太高了吧)
                    data.leftnumslots = 0
                    data.lacksize[item.prefab] = nil
                    local giveitem = item.components.stackable:Get(leftsize)
                    givecontaineritem(container, giveitem, data.entpos)
                    if not data.entfx then data.entfx = true end
                    -- 全部堆满,则结束收集
                    if IsTableEmpty(data.lacksize) then return true end
                else
                    -- 还能残留空间
                    local useleftslotsize = item.components.stackable.stacksize - data.lacksize[item.prefab]
                    data.leftnumslots = data.leftnumslots - math.ceil(useleftslotsize / slotsize)
                    data.lacksize[item.prefab] = data.leftnumslots * slotsize - useleftslotsize - data.leftnumslots * slotsize
                    if data.lacksize[item.prefab] <= 0 then data.lacksize[item.prefab] = nil end
                    local giveitem = entcontainer:RemoveItemBySlot(i)
                    givecontaineritem(container, giveitem, data.entpos)
                    if not data.entfx then data.entfx = true end
                end
            elseif data.lacksize[item.prefab] > 0 then
                -- 重叠格子会用完,且没有空白格子
                local giveitem = item.components.stackable:Get(data.lacksize[item.prefab])
                data.lacksize[giveitem.prefab] = nil
                container:GiveItem(giveitem, nil, data.entpos)
                if not data.entfx then data.entfx = true end
                -- 全部堆满,则结束收集
                if IsTableEmpty(data.lacksize) then return true end
            end
        elseif data.leftnumslots > 0 then
            -- 没有重叠格子但有空白格子
            if item.components.stackable then
                local slotsize = item.components.stackable.originalmaxsize or item.components.stackable.maxsize
                local leftsize = slotsize * data.leftnumslots
                if leftsize <= item.components.stackable.stacksize then
                    -- 空白格子都会被该道具堆满
                    data.leftnumslots = 0
                    local giveitem = item.components.stackable:Get(leftsize)
                    givecontaineritem(container, giveitem, data.entpos)
                    if not data.entfx then data.entfx = true end
                    -- 全部堆满,则结束收集
                    if IsTableEmpty(data.lacksize) then return true end
                else
                    -- 还能残留空间
                    data.leftnumslots = data.leftnumslots - math.ceil(item.components.stackable.stacksize / slotsize)
                    data.lacksize[item.prefab] = leftsize - item.components.stackable.stacksize - data.leftnumslots * slotsize
                    if data.lacksize[item.prefab] <= 0 then data.lacksize[item.prefab] = nil end
                    local giveitem = entcontainer:RemoveItemBySlot(i)
                    givecontaineritem(container, giveitem, data.entpos)
                    if not data.entfx then data.entfx = true end
                end
            else
                data.leftnumslots = data.leftnumslots - 1
                container:GiveItem(entcontainer:RemoveItemBySlot(i), nil, data.entpos)
            end
            if not data.entfx then data.entfx = true end
            if data.leftnumslots <= 0 and IsTableEmpty(data.lacksize) then return true end
        elseif IsTableEmpty(data.lacksize) then
            return true
        end
    end
end
local function collectcontainers(inst, container, data, ents)
    local result
    local fxents = {}
    container.ignoresound = true
    for _, ent in ipairs(ents) do
        if ent ~= inst and ent.components.container then
            local entcontainer = ent.components.container
            local finalent = getfinalowner(ent.virtfrom2hm or ent)
            if data.proxyents and data.proxyents[finalent] then finalent = data.proxyents[finalent] end
            data.entpos = finalent:GetPosition()
            entcontainer.ignoreoverstacked = true
            for i = entcontainer.numslots, 1, -1 do
                local item = entcontainer.slots[i]
                if item and item:IsValid() and collectentcontaineritem(inst, container, item, ent, entcontainer, i, data) then
                    result = true
                    break
                end
            end
            entcontainer.ignoreoverstacked = false
            if data.entfx then
                data.entfx = nil
                if not table.contains(fxents, finalent) then table.insert(fxents, finalent) end
            end
            if result then break end
        elseif ent ~= inst and ent.components.inventory then
            data.entpos = ent:GetPosition()
            for i = ent.components.inventory.maxslots, 1, -1 do
                local item = ent.components.inventory.itemslots[i]
                if item and item:IsValid() and collectentcontaineritem(inst, container, item, ent, ent.components.inventory, i, data) then
                    result = true
                    break
                end
            end
            if data.entfx then
                data.entfx = nil
                if not table.contains(fxents, finalent) then table.insert(fxents, finalent) end
            end
            if result then break end
        end
    end
    container.ignoresound = false
    for index, ent in ipairs(fxents) do showmovefx(ent) end
    return result
end
local function getcontainerspace(inst, container, data, addprefab)
    local slots = container.slots or container.itemslots
    local numslots = container.numslots or container.maxslots
    -- 没有剩余空间时返回true
    if data.prefabfn == nil then data.prefabs = data.prefabs or {} end
    data.infiniteprefabs = data.infiniteprefabs or {}
    data.lacksize = data.lacksize or {}
    data.leftnumslots = (data.leftnumslots or 0) + numslots
    for i = 1, numslots do
        local item = slots[i]
        if item ~= nil and item:IsValid() then
            data.leftnumslots = data.leftnumslots - 1
            local hasprefab = (data.prefabfn and data.prefabfn(item) or (data.prefabs and table.contains(data.prefabs, item.prefab)))
            if not hasprefab and addprefab ~= false and data.prefabs and not table.contains(itemsblacklist, item.prefab) then
                table.insert(data.prefabs, item.prefab)
                hasprefab = true
            end
            if hasprefab and item.components.stackable then
                if container.infinitestacksize or item.components.stackable.maxsize == math.huge then
                    data.infiniteprefabs[item.prefab] = true
                    if data.lacksize[item.prefab] then data.lacksize[item.prefab] = nil end
                elseif not data.infiniteprefabs[item.prefab] and item.components.stackable.stacksize < item.components.stackable.maxsize then
                    data.lacksize[item.prefab] = (data.lacksize[item.prefab] or 0) + item.components.stackable.maxsize - item.components.stackable.stacksize
                end
            end
        end
    end
    if (data.prefabs and #data.prefabs == 0) or (data.leftnumslots == 0 and IsTableEmpty(data.infiniteprefabs) and IsTableEmpty(data.lacksize)) then
        return true
    end
    if IsTableEmpty(data.infiniteprefabs) then data.infiniteprefabs = nil end
end
local function docollect(inst, player)
    if not (inst.components.container and inst.components.container.numslots > 0 and #inst.components.container.slots > 0) then return end
    local container = inst.components.container
    local data = {}
    if getcontainerspace(inst, container, data) then return end
    -- 记录要收集道具的来源容器列表
    local ents = {}
    if inst.components.inventoryitem and inst.components.inventoryitem.owner then
        -- 携带容器->自己所在根容器
        local owner = getfinalowner(inst)
        local ownercontainer = owner.components.inventory or owner.components.container
        if not owner:HasTag("dcs2hm") and not owner.dcs2hm and ownercontainer then table.insert(ents, owner) end
        if ownercontainer then
            for k, v in pairs(ownercontainer.itemslots or ownercontainer.slots) do
                if v and v:IsValid() and not v:HasTag("dcs2hm") and not v.dcs2hm and v.components.container and v.components.container.canbeopened then
                    table.insert(ents, v)
                    findcontainersincontainer(v, ents)
                end
            end
        end
        if owner.components.inventory then
            for k, v in pairs(EQUIPSLOTS) do
                local equip = owner.components.inventory:GetEquippedItem(v)
                if equip ~= nil and equip.components.container ~= nil then
                    table.insert(ents, equip)
                    findcontainersincontainer(equip, ents)
                end
            end
        end
    else
        -- 地面容器->内部容器和周围的地面容器
        findcontainersincontainer(inst, ents)
        if not inst.components.inventoryitem or inst:HasTag("heavy") then
            local x, y, z = inst.Transform:GetWorldPosition()
            local platform = inst:GetCurrentPlatform()
            local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
            for i, v in ipairs(nearents) do
                if v ~= inst and v:IsValid() and not v.dcs2hm and v.components.container and v.components.container.canbeopened and
                    (not inst.components.inventoryitem or inst:HasTag("heavy")) and v:GetCurrentPlatform() == platform then
                    table.insert(ents, v)
                    findcontainersincontainer(v, ents)
                end
            end
        end
    end
    for i = #ents, 1, -1 do
        if ents[i] == inst then
            table.remove(ents, i)
            break
        end
    end
    if #ents <= 0 then return end
    local tmpents = {}
    -- if inst.virtchest and inst.virtchest:IsValid() and inst.virtchest.components.container then table.insert(tmpents, inst.virtchest) end
    for i, v in ipairs(ents) do
        table.insert(tmpents, v)
        if v.virtchest and v.virtchest:IsValid() and v.virtchest.components.container then table.insert(tmpents, v.virtchest) end
    end
    -- 进行收集道具操作
    data.currplayer2hm = inst
    collectcontainers(inst, container, data, tmpents)
end
local function collectfn(player, inst)
    -- 混合拾取和收纳时,拾取后短暂时间内不会进行收纳
    if hascollectbutton and inst and inst.components.container ~= nil and not inst.pickuptask2hm then docollect(inst, player) end
end
local function pickuploading(inst) inst.pickuptask2hm = nil end
local function dopickup(inst, player)
    if not (player.components.inventory and (inst.components.inventory or inst.components.container)) then return end
    -- 检测是否装备懒人护符
    local hasorangeamulet = false
    local data = {}
    for k, v in pairs(player.components.inventory.equipslots) do
        if v and v.prefab == "orangeamulet" and v:IsValid() and
            ((v.components.finiteuses and v.components.finiteuses.current > 1) or (v.components.fueled and v.components.fueled.currentfuel > 1)) then
            data.orangeamulet = v
            data.beforefiniteuses = v.components.finiteuses and v.components.finiteuses.current - 1 or
                                        (v.components.fueled and v.components.fueled.currentfuel - 1)
            data.finiteuses = data.beforefiniteuses
            hasorangeamulet = true
            break
        end
    end
    if not hasorangeamulet then
        local activeitem = player.components.inventory.activeitem
        if activeitem and activeitem.prefab == "orangeamulet" and activeitem:IsValid() and
            ((activeitem.components.finiteuses and activeitem.components.finiteuses.current > 1) or
                (activeitem.components.fueled and activeitem.components.fueled.currentfuel > 1)) then
            data.orangeamulet = activeitem
            data.beforefiniteuses = activeitem.components.finiteuses and activeitem.components.finiteuses.current - 1 or
                                        (activeitem.components.fueled and activeitem.components.fueled.currentfuel - 1)
            data.finiteuses = data.beforefiniteuses
            hasorangeamulet = true
        end
    end
    if not hasorangeamulet then return end
    if inst.pickuptask2hm then inst.pickuptask2hm:Cancel() end
    inst.pickuptask2hm = inst:DoTaskInTime(0.3, pickuploading)
    local container = inst.components.inventory or inst.components.container
    if getcontainerspace(inst, container, data) then return end
    if data.orangeamulet and data.orangeamulet.skin_equip_sound and player.SoundEmitter then
        player.SoundEmitter:PlaySound(data.orangeamulet.skin_equip_sound)
    end
    local x, y, z = player.Transform:GetWorldPosition()
    local nearents = TheSim:FindEntities(x, y, z, 36, nil, PICKUP_CANT_TAGS, PICKUP_MUST_ONEOF_TAGS)
    for i = #nearents, 1, -1 do
        local v = nearents[i]
        if v:IsValid() and table.contains(data.prefabs, v.prefab) and v ~= inst and not v:IsInLimbo() and not iscontainerchild(inst, v) and
            container:CanTakeItemInSlot(v) and not v.components.inventoryitem.owner and v.components.inventoryitem.canbepickedup and
            not ((v:HasTag("fire") and not v:HasTag("lighter")) or v:HasTag("smolder")) and not v:HasTag("heavy") and
            not (v.components.container ~= nil and v.components.equippable == nil) and
            not ((v.components.burnable ~= nil and v.components.burnable:IsBurning() and v.components.lighter == nil) or
                (v.components.projectile ~= nil and v.components.projectile:IsThrown())) and
            not (inst.components.itemtyperestrictions ~= nil and not inst.components.itemtyperestrictions:IsAllowed(v)) and
            not (v.components.container ~= nil and v.components.container:IsOpen()) and
            not (v.components.yotc_racecompetitor ~= nil and v.components.entitytracker ~= nil) and
            (not v:HasTag("spider") or (player:HasTag("spiderwhisperer"))) and
            not ((v:HasTag("spider") and player:HasTag("spiderwhisperer")) and (v.components.follower.leader ~= nil and v.components.follower.leader ~= player)) and
            not (v.components.curseditem and not v.components.curseditem:checkplayersinventoryforspace(player)) and
            not (v.components.inventory ~= nil and v:HasTag("drop_inventory_onpickup")) then
            if data.infiniteprefabs then
                if data.infiniteprefabs[v.prefab] then
                    -- 无限需求堆叠道具,所以可以无限给予
                    showmovefx(v)
                    container:GiveItem(v)
                    data.finiteuses = data.finiteuses - math.max(v.components.stackable and v.components.stackable.stacksize / 4 or 1, 1)
                elseif data.leftnumslots > 0 then
                    -- 非堆叠道具则只能放到有限的空格
                    data.leftnumslots = data.leftnumslots - 1
                    showmovefx(v)
                    container:GiveItem(v)
                    data.finiteuses = data.finiteuses - 1
                end
            elseif data.lacksize[v.prefab] and v.components.stackable then -- 有限需求
                -- 有限需求,处理需求与供给数目关系
                if data.lacksize[v.prefab] >= v.components.stackable.stacksize then
                    -- 重叠格子用不完,直接给
                    data.finiteuses = data.finiteuses - math.max(v.components.stackable.stacksize / 4, 1)
                    data.lacksize[v.prefab] = data.lacksize[v.prefab] - v.components.stackable.stacksize
                    if data.lacksize[v.prefab] <= 0 then data.lacksize[v.prefab] = nil end
                    showmovefx(v)
                    container:GiveItem(v)
                elseif data.leftnumslots > 0 then
                    -- 重叠格子会用完,但还有空白格子
                    local slotsize = v.components.stackable.originalmaxsize or v.components.stackable.maxsize
                    local leftsize = data.lacksize[v.prefab] + slotsize * data.leftnumslots
                    if leftsize <= v.components.stackable.stacksize then
                        -- 重叠和空白格子都会被该道具堆满
                        data.finiteuses = data.finiteuses - math.max(leftsize / 4, 1)
                        data.leftnumslots = 0
                        data.lacksize[v.prefab] = nil
                        showmovefx(v)
                        container:GiveItem(v.components.stackable:Get(leftsize), nil, data.entpos)
                        -- 全部堆满,则结束收集
                        if IsTableEmpty(data.lacksize) then break end
                    else
                        -- 还能残留空间
                        data.finiteuses = data.finiteuses - math.max(v.components.stackable.stacksize / 4, 1)
                        leftsize = leftsize - v.components.stackable.stacksize
                        data.leftnumslots = math.floor(leftsize / slotsize)
                        data.lacksize[v.prefab] = math.floor(leftsize % slotsize)
                        if data.lacksize[v.prefab] <= 0 then data.lacksize[v.prefab] = nil end
                        showmovefx(v)
                        container:GiveItem(v, nil, data.entpos)
                    end
                elseif data.lacksize[v.prefab] > 0 then
                    -- 重叠格子会用完,且没有空白格子
                    data.finiteuses = data.finiteuses - math.max(data.lacksize[v.prefab] / 4, 1)
                    showmovefx(v)
                    local giveitem = v.components.stackable:Get(data.lacksize[v.prefab])
                    data.lacksize[giveitem.prefab] = nil
                    container:GiveItem(giveitem, nil, data.entpos)
                    -- 全部堆满,则结束收集
                    if IsTableEmpty(data.lacksize) then break end
                end
            elseif data.leftnumslots > 0 then
                -- 没有重叠格子但有空白格子
                showmovefx(v)
                data.leftnumslots = data.leftnumslots - 1
                if v.components.stackable then
                    local slotsize = v.components.stackable.originalmaxsize or v.components.stackable.maxsize
                    local leftsize = slotsize * data.leftnumslots
                    if leftsize <= v.components.stackable.stacksize then
                        -- 空白格子都会被该道具堆满
                        data.finiteuses = data.finiteuses - math.max(leftsize / 4, 1)
                        data.leftnumslots = 0
                        local giveitem = v.components.stackable:Get(leftsize)
                        container:GiveItem(giveitem, nil, data.entpos)
                        -- 全部堆满,则结束收集
                        if IsTableEmpty(data.lacksize) then return true end
                    else
                        -- 还能残留空间
                        data.finiteuses = data.finiteuses - math.max(v.components.stackable.stacksize / 4, 1)
                        leftsize = leftsize - v.components.stackable.stacksize
                        data.leftnumslots = math.floor(leftsize / slotsize)
                        data.lacksize[v.prefab] = math.floor(leftsize % slotsize)
                        if data.lacksize[v.prefab] <= 0 then data.lacksize[v.prefab] = nil end
                        container:GiveItem(v, nil, data.entpos)
                    end
                else
                    data.finiteuses = data.finiteuses - 1
                    container:GiveItem(v, nil, data.entpos)
                end
                if data.leftnumslots <= 0 and IsTableEmpty(data.lacksize) then break end
            end
            if data.finiteuses <= 0 then break end
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
local function pickupfn(player, inst)
    if hascollectbutton then
        if inst.components.container ~= nil then dopickup(inst, player) end
        if inst.components.equippable and inst.components.equippable:IsEquipped() and player.components.inventory then dopickup(player, player) end
    end
end
local function realcollectfn(doer, inst)
    pickupfn(doer, inst)
    collectfn(doer, inst)
end
-- 收集/拾取按钮
AddModRPCHandler("MOD_HARDMODE", "collectbtn2hm", realcollectfn)
local function collectbtnfn(inst, doer)
    if not hascollectbutton then return end
    if inst.components.container ~= nil then
        realcollectfn(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "collectbtn2hm"), inst)
    end
end

-- 容器锁定/解锁
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
local function dolock(inst, doer, typelock)
    if not (haslockbutton and inst.components.container and not inst.components.container.usespecificslotsforitems) then return end
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
local function lockfn(player, inst) if haslockbutton and inst and inst.components.container ~= nil then dolock(inst, player) end end
AddModRPCHandler("MOD_HARDMODE", "lockbtn2hm", lockfn)
-- 锁定/解锁按钮
local function lockbtnfn(inst, doer, btn)
    if not haslockbutton then return end
    btn:SetText(inst:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "锁定" or "Lock") or (TUNING.isCh2hm and "解锁" or "Unlock"))
    if inst.components.container ~= nil then
        lockfn(doer, inst)
    elseif inst.replica.container ~= nil then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "lockbtn2hm"), inst)
    end
end

-- 衣柜换装
local function reskinfn(player, inst) if inst:HasTag("wardrobe") and inst.components.wardrobe then BufferedAction(player, inst, ACTIONS.CHANGEIN):Do() end end
-- 换装按钮
AddModRPCHandler("MOD_HARDMODE", "reskinbtn2hm", reskinfn)
local function reskinbtnfn(inst, doer)
    if inst.components.wardrobe ~= nil and inst:HasTag("wardrobe") then
        BufferedAction(doer, inst, ACTIONS.CHANGEIN):Do()
    elseif inst.replica.container ~= nil and inst:HasTag("wardrobe") then
        SendModRPCToServer(GetModRPC("MOD_HARDMODE", "reskinbtn2hm"), inst)
    end
end
local function reskinvalidfn(inst) return defaultbtnvalidfn(inst) and inst:HasTag("wardrobe") end

-- [[[[[容器按钮]]]]
if containercfg then
    -- 按钮参数
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
            -- 可选整理按钮,默认第1个
            if hassortbutton then
                container.widget.sortbtninfo2hm = {
                    text = TUNING.isCh2hm and "整理" or "Sort",
                    helptext = TUNING.isCh2hm and [[排序该容器内道具
背包双击会混合排序物品栏和背包内道具]] or [[Sort Your Items
Backpack Double Click Will Pass Through Inventory]],
                    position = position1,
                    fn = realsortbtnfn,
                    validfn = defaultbtnvalidfn
                }
            end
            -- 可选按钮,默认第2个位置
            if haslockbutton then
                container.widget.lockbtninfo2hm = {
                    text = TUNING.isCh2hm and "锁定" or "Lock",
                    helptext = TUNING.isCh2hm and [[锁定该容器只能放置当前已有的道具]] or [[Lock the container to limit store current items]],
                    position = position2,
                    fn = lockbtnfn,
                    validfn = defaultbtnvalidfn
                }
            elseif hasmultisortbtn then
                container.widget.multisortbtninfo2hm = {
                    text = TUNING.isCh2hm and "跨整" or "MSort",
                    helptext = TUNING.isCh2hm and [[背包会混合排序物品栏和背包内道具
携带容器混合排序所在容器内的所有同类容器内道具
地面容器会混合排序周围同名容器内道具,不会跨船]] or "Sort Your Items Pass Through Containers",
                    position = position2,
                    fn = multisortbtnfn,
                    validfn = defaultbtnvalidfn
                }
            end
            -- 可选收集按钮,默认第3个位置
            if hascollectbutton then
                container.widget.collectbtninfo2hm = {
                    text = TUNING.isCh2hm and "收集" or "Collect",
                    helptext = TUNING.isCh2hm and [[携带容器收集携带的容器内同名道具
地面容器收集周围容器内的同名道具,不会跨船
佩戴或手持懒人护符,则拾取周围地上同名道具]] or [[Collect Same Items From Containers
Use Orange Amulet will Pickup Near Same Items]],
                    position = (hasmultisortbtn or haslockbutton) and position3 or (hassortbutton and position2 or position1),
                    fn = collectbtnfn,
                    validfn = defaultbtnvalidfn
                }
            end
            -- 特殊容器才有的交换按钮,但在这里无法区分是否用用,因此直接全员设置
            container.widget.exchangebtninfo2hm = {
                text = TUNING.isCh2hm and "穿越" or "PassW",
                helptext = TUNING.isCh2hm and [[与随机其他世界的该容器交换道具]] or
                    [[exchange container data with another world's the container]],
                position = haslockbutton and position3 or (hassortbutton and position2 or position1),
                fn = exchangebtnfn,
                validfn = exchangevalidfn
            }
            -- 妥协衣柜才有的换装按钮
            if prefab == "wardrobe" then
                local slotpos_2 = container.widget.slotpos[finalslot - 3]
                local position4 = Vector3(slotpos_2.x, slotpos_2.y - 57, slotpos_2.z)
                container.widget.reskinbtninfo2hm = {
                    text = TUNING.isCh2hm and "换装" or "Skin",
                    position = (haslockbutton or hasmultisortbtn) and position4 or (hassortbutton and hascollectbutton and position3 or position2),
                    fn = reskinbtnfn,
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
    -- 按钮添加
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
                if self.backpackinv and self.backpackinv[num] and not widget.buttoninfo then
                    local pos = self.backpackinv[num]:GetPosition()
                    if hassortbutton and widget.sortbtninfo2hm then
                        addbutton(self.bottomrow, overflow.inst, self.owner, "sortbutton2hm", widget.sortbtninfo2hm, Vector3(pos.x + 98, pos.y, pos.z))
                    end
                    if hascollectbutton and widget.collectbtninfo2hm then
                        addbutton(self.bottomrow, overflow.inst, self.owner, "collectbutton2hm", widget.collectbtninfo2hm,
                                  ((haslockbutton and widget.lockbtninfo2hm) or (hasmultisortbtn and widget.multisortbtninfo2hm)) and
                                      Vector3(pos.x + 238, pos.y, pos.z) or (hassortbutton and Vector3(pos.x + 168, pos.y, pos.z)) or
                                      Vector3(pos.x + 98, pos.y, pos.z))
                    end
                    if haslockbutton and widget.lockbtninfo2hm then
                        widget.lockbtninfo2hm.text = overflow.inst:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "解锁" or "Unlock") or
                                                         (TUNING.isCh2hm and "锁定" or "Lock")
                        addbutton(self.bottomrow, overflow.inst, self.owner, "lockbutton2hm", widget.lockbtninfo2hm, Vector3(pos.x + 168, pos.y, pos.z))
                    end
                    if hasmultisortbtn and widget.multisortbtninfo2hm then
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
            if container and not container:HasTag("dcs2hm") and not container.dcs2hm then
                if hassortbutton and widget.sortbtninfo2hm then addbutton(self, container, doer, "sortbutton2hm", widget.sortbtninfo2hm) end
                if container.prefab == "wardrobe" and widget.reskinbtninfo2hm and container:HasTag("wardrobecontainer2hm") then
                    addbutton(self, container, doer, "reskinbutton2hm", widget.reskinbtninfo2hm)
                end
                if haslockbutton and widget.lockbtninfo2hm then
                    widget.lockbtninfo2hm.text = container:HasTag("lockcontainer2hm") and (TUNING.isCh2hm and "解锁" or "Unlock") or
                                                     (TUNING.isCh2hm and "锁定" or "Lock")
                    addbutton(self, container, doer, "lockbutton2hm", widget.lockbtninfo2hm)
                end
                if container:HasTag("pocketdimension_container") and widget.exchangebtninfo2hm then
                    if not TUNING.DSA_ONE_PLAYER_MODE then addbutton(self, container, doer, "exchangebutton2hm", widget.exchangebtninfo2hm) end
                else
                    if hasmultisortbtn and widget.multisortbtninfo2hm then
                        addbutton(self, container, doer, "multisortbutton2hm", widget.multisortbtninfo2hm)
                    end
                    if hascollectbutton and widget.collectbtninfo2hm then
                        addbutton(self, container, doer, "collectbutton2hm", widget.collectbtninfo2hm)
                    end
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

-- [[[[[道具/制作栏快捷存取]]]]
if itemscfg then
    local collectrecipefn
    if craftmenucollectsupport or hasitemscollect then
        -- 后面的doer和item都是可选的,主要用于ctrl alt右键道具收集道具
        collectrecipefn = function(inst, recipe_type, neednum, doer, item)
            if not recipe_type or recipe_type == "" or
                not ((inst.components.inventory and inst.components.inventory.maxslots > 0) or
                    (inst.components.container and inst.components.container.numslots > 0)) then return end
            local inventory = inst.components.inventory
            if doer and doer:IsValid() and doer.components.inventory then inventory = doer.components.inventory end
            if inventory == nil then return end
            -- 记录要收集的实体名和目标数目,各实体堆叠时欠缺的数目(也可能是无限),剩余格子数目
            local data = {}
            data.neednum = neednum
            if data.neednum == false then data.neednum = nil end
            data.prefabs = {recipe_type}
            if item and item:IsValid() and item.prefab then
                if item.dryseeds2hm then -- 干种子
                    data.prefabs = nil
                    data.prefabfn = function(v) return v.dryseeds2hm ~= nil end
                elseif item.components.yotb_skinunlocker ~= nil then -- 宠物皮肤蓝图
                    data.prefabs = nil
                    data.prefabfn = function(v) return v.components.yotb_skinunlocker ~= nil end
                elseif item.nameoverride == "redpouch" then -- 红包
                    data.prefabs = nil
                    data.prefabfn = function(v) return v.prefab == "redpouch" or v.nameoverride == "redpouch" end
                elseif item:HasTag("halloween_ornament") then -- 万圣节装饰
                    data.prefabs = nil
                    data.prefabfn = function(v) return v:HasTag("halloween_ornament") end
                elseif item:HasTag("wintersfeastfood") then -- 圣诞零食
                    data.prefabs = nil
                    data.prefabfn = function(v) return v:HasTag("wintersfeastfood") end
                elseif item:HasTag("winter_ornament") then
                    if item.nameoverride == "winter_ornament" then -- 圣诞小玩意
                        data.prefabs = nil
                        data.prefabfn = function(v) return v.nameoverride == "winter_ornament" and v:HasTag("winter_ornament") end
                    elseif item:HasTag("lightbattery") then -- 圣诞灯
                        data.prefabs = nil
                        data.prefabfn = function(v) return v:HasTag("winter_ornament") and v:HasTag("lightbattery") end
                    elseif item.nameoverride ~= nil then -- 圣诞装饰
                        data.prefabs = nil
                        data.prefabfn = function(v)
                            return v.nameoverride ~= nil and v.nameoverride ~= "winter_ornament" and v:HasTag("winter_ornament") and
                                       not v:HasTag("lightbattery")
                        end
                    end
                elseif string.find(item.prefab, "trinket") then -- 玩具
                    data.prefabs = nil
                    data.prefabfn = function(v) return v.prefab ~= nil and string.find(v.prefab, "trinket") end
                end
            end
            -- 物品栏或容器空间检测
            if inst.components.inventory then
                local isfull = getcontainerspace(inst, inst.components.inventory, data, false)
                if isfull then
                    local overflow = inst.components.inventory:GetOverflowContainer()
                    if overflow and overflow.itemtestfn == nil then
                        isfull = getcontainerspace(inst, overflow, data, false)
                        if isfull then
                            data.leftnumslots = data.leftnumslots + 1
                            local activeitem = inventory.activeitem
                            if activeitem ~= nil and activeitem:IsValid() then
                                data.leftnumslots = data.leftnumslots - 1
                                if (data.prefabfn and data.prefabfn(activeitem) or (data.prefabs and table.contains(data.prefabs, activeitem.prefab))) and
                                    activeitem.components.stackable then
                                    if activeitem.components.stackable.maxsize == math.huge then
                                        data.infiniteprefabs[activeitem.prefab] = true
                                        if data.lacksize[activeitem.prefab] then data.lacksize[activeitem.prefab] = nil end
                                        isfull = nil
                                    elseif activeitem.components.stackable.stacksize < activeitem.components.stackable.maxsize then
                                        data.lacksize[activeitem.prefab] = (data.lacksize[activeitem.prefab] or 0) + activeitem.components.stackable.maxsize -
                                                                               activeitem.components.stackable.stacksize
                                        isfull = nil
                                    end
                                end
                            end
                        end
                    end
                end
                if isfull then
                    if inst.components.talker then
                        inst.components.talker:Say(GetActionFailString(inst, "STORE") or (TUNING.isCh2hm and ("已经拿不下了") or ("Inventory full.")))
                    end
                    return
                end
            elseif inst.components.container then
                if getcontainerspace(inst, inst.components.container, data, false) then
                    if doer and doer:IsValid() and doer.components.talker then
                        doer.components.talker:Say(GetActionFailString(inst, "STORE") or (TUNING.isCh2hm and ("已经放不下了") or ("Inventory full.")))
                    end
                    return
                end
            end
            data.fastresult = data.prefabs ~= nil
            if data.prefabs == nil then
                data.neednum = nil
            elseif data.infiniteprefabs ~= nil then
                data.lacksize[recipe_type] = data.neednum
                data.infiniteprefabs = nil
            elseif data.lacksize[recipe_type] == 0 then
                data.lacksize[recipe_type] = nil
            elseif not data.neednum then
                data.neednum = data.lacksize[recipe_type]
            end
            -- 记录要收集道具的来源容器列表
            local ents = {}
            data.proxyents = {}
            local x, y, z = inst.Transform:GetWorldPosition()
            local platform = inst:GetCurrentPlatform()
            local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
            for i, v in ipairs(nearents) do
                if v ~= inst and v:IsValid() and not v.dcs2hm then
                    if v.components.container_proxy and v.components.container_proxy:CanBeOpened() and not v.components.container and
                        not table.contains(collectblacklist, v.prefab) and v:GetCurrentPlatform() == platform then
                        local master = v.components.container_proxy.master
                        if master and master:IsValid() and not data.proxyents[master] and master.components.container and
                            master.components.container.canbeopened then
                            master.currentpocket2hm = v
                            data.proxyents[master] = v
                            table.insert(ents, master)
                            findcontainersincontainer(master, ents)
                        end
                    elseif v.components.container and v.components.container.canbeopened and v.components.container.acceptsstacks and
                        (not v.components.inventoryitem or v:HasTag("heavy")) and not inventory.opencontainers[v] and
                        not table.contains(collectblacklist, v.prefab) and v:GetCurrentPlatform() == platform then
                        table.insert(ents, v)
                        findcontainersincontainer(v, ents)
                    end
                end
            end
            if inst.components.rider and inst.components.rider.mount and inst.components.rider.mount:IsValid() and
                inst.components.rider.mount.components.container then table.insert(ents, inst.components.rider.mount) end
            if #ents <= 0 then return end
            local tmpents = {}
            for i, v in ipairs(ents) do
                table.insert(tmpents, v)
                if v.virtchest and v.virtchest:IsValid() and v.virtchest.components.container then
                    if not v.virtchest.virtfrom2hm then v.virtchest.virtfrom2hm = v end
                    table.insert(tmpents, v.virtchest)
                end
            end
            -- 进行收集道具操作
            data.currplayer2hm = doer or inst
            collectcontainers(inst, inst.components.inventory or inst.components.container, data, tmpents)
            -- 实际可以反馈结果
        end
    end
    -- 制作栏快速收集
    if craftmenucollectsupport then
        AddModRPCHandler("MOD_HARDMODE", "collectrecipetypebtn2hm", collectrecipefn)
        local function collectrecipeclientfn(doer, recipe_type, neednum)
            if not recipe_type or recipe_type == "" or type(recipe_type) ~= "string" then return end
            if doer.components.inventory ~= nil and not doer:HasTag("playerghost") and doer.components.inventory.isvisible then
                collectrecipefn(doer or ThePlayer, recipe_type, neednum)
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
        -- local function collect_recipe_type(recipe_type) if ThePlayer and recipe_type and recipe_type ~= "" then collectrecipeclientfn(ThePlayer, recipe_type) end end
        -- 收集指定素材，且至多收集一组
        AddClassPostConstruct("widgets/ingredientui",
                              function(self, atlas, image, num_need, num_found, has_enough, name, owner, recipe_type, quant_text_scale, ingredient_recipe, ...)
            if self.recipe_type and num_need and num_found and not IsCharacterIngredient(self.recipe_type) then
                self.onrightclick2hm = function()
                    collectrecipeclientfn(self.owner or ThePlayer, self.recipe_type, not has_enough and
                                              ((num_need * (self.parent and self.parent.parent and self.parent.parent.quantity or 1) - num_found)))
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
                        collectrecipeclientfn(self.owner or ThePlayer, prefab)
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
                                collectrecipeclientfn(self.owner or ThePlayer, recipe.product or recipe.name)
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
    -- 快速收集道具(需要支持收集相同类型的道具)
    if hasitemscollect then
        local collectaction = Action({})
        collectaction.priority = ACTIONS.LOOKAT.priority - 0.5
        collectaction.id = "COLLECT2HM"
        collectaction.str = TUNING.isCh2hm and "收集" or "Collect"
        collectaction.rmb = true
        collectaction.instant = true
        collectaction.mount_valid = true
        collectaction.fn = function(act)
            if not (act.invobject and act.invobject:IsValid() and act.invobject.prefab and act.invobject.components.inventoryitem and
                act.invobject.components.inventoryitem.owner) then return end
            local owner = act.invobject.components.inventoryitem.owner
            if owner and owner:IsValid() and (owner.components.container or owner.components.inventory) then
                local neednum = 1
                if act.invobject.components.stackable then
                    local slotsize = act.invobject.components.stackable.originalmaxsize or act.invobject.components.stackable.maxsize
                    if slotsize and act.invobject.components.stackable.stacksize < slotsize then
                        neednum = slotsize - act.invobject.components.stackable.stacksize
                    else
                        neednum = slotsize or 1
                    end
                end
                collectrecipefn(owner, act.invobject.prefab, neednum, act.doer, act.invobject)
                -- 实际可以反馈收集结果
                return true
            end
        end
        AddAction(collectaction)
    end
    -- 快速存放道具
    if hasitemsstore then
        local storeaction = Action({})
        storeaction.priority = ACTIONS.LOOKAT.priority - 0.5
        storeaction.id = "STORE2HM"
        storeaction.str = STRINGS.ACTIONS.STORE
        storeaction.rmb = true
        storeaction.instant = true
        storeaction.mount_valid = true
        local function openvirtchest(ent, inst)
            if ent.virtchest and ent.virtchest:IsValid() and ent.virtchest.components.container and ent.components.container.opencount == 0 then
                local self = ent.virtchest.components.container
                self.ignoreoverstacked = true
                ent.components.container.ignoresound = true
                for slot, _ in pairs(self.slots) do
                    local item = self:RemoveItemBySlot(slot)
                    if item ~= nil then ent.components.container:GiveItem(item, slot) end
                end
                ent.components.container.ignoresound = false
                self.ignoreoverstacked = false
            end
        end
        local function processstoreincontainers(invobject, ents, proxyents, inst, src_pos, isstackable)
            -- 优先存放在当前打开的容器
            local toremove = {}
            for i, ent in ipairs(ents) do
                if inst.components.inventory.opencontainers[ent] then
                    if ent.components.container:GiveItem(invobject, nil, src_pos, false) then
                        delayshowmovefx(ent)
                        return true
                    else
                        table.insert(toremove, i)
                    end
                end
            end
            for _, i in ipairs(toremove) do table.remove(ents, i) end
            toremove = {}
            -- 优先存放在已有此道具的容器,全图唯一容器更加优先
            for master, v in pairs(proxyents) do
                local hasitem, oldnum = master.components.container:Has(invobject.prefab, 1)
                if hasitem then
                    if master.components.container:GiveItem(invobject, nil, src_pos, false) then
                        delayshowmovefx(v)
                        return true
                    elseif invobject and invobject:IsValid() then
                        local nowhas, newnum = master.components.container:Has(invobject.prefab, 1)
                        if newnum > oldnum then delayshowmovefx(v) end
                    end
                end
            end
            for i, ent in ipairs(ents) do
                local oldhas, oldnum = ent.components.container:Has(invobject.prefab, 1)
                if not oldhas and ent.virtchest and ent.virtchest:IsValid() and ent.virtchest.components.container then
                    local virthas, virtnum = ent.virtchest.components.container:Has(invobject.prefab, 1)
                    oldhas = virthas
                    oldnum = oldnum + virtnum
                end
                if oldhas then
                    openvirtchest(ent, inst)
                    if isstackable then
                        if ent.components.container:GiveItem(invobject, nil, src_pos, false) then
                            delayshowmovefx(ent)
                            return true
                        else
                            if invobject and invobject:IsValid() then
                                local newhas, newnum = ent.components.container:Has(invobject.prefab, 1)
                                if newnum > oldnum then delayshowmovefx(ent) end
                            end
                        end
                    elseif ent.components.container:GiveItem(invobject, nil, src_pos, false) then
                        delayshowmovefx(ent)
                        return true
                    end
                    table.insert(toremove, i)
                end
            end
            for _, i in ipairs(toremove) do table.remove(ents, i) end
            -- 优先存放在有存放道具限制的容器
            local tmpentsindex = {}
            local itemtestfnents = {}
            for i, ent in ipairs(ents) do
                if ent.components.container.itemtestfn ~= nil then
                    table.insert(itemtestfnents, ent)
                    tmpentsindex[ent] = i
                end
            end
            if #itemtestfnents > 0 then
                table.sort(itemtestfnents, function(a, b)
                    if not (a and b and a.prefab and b.prefab and tmpentsindex[a] and tmpentsindex[b]) then return false end
                    if prioritystoreents[a.prefab] and prioritystoreents[b.prefab] then
                        if prioritystoreents[a.prefab] == prioritystoreents[b.prefab] then return tmpentsindex[a] < tmpentsindex[b] end
                        return prioritystoreents[a.prefab] < prioritystoreents[b.prefab]
                    end
                    return tmpentsindex[a] < tmpentsindex[b]
                end)
                for _, ent in ipairs(itemtestfnents) do
                    openvirtchest(ent, inst)
                    if ent.components.container:GiveItem(invobject, nil, src_pos, false) then
                        delayshowmovefx(ent)
                        return true
                    else
                        table.remove(ents, i)
                    end
                end
            end
            -- 普通容器
            for _, ent in ipairs(ents) do
                if ent.components.container.itemtestfn == nil then
                    openvirtchest(ent, inst)
                    if ent.components.container:GiveItem(invobject, nil, src_pos, false) then
                        delayshowmovefx(ent)
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
            local owner = act.invobject.components.inventoryitem.owner
            local prevcontainer = owner and (owner.components.container or owner.components.inventory)
            if not prevcontainer then return end
            -- 记录要存放道具的目的容器列表
            local isstackable = act.invobject.components.stackable ~= nil
            local isbigsize = isstackable and
                                  (act.invobject.components.stackable.stacksize >
                                      (act.invobject.components.stackable.originalmaxsize or act.invobject.components.stackable.maxsize))
            local src_pos = inst:GetPosition()
            local ents = {}
            local proxyents = {}
            if inst.components.rider and inst.components.rider.mount and inst.components.rider.mount:IsValid() and
                inst.components.rider.mount.components.container and inst.components.rider.mount ~= owner and
                inst.components.rider.mount.components.container.canbeopened then table.insert(ents, inst.components.rider.mount) end
            local x, y, z = inst.Transform:GetWorldPosition()
            local platform = inst:GetCurrentPlatform()
            local nearents = TheSim:FindEntities(x, y, z, 30, nil, GROUND_CONTAINER_CANT_TAGS)
            for i, v in ipairs(nearents) do
                if v:IsValid() and v ~= owner and not v.dcs2hm then
                    if isstackable and v.components.container_proxy and v.components.container_proxy:CanBeOpened() and not v.components.container and
                        not v.components.locomotor and not table.contains(storeblacklist, v.prefab) and v:GetCurrentPlatform() == platform then
                        local master = v.components.container_proxy.master
                        if master and master:IsValid() and master ~= owner and not proxyents[master] and master.components.container and
                            master.components.container.canbeopened and not master.components.container.usespecificslotsforitems and
                            master.components.container.acceptsstacks and (not isbigsize or master.components.container.infinitestacksize) and
                            master.components.container:CanTakeItemInSlot(act.invobject) then
                            proxyents[master] = v
                            master.currentpocket2hm = v
                        end
                    elseif v.components.container and (isstackable or not v.components.container.infinitestacksize) and
                        (not isbigsize or v.components.container.infinitestacksize) and (not v.components.inventoryitem or v:HasTag("heavy")) and
                        not v.components.health and not v.components.locomotor and not v.components.stewer and v.components.container.canbeopened and
                        not v.components.container.usespecificslotsforitems and v.components.container.acceptsstacks and v.components.container.type == "chest" and
                        v.components.container.numslots >= 9 and not table.contains(storeblacklist, v.prefab) and v:GetCurrentPlatform() == platform and
                        v.components.container:CanTakeItemInSlot(act.invobject) then
                        table.insert(ents, v)
                    end
                end
            end
            if #ents <= 0 and IsTableEmpty(proxyents) then return end
            local prevslot = act.invobject.components.inventoryitem:GetSlotNum()
            -- 进行存放道具操作
            act.invobject.components.inventoryitem:RemoveFromOwner(true)
            act.invobject.prevplayer2hm = inst
            local result = processstoreincontainers(act.invobject, ents, proxyents, inst, src_pos, isstackable)
            -- 存放完成数据修正,和失败检查
            if act.invobject:IsValid() then
                act.invobject.prevplayer2hm = nil
                if act.invobject.components.inventoryitem.owner == nil then prevcontainer:GiveItem(act.invobject, prevslot) end
            end
            return result
        end
        AddAction(storeaction)
    end
    if hasitemscollect or hasitemsstore then
        AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, actions)
            if inst.prefab and not table.contains(itemsblacklist, inst.prefab) and inst.replica.inventoryitem ~= nil and
                not inst.replica.inventoryitem:CanOnlyGoInPocket() and doer and not (doer.replica.inventory and doer.replica.inventory:GetActiveItem() == inst) and
                not (inst.replica.equippable and inst.replica.equippable:IsEquipped()) then
                if hasitemscollect then table.insert(actions, ACTIONS.COLLECT2HM) end
                if hasitemsstore then table.insert(actions, ACTIONS.STORE2HM) end
            end
        end)
        AddComponentPostInit("playeractionpicker", function(self)
            local oldGetInventoryActions = self.GetInventoryActions
            self.GetInventoryActions = function(self, ...)
                if self.inst and self.inst.components.playercontroller and self.inst.components.playercontroller:IsControlPressed(CONTROL_FORCE_STACK) then
                    if self.inst.components.playercontroller:IsControlPressed(CONTROL_FORCE_INSPECT) then
                        if hasitemscollect then ACTIONS.COLLECT2HM.priority = 11 end
                    elseif hasitemsstore then
                        ACTIONS.STORE2HM.priority = 11
                    end
                end
                local res = oldGetInventoryActions(self, ...)
                if hasitemscollect and ACTIONS.COLLECT2HM.priority == 11 then ACTIONS.COLLECT2HM.priority = ACTIONS.LOOKAT.priority - 0.5 end
                if hasitemsstore and ACTIONS.STORE2HM.priority == 11 then ACTIONS.STORE2HM.priority = ACTIONS.LOOKAT.priority - 0.5 end
                return res
            end
        end)
    end
end

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

-- 容器存取轨迹补丁
local clientitemtransferimage2hmdist = 36 * 36
local function clientitemtransferimage2hm(img, atlas, x, y, z, prevcontainer, prevslot, _x, _y, _z, currcontainer, currslot, userid, iscollectact)
    if ThePlayer and ThePlayer.userid and ThePlayer.HUD and TheFrontEnd and ThePlayer.HUD == TheFrontEnd:GetActiveScreen() and ThePlayer.HUD.controls and
        ThePlayer.HUD.controls.inv and ThePlayer.HUD.controls.containers then
        local controls = ThePlayer.HUD.controls
        -- 自己取出道具,官方已有路径
        -- 自己存放道具,未存放到己已打开容器时,需要添加路径,已添加
        -- 他人取出道具,未从其已打开容器取出时,需要添加路径,已添加
        -- 他人存放道具,未存放到其已打开容器时,需要添加路径,已添加
        local isself = userid == ThePlayer.userid
        local toopen
        local destpos
        if currcontainer then
            if isself and currcontainer == userid then
                toopen = true
                if currslot and controls.inv.inv and controls.inv.inv[currslot] then destpos = controls.inv.inv[currslot]:GetWorldPosition() end
            elseif isself and controls.inv.backpack and controls.inv.backpack:IsValid() and controls.inv.backpack:HasTag(currcontainer) then
                toopen = true
                if currslot and controls.inv.backpackinv and controls.inv.backpackinv[currslot] then
                    destpos = controls.inv.backpackinv[currslot]:GetWorldPosition()
                end
            else
                for container, containerwidget in pairs(controls.containers) do
                    if container and container:IsValid() and container:HasTag(currcontainer) then
                        toopen = true
                        if containerwidget and containerwidget.inv and containerwidget.inv[currslot] then
                            destpos = containerwidget.inv[currslot]:GetWorldPosition()
                        end
                        break
                    end
                end
            end
        end
        -- toopen说明已存在官方路径
        if toopen then return end
        local fromopen
        local startpos
        if prevcontainer then
            if isself and prevcontainer == userid then
                fromopen = true
                if prevslot and controls.inv.inv and controls.inv.inv[prevslot] then startpos = controls.inv.inv[prevslot]:GetWorldPosition() end
            elseif isself and controls.inv.backpack and controls.inv.backpack:IsValid() and controls.inv.backpack:HasTag(prevcontainer) then
                fromopen = true
                if prevslot and controls.inv.backpackinv and controls.inv.backpackinv[prevslot] then
                    startpos = controls.inv.backpackinv[prevslot]:GetWorldPosition()
                end
            else
                for container, containerwidget in pairs(controls.containers) do
                    if container and container:IsValid() and container:HasTag(prevcontainer) then
                        fromopen = true
                        if containerwidget and containerwidget.inv and containerwidget.inv[prevslot] then
                            startpos = containerwidget.inv[prevslot]:GetWorldPosition()
                        end
                        break
                    end
                end
            end
        end
        startpos = startpos or Vector3(TheSim:GetScreenPos(x, y, z))
        destpos = destpos or Vector3(TheSim:GetScreenPos(_x, _y, _z))
        local im = Image(atlas, img)
        im:MoveTo(startpos, destpos, .3, function() im:Kill() end)
    end
end
AddClientModRPCHandler("MOD_HARDMODE", "itemtransferimage2hm", clientitemtransferimage2hm)
local function cancelitemtransferimagetask2hm(inst) inst.itemtransferimagetask2hm = nil end
local function canceldisablefxtask2hm(inst) inst.disablecsfxtask2hm = nil end
local function onitemget(inst, data)
    -- inst是目的容器,src是来源容器,仅在快捷存取时额外显示路径
    if not POPULATING and data and data.src_pos and data.item and data.item:IsValid() and data.item.replica and data.item.replica.inventoryitem and
        (data.item.prevplayer2hm or data.item.currplayer2hm) and not inst.itemtransferimagetask2hm then
        -- 同一容器同时进行多次存放,说明是拆分存放,只需要显示第一次存放的路径
        inst.itemtransferimagetask2hm = inst:DoTaskInTime(0, cancelitemtransferimagetask2hm)
        local actplayer = data.item.prevplayer2hm or data.item.currplayer2hm
        if not (actplayer:IsValid() and actplayer.userid) then return end
        local src = data.item.prevcontainer and data.item.prevcontainer.inst or data.item.prevplayer2hm
        if not src then return end -- 理论上不可能出现src为空的情况
        local iscollectact = data.item.currplayer2hm ~= nil
        local atlas = data.item.replica.inventoryitem:GetAtlas()
        local img = data.item.replica.inventoryitem:GetImage()
        if not (img and atlas) then return end
        local x, y, z = data.src_pos:Get()
        if x == 0 and z == 0 then
            local prevfinalowner = getfinalowner(src)
            if prevfinalowner.currentpocket2hm and prevfinalowner.currentpocket2hm:IsValid() and prevfinalowner:HasTag("pocketdimension_container") then
                prevfinalowner = prevfinalowner.currentpocket2hm
            end
            x, y, z = prevfinalowner.Transform:GetWorldPosition()
        end
        local _x, _y, _z = inst.Transform:GetWorldPosition()
        if _x == 0 and _z == 0 then
            local currfinalowner = getfinalowner(inst)
            if currfinalowner.currentpocket2hm and currfinalowner.currentpocket2hm:IsValid() and currfinalowner:HasTag("pocketdimension_container") then
                currfinalowner = currfinalowner.currentpocket2hm
            end
            _x, _y, _z = currfinalowner.Transform:GetWorldPosition()
        end
        -- 来源容器ID,目标容器ID,取放操作的玩家ID
        local prevcontainer = src.userid or src.GUID
        local currcontainer = inst.userid or inst.GUID
        local userid = actplayer.userid
        local rpc = GetClientModRPC("MOD_HARDMODE", "itemtransferimage2hm")
        -- 尝试通知符合条件的所有玩家显示该路径
        for index, player in ipairs(AllPlayers) do
            if player and player:IsValid() and player.userid then
                local isself = player.userid == userid
                -- 进行快捷取出操作的玩家不需要显示该路径
                -- 已打开目的容器的玩家不需要显示该路径
                -- 一定距离外的他人不需要显示该路径
                if not (iscollectact and isself) and not (inst.components.container and inst.components.container.openlist[player]) and
                    (isself or player:GetDistanceSqToPoint(x, y, z) < clientitemtransferimage2hmdist or player:GetDistanceSqToPoint(_x, _y, _z) <
                        clientitemtransferimage2hmdist) then
                    -- 客户端玩家不需要发rpc
                    if TheNet:GetIsClient() and ThePlayer == player then
                        clientitemtransferimage2hm(img, atlas, x, y, z, prevcontainer, data.item.prevslot, _x, _y, _z, currcontainer, data and data.slot,
                                                   userid, iscollectact)
                    else
                        SendModRPCToClient(rpc, player.userid, img, atlas, x, y, z, prevcontainer, data.item.prevslot, _x, _y, _z, currcontainer,
                                           data and data.slot, userid, iscollectact)
                    end
                end
            end
        end
    end
end
-- 每个容器都加了一个自己的GUID标签,以方便本模组找到服务器容器对应的客户端容器;道具存放信号
AddComponentPostInit("container", function(self)
    if not self.inst.ctfi2hm and self.inst.GUID then
        self.inst.ctfi2hm = true
        self.inst:AddTag(self.inst.GUID)
        self.inst:ListenForEvent("itemget", onitemget)
    end
end)
AddComponentPostInit("inventory", function(self) if self.inst:HasTag("player") then self.inst:ListenForEvent("itemget", onitemget) end end)
AddComponentPostInit("stackable", function(self)
    local Put = self.Put
    self.Put = function(self, item, src_pos, ...)
        if item ~= self and src_pos and self.inst and self.inst.components.inventoryitem and self.inst.components.inventoryitem.owner then
            onitemget(self.inst.components.inventoryitem.owner, {item = item, src_pos = src_pos})
        end
        return Put(self, item, src_pos, ...)
    end
end)
