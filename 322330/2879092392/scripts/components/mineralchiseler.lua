local MineralChiseler = Class(function(self, inst)
    self.inst = inst

    self.inst:AddTag("mineral_chisel_tool")
end)

function MineralChiseler:OnRemoveFromEntity()
    self.inst:RemoveTag("mineral_chisel_tool")
end

-- Component is a singleton.

return MineralChiseler