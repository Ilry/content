--[[ 
-- EQUIPSLOT 前缀
local slotprefix = string.upper('lol_wp_s9_eyestone'..'_slot_')

-- 特殊容器的最大容量
local MAX_EYESTONE_SIZE = 6

-- 增加EQUIPSLOT
for i = 1,MAX_EYESTONE_SIZE do
    EQUIPSLOTS[slotprefix..i] = slotprefix..i
end

-- 设置能进容器的amulet,并将初始化后的替身物品和原物品进行数据同步
---@type table<string, boolean|fun(orig_itm:ent,fake_itm:ent):ent>
local RULES  = {
    lol_wp_s7_tearsofgoddess = function (orig_itm,fake_itm)
        local val = orig_itm.components.lol_wp_s7_tearsofgoddess and orig_itm.components.lol_wp_s7_tearsofgoddess.val
        if val then
            if fake_itm.components.lol_wp_s7_tearsofgoddess then
                fake_itm.components.lol_wp_s7_tearsofgoddess.val = val
            end
        end
        return fake_itm
    end,
}

-- 设置能进容器
for k,_ in pairs(RULES) do
    AddPrefabPostInit(k, function(inst)
        inst:AddTag('lol_wp_s9_eyestone_confirm_amulet')
    end)
end

-- 具有特殊功能的容器
local eyestone_containers = {
    lol_wp_s9_eyestone_low = true,
    -- lol_wp_s9_eyestone_high = true,
}

-- 当amulet放进特殊容器中,会添加tag,加上这个前缀
local tagprefix = 'lol_wp_s9_eyestone_'

---初始化替身装备的函数
---@param prefab string
---@param slot number
---@return ent fake_itm # 替身装备
---@nodiscard
local function genFakeEquip(prefab,slot)
    local fake_itm = SpawnPrefab(prefab)
    -- 更改槽位
    if fake_itm.components.equippable then
        fake_itm.components.equippable.equipslot = EQUIPSLOTS[slotprefix..slot]
    end
    -- 掉落时移除
    fake_itm:ListenForEvent('ondropped', fake_itm.Remove)
    -- 保存时删除,因为读取时itemget会触发再生成一个
    fake_itm.persists = false
    return fake_itm
end

---卸下并移除替身装备
---@param player ent
---@param slot_no number # 特殊容器槽位的编号
local function unequipAndRemove(player,slot_no)
    if player and player.components.inventory then
        local fake_itm = player.components.inventory:Unequip(EQUIPSLOTS[slotprefix..slot_no])
        if fake_itm ~= nil and fake_itm:IsValid() then
            -- player.components.inventory:GiveItem(fake_itm, nil, player:GetPosition())
            fake_itm:Remove()
        end
    end
end

---装备替身装备
---@param player ent
---@param fake_itm ent
local function equipFake(player,fake_itm)
    if player and player.components.inventory then
        player.components.inventory:Equip(fake_itm)
    end
end

---初始化替身装备并同步并装备
---@param slot_no number
---@param orig_itm ent
---@param player ent
local function initFakeAndSyncAndEquip(slot_no,orig_itm,player)
    local itm_prefab = orig_itm.prefab
    -- 初始化替身装备
    local fake_itm = genFakeEquip(itm_prefab,slot_no)
    -- 获取同步数据的函数
    local fix_fn = RULES[itm_prefab]
    if fix_fn and type(fix_fn) == 'function' then
        -- 同步数据
        fake_itm = fix_fn(orig_itm,fake_itm)
    end
    -- 装备替身装备
    equipFake(player,fake_itm)
end

-- 对所有有特殊容器功能的eyestone 做处理
for eyestone,_ in pairs(eyestone_containers) do
    AddPrefabPostInit(eyestone, function(inst)
        if not TheWorld.ismastersim then
            return inst
        end
        -- 读存时还会触发,所以不用存了
        inst:ListenForEvent('itemget', function (inst,data)
            local itm = data and data.item
            local itm_prefab = itm and itm.prefab
            local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
            if itm_prefab then
                -- 添加tag以保证放进容器的相同的amulet只能有一个
                inst:AddTag(tagprefix..itm_prefab)

                local slot_no = data.slot
                if slot_no and owner and owner:HasTag("player") then
                    initFakeAndSyncAndEquip(slot_no,itm,owner)
                end
            end
            -- 为了不让新装备的护符显示出来,这里重新覆盖通道
            if owner and owner:HasTag("player") then
                owner.AnimState:OverrideSymbol("swap_body", "torso_"..inst.prefab, inst.prefab)
            end
        end)
        inst:ListenForEvent('itemlose',function (inst,data)
            local itm = data and data.prev_item
            local itm_prefab = itm and itm.prefab
            if itm_prefab then
                inst:RemoveTag(tagprefix..itm_prefab)

                local slot_no = data.slot
                local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
                if slot_no and owner and owner:HasTag("player") then
                    -- 移除替身装备
                    unequipAndRemove(owner,slot_no)
                end

            end
        end)

        -- 取下eyestone,会让所有amulet失效
        if inst.components.inventoryitem then
            local old_OnDropped = inst.components.inventoryitem.OnDropped
            function inst.components.inventoryitem:OnDropped(...)
                local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
                if owner and owner.components.inventory then
                    for i = 1,MAX_EYESTONE_SIZE do
                        unequipAndRemove(owner,i)
                    end
                end
                return old_OnDropped(self,...)
            end
        end

        -- 装上eyestone,让所有amulet重新生效
        if inst.components.equippable then
            local old_onequipfn = inst.components.equippable.onequipfn
            inst.components.equippable.onequipfn = function(self,owner,...)
                local slots = inst.components.container and inst.components.container.slots
                if slots then
                    for slot_no, itm in pairs(slots) do
                        initFakeAndSyncAndEquip(slot_no,itm,owner)
                    end
                end
                return old_onequipfn ~= nil and old_onequipfn(self,owner,...)
            end
        end
    end)
end
]]


-- 写完才发现,有个好笑的问题: 替身物品的耐久之类的数据变动没法实时映射到原物品上...



-- local Widget = require "widgets/widget"

-- -- EQUIPSLOT 前缀
-- local slotprefix = string.upper('lol_wp_s9_eyestone'..'_slot_')

-- -- 特殊容器的最大容量
-- local MAX_EYESTONE_SIZE = 6

-- -- 增加EQUIPSLOT
-- for i = 1,MAX_EYESTONE_SIZE do
--     EQUIPSLOTS[slotprefix..i] = slotprefix..i
-- end

-- TUNING.EYESTONE_SLOTS_MAP = {}
-- for i = 1,MAX_EYESTONE_SIZE do
--     TUNING.EYESTONE_SLOTS_MAP[slotprefix..i] = i
-- end

-- TUNING.EYESTONE_SLOTS = {}

-- AddClassPostConstruct('widgets/equipslot',function (self,equipslot,...)
--     if TUNING.EYESTONE_SLOTS_MAP[equipslot] then
--         TUNING.EYESTONE_SLOTS[TUNING.EYESTONE_SLOTS_MAP[equipslot]] = self
--     end
-- end)

-- AddClassPostConstruct('widgets/inventorybar',function (self)
--     -- hash map
--     self.eyestone_slots_map = {}

--     self.eyestone_slots = {}
--     for i = 1,MAX_EYESTONE_SIZE do
--         self:AddEquipSlot(EQUIPSLOTS[slotprefix..i], "images/hud.xml", "inv_slot.tex")

--         self.eyestone_slots[i] = self.root:AddChild(Widget("eyestone_slot_"..i))
--         self.eyestone_slots[i]:SetScale(1.5,1.5)

--         self.eyestone_slots_map[slotprefix..i] = i -- 映射
--     end
--     -- 

--     -- 更新位置
--     function self:UpdateEyeStonePos()
--         for k, v in ipairs(self.equipslotinfo) do
--             if v.slot then
--                 local index = self.eyestone_slots_map[v.slot]
--                 if index then
--                     local x = 200 + ((index-1) % 3) * 78
--                     local y = 40 + (math.ceil(index / (MAX_EYESTONE_SIZE/2)) - 1) * 78
--                     -- self.eyestone_slots[index]:SetPosition(x, y, 100)
--                     TUNING.EYESTONE_SLOTS[index]:SetPosition(x, y, 0)
--                 end
--             end
--         end
--     end

--     LOLWP_S:hookFn(self,'Rebuild',nil,self.UpdateEyeStonePos)

-- end)

-- 考虑到布局冲突 和不可预测的情况 也否决了


--------------------------------------------------------------------------------

-- memo

--[[ 

## tag:

tagprefix..itm_prefab : 眼石会有这个tag
lol_wp_s9_eyestone_confirm_amulet : 所有能放进眼石的物品都有
is_in_lol_wp_eyestone : 在眼石中物品都有
is_in_lol_wp_eyestone_also_equip : 在眼石中物品并且眼石是装备状态的都有
lol_wp_eyestone : 所有眼石都有
-- not_valid_in_lol_wp_eyestone : 当物品处于眼石中,当没有这个tag才可以生效, (这个tag在大部分情况下都没有用,因为目前耐久用尽,会移除物品,也许以后会有开关功能之类的)

## component: 

cangoineyestone : 所有能放进眼石的物品都有

## event: 

lol_wp_repair : 耐久修复的物品会推这个事件
lol_wp_runout_durability : 耐久用尽的物品会推这个事件

## attri:

player.eyestone_containers_stuff[itm_prefab_in_eyestone] : 眼石中的唯一装备会被挂到玩家的这个表上,键名为prefab

## methods:

都在全局库LOLWP_U中了

]]
------------------------------
local modid = 'lol_wp'

---将装备从眼石中转移到玩家的inventory中
---@param itm ent
---@param doer ent
local function unequipItemInEyeStone(itm,doer)

    local eyestone = itm.components.inventoryitem and itm.components.inventoryitem.owner
    if eyestone and eyestone.components.container then
        local slot = eyestone.components.container:GetItemSlot(itm)
        -- local unequipped_itm = eyestone.components.container:RemoveItemBySlot(slot)
        eyestone.components.container:DropItem(itm)

        if doer.components.inventory then
            doer.components.inventory:GiveItem(itm, nil, doer:GetPosition())
        end
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- 当amulet放进特殊容器中,会添加tag,加上这个前缀
local tagprefix = 'lol_wp_s9_eyestone_'

---@class eyestone_durability_data
---@field event string
---@field fn fun(inst:ent)

---@class ent
---@field lol_wp_s9_eyestone_container_shadowitem_count integer # 放入眼石中的shadowitem的个数
---@field cangoineyestone fun(inst:ent|nil):boolean # 仅客机: 是否可以放入眼石

---@class eyestone_itm_data
---@field onequip nil|fun(inst:ent,owner:ent)
---@field onunequip nil|fun(inst:ent,owner:ent)
---@field cangoineyestone nil|fun(inst:ent,eyestone:ent|nil):boolean # 特殊判断条件
---@field allevent nil|eyestone_durability_data[] # 事件表
---@field onputin nil|fun(inst:ent,eyestone:ent|nil)
---@field ontakeout nil|fun(inst:ent,eyestone:ent|nil)

---@type table<string,eyestone_itm_data>
local RULES = { -- 设置能进容器的所有amulet
    -- 女神之泪
    lol_wp_s7_tearsofgoddess = {
        onequip = function(inst,owner)
            if inst.components.lol_wp_s7_tearsofgoddess then
                inst.components.lol_wp_s7_tearsofgoddess:WhenEquip(owner)
            end
        end,
        onunequip = function(inst,owner)
            if inst.components.lol_wp_s7_tearsofgoddess then
                inst.components.lol_wp_s7_tearsofgoddess:WhenUnEquip(owner)
            end
        end,
    },
    -- 多兰之戒
    lol_wp_s7_doranring = {
        onequip = function(inst,owner)
            if owner.components.lol_wp_player_dmg_adder then
                local dmg = TUNING.MOD_LOL_WP.DORANRING.PLANAR_DMG_WHEN_EQUIP*TUNING.MOD_LOL_WP.ITEM_EFFECT_RATE_IN_EYESTONE
                owner.components.lol_wp_player_dmg_adder:Modifier(inst,dmg,'lol_wp_s7_doranring','planar')
            end
        end,
        onunequip = function(inst,owner)
            if owner.components.lol_wp_player_dmg_adder then
                owner.components.lol_wp_player_dmg_adder:RemoveModifier(inst,'lol_wp_s7_doranring','planar')
            end
        end,
    },
    -- 三项
    lol_wp_trinity = {
        cangoineyestone = function (inst)
            return inst:HasTag('lol_wp_trinity_type_'..'amulet')
        end,
        onequip = function(inst,owner)
            if inst.components.lol_wp_trinity_data then
                inst.components.lol_wp_trinity_data:onequip(inst,owner)
            end
            local walkspeedmult = inst.components.equippable and inst.components.equippable.walkspeedmult or 1
            if owner.components.locomotor then
                owner.components.locomotor:SetExternalSpeedMultiplier(inst,'lol_wp_trinity_amulet_in_eyestone',walkspeedmult)
            end
        end,
        onunequip = function(inst,owner)
            if inst.components.lol_wp_trinity_data then
                inst.components.lol_wp_trinity_data:onunequip(inst,owner)
            end
            if owner.components.locomotor then
                owner.components.locomotor:RemoveExternalSpeedMultiplier(inst,'lol_wp_trinity_amulet_in_eyestone')
            end
        end,
        allevent = {
            {
                event = 'lol_wp_runout_durability', -- 耐久用尽
                fn = function (inst)
                    -- 如果在眼石中 耗尽耐久 则自动 unequip
                    if inst:HasTag('is_in_lol_wp_eyestone') then
                        inst:AddTag('not_valid_in_lol_wp_eyestone')
                        local player = LOLWP_S:GetOwnerReal(inst)
                        if player then
                            -- 此函数尚存在一个问题 当player不存在, 然后有装备是按时间掉耐久, 那么则移除不了, 咱不处理
                            unequipItemInEyeStone(inst,player)
                        end
                    end
                end
            },
            {
                event = 'lol_wp_repair', -- 耐久修复
                fn = function (inst)
                    if inst:HasTag('not_valid_in_lol_wp_eyestone') then
                        inst:RemoveTag('not_valid_in_lol_wp_eyestone')
                    end
                end
            }
        }
    },
    -- 峡谷制造者 护符形态
    riftmaker_amulet = {
        onequip = function(inst,owner)
            if inst.components.riftmaker_data then
                inst.components.riftmaker_data:onequip(inst,owner)
            end
        end,
        onunequip = function(inst,owner)
            if inst.components.riftmaker_data then
                inst.components.riftmaker_data:onunequip(inst,owner)
            end
        end,
        onputin = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) + 1
                eyestone:AddTag('shadow_item')
            end
        end,
        ontakeout = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) - 1
                if eyestone.lol_wp_s9_eyestone_container_shadowitem_count and eyestone.lol_wp_s9_eyestone_container_shadowitem_count <= 0 then
                    eyestone:RemoveTag('shadow_item')
                    eyestone.lol_wp_s9_eyestone_container_shadowitem_count = 0 -- 重置为0个
                end
            end
        end
    },
    -- 心之刚
    lol_heartsteel = {
        onequip = function (inst, owner)
            if inst.components.lol_heartsteel_data then
                inst.components.lol_heartsteel_data:onequip(inst,owner)
            end
        end,
        onunequip = function(inst,owner)
            if inst.components.lol_heartsteel_data then
                inst.components.lol_heartsteel_data:onunequip(inst,owner)
            end
        end,
    },
    -- 增幅典籍
    lol_wp_s11_amplifyingtome = {
        onequip = function(inst,owner)
            if owner.components.lol_wp_player_dmg_adder then
                local dmg = TUNING.MOD_LOL_WP.AMPLIFYINGTOME.PLANAR_DMG*TUNING.MOD_LOL_WP.ITEM_EFFECT_RATE_IN_EYESTONE
                owner.components.lol_wp_player_dmg_adder:Modifier(inst,dmg,'lol_wp_s11_amplifyingtome','planar')
                owner.components.lol_wp_player_dmg_adder:SetOnHitAlways('lol_wp_s11_amplifyingtome',function(victim)
                    if inst.components.finiteuses then
                       inst.components.finiteuses:Use(1)
                    end
                end)
            end
        end,
        onunequip = function(inst,owner)
            if owner.components.lol_wp_player_dmg_adder then
                owner.components.lol_wp_player_dmg_adder:RemoveModifier(inst,'lol_wp_s11_amplifyingtome','planar')
                owner.components.lol_wp_player_dmg_adder:RemoveOnHitAlways('lol_wp_s11_amplifyingtome')
            end
        end,
    },
    -- 黑暗封印
    lol_wp_s11_darkseal = {
        onequip = function (inst, owner)
            if inst.components.lol_wp_s11_darkseal_num then
                inst.components.lol_wp_s11_darkseal_num:WhenEquip(inst,owner)
            end

            if owner.components.lol_wp_player_dmg_adder then
                local dmg = inst.components.lol_wp_s11_darkseal_num:GetVal() * TUNING.MOD_LOL_WP.DARKSEAL.SKILL_HONOR.EXTRA_PLANAR_DMG_PER_STACK + TUNING.MOD_LOL_WP.DARKSEAL.PLANAR_DMG
                dmg = dmg*TUNING.MOD_LOL_WP.ITEM_EFFECT_RATE_IN_EYESTONE

                owner.components.lol_wp_player_dmg_adder:Modifier(inst,dmg,'lol_wp_s11_darkseal','planar')
            end
        end,
        onunequip = function (inst, owner)
            if inst.components.lol_wp_s11_darkseal_num then
                inst.components.lol_wp_s11_darkseal_num:WhenUnequip(inst,owner)
            end
            if owner.components.lol_wp_player_dmg_adder then
                owner.components.lol_wp_player_dmg_adder:RemoveModifier(inst,'lol_wp_s11_darkseal','planar')
            end
        end,
        cangoineyestone = function (inst, eyestone)
            if eyestone and eyestone:HasTag(tagprefix..'lol_wp_s11_mejaisoulstealer') then
                return false
            end
            return true
        end,
        onputin = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) + 1
                eyestone:AddTag('shadow_item')
            end
        end,
        ontakeout = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) - 1
                if eyestone.lol_wp_s9_eyestone_container_shadowitem_count and eyestone.lol_wp_s9_eyestone_container_shadowitem_count <= 0 then
                    eyestone:RemoveTag('shadow_item')
                    eyestone.lol_wp_s9_eyestone_container_shadowitem_count = 0 -- 重置为0个
                end
            end
        end
    },
    -- 梅贾的窃魂卷
    lol_wp_s11_mejaisoulstealer = {
        onequip = function (inst, owner)
            if inst.components.lol_wp_s11_mejaisoulstealer_num then
                inst.components.lol_wp_s11_mejaisoulstealer_num:WhenEquip(inst,owner)
            end

            if owner.components.lol_wp_player_dmg_adder then
                local dmg = inst.components.lol_wp_s11_mejaisoulstealer_num:GetVal() * TUNING.MOD_LOL_WP.MEJAISOULSTEALER.SKILL_HONOR.EXTRA_PLANAR_DMG_PER_STACK + TUNING.MOD_LOL_WP.MEJAISOULSTEALER.PLANAR_DMG
                dmg = dmg*TUNING.MOD_LOL_WP.ITEM_EFFECT_RATE_IN_EYESTONE
                owner.components.lol_wp_player_dmg_adder:Modifier(inst,dmg,'lol_wp_s11_mejaisoulstealer','planar')
            end
        end,
        onunequip = function (inst, owner)
            if inst.components.lol_wp_s11_mejaisoulstealer_num then
                inst.components.lol_wp_s11_mejaisoulstealer_num:WhenUnequip(inst,owner)
            end

            if owner.components.lol_wp_player_dmg_adder then
                owner.components.lol_wp_player_dmg_adder:RemoveModifier(inst,'lol_wp_s11_mejaisoulstealer','planar')
            end
        end,
        cangoineyestone = function (inst, eyestone)
            if eyestone and eyestone:HasTag(tagprefix..'lol_wp_s11_darkseal') then
                return false
            end
            return true
        end,
        onputin = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) + 1
                eyestone:AddTag('shadow_item')
            end
        end,
        ontakeout = function (inst, eyestone)
            if eyestone then
                eyestone.lol_wp_s9_eyestone_container_shadowitem_count = (eyestone.lol_wp_s9_eyestone_container_shadowitem_count or 0) - 1
                if eyestone.lol_wp_s9_eyestone_container_shadowitem_count and eyestone.lol_wp_s9_eyestone_container_shadowitem_count <= 0 then
                    eyestone:RemoveTag('shadow_item')
                    eyestone.lol_wp_s9_eyestone_container_shadowitem_count = 0 -- 重置为0个
                end
            end
        end
    },
    -- 无尽之力 护符形态
    lol_wp_s13_infinity_edge_amulet = {
        onequip = function (inst, owner)
            if inst.components.lol_wp_s13_infinity_edge_amulet_data then
                inst.components.lol_wp_s13_infinity_edge_amulet_data:WhenEquip(inst, owner)
            end
        end,
        onunequip = function (inst, owner)
            if inst.components.lol_wp_s13_infinity_edge_amulet_data then
                inst.components.lol_wp_s13_infinity_edge_amulet_data:WhenUnequip(inst, owner)
            end
        end,
        allevent = {
            {
                event = 'lol_wp_runout_durability', -- 耐久用尽
                fn = function (inst)
                    -- 如果在眼石中 耗尽耐久 则自动 unequip
                    if inst:HasTag('is_in_lol_wp_eyestone') then
                        inst:AddTag('not_valid_in_lol_wp_eyestone')
                        local player = LOLWP_S:GetOwnerReal(inst)
                        if player then
                            -- 此函数尚存在一个问题 当player不存在, 然后有装备是按时间掉耐久, 那么则移除不了, 咱不处理
                            unequipItemInEyeStone(inst,player)
                        end
                    end
                end
            },
            {
                event = 'lol_wp_repair', -- 耐久修复
                fn = function (inst)
                    if inst:HasTag('not_valid_in_lol_wp_eyestone') then
                        inst:RemoveTag('not_valid_in_lol_wp_eyestone')
                    end
                end
            }
        }
    },
    -- 中娅沙漏
    lol_wp_s15_zhonya = {
        onequip = function (inst, owner)
            if inst.components.lol_wp_s15_zhonya then
                inst.components.lol_wp_s15_zhonya:WhenEquipInEyeStone(inst,owner)
            end
        end,
        onunequip = function (inst, owner)
            if inst.components.lol_wp_s15_zhonya then
                inst.components.lol_wp_s15_zhonya:WhenUnEquipInEyeStone(inst,owner)
            end
        end
    },
    -- 遗失的章节
    lol_wp_s17_lostchapter = {
        onequip = function (inst, owner)
            if inst.components.lol_wp_s17_lostchapter_data then
                inst.components.lol_wp_s17_lostchapter_data:WhenEquip(inst,owner)
            end
        end,
        onunequip = function (inst, owner)
            if inst.components.lol_wp_s17_lostchapter_data then
                inst.components.lol_wp_s17_lostchapter_data:WhenUnequip(inst,owner)
            end
        end
    },
    -- s20 冰霜之心
    lol_wp_s20_frozenheart_armor = {
        onequip = function (inst, owner)
            if owner and owner.components.temperature then
                owner:DoTaskInTime(0,function ()
                    owner.components.temperature:SetTemperature(TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor.skill_wintertouch.temperature)
                end)
            end
            if owner and owner.components.combat then
                owner.components.combat.externaldamagetakenmultipliers:SetModifier('lol_wp_s20_frozenheart_armor',TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor.ABSORB,'lol_wp_s20_frozenheart_armor')
            end

            if owner._fx_lol_wp_s20_frozenheart_armor and owner._fx_lol_wp_s20_frozenheart_armor:IsValid() then
                owner._fx_lol_wp_s20_frozenheart_armor:Remove()
                owner._fx_lol_wp_s20_frozenheart_armor = nil
            end
            if TUNING[string.upper('CONFIG_'..modid..'key_lol_wp_s15_zhonya_freeze')] then
                owner._fx_lol_wp_s20_frozenheart_armor = SpawnPrefab('fx_lol_wp_s20_frozenheart_armor_anim')
                local scale = 1.3
                owner._fx_lol_wp_s20_frozenheart_armor.Transform:SetScale(scale, scale, scale)
                if TUNING[string.upper('CONFIG_'..modid..'fx_radius_adjust')] then
                    owner._fx_lol_wp_s20_frozenheart_armor.entity:SetParent(owner.entity)
                end
                owner._fx_lol_wp_s20_frozenheart_armor.entity:AddFollower()
                owner._fx_lol_wp_s20_frozenheart_armor.Follower:FollowSymbol(owner.GUID, nil, 0, 0, 0)
            end
        end,
        onunequip = function (inst, owner)
            if owner and owner.components.combat then
                owner.components.combat.externaldamagetakenmultipliers:RemoveModifier('lol_wp_s20_frozenheart_armor','lol_wp_s20_frozenheart_armor')
            end

            if owner._fx_lol_wp_s20_frozenheart_armor and owner._fx_lol_wp_s20_frozenheart_armor:IsValid() then
                owner._fx_lol_wp_s20_frozenheart_armor:Remove()
                owner._fx_lol_wp_s20_frozenheart_armor = nil
            end
        end
    }
}

-- 设置能进容器
for k,v in pairs(RULES) do
    AddPrefabPostInit(k, function(inst)
        inst:AddTag('lol_wp_s9_eyestone_confirm_amulet')
        inst.cangoineyestone = v.cangoineyestone
        if not TheWorld.ismastersim then
            return inst
        end
        inst:AddComponent('cangoineyestone')

        -- 监听
        if v.allevent then
            for _,event_data in ipairs(v.allevent) do
                inst:ListenForEvent(event_data.event,event_data.fn)
            end
        end
    end)
end

-- 具有本特殊功能的容器
local eyestone_containers = {
    lol_wp_s9_eyestone_low = true,
    lol_wp_s9_eyestone_high = true,
}

--------------------------------------------------------------------------------
-------------------------------tool---------------------------------------
--------------------------------------------------------------------------------

---装备/卸下amulet,需要触发哪些函数
---@param isequip boolean
---@param itm ent
---@param itm_prefab PrefabID
---@param player ent
---@param container ent
local function switchEquip(isequip,itm,itm_prefab,player,container)
    if isequip then
        -- 在眼石中的物品加上这个tag
        itm:AddTag('is_in_lol_wp_eyestone')
        -- 并且眼石是装备状态中
        if container and container.components.equippable and container.components.equippable:IsEquipped() then
            itm:AddTag('is_in_lol_wp_eyestone_also_equip')
        end
        local onequip = RULES[itm_prefab] and RULES[itm_prefab].onequip
        if onequip then
            onequip(itm,player)
        end
    else
        if itm:HasTag('is_in_lol_wp_eyestone') then
            itm:RemoveTag('is_in_lol_wp_eyestone')
        end
        if itm:HasTag('is_in_lol_wp_eyestone_also_equip') then
            itm:RemoveTag('is_in_lol_wp_eyestone_also_equip')
        end
        local onunequip = RULES[itm_prefab] and RULES[itm_prefab].onunequip
        if onunequip then
            onunequip(itm,player)
        end
    end
end

-- 对所有有特殊容器功能的eyestone 做处理
for eyestone,_ in pairs(eyestone_containers) do
    AddPrefabPostInit(eyestone, function(inst)
        -- 给所有眼石加上这个标签
        inst:AddTag('lol_wp_eyestone')

        if not TheWorld.ismastersim then
            return inst
        end

        -- 给所有眼石加上shadowlevel,初始为0
        inst:AddComponent('shadowlevel')
        inst.components.shadowlevel:SetDefaultLevel(0)

        -- 读存时还会触发,所以不用存tag了
        inst:ListenForEvent('itemget', function (inst,data)
            if data == nil then return end
            ---@type ent
            local itm = data.item
            local itm_prefab = itm and itm.prefab
            local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
            if itm_prefab then
                -- 添加tag以保证放进容器的相同的amulet只能有一个
                inst:AddTag(tagprefix..itm_prefab)

                -- 只有眼石再装备中,放物品进去才会生效
                if inst.components.equippable and inst.components.equippable:IsEquipped() then
                    -- 如果owner存在, 
                    if owner and owner:HasTag('player') then
                        -- 将物品挂到player上,以便在combat中判断和调用
                        ---@class ent
                        ---@field eyestone_containers_stuff table<PrefabID,ent>

                        if owner.eyestone_containers_stuff == nil then
                            owner.eyestone_containers_stuff = {}
                        end
                        owner.eyestone_containers_stuff[itm_prefab] = itm
                        -- 触发需要触发的函数
                        switchEquip(true,itm,itm_prefab,owner,inst)
                    end
                end

                -- 放进眼石时,就会触发这个函数
                local onputin = RULES[itm_prefab] and RULES[itm_prefab].onputin
                if onputin then
                    onputin(itm,inst)
                end
            end
        end)
        inst:ListenForEvent('itemlose',function (inst,data)
            if data == nil then return end
            local itm = data.prev_item
            local itm_prefab = itm and itm.prefab
            local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
            if itm_prefab then
                -- 取出时移除tag
                inst:RemoveTag(tagprefix..itm_prefab)

                -- 如果owner存在
                if owner and owner:HasTag('player') then
                    -- 将物品从player上移除
                    if owner.eyestone_containers_stuff then
                        owner.eyestone_containers_stuff[itm_prefab] = nil
                    end
                    -- 触发需要触发的函数
                    switchEquip(false,itm,itm_prefab,owner,inst)
                end

                -- 移除时 执行这个函数
                local ontakeout = RULES[itm_prefab] and RULES[itm_prefab].ontakeout
                if ontakeout then
                    ontakeout(itm,inst)
                end
            end
        end)

        -- -- 取下eyestone,会让所有amulet失效
        -- if inst.components.inventoryitem then
        --     LOLWP_S:hookFn(inst.components.inventoryitem,'OnDropped',function(self,...)
        --         local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
        --         -- 如果owner存在
        --         if owner and owner:HasTag('player') then
        --             -- 将物品从player上移除,直接将总表置空即可
        --             owner.eyestone_containers_stuff = nil
        --             -- 触发需要触发的函数
        --             local slots = inst.components.container and inst.components.container.slots
        --             for _, itm in pairs(slots or {}) do
        --                 local itm_prefab = itm and itm.prefab
        --                 if itm_prefab then
        --                     switchEquip(false,itm,itm_prefab,owner)
        --                 end
        --             end
        --         end
        --     end)
        -- end


        -- 装上eyestone,让所有amulet重新生效
        if inst.components.equippable then
            LOLWP_S:hookFn(inst.components.equippable,'onequipfn',function (self, owner, ...)
                if not inst.eyestone_special_fn_isequip then

                    if owner.eyestone_containers_stuff == nil then
                        owner.eyestone_containers_stuff = {}
                    end
                    -- 触发需要触发的函数,并 将物品挂到player上,以便在combat中判断和调用
                    local slots = inst.components.container and inst.components.container.slots
                    if slots then
                        for _, itm in pairs(slots) do
                            local itm_prefab = itm and itm.prefab
                            if itm_prefab then
                                -- 将物品挂到player上,以便在combat中判断和调用
                                owner.eyestone_containers_stuff[itm_prefab] = itm
                                -- 触发需要触发的函数
                                switchEquip(true,itm,itm_prefab,owner,inst)
                            end
                        end
                    end

                    inst.eyestone_special_fn_isequip = true
                end
            end)
        end

        -- 取下eyestone,会让所有amulet失效
        if inst.components.inventoryitem then
            LOLWP_S:hookFn(inst.components.equippable,'onunequipfn',function(self,...)

                -- 标记是否装备,避免重复触发
                if inst.eyestone_special_fn_isequip then

                    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
                    -- 如果owner存在
                    if owner and owner:HasTag('player') then
                        -- 将物品从player上移除,直接将总表置空即可
                        owner.eyestone_containers_stuff = nil
                        -- 触发需要触发的函数
                        local slots = inst.components.container and inst.components.container.slots
                        for _, itm in pairs(slots or {}) do
                            local itm_prefab = itm and itm.prefab
                            if itm_prefab then
                                switchEquip(false,itm,itm_prefab,owner,inst)
                            end
                        end
                    end

                    inst.eyestone_special_fn_isequip = false
                end

            end)
        end

    end)
end




