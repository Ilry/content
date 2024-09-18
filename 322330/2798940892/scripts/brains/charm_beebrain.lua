require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/wander"
require "behaviours/doaction"
require "behaviours/findflower"
require "behaviours/panic"
local beecommon = require "brains/beecommon"


local TARGET_FOLLOW_DIST = 2
local MAX_FOLLOW_DIST = 5

local MAX_CHASE_DIST = 15
local MAX_CHASE_TIME = 8

local RUN_AWAY_DIST = 6
local STOP_RUN_AWAY_DIST = 10

local MAX_WANDER_DIST_BEE_BEACON = 6

local CHARM_BEEBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
    --self.lastbeebeacon = nil
    self.beebeacontime = GetTime() + math.random()
end)

local function GetOwner(inst)
	local leader = inst.components.follower.leader
	return leader
end
local function KeepFaceTargetFn(inst, target)
    return inst.components.follower.leader == target
end
local function OwnerIsClose(inst)
    local owner = GetOwner(inst)
    return owner ~= nil and owner:IsNear(inst, MAX_FOLLOW_DIST)
end
local function IsHomeOnFire(inst)
    return inst.components.homeseeker
        and inst.components.homeseeker.home
        and inst.components.homeseeker.home.components.burnable
        and inst.components.homeseeker.home.components.burnable:IsBurning()
end

local FINDBEEBEACON_MUST_TAGS = { "beebeacon" }
local FINDBEEBEACON_CANT_TAGS = { "INLIMBO" }

local function FindBeeBeacon(self)
    local t = GetTime()
    if t >= self.beebeacontime then
        self.lastbeebeacon = FindEntity(self.inst, 30, nil, FINDBEEBEACON_MUST_TAGS, FINDBEEBEACON_CANT_TAGS)
        self.beebeacontime = t + 2 + math.random()
    elseif self.lastbeebeacon ~= nil
        and not (self.lastbeebeacon:IsValid() and
                self.lastbeebeacon:HasTag("beebeacon") and
                self.inst:IsNear(self.lastbeebeacon, 30)) then
        self.lastbeebeacon = nil
    end
    return self.lastbeebeacon
end

local function GetBeeBeaconPos(self)
    local target = FindBeeBeacon(self)
    return target ~= nil and target:GetPosition() or nil
end



local function CanHunt(item, inst)
    return item.components.inventoryitem ~= nil and
            item.components.inventoryitem.canbepickedup and
            item.components.inventoryitem.cangoincontainer and
            not item.components.inventoryitem:IsHeld() and
            not item.ischarm_bee_hunt
end


local ORANGE_PICKUP_MUST_TAGS = { "_inventoryitem" }
local ORANGE_PICKUP_CANT_TAGS = { "INLIMBO", "NOCLICK", "knockbackdelayinteraction", "catchable", "fire", "minesprung", "mineactive", "spider","trap"}

local function GoToHunt(inst)

    local target = FindEntity(inst, 15, 
        CanHunt, ORANGE_PICKUP_MUST_TAGS, ORANGE_PICKUP_CANT_TAGS)
    if target then
		target.ischarm_bee_hunt=true
        return BufferedAction(inst, target, ACTIONS.CHARM_BEE_HUNT)
    end
end




function CHARM_BEEBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode( function() return self.inst.components.follower.leader end, "Has Owner",
            PriorityNode{
				DoAction(self.inst, GoToHunt, "go to hunt", true),


                Follow(self.inst, function() return self.inst.components.follower.leader end, 0, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
                FailIfRunningDecorator(FaceEntity(self.inst, GetOwner, KeepFaceTargetFn)),
                StandStill(self.inst),
            }
			),

        StandStill(self.inst),
    }, 1)

    self.bt = BT(self.inst, root)
end

function CHARM_BEEBrain:OnInitializationComplete()
    self.inst.components.knownlocations:RememberLocation("home", self.inst:GetPosition())
end

return CHARM_BEEBrain
