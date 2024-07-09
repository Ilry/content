local function GetLeader(inst)
    local leader = inst.bernieleader
    return leader and leader:HasTag("mym_mate") and leader or nil
end

AddBrainPostInit("berniebigbrain", function(self)
    table.insert(self.bt.root.children, 1, Follow(self.inst, GetLeader, 1, 8, 20, true))
end)
