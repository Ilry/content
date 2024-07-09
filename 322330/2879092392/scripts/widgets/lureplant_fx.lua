local Widget = require "widgets/widget"
local Image = require "widgets/image"
local Lureplant_fx = Class(Widget, function(self, owner)
    self.owner = owner
    Widget._ctor(self, "Lureplant_fx")
    self:SetClickable(false)
    self.bg = self:AddChild(Image("images/fx/gemvision_lureplant.xml", "gemvision_lureplant.tex"))
    self.bg:SetVAnchor(ANCHOR_MIDDLE)
    self.bg:SetHAnchor(ANCHOR_MIDDLE)
    self.bg:SetScaleMode(SCALEMODE_FILLSCREEN)
    self.bg:SetVRegPoint(ANCHOR_MIDDLE)
    self.bg:SetHRegPoint(ANCHOR_MIDDLE)
    --[[self.owner:ListenForEvent("onputininventory", function() return self.owner:DoTaskInTime(0.1, function() return self:UpdateVisor() end) end)
        self.owner:ListenForEvent("itemget", function() return self.owner:DoTaskInTime(0.1, function() return self:UpdateVisor() end) end)
        self.owner:ListenForEvent("itemlose", function() return self.owner:DoTaskInTime(0.1, function() return self:UpdateVisor() end) end)]]
    --self.owner:ListenForEvent("equip", function() return self:UpdateVisor() end)
    self.owner:ListenForEvent("unequip", function()
        return self:UpdateVisor()
    end)
    self.owner:DoTaskInTime(0, function()
        return self:UpdateVisor()
    end)
    self.owner:DoPeriodicTask(0, function()
        return self:UpdateVisor()
    end)
    --self.owner:ListenForEvent("ms_respawnedfromghost", function() return self:UpdateVisor() end)
    --self.owner:ListenForEvent("ms_becameghost", function() return self:UpdateVisor() end)
    self:Hide()
end)
function Lureplant_fx:UpdateVisor(data)
    local hat = self.owner.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if hat and hat:HasTag("lureplant_fx") then
        self:Show()
    else
        self:Hide()
    end
end
return Lureplant_fx