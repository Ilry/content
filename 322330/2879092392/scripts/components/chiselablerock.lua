local MineralLoots = require("mineral_defs")

local ChiselableRock = Class(function(self, inst)
    self.inst = inst

    self.loot = nil
    self.onchiseledfn = nil

    self.inst:AddTag("has_mineral_inside")
end)

function ChiselableRock:OnRemoveFromEntity()
    self.inst:RemoveTag("has_mineral_inside")
end

function ChiselableRock:DropMineral(doer)
    local prefix = "ancientdreams_"

    if self.loot then
        local mineral = PrefabExists(prefix..self.loot) and SpawnPrefab(prefix..self.loot) or SpawnPrefab(self.loot)

        mineral.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
        LaunchAt(mineral, mineral, doer, .8, 1, 1)
    end

    if self.onchiseledfn ~= nil then
        self.onchiseledfn(self.inst, doer)
    end

    local pt = self.inst:GetPosition()
    SpawnPrefab("rock_break_fx").Transform:SetPosition(pt:Get())

    if self.inst.components.workable then
        self.inst.components.workable:Destroy(doer)
    elseif self.inst.components.stackable and self.inst.components.stackable:IsStack() then
        local stack = self.inst.components.stackable:Get()
        stack:Remove()
    else
        self.inst:Remove()
    end
end

function ChiselableRock:SetOnChiseledFn(fn)
    self.onchiseledfn = fn
end

function ChiselableRock:SetMineralLoot(loot)
    self.loot = loot
end

function ChiselableRock:InitRandomMineralLoot()
    local rand = math.random()

    if MineralLoots then
        if rand <= 0.33 then
            self:SetMineralLoot(MineralLoots["tier_3"][math.random(#MineralLoots["tier_3"])])
        elseif rand <= 0.67 then
            self:SetMineralLoot(MineralLoots["tier_2"][math.random(#MineralLoots["tier_2"])])
        else
            self:SetMineralLoot(MineralLoots["tier_1"][math.random(#MineralLoots["tier_1"])])
        end
    end
end

function ChiselableRock:OnSave()
    return
    {
        loot = self.loot
    }
end

function ChiselableRock:OnLoad(data)
    if data and data.loot then
        self.loot = data.loot
    end
end

return ChiselableRock