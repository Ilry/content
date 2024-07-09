local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Oneeyevision = Class(Widget, function(self, owner)
    self.owner = owner
    Widget._ctor(self, "Oneeyevision")
    self:SetClickable(false)
    self.bg = self:AddChild(Image("images/fx/whye_fx.xml", "whyoneeye.tex"))
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.owner:ListenForEvent("equip", function()
        return self:CheckPlayerVision()
    end)
    self.owner:ListenForEvent("unequip", function()
        return self:CheckPlayerVision()
    end)
    self.owner:ListenForEvent("ms_respawnedfromghost", function()
        return self:CheckPlayerVision()
    end)
    self.owner:ListenForEvent("ms_becameghost", function()
        return self:CheckPlayerVision()
    end)
    self.owner:DoTaskInTime(0, function()
        return self:CheckPlayerVision()
    end)
    self.owner:DoPeriodicTask(0, function()
        return self:CheckPlayerVision()
    end)
    self:Hide()
end)
function Oneeyevision:CheckPlayerVision()
    local hat = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if self.owner:HasTag("playerghost") then
        self:Hide()
    elseif self.owner:HasTag("oneeyevision") then
        if hat and hat:HasTag("secondeyevision") then
            self:Hide()
            self.owner:RemoveTag("oneeyevisionwidget")
        else
            self:Show()
            self.owner:AddTag("oneeyevisionwidget")
        end
    else
        if hat and hat:HasTag("secondeyevision") then
            self:Show()
            self.owner:AddTag("oneeyevisionwidget")
        else
            self:Hide()
            self.owner:RemoveTag("oneeyevisionwidget")
        end
    end
end
return Oneeyevision