local Component2hm = Class(function(self, inst)
    self.inst = inst
    self.data = {}
end)

function Component2hm:OnSave()
    if self.inst.onsave2hm then self.inst.onsave2hm(self.inst, self.data) end
    return self.data
end

function Component2hm:OnLoad(data)
    self.data = data or self.data
    if self.inst.onload2hm then self.inst.onload2hm(self.inst, self.data) end
end

function Component2hm:LoadPostPass(ents, data)
    if self.inst.LoadPostPass2hm then
        self.data = data or self.data
        self.inst.LoadPostPass2hm(self.inst, ents, self.data)
    end
end

return Component2hm
