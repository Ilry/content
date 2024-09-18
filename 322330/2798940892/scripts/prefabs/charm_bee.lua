local beecommon = require "brains/beecommon"

--[[
Bees.lua

bee
Default bee type. Flies around to flowers and pollinates them, generally gets spawned out of beehives or player-made beeboxes

killerbee
Aggressive version of the bee. Doesn't pollinate anythihng, but attacks anything within range. If it has a home to go to and no target,
it should head back there. Killer bees come out to defend beehives when they, the hive or worker bees are attacked
]]--
local assets =
{
    Asset("ANIM", "anim/bee.zip"),
    Asset("ANIM", "anim/bee_build.zip"),
    Asset("ANIM", "anim/bee_angry_build.zip"),
    Asset("INV_IMAGE", "killerbee"),
    Asset("SOUND", "sound/bee.fsb"),
}

local prefabs =
{
    "stinger",
    "honey",
}

local workersounds =
{
    takeoff = "dontstarve/bee/bee_takeoff",
    attack = "dontstarve/bee/bee_attack",
    buzz = "dontstarve/bee/bee_fly_LP",
    hit = "dontstarve/bee/bee_hurt",
    death = "dontstarve/bee/bee_death",
}

local killersounds =
{
    takeoff = "dontstarve/bee/killerbee_takeoff",
    attack = "dontstarve/bee/killerbee_attack",
    buzz = "dontstarve/bee/killerbee_fly_LP",
    hit = "dontstarve/bee/killerbee_hurt",
    death = "dontstarve/bee/killerbee_death",
}

local function OnWorked(inst, worker)
    inst:PushEvent("detachchild")
    if worker.components.inventory ~= nil then
        inst.SoundEmitter:KillAllSounds()

        worker.components.inventory:GiveItem(inst, nil, inst:GetPosition())
    end
end

local function bonus_damage_via_allergy(inst, target, damage, weapon)
    return (target:HasTag("allergictobees") and TUNING.BEE_ALLERGY_EXTRADAMAGE) or 0
end

local function OnDropped(inst)
    if inst.buzzing and not (inst:IsAsleep() or inst.SoundEmitter:PlayingSound("buzz")) then
        inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
    end
    inst.sg:GoToState("catchbreath")
    if inst.components.workable ~= nil then
        inst.components.workable:SetWorkLeft(1)
    end
    if inst.brain ~= nil then
        inst.brain:Start()
    end
    if inst.sg ~= nil then
        inst.sg:Start()
    end
    if inst.components.stackable ~= nil and inst.components.stackable:IsStack() then
        local x, y, z = inst.Transform:GetWorldPosition()
        while inst.components.stackable:IsStack() do
            local item = inst.components.stackable:Get()
            if item ~= nil then
                if item.components.inventoryitem ~= nil then
                    item.components.inventoryitem:OnDropped()
                end
                item.Physics:Teleport(x, y, z)
            end
        end
    end
end

local function OnPickedUp(inst)
    inst.sg:GoToState("idle")
    inst.SoundEmitter:KillSound("buzz")
    inst.SoundEmitter:KillAllSounds()
end

local function EnableBuzz(inst, enable)
    if enable then
        if not inst.buzzing then
            inst.buzzing = true
            if not ( inst:IsAsleep() or inst.SoundEmitter:PlayingSound("buzz")) then
                inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
            end
        end
    elseif inst.buzzing then
        inst.buzzing = false
        inst.SoundEmitter:KillSound("buzz")
    end
end

local function OnWake(inst)
    if inst.buzzing and not ( inst.SoundEmitter:PlayingSound("buzz")) then
        inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
    end
end

local function OnSleep(inst)
    inst.SoundEmitter:KillSound("buzz")
end

local RETARGET_MUST_TAGS = { "_combat", "_health" }
local RETARGET_CANT_TAGS = { "insect", "INLIMBO", "plantkin" }
local RETARGET_ONEOF_TAGS = { "character", "animal", "monster" }
local function KillerRetarget(inst)
    return FindEntity(inst, SpringCombatMod(8),
        function(guy)
            return inst.components.combat:CanTarget(guy)
        end,
        RETARGET_MUST_TAGS,
        RETARGET_CANT_TAGS,
        RETARGET_ONEOF_TAGS)
end

local function SpringBeeRetarget(inst)
    return TheWorld.state.isspring and
        FindEntity(inst, 4,
            function(guy)
                return inst.components.combat:CanTarget(guy)
            end,
			RETARGET_MUST_TAGS,
			RETARGET_CANT_TAGS,
			RETARGET_ONEOF_TAGS)
        or nil
end

local function commonfn(build, tags)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeFlyingCharacterPhysics(inst, 1, .5)

	MakeGhostPhysics(inst, 1, .5)



    inst.DynamicShadow:SetSize(.8, .5)
    inst.Transform:SetFourFaced()

    inst:AddTag("bee")
    inst:AddTag("insect")
    inst:AddTag("smallcreature")
    inst:AddTag("cattoyairborne")
    inst:AddTag("flying")
    inst:AddTag("ignorewalkableplatformdrowning")
    for i, v in ipairs(tags) do
        inst:AddTag(v)
    end

    inst.AnimState:SetBank("bee")
    inst.AnimState:SetBuild(build)
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetRayTestOnBB(true)

    MakeInventoryFloatable(inst)

    MakeFeedableSmallLivestockPristine(inst)
	inst:AddComponent("talker") 
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
	inst.components.locomotor.walkspeed = 10
    inst.components.locomotor.runspeed = 10
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst:SetStateGraph("SGcharm_bee")



    MakeSmallBurnableCharacter(inst, "body", Vector3(0, -1, 1))
    MakeTinyFreezableCharacter(inst, "body", Vector3(0, -1, 1))



    inst:AddComponent("knownlocations")

    ------------------

    inst:AddComponent("inspectable")

    ------------------

    inst.buzzing = true
    inst.EnableBuzz = EnableBuzz
    inst.OnEntityWake = OnWake
    inst.OnEntitySleep = OnSleep

    return inst
end

local workerbrain = require("brains/charm_beebrain")

local function worker_OnIsSpring(inst, isspring)
    if isspring then
        inst.AnimState:SetBuild("bee_angry_build")
    else
        inst.AnimState:SetBuild("bee_build")
    end
end

local function workerbee()

    local inst = commonfn("bee_build", { "worker"})

    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true
	
	
	inst:AddComponent("periodicspawner")
    inst.components.periodicspawner.prefab = "honey"
    inst.components.periodicspawner.basetime = TUNING.TOTAL_DAY_TIME * 2
    inst.components.periodicspawner.randtime = TUNING.TOTAL_DAY_TIME * 2
    inst.components.periodicspawner:Start()
	
	inst:AddComponent("pollinator")
	
    inst:SetBrain(workerbrain)
    inst.sounds = workersounds
	
    inst:WatchWorldState("isspring", worker_OnIsSpring)
    if TheWorld.state.isspring then
        worker_OnIsSpring(inst, true)
    end

    return inst
end



return Prefab("charm_bee", workerbee, assets, prefabs)