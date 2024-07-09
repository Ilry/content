local GemoverProducer = Class(function(self, inst)
    self.inst = inst

    --self.stacksize = 1
    --self.erased_prefab = "papyrus"

    self.inst:AddTag("papereraser")
end)

function GemoverProducer:OnRemoveFromEntity()
    self.inst:RemoveTag("papereraser")
end

function GemoverProducer:DoErase(gem, doer)
    return gem.components.scrachifiersharder:DoErase(self.inst, doer) ~= nil
end

return GemoverProducer