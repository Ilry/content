--[[
Copyright (C) 2020 Zarklord

This file is part of Gem Core.

The source code of this program is shared under the RECEX
SHARED SOURCE LICENSE (version 1.0).
The source code is shared for referrence and academic purposes
with the hope that people can read and learn from it. This is not
Free and Open Source software, and code is not redistributable
without permission of the author. Read the RECEX SHARED
SOURCE LICENSE for details
The source codes does not come with any warranty including
the implied warranty of merchandise.
You should have received a copy of the RECEX SHARED SOURCE
LICENSE in the form of a LICENSE file in the root of the source
directory. If not, please refer to
<https://raw.githubusercontent.com/Recex/Licenses/master/SharedSourceLicense/LICENSE.txt>
]]

local CRAFTINGHUD = "craftinghud"
local PINSLOT = "pinslot"
local SUBINGREDIENT = "subingredient"

local IngredientUI = require("widgets/ingredientui")

local crafting_menu_open = false

--sub ingredient hover
local is_subcraft_ingredients = nil
local visible_subingredients = nil

--pin slot hover
local is_pinslot_ingredients = nil
local visible_pinslot = nil

local _IngredientUI_ctor = IngredientUI._ctor
function IngredientUI._ctor(self, ...)
    _IngredientUI_ctor(self, ...)

    if self.ongainfocus and self.onlosefocus then
        local _ongainfocus = self.ongainfocus
        self.ongainfocus = function(...)
            is_subcraft_ingredients = true
            return _ongainfocus(...)
        end

        local _onlosefocus = self.onlosefocus
        self.onlosefocus = function(...)
            if self.ingredients == visible_subingredients then
                visible_subingredients = nil
                self.owner:PushEvent("gemdict_subingredient_hideoverlay")
            end
            return _onlosefocus(...)
        end
    end
end

function IngredientUI:UpdateQuantity(quantity, on_hand, has_enough, builder)
    if builder ~= nil then
        quantity = math.round(quantity * builder:IngredientMod())
    end
    local hud_atlas = resolvefilepath("images/hud.xml")
    self:SetTextures(hud_atlas, has_enough and "inv_slot.tex" or "resource_needed.tex")
    if self.quant then
        self.quant:SetString(string.format("%d/%d", on_hand, quantity))
        if has_enough then
            self.quant:SetColour(255/255, 255/255, 255/255, 1)
        else
            self.quant:SetColour(255/255, 155/255, 155/255, 1)
        end
    end
end

local GemDictIngredientUI = require("widgets/gemdictingredientui")
local IngredientAllocator = gemrun("gemdictionary/ingredientallocator")

local function ImageTableContainsImage(imagetable, image)
    for i, v in ipairs(imagetable) do
        if v.image == image then
            return i
        end
    end
    return true
end

local CraftingMenuIngredients = require("widgets/redux/craftingmenu_ingredients")

local startidx
local localdata
local SetRecipeEnv = setmetatable({
    ipairs = function(t, ...)
        if not localdata then return ipairs(t, ...) end
        local self = localdata.self
        local recipe = localdata.recipe
        local call_index = localdata.call_index

        if call_index == 1 and t == recipe.tech_ingredients then
            localdata.call_index = 2
            --if t is ever == to my modified tech ingredients table, replace it with the proper value before iterating
            t = localdata._tech_ingredients
            recipe.tech_ingredients = localdata._tech_ingredients
        elseif call_index == 2 and t == recipe.ingredients then
            localdata.call_index = 3
            --obtain the index where recipe.ingredients start.
            startidx = #self.ingredient_widgets + 1
        elseif call_index == 3 and t == recipe.character_ingredients then
            localdata.call_index = 4

            local owner = localdata.owner
            local builder = owner.replica.builder

            --get the local variables from __MakeIngredientList
            local root, w, half_div, offset, quant_text_scale, allow_ingredient_crafting
            local stacklevel = 2
            while debug.getinfo(stacklevel, "n") ~= nil do
                root = LocalVariableHacker.GetLocalVariable(stacklevel, "root")
                w = LocalVariableHacker.GetLocalVariable(stacklevel, "w")
                half_div = LocalVariableHacker.GetLocalVariable(stacklevel, "half_div")
                offset = LocalVariableHacker.GetLocalVariable(stacklevel, "offset")
                quant_text_scale = LocalVariableHacker.GetLocalVariable(stacklevel, "quant_text_scale")
                allow_ingredient_crafting = LocalVariableHacker.GetLocalVariable(stacklevel, "allow_ingredient_crafting")
                if root ~= nil and w ~= nil and half_div ~= nil and offset ~= nil and quant_text_scale ~= nil and allow_ingredient_crafting ~= nil then
                    break
                end
                stacklevel = stacklevel + 1
            end

            local ingredientdata = IngredientAllocator(recipe):GetRecipePopupIngredients(owner, builder:IngredientMod())

            --update recipe.ingredients, if some of the items it thought were avaliable actually weren't
            for i = startidx, #self.ingredient_widgets do
                local ingredient = recipe.ingredients[1 + (i - startidx)]
                local _ingredientdata = ingredientdata[ingredient]
                self.ingredient_widgets[i]:UpdateQuantity(ingredient.amount, _ingredientdata.num_found, _ingredientdata.has, builder)

                if self.is_sub_ingredients then
                    for item, count in pairs(_ingredientdata.items) do
                        item:PushEvent("gemdict_setcount", {count = count, state = SUBINGREDIENT})
                    end
                elseif self.is_pin_ingredients then
                    for item, count in pairs(_ingredientdata.items) do
                        item:PushEvent("gemdict_setcount", {count = count, state = PINSLOT})
                    end
                else
                    for item, count in pairs(_ingredientdata.items) do
                        item:PushEvent("gemdict_setcount", {count = count, state = CRAFTINGHUD})
                    end
                end
            end

            for i, v in ipairs(recipe.gemdict_ingredients) do
                local _ingredientdata = ingredientdata[v]
                local images, names, counts = v:GetImages(not _ingredientdata.has, _ingredientdata.num_found, not _ingredientdata.nomix and _ingredientdata.has or false)
                if _ingredientdata.nomix then
                    for i1, v1 in ipairs(_ingredientdata) do
                        for item, count in pairs(v1.items) do
                            local image = item.replica.inventoryitem:GetImage()
                            local index = ImageTableContainsImage(images, image)
                            if index then
                                counts[index].on_hand = v1.num_found
                                counts[index].has_enough = v1.has
                            else
                                table.insert(images, {image = image, atlas = item.replica.inventoryitem:GetAtlas()})
                                table.insert(names, item:GetBasicDisplayName())
                                table.insert(counts, {on_hand = v1.num_found, has_enough = v1.has})
                            end

                            if self.is_sub_ingredients then
                                item:PushEvent("gemdict_setcount", {count = count, state = SUBINGREDIENT})
                            elseif self.is_pin_ingredients then
                                item:PushEvent("gemdict_setcount", {count = count, state = PINSLOT})
                            else
                                item:PushEvent("gemdict_setcount", {count = count, state = CRAFTINGHUD})
                            end
                        end
                    end
                else
                    --obtain inv images, and names from val, and use them if they aren't already present in the list of images.
                    for item, count in pairs(_ingredientdata.items) do
                        local image = item.replica.inventoryitem:GetImage()
                        if not ImageTableContainsImage(images, image) then
                            table.insert(images, {image = image, atlas = item.replica.inventoryitem:GetAtlas()})
                            table.insert(names, item:GetBasicDisplayName())
                            table.insert(counts, {on_hand = _ingredientdata.num_found, has_enough = _ingredientdata.has})
                        end

                        if self.is_sub_ingredients then
                            item:PushEvent("gemdict_setcount", {count = count, state = SUBINGREDIENT})
                        elseif self.is_pin_ingredients then
                            item:PushEvent("gemdict_setcount", {count = count, state = PINSLOT})
                        else
                            item:PushEvent("gemdict_setcount", {count = count, state = CRAFTINGHUD})
                        end
                    end
                end

                --sub ingredient crafting is currently too complicated, for the moment its not allowed.
                --local ingredient_recipe_data = allow_ingredient_crafting and owner.HUD.controls.craftingmenu:GetRecipeState(v.type) or nil

                local ing = root:AddChild(GemDictIngredientUI(images, v.amount, counts, names, owner, v.type, quant_text_scale, nil))

                if GetGameModeProperty("icons_use_cc") then
                    ing.ing:SetEffect("shaders/ui_cc.ksh")
                end
                if self.num_items > 1 and #self.ingredient_widgets > 0 then
                    offset = offset + half_div
                end
                ing:SetPosition(offset, 0)
                offset = offset + w + half_div
                table.insert(self.ingredient_widgets, ing)
            end

            LocalVariableHacker.SetLocalVariable(stacklevel, "offset", offset)
        end
        return ipairs(t, ...)
    end
}, {__index = _G, __newindex = _G})
setfenv(CraftingMenuIngredients.SetRecipe, SetRecipeEnv)

local craftinghighlight = GEMENV.GetModConfigData("craftinghighlight", true)

local _SetRecipe = CraftingMenuIngredients.SetRecipe
function CraftingMenuIngredients:SetRecipe(recipe, ...)
    localdata = nil

    local owner = self.owner

    if is_subcraft_ingredients then
        visible_subingredients = self
        self.is_sub_ingredients = true
        is_subcraft_ingredients = nil
    elseif is_pinslot_ingredients then
        visible_pinslot = self
        self.is_pin_ingredients = true
        is_pinslot_ingredients = nil
    end

    if self.is_sub_ingredients then
        owner:PushEvent("gemdict_subingredient_hideoverlay")
    elseif self.is_pin_ingredients then
        owner:PushEvent("gemdict_pinslot_hideoverlay")
    else
        owner:PushEvent("gemdict_craftinghud_hideoverlay")
    end

    local retvals

    if not craftinghighlight and not recipe:HasGemDictIngredients() then
        if self.is_sub_ingredients then
            owner:PushEvent("gemdict_subingredient_disablecount")
        elseif self.is_pin_ingredients then
            owner:PushEvent("gemdict_pinslot_disablecount")
        else
            owner:PushEvent("gemdict_craftinghud_disablecount")
        end

        retvals = {_SetRecipe(self, recipe, ...)}
    else
        if self.is_sub_ingredients then
            owner:PushEvent("gemdict_subingredient_resetcount")
        elseif self.is_pin_ingredients then
            owner:PushEvent("gemdict_pinslot_resetcount")
        else
            owner:PushEvent("gemdict_craftinghud_resetcount")
        end

        localdata = {self = self, recipe = recipe, owner = owner, call_index = 1}
        --increase the size of the tech ingredients table so the ui spaces the ingredients properly.
        localdata._tech_ingredients = recipe.tech_ingredients
        recipe.tech_ingredients = ExtendedArray({}, {true}, #recipe.tech_ingredients + #recipe.gemdict_ingredients)
        --this will get reset back properly in the ipairs metatable function replacement above
        retvals = {_SetRecipe(self, recipe, ...)}
        localdata = nil
    end

    if self.is_sub_ingredients then
        owner:PushEvent("gemdict_subingredient_showoverlay")
    elseif self.is_pin_ingredients then
        owner:PushEvent("gemdict_pinslot_showoverlay")
    elseif crafting_menu_open then
        owner:PushEvent("gemdict_craftinghud_showoverlay")
    end

    return unpack(retvals)
end

local function SetGemDictCount(self, count)
    if count == nil or count == 0 then
        self.gemdict_ingredientoverlay:Hide()
        self.gemdict_consumecount:Hide()
    elseif count == false then
        self.gemdict_ingredientoverlay:Show()
        self.gemdict_consumecount:Hide()

        self.gemdict_ingredientoverlay:MoveToFront()

        if self.quantity then
            self.quantity:MoveToFront()
        end
    elseif count > 0 then
        self.gemdict_ingredientoverlay:Hide()
        self.gemdict_consumecount:Show()

        self.gemdict_consumecount:MoveToFront()
        self.gemdict_consumecount:SetString(tostring(count))
    end
end

local function GetGemDictState(self)
    if self._gemdict_state[SUBINGREDIENT] then
        return SUBINGREDIENT
    end
    if self._gemdict_state[PINSLOT] then
        return PINSLOT
    end
    if self._gemdict_state[CRAFTINGHUD] then
        return CRAFTINGHUD
    end
end

local function Refresh(self)
    self:SetGemDictCount(self._gemdict_count[self:GetGemDictState()])
end

local Text = require("widgets/text")
local Image = require("widgets/image")

GEMENV.AddClassPostConstruct("widgets/itemtile", function(self)
    self.gemdict_ingredientoverlay = self:AddChild(Image("images/gemdict_ui.xml", "gemdict_ingredientoverlay.tex"))
    self.gemdict_ingredientoverlay:SetTint(255/255, 255/255, 255/255, 0.5)
    self.gemdict_ingredientoverlay:SetClickable(false)
    self.gemdict_ingredientoverlay:Hide()

    self.gemdict_consumecount = self:AddChild(Text(NUMBERFONT, 36))
    self.gemdict_consumecount:SetPosition(24, 16, 0)
    self.gemdict_consumecount:SetClickable(false)
    self.gemdict_consumecount:Hide()

    self.SetGemDictCount = SetGemDictCount
    self.GetGemDictState = GetGemDictState

    self._gemdict_count = {
        [SUBINGREDIENT] = false,
        [PINSLOT] = false,
        [CRAFTINGHUD] = false,
    }
    self._gemdict_state = {
        [SUBINGREDIENT] = false,
        [PINSLOT] = false,
        [CRAFTINGHUD] = false,
    }

    self.inst:ListenForEvent("gemdict_setcount", function(_, data)
        self._gemdict_count[data.state] = data.count and ((self._gemdict_count[data.state] or 0) + data.count) or data.count
        if self:GetGemDictState() == data.state then
            self:SetGemDictCount(self._gemdict_count[data.state])
        end
    end, self.item)

    self.inst:ListenForEvent("gemdict_setstate", function(_, data)
        local prev_state = self:GetGemDictState()
        self._gemdict_state[data.state] = data.active
        local new_state = self:GetGemDictState()
        if prev_state ~= new_state then
            self:SetGemDictCount(self._gemdict_count[new_state])
        end
    end, self.item)

    local _Refresh = self.Refresh
    function self:Refresh(...)
        _Refresh(self, ...)
        Refresh(self)
    end

    local _StartDrag = self.StartDrag
    function self:StartDrag(...)
        _StartDrag(self, ...)
        self:SetGemDictCount(nil)
    end

    Refresh(self)
end)

local function SetItemlessGemDictState(self, state, active)
    local prev_state = self:GetItemlessGemDictState()
    self._gemdict_state[state] = active
    local new_state = self:GetItemlessGemDictState()
    if prev_state ~= new_state and not self.tile then
        self:UpdateItemlessGemDictCount(self._gemdict_count[new_state])
    end
end

local function SetItemlessGemDictCount(self, state, count)
    self._gemdict_count[state] = count
    if self:GetItemlessGemDictState() == state and not self.tile then
        self:UpdateItemlessGemDictCount(count)
    end
end

local function GetItemlessGemDictState(self)
    if self._gemdict_state[SUBINGREDIENT] then
        return SUBINGREDIENT
    end
    if self._gemdict_state[PINSLOT] then
        return PINSLOT
    end
    if self._gemdict_state[CRAFTINGHUD] then
        return CRAFTINGHUD
    end
end

local function UpdateItemlessGemDictCount(self, count)
    if count == false then
        self.gemdict_ingredientoverlay:Show()
        self.gemdict_ingredientoverlay:MoveToFront()
    else
        self.gemdict_ingredientoverlay:Hide()
    end
end

local function ForwardSetStateToItem(self, listen_event, send_event, state, active)
    self.inst:ListenForEvent(listen_event, function()
        self:SetItemlessGemDictState(state, active)
        local item = self.tile and self.tile.item
        if type(item) == "table" then
            item:PushEvent(send_event, {state = state, active = active})
        end
    end, self.owner)
end

local function ForwardSetCountToItem(self, listen_event, send_event, state, count)
    self.inst:ListenForEvent(listen_event, function()
        self:SetItemlessGemDictCount(state, count)
        local item = self.tile and self.tile.item
        if type(item) == "table" then
            item:PushEvent(send_event, {count = count, state = state})
        end
    end, self.owner)
end

GEMENV.AddClassPostConstruct("widgets/itemslot", function(self)
    self.gemdict_ingredientoverlay = self:AddChild(Image("images/gemdict_ui.xml", "gemdict_ingredientoverlay.tex"))
    self.gemdict_ingredientoverlay:SetTint(255/255, 255/255, 255/255, 0.5)
    self.gemdict_ingredientoverlay:SetClickable(false)
    self.gemdict_ingredientoverlay:Hide()

    ForwardSetStateToItem(self, "gemdict_craftinghud_showoverlay", "gemdict_setstate", CRAFTINGHUD, true)
    ForwardSetStateToItem(self, "gemdict_craftinghud_hideoverlay", "gemdict_setstate", CRAFTINGHUD, false)

    ForwardSetStateToItem(self, "gemdict_pinslot_showoverlay", "gemdict_setstate", PINSLOT, true)
    ForwardSetStateToItem(self, "gemdict_pinslot_hideoverlay", "gemdict_setstate", PINSLOT, false)

    ForwardSetStateToItem(self, "gemdict_subingredient_showoverlay", "gemdict_setstate", SUBINGREDIENT, true)
    ForwardSetStateToItem(self, "gemdict_subingredient_hideoverlay", "gemdict_setstate", SUBINGREDIENT, false)

    ForwardSetCountToItem(self, "gemdict_craftinghud_resetcount", "gemdict_setcount", CRAFTINGHUD, false)
    ForwardSetCountToItem(self, "gemdict_craftinghud_disablecount", "gemdict_setcount", CRAFTINGHUD, nil)

    ForwardSetCountToItem(self, "gemdict_pinslot_resetcount", "gemdict_setcount", PINSLOT, false)
    ForwardSetCountToItem(self, "gemdict_pinslot_disablecount", "gemdict_setcount", PINSLOT, nil)

    ForwardSetCountToItem(self, "gemdict_subingredient_resetcount", "gemdict_setcount", SUBINGREDIENT, false)
    ForwardSetCountToItem(self, "gemdict_subingredient_disablecount", "gemdict_setcount", SUBINGREDIENT, nil)

    local _SetTile = self.SetTile
    function self:SetTile(tile, ...)
        if tile then
            self:UpdateItemlessGemDictCount(nil)
        else
            self:UpdateItemlessGemDictCount(self._gemdict_count[self:GetItemlessGemDictState()])
        end
        return _SetTile(self, tile, ...)
    end

    self.SetItemlessGemDictState = SetItemlessGemDictState
    self.GetItemlessGemDictState = GetItemlessGemDictState
    self.SetItemlessGemDictCount = SetItemlessGemDictCount
    self.UpdateItemlessGemDictCount = UpdateItemlessGemDictCount

    self._gemdict_count = {
        [SUBINGREDIENT] = false,
        [PINSLOT] = false,
        [CRAFTINGHUD] = false,
    }
    self._gemdict_state = {
        [SUBINGREDIENT] = false,
        [PINSLOT] = false,
        [CRAFTINGHUD] = false,
    }
end)

local CraftingMenuHUD = require("widgets/redux/craftingmenu_hud")
local _Open = CraftingMenuHUD.Open
function CraftingMenuHUD:Open(search, ...)
    crafting_menu_open = true
    return _Open(self, search, ...)
end

local _Close = CraftingMenuHUD.Close
function CraftingMenuHUD:Close(...)
    crafting_menu_open = false
    self.owner:PushEvent("gemdict_craftinghud_hideoverlay")
    return _Close(self, ...)
end

local PinSlot = require("widgets/redux/craftingmenu_pinslot")
local _MakeRecipePopup = PinSlot.MakeRecipePopup
function PinSlot:MakeRecipePopup(...)
    local retvals = {_MakeRecipePopup(self, ...)}

    local root = retvals[1]

    if root then
        local _ShowPopup = root.ShowPopup
        root.ShowPopup = function(popup_self, recipe, ...)
            is_pinslot_ingredients = recipe ~= nil or nil
            return _ShowPopup(popup_self, recipe, ...)
        end

        local _HidePopup = root.HidePopup
        root.HidePopup = function(popup_self, ...)
            if popup_self.ingredients and popup_self.ingredients == visible_pinslot then
                visible_pinslot = nil
                self.owner:PushEvent("gemdict_pinslot_hideoverlay")
            end
            return _HidePopup(popup_self, ...)
        end
    end

    return unpack(retvals)
end