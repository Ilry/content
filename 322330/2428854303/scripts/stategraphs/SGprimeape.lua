require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.PICKUP, "action"),
    ActionHandler(ACTIONS.STEAL, "action"),
    ActionHandler(ACTIONS.PICK, "action"),
    ActionHandler(ACTIONS.HARVEST, "action"),
    ActionHandler(ACTIONS.ATTACK, "throw"),
    ActionHandler(ACTIONS.EAT, "eat"),
}

local events=
{
    CommonHandlers.OnLocomote(false, true),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnSleep(),
    EventHandler("doattack", function(inst, data)
        if not (inst.components.health:IsDead() or inst.sg:HasStateTag("busy")) then
            --If you're not in melee range throw instead.
            --Maybe do some randomness to throw or not?
            --V2C: gdi. because sg events are queued, ALL data can possibly go invalid >_ <""
            inst.sg:GoToState(
                (not (data.target ~= nil and data.target:IsValid()) and "idle") or
                (inst:GetDistanceSqToInst(data.target) <= TUNING.MONKEY_MELEE_RANGE * TUNING.MONKEY_MELEE_RANGE + 1 and "attack") or
                "throw"
            )
        end
    end),
}

local states =
{
    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle_loop", true)
            else
                inst.AnimState:PlayAnimation("idle_loop", true)
            end
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/idle")
        end,

        timeline =
        {

        },

        events=
        {
            EventHandler("animover", function(inst)

                if inst.components.combat.target and
                    inst.components.combat.target:HasTag("player") then

                    if math.random() < 0.05 then
                        inst.sg:GoToState("taunt")
                        return
                    end
                end

                inst.sg:GoToState("idle")

            end),
        },
    },

    State{

        name = "action",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("interact", true)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
        end,
        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
        end,
        events=
        {
            EventHandler("animover", function (inst)
                inst:PerformBufferedAction()
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{

        name = "eat",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat", true)
        end,

        onexit = function(inst)
            inst:PerformBufferedAction()
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
                local waittime = FRAMES*8
                for i = 0, 3 do
                    inst:DoTaskInTime((i * waittime), function() inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/eat") end)
                end
            end)
        },

        events=
        {
            EventHandler("animover", function (inst)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{
        name = "taunt",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
                --12 fist hits
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/taunt")
                local waittime = FRAMES*2
                for i = 0, 11 do
                    inst:DoTaskInTime((i * waittime), function() inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/chest_pound") end)
                end
            end)
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "throw",
        tags = {"attack", "busy", "canrotate", "throwing"},

        onenter = function(inst)
            if not inst.HasAmmo(inst) then
                inst.sg:GoToState("idle")
            end

            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("throw")
        end,

        timeline =
        {
            TimeEvent(14*FRAMES, function(inst) inst.components.combat:DoAttack()
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/throw") end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

CommonStates.AddWalkStates(states,
{
    starttimeline =
    {

    },

	walktimeline =
    {
        TimeEvent(4*FRAMES, function(inst) PlayFootstep(inst) end),
        TimeEvent(5*FRAMES, function(inst) PlayFootstep(inst) end),
        TimeEvent(10*FRAMES, function(inst)
            PlayFootstep(inst)
            if math.random() < 0.1 then
                inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/idle")
            end
         end),
        TimeEvent(11*FRAMES, function(inst) PlayFootstep(inst) end),

	},

    endtimeline =
    {

    },
})


CommonStates.AddSleepStates(states,
{
    starttimeline =
    {

    },

    sleeptimeline =
    {
    TimeEvent(1*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/sleep") end),
    },

    endtimeline =
    {

    },
})

CommonStates.AddCombatStates(states,
{
    attacktimeline =
    {
        TimeEvent(17*FRAMES, function(inst)
            inst.components.combat:DoAttack()
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/attack")
        end),
    },

    hittimeline =
    {
    TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/hurt") end),
    },

    deathtimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC002/creatures/monkey_island/death") end),
    },
})

CommonStates.AddFrozenStates(states)


return StateGraph("monkey", states, events, "idle", actionhandlers)
