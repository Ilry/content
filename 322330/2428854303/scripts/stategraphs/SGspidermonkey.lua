require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.PICKUP, "action"),
    ActionHandler(ACTIONS.STEAL, "action"),
    ActionHandler(ACTIONS.PICK, "action"),
    ActionHandler(ACTIONS.HARVEST, "action"),
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
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
			inst.sg:GoToState("attack", data.target)
        end
    end),

    EventHandler("agitated", function(inst, data)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("busy") then
            inst.sg:GoToState("taunt")
        end
    end),
}

local states =
{
    State
    {
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
        
        end,
    
        events =
        {
            EventHandler("animover", function(inst) 

                if (inst.components.combat.target and
                    inst.components.combat.target:HasTag("player")) or inst:HasTag("agitated") then

                    if math.random() < 0.1 then
                        inst.sg:GoToState("taunt")
                        return
                    end
                end

                inst.sg:GoToState("idle") 

            end),
        },
    },

    State
    {
        name = "action",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("interact", true)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
        end,

        onexit = function(inst)
            inst:PerformBufferedAction()
            inst.SoundEmitter:KillSound("make")
        end,

        events =
        {
            EventHandler("animover", function (inst)
                inst.sg:GoToState("idle")
            end),
        }
    }, 

    State
    {
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
                    inst:DoTaskInTime((i * waittime), function() inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/bite") end)
                end
            end)
        },

        events =
        {
            EventHandler("animover", function (inst)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State
    {
        name = "taunt",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

        timeline = 
        {
            TimeEvent(19*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/taunt") end),
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/step",nil,.5) end),
            TimeEvent(22*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/step") end),
        },
        
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State
    {
        name = "throw",
        tags = {"attack", "busy", "canrotate", "throwing"},
        
        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("throw")
        end,

        timeline = 
        {
            TimeEvent(14*FRAMES, function(inst) inst.components.combat:DoAttack() end),
        },
        
        events =
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
        
        TimeEvent(1*FRAMES, function(inst) PlayFootstep(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/step") end),
        TimeEvent(2*FRAMES, function(inst) PlayFootstep(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/step") end),
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
		TimeEvent(0, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/sleep") end),
	},
	
	endtimeline =
    {

    },
})

CommonStates.AddCombatStates(states,
{
    attacktimeline = 
    {        
       TimeEvent(1*FRAMES, function(inst)inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/swipe") end),
        TimeEvent(11*FRAMES, function(inst) inst.components.combat:DoAttack() end)
    },

    hittimeline =
    {
    TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/hurt") end),
    },

    deathtimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/enemy/spidermonkey/death") end),
    },
})

CommonStates.AddFrozenStates(states)


return StateGraph("spidermonkey", states, events, "idle", actionhandlers)