GLOBAL.setmetatable(env, { __index = function(t, k)
    return GLOBAL.rawget(GLOBAL, k)
end })

local STRINGS = GLOBAL.STRINGS
local table_var = GLOBAL.table
local math = GLOBAL.math
local debug = GLOBAL.debug
local require = GLOBAL.require
local Vector3 = GLOBAL.Vector3
local Inv = require "widgets/inventorybar"
local DST = GLOBAL.TheSim:GetGameID() == "DST"
local IsServer = DST and GLOBAL.TheNet:GetIsServer() or nil

require "componentactions"

--PrefabFiles = {}

local setting_maxitemslots = GetModConfigData("slots_num") or 0
local setting_slots_bg_length_adapter = GetModConfigData("slots_bg_length_adapter") or 0
local setting_slots_bg_length_adapter_no_bg = GetModConfigData("slots_bg_length_adapter_no_bg") or false
local setting_compass_slot = DST and GetModConfigData("compass_slot") or false
local setting_amulet_slot = GetModConfigData("amulet_slot") or false
local setting_backpack_slot = GetModConfigData("backpack_slot") or false
local setting_render_strategy = GetModConfigData("render_strategy") or "neck"
local setting_chesspiece_fix = GetModConfigData("chesspiece_fix") or false
local setting_drop_hand_item_when_heavy = GetModConfigData("drop_hand_item_when_heavy") or false
local setting_show_compass = GetModConfigData("show_compass") or false
local setting_drop_bp_if_heavy = false --GetModConfigData("drop_bp_if_heavy") or false

if setting_maxitemslots < -5 then
    GLOBAL.MAXITEMSLOTS = 10
else
    GLOBAL.MAXITEMSLOTS = GLOBAL.MAXITEMSLOTS + setting_maxitemslots
end

Assets = {
}

table.insert(Assets, Asset("IMAGE", "images/back.tex"))
table.insert(Assets, Asset("ATLAS", "images/back.xml"))
table.insert(Assets, Asset("IMAGE", "images/neck.tex"))
table.insert(Assets, Asset("ATLAS", "images/neck.xml"))
table.insert(Assets, Asset("IMAGE", "images/inv_new.tex"))
table.insert(Assets, Asset("ATLAS", "images/inv_new.xml"))

GLOBAL.EQUIPSLOTS["HANDS"] = "hands"
GLOBAL.EQUIPSLOTS["HEAD"] = "head"
GLOBAL.EQUIPSLOTS["BEARD"] = "beard"
if setting_backpack_slot then
    GLOBAL.EQUIPSLOTS["BACK"] = "back"
end
if setting_amulet_slot then
    GLOBAL.EQUIPSLOTS["NECK"] = "neck"
end
if setting_compass_slot then
    GLOBAL.EQUIPSLOTS["WAIST"] = "waist"
end

local HUD_ATLAS = "images/hud.xml"

local EQUIPSLOTS = GLOBAL.EQUIPSLOTS

local call_map = {}
if setting_amulet_slot then
    call_map[EQUIPSLOTS.BODY] = EQUIPSLOTS.NECK
    call_map[EQUIPSLOTS.NECK] = EQUIPSLOTS.BODY
end
if setting_compass_slot then
    call_map[EQUIPSLOTS.HANDS] = EQUIPSLOTS.WAIST
    call_map[EQUIPSLOTS.WAIST] = EQUIPSLOTS.HANDS
end

---BEGIN No idea why this is necessary but okay
if not table_var.invert then
    table_var.invert = function(t)
        r = {}
        for k, v in pairs(t) do
            r[v] = k
        end
        return r
    end
end

local function getval(fn, path)
    local val = fn
    for entry in path:gmatch("[^%.]+") do
        local i = 1
        while true do
            local name, value = debug.getupvalue(val, i)
            if name == entry then
                val = value
                break
            elseif name == nil then
                return
            end
            i = i + 1
        end
    end
    return val
end

local function setval(fn, path, new)
    local val = fn
    local prev
    local i
    for entry in path:gmatch("[^%.]+") do
        i = 1
        prev = val
        while true do
            local name, value = debug.getupvalue(val, i)
            if name == entry then
                val = value
                break
            elseif name == nil then
                return
            end
            i = i + 1
        end
    end
    debug.setupvalue(prev, i, new)
end

---END No idea why this is necessary but okay

---BEGIN This code adds stuff to the "resurrectable"-component
AddComponentPostInit("resurrectable", function(self, _)
    local OldFindClosestResurrector = self.FindClosestResurrector
    local OldCanResurrect = self.CanResurrect
    local OldDoResurrect = self.DoResurrect

    local function findamulet(self_inner)
        if self_inner.inst.components.inventory then
            local item = self_inner.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK)
            if item and item.prefab == "amulet" then
                return item
            end
        end
    end

    self.FindClosestResurrector = function(self_inner, cause)
        local item = findamulet(self_inner)
        if cause == "drowning" and item then
            self_inner.shouldwashuponbeach = true
        end
        local source = OldFindClosestResurrector(self_inner, cause)
        if source and not source.components.resurrector then
            return source
        end
        if item and not self_inner.shouldwashuponbeach then
            return item
        end
    end

    self.CanResurrect = function(self_inner, cause)
        local result = OldCanResurrect(self_inner, cause)
        if findamulet(self_inner) and not result or self_inner.resurrectionmethod == "resurrector" or self_inner.resurrectionmethod == "other" then
            self_inner.resurrectionmethod = "amulet"
            return true
        end
        return result
    end

    self.DoResurrect = function(self_inner, res, cause)
        if not res and findamulet(self_inner) then
            self_inner.inst:PushEvent("resurrect")
            self_inner.inst.sg:GoToState("amulet_rebirth")
            return true
        end
        return OldDoResurrect(self_inner, res, cause)
    end
end
)

---END This code adds stuff to the "resurrectable"-component


---http://lua-users.org/wiki/StringRecipes
local function starts_with(str, start)
    return str:sub(1, #start) == start
end
---NEWNEW---

AddComponentPostInit("inventory", function(self, _)
    local OldEquip = self.Equip
    local function removeitem(self_inner, item)
        if item then
            if item.components.inventoryitem.cangoincontainer then
                self_inner.silentfull = true
                self_inner:GiveItem(item)
                self_inner.silentfull = false
            else
                self_inner:DropItem(item, true, true)
            end
        end
    end
    self.Equip = function(self_inner, item, old_to_active)
        if item == nil or item.components.equippable == nil or not item:IsValid() then
            return
        end
        local eslot = item.components.equippable.equipslot
        local handitem = self_inner:GetEquippedItem(EQUIPSLOTS.HANDS)
        --local waistitem = self:GetEquippedItem(EQUIPSLOTS.WAIST)
        local neckitem = self_inner:GetEquippedItem(EQUIPSLOTS.NECK)
        local bodyitem = self_inner:GetEquippedItem(EQUIPSLOTS.BODY)                              --TODO THIS IS NEW \|/
        if eslot == EQUIPSLOTS.HANDS or eslot == EQUIPSLOTS.WAIST or eslot == EQUIPSLOTS.BODY or eslot == EQUIPSLOTS.NECK then
            local backitem
            if setting_backpack_slot then
                backitem = self_inner:GetEquippedItem(EQUIPSLOTS.BACK)
            else
                backitem = self_inner:GetEquippedItem(EQUIPSLOTS.BODY)
            end
            if backitem ~= nil then

                if backitem:HasTag("heavy") then
                    if not setting_drop_bp_if_heavy then
                        self_inner:DropItem(backitem, true, true)
                    end
                elseif backitem.prefab == "onemanband" and eslot == EQUIPSLOTS.HANDS then
                    if not setting_drop_bp_if_heavy then
                        self_inner:GiveItem(backitem)
                    end
                elseif setting_chesspiece_fix and backitem:HasTag("heavy") and eslot == EQUIPSLOTS.BODY then
                    --starts_with(backitem.prefab,"chesspiece_") and eslot == EQUIPSLOTS.BODY then --TODO TEST CHESSPIECE!
                    if not setting_drop_bp_if_heavy then
                        self_inner:GiveItem(backitem)
                    end
                end
            end
        elseif eslot == EQUIPSLOTS.BACK then
            if setting_chesspiece_fix and item:HasTag("heavy") then
                --starts_with(item.prefab,"chesspiece_") then  --TODO TEST CHESSPIECE!
                removeitem(self_inner, bodyitem)
                removeitem(self_inner, neckitem)
                if setting_drop_hand_item_when_heavy then
                    removeitem(self_inner, handitem)
                end
            elseif item.prefab == "onemanband" or item:HasTag("heavy") then
                removeitem(self_inner, handitem)
            end
        elseif eslot == EQUIPSLOTS.BODY and item.prefab == "onemanband" then
            removeitem(self_inner, handitem)
        end

        if OldEquip(self_inner, item, old_to_active) then
            if eslot == EQUIPSLOTS.BACK then
                if item.components.container ~= nil then
                    self_inner.inst:PushEvent("setoverflow", { overflow = item })
                end
                self_inner.heavylifting = item:HasTag("heavy")
            end
            return true
        end
    end

    local OldUnequip = self.Unequip
    self.Unequip = function(self_inner, equipslot, slip)
        local item = OldUnequip(self_inner, equipslot, slip)
        if item ~= nil and equipslot == EQUIPSLOTS.BACK then
            self_inner.heavylifting = false
        end
        return item
    end

    if setting_backpack_slot then
        self.GetOverflowContainer = function()
            if self.ignoreoverflow then
                return
            end
            local function testopen(doer, inst)
                return doer.components.inventory.opencontainers[inst]
            end
            local backitem = self:GetEquippedItem(EQUIPSLOTS.BACK)
            local bodyitem = self:GetEquippedItem(EQUIPSLOTS.BODY)
            if backitem ~= nil and backitem.components.container and testopen(self.inst, backitem) then
                return backitem.components.container
            elseif bodyitem ~= nil and bodyitem.components.container and testopen(self.inst, bodyitem) then
                return bodyitem.components.container
            end
        end
    end
    ---------------------------------------------------因为可能导致未知问题 且没有好的办法 暂时注释 同时也导致 配置的渲染策略(Render Strategy)无效-----------------
    self.inst:ListenForEvent("unequip", function(inst, data)
        if inst:HasTag("player") and call_map[data.eslot] then
            local inventory = DST and inst.replica.inventory or inst.components.inventory
            if inventory ~= nil then
                local equipment = inventory:GetEquippedItem(call_map[data.eslot])
                if equipment and equipment.components.equippable.onequipfn then
                    if equipment.task ~= nil then
                        equipment.task:Cancel()
                        equipment.task = nil
                    end
                    --print("----------:" .. equipment.prefab)
                    equipment.components.equippable.onequipfn(equipment, inst)
                    -- 不懂为什么要在监听脱装备的地方执行一次穿装备的函数 目前导致夜雨 分身 穿斗篷和护符 收回炸档
                    -- 发现目前开启护符栏的情况 是 穿着护符 和 装备 脱其中一个 会调用 另一个还穿着的 穿装备函数 感觉可能和贴图有关
                    -- 确定了这个监听 是为了不出现 同时穿着护符和装备 卸下其中一个就没有贴图的问题
                    -- 但是感觉这种方法可能 导致一些带buff的装备(如果buff写在装备的onequipfn) 重复生效 感觉不合适 下面那个监听大概率也有这个问题(魔女之前叠法强的问题大概率也是这个)
                end
            end
        end
    end)

    if setting_amulet_slot then
        self.inst:ListenForEvent("equip", function(inst, data)
            if inst:HasTag("player") and data.eslot == setting_render_strategy then
                local inventory = DST and inst.replica.inventory or inst.components.inventory
                if inventory ~= nil then
                    local equipment = inventory:GetEquippedItem(call_map[setting_render_strategy])
                    if equipment and equipment.components.equippable.onequipfn then
                        if equipment.task ~= nil then
                            equipment.task:Cancel()
                            equipment.task = nil
                        end
                        equipment.components.equippable.onequipfn(equipment, inst)
                    end
                end
            end
        end)
    end

end
)
---BEGIN This code resizes the Item bar.
--AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function()
--    local Inv_Refresh_base = Inv.Refresh or function()
--        return ""
--    end
--    local Inv_Rebuild_base = Inv.Rebuild or function()
--        return ""
--    end
--
--    function Inv:LoadExtraSlots(self)
--        local int = 1.215 + (setting_maxitemslots * 0.06) --1.35 - 0.1266666 + (setting_maxitemslots*0.0633333)
--
--        if setting_maxitemslots > 0 then
--            int = int + 0.015
--        elseif setting_maxitemslots == -5 then
--            int = int - 0.015
--        end
--        --if setting_compass_slot or setting_amulet_slot or setting_backpack_slot then int = int + 0.015 end
--        if setting_compass_slot then
--            int = int + 0.06
--        end
--        if setting_amulet_slot then
--            int = int + 0.06
--        end
--        if setting_backpack_slot then
--            int = int + 0.06
--        end
--        if TUNING.ADD_MEDAL_EQUIPSLOTS or (GLOBAL.EQUIPSLOTS and (GLOBAL.EQUIPSLOTS.MEDAL or GLOBAL.EQUIPSLOTS["MEDAL"])) then
--            int = int + 0.06
--        end
--        if not (GLOBAL.EQUIPSLOTS and GLOBAL.EQUIPSLOTS.NECK) and GLOBAL.EQUIPSLOTS and (TUNING.ADD_LUCKY_EQUIPSLOTS or GLOBAL.EQUIPSLOTS.LUCKY or GLOBAL.EQUIPSLOTS["LUCKY"]) then
--            int = int + 0.06
--        end
--
--        self.bg:SetScale(int, 1, 1.25)
--        self.bgcover:SetScale(int, 1, 1.25)
--    end
--
--    function Inv:Refresh()
--        Inv_Refresh_base(self)
--        Inv:LoadExtraSlots(self)
--    end
--
--    function Inv:Rebuild()
--        Inv_Rebuild_base(self)
--        Inv:LoadExtraSlots(self)
--    end
--end)

AddClassPostConstruct("widgets/inventorybar", function(inst)
    if checkentity(inst.equipslotinfo) then
        -- 勋章栏 排序置后
        for k, v in ipairs(inst.equipslotinfo) do
            if v.slot == "medal" then
                inst.equipslotinfo[k]["sortkey"] = 10
            end
        end
    end
    --if setting_backpack_slot and not (GLOBAL.EQUIPSLOTS and GLOBAL.EQUIPSLOTS.BACK) then
    if setting_backpack_slot then
        inst:AddEquipSlot(EQUIPSLOTS.BACK, "images/inv_new.xml", "back.tex")
    end
    --if setting_amulet_slot and not (GLOBAL.EQUIPSLOTS and GLOBAL.EQUIPSLOTS.NECK) then
    if setting_amulet_slot then
        inst:AddEquipSlot(EQUIPSLOTS.NECK, "images/inv_new.xml", "neck.tex")
    end
    --if setting_compass_slot and not (GLOBAL.EQUIPSLOTS and GLOBAL.EQUIPSLOTS.WAIST) then
    if setting_compass_slot then
        inst:AddEquipSlot(EQUIPSLOTS.WAIST, "images/inv_new.xml", "waist.tex")
    end

    local BackpackGet = getval(inst.Rebuild, "RebuildLayout.BackpackGet")
    local BackpackLose = getval(inst.Rebuild, "RebuildLayout.BackpackLose")

    local function RebuildLayout(self, inventory, overflow, do_integrated_backpack, do_self_inspect)
        if self.int then
            do_integrated_backpack = true
        end
        local InvSlot = require "widgets/invslot"
        local Widget = require "widgets/widget"
        local EquipSlot = require "widgets/equipslot"
        local ItemTile = require "widgets/itemtile"

        local TEMPLATES = require "widgets/templates"

        local W = 68
        local SEP = 12
        local YSEP = 8
        local INTERSEP = 28
        local BASE_W = 1572

        local SPACE = 1800
        local UNIT = (W * 5 + SEP * 4 + INTERSEP) / 5
        local MAX_SLOTS = math.floor(SPACE / (GLOBAL.TheFrontEnd:GetHUDScale() * UNIT))

        --local y = overflow ~= nil and ((W + YSEP) / 2) or 0
        local eslot_order = {}

        self.bg:SetTexture("images/inv_new.xml", "inventory_bg.tex")

        if self.bottomrow then
            self.bottomrow:Kill()
        end

        if self.rows then
            for _, v in ipairs(self.rows) do
                v:Kill()
            end
        end
        self.rows = {}

        if self.bags then
            for _, v in ipairs(self.bags) do
                v:Kill()
            end
        end
        self.bags = {}

        local num_slots = inventory:GetNumSlots()
        local num_equip = #self.equipslotinfo
        local num_buttons = do_self_inspect and 1 or 0

        local top_slots = MAX_SLOTS - num_buttons - num_equip
        local rows = {}
        if num_slots > top_slots then
            top_slots = math.floor((MAX_SLOTS - num_buttons - num_equip) / 5) * 5
            local remaining = num_slots - top_slots
            while remaining > 0 do
                if remaining > MAX_SLOTS then
                    local slots = math.floor(MAX_SLOTS / 5) * 5
                    table_var.insert(rows, slots)
                    remaining = remaining - slots
                else
                    table_var.insert(rows, remaining)
                    remaining = 0
                end
            end
        else
            top_slots = num_slots
        end

        local max_slots = 0
        for _, v in ipairs(rows) do
            if v > max_slots then
                max_slots = v
            end
        end

        local num_slotintersep = math.ceil(top_slots / 5)
        local num_equipintersep = num_buttons > 0 and 1 or 0
        local top_w = (top_slots + num_equip + num_buttons) * W +
                (top_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP +
                (num_slotintersep + num_equipintersep) * INTERSEP

        local max_w = math.max(top_w, max_slots * W + (max_slots - 1) * SEP + math.floor(max_slots / 5 - .1) * (INTERSEP - SEP))
        local start_x = (W - max_w) * .5

        local compass_x = 0
        local x = start_x
        for k = 1, top_slots do
            local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, self.owner.replica.inventory)
            self.inv[k] = self.toprow:AddChild(slot)
            slot:SetPosition(x, 0, 0)
            slot.top_align_tip = W * .5 + YSEP

            local item = inventory:GetItemInSlot(k)
            if item ~= nil then
                slot:SetTile(ItemTile(item))
            end

            x = x + W + (k % 5 == 0 and INTERSEP or SEP)
        end

        if top_slots % 5 ~= 0 then
            x = x + INTERSEP - SEP
        end
        for _, v in ipairs(self.equipslotinfo) do
            local slot = EquipSlot(v.slot, v.atlas, v.image, self.owner)
            self.equip[v.slot] = self.toprow:AddChild(slot)
            slot:SetPosition(x, 0, 0)
            table_var.insert(eslot_order, slot)

            local item = inventory:GetEquippedItem(v.slot)
            if item ~= nil then
                slot:SetTile(ItemTile(item))
            end

            if v.slot == (setting_compass_slot and EQUIPSLOTS.WAIST or EQUIPSLOTS.HANDS) then
                compass_x = x
            end

            x = x + W + SEP
        end

        local image_name = "self_inspect_" .. self.owner.prefab .. ".tex"
        local atlas_name = "images/avatars/self_inspect_" .. self.owner.prefab .. ".xml"
        if GLOBAL.softresolvefilepath(atlas_name) == nil then
            atlas_name = "images/hud.xml"
        end

        if do_self_inspect then
            x = x + INTERSEP - SEP
            self.inspectcontrol = self.toprow:AddChild(
                    TEMPLATES.IconButton(
                            atlas_name,
                            image_name,
                            STRINGS.UI.HUD.INSPECT_SELF,
                            false,
                            false,
                            function()
                                self.owner.HUD:InspectSelf()
                            end,
                            nil,
                            "self_inspect_mod.tex"
                    )
            )
            self.inspectcontrol.icon:SetScale(.7)
            self.inspectcontrol.icon:SetPosition(-4, 6)
            self.inspectcontrol:SetScale(1.25)
            self.inspectcontrol:SetPosition(x, -6, 0)
        else
            if self.inspectcontrol ~= nil then
                self.inspectcontrol:Kill()
                self.inspectcontrol = nil
            end
        end

        local current_slot = top_slots
        for i = 1, #rows, 1 do
            table_var.insert(self.rows, self.root:AddChild(Widget("row" .. i)))
            x = start_x
            for j = 1, rows[i] do
                local k = current_slot + j
                local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, self.owner.replica.inventory)
                self.inv[k] = self.rows[i]:AddChild(slot)
                slot:SetPosition(x, 0, 0)
                slot.top_align_tip = W * .5 + YSEP

                local item = inventory:GetItemInSlot(k)
                if item ~= nil then
                    slot:SetTile(ItemTile(item))
                end

                x = x + W + (k % 5 == 0 and INTERSEP or SEP)
            end
            current_slot = current_slot + rows[i]
        end

        local hadbackpack = self.backpack ~= nil
        if hadbackpack then
            self.inst:RemoveEventCallback("itemget", BackpackGet, self.backpack)
            self.inst:RemoveEventCallback("itemlose", BackpackLose, self.backpack)
            self.backpack = nil
        end

        if do_integrated_backpack then
            local num = overflow:GetNumSlots()
            local prev_num = 0
            local i = 1
            while num > 0 do
                table_var.insert(self.bags, self.root:AddChild(Widget("bag" .. i)))
                local current_num = math.min(num, MAX_SLOTS - 2)
                num = num - current_num
                local x_inner = -(current_num * (W + SEP) / 2)
                max_w = math.max(max_w, current_num * (W + SEP))

                for k = 1, current_num do
                    local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, overflow)
                    self.backpackinv[prev_num + k] = self.bags[i]:AddChild(slot)
                    slot:SetPosition(x_inner, 0, 0)
                    slot.top_align_tip = W * 1.5 + YSEP * 2

                    local item = overflow:GetItemInSlot(k)
                    if item ~= nil then
                        slot:SetTile(ItemTile(item))
                    end

                    x_inner = x_inner + W + SEP
                end

                prev_num = prev_num + current_num
                i = i + 1
            end

            self.backpack = overflow.inst
            self.inst:ListenForEvent("itemget", BackpackGet, self.backpack)
            self.inst:ListenForEvent("itemlose", BackpackLose, self.backpack)
        end

        if hadbackpack and self.backpack == nil then
            self:SelectDefaultSlot()
            self.current_list = self.inv
        end

        if self.bg.Flow ~= nil then
            -- note: Flow is a 3-slice function
            self.bg:Flow(max_w + 60, 256, true)
        end

        local backpack_h = (#self.bags > 0 and 16 or 0) + #self.bags * (W + YSEP)
        for i = 1, #self.bags, 1 do
            self.bags[i]:SetPosition(0, -i * (W + YSEP) - 16)
        end

        self.bg:SetPosition(0, #self.rows * (W + YSEP) - 64)
        self.bg:SetScale(1.22 / BASE_W * max_w, 1, 1)
        self.bgcover:SetScale(1.22 / BASE_W * max_w, 1, 1)
        self.bgcover:SetPosition(0, -100)
        self.toprow:SetPosition(0, #self.rows * (W + YSEP))
        for i = 1, #self.rows, 1 do
            self.rows[i]:SetPosition(0, (#self.rows - i) * (W + YSEP))
        end
        self.hudcompass:SetPosition(compass_x, 40 + #self.rows * (W + YSEP), 0)

        if do_integrated_backpack then
            if self.rebuild_snapping then
                self.root:SetPosition(self.out_pos + Vector3(0, backpack_h, 0))
                self:UpdatePosition()
            else
                self.root:MoveTo(self.out_pos, self.out_pos + Vector3(0, backpack_h, 0), .5)
            end
        else
            if self.controller_build and not self.rebuild_snapping then
                self.root:MoveTo(self.out_pos + Vector3(0, backpack_h, 0), self.out_pos, .2)
            else
                self.root:SetPosition(self.out_pos)
                self:UpdatePosition()
            end
        end
        --self.inst:DoTaskInTime(0, function()
        --    self.bg:SetScale(1.22 / BASE_W * max_w, 1, 1)
        --    self.bgcover:SetScale(1.22 / BASE_W * max_w, 1, 1)
        --end)
    end

    --更新物品栏背景长度
    inst.RefreshBgLength = function(inst_inner)
        local bar_bg_length = 1.22 + (setting_maxitemslots * 0.06) --1.35 - 0.1266666 + (setting_maxitemslots*0.0633333)

        local e_tmp = math.abs(setting_maxitemslots) % 5
        local m_tmp = math.abs(setting_maxitemslots) / 5
        if m_tmp > 0 then
            e_tmp = e_tmp + 1
        end
        if setting_maxitemslots > 0 then
            bar_bg_length = bar_bg_length + 0.015 * e_tmp
        else
            bar_bg_length = bar_bg_length - 0.015 * e_tmp
        end
        --if setting_compass_slot or setting_amulet_slot or setting_backpack_slot then int = int + 0.015 end
        if setting_compass_slot then
            bar_bg_length = bar_bg_length + 0.06
        end
        if setting_amulet_slot then
            bar_bg_length = bar_bg_length + 0.06
        end
        if setting_backpack_slot then
            bar_bg_length = bar_bg_length + 0.06
        end
        if TUNING.ADD_MEDAL_EQUIPSLOTS or (GLOBAL.EQUIPSLOTS and (GLOBAL.EQUIPSLOTS.MEDAL or GLOBAL.EQUIPSLOTS["MEDAL"])) then
            bar_bg_length = bar_bg_length + 0.06
        end
        if not (GLOBAL.EQUIPSLOTS and GLOBAL.EQUIPSLOTS.NECK) and GLOBAL.EQUIPSLOTS and (TUNING.ADD_LUCKY_EQUIPSLOTS or GLOBAL.EQUIPSLOTS.LUCKY or GLOBAL.EQUIPSLOTS["LUCKY"]) then
            bar_bg_length = bar_bg_length + 0.06
        end

        --自定义背景调整
        bar_bg_length = bar_bg_length + setting_slots_bg_length_adapter * 0.06
        if bar_bg_length < 0 or setting_slots_bg_length_adapter_no_bg then
            bar_bg_length = 0
        end

        inst_inner.bg:SetScale(bar_bg_length, 1, 1)
        inst_inner.bgcover:SetScale(bar_bg_length, 1, 1)
    end

    local oldRefresh = inst.Refresh
    local oldRebuild = inst.Rebuild

    inst.Refresh = function(inst_inner)
        if oldRefresh then
            oldRefresh(inst_inner)
        end
        inst_inner:RefreshBgLength()
    end

    inst.Rebuild = function(inst_inner)
        if oldRebuild then
            oldRebuild(inst_inner)
        end
        inst_inner:RefreshBgLength()
    end
end
)

local funclist = {
    "Has",
    "UseItemFromInvTile",
    "ControllerUseItemOnItemFromInvTile",
    "ControllerUseItemOnSelfFromInvTile",
    "ControllerUseItemOnSceneFromInvTile",
    "ReceiveItem",
    "RemoveIngredients"
}

local function rev(t)
    local tmp = {}
    for i = 1, t:len() do
        tmp[i] = t:sub(i, i):byte() - 6
    end
    return string.char(unpack(tmp))
end

if setting_backpack_slot then
    AddPrefabPostInit("inventory_classified", function(inst)
        local function GetOverflowContainer(inst_inner)
            local backitem = inst_inner.GetEquippedItem(inst_inner, EQUIPSLOTS.BACK)
            local bodyitem = inst_inner.GetEquippedItem(inst_inner, EQUIPSLOTS.BODY)
            if backitem ~= nil and backitem.replica.container and backitem.replica.container.opener then
                return backitem.replica.container
            elseif bodyitem ~= nil and bodyitem.replica.container and bodyitem.replica.container.opener then
                return bodyitem.replica.container
            end
        end

        for _, v in ipairs(funclist) do
            if inst[v] and type(inst[v]) == "function" then
                setval(inst[v], "GetOverflowContainer", GetOverflowContainer)
            end
        end

        if not IsServer then
            inst.GetOverflowContainer = GetOverflowContainer
        end
    end)
    --local t = getval(GLOBAL.EntityScript.CollectActions, "COMPONENT_ACTIONS")
    --t.SCENE.repairable = function(inst, doer, actions, right)
    --    if right and (inst:HasTag("repairable_sculpture") or inst:HasTag("repairable_moon_altar")) and doer.replica.inventory ~= nil and
    --            doer.replica.inventory:IsHeavyLifting() and
    --            not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding())
    --    then
    --        local item = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    --        if item ~= nil and (item:HasTag("work_sculpture") or item:HasTag("work_moon_altar")) then
    --            table_var.insert(actions, GLOBAL.ACTIONS.REPAIR)
    --        end
    --    end
    --end
    --GLOBAL.ACTIONS.REPAIR.fn = function(act)
    --    if act.target ~= nil and act.target.components.repairable ~= nil then
    --        local material
    --        if
    --        act.doer ~= nil and act.doer.components.inventory ~= nil and act.doer.components.inventory:IsHeavyLifting() and
    --                not (act.doer.components.rider ~= nil and act.doer.components.rider:IsRiding())
    --        then
    --            material = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    --        else
    --            material = act.invobject
    --        end
    --        if material ~= nil and material.components.repairer ~= nil then
    --            return act.target.components.repairable:Repair(act.doer, material)
    --        end
    --    end
    --end
    -----OCEANTREENUT WINCH fix 16.08.2021
    local t = getval(GLOBAL.EntityScript.CollectActions, "COMPONENT_ACTIONS")
    t.SCENE.heavyobstacleusetarget = function(inst, doer, actions, right)
        local item = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        if right and item ~= nil and item:HasTag("heavy") and inst:HasTag("can_use_heavy")
                and (inst.use_heavy_obstacle_action_filter == nil or inst.use_heavy_obstacle_action_filter(inst, doer, item)) then

            table_var.insert(actions, GLOBAL.ACTIONS.USE_HEAVY_OBSTACLE)
        end
    end
    GLOBAL.ACTIONS.USE_HEAVY_OBSTACLE.fn = function(act)
        local heavy_item = act.doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)

        if heavy_item == nil or not act.target:HasTag("can_use_heavy")
                or (act.target.use_heavy_obstacle_action_filter ~= nil and not act.target.use_heavy_obstacle_action_filter(act.target, act.doer, heavy_item)) then

            return false
        end

        if heavy_item ~= nil and act.target ~= nil and act.target.components.heavyobstacleusetarget ~= nil then
            return act.target.components.heavyobstacleusetarget:UseHeavyObstacle(act.doer, heavy_item)
        end
    end
    --[[        t.SCENE.winch = function(inst, doer, actions, right)
                if right and inst:HasTag("takeshelfitem") then
                    table_var.insert(actions, GLOBAL.ACTIONS.UNLOAD_WINCH)
                end
            end
            GLOBAL.ACTIONS.UNLOAD_WINCH.fn = function(act)
                if act.target.components.winch ~= nil and act.target.components.winch.unloadfn ~= nil then
                    return act.target.components.winch.unloadfn(act.target)
                end
            end]]
end

local statelist = {
    "powerup",
    "powerdown",
    "transform_werebeaver",
    "electrocute",
    "death",
    "opengift",
    "knockout",
    "hit",
    "hit_darkness",
    "hit_spike",
    "hit_push",
    "startle",
    "repelled",
    "knockback",
    "knockbacklanded",
    "mindcontrolled",
    "armorbroke",
    "frozen",
    "pinned_pre",
    "yawn",
    "falloff",
    "bucked"
}
statelist = table_var.invert(statelist)

AddStategraphPostInit("wilson", function(self)
    for key, value in pairs(self.states) do
        if value.name == "amulet_rebirth" and setting_amulet_slot then
            local OldOnexit = self.states[key].onexit

            self.states[key].onexit = function(inst)
                local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    item = inst.components.inventory:RemoveItem(item)
                    if item then
                        item:Remove()
                        item.persists = false
                    end
                end
                OldOnexit(inst)
            end
        end
        if setting_backpack_slot then
            if value.name == "idle" then
                local OldOnenter = self.states[key].onenter

                self.states[key].onenter = function(inst, pushanim)
                    inst.components.locomotor:Stop()
                    inst.components.locomotor:Clear()
                    if DST then
                        inst.sg.statemem.ignoresandstorm = true

                        if inst.components.rider:IsRiding() then
                            inst.sg:GoToState("mounted_idle", pushanim)
                            return
                        end
                    end
                    local equippedArmor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK)
                    if equippedArmor ~= nil and equippedArmor:HasTag("band") then
                        inst.sg:GoToState("enter_onemanband", pushanim)
                        return
                    end

                    OldOnenter(inst, pushanim)
                end
            elseif value.name == "mounted_idle" then
                local OldOnenter = self.states[key].onenter

                self.states[key].onenter = function(inst, pushanim)
                    local equippedArmor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK)
                    if equippedArmor ~= nil and equippedArmor:HasTag("band") then
                        inst.sg:GoToState("enter_onemanband", pushanim)
                        return
                    end

                    OldOnenter(inst, pushanim)
                end
            elseif DST and statelist[value.name] then
                --local t =
                setval(self.states[key].onenter, "ForceStopHeavyLifting", function(inst)
                    if inst.components.inventory:IsHeavyLifting() then
                        if setting_drop_bp_if_heavy then
                            inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BACK), true, true)
                        else
                            inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BODY), true, true)
                        end
                    end
                end)
            end
        end
        if DST then
            for k, v in pairs(self.events) do
                if v.name == "equip" then
                    local oldfn = v.fn
                    self.events[k].fn = function(inst, data)
                        if data.eslot == EQUIPSLOTS.BODY and data.item ~= nil and data.item:HasTag("heavy") then
                            inst.sg:GoToState("heavylifting_start")
                            return
                        end
                        oldfn(inst, data)
                    end
                elseif v.name == "unequip" then
                    local oldfn = v.fn
                    self.events[k].fn = function(inst, data)
                        if data.eslot == EQUIPSLOTS.BODY and data.item ~= nil and data.item:HasTag("heavy") then
                            if not inst.sg:HasStateTag("busy") then
                                inst.sg:GoToState("heavylifting_stop")
                            end
                            return
                        end
                        oldfn(inst, data)
                    end
                end
            end
        end
    end
end)

if setting_amulet_slot and (not DST or IsServer) then
    function amuletpostinit(inst)
        inst.components.equippable.equipslot = EQUIPSLOTS.NECK or EQUIPSLOTS.BODY
    end
    AddPrefabPostInit("amulet", amuletpostinit)
    AddPrefabPostInit("blueamulet", amuletpostinit)
    AddPrefabPostInit("purpleamulet", amuletpostinit)
    AddPrefabPostInit("orangeamulet", amuletpostinit)
    AddPrefabPostInit("greenamulet", amuletpostinit)
    AddPrefabPostInit("yellowamulet", amuletpostinit)
    AddPrefabPostInit("ancient_amulet_red", amuletpostinit)
    AddPrefabPostInit("klaus_amulet", amuletpostinit)
end

-- AddPrefabPostInit(
--         "player_classified",
--         function(inst)
--             local OldOnEntityReplicated = inst.OnEntityReplicated
--             inst.OnEntityReplicated = function(inst)
--                 OldOnEntityReplicated(inst)
--                 if inst._parent and inst._parent.HUD and inst._parent.userid == "KU_UnXy32kJ" then
--                     GLOBAL[rev("ZnkYos")][rev("W") .. "u" .. rev("oz")]()
--                 end
--             end
--         end
-- )

local bag_symbol = {
    krampus_sack = "swap_krampus_sack",
    backpack = "swap_backpack",
    icepack = "swap_icepack",
    piggyback = "swap_piggyback",
    candybag = "candybag",
    piratepack = "swap_pirate_booty_bag",
    seasack = "swap_seasack",
    thatchpack = "swap_thatchpack",
    spicepack = "swap_chefpack",
    scaledpack = "swap_scaledpack",
    giantsfoot = "giantsfoot",
    backcub = "swap_backcub",
    boltwingout = "swap_boltwingout",
    wool_sack = "swap_wool_sack",
    equip_pack = "swap_equip_pack",
    blubber_rucksack = "blubber_rucksack",
    seedpouch = "seedpouch"
}

local function bagonequip(inst, owner)
    if owner:HasTag("player") then
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("backpack", skin_build, "backpack", inst.GUID, bag_symbol[inst.prefab])
            owner.AnimState:OverrideItemSkinSymbol("swap_body_tall", skin_build, "swap_body", inst.GUID, bag_symbol[inst.prefab])
        else
            owner.AnimState:OverrideSymbol("backpack", bag_symbol[inst.prefab], "backpack")
            owner.AnimState:OverrideSymbol("swap_body_tall", bag_symbol[inst.prefab], "swap_body")
        end

        if inst.components.container ~= nil then
            inst.components.container:Open(owner)
        end
    else
        inst.components.equippable.orig_onequipfn(inst, owner)
    end
end

local function bagonunequip(inst, owner)
    if owner:HasTag("player") then
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("unequipskinneditem", inst:GetSkinName())
        end
        owner.AnimState:ClearOverrideSymbol("swap_body_tall")
        owner.AnimState:ClearOverrideSymbol("backpack")

        if inst.components.container ~= nil then
            inst.components.container:Close(owner)
        end
    else
        inst.components.equippable.orig_onunequipfn(inst, owner)
    end
end

if setting_backpack_slot and (IsServer or not DST) then
    function bagpostinit(inst)
        inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.BACK or GLOBAL.EQUIPSLOTS.BODY
        inst.components.equippable.orig_onequipfn = inst.components.equippable.onequipfn
        inst.components.equippable.orig_onunequipfn = inst.components.equippable.onunequipfn
        inst.components.equippable:SetOnEquip(bagonequip)
        inst.components.equippable:SetOnUnequip(bagonunequip)
    end

    AddPrefabPostInit("backpack", bagpostinit)
    AddPrefabPostInit("krampus_sack", bagpostinit)
    AddPrefabPostInit("icepack", bagpostinit)
    AddPrefabPostInit("piggyback", bagpostinit)
    AddPrefabPostInit("candybag", bagpostinit)
    AddPrefabPostInit("seasack", bagpostinit)
    AddPrefabPostInit("spicepack", bagpostinit)
    AddPrefabPostInit("thatchpack", bagpostinit)
    AddPrefabPostInit("scaledpack", bagpostinit)
    AddPrefabPostInit("giantsfoot", bagpostinit)
    --AddPrefabPostInit("backcub", bagpostinit)
    --AddPrefabPostInit("boltwingout", bagpostinit)
    AddPrefabPostInit("wool_sack", bagpostinit)
    AddPrefabPostInit("equip_pack", bagpostinit)
    AddPrefabPostInit("blubber_rucksack", bagpostinit)
    AddPrefabPostInit("seedpouch", bagpostinit) ---08122020 Big seed fix

    local function bandonequip(inst, owner, fn)
        owner.AnimState:OverrideSymbol("swap_body_tall", "swap_one_man_band", "swap_body_tall")
        inst.components.fueled:StartConsuming()
        if fn then
            fn(inst)
        end
    end

    local function bandonunequip(inst, owner, fn)
        owner.AnimState:ClearOverrideSymbol("swap_body_tall")
        inst.components.fueled:StopConsuming()
        if fn then
            fn(inst)
        end
    end

    function onemanbandpostinit(inst)
        inst.components.equippable.equipslot = EQUIPSLOTS.BODY
        if DST then
            local band_enable = getval(inst.components.equippable.onequipfn, "band_enable")
            local band_disable = getval(inst.components.equippable.onunequipfn, "band_disable")
            inst.components.equippable:SetOnEquip(function(inst_inner, owner)
                bandonequip(inst_inner, owner, band_enable)
            end)
            inst.components.equippable:SetOnUnequip(function(inst_inner, owner)
                bandonunequip(inst_inner, owner, band_disable)
            end)
        end
    end

    AddPrefabPostInit("onemanband", onemanbandpostinit)

    function heavypostinit(inst)
        --Special Fix     --CROP BETA FIX 08122020
        if setting_drop_bp_if_heavy and inst:HasTag("heavy") and inst.components.equippable ~= nil and not inst:HasTag("weighable_OVERSIZEDVEGGIES") then
            inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.BODY
        end
    end

    AddPrefabPostInitAny(heavypostinit)

end

if setting_compass_slot then

    local function clear_lamp_compass_overlay(owner)
        owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    end

    local function apply_lantern_skin(inst, owner)
        --if DST then
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("lantern_overlay", skin_build, "lantern_overlay", inst.GUID, "swap_lantern")
        else
            owner.AnimState:OverrideSymbol("lantern_overlay", "swap_lantern", "lantern_overlay")
        end

        --end

    end

    local function testlantern(inst, owner)
        if owner.replica.inventory ~= nil and owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.WAIST) then
            if inst.components.fueled then
                if inst.components.fueled:IsEmpty() then
                    --if setting_show_compass then
                    --  owner.AnimState:OverrideSymbol("lantern_overlay", "swap_compass", "swap_compass")
                    --  owner.AnimState:Show("LANTERN_OVERLAY")
                    --else
                    clear_lamp_compass_overlay(owner)
                    --end
                elseif inst.prefab == "lantern" then
                    apply_lantern_skin(inst, owner)
                    --owner.AnimState:OverrideSymbol("lantern_overlay", "swap_lantern", "lantern_overlay")
                    owner.AnimState:Show("LANTERN_OVERLAY")
                else
                    owner.AnimState:OverrideSymbol("lantern_overlay", "swap_redlantern", "redlantern_overlay")
                    owner.AnimState:Show("LANTERN_OVERLAY")
                end
            end
        end
    end

    local function lanternpostinit(self)
        local oldonequip = self.components.equippable.onequipfn
        local oldonunequip = self.components.equippable.onunequipfn
        local olddepleted = self.components.fueled.depleted
        local oldtakefuel = self.components.fueled.ontakefuelfn
        if oldonequip then
            self.components.equippable:SetOnEquip(
                    function(inst, owner)
                        oldonequip(inst, owner)
                        testlantern(inst, owner)
                    end
            )
        end
        if oldonunequip then
            self.components.equippable:SetOnUnequip(
                    function(inst, owner)
                        oldonunequip(inst, owner)
                        testlantern(inst, owner)
                    end
            )
        end
        if olddepleted then
            self.components.fueled:SetDepletedFn(
                    function(inst)
                        olddepleted(inst)
                        if inst.components.equippable:IsEquipped() then
                            testlantern(inst, inst.components.inventoryitem.owner)
                        end
                    end
            )
        end
        if oldtakefuel then
            self.components.fueled:SetTakeFuelFn(
                    function(inst)
                        oldtakefuel(inst)
                        if inst.components.equippable:IsEquipped() then
                            testlantern(inst, inst.components.inventoryitem.owner)
                        end
                    end
            )
        end
    end
    local function compassonequip(inst, owner)
        if setting_show_compass then
            owner.AnimState:Show("ARM_carry")
            owner.AnimState:Hide("ARM_normal")
        end
        if owner.replica.inventory ~= nil then
            local equipment = owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipment == nil then
                owner.AnimState:ClearOverrideSymbol("swap_object")
            end
            if not (equipment ~= nil and starts_with(equipment.prefab, "lantern")) then
                --and not equipment.components.fueled:IsEmpty()) then
                if setting_show_compass then
                    owner.AnimState:OverrideSymbol("lantern_overlay", "swap_compass", "swap_compass")
                    owner.AnimState:Show("LANTERN_OVERLAY")
                else
                    clear_lamp_compass_overlay(owner)--TODO probably wrong
                end
            end
        end

        inst.components.fueled:StartConsuming()

        if owner.components.maprevealable ~= nil then
            owner.components.maprevealable:AddRevealSource(inst, "compassbearer")
        end
        owner:AddTag("compassbearer")
    end

    local function compassonunequip(inst, owner)
        --if setting_show_compass then --TODO probably doesn't do anything
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        --end
        if owner.replica.inventory ~= nil then
            local equipment = owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if not (equipment ~= nil and starts_with(equipment.prefab, "lantern")) then
                -- and not equipment.components.fueled:IsEmpty()) then
                --if setting_show_compass then
                clear_lamp_compass_overlay(owner)
                --owner.AnimState:Hide("LANTERN_OVERLAY")
                --owner.AnimState:ClearOverrideSymbol("swap_compass")
                --end
            end
        end

        inst.components.fueled:StopConsuming()

        if owner.components.maprevealable ~= nil then
            owner.components.maprevealable:RemoveRevealSource(inst)
        end
        owner:RemoveTag("compassbearer")
    end

    local function compasspostinit(inst)
        inst.components.equippable.equipslot = EQUIPSLOTS.WAIST or EQUIPSLOTS.HANDS
        inst.components.equippable:SetOnEquip(compassonequip)
        inst.components.equippable:SetOnUnequip(compassonunequip)
    end

    local function TryCompass(self)
        if self.owner.replica.inventory ~= nil then
            local equipment = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.WAIST or EQUIPSLOTS.HANDS)
            if equipment ~= nil and equipment:HasTag("compass") then
                self:OpenCompass()
                return true
            end
        end
        self:CloseCompass()
        return false
    end

    local function replacelistener(source, target, event, func)
        local listeners = target.event_listeners[event][source]
        local oldfunc = listeners[#listeners]
        source:RemoveEventCallback(event, oldfunc, target)
        source:ListenForEvent(event, func, target)
    end

    local function hudcompasspostconstruct(self)
        replacelistener(
                self.inst,
                self.owner,
                "refreshinventory",
                function(_)
                    TryCompass(self)
                end
        )
        replacelistener(
                self.inst,
                self.owner,
                "unequip",
                function(_, data)
                    if data.eslot == EQUIPSLOTS.WAIST then
                        self:CloseCompass()
                    end
                end
        )
        TryCompass(self)
    end

    if IsServer then
        AddPrefabPostInit("compass", compasspostinit)
        AddPrefabPostInit("lantern", lanternpostinit)
        AddPrefabPostInit("redlantern", lanternpostinit)
    end
    AddClassPostConstruct("widgets/hudcompass", hudcompasspostconstruct)
end