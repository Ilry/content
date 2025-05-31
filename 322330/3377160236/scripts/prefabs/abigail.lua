local assets =
{
    Asset("ANIM", "anim/player_ghost_withhat.zip"),
    Asset("ANIM", "anim/ghost_abigail_build.zip"),

    Asset("ANIM", "anim/ghost_abigail.zip"),
    Asset("ANIM", "anim/ghost_abigail_gestalt.zip"),

    Asset("ANIM", "anim/lunarthrall_plant_front.zip"),
    Asset("ANIM", "anim/brightmare_gestalt_evolved.zip"),
    Asset("ANIM", "anim/ghost_abigail_commands.zip"),
    Asset("ANIM", "anim/ghost_abigail_gestalt_build.zip"),
    Asset("ANIM", "anim/ghost_abigail_shadow_build.zip"),
    Asset("ANIM", "anim/ghost_abigail_resurrect.zip"),
    Asset("ANIM", "anim/ghost_wendy_resurrect.zip"),

    Asset("ANIM", "anim/ghost_abigail_human.zip"),

    Asset("SOUND", "sound/ghost.fsb"),
}

local prefabs =
{
    "abigail_attack_fx",
    "abigail_attack_fx_ground",
	"abigail_retaliation",
	"abigailforcefield",
	"abigaillevelupfx",
	"abigail_vex_debuff",
}

local brain = require("brains/abigailbrain")

local function UpdateGhostlyBondLevel(inst, level)
	local max_health = level == 3 and TUNING.ABIGAIL_HEALTH_LEVEL3
					or level == 2 and TUNING.ABIGAIL_HEALTH_LEVEL2
					or TUNING.ABIGAIL_HEALTH_LEVEL1

	local health = inst.components.health
	if health ~= nil then
		if health:IsDead() then
			health.maxhealth = max_health
		else
			local health_percent = health:GetPercent()
			health:SetMaxHealth(max_health)
			health:SetPercent(health_percent, true)
		end

	    if inst._playerlink ~= nil and inst._playerlink.components.pethealthbar ~= nil then
	        inst._playerlink.components.pethealthbar:SetMaxHealth(max_health)
		end
	end

	local light_vals = TUNING.ABIGAIL_LIGHTING[level] or TUNING.ABIGAIL_LIGHTING[1]
	if light_vals.r ~= 0 then
		inst.Light:Enable(not inst.inlimbo)
		inst.Light:SetRadius(light_vals.r)
		inst.Light:SetIntensity(light_vals.i)
		inst.Light:SetFalloff(light_vals.f)
	else
		inst.Light:Enable(false)
	end
    inst.AnimState:SetLightOverride(light_vals.l)
end

local ABIGAIL_DEFENSIVE_MAX_FOLLOW_DSQ = TUNING.ABIGAIL_DEFENSIVE_MAX_FOLLOW * TUNING.ABIGAIL_DEFENSIVE_MAX_FOLLOW
local function IsWithinDefensiveRange(inst)
    return inst._playerlink and inst:GetDistanceSqToInst(inst._playerlink) < ABIGAIL_DEFENSIVE_MAX_FOLLOW_DSQ
end

local COMBAT_MUSHAVE_TAGS = { "_combat", "_health" }
local COMBAT_CANTHAVE_TAGS = { "INLIMBO", "noauradamage", "companion" }

local COMBAT_MUSTONEOF_TAGS_AGGRESSIVE = { "monster", "prey", "insect", "hostile", "character", "animal" }
local COMBAT_MUSTONEOF_TAGS_DEFENSIVE = { "monster", "prey" }

local COMBAT_TARGET_DSQ = TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE * TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE

local function HasFriendlyLeader(inst, target)
    local leader = inst.components.follower.leader
    if leader ~= nil then
        local target_leader = (target.components.follower ~= nil) and target.components.follower.leader or nil

        if target_leader and target_leader.components.inventoryitem then
            target_leader = target_leader.components.inventoryitem:GetGrandOwner()
            -- Don't attack followers if their follow object has no owner
            if target_leader == nil then
                return true
            end
        end

        local PVP_enabled = TheNet:GetPVPEnabled()

        return leader == target or (target_leader ~= nil
                and (target_leader == leader or (target_leader:HasTag("player")
                and not PVP_enabled))) or
                (target.components.domesticatable and target.components.domesticatable:IsDomesticated()
                and not PVP_enabled) or
                (target.components.saltlicker and target.components.saltlicker.salted
                and not PVP_enabled)
    end

    return false
end

local function CommonRetarget(inst, v)
    return v ~= inst and v ~= inst._playerlink and v.entity:IsVisible()
            and v:GetDistanceSqToInst(inst._playerlink) < COMBAT_TARGET_DSQ
            and inst.components.combat:CanTarget(v)
            and v.components.minigame_participator == nil
            and not HasFriendlyLeader(inst, v)

end

local function DefensiveRetarget(inst)
    if inst._playerlink == nil then
        return nil
    elseif not IsWithinDefensiveRange(inst) then
        return nil
    else
        local ix, iy, iz = inst.Transform:GetWorldPosition()
        local entities_near_me = TheSim:FindEntities(
            ix, iy, iz, TUNING.ABIGAIL_DEFENSIVE_MAX_FOLLOW,
            COMBAT_MUSHAVE_TAGS, COMBAT_CANTHAVE_TAGS, COMBAT_MUSTONEOF_TAGS_DEFENSIVE
        )

        local leader = inst.components.follower.leader

        for _, v in ipairs(entities_near_me) do
            if CommonRetarget(inst, v)
                    and (v.components.combat.target == inst._playerlink or
                        inst._playerlink.components.combat.target == v or
                        v.components.combat.target == inst) then

                return v
            end
        end

        return nil
    end
end

local function AggressiveRetarget(inst)
    if inst._playerlink == nil then
        return nil
    else
        local ix, iy, iz = inst.Transform:GetWorldPosition()
        local entities_near_me = TheSim:FindEntities(
            ix, iy, iz, TUNING.ABIGAIL_COMBAT_TARGET_DISTANCE,
            COMBAT_MUSHAVE_TAGS, COMBAT_CANTHAVE_TAGS, COMBAT_MUSTONEOF_TAGS_AGGRESSIVE
        )

        local leader = inst.components.follower.leader

        for _, v in ipairs(entities_near_me) do
            if CommonRetarget(inst, v) then
                return v
            end
        end

        return nil
    end
end

local function StartForceField(inst)
	if not inst.sg:HasStateTag("dissipate") and not inst:HasDebuff("forcefield") and (inst.components.health == nil or not inst.components.health:IsDead()) then
		local elixir_buff = inst:GetDebuff("elixir_buff")
		inst:AddDebuff("forcefield", elixir_buff ~= nil and elixir_buff.potion_tunings.shield_prefab or "abigailforcefield")
	end
end

local function OnAttacked(inst, data)
    if data.attacker == nil then
        inst.components.combat:SetTarget(nil)
    elseif not data.attacker:HasTag("noauradamage") then
        if not inst.is_defensive then
            inst.components.combat:SetTarget(data.attacker)
        elseif inst:IsWithinDefensiveRange() and inst._playerlink:GetDistanceSqToInst(data.attacker) < ABIGAIL_DEFENSIVE_MAX_FOLLOW_DSQ then
            -- Basically, we avoid targetting the attacker if they're far enough away that we wouldn't reach them anyway.
            inst.components.combat:SetTarget(data.attacker)
        end
    end

	if inst:HasDebuff("forcefield") then
		if data.attacker ~= nil and data.attacker ~= inst._playerlink and data.attacker.components.combat ~= nil then
			local elixir_buff = inst:GetDebuff("elixir_buff")
			if elixir_buff ~= nil and elixir_buff.prefab == "ghostlyelixir_retaliation_buff" then
				local retaliation = SpawnPrefab("abigail_retaliation")
				retaliation:SetRetaliationTarget(data.attacker)
				inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/on")
			else
				inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/on")
			end
		end
    end

    StartForceField(inst)
end

local function OnBlocked(inst, data)
    if data ~= nil and inst._playerlink ~= nil and data.attacker == inst._playerlink then
		if inst.components.health ~= nil and not inst.components.health:IsDead() then
			inst._playerlink.components.ghostlybond:Recall()
		end
	end
end

local function OnDeath(inst)
    inst.components.aura:Enable(false)
	inst:RemoveDebuff("ghostlyelixir")
	inst:RemoveDebuff("forcefield")
end

local function OnRemoved(inst)
    inst:BecomeDefensive()
end

local function auratest(inst, target)
    if target == inst._playerlink then
        return false
    end

	if target.components.minigame_participator ~= nil then
		return false
	end

    if (target:HasTag("player") and not TheNet:GetPVPEnabled()) or target:HasTag("ghost") or target:HasTag("noauradamage") then
        return false
    end

    local leader = inst.components.follower.leader
    if leader ~= nil
        and (leader == target
            or (target.components.follower ~= nil and
                target.components.follower.leader == leader)) then
        return false
    end

    if inst.is_defensive and not IsWithinDefensiveRange(inst) then
        return false
    end

    if inst.components.combat.target == target then
        return true
    end

    if target.components.combat.target ~= nil
        and (target.components.combat.target == inst or
            target.components.combat.target == leader) then
        return true
    end

    local ismonster = target:HasTag("monster")
    if ismonster and not TheNet:GetPVPEnabled() and 
       ((target.components.follower and target.components.follower.leader ~= nil and 
         target.components.follower.leader:HasTag("player")) or target.bedazzled) then
        return false
    end

    if target:HasTag("companion") then
        return false
    end

    return ismonster or target:HasTag("prey")
end

local function UpdateDamage(inst)
    local buff = inst:GetDebuff("elixir_buff")

	local phase = (buff ~= nil and buff.prefab == "ghostlyelixir_attack_buff") and "night" or TheWorld.state.phase
	inst.components.combat.defaultdamage = (TUNING.ABIGAIL_DAMAGE[phase] or TUNING.ABIGAIL_DAMAGE.day) / TUNING.ABIGAIL_VEX_DAMAGE_MOD -- so abigail does her intended damage defined in tunings.lua

    inst.attack_level = phase == "day" and 1
						or phase == "dusk" and 2
						or 3

    -- If the animation fx was already playing we update its animation
    local level_str = tostring(inst.attack_level)
    if inst.attack_fx and not inst.attack_fx.AnimState:IsCurrentAnimation("attack" .. level_str .. "_loop") then
        inst.attack_fx.AnimState:PlayAnimation("attack" .. level_str .. "_loop", true)
    end

    if inst.attack_fx_ground and not inst.attack_fx_ground.AnimState:IsCurrentAnimation("attack" .. level_str .. "_ground_loop") then
        inst.attack_fx_ground.AnimState:PlayAnimation("attack" .. level_str .. "_ground_loop", true)
    end
end

local function AbigailHealthDelta(inst, data)
	if inst._playerlink ~= nil then
		if data.oldpercent > data.newpercent and data.newpercent <= 0.25 and not inst.issued_health_warning then
			inst._playerlink.components.talker:Say(GetString(inst._playerlink, "ANNOUNCE_ABIGAIL_LOW_HEALTH"))
			inst.issued_health_warning = true
		elseif data.oldpercent < data.newpercent and data.newpercent > 0.33 then
			inst.issued_health_warning = false
		end
	end
end

local function DoAppear(sg)
	sg:GoToState("appear")
end

local function AbleToAcceptTest(inst, item)
    return false, item.prefab == "reviver" and "ABIGAILHEART" or nil
end

local function OnDebuffAdded(inst, name, debuff)
    if inst._playerlink ~= nil and inst._playerlink.components.pethealthbar ~= nil and name == "elixir_buff" then
        inst._playerlink.components.pethealthbar:SetSymbol(debuff.prefab)
    end
end

local function OnDebuffRemoved(inst, name, debuff)
    if inst._playerlink ~= nil and inst._playerlink.components.pethealthbar ~= nil and name == "elixir_buff" then
		inst._playerlink.components.pethealthbar:SetSymbol(0)
	end
end

local function on_ghostlybond_level_change(inst, player, data)
	if not inst.inlimbo and data.level > 1 and not inst.sg:HasStateTag("busy") and (inst.components.health == nil or not inst.components.health:IsDead()) then
		inst.sg:GoToState("ghostlybond_levelup", {level = data.level})
	end

	UpdateGhostlyBondLevel(inst, data.level)
end

local function BecomeAggressive(inst)
    inst.AnimState:OverrideSymbol("ghost_eyes", "ghost_abigail_build", "angry_ghost_eyes")
    inst.is_defensive = false
    inst._playerlink:AddTag("has_aggressive_follower")
    inst.components.combat:SetRetargetFunction(0.5, AggressiveRetarget)
end

local function BecomeDefensive(inst)
    inst.AnimState:ClearOverrideSymbol("ghost_eyes")
    inst.is_defensive = true
	if inst._playerlink ~= nil then
	    inst._playerlink:RemoveTag("has_aggressive_follower")
	end
    inst.components.combat:SetRetargetFunction(0.5, DefensiveRetarget)
end

local function onlostplayerlink(inst)
	inst._playerlink = nil
end

local function ApplyDebuff(inst, data)
	local target = data ~= nil and data.target
	if target ~= nil then
        target:AddDebuff("abigail_vex_debuff", "abigail_vex_debuff")

        local debuff = target:GetDebuff("abigail_vex_debuff")
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil and debuff ~= nil then
            debuff.AnimState:OverrideItemSkinSymbol("flower", skin_build, "flower", inst.GUID, "abigail_attack_fx" )
        end
	end
end

local function linktoplayer(inst, player)
    inst.persists = false
    inst._playerlink = player

    BecomeDefensive(inst)

    inst:ListenForEvent("healthdelta", AbigailHealthDelta)
    inst:ListenForEvent("onareaattackother", ApplyDebuff)

    player.components.leader:AddFollower(inst)
    if player.components.pethealthbar ~= nil then
        player.components.pethealthbar:SetPet(inst, "", TUNING.ABIGAIL_HEALTH_LEVEL1)

        local elixir_buff = inst:GetDebuff("elixir_buff")
        if elixir_buff then
            player.components.pethealthbar:SetSymbol(elixir_buff.prefab)
        end
    end

    UpdateGhostlyBondLevel(inst, player.components.ghostlybond.bondlevel)
    inst:ListenForEvent("ghostlybond_level_change", inst._on_ghostlybond_level_change, player)
    inst:ListenForEvent("onremove", inst._onlostplayerlink, player)
end

local function OnExitLimbo(inst)
	local level = (inst._playerlink ~= nil and inst._playerlink.components.ghostlybond ~= nil) and inst._playerlink.components.ghostlybond.bondlevel or 1
	local light_vals = TUNING.ABIGAIL_LIGHTING[level] or TUNING.ABIGAIL_LIGHTING[1]
	inst.Light:Enable(light_vals.r ~= 0)
end

local function getstatus(inst)
	local bondlevel = (inst._playerlink ~= nil and inst._playerlink.components.ghostlybond ~= nil) and inst._playerlink.components.ghostlybond.bondlevel or 0
	return bondlevel == 3 and "LEVEL3"
		or bondlevel == 2 and "LEVEL2"
		or "LEVEL1"
end

-- 隐身脱战
local function UndoTransparency(inst)

    -- inst.components.fader:Fade(0.3, 1.0, 0.75, do_transparency)
    inst.fade_toggle:set(false)

    if not inst:HasTag("gestalt") then inst.components.aura:Enable(true) end

    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "transparency")
    inst:RemoveTag("notarget")
    inst._is_transparent = false

    inst.sg:GoToState("escape_end")
end

local function DoGhostEscape(inst)
    if (inst.sg and inst.sg:HasStateTag("nocommand"))
            or (inst.components.health and inst.components.health:IsDead()) then
        return
    end

    inst.components.aura:Enable(false)

    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "transparency", 1.25)
    inst:AddTag("notarget")
    inst._is_transparent = true

    inst._undo_transparency_task = inst:DoTaskInTime(TUNING.WENDYSKILL_ESCAPE_TIME, UndoTransparency)
    inst.fade_toggle:set(true)
    -- Pushing a nil target should cause anybody targetting Abigail to drop her.
    inst:PushEvent("transfercombattarget", nil)
    inst.components.combat:SetTarget(nil)
    inst.sg:GoToState("escape")
end

-- 冲刺
local function SetTransparentPhysics(inst, on)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith((TheWorld:CanFlyingCrossBarriers() and COLLISION.GROUND) or COLLISION.WORLD)
    if not on then
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:CollidesWith(COLLISION.GIANTS)
    end
end

local function do_transparency(transparency_level, inst)
    inst.AnimState:OverrideMultColour(1.0, 1.0, 1.0, transparency_level)
end

local function OnFadeToggleDirty(inst)
    inst.AnimState:UsePointFiltering(inst.fade_toggle:value())
    if inst.fade_toggle:value() then
        inst.components.fader:Fade(1.0, 0.3, 0.75, do_transparency)
    else
        inst.components.fader:Fade(1.0, 1.0, 1.0, do_transparency)
    end
end

local ATTACK_MUST_TAGS = {"_health", "_combat"}
local ATTACK_NO_TAGS = {"DECOR", "FX", "INLIMBO", "NOCLICK"}
local function DoGhostAttackAt(inst, pos)
    if (inst.sg and inst.sg:HasStateTag("nocommand"))
            or (inst.components.health and inst.components.health:IsDead()) then
        return
    end

    local px, py, pz = pos:Get()
    local targets_near_position = TheSim:FindEntities(px, py, pz, 2, ATTACK_MUST_TAGS, ATTACK_NO_TAGS)
    if #targets_near_position > 0 then
        inst.components.combat:SetTarget(targets_near_position[1])

        local timer = inst.components.timer
        if timer:TimerExists("block_retargets") then
            timer:SetTimeLeft("block_retargets", TUNING.WENDYSKILL_COMMAND_COOLDOWN)
        else
            timer:StartTimer("block_retargets", TUNING.WENDYSKILL_COMMAND_COOLDOWN)
        end
    else
        inst.components.combat:SetTarget(nil)
    end

    inst.components.aura:Enable(false)

    inst.sg:GoToState("abigail_attack_start", pos)
end

-- 作祟
local HAUNT_CANT_TAGS = {"catchable", "DECOR", "FX", "haunted", "INLIMBO", "NOCLICK"}
local function DoGhostHauntAt(inst, pos)
    print("执行作祟命令")
    if (inst.sg and inst.sg:HasStateTag("nocommand"))
            or (inst.components.health and inst.components.health:IsDead()) then
        print("sg出了问题")
        return
    end

    local px, py, pz = pos:Get()
    local targets_near_position = TheSim:FindEntities(px, py, pz, 2, nil, HAUNT_CANT_TAGS)
    if #targets_near_position > 0 then
        inst._haunt_target = targets_near_position[1]
        inst:ListenForEvent("onremove", inst._OnHauntTargetRemoved, inst._haunt_target)
    end
end

-- 丢失目标
local function OnDroppedTarget(inst, data)
    -- If we're blocking retargets but our target went away/died,
    -- allow ourselves to go back to target grabbing again.
    inst.components.timer:StopTimer("block_retargets")
end

local function NewHealthSetVal(inst)
    inst.components.health.SetVal = function(self, val, cause, afflicter)
        local old_health = self.currenthealth
        local max_health = self:GetMaxWithPenalty()
        local min_health = math.min(self.minhealth or 0, max_health)

        self.inst:PushEvent("pre_health_setval", {val=val, old_health=old_health})

        if val > max_health then
            val = max_health
        end

        if val <= min_health then
            self.currenthealth = min_health
            self.inst:PushEvent("minhealth", { cause = cause, afflicter = afflicter })
        else
            self.currenthealth = val
        end

        if old_health > 0 and self.currenthealth <= 0 then
            local wendy = inst._playerlink
            if wendy and
                    wendy.components.skilltreeupdater and
                    wendy.components.skilltreeupdater:IsActivated("wendy_sisturn_protection") and
                    not wendy.components.timer:TimerExists("wendy_sisturn_protection_cd")
            then
                wendy.components.timer:StartTimer("wendy_sisturn_protection_cd", TUNING.WENDY_SISTURN_PROTECTION)
                local sisturn_bonus = wendy.components.ghostlybond.externalbondtimemultipliers:Get()
                if sisturn_bonus and sisturn_bonus > 1 then
                    self.currenthealth = 1
                    wendy.components.ghostlybond:Recall()
                    TheWorld:PushEvent("abigail_will_die")
                    return
                end
            end

            -- NOTES(JBK): Make sure to keep the events fired up to date with the explosive component.
            --Push world event first, because the entity event may invalidate itself
            --i.e. items that use .nofadeout and manually :Remove() on "death" event
            TheWorld:PushEvent("entity_death", { inst = self.inst, cause = cause, afflicter = afflicter })
            self.inst:PushEvent("death", { cause = cause, afflicter = afflicter })

            --Here, check if killing player or monster
            local notify_type = (self.inst.isplayer and "TotalPlayersKilled") or "TotalEnemiesKilled"
            NotifyPlayerProgress(notify_type, 1, afflicter)

            --V2C: If "death" handler removes ourself, then the prefab should explicitly set nofadeout = true.
            --     Intentionally NOT using IsValid() here to hide those bugs.
            if not self.nofadeout then
                self.inst:AddTag("NOCLICK")
                self.inst.persists = false
                self.inst.erode_task = self.inst:DoTaskInTime(self.destroytime or 2, ErodeAway)
            end
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("ghost")
    inst.AnimState:SetBuild("ghost_abigail_build")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim_bloom_ghost.ksh")

    inst:AddTag("character")
    inst:AddTag("scarytoprey")
    inst:AddTag("girl")
    inst:AddTag("ghost")
    inst:AddTag("flying")
    inst:AddTag("noauradamage")
    inst:AddTag("notraptrigger")
    inst:AddTag("abigail")
    inst:AddTag("NOBLOCK")

    inst:AddTag("trader") --trader (from trader component) added to pristine state for optimization
	inst:AddTag("ghostlyelixirable") -- for ghostlyelixirable component

    MakeGhostPhysics(inst, 1, .5)

    inst.Light:SetIntensity(.6)
    inst.Light:SetRadius(.5)
    inst.Light:SetFalloff(.6)
    inst.Light:Enable(false)
    inst.Light:SetColour(180 / 255, 195 / 255, 225 / 255)

    --It's a loop that's always on, so we can start this in our pristine state
    -- inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_howl_LP", "howl")

    inst.fade_toggle = net_bool(inst.GUID, "abigail.fade_toggle", "fade_toggledirty")
    inst.fade_toggle:set(false)

    if not TheNet:IsDedicated() then
        inst:AddComponent("fader")
        inst:ListenForEvent("fade_toggledirty", OnFadeToggleDirty)
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.scrapbook_damage = { TUNING.ABIGAIL_DAMAGE.day, TUNING.ABIGAIL_DAMAGE.night }
    inst.scrapbook_ignoreplayerdamagemod = true

    inst._playerlink = nil

    inst:SetBrain(brain)

    inst:AddComponent("locomotor") -- locomotor must be constructed before the stategraph
    inst.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.5
    inst.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED
    inst.components.locomotor.pathcaps = { allowocean = true, ignorecreep = true }
    inst.components.locomotor:SetTriggersCreep(false)

    inst:SetStateGraph("SGabigail")
	inst.sg.OnStart = DoAppear

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("debuffable")
	inst.components.debuffable.ondebuffadded = OnDebuffAdded
	inst.components.debuffable.ondebuffremoved = OnDebuffRemoved

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.ABIGAIL_HEALTH_LEVEL1)
    inst.components.health:StartRegen(1, 1)
	inst.components.health.nofadeout = true
	inst.components.health.save_maxhealth = true
    NewHealthSetVal(inst)

    inst:AddComponent("combat")
    inst.components.combat.playerdamagepercent = TUNING.ABIGAIL_DMG_PLAYER_PERCENT
	inst.components.combat:SetKeepTargetFunction(auratest)

    inst:AddComponent("aura")
    inst.components.aura.radius = 4
    inst.components.aura.tickperiod = 1
    inst.components.aura.ignoreallies = true
    inst.components.aura.auratestfn = auratest

    inst.SetTransparentPhysics = SetTransparentPhysics
    --inst._haunt_target = nil
    inst._OnHauntTargetRemoved = function()
        if inst._haunt_target then
            inst:RemoveEventCallback("onremove", inst._OnHauntTargetRemoved, inst._haunt_target)
            inst._haunt_target = nil
        end
    end

    inst.auratest = auratest


    ------------------
    --Added so you can attempt to give hearts to trigger flavour text when the action fails
    inst:AddComponent("trader")
    inst.components.trader:SetAbleToAcceptTest(AbleToAcceptTest)

	inst:AddComponent("ghostlyelixirable")

    inst:AddComponent("follower")
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
	inst.components.follower.keepleaderduringminigame = true

	inst:AddComponent("timer")

    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("blocked", OnBlocked)
    inst:ListenForEvent("death", OnDeath)
    inst:ListenForEvent("onremove", OnRemoved)
	inst:ListenForEvent("exitlimbo", OnExitLimbo)

    inst:ListenForEvent("do_ghost_escape", DoGhostEscape)
    inst:ListenForEvent("do_ghost_attackat", DoGhostAttackAt)
    inst:ListenForEvent("do_ghost_hauntat", DoGhostHauntAt)
    inst:ListenForEvent("droppedtarget", OnDroppedTarget)

    inst.BecomeDefensive = BecomeDefensive
    inst.BecomeAggressive = BecomeAggressive

    inst.IsWithinDefensiveRange = IsWithinDefensiveRange

    inst.LinkToPlayer = linktoplayer


    inst.is_defensive = true
    inst.issued_health_warning = false

    inst:WatchWorldState("phase", UpdateDamage)
	UpdateDamage(inst, TheWorld.state.phase)
	inst.UpdateDamage = UpdateDamage

	inst._on_ghostlybond_level_change = function(player, data) on_ghostlybond_level_change(inst, player, data) end
	inst._onlostplayerlink = function(player) onlostplayerlink(inst, player) end

    return inst
end

-------------------------------------------------------------------------------

local function SetRetaliationTarget(inst, target)
	inst._RetaliationTarget = target
	inst.entity:SetParent(target.entity)
	local s = (1 / target.Transform:GetScale()) * (target:HasTag("largecreature") and 1.1 or .8)
	if s ~= 1 and s ~= 0 then
		inst.Transform:SetScale(s, s, s)
	end

	inst.detachretaliationattack = function(t)
		if inst._RetaliationTarget ~= nil and inst._RetaliationTarget == t then
			inst.entity:SetParent(nil)
			inst.Transform:SetPosition(t.Transform:GetWorldPosition())
		end
	end

	inst:ListenForEvent("onremove", inst.detachretaliationattack, target)
	inst:ListenForEvent("death", inst.detachretaliationattack, target)
end

local function DoRetaliationDamage(inst)
	local target = inst._RetaliationTarget
	if target ~= nil and target:IsValid() and not target.inlimbo and target.components.combat ~= nil then
		target.components.combat:GetAttacked(inst, TUNING.GHOSTLYELIXIR_RETALIATION_DAMAGE)
		inst:detachretaliationattack(target)
        inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/shield/retaliation_fx")

	end
end

local function retaliationattack_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("abigail_shield")
    inst.AnimState:SetBuild("abigail_shield")
    inst.AnimState:PlayAnimation("retaliation_fx")
    inst.AnimState:SetBloomEffectHandle("shaders/anim_bloom_ghost.ksh")
    inst.AnimState:SetLightOverride(.1)
	inst.AnimState:SetFinalOffset(3)

    --It's a loop that's always on, so we can start this in our pristine state
    -- inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_howl_LP", "howl")

	inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst._RetaliationTarget = nil
	inst.SetRetaliationTarget = SetRetaliationTarget
	inst:DoTaskInTime(12*FRAMES, DoRetaliationDamage)
	inst:DoTaskInTime(30*FRAMES, inst.Remove)

	return inst
end

-------------------------------------------------------------------------------

local function do_hit_fx(inst)
	local fx = SpawnPrefab("abigail_vex_hit")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
end

local function on_target_attacked(inst, target, data)
	if data ~= nil and data.attacker ~= nil and data.attacker:HasTag("ghostlyfriend") then
		inst.hitevent:push()
	end
end

local function buff_OnExtended(inst)
	if inst.decaytimer ~= nil then
		inst.decaytimer:Cancel()
	end
	inst.decaytimer = inst:DoTaskInTime(TUNING.ABIGAIL_VEX_DURATION, function() inst.components.debuff:Stop() end)
end

local function buff_OnAttached(inst, target)
	if target ~= nil and target:IsValid() and not target.inlimbo and target.components.combat ~= nil and target.components.health ~= nil and not target.components.health:IsDead() then
		target.components.combat.externaldamagetakenmultipliers:SetModifier(inst, TUNING.ABIGAIL_VEX_DAMAGE_MOD)

		inst.entity:SetParent(target.entity)
		inst.Transform:SetPosition(0, 0, 0)
		local s = (1 / target.Transform:GetScale()) * (target:HasTag("largecreature") and 1.6 or 1.2)
		if s ~= 1 and s ~= 0 then
			inst.Transform:SetScale(s, s, s)
		end

		inst:ListenForEvent("attacked", inst._on_target_attacked, target)
	end

	buff_OnExtended(inst)

    inst:ListenForEvent("death", function() inst.components.debuff:Stop() end, target)
end

local function buff_OnDetached(inst, target)
	if inst.decaytimer ~= nil then
		inst.decaytimer:Cancel()
		inst.decaytimer = nil

		if target ~= nil and target:IsValid() and target.components.combat ~= nil then
			target.components.combat.externaldamagetakenmultipliers:RemoveModifier(inst)
		end

		inst.AnimState:PushAnimation("vex_debuff_pst", false)
		inst:ListenForEvent("animqueueover", inst.Remove)
	end
end

local function abigail_vex_debuff_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	inst.AnimState:SetBank("abigail_debuff_fx")
	inst.AnimState:SetBuild("abigail_debuff_fx")

	inst.AnimState:PlayAnimation("vex_debuff_pre")
	inst.AnimState:PushAnimation("vex_debuff_loop", true)
	inst.AnimState:SetFinalOffset(3)

	inst:AddTag("FX")

	inst.hitevent = net_event(inst.GUID, "abigail_vex_debuff.hitevent")

	if not TheNet:IsDedicated() then
        inst:ListenForEvent("abigail_vex_debuff.hitevent", do_hit_fx)
	end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
	inst._on_target_attacked = function(target, data) on_target_attacked(inst, target, data) end

    inst:AddComponent("debuff")
    inst.components.debuff:SetAttachedFn(buff_OnAttached)
    inst.components.debuff:SetDetachedFn(buff_OnDetached)
    inst.components.debuff:SetExtendedFn(buff_OnExtended)

	return inst
end


-------------------------------------------------------------------------------

local function abigail_vex_hit_fn()
    local inst = CreateEntity()

	inst:AddTag("CLASSIFIED")
    --[[Non-networked entity]]
    inst.entity:AddTransform()
    inst.entity:AddAnimState()

	inst.AnimState:SetBank("abigail_debuff_fx")
	inst.AnimState:SetBuild("abigail_debuff_fx")

	inst.AnimState:PlayAnimation("vex_hit")
	inst.AnimState:SetFinalOffset(3)

	inst:AddTag("FX")

    inst.persists = false
	inst:ListenForEvent("animover", inst.Remove)

	return inst
end

return Prefab("abigail", fn, assets, prefabs),
	   Prefab("abigail_retaliation", retaliationattack_fn, {Asset("ANIM", "anim/abigail_shield.zip")} ),
	   Prefab("abigail_vex_debuff", abigail_vex_debuff_fn, {Asset("ANIM", "anim/abigail_debuff_fx.zip")}, {"abigail_vex_hit"} ),
	   Prefab("abigail_vex_hit", abigail_vex_hit_fn, {Asset("ANIM", "anim/abigail_debuff_fx.zip")} )
