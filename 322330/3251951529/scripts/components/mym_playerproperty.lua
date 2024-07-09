local function onbuilt(inst)
    if not inst.components.locomotor then --我不希望队友也加上标签，角色标签能少一个是一个
        inst:AddTag("mym_playerbuilt")
    end
end

local PlayerProperty = Class(function(self, inst)
    self.inst = inst

    inst:ListenForEvent("onbuilt", onbuilt)
end)

function PlayerProperty:OnSave()
    return {
        builder = self.inst:HasTag("mym_playerbuilt") or nil
    }
end

function PlayerProperty:OnLoad(data)
    if data and data.builder then
        self.inst:AddTag("mym_playerbuilt")
    end
end

return PlayerProperty
