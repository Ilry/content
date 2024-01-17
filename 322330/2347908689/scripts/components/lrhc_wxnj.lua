
local function onwnj(self,wnj)
	if wnj then
		self.inst:RemoveTag("can_hclr_wxnj")
		self.inst:AddTag("hide_percentage")
		if self.inst.components.fueled then
			self.inst.components.fueled.StartConsuming = function(self) self:StopConsuming() end
			self.inst.components.fueled:StopConsuming()
			self.inst.components.fueled.rate = 0
			self.inst.components.fueled:SetPercent(1)
		elseif self.inst.components.finiteuses  then
			self.inst.components.finiteuses:SetPercent(1)
			self.inst.components.finiteuses.SetUses = function(self)  end
		elseif self.inst.components.armor  then
			self.inst.components.armor:SetPercent(1)
			self.inst.components.armor.indestructible = true
		end
	else
		self.inst:AddTag("can_hclr_wxnj")
	end

end

local hclr_gaizao = Class(function(self, inst)
	self.inst = inst
	self.wnj = false
end,
nil,
{
	wnj = onwnj
})

function hclr_gaizao:SetWNJ(object)
	self.wnj = true
	object.components.stackable:Get():Remove()
	return true
end

function hclr_gaizao:OnSave()
    return { wnj = self.wnj }
end

function hclr_gaizao:OnLoad(data)
    if data.wnj then
        self.wnj = true
    end
end
return hclr_gaizao
