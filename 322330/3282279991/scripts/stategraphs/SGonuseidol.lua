-- local TUNING = GLOBAL.TUNING
local FRAMES = GLOBAL.FRAMES
local EventHandler = GLOBAL.EventHandler
local State = GLOBAL.State
local TimeEvent = GLOBAL.TimeEvent
-- local SpawnPrefab = GLOBAL.SpawnPrefab
-- local Vector3 = GLOBAL.Vector3

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

local OnUseIdolStates =
{
    State{
        name = "onuseidol",
        tags = { "doing", "busy", "nodangle" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("channel_pre")
            inst.AnimState:PushAnimation("channel_loop", true)
            inst.sg:SetTimeout(3)
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
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

}

for _, state in pairs(OnUseIdolStates) do
    AddStategraphState("wilson", state)
end