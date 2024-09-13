require "behaviours/chaseandattack"
require "behaviours/doaction"
require "behaviours/faceentity"
require "behaviours/follow"
require "behaviours/leash"

local BrainCommon = require("brains/braincommon")

local OtterFollowerBrain = Class(Brain, function(self, inst)
	Brain._ctor(self, inst)
	
	self.max_wander_dist = 15
	self.dance_dist = math.random(4, 6)
end)

local MIN_FOLLOW_DIST = 1
local TARGET_FOLLOW_DIST = 6
local MAX_FOLLOW_DIST = 12

local LEASH_DIST = 1

local PICKABLE_MUST_TAGS = {"pickable"}
local PICKABLE_CANT_TAGS = {"burnt", "fire", "FX", "INLIMBO", "outofreach"}
local PICKABLE_ONEOF_TAGS = {"kelp"}

local SEE_ITEM_DISTANCE = 20

local FINDITEMS_CANT_TAGS = {"FX", "DECOR", "INLIMBO", "outofreach"}
local NOT_LEAK_TAGS = {"FX", "DECOR", "INLIMBO"}

--

local function GetLeader(inst)
	return inst.components.follower and inst.components.follower.leader
end

local function GetLeaderPos(inst)
	local leader = GetLeader(inst)
	
	return leader and leader:GetPosition()
end

local function GetTraderFn(inst)
	local leader = GetLeader(inst)
	
	if leader then
		return inst.components.trader and inst.components.trader:IsTryingToTradeWithMe(leader) and leader or nil
	end
end

local function KeepTraderFn(inst, target)
	return inst.components.trader and inst.components.trader:IsTryingToTradeWithMe(target)
end

--

local function FixBoat(inst)
	if inst.components.timer:TimerExists("patch_boat_cooldown") and TUNING.OTTER_KELP_PATCH_ENABLED then
		return nil
	end
	
	local leak, patch
	
	if inst.components.inventory then
		patch = inst.components.inventory:FindItem(function(item) return item.components.boatpatch ~= nil end)
		
		if patch == nil then
			patch = SpawnPrefab("boatpatch_kelp")
			patch._anotterpatch = true
			
			inst.components.inventory:GiveItem(patch)
		end
	end
	
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, TUNING.OTTER_KELP_PATCH_RANGE, nil, NOT_LEAK_TAGS)
	
	for i, v in ipairs(ents) do
		if v.components.boatleak and v.components.boatleak.has_leaks ~= false then
			leak = v
			break
		end
	end
	
	if patch == nil or leak == nil then
		return
	end
	
	local buffered_action = BufferedAction(inst, leak, ACTIONS.REPAIR_LEAK, patch)
	
	inst._start_patch_cooldown_callback = inst._start_patch_cooldown_callback or function()
		inst.components.timer:StartTimer("patch_boat_cooldown", TUNING.OTTER_KELP_PATCH_COOLDOWN)
	end
	buffered_action:AddSuccessAction(inst._start_patch_cooldown_callback)
	
	return buffered_action
end

--

local function TryToPickPickables(inst)
	if inst.sg:HasStateTag("busy") or inst.components.timer:TimerExists("picked_something_up_recently") then
		return
	end
	
	local closest_pickable = FindEntity(inst, SEE_ITEM_DISTANCE, nil, PICKABLE_MUST_TAGS, PICKABLE_CANT_TAGS, PICKABLE_ONEOF_TAGS)
	if not closest_pickable then
		return nil
	end
	
	local buffered_action = BufferedAction(inst, closest_pickable, ACTIONS.PICK)
	
	inst._start_interact_cooldown_callback = inst._start_interact_cooldown_callback or function()
		inst.components.timer:StartTimer("picked_something_up_recently", TUNING.OTTER_FOLLOW_PICKING_COOLDOWN)
	end
	buffered_action:AddSuccessAction(inst._start_interact_cooldown_callback)
	
	return buffered_action
end

local function FindGroundItemAction(inst)
	if inst.sg:HasStateTag("busy") or inst.components.timer:TimerExists("picked_something_up_recently") then
		return
	end
	
	if inst.components.inventory and inst.components.eater then
		local target = inst.components.inventory:FindItem(function(item) return inst.components.eater:CanEat(item) end)
		
		if target then
			return BufferedAction(inst, target, ACTIONS.EAT)
		end
		
		target = FindEntity(inst, SEE_ITEM_DISTANCE, function(item) return inst.components.eater:CanEat(item) and item:GetTimeAlive() >= 3 end, nil, FINDITEMS_CANT_TAGS)
		
		if not target then
			return nil
		end
		
		local buffered_action = BufferedAction(inst, target, ACTIONS.PICKUP)
		
		inst._start_ate_cooldown_callback = inst._start_ate_cooldown_callback or function()
			inst.components.timer:StartTimer("ate_recently", TUNING.OTTER_FOLLOW_EATING_COOLDOWN)
		end
		buffered_action:AddSuccessAction(inst._start_ate_cooldown_callback)
		
		return buffered_action
	end
end

--

local function on_reach_destination(inst, data)
	if data and data.target and data.target:IsValid() and data.target:HasTag("oceanfishable_creature") and data.target:IsOnOcean(false) then
		inst.sg:GoToState("toss_fish", data.target)
	end
end

local MUST_TOSSABLE_TAGS = {"oceanfishable_creature"}
local NOT_TOSSABLE_TAGS = {"INLIMBO", "outofreach", "FX", "fishmeat"}

local function GetNearbyFishTarget(inst)
	return (not inst.components.timer:TimerExists("fished_recently")
		and FindEntity(inst, SEE_ITEM_DISTANCE, function(item) return item:IsOnOcean(false) end, MUST_TOSSABLE_TAGS, NOT_TOSSABLE_TAGS))
		or nil
end

local function TryToFish(inst)
	local nearest_fish = GetNearbyFishTarget(inst)
	
	if nearest_fish then
		inst.components.locomotor:GoToEntity(nearest_fish)
	end
end

--

local function DanceParty(inst)
	inst:PushEvent("dance")
end

local function ShouldDanceParty(inst)
	local leader = GetLeader(inst)
	
	return leader and leader.sg and leader.sg:HasStateTag("dancing")
end

local function ShouldWatchMinigame(inst)
	local leader = GetLeader(inst)
	
	if leader and leader.components.minigame_participator then
		if inst.components.combat and inst.components.combat.target == nil or inst.components.combat.target.components.minigame_participator then
			return true
		end
	end
	
	return false
end

local function WatchingMinigame(inst)
	local leader = GetLeader(inst)
	
	return (leader and leader.components.minigame_participator) and leader.components.minigame_participator:GetMinigame() or nil
end

--

local UPDATE_RATE = 0.25
local ACTION_TIMEOUT_TIME = 10
local STEAL_CHASE_TIMEOUT_TIME = 4

function OtterFollowerBrain:OnStart()
	self.inst:ListenForEvent("onreachdestination", on_reach_destination)
	
	local dance = WhileNode(function() return ShouldDanceParty(self.inst) end, "Dance Party",
		PriorityNode({
			Leash(self.inst, GetLeaderPos, self.dance_dist, self.dance_dist + 2),
			ActionNode(function() DanceParty(self.inst) end),
	}, UPDATE_RATE))
	
	local watch_game = WhileNode( function() return ShouldWatchMinigame(self.inst) end, "Watching Game",
		PriorityNode({
			Follow(self.inst, WatchingMinigame, TUNING.MINIGAME_CROWD_DIST_MIN, TUNING.MINIGAME_CROWD_DIST_TARGET, TUNING.MINIGAME_CROWD_DIST_MAX),
			RunAway(self.inst, "minigame_participator", 5, 7),
			FaceEntity(self.inst, WatchingMinigame, WatchingMinigame),
			
		}, UPDATE_RATE))
	
	local root = PriorityNode({
		FailIfSuccessDecorator(ConditionWaitNode(function() return not self.inst.sg:HasStateTag("jumping") end, "Block While Jumping")),
		BrainCommon.PanicTrigger(self.inst),
		dance,
		watch_game,
		WhileNode(function() return GetTraderFn(self.inst) end, "IsTrading",
			Leash(self.inst, GetLeaderPos, LEASH_DIST, LEASH_DIST),
			FaceEntity(self.inst, GetTraderFn, KeepTraderFn)),
		DoAction(self.inst, FixBoat, "Patch Boat"),
		ChaseAndAttack(self.inst, STEAL_CHASE_TIMEOUT_TIME, 1.5 * self.max_wander_dist),
		WhileNode(function() return self.inst.components.inventory and not self.inst.components.inventory:IsFull() end, "Not Enough Items",
			PriorityNode({
				WhileNode(function() return GetNearbyFishTarget(self.inst) ~= nil end, "Try Fishing",
					ActionNode(function() TryToFish(self.inst) end)
				),
				DoAction(self.inst, FindGroundItemAction, "Look For Ground Edibles", nil, ACTION_TIMEOUT_TIME),
				DoAction(self.inst, TryToPickPickables, "Harvest Kelp", nil, ACTION_TIMEOUT_TIME),
			
			}, UPDATE_RATE)
		),
		Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
		Wander(self.inst, nil, self.max_wander_dist)
	
	}, UPDATE_RATE)
	
	self.bt = BT(self.inst, root)
end

function OtterFollowerBrain:OnStop()
	self.inst:RemoveEventCallback("onreachdestination", on_reach_destination)
end

return OtterFollowerBrain