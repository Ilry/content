GLOBAL.setmetatable(
	env,
	{
		__index = function(t, k)
			return GLOBAL.rawget(GLOBAL, k)
		end
	}
)

local DOES_NOT_BITE_PLAYERS = GetModConfigData("does_not_bite_players")
local STARFISH_RESET_TIME = GetModConfigData("reset_time")
local STARFISH_TRAP_RADIUS = GetModConfigData("trap_radius")
local STARFISH_INVINCIBLE = GetModConfigData("invincible")

TUNING.STARFISH_TRAP_RADIUS = STARFISH_TRAP_RADIUS
TUNING.STARFISH_TRAP_NOTDAY_RESET.BASE = STARFISH_RESET_TIME
TUNING.STARFISH_TRAP_NOTDAY_RESET.VARIANCE = 0

local function on_anim_over(inst)
	if inst.components.mine.issprung then
		return
	end
	---soundhelp i can't get these sounds to play at the begining of idle 2 and idle 3
	---i need your help, your my only hope
	local random_value = math.random()
	if random_value < 0.4 then
		inst.AnimState:PushAnimation("idle_2")
		-- inst.SoundEmitter:PlaySound("turnoftides/creatures/together/starfishtrap/idle")
		inst.AnimState:PushAnimation("idle", true)
	elseif random_value < 0.8 then
		inst.AnimState:PushAnimation("idle_3")
		-- inst.SoundEmitter:PlaySound("turnoftides/creatures/together/starfishtrap/idle")
		inst.AnimState:PushAnimation("idle", true)
	end
end

local mine_test_fn = function(target, inst)
	return not (target.components.health ~= nil and target.components.health:IsDead()) and
		(target.components.combat ~= nil and target.components.combat:CanBeAttacked(inst))
end

local mine_test_tags = {"monster", "animal", "character"}
local mine_must_tags = {"_combat"}
local mine_no_tags = {"notraptrigger", "flying", "ghost", "playerghost", "player"}

local function do_snap(inst)
	-- We're going off whether we hit somebody or not, so play the trap sound.
	inst.SoundEmitter:PlaySound("turnoftides/creatures/together/starfishtrap/trap")

	-- Do an AOE attack, based on how the combat component does it.
	local x, y, z = inst.Transform:GetWorldPosition()
	local target_ents =
		TheSim:FindEntities(x, y, z, TUNING.STARFISH_TRAP_RADIUS, mine_must_tags, mine_no_tags, mine_test_tags)
	for i, target in ipairs(target_ents) do
		if target ~= inst and target.entity:IsVisible() and mine_test_fn(target, inst) then
			target.components.combat:GetAttacked(inst, TUNING.STARFISH_TRAP_DAMAGE)
		end
	end

	if inst._snap_task ~= nil then
		inst._snap_task:Cancel()
		inst._snap_task = nil
	end
end

local function reset(inst)
	inst.components.mine:Reset()
end

local function start_reset_task(inst)
	if inst._reset_task ~= nil then
		inst._reset_task:Cancel()
	end
	local reset_task_randomized_time =
		GetRandomWithVariance(TUNING.STARFISH_TRAP_NOTDAY_RESET.BASE, TUNING.STARFISH_TRAP_NOTDAY_RESET.VARIANCE)
	inst._reset_task = inst:DoTaskInTime(reset_task_randomized_time, reset)
	inst._reset_task_end_time = GetTime() + reset_task_randomized_time
end

local function on_explode(inst, target)
	inst.AnimState:PlayAnimation("trap")
	inst.AnimState:PushAnimation("trap_idle", true)

	inst:RemoveEventCallback("animover", on_anim_over)

	if target ~= nil and inst._snap_task == nil then
		local frames_until_anim_snap = 8
		inst._snap_task = inst:DoTaskInTime(frames_until_anim_snap * FRAMES, do_snap)
	end

	start_reset_task(inst)
end

AddPrefabPostInit(
	"trap_starfish",
	function(inst)
		if inst and inst.components then
			if DOES_NOT_BITE_PLAYERS and inst.components.mine then
				inst.components.mine:SetAlignment("player")
				inst.components.mine:SetOnExplodeFn(on_explode)
			end

			if STARFISH_INVINCIBLE and inst.components.workable then
				local old_onwork = inst.components.workable.onwork
				inst.components.workable:SetOnWorkCallback(
					function(inst, worker, workleft, numworks)
						if worker:HasTag("player") then
							if old_onwork then
								old_onwork(inst, worker, workleft, numworks)
							end
						else
							inst.components.workable:SetWorkLeft(1)
						end
					end
				)
			end
		end
	end
)
