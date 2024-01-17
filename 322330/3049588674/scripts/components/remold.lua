local shadow_power, moon_power = 0, 1

local Remold = Class(function (self, inst)
    self.inst = inst
    self.shadow_molded = false
    self.moon_molded = false
end)

function Remold:GetShadowMolded()
    return self.shadow_molded
end

function Remold:GetMoonMolded()
    return self.moon_molded
end

function Remold:SetMoldState(mold_power)
    if mold_power == shadow_power then
        self.shadow_molded = true
    elseif mold_power == moon_power then
        self.moon_molded = true
    else
        return false
    end
    return true
end

function Remold:OnSave()
    return {
        shadow_molded = self.shadow_molded,
        moon_molded = self.moon_molded
    }
end

function Remold:Onload(data)
    if data.shadow_molded then
        self.shadow_molded = data.shadow_molded 
    end
    if data.moon_molded then
        self.moon_molded = data.shadow_moldemoon_molded
    end
end

return Remold
