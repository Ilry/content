local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Orange_fx = Class(Widget, function(self, owner)
    self.owner = owner
    Widget._ctor(self, "Orange_fx")
    self:SetClickable(false)
    self.bg = self:AddChild(Image("images/fx/gemvision_orange.xml", "gemvision_orange.tex"))
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    self.owner:ListenForEvent("unequip", function()
        return self:UpdateVisor()
    end)
    self.owner:DoTaskInTime(0, function()
        return self:UpdateVisor()
    end)
    self.owner:DoPeriodicTask(0, function()
        return self:UpdateVisor()
    end)
    self:Hide()
end)
function Orange_fx:UpdateVisor(data)
    local hat = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if hat and hat:HasTag("orangegem_fx") then
        self:Show()
    else
        self:Hide()
    end
end
return Orange_fx