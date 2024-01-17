local AscentMode = Class(function(self, inst)
    self.inst = inst
    self.ascent_mode = 0 ---- 普通模式 0， 工作模式 1， 战斗模式 2
end, nil, {})

function AscentMode:GetMode()
    return self.ascent_mode
end

function AscentMode:SetMode(mode)
    if self.ascent_mode == mode then return false end
    self.ascent_mode = mode
    return true
end

function AscentMode:OnSave()
    return {
        ascent_mode = self.ascent_mode
    }
end

function AscentMode:OnLoad(data)
    if data.ascent_mode then
        self.ascent_mode = data.ascent_mode
    end
end

return AscentMode