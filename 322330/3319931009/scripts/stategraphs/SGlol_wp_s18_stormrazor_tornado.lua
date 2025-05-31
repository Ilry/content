local db = TUNING.MOD_LOL_WP.STORMRAZOR

require("stategraphs/commonstates")

local events =
{
    EventHandler("locomote", function(inst)
        local is_moving = inst.sg:HasStateTag("moving")
        local is_running = inst.sg:HasStateTag("running")
        local is_idling = inst.sg:HasStateTag("idle")

        local should_move = inst.components.locomotor:WantsToMoveForward()
        local should_run = inst.components.locomotor:WantsToRun()
        if is_moving and not should_move then
            if is_running then
                inst.sg:GoToState("run_stop")
            else
                inst.sg:GoToState("walk_stop")
            end
        elseif (is_idling and should_move) or (is_moving and should_move and is_running ~= should_run) then
            if should_run then
                if inst.sg:HasStateTag("empty") then
                    inst.sg:GoToState("spawn")
                else
                    inst.sg:GoToState("run_start")
                end
            else
                inst.sg:GoToState("walk_start")
            end
        end
    end)
    -- EventHandler("locomote", function(inst)
    --     local is_moving = inst.sg:HasStateTag("moving")
    --     local is_idling = inst.sg:HasStateTag("idle")

    --     local should_move = inst.components.locomotor:WantsToMoveForward()
    --     if is_moving and not should_move then
    --         inst.sg:GoToState("walk_stop")
    --     elseif (is_idling and should_move) then
    --      if inst.sg:HasStateTag("empty") then
    --          inst.sg:GoToState("spawn")
    --      else
    --          inst.sg:GoToState("walk_start")
    --         end
    --     end
    -- end)
}

local WORK_ACTIONS =
{
    CHOP = true,
    DIG = true,
    HAMMER = true,
    MINE = true,
}
local TARGET_TAGS = { "_combat" }
for k, v in pairs(WORK_ACTIONS) do
    table.insert(TARGET_TAGS, k.."_workable")
end
local TARGET_IGNORE_TAGS = { "INLIMBO" }

local function destroystuff(inst)
    -- local x, y, z = inst.Transform:GetWorldPosition()
    -- local ents = TheSim:FindEntities(x, y, z, 3, nil, TARGET_IGNORE_TAGS, TARGET_TAGS)
    -- for i, v in ipairs(ents) do
    --     --stuff might become invalid as we work or damage during iteration
    --     if v ~= inst.WINDSTAFF_CASTER and v:IsValid() then
    --         if v.components.health ~= nil and
    --             not v.components.health:IsDead() and
    --             v.components.combat ~= nil and
    --             v.components.combat:CanBeAttacked() and
    --             (TheNet:GetPVPEnabled() or not (inst.WINDSTAFF_CASTER_ISPLAYER and v:HasTag("player"))) then
    --             local damage =
    --                 inst.WINDSTAFF_CASTER_ISPLAYER and
    --                 v:HasTag("player") and
    --                 TUNING.TORNADO_DAMAGE * TUNING.PVP_DAMAGE_MOD or
    --                 TUNING.TORNADO_DAMAGE
    --             v.components.combat:GetAttacked(inst, damage, nil, "wind")
    --             if v:IsValid() and
    --                 inst.WINDSTAFF_CASTER ~= nil and inst.WINDSTAFF_CASTER:IsValid() and
    --                 v.components.combat ~= nil and
    --                 not (v.components.health ~= nil and v.components.health:IsDead()) and
    --                 not (v.components.follower ~= nil and
    --                     v.components.follower.keepleaderonattacked and
    --                     v.components.follower:GetLeader() == inst.WINDSTAFF_CASTER) then
    --                 v.components.combat:SuggestTarget(inst.WINDSTAFF_CASTER)
    --             end
    --         elseif v.components.workable ~= nil and
    --             v.components.workable:CanBeWorked() and
    --             v.components.workable:GetWorkAction() and
    --             WORK_ACTIONS[v.components.workable:GetWorkAction().id] then
    --             SpawnPrefab("collapse_small").Transform:SetPosition(v.Transform:GetWorldPosition())
    --             v.components.workable:WorkedBy(inst, 2)
    --             --v.components.workable:Destroy(inst)
    --         end
    --     end
    -- end

    local x,_,z = inst:GetPosition():Get()

    local ents = TheSim:FindEntities(x, 0, z, 2, nil, {'player',"companion","structure","wall","abigail","glommer"})

    ---@type ent
    local owner = inst._lol_wp_s18_stormrazor_tornado_belongs_to
    local dmg = db.SKILL_WIND_SLASH.DMG
    if owner and owner.components and owner.components.combat then
        local dmgmult = owner.components.combat.externaldamagemultipliers:Get()
        -- 霸王血钙
        local overload_dmg = 0
        if owner.components.health then
            local equips,found = LOLWP_S:findEquipments(owner,'lol_wp_overlordbloodarmor')
            if found then
                local maxhealth =  owner.components.health and owner.components.health.maxhealth or 0
                local extra_atk = TUNING.MOD_LOL_WP.OVERLORDBLOOD.SKILL_MAXHP_TO_ATK * maxhealth
                local lost_hp = (1-owner.components.health:GetPercent()) * maxhealth
                local extra_atk2 = lost_hp * TUNING.MOD_LOL_WP.OVERLORDBLOOD.SKILL_LOSTHP_TO_ATK
                overload_dmg = overload_dmg + extra_atk + extra_atk2
            end
        end
        -- 狂妄
        local hubris_dmg = 0
        if 1 then
            local equips,found = LOLWP_S:findEquipments(owner,'lol_wp_s14_hubris')
            if found then
                local _db = TUNING.MOD_LOL_WP.HUBRIS
                hubris_dmg = hubris_dmg + _db.DMG_WHEN_EQUIP
                for i,v in ipairs(equips) do
                    if v.components.lol_wp_s14_hubris_skill_reputation then
                        local val = v.components.lol_wp_s14_hubris_skill_reputation:GetStack()
                        if val > 0 then
                            hubris_dmg = hubris_dmg + _db.SKILL_REPUTATION.DMG_PER_STACK * val
                        end
                    end
                end
            end
        end
        -- 三相之力和无尽之刃护符形态提供的攻击倍率加成
        local isequip_trinity = false
        local equip_trinity = LOLWP_U:getEquipInEyeStone(owner,'lol_wp_trinity')
        if equip_trinity then
            isequip_trinity = true
        end
        if not isequip_trinity then
            local _,found = LOLWP_S:findEquipments(owner,'lol_wp_trinity')
            if found then
                isequip_trinity = true
            end
        end
        if isequip_trinity then
            dmgmult = dmgmult * TUNING.MOD_LOL_WP.TRINITY.DMGMULT
        end

        -- local isequip_edge = false
        -- local equip_edge = LOLWP_U:getEquipInEyeStone(owner,'lol_wp_s13_infinity_edge_amulet')
        -- if equip_edge then
        --     isequip_edge = true
        -- end
        -- if not isequip_edge then
        --     local _,found = LOLWP_S:findEquipments(owner,'lol_wp_s13_infinity_edge_amulet')
        --     if found then
        --         isequip_edge = true
        --     end
        -- end
        -- if isequip_edge then
        --     dmgmult = dmgmult * 
        -- end

        dmg = (dmg + overload_dmg + hubris_dmg) * (dmgmult or 1)
        -- ent.components.combat:GetAttacked(owner,dmg) 
    end


    
    for _,ent in pairs(ents) do
        if ent.components.combat and LOLWP_S:checkAlive(ent) then
            local isTarget = true
            if inst._lol_wp_s18_stormrazor_tornado_belongs_to ~= nil and inst._lol_wp_s18_stormrazor_tornado_belongs_to:IsValid() then
                if inst._lol_wp_s18_stormrazor_tornado_belongs_to.components.combat and inst._lol_wp_s18_stormrazor_tornado_belongs_to.components.combat:IsAlly(ent) then
                    isTarget = false
                end
            end
            if isTarget then
                -- ent.components.combat:GetAttacked(inst._lol_wp_s18_stormrazor_tornado_belongs_to,db.SKILL_WIND_SLASH.DMG,inst._lol_wp_s18_stormrazor_tornado_weapon)
                ent.components.health:DoDelta(-dmg)
                ---@type event_data_attacked
                local event_data_attacked = { attacker = owner, damage = dmg, damageresolved = dmg, original_damage = dmg, weapon = inst._lol_wp_s18_stormrazor_tornado_weapon}
                ent:PushEvent("attacked",event_data_attacked)
            end
        end
        if ent:HasTag('boulder') or ent:HasTag('tree') then
            if ent.components.workable and ent.components.workable:CanBeWorked() then
                ent.components.workable:Destroy(inst._lol_wp_s18_stormrazor_tornado_belongs_to)
            end
        end

    end
end

local states =
{
    State{
        name = "empty",
        tags = {"idle", "empty"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("empty")
        end,
    },

    State{
        name = "idle",
        tags = {"idle"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PushAnimation("tornado_loop", false)
            destroystuff(inst)
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
            end)
        },
    },

    State{
        name = "spawn",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("tornado_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("walk")
            end)
        },
    },

    State{
        name = "despawn",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("tornado_pst")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                inst:Remove()
            end)
        },
    },

    State{
        name = "walk_start",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            inst.sg:GoToState("walk")
        end,
    },

    State{
        name = "walk",
        tags = {"moving", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:WalkForward()
            inst.AnimState:PushAnimation("tornado_loop", false)
            destroystuff(inst)
        end,

        timeline =
        {
            TimeEvent(5*FRAMES, destroystuff),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("walk")
            end)
        },
    },

    State{
        name = "walk_stop",
        tags = {"canrotate"},

        onenter = function(inst)
            inst.sg:GoToState("idle")
        end,
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PushAnimation("tornado_loop", false)
        end,

        timeline =
        {
            TimeEvent(5*FRAMES, destroystuff),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("run")
            end),
        },
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PushAnimation("tornado_loop", false)
        end,

        timeline =
        {
            TimeEvent(5*FRAMES, destroystuff),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("run")
            end),
        },
    },

    State{
        name = "run_stop",
        tags = {"idle"},

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PushAnimation("tornado_loop", false)
        end,

        timeline =
        {
            TimeEvent(5*FRAMES, destroystuff),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },
}

return StateGraph("lol_wp_s18_stormrazor_tornado", states, events, "empty")
