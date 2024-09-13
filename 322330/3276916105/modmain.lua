local ENV = env
GLOBAL.setfenv(1, GLOBAL)

local GetModConfigData = ENV.GetModConfigData

local brain = require("brains/otterbrain")
local brain_follower = require("brains/otter_followerbrain")

--	Config Tunings

local total_daytime = TUNING.TOTAL_DAY_TIME

TUNING.OTTER_MAX_LOYALTY_TIME = total_daytime * (GetModConfigData("follow_time") or 3)
TUNING.OTTER_FULL_LOYALTY_TIME = TUNING.OTTER_MAX_LOYALTY_TIME * 0.9
TUNING.OTTER_MAX_LOYALTY_PER_KELP = total_daytime * (GetModConfigData("follow_kelp") or 0.5)
TUNING.OTTER_MAX_LOYALTY_PER_MEAT = total_daytime * (GetModConfigData("follow_meat") or 1)
TUNING.OTTER_MAX_LOYALTY_PER_FISH = total_daytime * (GetModConfigData("follow_fish") or 3)

TUNING.OTTER_KELP_PACIFY_RANGE = GetModConfigData("qol_pacify") and 20 or 0
TUNING.OTTER_KELP_PACIFY_TIME = 1
TUNING.OTTER_KELP_PATCH_COOLDOWN = GetModConfigData("qol_patch") or 120
TUNING.OTTER_KELP_PATCH_ENABLED = GetModConfigData("qol_patch") ~= false
TUNING.OTTER_KELP_PATCH_RANGE = 8

TUNING.OTTER_FOLLOW_EATING_COOLDOWN = 120
TUNING.OTTER_FOLLOW_FISHING_COOLDOWN = 60
TUNING.OTTER_FOLLOW_PICKING_COOLDOWN = GetModConfigData("qol_patch") or 240
TUNING.OTTER_FOLLOW_TAGMODE = GetModConfigData("qol_tags") or 1

--	Follower Fns

function IsOtterKelp(inst, item)
	return item and string.find(item.prefab, "kelp")
end

local function OnChangedLeader(inst, new_leader, old_leader)
	inst:SetBrain(new_leader ~= nil and brain_follower or brain)
	
	local mode = TUNING.OTTER_FOLLOW_TAGMODE
	if new_leader then
		if mode == 1 or mode == 3 then
			inst:RemoveTag("hostile")
		end
		if mode == 2 or mode == 3 then
			inst:RemoveTag("monster")
		end
	else
		if mode == 1 or mode == 3 then
			inst:AddTag("hostile")
		end
		if mode == 2 or mode == 3 then
			inst:AddTag("monster")
		end
	end
end

local function ShouldAcceptItem(inst, item)
	if item.components.edible and inst.components.follower:GetLeader() == nil or inst.components.follower:GetLoyaltyPercent() <= TUNING.OTTER_FULL_LOYALTY_TIME then
		return inst.components.eater and inst.components.eater:CanEat(item)
			or IsOtterKelp(inst, item)
	end
		
	return false
end

local function OnGetItemFromPlayer(inst, giver, item)
	local got_food = inst.components.eater and inst.components.eater:CanEat(item)
	local is_heavy = item.components.weighable and item.components.weighable:GetWeightPercent() >= TUNING.HERMITCRAB.HEAVY_FISH_THRESHHOLD
	
	if inst.components.combat:TargetIs(giver) then
		inst.components.combat:SetTarget(nil)
	elseif giver.components.leader then
		giver:PushEvent("makefriend")
		giver.components.leader:AddFollower(inst)
		
		local loyalty = ((got_food and is_heavy) and TUNING.OTTER_MAX_LOYALTY_PER_FISH)
			or (got_food and TUNING.OTTER_MAX_LOYALTY_PER_MEAT)
			or (IsOtterKelp(inst, item) and TUNING.OTTER_MAX_LOYALTY_PER_KELP)
			or nil
		
		if loyalty then
			inst.components.follower:AddLoyaltyTime(loyalty)
		end
	end
	
	if got_food then
		inst.components.eater:Eat(item, giver)
		inst:PushEvent("onfedbyplayer", {food = item, feeder = giver})
	end
	
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	end
end

local function OnRefuseItem(inst, item)
	if inst.components.sleeper:IsAsleep() then
		inst.components.sleeper:WakeUp()
	else
		inst.sg:GoToState("taunt")
	end
end

local PLAYER_TAGS = {"player"}
local PLAYER_NOT_TAGS = {"INLIMBO", "invisible", "playerghost"}

local function KelpLookup(inst, guy)
	if guy and guy:IsValid() and guy.components.inventory then
		local equipped_head = guy.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
		local equipped_body = guy.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY) or nil
		
		return IsOtterKelp(inst, equipped_head) or IsOtterKelp(inst, equipped_body)
	end
	
	return false
end

local function KelpPacify(inst)
	local hippie = FindEntity(inst, TUNING.OTTER_KELP_PACIFY_RANGE, function(guy) return inst:KelpLookup(guy) end, PLAYER_TAGS, PLAYER_NOT_TAGS)
	
	if (hippie or inst.components.follower and inst.components.follower:GetLeader()) then
		if inst.components.timer then
			if inst.components.timer:TimerExists("steallootcooldown") then
				inst.components.timer:SetTimeLeft("steallootcooldown", TUNING.OTTER_KELP_PACIFY_TIME)
			else
				inst.components.timer:StartTimer("steallootcooldown", TUNING.OTTER_KELP_PACIFY_TIME)
			end
			
			if inst.components.timer:TimerExists("picked_something_up_recently") then
				inst.components.timer:SetTimeLeft("picked_something_up_recently", TUNING.OTTER_KELP_PACIFY_TIME)
			else
				inst.components.timer:StartTimer("picked_something_up_recently", TUNING.OTTER_KELP_PACIFY_TIME)
			end
		end
		
		local ba = inst:GetBufferedAction()
		if ba and (ba.action == ACTIONS.STEAL or ba.action == ACTIONS.PICKUP) then
			inst:ClearBufferedAction()
		end
	end
end

local OldTossFish
local function TossFish(inst, item, ...)
	if OldTossFish then
		OldTossFish(inst, item, ...)
	end
	
	if inst.components.follower and inst.components.follower:GetLeader() and inst.components.timer and inst.components.timer:TimerExists("fished_recently") then
		inst.components.timer:SetTimeLeft("fished_recently", TUNING.OTTER_FOLLOW_FISHING_COOLDOWN)
	end
end

local function OnDropItem(inst, data)
	local item = data and data.item
	
	if item and item._anotterpatch and item:IsValid() then
		item:Remove()
	end
end

--	Postinits

ENV.AddPrefabPostInit("otter", function(inst)
	if not TheWorld.ismastersim then
		return
	end
	
	if inst.components.follower == nil then
		inst:AddComponent("follower")
	end
	inst.components.follower.maxfollowtime = TUNING.OTTER_MAX_LOYALTY_TIME
	inst.components.follower.OnChangedLeader = OnChangedLeader
	
	if inst.components.trader == nil then
		inst:AddComponent("trader")
	end
	inst.components.trader.deleteitemonaccept = false
	inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader:SetOnAccept(OnGetItemFromPlayer)
	inst.components.trader:SetOnRefuse(OnRefuseItem)
	
	inst.KelpPacify = KelpPacify
	inst.KelpLookup = KelpLookup
	inst.OnDropItem = OnDropItem
	
	if not OldTossFish then
		OldTossFish = inst.TossFish
	end
	inst.TossFish = TossFish
	
	inst._kelppacify = inst:DoPeriodicTask(0.1, inst.KelpPacify)
	
	inst:ListenForEvent("dropitem", inst.OnDropItem)
end)

--

local Trader = require("components/trader")
	
	local OldAbleToAccept = Trader.AbleToAccept
	function Trader:AbleToAccept(...)
		local test, cause = OldAbleToAccept(self, ...)
		
		if self.inst.prefab == "otter" and not test and cause == "BUSY" then -- Marotters are busy waaaay too often so f this
			return true
		end
		
		return test, cause
	end

--

local actionhandlers = {
	ActionHandler(ACTIONS.REPAIR_LEAK, "drop"),
}

local events = {
	EventHandler("dance", function(inst)
		if not inst.sg:HasStateTag("dancing") and not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("dance")
		end
	end),
}

local states = {
	State{
		name = "dance",
		tags = {"idle", "canrotate", "dancing"},
		
		onenter = function(inst, notaunt)
			inst.Physics:Stop()
			inst.Transform:SetRotation(math.random(360))
			
			if not notaunt then
				inst.AnimState:PlayAnimation("taunt")
				inst.AnimState:PushAnimation("run_pre", false)
				inst.SoundEmitter:PlaySound("meta4/otter/taunt_f0")
			else
				inst.AnimState:PushAnimation("run_loop", false)
			end
		end,
		
		timeline = {
			FrameEvent(4 * FRAMES, function(inst)
				inst.SoundEmitter:PlaySound("meta4/otter/vo_taunt_f8")
			end),
			
			FrameEvent(8 * FRAMES, function(inst)
				if inst.components.amphibiouscreature and not inst.components.amphibiouscreature.in_water then
					inst.SoundEmitter:PlaySound("meta4/otter/run_lp_f8")
				else
					inst.SoundEmitter:PlaySound("turnoftides/common/together/water/submerge/medium")
				end
			end),
		},
		
		events = {
			EventHandler("animqueueover", function(inst)
				inst.sg:GoToState("dance", true)
			end),
		},
	},
}

ENV.AddStategraphPostInit("otter", function(sg)
	for _, act in pairs(actionhandlers) do
		sg.actionhandlers[act.action] = act
	end
	
	for _, event in pairs(events) do
		sg.events[event.name] = event
	end
	
	for _, state in pairs(states) do
		sg.states[state.name] = state
	end
end)