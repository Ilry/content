local EnduranceBody = Class(function(self, inst)
    self.inst = inst
    self._headgear_equippable = net_bool(inst.GUID, "why_endurance._headgear_equippable", "headgear_equippabledirty")
end, nil, {})

function EnduranceBody:GetHeadgear_equippable()
    return self._headgear_equippable:value()
end

return EnduranceBody