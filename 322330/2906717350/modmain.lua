---------------------------{{{{{{  INIT START  }}}}}}-------------------------------------------------------------------------------------------

Assets =
{
    Asset("ATLAS","images/inventory_bg.xml"),
    Asset("IMAGE", "images/back.tex"),
    Asset("ATLAS", "images/back.xml"),
    Asset("IMAGE", "images/neck.tex"),
    Asset("ATLAS", "images/neck.xml"),
}

MOREEQUIPSLOTS = GetModConfigData("MOREEQUIPSLOTS")
INVENTORYSIZE = GetModConfigData("INVENTORYSIZE")
ENABLEBACKPACK = GetModConfigData("ENABLEBACKPACK")


BackPacks = {'icepack','backpack','piggyback','krampus_sack','spicepack','candybag','seedpouch'}
Amulets = {'amulet','blueamulet','purpleamulet','orangeamulet','greenamulet','yellowamulet'}

---------------------------{{{{{{  INIT END  }}}}}}-------------------------------------------------------------------------------------------


---------------------------{{{{{{  MOREEQUIPSLOTS START  }}}}}}-------------------------------------------------------------------------------------------

if MOREEQUIPSLOTS then

    local require = GLOBAL.require
    local TheInput = GLOBAL.TheInput
    local ThePlayer = GLOBAL.ThePlayer
    local IsServer = GLOBAL.TheNet:GetIsServer()
    local Inv = require "widgets/inventorybar"

    GLOBAL.EQUIPSLOTS =
    {
        HANDS = "hands",
        HEAD = "head",
        BODY = "body",
        BACK = "back",
        NECK = "neck",
    }
    GLOBAL.EQUIPSLOT_IDS = {}
    local slot = 0
    for k, v in pairs(GLOBAL.EQUIPSLOTS) do
        slot = slot + 1
        GLOBAL.EQUIPSLOT_IDS[v] = slot
    end
    slot = nil

    AddComponentPostInit("resurrectable", function(self, inst)
        local original_FindClosestResurrector = self.FindClosestResurrector
        local original_CanResurrect = self.CanResurrect
        local original_DoResurrect = self.DoResurrect

        self.FindClosestResurrector = function(self)
            if IsServer and self.inst.components.inventory then
                local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    return item
                end
            end
            original_FindClosestResurrector(self)
        end

        self.CanResurrect = function(self)
            if IsServer and self.inst.components.inventory then
                local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    return true
                end
            end
            original_CanResurrect(self)
        end

        self.DoResurrect = function(self)
            self.inst:PushEvent("resurrect")
            if IsServer and self.inst.components.inventory then
                local item = self.inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                if item and item.prefab == "amulet" then
                    self.inst.sg:GoToState("amulet_rebirth")
                    return true
                end
            end
            original_DoResurrect(self)
        end
    end)

    AddComponentPostInit("inventory", function(self, inst)
        local original_Equip = self.Equip
        self.Equip = function(self, item, old_to_active)
            if original_Equip(self, item, old_to_active) and item and item.components and item.components.equippable then
                local eslot = item.components.equippable.equipslot
                if self.equipslots[eslot] ~= item then
                    if eslot == GLOBAL.EQUIPSLOTS.BACK and item.components.container ~= nil then
                        self.inst:PushEvent("setoverflow", { overflow = item })
                    end
                end
                return true
            else
                return
            end
        end

        self.GetOverflowContainer = function()
            if self.ignoreoverflow then
                return
            end
            local item = self:GetEquippedItem(GLOBAL.EQUIPSLOTS.BACK)
            return item ~= nil and item.components.container or nil
        end
    end)

    AddGlobalClassPostConstruct("widgets/inventorybar", "Inv", function()
        local Inv_Refresh_base = Inv.Refresh or function() return "" end
        local Inv_Rebuild_base = Inv.Rebuild or function() return "" end

        function Inv:LoadExtraSlots(self)
            self.bg:SetScale(1.35,1,1.25)
            self.bgcover:SetScale(1.35,1,1.25)

            if self.addextraslots == nil then
                self.addextraslots = 1

                self:AddEquipSlot(GLOBAL.EQUIPSLOTS.BACK, "images/back.xml", "back.tex")
                self:AddEquipSlot(GLOBAL.EQUIPSLOTS.NECK, "images/neck.xml", "neck.tex")

                --if self.inspectcontrol then
                --    local W = 68
                --    local SEP = 12
                --    local INTERSEP = 28
                --    local inventory = self.owner.replica.inventory
                --    local num_slots = inventory:GetNumSlots()
                --    local num_equip = #self.equipslotinfo
                --    local num_buttons = self.controller_build and 0 or 1
                --    local num_slotintersep = math.ceil(num_slots / 5)
                --    local num_equipintersep = num_buttons > 0 and 1 or 0
                --    local total_w = (num_slots + num_equip + num_buttons) * W + (num_slots + num_equip + num_buttons - num_slotintersep - num_equipintersep - 1) * SEP + (num_slotintersep + num_equipintersep) * INTERSEP
                --    self.inspectcontrol.icon:SetPosition(-4, 6)
                --    self.inspectcontrol:SetPosition((total_w - W) * .5 + 3, 180, 0)
                --end
            end
        end

        function Inv:Refresh()
            Inv_Refresh_base(self)
            Inv:LoadExtraSlots(self)
        end

        function Inv:Rebuild()
            Inv_Rebuild_base(self)
            Inv:LoadExtraSlots(self)
        end
    end)

    AddPrefabPostInit("inventory_classified", function(inst)
        function GetOverflowContainer(inst)
            local item = inst.GetEquippedItem(inst, GLOBAL.EQUIPSLOTS.BACK)
            return item ~= nil and item.replica.container or nil
        end

        function Count(item)
            return item.replica.stackable ~= nil and item.replica.stackable:StackSize() or 1
        end

        function Has(inst, prefab, amount)
            local count =
                inst._activeitem ~= nil and
                inst._activeitem.prefab == prefab and
                Count(inst._activeitem) or 0

            if inst._itemspreview ~= nil then
                for i, v in ipairs(inst._items) do
                    local item = inst._itemspreview[i]
                    if item ~= nil and item.prefab == prefab then
                        count = count + Count(item)
                    end
                end
            else
                for i, v in ipairs(inst._items) do
                    local item = v:value()
                    if item ~= nil and item ~= inst._activeitem and item.prefab == prefab then
                        count = count + Count(item)
                    end
                end
            end

            local overflow = GetOverflowContainer(inst)
            if overflow ~= nil then
                local overflowhas, overflowcount = overflow:Has(prefab, amount)
                count = count + overflowcount
            end

            return count >= amount, count
        end

        if not IsServer then
            inst.GetOverflowContainer = GetOverflowContainer
            inst.Has = Has
        end
    end)

    AddStategraphPostInit("wilson", function(self)
        for key,value in pairs(self.states) do
            if value.name == 'amulet_rebirth' then
                local original_amulet_rebirth_onexit = self.states[key].onexit


                self.states[key].onexit = function(inst)
                    local item = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.NECK)
                    if item and item.prefab == "amulet" then
                        item = inst.components.inventory:RemoveItem(item)
                        if item then
                            item:Remove()
                            item.persists = false
                        end
                    end
                    original_amulet_rebirth_onexit(inst)
                end
            end
        end
    end)

    function backpackpostinit(inst)
        if IsServer then
            inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.BACK or GLOBAL.EQUIPSLOTS.BODY
        end
    end

    function amuletpostinit(inst)
        if IsServer then
            inst.components.equippable.equipslot = GLOBAL.EQUIPSLOTS.NECK or GLOBAL.EQUIPSLOTS.BODY
        end
    end


    for key, value in pairs(Amulets) do
        AddPrefabPostInit(value, amuletpostinit)
    end
    
    for key, value in pairs(BackPacks) do
        AddPrefabPostInit(value, backpackpostinit)
    end

end

---------------------------{{{{{{  MOREEQUIPSLOTS END  }}}}}}-------------------------------------------------------------------------------------------


---------------------------{{{{{{  INVENTORYSIZE START  }}}}}}-------------------------------------------------------------------------------------------

local require = GLOBAL.require
local softresolvefilepath = GLOBAL.softresolvefilepath
local GetGameModeProperty = GLOBAL.GetGameModeProperty
local Vector3 = GLOBAL.Vector3
local TUNING = GLOBAL.TUNING
local MAXITEMSLOTS = GLOBAL.MAXITEMSLOTS
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS

local STRINGS = GLOBAL.STRINGS
local makereadonly = GLOBAL.makereadonly
local SCALEMODE_PROPORTIONAL = GLOBAL.SCALEMODE_PROPORTIONAL
local TALKINGFONT = GLOBAL.TALKINGFONT
local ANCHOR_BOTTOM = GLOBAL.ANCHOR_BOTTOM
local IsServer = GLOBAL.TheNet:GetIsServer()
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local net_entity = GLOBAL.net_entity

MAXITEMSLOTS = INVENTORYSIZE

_G = GLOBAL
local TheNet = _G.rawget(_G, "TheNet")

local inventory = require("components/inventory")
local inventory_replica = require("components/inventory_replica")
local inventorybar = require("widgets/inventorybar")
local InvSlot = require("widgets/invslot")
local Image = require("widgets/image")
local Widget = require("widgets/widget")
local EquipSlot = require("widgets/equipslot")
local ItemTile = require("widgets/itemtile")
local Text = require("widgets/text")
local HudCompass = require "widgets/hudcompass"
local ThreeSlice = require("widgets/threeslice")
local TEMPLATES = require "widgets/templates"
local SourceModifierList = require("util/sourcemodifierlist")
local Profile = GLOBAL.Profile

inventory.maxslots = MAXITEMSLOTS


if MAXITEMSLOTS ~= 15 then

    local function OnDeath(inst)
        if inst.components.inventory ~= nil then
            inst.components.inventory:DropEverything(true)
        end
    end

    local function OnOwnerDespawned(inst)
        if inst.components.inventory ~= nil then
            for slot, item in pairs(inst.components.inventory.itemslots) do
                item:PushEvent("player_despawn")
            end
            for slot, equip in pairs(inst.components.inventory.equipslots) do
                equip:PushEvent("player_despawn")
            end
            if inst.components.inventory.activeitem ~= nil then
                inst.components.inventory.activeitem:PushEvent("player_despawn")
            end
        end
    end

    local inventory_CTorBase = inventory._ctor or function() return true end

    function inventory._ctor(self, inst)
        self.inst = inst
        self.isopen = false
        self.isvisible = false

        self.ignoreoverflow = false
        self.ignorefull = false
        self.silentfull = false
        self.ignoresound = false

        self.itemslots = { }
        self.maxslots = MAXITEMSLOTS

        self.equipslots = { }
        self.heavylifting = false

        self.activeitem = nil
        self.acceptsstacks = true
        self.ignorescangoincontainer = false
        self.opencontainers = { }
        self.opencontainerproxies = {}

        self.dropondeath = true
        inst:ListenForEvent("death", OnDeath)
        self.isexternallyinsulated = SourceModifierList(inst, false, SourceModifierList.boolean)
        inst:ListenForEvent("player_despawn", OnOwnerDespawned)

        if inst.replica.inventory.classified ~= nil then
            makereadonly(self, "maxslots")
            makereadonly(self, "acceptsstacks")
            makereadonly(self, "ignorescangoincontainer")
        end
    end

    local InventoryGetNumSlotsBase = inventory_replica.GetNumSlots
    function inventory_replica:GetNumSlots()
        local result = InventoryGetNumSlotsBase(self)
        return MAXITEMSLOTS
    end

    local function addItemSlotNetvarsInInventory(inst)
        if (#inst._items < MAXITEMSLOTS) then
            for i = #inst._items + 1, MAXITEMSLOTS do
                table.insert(inst._items, net_entity(inst.GUID, "inventory._items[" .. tostring(i) .. "]", "items[" .. tostring(i) .. "]dirty"))
            end
        end
    end
    AddPrefabPostInit("inventory_classified", addItemSlotNetvarsInInventory)

    local HUD_ATLAS = "images/hud.xml"
    local HUD2_ATLAS = "images/hud2.xml"
    local HUD_CHARACTERS = 
    {
        ["wanda"] = HUD2_ATLAS,
    }
    local W = 64
    local SEP = 7
    local YSEP = 8
    local INTERSEP = 15

    local inventorybar_CTorBase = inventorybar._ctor or function() return true end
    function inventorybar._ctor(self, owner)
        inventorybar_CTorBase(self, owner)
        self.root:KillAllChildren()
        self.hudcompass = self.root:AddChild(HudCompass(owner, true))
        self.hudcompass:SetScale(1.5, 1.5)
        self.hudcompass:SetPosition(0, 118, 0)
        self.hudcompass:SetMaster()
        self.hand_inv = self.root:AddChild(Widget("hand_inv"))
        self.bg = self.root:AddChild(ThreeSlice(HUD_ATLAS, "inventory_corner.tex", "inventory_filler.tex"))
        self.newbg = self.root:AddChild(Image("images/inventory_bg.xml", "inventory_bg.tex"))
        self.newbg:SetVRegPoint(ANCHOR_BOTTOM)
        if MAXITEMSLOTS == 45 then
            self.newbg:SetScale(1.463, 1.128, 0)  
        else
            self.newbg:SetScale(0.89, 1.128, 0)
        end
        self.newbg:SetPosition(Vector3(0, -93, 0))

        self.repeat_time = .2

        self.actionstring = self.root:AddChild(Widget("actionstring"))
        self.actionstring:SetScaleMode(SCALEMODE_PROPORTIONAL)

        self.actionstringtitle = self.actionstring:AddChild(Text(TALKINGFONT, 35))
        self.actionstringtitle:SetColour(1, 1, 1, 1)

        self.actionstringbody = self.actionstring:AddChild(Text(TALKINGFONT, 25))
        self.actionstringbody:EnableWordWrap(true)
        self.actionstring:Hide()

        self.root:SetPosition(self.in_pos)
        self:StartUpdating()
    end

    local function BackpackGet(inst, data)
        local owner = ThePlayer
        if owner ~= nil and owner.HUD ~= nil and owner.replica.inventory:IsHolding(inst) then
            local inv = owner.HUD.controls.inv
            if inv ~= nil then
                inv:OnItemGet(data.item, inv.backpackinv[data.slot], data.src_pos, data.ignore_stacksize_anim)
            end
        end
    end

    local function BackpackLose(inst, data)
        local owner = ThePlayer
        if owner ~= nil and owner.HUD ~= nil and owner.replica.inventory:IsHolding(inst) then
            local inv = owner.HUD.controls.inv
            if inv then
                inv:OnItemLose(inv.backpackinv[data.slot])
            end
        end
    end

    local function InventorybarRework(self)
        function self:Rebuild()
            if self.cursor then
                self.cursor:Kill()
                self.cursor = nil
            end

            if self.toprow then
                self.toprow:Kill()
            end

            if self.bottomrow then
                self.bottomrow:Kill()
            end

            self.toprow = self.root:AddChild(Widget("toprow"))
            self.bottomrow = self.root:AddChild(Widget("toprow"))

            self.inv = { }
            self.equip = { }
            self.backpackinv = { }



            local controller_attached = TheInput:ControllerAttached()
            self.controller_build = controller_attached
            self.integrated_backpack = controller_attached or Profile:GetIntegratedBackpack()



            local inventory = self.owner.replica.inventory
            local overflow = inventory:GetOverflowContainer()

            overflow = (overflow ~= nil and overflow:IsOpenedBy(self.owner)) and overflow or nil

            local do_integrated_backpack = overflow ~= nil and self.integrated_backpack
            local do_self_inspect = not (self.controller_build or GetGameModeProperty("no_avatar_popup"))


            -------------------------------{{{{{ RebuildLayout START }}}}}--------------------------------------------------
            self.bottomrow:SetPosition(0, - W - SEP, 0)
            local row_offset =(W + SEP)

            local y = 0
            local eslot_order = { }

            local num_slots = MAXITEMSLOTS
            local num_equip = #self.equipslotinfo 

            local T = num_slots + 5

            local num_intersep =(T / 10) -1
            local total_w =(num_slots -((num_slots - 5) / 2)) *(W) +(num_slots -((num_slots - 5) / 2) -1 - num_intersep) *(SEP) +(INTERSEP * num_intersep)
            local total_e = num_equip * 64 + SEP *(num_equip - 1)

                for k, v in ipairs(self.equipslotinfo) do
                    local slot = EquipSlot(v.slot, v.atlas, v.image, self.owner)
                    self.equip[v.slot] = self.toprow:AddChild(slot)
                    local x = - total_e / 2 + W / 2 +(k + 0) * W +(k + 0) * SEP - 110  
                    slot:SetPosition(x, y + row_offset + 2, 0)
                    if v.slot == EQUIPSLOTS.HANDS then
                        self.hand_inv:SetScale(1.5, 1.5)
                        self.hand_inv:SetPosition(x, do_integrated_backpack and 80+W+SEP+YSEP or 40+W+SEP+YSEP, 0)
                    end
                    table.insert(eslot_order, slot)

                    local item = inventory:GetEquippedItem(v.slot)
                    if item then
                        slot:SetTile(ItemTile(item, inventory))
                    end
                end


                for k = 1, T / 2+1 do	
                    local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, inventory)
                    self.inv[k] = self.toprow:AddChild(slot)
                    local interseps = math.floor((k - 1) / 5)
                    local x = - total_w / 2 + W / 2 + interseps *(INTERSEP - SEP) +(k - 1) * W +(k - 1) * SEP - 40  
                    slot:SetPosition(x, y, 0)

                    local item = inventory:GetItemInSlot(k)
                    if item then
                        slot:SetTile(ItemTile(item, inventory))
                    end
                end

                for k =((T / 2) + 1)+1,((T / 2) +((T / 2) -5) / 2) do   
                    local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, inventory)
                    self.inv[k] = self.toprow:AddChild(slot)
                    local interseps = math.floor((k - 1 - T / 2) / 5)
                    local x = - total_w / 2 + W / 2 + interseps *(INTERSEP - SEP) +(k - 1 - T / 2) * W +(k - 1 - T / 2) * SEP - 110 
                    slot:SetPosition(x, y + row_offset, 0)

                    local item = inventory:GetItemInSlot(k)
                    if item then
                        slot:SetTile(ItemTile(item, inventory))
                    end
                end

                for k =((T / 2) +((T / 2) -5) / 2 + 1),(T - 5) do 
                    local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, inventory)
                    self.inv[k] = self.toprow:AddChild(slot)
                    local interseps = math.floor((k + 5 - 1 - T / 2) / 5)
                    local x = - total_w / 2 + W / 2 + interseps *(INTERSEP - SEP) +(k + 5 + 0 - T / 2) * W +(k + 5 + 0 - T / 2) * SEP - 40  
                    slot:SetPosition(x, y + row_offset, 0)

                    local item = inventory:GetItemInSlot(k)
                    if item then
                        slot:SetTile(ItemTile(item, inventory))
                    end
                end

            local image_name = "self_inspect_" .. self.owner.prefab .. ".tex"
            local atlas_name = "images/avatars/self_inspect_" .. self.owner.prefab .. ".xml"
            if softresolvefilepath(atlas_name) == nil then
                atlas_name = HUD_CHARACTERS[owner_prefab] or HUD_ATLAS
            end

            if do_self_inspect then
                self.bg:SetScale(1.22, 1, 1)
                self.bgcover:SetScale(1.22, 1, 1)

                self.inspectcontrol = self.toprow:AddChild(TEMPLATES.IconButton(atlas_name, image_name, STRINGS.UI.HUD.INSPECT_SELF, false, false, function() self.owner.HUD:InspectSelf() end, nil, "self_inspect_mod.tex"))
                self.inspectcontrol.icon:SetScale(.7)
                self.inspectcontrol.icon:SetPosition(-4, 6)
                self.inspectcontrol:SetScale(1.25)
                self.inspectcontrol:SetPosition(((total_w - W) * .5 + 3)-34, 144, 0)
            else
                self.bg:SetScale(1.15, 1, 1)
                self.bgcover:SetScale(1.15, 1, 1)

                if self.inspectcontrol ~= nil then
                    self.inspectcontrol:Kill()
                    self.inspectcontrol = nil
                end
            end

            local old_backpack = self.backpack
            if self.backpack then
                self.inst:RemoveEventCallback("itemget", BackpackGet, self.backpack)
                self.inst:ListenForEvent("itemlose", BackpackLose, self.backpack)
                self.backpack = nil
            end

            local new_backpack = inventory.overflow
            local do_integrated_backpack = _G.TheInput:ControllerAttached() and new_backpack

            if do_integrated_backpack then

                local num = new_backpack.components.container.numslots
                local total_wb = 0
                local backpack_controller_size_max = 0

                backpack_controller_size_max = 25
                total_wb =(num_slots + 5) / 2 * W +((num_slots + 5) / 2 - 1 - 4) * SEP + 4 * INTERSEP

                if num > backpack_controller_size_max then

                    for k = backpack_controller_size_max + 1, num do
                        local item = new_backpack.components.container:GetItemInSlot(k)
                        new_backpack.components.container:DropItem(item)
                    end

                    new_backpack.components.container:SetNumSlots(backpack_controller_size_max, num)
                    num = backpack_controller_size_max
                end

                for k = 1, num do
                    local slot = InvSlot(k, HUD_ATLAS, "inv_slot.tex", self.owner, new_backpack.components.container)
                    self.backpackinv[k] = self.bottomrow:AddChild(slot)
                    local interseps_backpack = math.floor((k - 1) / 5)
                    local x = - total_wb / 2 + W / 2 + interseps_backpack *(INTERSEP - SEP) +(k - 1) * W +(k - 1) * SEP
                    slot:SetPosition(x, y, 0)

                    local item = new_backpack.components.container:GetItemInSlot(k)
                    if item then
                        slot:SetTile(ItemTile(item))
                    end
                end

                self.backpack = inventory.overflow
                self.inst:ListenForEvent("itemget", BackpackGet, self.backpack)
                self.inst:ListenForEvent("itemlose", BackpackLose, self.backpack)

            end

            if old_backpack and not self.backpack then
                self:SelectSlot(self.inv[1])
                self.current_list = self.inv
            end

            if do_integrated_backpack then
                self.root:SetPosition(self.in_pos)
            else
                self.root:SetPosition(self.out_pos)
            end
            -------------------------------{{{{{ RebuildLayout END }}}}}--------------------------------------------------

            
            self.actionstring:MoveToFront()
            self:SelectDefaultSlot()
            self:UpdateCursor()

            if self.cursor ~= nil then
                self.cursor:MoveToFront()
            end

            self.rebuild_pending = nil
            self.rebuild_snapping = nil
        end
    end

    AddClassPostConstruct("widgets/inventorybar", InventorybarRework)

end

-------------------------------{{{{{ INVENTORYSIZE END }}}}}--------------------------------------------------


-------------------------------{{{{{ ENABLEBACKPACK START }}}}}--------------------------------------------------

if ENABLEBACKPACK then
    for key, value in pairs(BackPacks) do
        AddPrefabPostInit(value,function(inst)
            if ENABLEBACKPACK == true then
                if inst.components.inventoryitem then
                    inst.components.inventoryitem.cangoincontainer = true
                end
            end
        end)
    end
end

-------------------------------{{{{{ ENABLEBACKPACK END }}}}}--------------------------------------------------
