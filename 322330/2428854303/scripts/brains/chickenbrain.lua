require "behaviours/wander"
require "behaviours/leash"
require "behaviours/runaway"
require "behaviours/doaction"
require "behaviours/panic"

local SEE_BAIT_DIST = 15
local MAX_LEASH_DIST = 10
local MAX_WANDER_DIST = 15
local STOP_RUN_DIST = 7
local SEE_PLAYER_DIST = 10
local RUN_TIME_OUT    = 7

local ChickenBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local function EatFoodAction(inst)
    local target = FindEntity(inst, SEE_BAIT_DIST,
        function(item)
            return inst.components.eater:CanEat(item) and
            item.components.bait and
            not item:HasTag("planted") and
            not (item.components.inventoryitem and
            item.components.inventoryitem:IsHeld())
        end)
    if target then
        local act = BufferedAction(inst, target, ACTIONS.EAT)
        act.validfn = function() return not (target.components.inventoryitem and target.components.inventoryitem:IsHeld()) end
        return act
    end
end

local RUN_AWAY_PARAMS =
{
    tags = { "_combat", "_health" },
    notags = { "chickenfamily", "playerghost", "INLIMBO" },
    fn = function(guy)
        return not guy.components.health:IsDead()
            and (guy.components.combat.target ~= nil and
                guy.components.combat.target:HasTag("chickenfamily"))
    end,
}

local function GoHomeAction(inst)
    if inst.components.homeseeker and 
		inst.components.homeseeker.home and 
		inst.components.homeseeker.home:IsValid() and
		inst.sg:HasStateTag("trapped") == false then
        return BufferedAction(inst, inst.components.homeseeker.home, ACTIONS.GOHOME)
    end
end

function ChickenBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return self.inst.components.health.takingfiredamage end, "OnFire", Panic(self.inst)),
        -- WhileNode(function() return self.inst.components.health:GetPercent() < .50 end, "LowHealth",
			-- RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST)),	
		
		-- WhileNode(function() return not TheWorld.state.iscaveday end, "CaveNightness",
			-- DoAction(self.inst, GoHomeAction, "GoHome", true)),
			
		WhileNode(function() return GetTime() - self.inst.components.combat:GetLastAttackedTime() <= RUN_TIME_OUT end, "Attacked",
			RunAway(self.inst, "scarytoprey", SEE_PLAYER_DIST, STOP_RUN_DIST)),
			
        RunAway(self.inst, RUN_AWAY_PARAMS, SEE_PLAYER_DIST, STOP_RUN_DIST),
        RunAway(self.inst, "OnFire", SEE_PLAYER_DIST, STOP_RUN_DIST),
		
		EventNode(self.inst, "GoHome",
			DoAction(self.inst, GoHomeAction, "GoHome", true)),
		
        DoAction(self.inst, EatFoodAction),
        Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST)
    }, .25)

    self.bt = BT(self.inst, root)
end

return ChickenBrain