require("stategraphs/commonstates")

local Utils = require("mym_utils/utils")
local GetPrefab = require("mym_utils/getprefab")
local ModUtils = require("mym_modutils")

AddStategraphEvent("wilson", EventHandler("doattack", function(inst, data)
    local target = data.target
    target = target:IsValid() and target or inst.components.combat.target
    if not target
        or (inst.components.channelcaster and inst.components.channelcaster:IsChanneling()) --火女释放月焰时不应该打破
    then
        return
    end
    inst:PushBufferedAction(BufferedAction(inst, target, ACTIONS.ATTACK)) --是否死亡会在后面判断
end))

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.EXTINGUISH, "dolongaction"))

local fx_over_prefabs = {
    "fx_lightning_over_book"
}
local fx_under_prefabs = {
    "fx_tentacles_under_book",
    "fx_plants_small_under_book",
    "fx_plants_big_under_book",
    "fx_roots_under_book",
    "fx_fish_under_book",
}

AddStategraphState("wilson", State {
    name = "mym_use_skill",
    tags = { "doing", "busy", "canrotate" },

    onenter = function(inst)
        local buf = inst:GetBufferedAction()
        if not buf then --应该不可能
            inst.sg:GoToState("idle")
            return
        end
        if buf.target then
            inst:FacePoint(buf.target.Transform:GetWorldPosition())
        end

        local state = inst.components.mym_mate.skillData.state
        inst.sg.statemem.skillState = state

        if state == "castspellmind" then
            inst.SoundEmitter:PlaySound("meta3/willow/pyrokinetic_activate")
            inst.AnimState:PlayAnimation("pyrocast_pre") --4 frames
            inst.AnimState:PushAnimation("pyrocast", false)
        elseif state == "book" then
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("book", false)

            local suffix = inst.components.rider:IsRiding() and "_mount" or ""
            inst.sg.statemem.fx_over = SpawnPrefab(fx_over_prefabs[math.random(1, #fx_over_prefabs)] .. suffix)
            inst.sg.statemem.fx_over.entity:SetParent(inst.entity)
            inst.sg.statemem.fx_over.Follower:FollowSymbol(inst.GUID, "swap_book_fx_over", 0, 0, 0, true)

            inst.sg.statemem.fx_under = SpawnPrefab(fx_under_prefabs[math.random(1, #fx_under_prefabs)] .. suffix)
            inst.sg.statemem.fx_under.entity:SetParent(inst.entity)
            inst.sg.statemem.fx_under.Follower:FollowSymbol(inst.GUID, "swap_book_fx_under", 0, 0, 0, true)

            -- 音效先不加
        end

        inst.components.locomotor:Stop()
    end,

    timeline =
    {
        FrameEvent(11, function(inst)
            if inst.sg.statemem.skillState == "book" then
                inst:PerformBufferedAction()
            end
        end),
        TimeEvent(15 * FRAMES, function(inst)
            if inst.sg.statemem.skillState == "castspellmind" then
                inst:PerformBufferedAction()
            end
        end),
        TimeEvent(19 * FRAMES, function(inst)
            if inst.sg.statemem.skillState == "book" then
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end
        end),
        TimeEvent(51 * FRAMES, function(inst)
            if inst.sg.statemem.skillState == "book" then
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
            end
        end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        if inst.sg.statemem.fx_over ~= nil and inst.sg.statemem.fx_over:IsValid() then
            inst.sg.statemem.fx_over:Remove()
        end
        if inst.sg.statemem.fx_under ~= nil and inst.sg.statemem.fx_under:IsValid() then
            inst.sg.statemem.fx_under:Remove()
        end
    end,
})

local LocomoteFn = CommonHandlers.OnLocomote(true, false).fn
AddStategraphPostInit("wilson", function(sg)
    Utils.FnDecorator(sg.events["locomote"], "fn", function(inst)
        if inst:HasTag("mym_mate") then
            LocomoteFn(inst)
            return nil, true
        end
    end)

    ------------------------------------------------------------------------------------------------
    -- 加快队友砍树速度（可能加过头了）
    Utils.FnDecorator(sg.actionhandlers[ACTIONS.CHOP], "deststate", function(inst)
        return { inst.sg:HasStateTag("chopping") and "chop" or "chop_start" },
            inst:HasTag("mym_mate") and (GetTime() - inst.sg.statestarttime) > 4 * FRAMES
    end)

    ------------------------------------------------------------------------------------------------

    Utils.FnDecorator(sg.states["idle"], "onenter", function(inst)
        local leader = inst.components.follower and inst.components.follower.leader
        if inst:HasTag("mym_mate")
            and math.random() < 0.03             --概率尽量小一点儿
            and (inst.soundsname or inst.prefab) -- 初始化需要
            and (not leader or ((not leader.components.combat or not leader.components.combat.target) and inst:IsNear(leader, 20)))
            and not inst.components.combat.target
            and not GetPrefab.IsInCombat(inst, 20)
        then
            -- 跳舞
            local data = GetRandomItem(EMOTE_ITEMS).data
            if not inst.components.inventory:IsHeavyLifting()
                and (data.mounted or not inst.components.rider:IsRiding())
                and (not data.mountonly or inst.components.rider:IsRiding())
                and (data.beaver or not inst:HasTag("beaver"))
                and (data.moose or not inst:HasTag("weremoose"))
                and (data.goose or not inst:HasTag("weregoose")) then
                inst.sg:GoToState("emote", data)
                return nil, true
            end
        end
    end)

    Utils.FnDecorator(sg.states["emote"], "onenter", function(inst)
        if inst:HasTag("mym_mate") and not inst.components.timer:TimerExists("mym_emote_duration") then
            inst.components.timer:StartTimer("mym_emote_duration", math.random(10, 30))
        end
    end)
    -- 我不希望一直跳
    Utils.FnDecorator(sg.states["emote"], "onupdate", function(inst)
        if inst:HasTag("mym_mate") then
            local leader = inst.components.follower and inst.components.follower.leader
            if not inst.components.timer:TimerExists("mym_emote_duration")
                or inst.components.combat.target
                or (leader and not inst:IsNear(leader, 20))
            then
                inst.sg:GoToState("idle", true)
                return nil, true
            end
        end
    end)

    -- 猴子直接消失好了
    Utils.FnDecorator(sg.states["death"].events["animover"], "fn", function(inst)
        if inst:HasTag("wonkey") then
            ErodeAway(inst)
            return nil, true
        end
    end)

    ------------------------------------------------------------------------------------------------
    -- mod适配

    -- 弹奏吉他
    if ModUtils.IsModEnableById(ModUtils.MODNAMES.Legion) or ModUtils.IsModEnableById(ModUtils.MODNAMES.Zhijiang) then
        --当leader远离时不再弹奏
        if sg.states["playguitar_loop"] then
            Utils.FnDecorator(sg.states["playguitar_loop"], "onupdate", function(inst)
                local leader = inst.components.follower and inst.components.follower.leader
                if leader and not inst:IsNear(leader, 20) then
                    inst:PushEvent("playenough")
                end
            end)
        end
    end
end)

----------------------------------------------------------------------------------------------------

AddStategraphEvent("berniebig", CommonHandlers.OnLocomote(true, true)) --不考虑其他mod，直接加上应该也没事
