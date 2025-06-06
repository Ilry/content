require("stategraphs/commonstates")

local function getidleanim(inst)

    if not inst.components.timer:TimerExists("flicker_cooldown") and 
        TheWorld.components.sisturnregistry and 
        TheWorld.components.sisturnregistry:IsBlossom() and 
        math.random()<0.2 and
        not inst.components.debuffable:HasDebuff("abigail_murder_buff") then
            
        inst.components.timer:StartTimer("flicker_cooldown", math.random()*20  + 10 )

        return "idle_abigail_flicker"
    end

    return (inst._is_transparent and "abigail_escape_loop")
        or (inst.components.aura.applying and "attack_loop")
        or (inst.is_defensive and math.random() < 0.1 and "idle_custom")
        or "idle"
end

local function startaura(inst)
    if inst.components.health:IsDead() or inst.sg:HasStateTag("dissipate") or inst:HasTag("gestalt") then
        return
    end

    inst.Light:SetColour(255/255, 32/255, 32/255)
    inst.AnimState:SetMultColour(207/255, 92/255, 92/255, 1)

    inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/attack_LP", "angry")

    local attack_anim = "attack" .. tostring(inst.attack_level or 1)

    inst.attack_fx = SpawnPrefab("abigail_attack_fx")
    inst:AddChild(inst.attack_fx)
    inst.attack_fx.AnimState:PlayAnimation(attack_anim .. "_pre")
    inst.attack_fx.AnimState:PushAnimation(attack_anim .. "_loop", true)

    if inst:HasDebuff("abigail_murder_buff") then
        inst.attack_fx.AnimState:SetBuild("abigail_attack_fx_shadow_build")

        inst.attack_fx.AnimState:OverrideSymbol("fx_swirl",       "abigail_attack_fx_shadow_build",      "fx_swirl")
        inst.attack_fx.AnimState:OverrideSymbol("fx_aoe_swirl",       "abigail_attack_fx_shadow_build",      "fx_aoe_swirl")
        inst.attack_fx.AnimState:OverrideSymbol("fx_swirl_01",       "abigail_attack_fx_shadow_build",      "fx_swirl_01")
    end

    local skin_build = inst:GetSkinBuild()
    if skin_build then
        inst.attack_fx.AnimState:OverrideItemSkinSymbol("flower", skin_build, "flower", inst.GUID, "abigail_attack_fx")
    end
end

local function stopaura(inst)
    inst.Light:SetColour(180/255, 195/255, 225/255)
    inst.SoundEmitter:KillSound("angry")
    inst.AnimState:SetMultColour(1, 1, 1, 1)

    if inst.attack_fx then
        inst.attack_fx:kill_fx(inst.attack_level or 1)
        inst.attack_fx = nil
    end
end

local function onattack(inst)

    if inst:HasTag("gestalt") and
       inst.components.health ~= nil and
       not inst.components.health:IsDead() and
       not inst.sg:HasStateTag("busy") then
        inst.sg:GoToState("gestalt_attack")
    end
end

local DASHATTACK_MUST_TAGS = {"_combat"}
local function dash_attack_onupdate(inst, dt)

    if not inst.sg.mem.aoe_attack_times then return end
    if inst:HasTag("gestalt") then return end

    local aura = inst.components.aura
    local combat = inst.components.combat
    local current_attack_time
    local ix, iy, iz = inst.Transform:GetWorldPosition()
    local hittable_entities = TheSim:FindEntities(ix, iy, iz, aura.radius, DASHATTACK_MUST_TAGS, aura.auraexcludetags)    

    for _, hittable_entity in pairs(hittable_entities) do


        local leader = inst._playerlink     

        if hittable_entity ~= inst and
                combat:IsValidTarget(hittable_entity) and
                not inst.components.combat:IsAlly(hittable_entity) and
                (leader == nil or not leader.components.combat:IsAlly(hittable_entity)) and                
                inst:auratest(hittable_entity, true) then
            current_attack_time = inst.sg.mem.aoe_attack_times[hittable_entity]
            if not current_attack_time or (current_attack_time - dt <= 0) then
                inst.sg.mem.aoe_attack_times[hittable_entity] = TUNING.WENDYSKILL_DASHATTACK_HITRATE

                inst:PushEvent("onareaattackother", { target = hittable_entity, weapon = nil, stimuli = nil })
                local dmg, spdmg = combat:CalcDamage(hittable_entity, nil, combat.areahitdamagepercent)
                hittable_entity.components.combat:GetAttacked(inst, dmg, nil, nil, spdmg)
            else
                inst.sg.mem.aoe_attack_times[hittable_entity] = current_attack_time - dt
            end
        end
    end
end

local actionhandlers =
{
    ActionHandler(ACTIONS.HAUNT, "haunt_pre"),
}

local events =
{
    CommonHandlers.OnLocomote(true, true),
    EventHandler("doattack", onattack),
    EventHandler("startaura", startaura),
    EventHandler("stopaura", stopaura),
    EventHandler("attacked", function(inst)        
        if not (inst.components.health:IsDead() or inst.sg:HasStateTag("dissipate")) and not inst.sg:HasStateTag("nointerrupt")  and not inst.sg:HasStateTag("swoop") then
            inst.sg:GoToState("hit")
        end
    end),
    EventHandler("dance", function(inst)
        if not (inst.sg:HasStateTag("dancing") or inst.sg:HasStateTag("busy") or
                inst.components.health:IsDead() or inst.sg:HasStateTag("dissipate")) then
            inst.sg:GoToState("dance")
        end
    end),
    EventHandler("gestalt_mutate", function(inst, data)
        inst.sg:GoToState("abigail_transform_pre", {gestalt=data.gestalt})
    end),

    EventHandler("start_playwithghost", function(inst, data)
        local target = data.target
        if target and target:IsValid() and not inst.sg:HasStateTag("playing")
                and (GetTime() - (inst.sg.mem.lastplaytime or 0)) > TUNING.ABIGAIL_PLAYFUL_DELAY then
            inst.sg.mem.queued_play_target = target
            target:PushEvent("ghostplaywithme", { target = inst })
        end
    end),
}

local states =
{
    State{
        name = "idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            if inst.sg.mem.queued_play_target then
                inst.sg.mem.lastplaytime = GetTime()
                inst.sg:GoToState("play", inst.sg.mem.queued_play_target)
                inst.sg.mem.queued_play_target = nil
            else
                local anim = getidleanim(inst)
                if anim ~= nil then
                    inst.AnimState:PlayAnimation(anim)
                end
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
            EventHandler("startaura", function(inst)
                if not inst:HasTag("gestalt") then
                    inst.sg:GoToState("attack_start")
                end
            end),
        },

    },

    State{
        name = "attack_start",
        tags = { "busy", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("attack_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "appear",
        tags = { "busy", "noattack", "nointerrupt" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("appear")
			if inst.components.health then
		        inst.components.health:SetInvincible(true)
			end
            --inst:updatehealingbuffs()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if not inst:HasTag("gestalt") then inst.components.aura:Enable(true) end
	        inst.components.health:SetInvincible(false)
			if inst._playerlink then
				inst._playerlink.components.ghostlybond:SummonComplete()
			end
        end,
    },

    State{
        name = "dance",
        tags = {"idle", "dancing"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()
            inst.AnimState:PushAnimation("dance", true)
        end,
    },

    State{
        name = "hit",
        tags = { "busy" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "dissipate",
        tags = { "busy", "noattack", "nointerrupt", "dissipate" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("dissipate")

	        inst.components.health:SetInvincible(true)
			inst.components.aura:Enable(false)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
					if inst._playerlink and inst._playerlink.components.ghostlybond then
						inst.sg:GoToState("dissipated")
					else
						inst:Remove()
					end
                end
            end)
        },

		onexit = function(inst)
	        inst.components.health:SetInvincible(false)
            inst:BecomeDefensive()
		end,
    },

    State{
        name = "dissipated",
        tags = { "busy", "noattack", "nointerrupt", "dissipate" },

        onenter = function(inst)
            inst.Physics:Stop()
			inst.components.aura:Enable(false)
			if inst._playerlink then
				inst._playerlink.components.ghostlybond:RecallComplete()
			end
			if inst.components.health:IsDead() then
				inst.components.health:SetCurrentHealth(1)
			end
            --inst:updatehealingbuffs()
        end,
    },

    State{
        name = "ghostlybond_levelup",
        tags = { "busy" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("flower_change")

			inst.sg.statemem.level = (data ~= nil and data.level) or nil
        end,

        timeline =
        {
			TimeEvent(14 * FRAMES, function(inst)
                local change_sound = (inst.sg.statemem.level == 3 and "dontstarve/characters/wendy/abigail/level_change/2")
                    or "dontstarve/characters/wendy/abigail/level_change/1"
                inst.SoundEmitter:PlaySound(change_sound)
            end),
			TimeEvent(15 * FRAMES, function(inst)
				local fx = SpawnPrefab("abigaillevelupfx")
				fx.entity:SetParent(inst.entity)

                local skin_build = inst:GetSkinBuild()
                if skin_build ~= nil then
                    fx.AnimState:OverrideItemSkinSymbol("flower", skin_build, "flower", inst.GUID, "abigail_attack_fx" )
                end
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "walk_start",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            if inst.AnimState:AnimDone() or inst.AnimState:GetCurrentAnimationLength() == 0 then
                inst.sg:GoToState("walk")
            else
                inst.components.locomotor:WalkForward()
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("walk")
                end
            end),
        },
    },

    State{
        name = "walk",
        tags = { "moving", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            local anim = getidleanim(inst)
            if anim then
                inst.AnimState:PlayAnimation(anim)
            end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline =
        {
            TimeEvent(FRAMES, function(inst)
                if math.random() < 0.8 then
                    if inst:HasTag("gestalt") then
                        inst.SoundEmitter:PlaySound("meta5/abigail/gestalt_abigail_idle")
                    else
                        inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/howl")
                    end
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("walk")
        end,
    },

    State{
        name = "walk_stop",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "run_start",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            if inst.AnimState:AnimDone() or inst.AnimState:GetCurrentAnimationLength() == 0 then
                inst.sg:GoToState("run")
            else
                inst.components.locomotor:RunForward()
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("run")
                end
            end),
        },
    },

    State{
        name = "run",
        tags = { "moving", "running", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            local anim = getidleanim(inst)
            if anim then
                inst.AnimState:PlayAnimation(anim)
            end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        timeline =
        {
            TimeEvent(FRAMES, function(inst)
                if math.random() < 0.8 then
                    if inst:HasTag("gestalt") then
                        inst.SoundEmitter:PlaySound("meta5/abigail/gestalt_abigail_idle")
                    else
                        inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/howl")
                    end
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("run")
        end,
    },

    State{
        name = "run_stop",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State {
        name = "abigail_attack_start",
        tags = { "busy", "nointerrupt", "swoop" }, --"noattack", 

        onenter = function(inst, target_position)
            inst.Transform:SetEightFaced()

            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("abigail_attack_pre")

            if target_position then
                inst:ForceFacePoint(target_position:Get())
            end

            local ipos = inst:GetPosition()
            local route = (target_position - ipos)
            local _, route_length = route:GetNormalizedAndLength()
            inst.sg.statemem.route_time = route_length / TUNING.WENDYSKILL_DASHATTACK_VELOCITY
        end,

        timeline = {

            FrameEvent(10, function(inst)
                inst.sg.mem.aoe_attack_times = {}

                if not inst:HasTag("gestalt") then
                    inst.Light:SetColour(255/255, 32/255, 32/255)
                    inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/abigail/attack_LP", "angry")
                    inst.AnimState:SetMultColour(207/255, 92/255, 92/255, 1)

                    inst.sg.mem.abigail_attack_fx = SpawnPrefab("abigail_attack_fx")
                    inst:AddChild(inst.sg.mem.abigail_attack_fx)

                    local attack_anim = "attack" .. tostring(inst.attack_level or 1)
    
                    inst.sg.mem.abigail_attack_fx.AnimState:PlayAnimation(attack_anim .. "_pre")
                    inst.sg.mem.abigail_attack_fx.AnimState:PushAnimation(attack_anim .. "_loop", true)                    
                end

            end)
        },

        onupdate = dash_attack_onupdate,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg.statemem.exit_success = true
                inst.sg:GoToState("abigail_attack_loop", inst.sg.statemem.route_time)
            end)
        },

        onexit = function(inst)
            if not inst.sg.statemem.exit_success then
                inst.Transform:SetNoFaced()

                inst.sg.mem.aoe_attack_times = nil
                if not inst:HasTag("gestalt") then 
                    inst.components.aura:Enable(true)
                    inst.Light:SetColour(180/255, 195/255, 225/255)
                    inst.SoundEmitter:KillSound("angry")
                    inst.AnimState:SetMultColour(1, 1, 1, 1)
                end
                if inst.sg.mem.abigail_attack_fx then
                    inst.sg.mem.abigail_attack_fx:Remove()
                end
            end
        end,
    },

    State {
        name = "abigail_attack_loop",
        tags = {"busy", "swoop" },

        onenter = function(inst, loop_time)
            inst:SetTransparentPhysics(true)
            inst.AnimState:PlayAnimation("abigail_attack_loop", true)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.Physics:Stop()
            inst.Physics:SetMotorVelOverride(TUNING.WENDYSKILL_DASHATTACK_VELOCITY, 0, 0)
            inst.sg:SetTimeout(loop_time or 1.75)
        end,

        onupdate = dash_attack_onupdate,

        ontimeout = function(inst)
            inst.sg.statemem.exit_success = true
            inst.sg:GoToState("abigail_attack_end")
        end,

        onexit = function(inst)
            inst.components.locomotor:Stop()
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst:SetTransparentPhysics(false)

            inst.sg.mem.aoe_attack_times = nil

            inst.Light:SetColour(180/255, 195/255, 225/255)
            inst.SoundEmitter:KillSound("angry")
            inst.AnimState:SetMultColour(1, 1, 1, 1)
            if inst.sg.mem.abigail_attack_fx then
                inst.sg.mem.abigail_attack_fx:Remove()
            end

            if not inst.sg.statemem.exit_success then
                inst.Transform:SetNoFaced()
                if not inst:HasTag("gestalt") then
                    inst.components.aura:Enable(true)
                end
            end
        end,
    },

    State {
        name = "abigail_attack_end",
        tags = { "busy", "nointerrupt", "swoop" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("abigail_attack_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        onexit = function(inst)
            inst.Transform:SetNoFaced()
            if not inst:HasTag("gestalt") then
                inst.components.aura:Enable(true)
            end
        end,
    },

    State {
        name = "escape",
        tags = { "busy", "noattack", "nointerrupt" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("abigail_escape_pre")

            inst.components.health:SetInvincible(true)

            inst.Transform:SetTwoFaced()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg.statemem._finished = true
                inst.sg:GoToState("run_start")
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem._finished then
	            inst.components.health:SetInvincible(false)
            end
        end,
    },

    State {
        name = "escape_end",
        tags = { "busy", "noattack", "nointerrupt" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("abigail_escape_pst")

            inst.Transform:SetNoFaced()
        end,

        timeline = {
            FrameEvent(16, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("run_start")
            end),
        },

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
        end,
    },

    State {
        name = "scare",
        tags = { "busy", "nointerrupt"},

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("abigail_scare")
            inst.SoundEmitter:PlaySound("meta5/abigail/jumpscare")
        end,

        timeline =
        {
			SoundFrameEvent(14, "dontstarve/characters/wendy/abigail/level_change/2"),
			FrameEvent(15, function(inst)
				local fx = SpawnPrefab("abigaillevelupfx")
				fx.entity:SetParent(inst.entity)

                local skin_build = inst:GetSkinBuild()
                if skin_build ~= nil then
                    fx.AnimState:OverrideItemSkinSymbol("flower", skin_build, "flower", inst.GUID, "abigail_attack_fx" )
                end

                inst:PushEvent("do_ghost_scare")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State {
        name = "abigail_transform_pre",
        tags = { "busy" },

        onenter = function(inst, data)
            inst.sg.statemem.gestalt = data.gestalt
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("abigail_transform_pre")
        end,

        timeline =
        {
            FrameEvent(15, function(inst)

            end),
        },

        onexit = function(inst, data)
            if inst.sg.statemem.gestalt  then
                inst:SetToGestalt()
            else
                inst:SetToNormal()
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("abigail_transform")
                end
            end),
        },
    },

    State {
        name = "abigail_transform",
        tags = { "busy" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("abigail_transform")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State {
        name = "gestalt_attack",
        tags = { "busy", "nointerrupt"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("meta5/abigail/gestalt_abigail_dashattack_pre")

            inst.Physics:Stop()

            inst.AnimState:PlayAnimation("gestalt_attack_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("gestalt_loop_attack")
                end
            end),
        },
    },

    State {
        name = "gestalt_loop_attack",
        tags = { "busy", "nointerrupt", "swoop"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.Physics:Stop()
            inst:SetTransparentPhysics(true)
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.Physics:ClearMotorVelOverride()
            inst.Physics:SetMotorVelOverride(15, 0, 0)

            inst.AnimState:PlayAnimation("gestalt_attack_loop", true)
            inst.sg:SetTimeout(3)

            inst.sg.statemem.oldattackdamage = inst.components.combat.defaultdamage

            if TheWorld.state.isnight or (inst:HasDebuff("elixir_buff") and inst.components.debuffable:GetDebuff("elixir_buff").prefab == "ghostlyelixir_attack_buff" )  then
                inst.components.combat.defaultdamage = TUNING.ABIGAIL_GESTALT_DAMAGE.night
            elseif TheWorld.state.isday then 
                inst.components.combat.defaultdamage = TUNING.ABIGAIL_GESTALT_DAMAGE.day
            else
                inst.components.combat.defaultdamage = TUNING.ABIGAIL_GESTALT_DAMAGE.dusk
            end

            inst.components.combat:StartAttack()
            inst.sg.statemem.enable_attack = true
        end,

        ontimeout = function(inst)
            inst.sg.statemem.enable_attack = false
        end,

        onupdate = function(inst)

            if inst.components.combat.target and inst.components.combat.target:IsValid() and inst.sg.statemem.enable_attack then
                local x,y,z = inst.components.combat.target.Transform:GetWorldPosition()
                inst:ForceFacePoint(x,y,z)
            end

            if inst.sg.statemem.enable_attack then
                local target = inst.components.combat.target
                if target ~= nil and target:IsValid() and inst:GetDistanceSqToInst(target) <= TUNING.GESTALT_ATTACK_HIT_RANGE_SQ then
                    if inst.components.combat:CanTarget(target) then
                        inst.sg.statemem.enable_attack = false

                        inst.components.combat:DoAttack(target)
                        inst:ApplyDebuff({target=target})

                        if target.components.combat and target.components.combat.hiteffectsymbol then
                        local fx = SpawnPrefab("abigail_gestalt_hit_fx")
                            fx.entity:SetParent(target.entity)
                            target:AddChild(fx)
                            inst.SoundEmitter:PlaySound("meta5/abigail/gestalt_abigail_dashattack_hit")
                        end
                    end
                end
            end

            if (inst.sg.statemem.enable_attack == false or inst.components.combat.target == nil or not inst.components.combat.target:IsValid() or inst.components.combat.target.components.health:IsDead() ) 
                and not inst.end_gestalt_attack_task then
                    inst.end_gestalt_attack_task = inst:DoTaskInTime(0.5,function() inst.sg:GoToState("gestalt_pst_attack") end)
            end
        end,

        onexit = function(inst)
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.components.locomotor:Stop()
            inst.sg.statemem.enable_attack = false

            if inst.end_gestalt_attack_task then
                inst.end_gestalt_attack_task:Cancel()
                inst.end_gestalt_attack_task = nil
            end

            if inst.sg.statemem.oldattackdamage then
                inst.components.combat.defaultdamage = inst.sg.statemem.oldattackdamage
            end

            inst:SetTransparentPhysics(false)
        end,
    },

    State {
        name = "gestalt_pst_attack",
        tags = { "busy", "nointerrupt"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("gestalt_attack_pst")
            inst.SoundEmitter:PlaySound("meta5/abigail/gestalt_abigail_dashattack_pst")            
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
           
    },

    State {
        name = "haunt_pre",
        tags = { "busy", "doing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("dissipate")
            inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_haunt", nil, nil, true)
        end,

        timeline =
        {
            FrameEvent(15, function(inst)
                inst:PerformBufferedAction()
            end)
        },

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("haunt")
            end),
        },
    },

    State {
        name = "haunt",
        tags = { "busy", "doing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("appear")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State {
        name = "play",
		tags = {"busy", "canrotate", "playful"},

        onenter = function(inst, target)
            inst.components.locomotor:StopMoving()

            if target and target:IsValid() then
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end

            inst.AnimState:PlayAnimation("dance")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },
}

return StateGraph("abigail", states, events, "appear", actionhandlers)
