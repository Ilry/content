local PmUpdate = Class(function(self, inst)
    self.inst = inst
    self.inst:AddTag("pmupdate")
    self.data = nil
end)

function PmUpdate:Work(doer,target)
    if target.components.workable ~= nil then
        local result = SpawnPrefab("pmfiresuppressor")
		result.Transform:SetPosition(target.Transform:GetWorldPosition())
        result.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
		target:Remove()
		return true

    end
    return false
end

return PmUpdate