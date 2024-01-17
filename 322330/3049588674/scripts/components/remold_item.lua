local RemoldItem = Class(function(self, inst)
    self.inst = inst
    self.dofn = nil
end, nil, {})

function RemoldItem:SetDoFn(dofn)
    self.dofn = dofn
end

function RemoldItem:Do(doer, target)
    if self.dofn then self.dofn(self, doer, target) end
end

return RemoldItem