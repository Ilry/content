local Remoldable = Class(function(self, inst)
    self.inst = inst
    self.dofn = nil
end, nil, {})

function Remoldable:OnDo(fn)
    self.dofn = fn
end

function Remoldable:OnApplied(doer)
    if self.inst.components.stackable then
        self.inst.components.stackable:Get(1):Remove()
    else
        self.inst:Remove()
    end
    if self.dofn ~= nil then self.dofn(self.inst, doer) end
end

return Remoldable
