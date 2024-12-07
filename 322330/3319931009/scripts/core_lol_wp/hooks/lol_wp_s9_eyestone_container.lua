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