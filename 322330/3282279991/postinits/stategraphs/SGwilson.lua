local isportable = GetModConfigData("isportable")

local function DoTalkSound(inst)
    if inst.talksoundoverride ~= nil then
        inst.SoundEmitter:PlaySound(inst.talksoundoverride, "talk")
        return true
    elseif not inst:HasTag("mime") then
        inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/talk_LP", "talk")
        return true
    end
end

local function StopTalkSound(inst, instant)
    if not instant and inst.endtalksound ~= nil and inst.SoundEmitter:PlayingSound("talk") then
        inst.SoundEmitter:PlaySound(inst.endtalksound)
    end
    inst.SoundEmitter:KillSound("talk")
end

local function CancelTalk_Override(inst, instant)
	if inst.sg.statemem.talktask ~= nil then
		inst.sg.statemem.talktask:Cancel()
		inst.sg.statemem.talktask = nil
		StopTalkSound(inst, instant)
	end
end

local function OnTalk_Override(inst)
	CancelTalk_Override(inst, true)
	if DoTalkSound(inst) then
		inst.sg.statemem.talktask = inst:DoTaskInTime(1.5 + math.random() * .5, CancelTalk_Override)
	end
	return true
end

local function OnDoneTalking_Override(inst)
	CancelTalk_Override(inst)
	return true
end

local function GetSkillTree(player)
    return player.components.skilltreeupdater
end

local States =
{
    State{
        name = "useidol",
        tags = { "doing", "busy", "nodangle" },

        onenter = function(inst)
            if not isportable then
                if not FindEntity(target, 8, nil, {"moonportal"}) then
                    inst.sg:GoToState("useidol_fail", {reason = "NOPORTALNEAR"})
                end
            end
            ---Useless, why?
            if GetSkillTree(inst) == nil then
                inst.sg:GoToState("useidol_fail", {reason = "NOSKILLTREE"})
            end
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("channel_pre")
            inst.AnimState:PushAnimation("channel_loop", true)
            inst.sg:SetTimeout(3)
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(.7, function(inst)
                if inst.components.talker ~= nil then
                    inst.components.talker:Say(GetString(inst, "ONUSEIDOL"))
                end
            end),
        },

        events =
        {
            EventHandler("ontalk", function(inst)
                if not (inst.AnimState:IsCurrentAnimation("channel_dial_loop") or inst:HasTag("mime")) then
                    inst.AnimState:PlayAnimation("channel_dial_loop", true)
                end
				return OnTalk_Override(inst)
            end),
            EventHandler("donetalking", function(inst)
                if not inst.AnimState:IsCurrentAnimation("channel_loop") then
                    inst.AnimState:PlayAnimation("channel_loop", true)
                end
				return OnDoneTalking_Override(inst)
            end),
        },

        ontimeout = function(inst)
            inst.AnimState:PlayAnimation("channel_pst")
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
			CancelTalk_Override(inst)
        end,

    },

    State{
        name = "useidol_fail",
        tags = { "busy" },

        onenter = function(inst, data)
            inst.sg:GoToState("idle")
            if inst.components.talker then
                inst.components.talker:Say(GetActionFailString(inst, "IDOL_FAIL", data.reason))
            end
        end,
    },
}

for _, state in pairs(States) do
    AddStategraphState("wilson", state)
    AddStategraphState("wilson_client", state)
end

local Util = require "utils"

local function UseIdolDestFn(inst, action)
    if action.invobject ~= nil and action.invobject.prefab == "moonrockidol" then
        return {"useidol"}, true
    end
end

AddStategraphPostInit("wilson", function(self)
    Util.FnDecorator(self.actionhandlers[ACTIONS.CASTSPELL], "deststate", UseIdolDestFn)
end)
AddStategraphPostInit("wilson_client", function(self)
    Util.FnDecorator(self.actionhandlers[ACTIONS.CASTSPELL], "deststate", UseIdolDestFn)
end)

