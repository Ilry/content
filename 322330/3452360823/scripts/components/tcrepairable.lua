local max = TUNING.TC_CHEST_MAX_REPAIR_STATUS_LIMIT

local TCRepairable = Class(function(self, inst)
    self.inst = inst

end)

function TCRepairable:Initialize(data)
    if self.inst.components.armor ~= nil then
        self.type = "armor"
        self.max = data and data.max or self.inst.components.armor.maxcondition * max
        self.inst.components.armor.maxcondition = data and data.max_current or self.inst.components.armor.maxcondition
    elseif self.inst.components.finiteuses ~= nil then
        self.type = "finiteuses"
        self.max = data and data.max or self.inst.components.finiteuses.total * max
        self.inst.components.finiteuses.total = data and data.max_current or self.inst.components.finiteuses.total
    elseif self.inst.components.fueled ~= nil then
        self.type = "fueled"
        self.max = data and data.max or self.inst.components.fueled.maxfuel * max
        self.inst.components.fueled.maxfuel = data and data.max_current or self.inst.components.fueled.maxfuel
    elseif self.inst.components.perishable ~= nil then
        self.type = "perishable"
        self.max = data and data.max or self.inst.components.perishable.perishtime * max
        self.inst.components.perishable.perishtime = data and data.max_current or self.inst.components.perishable.perishtime
    end
end

function TCRepairable:UpgradeStatus(percent_override)
    print("UpgradeStatus", self.type, self.max_current, percent_override)
    local percent = percent_override or TUNING.TC_CHEST_UPGRADE_PERCENT
    local type = self.type
    local inst = self.inst
    self.max_current = self.max_current or 0
    if type == "armor" then
        local armor = inst.components.armor
        armor.maxcondition = math.min(self.max / max * percent + armor.maxcondition, self.max)
        self.max_current = armor.maxcondition
    elseif type == "finiteuses" then
        local finiteuses = inst.components.finiteuses
        finiteuses.total = math.min(self.max / max * percent + finiteuses.total, self.max)
        self.max_current = finiteuses.total
    elseif type == "fueled" then
        local fueled = inst.components.fueled
        fueled.maxfuel = math.min(self.max / max * percent + fueled.maxfuel, self.max)
        self.max_current = fueled.maxfuel
    elseif type == "perishable" then
        local perishable = inst.components.perishable
        perishable.perishtime = math.min(self.max / max * percent + perishable.perishtime, self.max)
        self.max_current = perishable.perishtime
    end
end

function TCRepairable:Repair(percent_override)
    local percent = percent_override or TUNING.TC_CHEST_REPAIR_PERCENT
    local type = self.type
    local inst = self.inst
    if type == "armor" then
        inst.components.armor:Repair(percent * self.max / max)
        self.current = inst.components.armor.condition
    elseif type == "finiteuses" then
        inst.components.finiteuses:Repair(percent * self.max / max)
        self.current = inst.components.finiteuses.current
    elseif type == "fueled" then
        inst.components.fueled:DoDelta(percent * self.max / max)
        self.current = inst.components.fueled.currentfuel
    elseif type == "perishable" then
        inst.components.perishable:AddTime(percent * self.max / max)
        self.current = inst.components.perishable.perishtime
    end
end

function TCRepairable:OnSave()
    return
    {
        max = self.max,
        max_current = self.max_current,
        current = self.current,
	}
end

function TCRepairable:OnLoad(data)
	if data ~= nil then
		self.max = data.max
        self.max_current = data.max_current
        self.current = data.current
        self:Initialize(data)
	end
end

return TCRepairable
