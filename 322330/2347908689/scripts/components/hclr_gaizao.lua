local hclr_gaizao = Class(function(self, inst)
	self.inst = inst
	self.targetprefab = nil
end)

local function doremove(item)
    if  item.components.stackable ~= nil then
        item.components.stackable:Get():Remove()
    else
        item:Remove()
    end
end

function hclr_gaizao:GaiZao(target)
	if self.targetprefab ~= nil then
		local x, y, z = target.Transform:GetWorldPosition()
		if target.components.container then
			target.components.container:DropEverything()
			target.components.container:Close()
		end
		local skin = target.skinname
		target:Remove()
		doremove(self.inst)
		local newtarget = SpawnPrefab(self.targetprefab,skin)
		newtarget.Transform:SetPosition(x, y, z)
		SpawnPrefab("collapse_small").Transform:SetPosition(x, y, z)
		return true
	end
end
return hclr_gaizao
