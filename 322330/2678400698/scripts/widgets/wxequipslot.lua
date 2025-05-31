-- Original code is from "WX Automation Patch" by wiefean.
-- https://steamcommunity.com/sharedfiles/filedetails/?id=3385430772

local ItemSlot = require "widgets/itemslot"
local ItemTile = require "widgets/itemtile"

local WXEquipSlot = Class(ItemSlot, function(self, eslot, atlas, bgim, owner)
    ItemSlot._ctor(self, atlas, bgim, owner)
    self.owner = owner
    self.eslot = eslot or ""
    self.highlight = false

    self:SetOnTileChangedFn(function(self, tile)
        if tile ~= nil then
            tile:SetIsEquip(true)
        end
    end)
end)

function WXEquipSlot:GetTarget()
    local player_classified = self.owner ~= nil and self.owner.player_classified or nil
    return (player_classified ~= nil and player_classified.wxequipwidget ~= nil and
        player_classified.wxequipwidget["target"] ~= nil and player_classified.wxequipwidget["target"]:value()) or nil
end

function WXEquipSlot:GetItem()
    local player_classified = self.owner ~= nil and self.owner.player_classified or nil
    return (player_classified ~= nil and player_classified.wxequipwidget ~= nil and
        player_classified.wxequipwidget[self.eslot] ~= nil and player_classified.wxequipwidget[self.eslot]:value()) or nil
end

function WXEquipSlot:Refresh()
    local item = self:GetItem()
    if item ~= nil then
        if self.tile == nil or (self.tile.item ~= nil and self.tile.item ~= item) then
            self:SetTile(ItemTile(item))
            self.tile.GetDescriptionString = function(tile)
                return tile.item ~= nil and tile.item:IsValid() and
                    tile.item:GetDisplayName() or ""
            end
        end
    else
        self:SetTile(nil)
    end

    if self.tile ~= nil and self.tile.item ~= nil then
        self.tile:Refresh()
    end
end

function WXEquipSlot:Click()
    self:OnControl(CONTROL_ACCEPT, true)
end

function WXEquipSlot:OnControl(control, down)
    if self.tile ~= nil then
        self.tile:UpdateTooltip()
    end

    if down then
        local target = self:GetTarget()
        if target == nil or self.owner == nil then
            return false
        end

        local item = self:GetItem()
        if control == CONTROL_ACCEPT then
            local active_item = self.owner.replica.inventory and self.owner.replica.inventory:GetActiveItem() or nil
            if active_item ~= nil and active_item.replica.equippable ~= nil and active_item.replica.equippable:EquipSlot() == self.eslot then
                SendModRPCToServer(GetModRPC("WXAutomationRPC", "GiveWXEquipment"), self.owner, target, self.eslot)
                return true
            elseif active_item == nil and item ~= nil then
                SendModRPCToServer(GetModRPC("WXAutomationRPC", "TakeWXEquipment"), self.owner, target, self.eslot)
                return true
            end
        elseif control == CONTROL_SECONDARY and item ~= nil then
            SendModRPCToServer(GetModRPC("WXAutomationRPC", "ToggleWXSecondaryContainer"), self.owner, target, self.eslot)
            return true
        end
    end
end

return WXEquipSlot