require("stategraphs/commonstates")

local ATTACK_PROP_MUST_TAGS = { "_combat" }
local ATTACK_PROP_CANT_TAGS = { "flying", "shadow", "ghost", "FX", "NOCLICK", "DECOR", "INLIMBO", "playerghost" }

local function DoEquipmentFoleySounds(inst)
    for k, v in pairs(inst.components.inventory.equipslots) do
        if v.foleysound ~= nil then
            inst.SoundEmitter:PlaySound(v.foleysound, nil, nil, true)
        end
    end
end

local function DoFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    if inst.foleysound ~= nil then
        inst.SoundEmitter:PlaySound("dontstarve/movement/foley/wx78", nil, nil, true)
    end
end

local function DoMountedFoleySounds(inst)
    DoEquipmentFoleySounds(inst)
    local saddle = inst.components.rider:GetSaddle()
    if saddle ~= nil and saddle.mounted_foleysound ~= nil then
        inst.SoundEmitter:PlaySound(saddle.mounted_foleysound, nil, nil, true)
    end
end

local DoRunSounds = function(inst)
    if inst.sg.mem.footsteps > 3 then
        PlayFootstep(inst, .6, true)
    else
        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
        PlayFootstep(inst, 1, true)
    end
end

local function ConfigureRunState(inst)
    if inst.components.rider:IsRiding() then
        inst.sg.statemem.riding = true
        inst.sg.statemem.groggy = inst:HasTag("groggy")
        inst.sg:AddStateTag("nodangle")

        local mount = inst.components.rider:GetMount()
        inst.sg.statemem.ridingwoby = mount and mount:HasTag("woby")

    elseif inst:IsInAnyStormOrCloud() and not inst.components.inventory:EquipHasTag("goggles") then
        inst.sg.statemem.sandstorm = true
    elseif inst:HasTag("groggy") then
        inst.sg.statemem.groggy = true
    elseif inst.components.carefulwalker:IsCarefulWalking() then
        inst.sg.statemem.careful = true
        inst.sg:AddStateTag("noslip")
    else
        inst.sg.statemem.normal = true
    end
end

local function GetRunStateAnim(inst)
    return (inst.sg.statemem.heavy and "heavy_walk")
        or (inst.sg.statemem.sandstorm and "sand_walk")
        or ((inst.sg.statemem.groggy or inst.sg.statemem.moosegroggy or inst.sg.statemem.goosegroggy) and "idle_walk")
        or (inst.sg.statemem.careful and "careful_walk")
        or (inst.sg.statemem.ridingwoby and "run_woby")
        or "run"
end

local function DoHurtSound(inst)
    if inst.hurtsoundoverride ~= nil then
        inst.SoundEmitter:PlaySound(inst.hurtsoundoverride, nil, inst.hurtsoundvolume)
    elseif not inst:HasTag("mime") then
        inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/hurt", nil, inst.hurtsoundvolume)
    end
end

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

local function DoMountSound(inst, mount, sound, ispredicted)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, ispredicted)
    end
end

local function ClearStatusAilments(inst)
    if inst.components.freezable ~= nil and inst.components.freezable:IsFrozen() then
        inst.components.freezable:Unfreeze()
    end
    if inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck() then
        inst.components.pinnable:Unstick()
    end
end

local function GetUnequipState(inst, data)
    return (data.eslot ~= EQUIPSLOTS.HANDS and "item_hat")
        or (not data.slip and "item_in")
        or (data.item ~= nil and data.item:IsValid() and "tool_slip")
        or "toolbroke"
        , data.item
end

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local function StartTeleporting(inst)
    inst.sg.statemem.isteleporting = true

    inst.components.health:SetInvincible(true)
    inst:Hide()
    inst.DynamicShadow:Enable(false)
end

local function DoneTeleporting(inst)
    inst.sg.statemem.isteleporting = false

    inst.components.health:SetInvincible(false)
    inst:Show()
    inst.DynamicShadow:Enable(true)
end

local function IsMinigameItem(inst)
    return inst:HasTag("minigameitem")
end

local function OnExitRow(inst)
    local boat = inst.components.sailor:GetBoat()
    if boat and boat.components.rowboatwakespawner then
        boat.components.rowboatwakespawner:StopSpawning()
    end
    if inst.sg.nextstate ~= "row_ia" and inst.sg.nextstate ~= "sail_ia" then
        inst.components.locomotor:Stop(nil, true)
        if inst.sg.nextstate ~= "row_stop_ia" and inst.sg.nextstate ~= "sail_stop_ia" then --Make sure equipped items are pulled back out (only really for items with flames right now)
            local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped then
                equipped:PushEvent("stoprowing", {owner = inst})
            end
            if boat then
                boat.replica.sailable:PlayIdleAnims()
            end
        end
    end
end

local function OnExitSail(inst)
    local boat = inst.components.sailor:GetBoat()
    if boat and boat.components.rowboatwakespawner then
        boat.components.rowboatwakespawner:StopSpawning()
    end

    if inst.sg.nextstate ~= "sail_ia" then
        inst.SoundEmitter:KillSound("sail_loop")
        if inst.sg.nextstate ~= "row_ia" then
            inst.components.locomotor:Stop(nil, true)
        end
        if inst.sg.nextstate ~= "row_stop_ia" and inst.sg.nextstate ~= "sail_stop_ia" then
            if boat then
                boat.replica.sailable:PlayIdleAnims()
            end
        end
    end
end

local function LandFlyingPlayer(player)
    player.sg:RemoveStateTag("flying")
    if player.Physics ~= nil then
        if player.sg.statemem.collisionmask ~= nil then
            player.Physics:SetCollisionMask(player.sg.statemem.collisionmask)
        end
    end
end

local function RaiseFlyingPlayer(player)
    player.sg:AddStateTag("flying")
    if player.Physics ~= nil then
        player.sg.statemem.collisionmask = player.Physics:GetCollisionMask()
        player.Physics:ClearCollidesWith(COLLISION.LIMITS)
        player.Physics:CollidesWith(COLLISION.FLYERS)
    end
end

local function installBermudaFX(inst)

    if inst.sg.statemem.startinfo then print("WARNING: installBermudaFX twice???") return end

    inst.AnimState:Pause()

    inst.sg.statemem.startinfo = {
        --TODO store original ADDcolour and erosion
        -- colour = inst.AnimState:GetMultColour(),
        scale = inst.Transform:GetScale(),
    }

    --[[
    local textures = {
        "images/bermudaTriangle01.tex",
        "images/bermudaTriangle02.tex",
        "images/bermudaTriangle03.tex",
        "images/bermudaTriangle04.tex",
        "images/bermudaTriangle05.tex",
    }
    --]]

    local colours = {
        {30/255, 57/255, 81/255, 1.0},
        {30/255, 57/255, 81/232, 1.0},
        {30/255, 57/255, 81/232, 1.0},
        {30/255, 57/255, 81/232, 1.0},

        {255/255, 255/255, 255/255, 1.0},
        {255/255, 255/255, 255/255, 1.0},

        {0, 0, 0, 1.0},
    }

    local colourfn = nil
    local posfn = nil
    local scalefn = nil
    local texturefn = nil

    colourfn = function()
        local colour = colours[math.random(#colours)]
        inst.AnimState:SetAddColour(colour[1], colour[2], colour[3], colour[4])
        inst.sg.statemem.colourtask = nil
        inst.sg.statemem.colourtask = inst:DoTaskInTime(math.random(10, 15) * FRAMES, colourfn)
    end

    posfn = function()
        local offset = Vector3(math.random(-1, 1) * .1, math.random(-1, 1) * .1, math.random(-1, 1) * .1)
        inst.Transform:SetPosition((inst:GetPosition() + offset):Get())
        inst.sg.statemem.postask = nil
        inst.sg.statemem.postask = inst:DoTaskInTime(math.random(6, 9) * FRAMES, posfn)
    end

    scalefn = function()
        inst.Transform:SetScale(math.random(95, 105) * 0.01, math.random(99, 101) * 0.01, 1)

        inst.sg.statemem.scaletask = nil
        inst.sg.statemem.scaletask = inst:DoTaskInTime(math.random(5, 8) * FRAMES, scalefn)
    end

    texturefn = function()
        inst.AnimState:SetErosionParams(math.random(1, 4) * 0.1, 0, 1)
        --AnimState does not have SetErosionTexture in DST, and TheSim is a touchy subject
        --inst.AnimState:SetErosionParams(math.random(4, 6) * 0.1, 0, 1)
        --TheSim:SetErosionTexture(textures[math.random(#textures)])

        inst.sg.statemem.texturetask = nil
        inst.sg.statemem.texturetask = inst:DoTaskInTime(math.random(4, 7) * FRAMES, texturefn)
    end

    colourfn()
    posfn()
    scalefn()
    texturefn()
end

local function removeBermudaFX(inst)

    if inst.sg.statemem.startinfo then
        inst.sg.statemem.colourtask:Cancel()
        inst.sg.statemem.colourtask = nil
        inst.sg.statemem.postask:Cancel()
        inst.sg.statemem.postask = nil
        inst.sg.statemem.scaletask:Cancel()
        inst.sg.statemem.scaletask = nil
        inst.sg.statemem.texturetask:Cancel()
        inst.sg.statemem.texturetask = nil

        --TODO can we restore the original values from statemem?
        inst.AnimState:SetAddColour(0,0,0,1)
        inst.Transform:SetScale(1,1,1)
        inst.AnimState:SetErosionParams(0, 0, 0)
        --TheSim:SetErosionTexture("images/erosion.tex")

        inst.AnimState:Resume()

        inst.sg.statemem.startinfo = nil
    end
end

local actionhandlers =
{
    -------------------------
    -- Agriculture Actions --
    -------------------------
    ActionHandler(ACTIONS.TILL, "till_start"),
    ActionHandler(ACTIONS.PLANTSOIL,
        function(inst, action)
            return (inst:HasTag("quagmire_farmhand") and "doshortaction")
                or (inst:HasTag("quagmire_fasthands") and "domediumaction")
                or "dolongaction"
        end),
    ActionHandler(ACTIONS.POUR_WATER,
        function(inst, action)
            return action.invobject ~= nil
                and (action.invobject:HasTag("wateringcan") and "pour")
                or "dolongaction"
        end),
    ActionHandler(ACTIONS.POUR_WATER_GROUNDTILE,
        function(inst, action)
            return action.invobject ~= nil
                and (action.invobject:HasTag("wateringcan") and "pour")
                or "dolongaction"
        end),
    ActionHandler(ACTIONS.FILL, "dolongaction"),
    ActionHandler(ACTIONS.ADDCOMPOSTABLE, "give"),
    ActionHandler(ACTIONS.ACTIVATE,
        function(inst, action)
            return action.target.components.activatable ~= nil
                and (   (   action.target:HasTag("engineering") and (
                                (inst:HasTag("scientist") and "dolongaction") or
                                (not inst:HasTag("handyperson") and "dolongestaction")
                            )
                        ) or
                        (action.target.components.activatable.standingaction and "dostandingaction") or
                        (action.target.components.activatable.quickaction and "doshortaction") or
                        "dolongaction"
                    )
                or nil
        end),
    ActionHandler(ACTIONS.DEPLOY, "doshortaction"),
    ActionHandler(ACTIONS.DEPLOY_TILEARRIVE, "doshortaction"),
    ActionHandler(ACTIONS.HAMMER,
        function(inst)
            return not inst.sg:HasStateTag("prehammer")
                and (inst.sg:HasStateTag("hammering") and
                    "hammer" or
                    "hammer_start")
                or nil
        end),

    --------------------------
    -- Horticulture Actions --
    --------------------------
    ActionHandler(ACTIONS.PICK,
        function(inst, action)
            return (inst.components.rider ~= nil and inst.components.rider:IsRiding() and "dolongaction")
                or (action.target ~= nil
                and action.target.components.pickable ~= nil
                and (   (action.target.components.pickable.jostlepick and "dojostleaction") or
                        (action.target.components.pickable.quickpick and "doshortaction") or
                        (inst:HasTag("fastpicker") and "doshortaction") or
                        (inst:HasTag("quagmire_fasthands") and "domediumaction") or
                        "dolongaction"  ))
                or nil
        end),
    ActionHandler(ACTIONS.FERTILIZE,
        function(inst, action)
            return (((action.target ~= nil and action.target ~= inst) or action:GetActionPoint() ~= nil) and "doshortaction")
                or (action.invobject ~= nil and action.invobject:HasTag("slowfertilize") and "fertilize")
                or "fertilize_short"
        end),
    ActionHandler(ACTIONS.SCYTHE, "scythe"),

    ---------------------------
    -- Arboriculture Actions --
    ---------------------------
    ActionHandler(ACTIONS.CHOP,
        function(inst)
            if not inst.sg:HasStateTag("prechop") then
                return inst.sg:HasStateTag("chopping")
                    and "chop"
                    or "chop_start"
            end
        end),
    ActionHandler(ACTIONS.DIG,
        function(inst)
            if not inst.sg:HasStateTag("predig") then
                return inst.sg:HasStateTag("digging")
                    and "dig"
                    or "dig_start"
            end
        end),

    ------------------------
    -- Apiculture Actions --
    ------------------------
    ActionHandler(ACTIONS.HARVEST,
        function(inst)
            return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
        end),
    ActionHandler(ACTIONS.NET,
        function(inst)
            return not inst.sg:HasStateTag("prenet")
                and (inst.sg:HasStateTag("netting") and
                    "bugnet" or
                    "bugnet_start")
                or nil
        end),

    -------------------------
    -- Aquaculture Actions --
    -------------------------
    ActionHandler(ACTIONS.FISH, "fishing_pre"),
    ActionHandler(ACTIONS.MURDER,
        function(inst)
            return inst:HasTag("quagmire_fasthands") and "domediumaction" or "dolongaction"
        end),
    ActionHandler(ACTIONS.OCEAN_FISHING_POND, "fishing_ocean_pre"),
    ActionHandler(ACTIONS.OCEAN_FISHING_CAST, "oceanfishing_cast"),
    ActionHandler(ACTIONS.OCEAN_FISHING_REEL,
        function(inst, action)
            local fishable = action.invobject ~= nil and action.invobject.components.oceanfishingrod.target or nil
            if fishable ~= nil and fishable.components.oceanfishable ~= nil and fishable:HasTag("partiallyhooked") then
                return "oceanfishing_sethook"
            elseif inst:HasTag("fishing_idle") and not (inst.sg:HasStateTag("reeling") and not inst.sg.statemem.allow_repeat) then
                return "oceanfishing_reel"
            end
            return nil
        end),
    ActionHandler(ACTIONS.CHANGE_TACKLE, "dolongaction"),
    ActionHandler(ACTIONS.OCEAN_TRAWLER_LOWER, "doshortaction"),
    ActionHandler(ACTIONS.OCEAN_TRAWLER_RAISE, "doshortaction"),
    ActionHandler(ACTIONS.OCEAN_TRAWLER_FIX, "dolongaction"),

    ----------------------
    -- Military Actions --
    ----------------------
    ActionHandler(ACTIONS.RESETMINE, "dolongaction"),

    -----------------------------
    -- MachineIndustry Actions --
    -----------------------------
    ActionHandler(ACTIONS.ADVANCEDREPAIR, "dolongaction"),
    ActionHandler(ACTIONS.REPAIR, "dolongaction"),
    ActionHandler(ACTIONS.REPAIR_LEAK, "dolongaction"),
    ActionHandler(ACTIONS.ADDFUEL, "doshortaction"),
    ActionHandler(ACTIONS.TURNOFF, "give"),
    ActionHandler(ACTIONS.TURNON, "give"),

    ----------------------------
    -- MiningIndustry Actions --
    ----------------------------
    ActionHandler(ACTIONS.MINE,
        function(inst)
            if not inst.sg:HasStateTag("premine") then
                return inst.sg:HasStateTag("mining")
                    and "mine"
                    or "mine_start"
            end
        end),
    ActionHandler(ACTIONS.BUILD,
        function(inst, action)
            local rec = GetValidRecipe(action.recipe)
            return (rec ~= nil and rec.sg_state)
                or (inst:HasTag("hungrybuilder") and "dohungrybuild")
                or (inst:HasTag("fastbuilder") and "domediumaction")
                or (inst:HasTag("slowbuilder") and "dolongestaction")
                or "dolongaction"
        end),

    ------------------------
    -- Navigation Actions --
    ------------------------
    ActionHandler(ACTIONS.STORE, "doshortaction"),
    ActionHandler(ACTIONS.LOAD, "doshortaction"),
    ActionHandler(ACTIONS.RUMMAGE, "doshortaction"),
    ActionHandler(ACTIONS.JUMPIN, "jumpin_pre"),

    -------------------------
    -- Pastoralism Actions --
    -------------------------
    ActionHandler(ACTIONS.MOUNT, "doshortaction"),
    ActionHandler(ACTIONS.SADDLE, "doshortaction"),
    ActionHandler(ACTIONS.UNSADDLE, "unsaddle"),
    ActionHandler(ACTIONS.BRUSH, "dolongaction"),
    ActionHandler(ACTIONS.SHAVE, "dolongaction"),

    --------------------------
    -- FoodIndustry Actions --
    --------------------------
    ActionHandler(ACTIONS.COOK, "dolongaction"),
    ActionHandler(ACTIONS.DRY, "doshortaction"),

    ------------------
    -- Misc Actions --
    ------------------
    ActionHandler(ACTIONS.GIVE,
        function(inst, action)
            return action.invobject ~= nil
                and action.target ~= nil
                and (   (action.target:HasTag("moonportal") and action.invobject:HasTag("moonportalkey") and "dochannelaction") or
                        (action.invobject.prefab == "quagmire_portal_key" and action.target:HasTag("quagmire_altar") and "quagmireportalkey") or
                        (action.target:HasTag("give_dolongaction") and "dolongaction")
                    )
                or "give"
        end),
    ActionHandler(ACTIONS.TAKEITEM,
        function(inst, action)
            return action.target ~= nil
                and action.target.takeitem ~= nil --added for quagmire
                and "give"
                or "dolongaction"
        end),
    ActionHandler(ACTIONS.PICKUP,
        function(inst, action)
            return (action.target ~= nil and action.target:HasTag("minigameitem") and "dosilentshortaction")
                or (inst.components.rider ~= nil and inst.components.rider:IsRiding() and "domediumaction")
                or "doshortaction"
        end),
    ActionHandler(ACTIONS.DROP, "doshortaction"),
    ActionHandler(ACTIONS.AUGMENT, "doshortaction"),
    ActionHandler(ACTIONS.WXMIGRATE, "migrate"),

}

local ia_actionhandlers =
{
    -------------------------
    -- Shipwrecked Actions --
    -------------------------
    ActionHandler(ACTIONS.PLANT, "doshortaction"),
    ActionHandler(ACTIONS.STICK, "doshortaction"),
    ActionHandler(ACTIONS.SEW, "dolongaction"),
    ActionHandler(ACTIONS.HACK,
        function(inst)
            if not inst.sg:HasStateTag("prehack") then
                return inst.sg:HasStateTag("hacking")
                    and "hack"
                    or "hack_start"
            end
        end),
    ActionHandler(ACTIONS.EMBARK, "embark"),
    ActionHandler(ACTIONS.DISEMBARK, "disembark"),
    ActionHandler(ACTIONS.TOGGLEON, "give"),
    ActionHandler(ACTIONS.TOGGLEOFF, "give"),
    ActionHandler(ACTIONS.REPAIRBOAT, "dolongaction"),

}

if KnownModIndex:IsModEnabled("workshop-1467214795") then
    for k, v in pairs(ia_actionhandlers) do
        table.insert(actionhandlers, v)
    end
end

local events =
{
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnStep(),
    CommonHandlers.OnHop(),

    EventHandler("ontalk", function(inst, data)
        if inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("notalking") then
            if not inst:HasTag("mime") then
                inst.sg:GoToState("talk", data.noanim)
            elseif not inst.components.inventory:IsHeavyLifting() then
                --Don't do it even if mounted!
                inst.sg:GoToState("mime")
            end
        end
    end),

    EventHandler("doattack", function(inst, data)
        if inst.components.health ~= nil and not inst.components.health:IsDead()
            and not (inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("hit")) then
            local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
            if weapon == nil then
                inst.sg:GoToState("attack")
            elseif weapon:HasTag("blowdart") then
                inst.sg:GoToState("blowdart")
            elseif weapon:HasTag("thrown") then
                inst.sg:GoToState("throw")
            elseif weapon:HasTag("speargun") then
                inst.sg:GoToState("speargun")
            elseif weapon:HasTag("blunderbuss") then
                inst.sg:GoToState("speargun")
            else
                inst.sg:GoToState("attack")
            end
            --(weapon:HasTag("slingshot") and "slingshot_shoot")
            --(weapon:HasTag("pillow") and "attack_pillow_pre")
            --(weapon:HasTag("propweapon") and "attack_prop_pre")
            --(weapon:HasTag("multithruster") and "multithrust_pre")
            --(weapon:HasTag("helmsplitter") and "helmsplitter_pre")
        end
    end),

    EventHandler("attacked", function(inst, data)
        if inst.components.sailor and inst.components.sailor:IsSailing() then
            local boat = inst.components.sailor:GetBoat()
            if not inst.components.health:IsDead() and not (boat and boat.components.boathealth and boat.components.boathealth:IsDead()) then
                if not boat.components.sailable or not boat.components.sailable:CanDoHit() then
                    return
                end

                if data.attacker and (data.attacker:HasTag("insect") or data.attacker:HasTag("twister")) then
                    local is_idle = inst.sg:HasStateTag("idle")
                    if not is_idle then
                        return
                    end
                end

                boat.components.sailable:GetHit()
            end
        end

        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("drowning") then
            if data.weapon ~= nil and data.weapon:HasTag("tranquilizer") and (inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("knockout")) then
                return --Do nothing
            elseif inst.sg:HasStateTag("dismounting") then
                -- don't interrupt transform or when bucked in the air
                inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
                DoHurtSound(inst)
            elseif inst.sg:HasStateTag("devoured") or inst.sg:HasStateTag("suspended") then
                return --Do nothing
            elseif data.attacker ~= nil
                and data.attacker:HasTag("groundspike")
                and not inst.components.rider:IsRiding() then
                inst.sg:GoToState("hit_spike", data.attacker)
            elseif data.attacker ~= nil
                and data.attacker.sg ~= nil
                and data.attacker.sg:HasStateTag("pushing") then
                inst.sg:GoToState("hit_push")
            elseif inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck() then
                inst.sg:GoToState("pinned_hit")
            elseif inst.sg:HasStateTag("nointerrupt") then
                inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
                DoHurtSound(inst)
            else
                local t = GetTime()
                local stunlock =
                    data.stimuli ~= "stun" and
                    data.attacker ~= nil and
                    --V2C: skip stunlock protection when idle
                    -- gjans: we transition to idle for 1 frame after being hit, hence the timeinstate check
                    not (inst.sg:HasStateTag("idle") and inst.sg.timeinstate > 0) and
                    data.attacker.components.combat ~= nil and
                    data.attacker.components.combat.playerstunlock or
                    nil
                if stunlock ~= nil and
                    t - (inst.sg.mem.laststuntime or 0) <
                    (   (stunlock == PLAYERSTUNLOCK.NEVER and math.huge) or
                        (stunlock == PLAYERSTUNLOCK.RARELY and TUNING.STUNLOCK_TIMES.RARELY) or
                        (stunlock == PLAYERSTUNLOCK.SOMETIMES and TUNING.STUNLOCK_TIMES.SOMETIMES) or
                        (stunlock == PLAYERSTUNLOCK.OFTEN and TUNING.STUNLOCK_TIMES.OFTEN) or
                        0 --unsupported case
                    ) then
                    -- don't go to full hit state, just play sounds
                    inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
                    DoHurtSound(inst)
                else
                    inst.sg.mem.laststuntime = t
                    inst.sg:GoToState("hit", data.noimpactsound and "noimpactsound" or nil)
                end
            end
        end
    end),

    EventHandler("snared", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("startle", true)
        end
    end),

    EventHandler("startled", function(inst)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("startle", false)
        end
    end),

    EventHandler("repelled", function(inst, data)
        if not inst.components.health:IsDead() then
            inst.sg:GoToState("repelled", data)
        end
    end),

    EventHandler("knockback", function(inst, data)
        if not inst.components.health:IsDead() then
            if inst.sg:HasStateTag("parrying") then
                inst.sg.statemem.parrying = true
                inst.sg:GoToState("parry_knockback", {
                    timeleft =
                        (inst.sg.statemem.task ~= nil and GetTaskRemaining(inst.sg.statemem.task)) or
                        (inst.sg.statemem.timeleft ~= nil and math.max(0, inst.sg.statemem.timeleft + inst.sg.statemem.timeleft0 - GetTime())) or
                        inst.sg.statemem.parrytime,
                    knockbackdata = data,
                    isshield = inst.sg.statemem.isshield,
                })
            else
                inst.sg:GoToState((data.forcelanded or inst.components.inventory:EquipHasTag("heavyarmor") or inst:HasTag("heavybody")) and "knockbacklanded" or "knockback", data)
            end
        end
    end),

    EventHandler("devoured", function(inst, data)
        if not inst.components.health:IsDead() and data ~= nil and data.attacker ~= nil and data.attacker:IsValid() then
            inst.sg:GoToState("devoured", data)
        end
    end),

    EventHandler("suspended", function(inst, attacker)
        if not inst.components.health:IsDead() and
            not inst.components.rider:IsRiding() and
            attacker and attacker:IsValid() and
            not (attacker.components.health and attacker.components.health:IsDead())
        then
            inst.sg:GoToState("suspended", attacker)
        end
    end),

    EventHandler("death", function(inst, data)
        if data ~= nil and data.cause == "file_load" and inst.components.revivablecorpse ~= nil then
            inst.sg:GoToState("corpse", true)
        elseif data.cause == "drowning" then
            inst.sg:GoToState("death_drown")
        else
            if inst.components.sailor and inst.components.sailor.boat and inst.components.sailor.boat.components.container then
                inst.components.sailor.boat.components.container:Close(true)
            end
            if not inst.sg:HasStateTag("dead") then
                inst.sg:GoToState("death")
            end
        end
    end),

    EventHandler("equip", function(inst, data)
        if data.eslot == EQUIPSLOTS.BODY and data.item ~= nil and data.item:HasTag("heavy") then
            inst.sg:GoToState("heavylifting_start")
        elseif inst.components.inventory:IsHeavyLifting()
            and not inst.components.rider:IsRiding() then
            if inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("moving") then
                inst.sg:GoToState("heavylifting_item_hat")
            end
        elseif inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("channeling") then
            inst.sg:GoToState(
                (data.item ~= nil and data.item.projectileowner ~= nil and "catch_equip") or
                (data.eslot == EQUIPSLOTS.HANDS and "item_out") or
                "item_hat"
            )
        elseif data.item ~= nil and data.item.projectileowner ~= nil then
            SpawnPrefab("lucy_transform_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_object", 50, -25, 0)
        end
    end),

    EventHandler("unequip", function(inst, data)
        if data.eslot == EQUIPSLOTS.BODY and data.item ~= nil and data.item:HasTag("heavy") then
            if not inst.sg:HasStateTag("busy") then
                inst.sg:GoToState("heavylifting_stop")
            end
        elseif inst.components.inventory:IsHeavyLifting()
            and not inst.components.rider:IsRiding() then
            if inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("moving") then
                inst.sg:GoToState("heavylifting_item_hat")
            end
        elseif inst.sg:HasStateTag("idle") or inst.sg:HasStateTag("channeling") then
            inst.sg:GoToState(GetUnequipState(inst, data))
        end
    end),

    EventHandler("itemranout", function(inst, data)
        if inst.components.inventory:GetEquippedItem(data.equipslot) == nil then
            local sameTool = inst.components.inventory:FindItem(function(item)
                return item.prefab == data.prefab and
                    item.components.equippable ~= nil and
                    item.components.equippable.equipslot == data.equipslot
            end)
            if sameTool ~= nil then
                inst.components.inventory:Equip(sameTool)
            end
        end
    end),

    EventHandler("toolbroke",
        function(inst, data)
            if not inst.sg:HasStateTag("nointerrupt") then
                inst.sg:GoToState("toolbroke", data.tool)
            end
        end),

    EventHandler("armorbroke",
    function(inst)
        if not inst.sg:HasStateTag("nointerrupt") then
            inst.sg:GoToState("armorbroke")
        end
    end),

    EventHandler("fishingcancel",
        function(inst)
            if inst.sg:HasStateTag("fishing") and not inst:HasTag("busy") then
                inst.sg:GoToState("fishing_pst")
            end
        end),

    EventHandler("oceanfishing_stoppedfishing", function(inst, data)
        if inst.sg:HasStateTag("fishing") and (inst.components.health == nil or not inst.components.health:IsDead()) then
            if data ~= nil and data.reason ~= nil then
                if data.reason == "linesnapped" or data.reason == "toofaraway" then
                    inst.sg:GoToState("oceanfishing_linesnapped", {escaped_str = "ANNOUNCE_OCEANFISHING_LINESNAP"})
                else
                    inst.sg:GoToState("oceanfishing_stop", {escaped_str = data.reason == "linetooloose" and "ANNOUNCE_OCEANFISHING_LINETOOLOOSE"
                                                                        or data.reason == "badcast" and "ANNOUNCE_OCEANFISHING_BADCAST"
                                                                        or (data.reason ~= "reeledin") and "ANNOUNCE_OCEANFISHING_GOTAWAY"
                                                                        or nil})
                end
            else
                inst.sg:GoToState("oceanfishing_stop")
            end
        end
    end),

    EventHandler("onsink", function(inst, data)
        if data and data.ia_boat and not inst.components.health:IsDead() and not inst.sg:HasStateTag("drowning") and
            (inst.components.drownable ~= nil and inst.components.drownable:ShouldDrown()) then
            inst.sg:GoToState("sink_boat", data.shore_pt)
        else
            if inst.components.sailor and inst.components.sailor.boat and inst.components.sailor.boat.components.container then
                inst.components.sailor.boat.components.container:Close(true)
            end
            if not inst.components.health:IsDead() and not inst.sg:HasStateTag("drowning") and
                (inst.components.drownable ~= nil and inst.components.drownable:ShouldDrown()) then
                if data ~= nil and data.boat ~= nil then
                    inst.sg:GoToState("sink", data.shore_pt)
                else
                    inst.sg:GoToState("sink_fast")
                end
            end
        end
    end),

    EventHandler("onfallinvoid", function(inst, data)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("falling") and
            (inst.components.drownable ~= nil and inst.components.drownable:ShouldFallInVoid()) then
            inst.sg:GoToState("abyss_fall", data and data.teleport_pt or nil)
        end
    end),

    EventHandler("dismount",
        function(inst)
            if not inst.sg:HasStateTag("dismounting") and inst.components.rider:IsRiding() then
                inst.sg:GoToState("dismount")
            end
        end),

    EventHandler("bucked",
        function(inst, data)
            if not inst.sg:HasStateTag("dismounting") and inst.components.rider:IsRiding() then
                inst.sg:GoToState(data.gentle and "falloff" or "bucked")
            end
        end),

    EventHandler("pinned",
        function(inst, data)
            if inst.components.health ~= nil and not inst.components.health:IsDead() and inst.components.pinnable ~= nil then
                if inst.components.pinnable.canbepinned then
                    inst.sg:GoToState("pinned_pre", data)
                elseif inst.components.pinnable:IsStuck() then
                    --V2C: Since sg events are queued, it's possible we're no longer pinnable
                    inst.components.pinnable:Unstick()
                end
            end
        end),

    -------------------------------
    -- Shipwrecked EventHandlers --
    -------------------------------
    EventHandler("locomote", function(inst, data)
        if inst.components.sailor == nil or not inst.components.sailor:IsSailing() then
            -- From CommonHandlers.OnLocomote(can_run, can_walk)
            local can_run = true
            local can_walk = false
            local is_moving = inst.sg:HasStateTag("moving")
            local is_running = inst.sg:HasStateTag("running")
            local is_idling = inst.sg:HasStateTag("idle")

            local should_move = inst.components.locomotor:WantsToMoveForward()
            local should_run = inst.components.locomotor:WantsToRun()

            if is_moving and not should_move then
                inst.sg:GoToState(is_running and "run_stop" or "walk_stop")
            elseif (is_idling and should_move) or (is_moving and should_move and is_running ~= should_run and can_run and can_walk) then
                if can_run and (should_run or not can_walk) then
                    inst.sg:GoToState("run_start")
                elseif can_walk then
                    inst.sg:GoToState("walk_start")
                end
            end
        else
            local is_moving = inst.sg:HasStateTag("moving")
            local is_running = inst.sg:HasStateTag("running")
            local is_idling = inst.sg:HasStateTag("idle")
            local is_attacking = inst.sg:HasStateTag("attack")

            local should_move = inst.components.locomotor:WantsToMoveForward()
            local should_run = inst.components.locomotor:WantsToRun()

            if inst.components.sailor and inst.components.sailor.boat and not inst.components.sailor.boat.components.sailable then
                should_move = false
            end

            local hasSail = inst.replica.sailor and inst.replica.sailor:GetBoat() and inst.replica.sailor:GetBoat().replica.sailable:GetIsSailEquipped() or false
            if not should_move then
                if inst.components.sailor and inst.components.sailor.boat then
                    inst.components.sailor.boat:PushEvent("boatstopmoving")
                end
            end
            if should_move then
                if inst.components.sailor and inst.components.sailor.boat then
                    inst.components.sailor.boat:PushEvent("boatstartmoving")
                end
            end
            
            if inst.components.sailor and inst.components.sailor:IsSailing() and not is_attacking then
                if is_moving and not should_move then
                    if hasSail then
                        inst.sg:GoToState("sail_stop_ia")
                    else
                        inst.sg:GoToState("row_stop_ia")
                    end
                elseif (is_idling and should_move) then
                    if hasSail then
                        inst.sg:GoToState("sail_start_ia")
                    else
                        inst.sg:GoToState("rowl_start_ia")
                    end
                end
            end
        end
    end),

    --ive changed the vacuum states and handlers to allow being sucked up over water, if this is a bad idea tell me and i can remove it -Half
    EventHandler("vacuum_in", function(inst)
        if inst.components.health and not inst.components.health:IsDead() and
        not (IsOnWater(inst:GetPosition())) and
        not inst.sg:HasStateTag("vacuum_in") and
        not (inst.components.sailor and inst.components.sailor:IsSailing()) then
            inst.sg:GoToState("vacuumedin")
        end
    end),

    EventHandler("vacuum_out", function(inst, data)
        if inst.components.health and not inst.components.health:IsDead() and
        not inst.sg:HasStateTag("vacuum_out") and
        not (inst.components.sailor and inst.components.sailor:IsSailing()) then
            if IsOnWater(inst:GetPosition()) then
                --copied from keeponland
                local pt = inst:GetPosition()
                local angle = inst.Transform:GetRotation()
                angle = angle * DEGREES
                local dist = -1
                local newpt = Vector3(pt.x + dist * math.cos(angle), pt.y, pt.z + dist * -math.sin(angle))
                if not IsLand(GetVisualTileType(newpt.x, newpt.y, newpt.z, 1.5 / 4)) then
                    --Okay, try to find any point nearby
                    local result_offset = FindGroundOffset(pt, 0, 5, 12)
                    newpt = result_offset and pt + result_offset or nil
                end

                if newpt then
                    inst.Transform:SetPosition(newpt.x, newpt.y, newpt.z)
                    if inst.components.locomotor then
                        inst.components.locomotor:Stop()
                    end
                end
            end
            inst.sg:GoToState("vacuumedout", data)
        else
            inst:RemoveTag("NOVACUUM")
        end
    end),

    EventHandler("vacuum_held", function(inst)
        if inst.components.health and not inst.components.health:IsDead() and
        not inst.sg:HasStateTag("vacuum_held") and
        not (inst.components.sailor and inst.components.sailor:IsSailing()) then
            if not IsOnWater(inst:GetPosition()) then
                inst.sg:GoToState("vacuumedheld")
            else
                --copied from keeponland
                local pt = inst:GetPosition()
                local angle = inst.Transform:GetRotation()
                angle = angle * DEGREES
                local dist = -1
                local newpt = Vector3(pt.x + dist * math.cos(angle), pt.y, pt.z + dist * -math.sin(angle))
                if not IsLand(GetVisualTileType(newpt.x, newpt.y, newpt.z, 1.5 / 4)) then
                    --Okay, try to find any point nearby
                    local result_offset = FindGroundOffset(pt, 0, 5, 12)
                    newpt = result_offset and pt + result_offset or nil
                end

                if newpt then
                    inst.Transform:SetPosition(newpt.x, newpt.y, newpt.z)
                    if inst.components.locomotor then
                        inst.components.locomotor:Stop()
                    end
                    inst.sg:GoToState("vacuumedheld")
                end
            end
        end
    end),

    EventHandler("sailequipped", function(inst)
        if inst.sg:HasStateTag("rowing") then
            inst.sg:GoToState("sail_ia")
            local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped then
                equipped:PushEvent("stoprowing", {owner = inst})
            end
        end
    end),

    EventHandler("sailunequipped", function(inst)
        if inst.sg:HasStateTag("sailing") then
            inst.sg:GoToState("row_ia")

            if not inst:HasTag("mime") then
                inst.AnimState:OverrideSymbol("paddle", "swap_paddle", "paddle")
            end
            --TODO allow custom paddles?
            inst.AnimState:OverrideSymbol("wake_paddle", "swap_paddle", "wake_paddle")

            local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped then
                equipped:PushEvent("startrowing", {owner = inst})
            end
        end
    end),

    EventHandler("boatattacked", function(inst, data)
        if inst.components.sailor and inst.components.sailor:IsSailing() then
            local boat = inst.components.sailor:GetBoat()
            if not (boat and boat.components.boathealth and boat.components.boathealth:IsDead()) and
                not inst.components.health:IsDead() then

                if not boat.components.sailable or not boat.components.sailable:CanDoHit() then
                    return
                end

                if data.attacker and (data.attacker:HasTag("insect") or data.attacker:HasTag("twister"))then
                    local is_idle = inst.sg:HasStateTag("idle")
                    if not is_idle then
                        return
                    end
                end

                boat.components.sailable:GetHit()
            end
        end
    end),

    EventHandler("boostbywave", function(inst, data)
        if inst.sg:HasStateTag("running") then

            local boost = data.boost or TUNING.WAVEBOOST
            if inst.components.sailor then
                local boat = inst.components.sailor:GetBoat()
                if boat and boat.waveboost and not data.boost then
                    boost = boat.waveboost
                end
            end

            if inst.components.locomotor then
                inst.components.locomotor.boost = boost
            end
        end
    end),

    EventHandler("onhitcoastline", function(inst, data)
        if not inst.components.health:IsDead() and not inst.sg:HasStateTag("drowning") and
                (inst.components.drydrownable ~= nil and inst.components.drydrownable:ShouldDrown()) then
            if inst.components.drydrownable:ShouldDestroyBoat() then
                inst.components.drydrownable:DestroyBoat()
            else
                inst.sg:GoToState("hitcoastline")
            end
        end
    end),
}

local states =
{
    -----------------
    -- Misc States --
    -----------------
    State{
        name = "idle",
        tags = {"idle", "canrotate"},

        onenter = function(inst, pushanim)
            --inst.components.locomotor:Stop()
            inst.Physics:Stop()

            local drownable = inst.components.drownable
            if drownable then
                local fallingreason = drownable:GetFallingReason()
                if fallingreason == FALLINGREASON.OCEAN then
                    inst.sg:GoToState("sink_fast")
                    return
                elseif fallingreason == FALLINGREASON.VOID then
                    inst.sg:GoToState("abyss_fall")
                    return
                end
            end
            if inst.components.drydrownable ~= nil and inst.components.drydrownable:ShouldDrown() then
                inst:PushEvent("onhitcoastline")
            end

            inst.sg.statemem.ignoresandstorm = true

            if inst.components.rider:IsRiding() then
                inst.sg:GoToState("mounted_idle", pushanim)
                return
            end

            local equippedArmor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if equippedArmor ~= nil and equippedArmor:HasTag("band") then
                inst.sg:GoToState("enter_onemanband", pushanim)
                return
            end

            if inst.sg.mem.queuetalk_timeout ~= nil then
                local remaining_talk_time = inst.sg.mem.queuetalk_timeout - GetTime()
                inst.sg.mem.queuetalk_timeout = nil
                if not (pushanim or inst:HasTag("ignoretalking")) then
                    if remaining_talk_time > 1 then
                        inst.sg:GoToState("talk")
                        return
                    end
                end
            end

            local anims = {}

            inst.sg.statemem.ignoresandstorm = false
            if inst:IsInAnyStormOrCloud() and not inst.components.inventory:EquipHasTag("goggles") then
                if not (inst.AnimState:IsCurrentAnimation("sand_walk_pst") or
                        inst.AnimState:IsCurrentAnimation("sand_walk") or
                        inst.AnimState:IsCurrentAnimation("sand_walk_pre")) then
                    table.insert(anims, "sand_idle_pre")
                end
                table.insert(anims, "sand_idle_loop")
                inst.sg.statemem.sandstorm = true
            elseif inst.components.sanity:IsInsane() then
                table.insert(anims, "idle_sanity_pre")
                table.insert(anims, "idle_sanity_loop")
            elseif inst.components.sanity:IsEnlightened() then
                table.insert(anims, "idle_lunacy_pre")
                table.insert(anims, "idle_lunacy_loop")
            elseif inst.components.temperature:IsFreezing() then
                table.insert(anims, "idle_shiver_pre")
                table.insert(anims, "idle_shiver_loop")
            elseif inst.components.temperature:IsOverheating() then
                table.insert(anims, "idle_hot_pre")
                table.insert(anims, "idle_hot_loop")
            elseif inst:HasTag("groggy") then
                if not inst.AnimState:IsCurrentAnimation("yawn") then
                    table.insert(anims, "idle_groggy_pre")
                end
                table.insert(anims, "idle_groggy")
            else
                table.insert(anims, "idle_loop")
            end

            if pushanim then
                for k, v in pairs(anims) do
                    inst.AnimState:PushAnimation(v, k == #anims)
                end
            else
                inst.AnimState:PlayAnimation(anims[1], #anims == 1)
                for k, v in pairs(anims) do
                    if k > 1 then
                        inst.AnimState:PushAnimation(v, k == #anims)
                    end
                end
            end
        end,

        events =
        {
            EventHandler("sandstormlevel", function(inst, data)
                if not inst.sg.statemem.ignoresandstorm then
                    if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                        if inst.sg.statemem.sandstorm then
                            inst.sg:GoToState("idle")
                        end
                    elseif not (inst.sg.statemem.sandstorm or inst.components.inventory:EquipHasTag("goggles")) then
                        inst.sg:GoToState("idle")
                    end
                end
            end),
            EventHandler("miasmalevel", function(inst, data)
                if not inst.sg.statemem.ignoresandstorm then
                    if data.level < 1 then
                        if inst.sg.statemem.sandstorm then
                            inst.sg:GoToState("idle")
                        end
                    elseif not (inst.sg.statemem.sandstorm or inst.components.inventory:EquipHasTag("goggles")) then
                        inst.sg:GoToState("idle")
                    end
                end
            end),
        },
    },

    State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            ConfigureRunState(inst)
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation(GetRunStateAnim(inst).."_pre")
            --goose footsteps should always be light
            inst.sg.mem.footsteps = 0
        end,

        timeline =
        {
            --mounted
            TimeEvent(0, function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end),

            --unmounted
            TimeEvent(4 * FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    PlayFootstep(inst, nil, true)
                    DoFoleySounds(inst)
                end
            end),

            --mounted
            TimeEvent(5 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    PlayFootstep(inst, nil, true)
                end
            end),
        },

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
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            ConfigureRunState(inst)
            inst.components.locomotor:RunForward()

            local anim = GetRunStateAnim(inst)
            if anim == "run" then
                anim = "run_loop"
            elseif anim == "run_woby" then
                anim = "run_woby_loop"
            end
            if not inst.AnimState:IsCurrentAnimation(anim) then
                inst.AnimState:PlayAnimation(anim, true)
            end

            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        timeline =
        {
            --unmounted
            TimeEvent(7 * FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            TimeEvent(15 * FRAMES, function(inst)
                if inst.sg.statemem.normal then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --careful
            --Frame 11 shared with heavy lifting below
            --[[TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            TimeEvent(26 * FRAMES, function(inst)
                if inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --sandstorm
            --Frame 12 shared with groggy below
            --[[TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            TimeEvent(23 * FRAMES, function(inst)
                if inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --groggy
            TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.groggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                elseif inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.groggy or
                    inst.sg.statemem.sandstorm then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --heavy lifting
            TimeEvent(0 * FRAMES, function(inst)
                if inst.sg.statemem.heavy and inst.sg.statemem.heavy_fast then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                end
            end),
            TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.heavy and inst.sg.statemem.heavy_fast then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                end
            end),
            TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.heavy and not inst.sg.statemem.heavy_fast then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                elseif inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                elseif inst.sg.statemem.sandstorm
                    or inst.sg.statemem.careful then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            TimeEvent(36 * FRAMES, function(inst)
                if inst.sg.statemem.heavy and not inst.sg.statemem.heavy_fast then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    if inst.sg.mem.footsteps > 12 then
                        inst.sg.mem.footsteps = math.random(4, 6)
                        inst:PushEvent("encumberedwalking")
                    elseif inst.sg.mem.footsteps > 3 then
                        --normally stops at > 3, but heavy needs to keep count
                        inst.sg.mem.footsteps = inst.sg.mem.footsteps + 1
                    end
                end
            end),

            --mounted
            TimeEvent(0 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoMountedFoleySounds(inst)
                end
            end),
            TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoRunSounds(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/beefalo/walk",nil,.5)
                    if inst.sg.statemem.ridingwoby then
                        inst.SoundEmitter:PlaySoundWithParams("dontstarve/characters/walter/woby/big/footstep", {intensity= 1})
                    end
                end
            end),
            TimeEvent(3 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    if inst.sg.statemem.ridingwoby then
                        inst.SoundEmitter:PlaySoundWithParams("dontstarve/characters/walter/woby/big/footstep", {intensity= 1})
                    end
                end
            end),
            TimeEvent(8 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    DoRunSounds(inst)
                    inst.SoundEmitter:PlaySound("dontstarve/beefalo/walk",nil,.5)
                    if inst.sg.statemem.ridingwoby then
                        inst.SoundEmitter:PlaySoundWithParams("dontstarve/characters/walter/woby/big/footstep", {intensity= 1})
                    end
                end
            end),
            TimeEvent(10 * FRAMES, function(inst)
                if inst.sg.statemem.riding then
                    if inst.sg.statemem.ridingwoby then
                        inst.SoundEmitter:PlaySoundWithParams("dontstarve/characters/walter/woby/big/footstep", {intensity= 1})
                    end
                end
            end),


            --moose
            --Frame 11 shared with heavy lifting above
            --[[TimeEvent(11 * FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),]]
            TimeEvent(24 * FRAMES, function(inst)
                if inst.sg.statemem.moose then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --moose groggy
            TimeEvent(14 * FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),
            TimeEvent(30 * FRAMES, function(inst)
                if inst.sg.statemem.moosegroggy then
                    DoMooseRunSounds(inst)
                    DoFoleySounds(inst)
                end
            end),

            --goose
            --Frame 1 shared with groggy above
            --[[TimeEvent(1 * FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),]]
            TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.goose then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseRunFX(inst)
                end
            end),

            --goose groggy
            TimeEvent(4 * FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseWalkFX(inst)
                end
            end),
            TimeEvent(17 * FRAMES, function(inst)
                if inst.sg.statemem.goosegroggy then
                    DoRunSounds(inst)
                    DoFoleySounds(inst)
                    DoGooseWalkFX(inst)
                end
            end),
        },

        events =
        {
            EventHandler("gogglevision", function(inst, data)
                if data.enabled then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst:IsInAnyStormOrCloud()) then
                    inst.sg:GoToState("run")
                end
            end),
            EventHandler("sandstormlevel", function(inst, data)
                if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst.components.inventory:EquipHasTag("goggles")) then
                    inst.sg:GoToState("run")
                end
            end),
            EventHandler("miasmalevel", function(inst, data)
                if data.level < 1 then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.iswere or
                            inst.sg.statemem.sandstorm or
                            inst.components.inventory:EquipHasTag("goggles")) then
                    inst.sg:GoToState("run")
                end
            end),
            EventHandler("carefulwalking", function(inst, data)
                if not data.careful then
                    if inst.sg.statemem.careful then
                        inst.sg:GoToState("run")
                    end
                elseif not (inst.sg.statemem.riding or
                            inst.sg.statemem.heavy or
                            inst.sg.statemem.sandstorm or
                            inst.sg.statemem.groggy or
                            inst.sg.statemem.careful or
                            inst.sg.statemem.iswere) then
                    inst.sg:GoToState("run")
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("run")
        end,
    },

    State{
        name = "run_stop",
        tags = {"canrotate", "idle"},

        onenter = function(inst)
            ConfigureRunState(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation(GetRunStateAnim(inst).."_pst")

            if inst.sg.statemem.moose or inst.sg.statemem.moosegroggy then
                PlayMooseFootstep(inst, .6, true)
                DoFoleySounds(inst)
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
        name = "dostandingaction",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give")
            inst.AnimState:PushAnimation("give_pst", false)

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(14 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
				inst.sg:RemoveStateTag("busy")
                inst:PerformBufferedAction()
            end),
        },

        ontimeout = function(inst)
            --give_pst should still be playing
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "doequippedaction",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give_equipped")
            inst.AnimState:PushAnimation("give_equipped_pst", false)

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(14 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(6 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(12 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        ontimeout = function(inst)
            --give_pst should still be playing
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "catch_equip",
        tags = { "idle" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("catch_pre")
            inst.AnimState:PushAnimation("catch", false)
        end,

        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst.sg.statemem.playedfx = true
                SpawnPrefab("lucy_transform_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_object", 50, -25, 0)
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_catch")
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
            if not inst.sg.statemem.playedfx then
                SpawnPrefab("lucy_transform_fx").entity:AddFollower():FollowSymbol(inst.GUID, "swap_object", 50, -25, 0)
            end
        end,
    },

    State{
        name = "item_hat",
        tags = { "idle", "keepchannelcasting" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("item_hat")
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
        name = "item_in",
        tags = { "idle", "nodangle", "keepchannelcasting" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("item_in")
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
            if inst.sg.statemem.followfx ~= nil then
                for i, v in ipairs(inst.sg.statemem.followfx) do
                    v:Remove()
                end
            end
        end,
    },

    State{
        name = "item_out",
        tags = { "idle", "nodangle", "keepchannelcasting" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("item_out")
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
        name = "give",
        tags = { "giving" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("give")
            inst.AnimState:PushAnimation("give_pst", false)
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst:PerformBufferedAction()
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
    },

    State{
        name = "doshortaction",
        tags = { "doing", "busy", "keepchannelcasting" },

        onenter = function(inst, silent)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickup")
            inst.AnimState:PushAnimation("pickup_pst", false)

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg.statemem.silent = silent
            inst.sg:SetTimeout(10 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(6 * FRAMES, function(inst)
                if inst.sg.statemem.silent then
                    inst.components.talker:IgnoreAll("silentpickup")
                    inst:PerformBufferedAction()
                    inst.components.talker:StopIgnoringAll("silentpickup")
                else
                    inst:PerformBufferedAction()
                end
            end),
        },

        ontimeout = function(inst)
            --pickup_pst should still be playing
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "dosilentshortaction",
        tags = { "keepchannelcasting" },

        onenter = function(inst)
            inst.sg:GoToState("doshortaction", true)
        end,
    },

    State{
        name = "domediumaction",

        onenter = function(inst)
            inst.sg:GoToState("dolongaction", .5)
        end,
    },

    State{
        name = "dolongaction",
        tags = { "doing", "busy", "nodangle" },

        onenter = function(inst, timeout)
            if timeout == nil then
                timeout = 1
            elseif timeout > 1 then
                inst.sg:AddStateTag("slowaction")
            end
            inst.sg:SetTimeout(timeout)
            inst.components.locomotor:Stop()
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
            inst.AnimState:PlayAnimation("build_pre")
            inst.AnimState:PushAnimation("build_loop", true)
            if inst.bufferedaction ~= nil then
                inst.sg.statemem.action = inst.bufferedaction
                if inst.bufferedaction.action.actionmeter then
                    inst.sg.statemem.actionmeter = true
                    StartActionMeter(inst, timeout)
                end
                if inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                    inst.bufferedaction.target:PushEvent("startlongaction", inst)
                end
            end
        end,

        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        ontimeout = function(inst)
            inst.SoundEmitter:KillSound("make")
            inst.AnimState:PlayAnimation("build_pst")
            if inst.sg.statemem.actionmeter then
                inst.sg.statemem.actionmeter = nil
                StopActionMeter(inst, true)
            end
            inst.sg:RemoveStateTag("busy")
            inst:PerformBufferedAction()
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
            if inst.sg.statemem.actionmeter then
                StopActionMeter(inst, false)
            end
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "dolongestaction",
        onenter = function(inst)
            inst.sg:GoToState("dolongaction", TUNING.LONGEST_ACTION_TIMEOUT)
        end,
    },

    State{
        --Alternative to doshortaction but animated with your held tool
        --Animation mirrors attack action, but are not "auto" predicted
        --by clients (also no sound prediction)
        name = "dojostleaction",
        tags = { "doing", "busy" },

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.locomotor:Stop()
            local cooldown
            if inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                DoMountSound(inst, inst.components.rider:GetMount(), "angry")
                cooldown = 16 * FRAMES
            elseif equip ~= nil and equip:HasTag("whip") then
                inst.AnimState:PlayAnimation("whip_pre")
                inst.AnimState:PushAnimation("whip", false)
                inst.sg.statemem.iswhip = true
                inst.SoundEmitter:PlaySound("dontstarve/common/whip_large")
                cooldown = 17 * FRAMES
            elseif equip ~= nil and equip:HasTag("pocketwatch") then
                inst.AnimState:PlayAnimation("pocketwatch_atk_pre" )
                inst.AnimState:PushAnimation("pocketwatch_atk", false)
                inst.sg.statemem.ispocketwatch = true
                cooldown = 19 * FRAMES
                if equip:HasTag("shadow_item") then
                    inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/pre_shadow")
                    inst.AnimState:Show("pocketwatch_weapon_fx")
                    inst.sg.statemem.ispocketwatch_fueled = true
                else
                    inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/pre")
                    inst.AnimState:Hide("pocketwatch_weapon_fx")
                end
            elseif equip ~= nil and equip:HasTag("jab") then
                inst.AnimState:PlayAnimation("spearjab_pre")
                inst.AnimState:PushAnimation("spearjab", false)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
                cooldown = 21 * FRAMES
            elseif equip ~= nil and equip.components.weapon ~= nil and not equip:HasTag("punch") then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                cooldown = 13 * FRAMES
            elseif equip ~= nil and (equip:HasTag("light") or equip:HasTag("nopunch")) then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                cooldown = 13 * FRAMES
            else
                inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
                cooldown = 24 * FRAMES
            end

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target:GetPosition())
            end

            inst.sg.statemem.action = buffaction
            inst.sg:SetTimeout(cooldown)
        end,

        timeline =
        {
            --whip: frame 10 action
            --other: frame 8 action
            TimeEvent(8 * FRAMES, function(inst)
                if not (inst.sg.statemem.iswhip or
                        inst.sg.statemem.ispocketwatch) then
                    inst.sg:RemoveStateTag("busy")
                    inst:PerformBufferedAction()
                end
            end),
            TimeEvent(10 * FRAMES, function(inst)
                if inst.sg.statemem.iswhip or inst.sg.statemem.ispocketwatch then
                    inst.sg:RemoveStateTag("busy")
                    inst:PerformBufferedAction()
                end
            end),
            TimeEvent(17*FRAMES, function(inst)
                if inst.sg.statemem.ispocketwatch then
                    inst.SoundEmitter:PlaySound(inst.sg.statemem.ispocketwatch_fueled and "wanda2/characters/wanda/watch/weapon/pst_shadow" or "wanda2/characters/wanda/watch/weapon/pst")
                end
            end),
        },

        ontimeout = function(inst)
            --anim pst should still be playing
            inst.sg:GoToState("idle", true)
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        },

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "talk",
        tags = { "idle", "talking" },

        onenter = function(inst, noanim)
            if not noanim then
                inst.AnimState:PlayAnimation(
                    inst.components.inventory:IsHeavyLifting() and
                    not inst.components.rider:IsRiding() and
                    "heavy_dial_loop" or
                    "dial_loop",
                    true)
            end
            DoTalkSound(inst)
            inst.sg:SetTimeout(1.5 + math.random() * .5)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,

        events =
        {
            EventHandler("donetalking", function(inst)
                inst.sg:GoToState("idle")
            end),
        },

        onexit = StopTalkSound,
    },

    State{
        name = "stunned",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst:ClearBufferedAction()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_sanity_pre")
            inst.AnimState:PushAnimation("idle_sanity_loop", true)
            inst.sg:SetTimeout(5)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,
    },

    State{
        name = "wakeup",
        tags = { "busy", "waking", "nomorph", "nodangle" },

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            if inst.AnimState:IsCurrentAnimation("bedroll") or
                inst.AnimState:IsCurrentAnimation("bedroll_sleep_loop") then
                inst.AnimState:PlayAnimation("bedroll_wakeup")
            elseif not (inst.AnimState:IsCurrentAnimation("bedroll_wakeup") or
                        inst.AnimState:IsCurrentAnimation("wakeup")) then
                inst.AnimState:PlayAnimation("wakeup")
            end

            --Touch stone rez
            inst.sg.statemem.isresurrection = true
            inst.sg:AddStateTag("nopredict")
            inst.sg:AddStateTag("silentmorph")
            inst.sg:RemoveStateTag("nomorph")
            inst.components.health:SetInvincible(false)
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
            if inst.components.follower ~= nil then
                inst.components.follower.leader = nil
            end
        end,
    },

    State{
        name = "toolbroke",
        tags = { "busy", "pausepredict" },

        onenter = function(inst, tool)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/use_break")
            inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")

            if tool == nil or not tool.nobrokentoolfx then
                SpawnPrefab("brokentool").Transform:SetPosition(inst.Transform:GetWorldPosition())
            end

            inst.sg.statemem.toolname = tool ~= nil and tool.prefab or nil

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.sg:SetTimeout(10 * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.sg.statemem.toolname ~= nil then
                local sameTool = inst.components.inventory:FindItem(function(item)
                    return item.prefab == inst.sg.statemem.toolname
                end)
                if sameTool ~= nil then
                    inst.components.inventory:Equip(sameTool)
                end
            end

            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end,
    },

    State{
        name = "armorbroke",
        tags = { "busy", "pausepredict" },

        onenter = function(inst, armor)
            inst.AnimState:PlayAnimation("hit")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/use_armour_break")

            if armor ~= nil then
                local sameArmor = inst.components.inventory:FindItem(function(item)
                    return item.prefab == armor.prefab
                end)
                if sameArmor ~= nil then
                    inst.components.inventory:Equip(sameArmor)
                end
            end

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.sg:SetTimeout(10 * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,
    },

    State{
        name = "hammered",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst:ClearBufferedAction()

            if inst.components.rider:IsRiding() then
                DoMountSound(inst, inst.components.rider:GetMount(), "yell")
                inst.AnimState:PlayAnimation("fall_off")
                inst.sg:AddStateTag("dismounting")
            else
                inst.AnimState:PlayAnimation("hit")
            end
        end,

        timeline =
        {
            TimeEvent(3*FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("ontalk", function(inst)
                if inst.sg.statemem.talktask ~= nil then
                    inst.sg.statemem.talktask:Cancel()
                    inst.sg.statemem.talktask = nil
                    StopTalkSound(inst, true)
                end
                if DoTalkSound(inst) then
                    inst.sg.statemem.talktask =
                        inst:DoTaskInTime(1.5 + math.random() * .5,
                            function()
                                inst.sg.statemem.talktask = nil
                                StopTalkSound(inst)
                            end)
                end
            end),
            EventHandler("donetalking", function(inst)
                if inst.sg.statemem.talktalk ~= nil then
                    inst.sg.statemem.talktask:Cancel()
                    inst.sg.statemem.talktask = nil
                    StopTalkSound(inst)
                end
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg:HasStateTag("dismounting") then
                        inst.sg:RemoveStateTag("dismounting")
                        inst.components.rider:ActualDismount()
                    end
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.talktask ~= nil then
                inst.sg.statemem.talktask:Cancel()
                inst.sg.statemem.talktask = nil
                StopTalkSound(inst)
            end
        end,
    },

    State{
        name = "migrate",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickup")

            inst.sg.statemem.action = inst.bufferedaction
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() and
                    not inst:PerformBufferedAction() then
                    inst.AnimState:PlayAnimation("pickup_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    ---------------------
    -- Military States --
    ---------------------
    State{
        name = "attack",
        tags = {"attack", "notalking", "abouttoattack", "busy"},

        onenter = function(inst)
            if inst.sg.laststate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
            end
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.Physics:Stop()
            local cooldown = 0
            if inst.components.rider:IsRiding() then
                if equip ~= nil and (equip.components.projectile ~= nil or equip:HasTag("rangedweapon")) then
                    inst.AnimState:PlayAnimation("player_atk_pre")
                    inst.AnimState:PushAnimation("player_atk", false)

                    if (equip.projectiledelay or 0) > 0 then
                        --V2C: Projectiles don't show in the initial delayed frames so that
                        --     when they do appear, they're already in front of the player.
                        --     Start the attack early to keep animation in sync.
                        inst.sg.statemem.projectiledelay = 8 * FRAMES - equip.projectiledelay
                        if inst.sg.statemem.projectiledelay > FRAMES then
                            inst.sg.statemem.projectilesound =
                                (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                                (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                                "dontstarve/wilson/attack_weapon"
                        elseif inst.sg.statemem.projectiledelay <= 0 then
                            inst.sg.statemem.projectiledelay = nil
                        end
                    end
                    if inst.sg.statemem.projectilesound == nil then
                        inst.SoundEmitter:PlaySound(
                            (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                            (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                            "dontstarve/wilson/attack_weapon",
                            nil, nil, true
                        )
                    end
                    cooldown = math.max(cooldown, 13 * FRAMES)
                else
                    inst.AnimState:PlayAnimation("atk_pre")
                    inst.AnimState:PushAnimation("atk", false)
                    DoMountSound(inst, inst.components.rider:GetMount(), "angry", true)
                    cooldown = math.max(cooldown, 16 * FRAMES)
                end
            elseif equip ~= nil and equip:HasTag("toolpunch") then

                -- **** ANIMATION WARNING ****
                -- **** ANIMATION WARNING ****
                -- **** ANIMATION WARNING ****

                --  THIS ANIMATION LAYERS THE LANTERN GLOW UNDER THE ARM IN THE UP POSITION SO CANNOT BE USED IN STANDARD LANTERN GLOW ANIMATIONS.
                
                inst.AnimState:PlayAnimation("toolpunch")
                inst.sg.statemem.istoolpunch = true
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, inst.sg.statemem.attackvol, true)
                cooldown = math.max(cooldown, 13 * FRAMES)
            elseif equip ~= nil and equip:HasTag("whip") then
                inst.AnimState:PlayAnimation("whip_pre")
                inst.AnimState:PushAnimation("whip", false)
                inst.sg.statemem.iswhip = true
                inst.SoundEmitter:PlaySound("dontstarve/common/whip_pre", nil, nil, true)
                cooldown = math.max(cooldown, 17 * FRAMES)
            elseif equip ~= nil and equip:HasTag("pocketwatch") then
                inst.AnimState:PlayAnimation(inst.sg.statemem.chained and "pocketwatch_atk_pre_2" or "pocketwatch_atk_pre" )
                inst.AnimState:PushAnimation("pocketwatch_atk", false)
                inst.sg.statemem.ispocketwatch = true
                cooldown = math.max(cooldown, 15 * FRAMES)
                if equip:HasTag("shadow_item") then
                    inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/pre_shadow", nil, nil, true)
                    inst.AnimState:Show("pocketwatch_weapon_fx")
                    inst.sg.statemem.ispocketwatch_fueled = true
                else
                    inst.SoundEmitter:PlaySound("wanda2/characters/wanda/watch/weapon/pre", nil, nil, true)
                    inst.AnimState:Hide("pocketwatch_weapon_fx")
                end
            elseif equip ~= nil and equip:HasTag("book") then
                inst.AnimState:PlayAnimation("attack_book")
                inst.sg.statemem.isbook = true
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                cooldown = math.max(cooldown, 19 * FRAMES)
            elseif equip ~= nil and equip.components.weapon ~= nil and not equip:HasTag("punch") then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                if (equip.projectiledelay or 0) > 0 then
                    --V2C: Projectiles don't show in the initial delayed frames so that
                    --     when they do appear, they're already in front of the player.
                    --     Start the attack early to keep animation in sync.
                    inst.sg.statemem.projectiledelay = 8 * FRAMES - equip.projectiledelay
                    if inst.sg.statemem.projectiledelay > FRAMES then
                        inst.sg.statemem.projectilesound =
                            (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                            (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                            "dontstarve/wilson/attack_weapon"
                    elseif inst.sg.statemem.projectiledelay <= 0 then
                        inst.sg.statemem.projectiledelay = nil
                    end
                end
                if inst.sg.statemem.projectilesound == nil then
                    inst.SoundEmitter:PlaySound(
                        (equip:HasTag("icestaff") and "dontstarve/wilson/attack_icestaff") or
                        (equip:HasTag("shadow") and "dontstarve/wilson/attack_nightsword") or
                        (equip:HasTag("firestaff") and "dontstarve/wilson/attack_firestaff") or
                        "dontstarve/wilson/attack_weapon",
                        nil, nil, true
                    )
                end
                cooldown = math.max(cooldown, 13 * FRAMES)
            elseif equip ~= nil and (equip:HasTag("light") or equip:HasTag("nopunch")) then
                inst.AnimState:PlayAnimation("atk_pre")
                inst.AnimState:PushAnimation("atk", false)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon", nil, nil, true)
                cooldown = math.max(cooldown, 13 * FRAMES)
            else
                inst.AnimState:PlayAnimation("punch")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh", nil, nil, true)
                cooldown = math.max(cooldown, 24 * FRAMES)
            end

            inst.sg:SetTimeout(cooldown)

            if inst.components.combat.target ~= nil and inst.components.combat.target:IsValid() then
                inst:FacePoint(inst.components.combat.target.Transform:GetWorldPosition())
            end
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) inst.sg:RemoveStateTag("abouttoattack") end),
            TimeEvent(12*FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(13*FRAMES, function(inst)
                inst.sg:RemoveStateTag("attack")
            end),
        },

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "blowdart",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            if inst.components.combat:InCooldown() then
                inst.sg:RemoveStateTag("abouttoattack")
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle", true)
                return
            end
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("dart_pre")
            if inst.sg.laststate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
                inst.AnimState:SetTime(5 * FRAMES)
            end
            inst.AnimState:PushAnimation("dart", false)

            inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * FRAMES, inst.components.combat.min_attack_period + .5 * FRAMES))

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
            end

            if (equip ~= nil and equip.projectiledelay or 0) > 0 then
                --V2C: Projectiles don't show in the initial delayed frames so that
                --     when they do appear, they're already in front of the player.
                --     Start the attack early to keep animation in sync.
                inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * FRAMES - equip.projectiledelay
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst.sg.statemem.projectiledelay = nil
                end
            end
        end,

        onupdate = function(inst, dt)
            if (inst.sg.statemem.projectiledelay or 0) > 0 then
                inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
                if inst.sg.statemem.projectiledelay <= 0 then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                if inst.sg.statemem.chained then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
                end
            end),
            TimeEvent(9 * FRAMES, function(inst)
                if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
                if not inst.sg.statemem.chained then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/blowdart_shoot", nil, nil, true)
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
                if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
                    inst:PerformBufferedAction()
                    inst.sg:RemoveStateTag("abouttoattack")
                end
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    },

    State{
        name = "throw",
        tags = { "attack", "notalking", "abouttoattack", "autopredict" },

        onenter = function(inst)
            if inst.components.combat:InCooldown() then
                inst.sg:RemoveStateTag("abouttoattack")
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle", true)
                return
            end
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            local cooldown = math.max(inst.components.combat.min_attack_period + .5 * FRAMES, 11 * FRAMES)

            inst.AnimState:PlayAnimation("throw")

            inst.sg:SetTimeout(cooldown)

            if target ~= nil and target:IsValid() then
                inst:FacePoint(target.Transform:GetWorldPosition())
                inst.sg.statemem.attacktarget = target
            end
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.sg.statemem.thrown = true
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst, data)
                if data.eslot ~= EQUIPSLOTS.HANDS or not inst.sg.statemem.thrown then
                    inst.sg:GoToState("idle")
                end
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    },

    State{
        name = "death",
        tags = { "busy", "dead", "pausepredict", "nomorph" },

        onenter = function(inst)
            inst.Physics:Stop()
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            if inst.components.rider:IsRiding() then
                DoMountSound(inst, inst.components.rider:GetMount(), "yell")
                inst.AnimState:PlayAnimation("fall_off")
                inst.sg:AddStateTag("dismounting")
            else
                inst.SoundEmitter:PlaySound("dontstarve/wilson/death")
                if inst.deathsoundoverride ~= nil then
                    inst.SoundEmitter:PlaySound(inst.deathsoundoverride)
                elseif not inst:HasTag("mime") then
                    inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/death_voice")
                end

                inst.components.inventory:DropEverything(true)
                inst.AnimState:PlayAnimation(inst.deathanimoverride or "death")

                inst.AnimState:Hide("swap_arm_carry")
            end

            if inst.components.burnable ~= nil then
                inst.components.burnable:Extinguish()
            end

            inst.sg:ClearBufferedEvents()
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg:HasStateTag("dismounting") then
                        inst.sg:RemoveStateTag("dismounting")
                        inst.components.rider:ActualDismount()

                        inst.SoundEmitter:PlaySound("dontstarve/wilson/death")

                        if inst.deathsoundoverride ~= nil then
                            inst.SoundEmitter:PlaySound(FunctionOrValue(inst.deathsoundoverride, inst))
                        elseif not inst:HasTag("mime") then
                            inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/death_voice")
                        end

                        inst.components.inventory:DropEverything(true)
                        inst.AnimState:PlayAnimation(inst.deathanimoverride or "death")

                        inst.AnimState:Hide("swap_arm_carry")
                    end
                end
            end),
        },
    },

    State{
        name = "hit",
        tags = { "busy", "pausepredict", "keepchannelcasting" },

        onenter = function(inst, frozen)
            inst.Physics:Stop()
            --inst:ClearBufferedAction()
            inst:InterruptBufferedAction()

            inst.AnimState:PlayAnimation("hit")

            if frozen == "noimpactsound" then
                frozen = nil
            else
                inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
            end
            DoHurtSound(inst)

            local stun_frames = math.min(inst.AnimState:GetCurrentAnimationNumFrames(), frozen and 10 or 6)
            if inst.components.playercontroller ~= nil then
                --Specify min frames of pause since "busy" tag may be
                --removed too fast for our network update interval.
                inst.components.playercontroller:RemotePausePrediction(stun_frames <= 7 and stun_frames or nil)
            end
            inst.sg:SetTimeout(stun_frames * FRAMES)
        end,

        ontimeout = function(inst)
            --V2C: -removing the tag now, since this is actually a supported "channeling_item"
            --      state (i.e. has custom anim)
            --     -the state enters with the tag though, to cheat having to create a separate
            --      hit state for channeling items
            inst.sg:RemoveStateTag("keepchannelcasting")
            inst.sg:GoToState("idle", true)
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
        name = "hit_spike",
        tags = { "busy", "nopredict", "nomorph" },

        onenter = function(inst, spike)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            local anim = "short"

            if spike ~= nil and type(spike) == "table" then
                inst:ForceFacePoint(spike.Transform:GetWorldPosition())
                if spike.spikesize then
                    anim = spike.spikesize
                end
            else
                anim = spike
            end
            inst.AnimState:PlayAnimation("hit_spike_"..anim)

            inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
            DoHurtSound(inst)

            inst.sg:SetTimeout(15 * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,
    },

    State{
        name = "hit_push",
        tags = { "busy", "nopredict", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("hit")

            inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
            DoHurtSound(inst)

            inst.sg:SetTimeout(6 * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,
    },

    State{
        name = "startle",
        tags = { "busy" },

        onenter = function(inst, snap)
            local usehit = inst.components.rider:IsRiding()
            local stun_frames = usehit and 6 or 9

            if snap then
                inst.sg:AddStateTag("nopredict")
            else
                inst.sg:AddStateTag("pausepredict")
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:RemotePausePrediction(stun_frames <= 7 and stun_frames or nil)
                end
            end

            ClearStatusAilments(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            if usehit then
                inst.AnimState:PlayAnimation("hit")
            else
                inst.AnimState:PlayAnimation("distress_pre")
                inst.AnimState:PushAnimation("distress_pst", false)
            end

            DoHurtSound(inst)

            inst.sg:SetTimeout(stun_frames * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,
    },

    State{
        name = "repelled",
        tags = { "busy", "nopredict", "nomorph" },

        onenter = function(inst, data)
            ClearStatusAilments(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            --In case mount has shorter hit anims
            local stun_frames = 9
            if inst.components.rider:IsRiding() then
                inst.AnimState:PlayAnimation("hit")
                stun_frames = math.min(inst.AnimState:GetCurrentAnimationNumFrames(), stun_frames)
            else
                inst.AnimState:PlayAnimation("distress_pre")
                inst.AnimState:PushAnimation("distress_pst", false)
            end

            DoHurtSound(inst)

            if data ~= nil then
                if data.knocker ~= nil then
                    inst.sg:AddStateTag("nointerrupt")
                end
                if data.radius ~= nil and data.repeller ~= nil and data.repeller:IsValid() then
                    local x, y, z = data.repeller.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    local rangesq = data.radius * data.radius
                    if distsq < rangesq then
                        if distsq > 0 then
                            inst:ForceFacePoint(x, y, z)
                        end
                        local k = .5 * distsq / rangesq - 1
                        inst.sg.statemem.speed = (data.strengthmult or 1) * 25 * k
                        inst.sg.statemem.dspeed = 2
                        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                    end
                end
            end

            inst.sg:SetTimeout(9 * FRAMES)
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.sg.statemem.speed = inst.sg.statemem.speed + inst.sg.statemem.dspeed
                if inst.sg.statemem.speed < 0 then
                    inst.sg.statemem.dspeed = inst.sg.statemem.dspeed + .25
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                else
                    inst.sg.statemem.speed = nil
                    inst.sg.statemem.dspeed = nil
                    inst.Physics:Stop()
                end
            end
        end,

        timeline =
        {
            FrameEvent(4, function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.Physics:Stop()
            end
        end,
    },

    State{
        name = "knockback",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "nointerrupt", "jumping" },

        onenter = function(inst, data)
            ClearStatusAilments(inst)
            inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("knockback_high")

            if data ~= nil then
                if data.disablecollision then
                    ToggleOffPhysics(inst)
                    inst.Physics:CollidesWith(COLLISION.WORLD)
                end
                if data.propsmashed then
                    local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    local pos
                    if item ~= nil then
                        pos = inst:GetPosition()
                        pos.y = TUNING.KNOCKBACK_DROP_ITEM_HEIGHT_HIGH
                        local dropped = inst.components.inventory:DropItem(item, true, true, pos)
                        if dropped ~= nil then
                            dropped:PushEvent("knockbackdropped", { owner = inst, knocker = data.knocker, delayinteraction = TUNING.KNOCKBACK_DELAY_INTERACTION_HIGH, delayplayerinteraction = TUNING.KNOCKBACK_DELAY_PLAYER_INTERACTION_HIGH })
                        end
                    end
                    if item == nil or not item:HasTag("propweapon") then
                        item = inst.components.inventory:FindItem(IsMinigameItem)
                        if item ~= nil then
                            pos = pos or inst:GetPosition()
                            pos.y = TUNING.KNOCKBACK_DROP_ITEM_HEIGHT_LOW
                            item = inst.components.inventory:DropItem(item, false, true, pos)
                            if item ~= nil then
                                item:PushEvent("knockbackdropped", { owner = inst, knocker = data.knocker, delayinteraction = TUNING.KNOCKBACK_DELAY_INTERACTION_LOW, delayplayerinteraction = TUNING.KNOCKBACK_DELAY_PLAYER_INTERACTION_LOW })
                            end
                        end
                    end
                end
                if data.radius ~= nil and data.knocker ~= nil and data.knocker:IsValid() then
                    local x, y, z = data.knocker.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    local rangesq = data.radius * data.radius
                    local rot = inst.Transform:GetRotation()
                    local rot1 = distsq > 0 and inst:GetAngleToPoint(x, y, z) or data.knocker.Transform:GetRotation() + 180
                    local drot = math.abs(rot - rot1)
                    while drot > 180 do
                        drot = math.abs(drot - 360)
                    end
                    local k = distsq < rangesq and .3 * distsq / rangesq - 1 or -.7
                    inst.sg.statemem.speed = (data.strengthmult or 1) * 12 * k
                    inst.sg.statemem.dspeed = 0
                    if drot > 90 then
                        inst.sg.statemem.reverse = true
                        inst.Transform:SetRotation(rot1 + 180)
                        inst.Physics:SetMotorVel(-inst.sg.statemem.speed, 0, 0)
                    else
                        inst.Transform:SetRotation(rot1)
                        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                    end
                end
            end
            if not inst.sg.statemem.isphysicstoggle then
                if inst:IsOnPassablePoint(true) then
                    inst.sg.statemem.safepos = inst:GetPosition()
                elseif data ~= nil and data.knocker ~= nil and data.knocker:IsValid() and data.knocker:IsOnPassablePoint(true) then
                    local x1, y1, z1 = data.knocker.Transform:GetWorldPosition()
                    local radius = data.knocker:GetPhysicsRadius(0) - inst:GetPhysicsRadius(0)
                    if radius > 0 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        local dx = x - x1
                        local dz = z - z1
                        local dist = radius / math.sqrt(dx * dx + dz * dz)
                        x = x1 + dx * dist
                        z = z1 + dz * dist
                        if TheWorld.Map:IsPassableAtPoint(x, 0, z, true) then
                            x1, z1 = x, z
                        end
                    end
                    inst.sg.statemem.safepos = Vector3(x1, 0, z1)
                end
            end
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.sg.statemem.speed = inst.sg.statemem.speed + inst.sg.statemem.dspeed
                if inst.sg.statemem.speed < 0 then
                    inst.sg.statemem.dspeed = inst.sg.statemem.dspeed + .075
                    inst.Physics:SetMotorVel(inst.sg.statemem.reverse and -inst.sg.statemem.speed or inst.sg.statemem.speed, 0, 0)
                else
                    inst.sg.statemem.speed = nil
                    inst.sg.statemem.dspeed = nil
                    inst.Physics:Stop()
                end
            end
            local safepos = inst.sg.statemem.safepos
            if safepos ~= nil then
                if inst:IsOnPassablePoint(true) then
                    safepos.x, safepos.y, safepos.z = inst.Transform:GetWorldPosition()
                elseif inst.sg.statemem.landed then
                    local mass = inst.Physics:GetMass()
                    if mass > 0 then
                        inst.sg.statemem.restoremass = mass
                        inst.Physics:SetMass(99999)
                    end
                    inst.Physics:Teleport(safepos.x, 0, safepos.z)
                    inst.sg.statemem.safepos = nil
                end
            end
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),
            FrameEvent(10, function(inst)
                inst.sg.statemem.landed = true
                inst.sg:RemoveStateTag("nointerrupt")
                inst.sg:RemoveStateTag("jumping")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("knockback_pst")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.restoremass ~= nil then
                inst.Physics:SetMass(inst.sg.statemem.restoremass)
            end
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            if inst.sg.statemem.speed ~= nil then
                inst.Physics:Stop()
            end
        end,
    },

    State{
        name = "knockback_pst",
        tags = { "knockback", "busy", "nomorph", "nodangle" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("buck_pst")
        end,

        timeline =
        {
            TimeEvent(27 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("knockback")
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nomorph")
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
        name = "knockbacklanded",
        tags = { "knockback", "busy", "nopredict", "nomorph", "nointerrupt", "jumping" },

        onenter = function(inst, data)
            ClearStatusAilments(inst)
            inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("hit_spike_heavy")

            if data ~= nil then
                if data.propsmashed then
                    local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    local pos
                    if item ~= nil then
                        pos = inst:GetPosition()
                        pos.y = TUNING.KNOCKBACK_DROP_ITEM_HEIGHT_LOW
                        local dropped = inst.components.inventory:DropItem(item, true, true, pos)
                        if dropped ~= nil then
                            dropped:PushEvent("knockbackdropped", { owner = inst, knocker = data.knocker, delayinteraction = TUNING.KNOCKBACK_DELAY_INTERACTION_LOW, delayplayerinteraction = TUNING.KNOCKBACK_DELAY_PLAYER_INTERACTION_LOW })
                        end
                    end
                    if item == nil or not item:HasTag("propweapon") then
                        item = inst.components.inventory:FindItem(IsMinigameItem)
                        if item ~= nil then
                            if pos == nil then
                                pos = inst:GetPosition()
                                pos.y = TUNING.KNOCKBACK_DROP_ITEM_HEIGHT_LOW
                            end
                            item = inst.components.inventory:DropItem(item, false, true, pos)
                            if item ~= nil then
                                item:PushEvent("knockbackdropped", { owner = inst, knocker = data.knocker, delayinteraction = TUNING.KNOCKBACK_DELAY_INTERACTION_LOW, delayplayerinteraction = TUNING.KNOCKBACK_DELAY_PLAYER_INTERACTION_LOW })
                            end
                        end
                    end
                end
                if data.radius ~= nil and data.knocker ~= nil and data.knocker:IsValid() then
                    local x, y, z = data.knocker.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    local rangesq = data.radius * data.radius
                    local rot = inst.Transform:GetRotation()
                    local rot1 = distsq > 0 and inst:GetAngleToPoint(x, y, z) or data.knocker.Transform:GetRotation() + 180
                    local drot = math.abs(rot - rot1)
                    while drot > 180 do
                        drot = math.abs(drot - 360)
                    end
                    local k = distsq < rangesq and .3 * distsq / rangesq - 1 or -.7
                    inst.sg.statemem.speed = (data.strengthmult or 1) * 8 * k
                    inst.sg.statemem.dspeed = 0
                    if drot > 90 then
                        inst.sg.statemem.reverse = true
                        inst.Transform:SetRotation(rot1 + 180)
                        inst.Physics:SetMotorVel(-inst.sg.statemem.speed, 0, 0)
                    else
                        inst.Transform:SetRotation(rot1)
                        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                    end
                end
            end

            if inst:IsOnPassablePoint(true) then
                inst.sg.statemem.safepos = inst:GetPosition()
            elseif data ~= nil and data.knocker ~= nil and data.knocker:IsValid() and data.knocker:IsOnPassablePoint(true) then
                local x1, y1, z1 = data.knocker.Transform:GetWorldPosition()
                local radius = data.knocker:GetPhysicsRadius(0) - inst:GetPhysicsRadius(0)
                if radius > 0 then
                    local x, y, z = inst.Transform:GetWorldPosition()
                    local dx = x - x1
                    local dz = z - z1
                    local dist = radius / math.sqrt(dx * dx + dz * dz)
                    x = x1 + dx * dist
                    z = z1 + dz * dist
                    if TheWorld.Map:IsPassableAtPoint(x, 0, z, true) then
                        x1, z1 = x, z
                    end
                end
                inst.sg.statemem.safepos = Vector3(x1, 0, z1)
            end

            inst.sg:SetTimeout(11 * FRAMES)
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.sg.statemem.speed = inst.sg.statemem.speed + inst.sg.statemem.dspeed
                if inst.sg.statemem.speed < 0 then
                    inst.sg.statemem.dspeed = inst.sg.statemem.dspeed + .075
                    inst.Physics:SetMotorVel(inst.sg.statemem.reverse and -inst.sg.statemem.speed or inst.sg.statemem.speed, 0, 0)
                else
                    inst.sg.statemem.speed = nil
                    inst.sg.statemem.dspeed = nil
                    inst.Physics:Stop()
                end
            end
            local safepos = inst.sg.statemem.safepos
            if safepos ~= nil then
                if inst:IsOnPassablePoint(true) then
                    safepos.x, safepos.y, safepos.z = inst.Transform:GetWorldPosition()
                elseif inst.sg.statemem.landed then
                    local mass = inst.Physics:GetMass()
                    if mass > 0 then
                        inst.sg.statemem.restoremass = mass
                        inst.Physics:SetMass(99999)
                    end
                    inst.Physics:Teleport(safepos.x, 0, safepos.z)
                    inst.sg.statemem.safepos = nil
                end
            end
        end,

        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),
            FrameEvent(10, function(inst)
                inst.sg.statemem.landed = true
                inst.sg:RemoveStateTag("nointerrupt")
                inst.sg:RemoveStateTag("jumping")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.sg.statemem.restoremass ~= nil then
                inst.Physics:SetMass(inst.sg.statemem.restoremass)
            end
            if inst.sg.statemem.speed ~= nil then
                inst.Physics:Stop()
            end
        end,
    },

    State{
        name = "parry_knockback",
        tags = { "parrying", "parryhit", "busy", "nopredict", "nomorph" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("parryblock")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")

            if data ~= nil then
                if data.timeleft ~= nil then
                    inst.sg.statemem.timeleft0 = GetTime()
                    inst.sg.statemem.timeleft = data.timeleft
                end
                data = data.knockbackdata
                if data ~= nil and data.radius ~= nil and data.knocker ~= nil and data.knocker:IsValid() then
                    local x, y, z = data.knocker.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    local rangesq = data.radius * data.radius
                    local rot = inst.Transform:GetRotation()
                    local rot1 = distsq > 0 and inst:GetAngleToPoint(x, y, z) or data.knocker.Transform:GetRotation() + 180
                    local drot = math.abs(rot - rot1)
                    while drot > 180 do
                        drot = math.abs(drot - 360)
                    end
                    local k = distsq < rangesq and .3 * distsq / rangesq - 1 or -.7
                    inst.sg.statemem.speed = (data.strengthmult or 1) * 12 * k
                    if drot > 90 then
                        inst.sg.statemem.reverse = true
                        inst.Transform:SetRotation(rot1 + 180)
                        inst.Physics:SetMotorVel(-inst.sg.statemem.speed, 0, 0)
                    else
                        inst.Transform:SetRotation(rot1)
                        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                    end
                end
            end

            inst.sg:SetTimeout(6 * FRAMES)
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.sg.statemem.speed = .75 * inst.sg.statemem.speed
                inst.Physics:SetMotorVel(inst.sg.statemem.reverse and -inst.sg.statemem.speed or inst.sg.statemem.speed, 0, 0)
            end
        end,

        events =
        {
            EventHandler("unequip", function(inst, data)
                -- We need to handle this because the default unequip
                -- handler is ignored while we are in a "busy" state.
                inst.sg.statemem.unequipped = true
            end),
        },

        ontimeout = function(inst)
            if inst.sg.statemem.unequipped then
                inst.sg:GoToState("idle")
            else
                inst.sg.statemem.parrying = true
                inst.sg:GoToState("parry_idle", inst.sg.statemem.timeleft ~= nil and { duration = math.max(0, inst.sg.statemem.timeleft + inst.sg.statemem.timeleft0 - GetTime()) } or nil)
            end
        end,

        onexit = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.Physics:Stop()
            end
            if not inst.sg.statemem.parrying then
                inst.components.combat.redirectdamagefn = nil
            end
        end,
    },

    State{
        name = "devoured",
        tags = { "devoured", "invisible", "noattack", "notalking", "nointerrupt", "busy", "nopredict", "silentmorph" },

        onenter = function(inst, data)
            local attacker = data.attacker
            ClearStatusAilments(inst)
            local mount = inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("empty")

            inst:Hide()
            inst.DynamicShadow:Enable(false)
            ToggleOffPhysics(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            StopTalkSound(inst, true)
            if inst.components.talker ~= nil then
                inst.components.talker:ShutUp()
                inst.components.talker:IgnoreAll("devoured")
            end
            if attacker ~= nil and attacker:IsValid() then
                inst.sg.statemem.attacker = attacker
                if mount ~= nil then
                    --use true physics radius if available
                    local radius = attacker.Physics ~= nil and attacker.Physics:GetRadius() or attacker:GetPhysicsRadius(0)
                    if radius > 0 then
                        local dir = attacker:GetAngleToPoint(inst.Transform:GetWorldPosition()) * DEGREES
                        local x, y, z = attacker.Transform:GetWorldPosition()
                        x = x + radius * math.cos(dir)
                        z = z - radius * math.sin(dir)
                        if TheWorld.Map:IsPassableAtPoint(x, 0, z) then
                            if mount.Physics ~= nil then
                                mount.Physics:Teleport(x, 0, z)
                            else
                                mount.Transform:SetPosition(x, 0, z)
                            end
                        end
                    end
                end
                inst.Transform:SetRotation(attacker.Transform:GetRotation() + 180)
            end
        end,

        onupdate = function(inst)
            local attacker = inst.sg.statemem.attacker
            if attacker ~= nil and attacker:IsValid() then
                inst.Transform:SetPosition(attacker.Transform:GetWorldPosition())
                inst.Transform:SetRotation(attacker.Transform:GetRotation() + 180)
            else
                inst.sg:GoToState("idle")
            end
        end,

        events =
        {
            EventHandler("spitout", function(inst, data)
                local attacker = data ~= nil and data.spitter or inst.sg.statemem.attacker
                if attacker ~= nil and attacker:IsValid() then
                    local rot = data.rot or attacker.Transform:GetRotation() + 180
                    inst.Transform:SetRotation(rot)
                    local physradius = attacker:GetPhysicsRadius(0)
                    if physradius > 0 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        rot = rot * DEGREES
                        x = x + math.cos(rot) * physradius
                        z = z - math.sin(rot) * physradius
                        inst.Physics:Teleport(x, 0, z)
                    end
                    DoHurtSound(inst)
                    inst.sg:HandleEvent("knockback", {
                        knocker = attacker,
                        radius = data ~= nil and data.radius or physradius + 1,
                        strengthmult = data ~= nil and data.strengthmult or nil,
                    })
                else
                    inst.sg:HandleEvent("knockback")
                end
                --NOTE: ignores heavy armor/body
            end),
        },

        onexit = function(inst)
            if inst.components.health:IsDead() then
                local attacker = inst.sg.statemem.attacker
                if attacker ~= nil and attacker:IsValid() then
                    local rot = attacker.Transform:GetRotation()
                    inst.Transform:SetRotation(rot + 180)
                    --use true physics radius if available
                    local radius = attacker.Physics ~= nil and attacker.Physics:GetRadius() or attacker:GetPhysicsRadius(0)
                    if radius > 0 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        rot = rot * DEGREES
                        x = x + math.cos(rot) * radius
                        z = z - math.sin(rot) * radius
                        if TheWorld.Map:IsPassableAtPoint(x, 0, z, true) then
                            inst.Physics:Teleport(x, 0, z)
                        end
                    end
                end
            end            
            inst:Show()
            inst.DynamicShadow:Enable(true)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            inst.entity:SetParent(nil)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            if inst.components.talker ~= nil then
                inst.components.talker:StopIgnoringAll("devoured")
            end
        end,
    },

    State{
        name = "suspended",
        tags = { "suspended", "noattack", "notalking", "nointerrupt", "busy", "nopredict", "nomorph", "nodangle" },

        onenter = function(inst, attacker)
            ClearStatusAilments(inst)
            local mount = inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()
            ToggleOffPhysics(inst)
            inst.Transform:SetNoFaced()
            inst.AnimState:PlayAnimation("suspended_pre")
            inst.AnimState:PushAnimation("suspended")
            inst.components.inventory:Hide()
            inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end
            StopTalkSound(inst, true)
            if inst.components.talker then
                inst.components.talker:ShutUp()
                inst.components.talker:IgnoreAll("suspended")
            end
            if attacker and attacker:IsValid() then
                inst.sg.statemem.attacker = attacker
                if mount then
                    --use true physics radius if available
                    local radius = attacker.Physics and attacker.Physics:GetRadius() or attacker:GetPhysicsRadius(0)
                    if radius > 0 then
                        local dir = attacker:GetAngleToPoint(inst.Transform:GetWorldPosition()) * DEGREES
                        local x, y, z = attacker.Transform:GetWorldPosition()
                        x = x + radius * math.cos(dir)
                        z = z - radius * math.sin(dir)
                        if TheWorld.Map:IsPassableAtPoint(x, 0, z) then
                            if mount.Physics ~= nil then
                                mount.Physics:Teleport(x, 0, z)
                            else
                                mount.Transform:SetPosition(x, 0, z)
                            end
                        end
                    end
                end
                attacker:PushEvent("playersuspended", inst)
            end
        end,

        onupdate = function(inst)
            local attacker = inst.sg.statemem.attacker
            if attacker and attacker:IsValid() then
                inst.Transform:SetPosition(attacker.Transform:GetWorldPosition())
            else
                inst.sg:GoToState("idle")
            end
        end,

        events =
        {
            EventHandler("attacked", function(inst)
                inst.AnimState:PlayAnimation("suspended_hit")
                inst.AnimState:PushAnimation("suspended")
                DoHurtSound(inst)
                return true
            end),
            EventHandler("abouttospit", function(inst)
                inst.AnimState:PlayAnimation("suspended_spit")
                inst.AnimState:PushAnimation("suspended")
                DoHurtSound(inst)
            end),
            EventHandler("spitout", function(inst, data)
                local attacker = data ~= nil and data.spitter or inst.sg.statemem.attacker
                if attacker and attacker:IsValid() then
                    local rot = data.rot or attacker.Transform:GetRotation() + 180
                    inst.Transform:SetRotation(rot)
                    local x, y, z = inst.Transform:GetWorldPosition()
                    rot = rot * DEGREES
                    x = x + math.cos(rot) * 0.1
                    z = z - math.sin(rot) * 0.1
                    inst.Physics:Teleport(x, 0, z)
                    DoHurtSound(inst)
                    inst.sg:HandleEvent("knockback", {
                        knocker = attacker,
                        radius = data ~= nil and data.radius or physradius + 1,
                        strengthmult = data ~= nil and data.strengthmult or nil,
                    })
                else
                    inst.sg:HandleEvent("knockback")
                end
                --NOTE: ignores heavy armor/body
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            if inst.components.health:IsDead() then
                local attacker = inst.sg.statemem.attacker
                if attacker and attacker:IsValid() then
                    --use true physics radius if available
                    local radius = attacker.Physics and attacker.Physics:GetRadius() or attacker:GetPhysicsRadius(0)
                    if radius > 0 then
                        local x, y, z = inst.Transform:GetWorldPosition()
                        local theta = attacker.Transform:GetRotation() * DEGREES
                        x = x + math.cos(theta) * radius
                        z = z - math.sin(theta) * radius
                        if TheWorld.Map:IsPassableAtPoint(x, 0, z, true) then
                            inst.Physics:Teleport(x, 0, z)
                        end
                    end
                end
                attacker:PushEvent("suspendedplayerdied", inst)
            end
            inst.Transform:SetFourFaced()
            inst.components.inventory:Show()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(true)
                inst.components.playercontroller:Enable(true)
            end
            if inst.components.talker then
                inst.components.talker:StopIgnoringAll("suspended")
            end
        end,
    },

    State{
        name = "frozen",
        tags = { "busy", "frozen", "nopredict", "nodangle" },

        onenter = function(inst)
            if inst.components.pinnable ~= nil and inst.components.pinnable:IsStuck() then
                inst.components.pinnable:Unstick()
            end

            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")
            inst.AnimState:PlayAnimation("frozen")
            inst.SoundEmitter:PlaySound("dontstarve/common/freezecreature")

            inst.components.inventory:Hide()
            inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end

            --V2C: cuz... freezable component and SG need to match state,
            --     but messages to SG are queued, so it is not great when
            --     when freezable component tries to change state several
            --     times within one frame...
            if inst.components.freezable == nil then
                inst.sg:GoToState("hit", true)
            elseif inst.components.freezable:IsThawing() then
                inst.sg.statemem.isstillfrozen = true
                inst.sg:GoToState("thaw")
            elseif not inst.components.freezable:IsFrozen() then
                inst.sg:GoToState("hit", true)
            end
        end,

        events =
        {
            EventHandler("onthaw", function(inst)
                inst.sg.statemem.isstillfrozen = true
                inst.sg:GoToState("thaw")
            end),
            EventHandler("unfreeze", function(inst)
                inst.sg:GoToState("hit", true)
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.isstillfrozen then
                inst.components.inventory:Show()
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:EnableMapControls(true)
                    inst.components.playercontroller:Enable(true)
                end
            end
            inst.AnimState:ClearOverrideSymbol("swap_frozen")
        end,
    },

    State{
        name = "thaw",
        tags = { "busy", "thawing", "nopredict", "nodangle" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:OverrideSymbol("swap_frozen", "frozen", "frozen")
            inst.AnimState:PlayAnimation("frozen_loop_pst", true)
            inst.SoundEmitter:PlaySound("dontstarve/common/freezethaw", "thawing")

            inst.components.inventory:Hide()
            inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end
        end,

        events =
        {
            EventHandler("unfreeze", function(inst)
                inst.sg:GoToState("hit", true)
            end),
        },

        onexit = function(inst)
            inst.components.inventory:Show()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(true)
                inst.components.playercontroller:Enable(true)
            end
            inst.SoundEmitter:KillSound("thawing")
            inst.AnimState:ClearOverrideSymbol("swap_frozen")
        end,
    },

    State{
        name = "pinned_pre",
        tags = { "busy", "pinned", "nopredict" },

        onenter = function(inst)
            if inst.components.freezable ~= nil and inst.components.freezable:IsFrozen() then
                inst.components.freezable:Unfreeze()
            end

            if inst.components.pinnable == nil or not inst.components.pinnable:IsStuck() then
                inst.sg:GoToState("breakfree")
                return
            end

            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:OverrideSymbol("swap_goosplat", inst.components.pinnable.goo_build or "goo", "swap_goosplat")
            inst.AnimState:PlayAnimation("hit")

            --inst.components.inventory:Hide()
            --inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end
        end,

        events =
        {
            EventHandler("onunpin", function(inst, data)
                inst.sg:GoToState("breakfree")
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg.statemem.isstillpinned = true
                    inst.sg:GoToState("pinned")
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.isstillpinned then
                --inst.components.inventory:Show()
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:EnableMapControls(true)
                    inst.components.playercontroller:Enable(true)
                end
            end
            inst.AnimState:ClearOverrideSymbol("swap_goosplat")
        end,
    },

    State{
        name = "pinned",
        tags = { "busy", "pinned", "nopredict" },

        onenter = function(inst)
            if inst.components.pinnable == nil or not inst.components.pinnable:IsStuck() then
                inst.sg:GoToState("breakfree")
                return
            end

            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("distress_loop", true)
             -- TODO: struggle sound
            inst.SoundEmitter:PlaySound("dontstarve/creatures/spat/spit_playerstruggle", "struggling")

            --inst.components.inventory:Hide()
            --inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end
        end,

        events =
        {
            EventHandler("onunpin", function(inst, data)
                inst.sg:GoToState("breakfree")
            end),
        },

        onexit = function(inst)
            --inst.components.inventory:Show()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(true)
                inst.components.playercontroller:Enable(true)
            end
            inst.SoundEmitter:KillSound("struggling")
        end,
    },

    State{
        name = "pinned_hit",
        tags = { "busy", "pinned", "nopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("hit_goo")

            inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
            DoHurtSound(inst)

            --inst.components.inventory:Hide()
            --inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
            end
        end,

        events =
        {
            EventHandler("onunpin", function(inst, data)
                inst.sg:GoToState("breakfree")
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg.statemem.isstillpinned = true
                    inst.sg:GoToState("pinned")
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.isstillpinned then
                --inst.components.inventory:Show()
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:EnableMapControls(true)
                    inst.components.playercontroller:Enable(true)
                end
            end
        end,
    },

    State{
        name = "breakfree",
        tags = { "busy", "nopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("distress_pst")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/spat/spit_playerunstuck")

            --inst.components.inventory:Hide()
            --inst:PushEvent("ms_closepopups")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(false)
                inst.components.playercontroller:Enable(false)
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

        onexit = function(inst)
            --inst.components.inventory:Show()
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:EnableMapControls(true)
                inst.components.playercontroller:Enable(true)
            end
        end,
    },

    --------------------------
    -- Arboriculture States --
    --------------------------
    State{
        name = "chop_start",
        tags = {"prechop", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("chop_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("chop")
                end
            end),
        },
    },

    State{
        name = "chop",
        tags = {"prechop", "chopping", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.AnimState:PlayAnimation("chop_loop")
        end,

        timeline =
        {
            TimeEvent(2 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),

            TimeEvent(9 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("prechop")
            end),

            TimeEvent(16 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("chopping")
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
        name = "dig_start",
        tags = {"predig", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("shovel_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("dig")
                end
            end),
        },
    },

    State{
        name = "dig",
        tags = {"predig", "digging", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.AnimState:PlayAnimation("shovel_loop")
        end,

        timeline =
        {
            TimeEvent(15 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.SoundEmitter:PlaySound("dontstarve/wilson/dig")
            end),

            TimeEvent(35 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("predig")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("shovel_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    ----------------------------
    -- Mining Industry States --
    ----------------------------
    State{
        name = "mine_start",
        tags = {"premine", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("mine")
                end
            end),
        },
    },

    State{
        name = "mine",
        tags = {"premine", "mining", "working"},

        onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            inst.sg.statemem.target = buffaction ~= nil and buffaction.target or nil

            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                local buffaction = inst:GetBufferedAction()
                if buffaction ~= nil then
                    local target = buffaction.target
                    if target ~= nil and target:IsValid() then
                        if target.Transform ~= nil then
                            SpawnPrefab("mining_fx").Transform:SetPosition(target.Transform:GetWorldPosition())
                        end
                        inst.SoundEmitter:PlaySound(target:HasTag("frozen") and "dontstarve_DLC001/common/iceboulder_hit" or "dontstarve/wilson/use_pick_rock")
                    end
                    inst:PerformBufferedAction()
                end
            end),

            TimeEvent(14 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("premine")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    ------------------------
    -- Agriculture States --
    ------------------------
    State{
        name = "till_start",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            local equippedTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equippedTool ~= nil and equippedTool.components.tool ~= nil and equippedTool.components.tool:CanDoAction(ACTIONS.DIG) then
                --upside down tool build
                inst.AnimState:PlayAnimation("till2_pre")
            else
                inst.AnimState:PlayAnimation("till_pre")
            end
        end,

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("till")
                end
            end),
        },
    },

    State{
        name = "till",
        tags = { "doing", "busy" },

        onenter = function(inst)
            local equippedTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equippedTool ~= nil and equippedTool.components.tool ~= nil and equippedTool.components.tool:CanDoAction(ACTIONS.DIG) then
                --upside down tool build
                inst.sg.statemem.fliptool = true
                inst.AnimState:PlayAnimation("till2_loop")
            else
                inst.AnimState:PlayAnimation("till_loop")
            end
        end,

        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/wilson/dig") end),
            TimeEvent(11 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
            TimeEvent(12 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/mole/emerge") end),
            TimeEvent(22 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation(inst.sg.statemem.fliptool and "till2_pst" or "till_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    State{
        name = "pour",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()

            inst.AnimState:PlayAnimation("water_pre")
            inst.AnimState:PushAnimation("water", false)

            inst.AnimState:Show("water")

            inst.sg.statemem.action = inst:GetBufferedAction()

            if inst.sg.statemem.action ~= nil then
                local pt = inst.sg.statemem.action:GetActionPoint()
                if pt ~= nil then
                    local tx, ty, tz = TheWorld.Map:GetTileCenterPoint(pt.x, 0, pt.z)
                    inst.Transform:SetRotation(inst:GetAngleToPoint(tx, ty, tz))
                end

                local invobject = inst.sg.statemem.action.invobject
                if invobject.components.finiteuses ~= nil and invobject.components.finiteuses:GetUses() <= 0 then
                    inst.AnimState:Hide("water")
                    inst.sg.statemem.nosound = true
                end
            end

            inst.sg:SetTimeout(26 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(5 * FRAMES, function(inst)
                if not inst.sg.statemem.nosound then
                    inst.SoundEmitter:PlaySound("farming/common/watering_can/use")
                end
            end),
            TimeEvent(24 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    State{
        name = "fertilize",
        tags = { "doing", "busy", "nomorph", "self_fertilizing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("fertilize_pre")
            inst.AnimState:PushAnimation("fertilize", false)
        end,

        timeline =
        {
            TimeEvent(27 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wormwood/fertalize_LP", "rub")
                inst.SoundEmitter:SetParameter("rub", "start", math.random())
            end),
            TimeEvent(82 * FRAMES, function(inst)
                inst.SoundEmitter:KillSound("rub")
            end),
            TimeEvent(88 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
            TimeEvent(90 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
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
            inst.SoundEmitter:KillSound("rub")
        end,
    },

    State{
        name = "fertilize_short",
        tags = { "doing", "busy", "nomorph", "self_fertilizing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("short_fertilize_pre")
            inst.AnimState:PushAnimation("short_fertilize", false)
        end,

        timeline =
        {
            TimeEvent(15 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wormwood/fertalize_LP", "rub")
                inst.SoundEmitter:SetParameter("rub", "start", math.random())
            end),
            TimeEvent(18 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
            TimeEvent(31 * FRAMES, function(inst)
                inst.SoundEmitter:KillSound("rub")
            end),
            TimeEvent(33 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
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
            inst.SoundEmitter:KillSound("rub")
        end,
    },

    State{
        name = "hammer_start",
        tags = { "prehammer", "working" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("hammer")
                end
            end),
        },
    },

    State{
        name = "hammer",
        tags = { "prehammer", "hammering", "working" },

        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("prehammer")
                inst.SoundEmitter:PlaySound("dontstarve/creatures/knight/hurt")
            end),

            TimeEvent(9 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("prehammer")
            end),

            TimeEvent(14 * FRAMES, function(inst)
                if inst.components.playercontroller ~= nil and
                    inst.components.playercontroller:IsAnyOfControlsPressed(
                        CONTROL_SECONDARY,
                        CONTROL_ACTION,
                        CONTROL_CONTROLLER_ALTACTION) and
                    inst.sg.statemem.action ~= nil and
                    inst.sg.statemem.action:IsValid() and
                    inst.sg.statemem.action.target ~= nil and
                    inst.sg.statemem.action.target.components.workable ~= nil and
                    inst.sg.statemem.action.target.components.workable:CanBeWorked() and
                    inst.sg.statemem.action.target:IsActionValid(inst.sg.statemem.action.action, true) and
                    CanEntitySeeTarget(inst, inst.sg.statemem.action.target) then
                    inst:ClearBufferedAction()
                    inst:PushBufferedAction(inst.sg.statemem.action)
                end
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
    },

    State{
        name = "enter_onemanband",
        tags = { "playing", "idle" },

        onenter = function(inst, pushanim)
            --inst.components.locomotor:Stop()
            inst.Physics:Stop()

            if pushanim then
                inst.AnimState:PushAnimation("idle_onemanband1_pre", false)
            else
                inst.AnimState:PlayAnimation("idle_onemanband1_pre")
            end

            if inst.AnimState:IsCurrentAnimation("idle_onemanband1_pre") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
                inst.sg.statemem.soundplayed = true
            end
        end,

        onupdate = function(inst)
            if not inst.sg.statemem.soundplayed and inst.AnimState:IsCurrentAnimation("idle_onemanband1_pre") then
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
                inst.sg.statemem.soundplayed = true
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() and inst.AnimState:IsCurrentAnimation("idle_onemanband1_pre") then
                    inst.sg:GoToState("play_onemanband")
                end
            end),
        },
    },

    State{
        name = "play_onemanband",
        tags = { "playing", "idle" },

        onenter = function(inst)
            --inst.components.locomotor:Stop()
            inst.Physics:Stop()
            --inst.AnimState:PlayAnimation("idle_onemanband1_pre")
            inst.AnimState:PlayAnimation("idle_onemanband1_loop")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState(math.random() <= 0.15 and "play_onemanband_stomp" or "play_onemanband")
                end
            end),
        },
    },

    State{
        name = "play_onemanband_stomp",
        tags = { "playing", "idle" },

        onenter = function(inst)
            --inst.components.locomotor:Stop()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_onemanband1_pst")
            inst.AnimState:PushAnimation("idle_onemanband2_pre")
            inst.AnimState:PushAnimation("idle_onemanband2_loop")
            inst.AnimState:PushAnimation("idle_onemanband2_pst", false)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
        end,

        timeline =
        {
            TimeEvent(20*FRAMES, function( inst )
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
            end),
            TimeEvent(25*FRAMES, function( inst )
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
            end),
            TimeEvent(30*FRAMES, function( inst )
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
            end),
            TimeEvent(35*FRAMES, function( inst )
                inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
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
    },

    State{
        name = "scythe",
        tags = { "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("scythe_pre")
            inst.AnimState:PushAnimation("scythe_loop", false)
        end,

        timeline =
        {
            FrameEvent(14, function(inst) inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh") end),
            FrameEvent(15, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
                inst:PerformBufferedAction()
            end),
            FrameEvent(18, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            FrameEvent(25, function(inst)
                inst.sg:GoToState("idle", true)
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    -----------------------
    -- Apiculture States --
    -----------------------

    State{
        name = "bugnet_start",
        tags = { "prenet", "working", "autopredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("bugnet_pre")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("bugnet")
                end
            end),
        },
    },

    State{
        name = "bugnet",
        tags = { "prenet", "netting", "working", "autopredict" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bugnet")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/use_bugnet", nil, nil, true)
        end,

        timeline =
        {
            TimeEvent(10*FRAMES, function(inst)
                local buffaction = inst:GetBufferedAction()
                local tool = buffaction ~= nil and buffaction.invobject or nil
                inst:PerformBufferedAction()
                inst.sg:RemoveStateTag("prenet")
                inst.SoundEmitter:PlaySound(tool ~= nil and tool.overridebugnetsound or "dontstarve/wilson/dig")
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

    ------------------------
    -- Aquaculture States --
    ------------------------
    State{
        name = "fishing_pre",
        tags = { "prefish", "fishing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("fishing_pre")
            inst.AnimState:PushAnimation("fishing_cast", false)
        end,

        timeline =
        {
            TimeEvent(13*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_cast") end),
            TimeEvent(15*FRAMES, function(inst) inst:PerformBufferedAction() end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_baitsplash")
                    inst.sg:GoToState("fishing")
                end
            end),
        },
    },

    State{
        name = "fishing",
        tags = { "fishing" },

        onenter = function(inst, pushanim)
            if pushanim then
                if type(pushanim) == "string" then
                    inst.AnimState:PlayAnimation(pushanim)
                end
                inst.AnimState:PushAnimation("fishing_idle", true)
            else
                inst.AnimState:PlayAnimation("fishing_idle", true)
            end
            local equippedTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equippedTool and equippedTool.components.fishingrod then
                equippedTool.components.fishingrod:WaitForFish()
            end
        end,

        events =
        {
            EventHandler("fishingnibble", function(inst) inst.sg:GoToState("fishing_nibble") end),
        },
    },

    State{
        name = "fishing_pst",
        tags = { "fishing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("fishing_pst")
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
        name = "fishing_nibble",
        tags = { "fishing", "nibble" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bite_light_pre")
            inst.AnimState:PushAnimation("bite_light_loop", true)
            inst.sg:SetTimeout(1 + math.random())
            inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishinwater", "splash")
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("fishing", "bite_light_pst")
        end,

        events =
        {
            EventHandler("fishingstrain", function(inst) inst.sg:GoToState("fishing_strain") end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("splash")
        end,
    },

    State{
        name = "fishing_strain",
        tags = { "fishing" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bite_heavy_pre")
            inst.AnimState:PushAnimation("bite_heavy_loop", true)
            inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishinwater", "splash")
            inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_strain", "strain")
        end,

        events =
        {
            EventHandler("fishingcatch", function(inst, data)
                inst.sg:GoToState("catchfish", data.build)
            end),
            EventHandler("fishingloserod", function(inst)
                inst.sg:GoToState("loserod")
            end),

        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("splash")
            inst.SoundEmitter:KillSound("strain")
        end,
    },

    State{
        name = "catchfish",
        tags = { "fishing", "catchfish", "busy" },

        onenter = function(inst, build)
            inst.AnimState:PlayAnimation("fish_catch")
            --print("Using ", build, " to swap out fish01")
            inst.AnimState:OverrideSymbol("fish01", build, "fish01")

            -- inst.AnimState:OverrideSymbol("fish_body", build, "fish_body")
            -- inst.AnimState:OverrideSymbol("fish_eye", build, "fish_eye")
            -- inst.AnimState:OverrideSymbol("fish_fin", build, "fish_fin")
            -- inst.AnimState:OverrideSymbol("fish_head", build, "fish_head")
            -- inst.AnimState:OverrideSymbol("fish_mouth", build, "fish_mouth")
            -- inst.AnimState:OverrideSymbol("fish_tail", build, "fish_tail")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishcaught") end),
            TimeEvent(10*FRAMES, function(inst) inst.sg:RemoveStateTag("fishing") end),
            TimeEvent(23*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishland") end),
            TimeEvent(24*FRAMES, function(inst)
                local equippedTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if equippedTool and equippedTool.components.fishingrod then
                    equippedTool.components.fishingrod:Collect()
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

        onexit = function(inst)
            inst.AnimState:ClearOverrideSymbol("fish01")
            -- inst.AnimState:ClearOverrideSymbol("fish_body")
            -- inst.AnimState:ClearOverrideSymbol("fish_eye")
            -- inst.AnimState:ClearOverrideSymbol("fish_fin")
            -- inst.AnimState:ClearOverrideSymbol("fish_head")
            -- inst.AnimState:ClearOverrideSymbol("fish_mouth")
            -- inst.AnimState:ClearOverrideSymbol("fish_tail")
        end,
    },

    State{
        name = "loserod",
        tags = { "busy", "nopredict" },

        onenter = function(inst)
            local equippedTool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equippedTool and equippedTool.components.fishingrod then
                equippedTool.components.fishingrod:Release()
                equippedTool:Remove()
            end
            inst.AnimState:PlayAnimation("fish_nocatch")
        end,

        timeline =
        {
            TimeEvent(4*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_lostrod") end),
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
        name = "sink",
        tags = { "busy", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst, shore_pt)
            inst:ClearBufferedAction()

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()

            inst.AnimState:PlayAnimation("sink")
            inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/sinking")
            if inst.components.rider:IsRiding() then
                inst.sg:AddStateTag("dismounting")
            end

            if shore_pt ~= nil then
                inst.components.drownable:OnFallInOcean(shore_pt:Get())
            else
                inst.components.drownable:OnFallInOcean()
            end
            inst.DynamicShadow:Enable(false)
        end,

        timeline =
        {
            TimeEvent(75 * FRAMES, function(inst)
                inst.components.drownable:DropInventory()
                inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/medium")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    StartTeleporting(inst)

                    if inst.sg:HasStateTag("dismounting") then
                        inst.sg:RemoveStateTag("dismounting")

                        local mount = inst.components.rider:GetMount()
                        inst.components.rider:ActualDismount()
                        if mount ~= nil then
                            if mount.components.drownable ~= nil then
                                mount:Hide()
                                mount:PushEvent("onsink", {noanim = true, shore_pt = Vector3(inst.components.drownable.dest_x, inst.components.drownable.dest_y, inst.components.drownable.dest_z)})
                            elseif mount.components.health ~= nil then
                                mount:Hide()
                                mount.components.health:Kill()
                            end
                        end
                    end

                    inst.components.drownable:WashAshore() -- TODO: try moving this into the timeline
                end
            end),

            EventHandler("on_washed_ashore", function(inst)
                inst.sg:GoToState("washed_ashore")
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end

            inst.DynamicShadow:Enable(true)
        end,
    },

    State{
        name = "sink_fast",
        tags = { "busy", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst, data)
            inst:ClearBufferedAction()

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()

            inst.AnimState:PlayAnimation("sink")
            inst.AnimState:SetFrame(60)
            inst.AnimState:Hide("plank")
            inst.AnimState:Hide("float_front")
            inst.AnimState:Hide("float_back")

            if inst.components.rider:IsRiding() then
                inst.sg:AddStateTag("dismounting")
            end

            inst.components.drownable:OnFallInOcean()
            inst.DynamicShadow:Enable(false)
        end,

        timeline =
        {
            TimeEvent(14 * FRAMES, function(inst)
                inst.AnimState:Show("float_front")
                inst.AnimState:Show("float_back")
            end),

            TimeEvent(16 * FRAMES, function(inst)
                inst.components.drownable:DropInventory()
            end),
        },


        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    StartTeleporting(inst)

                    if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
                        local mount = inst.components.rider:GetMount()
                        inst.components.rider:ActualDismount()
                        if mount ~= nil then
                            if mount.components.drownable ~= nil then
                                mount:PushEvent("onsink", {noanim = true, shore_pt = Vector3(inst.components.drownable.dest_x, inst.components.drownable.dest_y, inst.components.drownable.dest_z)})
                            elseif mount.components.health ~= nil then
                                mount:Hide()
                                mount.components.health:Kill()
                            end
                        end
                    end

                    inst.components.drownable:WashAshore() -- TODO: try moving this into the timeline
                end
            end),

            EventHandler("on_washed_ashore", function(inst)
                inst.sg:GoToState("washed_ashore")
            end),
        },

        onexit = function(inst)
            inst.AnimState:Show("plank")
            inst.AnimState:Show("float_front")
            inst.AnimState:Show("float_back")
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end

            inst.DynamicShadow:Enable(true)
        end,
    },

    State{
        name = "washed_ashore",
        tags = { "busy", "canrotate", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst)
            inst.SoundEmitter:PlaySound("turnoftides/common/together/water/splash/medium")
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("wakeup")
            if inst.components.drownable ~= nil then
                inst.components.drownable:TakeDrowningDamage()
            end

            local puddle = SpawnPrefab("washashore_puddle_fx")
            puddle.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.components.talker:Say(GetString(inst, "ANNOUNCE_WASHED_ASHORE"))

                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "abyss_fall",
        tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt", "nodangle", "falling" },
        onenter = function(inst, teleport_pt)
            inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("abyss_fall")
            if inst.components.drownable then
                local teleport_x, teleport_y, teleport_z
                if teleport_pt then
                    teleport_x, teleport_y, teleport_z = teleport_pt:Get()
                end
                inst.components.drownable:OnFallInVoid(teleport_x, teleport_y, teleport_z)
            end
            inst.DynamicShadow:Enable(false)
            ToggleOffPhysics(inst)
            if inst.components.playercontroller then
                inst.components.playercontroller:Enable(false)
            end
            inst.components.health:SetInvincible(true)
        end,

        timeline =
        {
            FrameEvent(22, function(inst)
                inst.AnimState:SetLayer(LAYER_BELOW_GROUND)
            end),
            FrameEvent(30, function(inst)
                inst.sg:AddStateTag("invisible")
                inst:Hide()
            end),
            TimeEvent(2.5, function(inst)
                inst.sg.statemem.falling = true
                if inst.components.drownable ~= nil then
                    inst.components.drownable:Teleport()
                else
                    inst:PutBackOnGround()
                end
                inst.sg:GoToState("abyss_drop")
            end),
        },

        onexit = function(inst)
            inst.AnimState:SetLayer(LAYER_WORLD)
            inst.DynamicShadow:Enable(true)
            inst:Show()
            if not inst.sg.statemem.falling then
                ToggleOnPhysics(inst)
                inst.components.health:SetInvincible(false)
            end
            if inst.components.playercontroller then
                inst.components.playercontroller:Enable(true)
            end
        end,
    },

    State{
        name = "abyss_drop",
        tags = { "busy", "nopredict", "nomorph", "noattack", "nointerrupt", "nodangle", "overridelocomote", "falling" },

        onenter = function(inst)
            inst.components.rider:ActualDismount()
            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("fall_high")

            ToggleOffPhysics(inst)
            inst.components.health:SetInvincible(true)

            inst.sg:SetTimeout(2)
        end,

        timeline =
        {
            FrameEvent(12, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),
            FrameEvent(14, function(inst)
                inst.sg:RemoveStateTag("noattack")
                inst.sg:RemoveStateTag("nointerrupt")
                ToggleOnPhysics(inst)
                inst.components.health:SetInvincible(false)
            end),
            FrameEvent(15, function(inst)
                inst.sg.statemem.trackcontrol = true
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("abyss_drop_pst")
        end,

        events =
        {
            EventHandler("locomote", function(inst, data)
                if data and data.remoteoverridelocomote or inst.components.locomotor:WantsToMoveForward() then
                    if inst.AnimState:AnimDone() then
                        inst.sg:GoToState("abyss_drop_pst")
                    elseif inst.sg.statemem.trackcontrol then
                        inst.sg.statemem.getup = true
                    end
                end
                return true
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg.statemem.getup then
                        inst.sg:GoToState("abyss_drop_pst")
                    end
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            inst.components.health:SetInvincible(false)
        end,
    },

    State{
        name = "abyss_drop_pst",
        tags = { "busy", "nomorph", "nodangle", "falling" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("buck_pst")
        end,

        timeline =
        {
            TimeEvent(27 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nomorph")
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

    ------------------------
    -- Mariculture States --
    ------------------------
    State{
        name = "oceanfishing_cast",
        tags = { "prefish", "fishing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("fishing_ocean_pre")
            inst.AnimState:PushAnimation("fishing_ocean_cast", false)
            inst.AnimState:PushAnimation("fishing_ocean_cast_loop", true)
        end,

        timeline =
        {
            TimeEvent(13*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_cast")
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_cast_ocean")
                inst.sg:RemoveStateTag("prefish")
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("newfishingtarget", function(inst, data)
                if data ~= nil and data.target ~= nil and not data.target:HasTag("projectile") then
                    inst.sg.statemem.hooklanded = true
                    inst.AnimState:PushAnimation("fishing_ocean_cast_pst", false)
                end
            end),

            EventHandler("animqueueover", function(inst)
                if inst.sg.statemem.hooklanded and inst.AnimState:AnimDone() then
                    inst.sg:GoToState("oceanfishing_idle")
                end
            end),
        },
    },

    State{
        name = "oceanfishing_idle",
        tags = { "fishing", "canrotate" },

        onenter = function(inst)
            inst:AddTag("fishing_idle")
            local rod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local target = (rod ~= nil and rod.components.oceanfishingrod ~= nil) and rod.components.oceanfishingrod.target or nil
            if target ~= nil and target.components.oceanfishinghook ~= nil and TUNING.OCEAN_FISHING.IDLE_QUOTE_TIME_MIN > 0 then
                inst.sg:SetTimeout(TUNING.OCEAN_FISHING.IDLE_QUOTE_TIME_MIN + math.random() * TUNING.OCEAN_FISHING.IDLE_QUOTE_TIME_VAR)
            end
        end,

        onupdate = function(inst)
            local rod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            rod = (rod ~= nil and rod.components.oceanfishingrod ~= nil) and rod or nil
            local target = rod ~= nil and rod.components.oceanfishingrod.target or nil
            if target ~= nil then
                if target.components.oceanfishinghook ~= nil then
                    inst.SoundEmitter:KillSound("unreel_loop")
                    if not inst.AnimState:IsCurrentAnimation("hooked_loose_idle") then
                        inst.AnimState:PlayAnimation("hooked_loose_idle", true)
                    end
                else
                    if rod.components.oceanfishingrod:IsLineTensionLow() then
                        inst.SoundEmitter:KillSound("unreel_loop")
                        if not inst.AnimState:IsCurrentAnimation("hooked_loose_idle") then
                            inst.AnimState:PlayAnimation("hooked_loose_idle", true)
                        end
                    elseif rod.components.oceanfishingrod:IsLineTensionGood() then
                        if target.components.oceanfishable ~= nil and target.components.oceanfishable:IsStruggling() then
                            if not inst.SoundEmitter:PlayingSound("unreel_loop") then
                                inst.SoundEmitter:PlaySound("dontstarve/common/fishpole_strain", "unreel_loop")
                            end
                            inst.SoundEmitter:SetParameter("unreel_loop", "tension", 0.0)
                        else
                            inst.SoundEmitter:KillSound("unreel_loop")
                        end
                        if not inst.AnimState:IsCurrentAnimation("hooked_good_idle") then
                            inst.AnimState:PlayAnimation("hooked_good_idle", true)
                        end
                    else
                        if not inst.SoundEmitter:PlayingSound("unreel_loop") then
                            inst.SoundEmitter:PlaySound("dontstarve/common/fishpole_strain", "unreel_loop")
                        end
                        inst.SoundEmitter:SetParameter("unreel_loop", "tension", 1.0)
                        if not inst.AnimState:IsCurrentAnimation("hooked_tight_idle") then
                            inst.AnimState:PlayAnimation("hooked_tight_idle", true)
                        end
                    end
                end
            end
        end,

        ontimeout = function(inst)
            if inst.components.talker ~= nil then
                inst.components.talker:Say(GetString(inst, "ANNOUNCE_OCEANFISHING_IDLE_QUOTE"), nil, nil, true)

                inst.sg:SetTimeout(inst.sg.timeinstate + TUNING.OCEAN_FISHING.IDLE_QUOTE_TIME_MIN + math.random() * TUNING.OCEAN_FISHING.IDLE_QUOTE_TIME_VAR)
            end
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("unreel_loop")
            inst:RemoveTag("fishing_idle")
        end,
    },

    State{
        name = "oceanfishing_reel",
        tags = { "fishing", "doing", "reeling", "canrotate" },

        onenter = function(inst)
            inst:AddTag("fishing_idle")
            inst.components.locomotor:Stop()

            local rod = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            rod = (rod ~= nil and rod.components.oceanfishingrod ~= nil) and rod or nil
            local target = rod ~= nil and rod.components.oceanfishingrod.target or nil
            if target == nil then
                inst:ClearBufferedAction()
            else
                if inst:PerformBufferedAction() then
                    if target.components.oceanfishinghook ~= nil or rod.components.oceanfishingrod:IsLineTensionLow() then
                        inst.SoundEmitter:KillSound("reel_loop")
                        inst.SoundEmitter:PlaySound("dontstarve/common/fishpole_reel_in1_LP", "reel_loop")
                        if not inst.AnimState:IsCurrentAnimation("hooked_loose_reeling") then
                            inst.AnimState:PlayAnimation("hooked_loose_reeling", true)
                        end
                    elseif rod.components.oceanfishingrod:IsLineTensionGood() then
                        inst.SoundEmitter:KillSound("reel_loop")
                        inst.SoundEmitter:PlaySound("dontstarve/common/fishpole_reel_in2_LP", "reel_loop")
                        if not inst.AnimState:IsCurrentAnimation("hooked_good_reeling") then
                            inst.AnimState:PlayAnimation("hooked_good_reeling", true)
                        end
                    else
                        inst.SoundEmitter:KillSound("reel_loop")
                        inst.SoundEmitter:PlaySound("dontstarve/common/fishpole_reel_in3_LP", "reel_loop")
                        if not inst.AnimState:IsCurrentAnimation("hooked_tight_reeling") then
                            inst.AnimState:PlayAnimation("hooked_tight_reeling", true)
                        end
                    end

                    inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
                end

            end
        end,

        timeline =
        {
            TimeEvent(TUNING.OCEAN_FISHING.REEL_ACTION_REPEAT_DELAY, function(inst) inst.sg.statemem.allow_repeat = true end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("oceanfishing_idle")
        end,

        onexit = function(inst)
            inst.SoundEmitter:KillSound("reel_loop")
            inst:RemoveTag("fishing_idle")
        end,
    },

    State{
        name = "oceanfishing_sethook",
        tags = { "fishing", "doing", "busy" },

        onenter = function(inst)
            inst:AddTag("fishing_idle")
            inst.components.locomotor:Stop()

            --inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishcaught_ocean")
            inst.AnimState:PlayAnimation("fishing_ocean_bite_heavy_pre")
            inst.AnimState:PushAnimation("fishing_ocean_bite_heavy_loop", false)

            inst:PerformBufferedAction()
        end,

        timeline =
        {
            --TimeEvent(2*FRAMES, function(inst) inst:PerformBufferedAction() end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst) inst.sg:GoToState("oceanfishing_idle") end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("sethook_loop")
            inst:RemoveTag("fishing_idle")
        end,
    },

    State{
        name = "oceanfishing_catch",
        tags = { "fishing", "catchfish", "busy" },

        onenter = function(inst, build)
            inst.AnimState:PlayAnimation("fishing_ocean_catch")
        end,

        timeline =
        {
            --TimeEvent(23*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_fishland") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.AnimState:ClearOverrideSymbol("fish01")
        end,
    },

    State{
        name = "oceanfishing_stop",
        tags = { "fishing" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("fishing_ocean_pst")

            if data ~= nil and data.escaped_str and inst.components.talker ~= nil then
                inst.components.talker:Say(GetString(inst, data.escaped_str), nil, nil, true)
            end
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "oceanfishing_linesnapped",
        tags = { "busy", "nomorph" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("line_snap")
            inst.sg.statemem.escaped_str = data ~= nil and data.escaped_str or nil
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/fishingpole_linebreak")
            end),
            TimeEvent(29*FRAMES, function(inst)
                if inst.components.talker ~= nil then
                    inst.components.talker:Say(GetString(inst, inst.sg.statemem.escaped_str or "ANNOUNCE_OCEANFISHING_LINESNAP"), nil, nil, true)
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
    },

    -----------------------
    -- Navigation States --
    -----------------------
    State{
        name = "jumpin_pre",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation(inst.components.inventory:IsHeavyLifting() and "heavy_jump_pre" or "jump_pre", false)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.bufferedaction ~= nil then
                        inst:PerformBufferedAction()
                    else
                        inst.sg:GoToState("idle")
                    end
                end
            end),
        },
    },

    State{
        name = "jumpin",
        tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

        onenter = function(inst, data)
            ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()

            inst.sg.statemem.target = data.teleporter
            local target = inst.sg.statemem.target
            if target and target.prefab == "wormhole" and
                target.sg and not target.sg:HasStateTag("open") then
                target.sg:GoToState("opening")
            end
            local targetTeleporter = inst.sg.statemem.target.components.teleporter.targetTeleporter
            if targetTeleporter and targetTeleporter.prefab == "wormhole" and
                targetTeleporter.sg and not targetTeleporter.sg:HasStateTag("open") then
                targetTeleporter.sg:GoToState("opening")
            end
            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            if data.teleporter ~= nil and data.teleporter.components.teleporter ~= nil then
                data.teleporter.components.teleporter:RegisterTeleportee(inst)
            end

            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jump" or "jump")

            local pos = data ~= nil and data.teleporter and data.teleporter:GetPosition() or nil

            local MAX_JUMPIN_DIST = 3
            local MAX_JUMPIN_DIST_SQ = MAX_JUMPIN_DIST * MAX_JUMPIN_DIST
            local MAX_JUMPIN_SPEED = 6

            local dist
            if pos ~= nil then
                inst:ForceFacePoint(pos:Get())
                local distsq = inst:GetDistanceSqToPoint(pos:Get())
                if distsq <= .25 * .25 then
                    dist = 0
                    inst.sg.statemem.speed = 0
                elseif distsq >= MAX_JUMPIN_DIST_SQ then
                    dist = MAX_JUMPIN_DIST
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED
                else
                    dist = math.sqrt(distsq)
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED * dist / MAX_JUMPIN_DIST
                end
            else
                inst.sg.statemem.speed = 0
                dist = 0
            end

            inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)

            inst.sg.statemem.teleportarrivestate = "jumpout"
        end,

        timeline =
        {
            TimeEvent(.5 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.speed * (inst.sg.statemem.heavy and .55 or .75), 0, 0)
            end),
            TimeEvent(1 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.heavy and inst.sg.statemem.speed * .6 or inst.sg.statemem.speed, 0, 0)
            end),

            -- NORMAL WHOOSH SOUND GOES HERE
            TimeEvent(1 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    --print ("START NORMAL JUMPING SOUND")
                    inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
                end
            end),

            -- HEAVY WHOOSH SOUND GOES HERE
            TimeEvent(5 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    --print ("START HEAVY JUMPING SOUND")
                    inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
                end
            end),

            --Heavy lifting
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .4, 0, 0)
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .3, 0, 0)
                end
            end),

            --Normal
            TimeEvent(15 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:Stop()
                end

                -- this is just hacked in here to make the sound play BEFORE the player hits the wormhole
                if inst.sg.statemem.target ~= nil then
                    if inst.sg.statemem.target:IsValid() then
                        --inst.sg.statemem.target:PushEvent("starttravelsound", inst)
                    else
                        inst.sg.statemem.target = nil
                    end
                end
            end),

            --Heavy lifting
            TimeEvent(20 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:Stop()
                end
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg.statemem.target ~= nil and
                        inst.sg.statemem.target:IsValid() and
                        inst.sg.statemem.target.components.teleporter ~= nil then
                        --Unregister first before actually teleporting
                        inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
                        if inst.sg.statemem.target.components.teleporter:Activate(inst) then
                            inst.sg.statemem.isteleporting = true
                            inst.components.health:SetInvincible(true)
                            if inst.components.playercontroller ~= nil then
                                inst.components.playercontroller:Enable(false)
                            end
                            inst:Hide()
                            inst.DynamicShadow:Enable(false)
                        end
                    end
                    if inst.sg.statemem.target ~= nil and
                        inst.sg.statemem.target:IsValid() and
                        inst.sg.statemem.target.components.teleporter ~= nil then
                        if inst.sg.statemem.target.prefab == "wormhole" or
                            inst.sg.statemem.target.prefab == "tentacle_pillar_hole" then
                            inst.sg:GoToState("jumpout")
                        elseif inst.sg.statemem.target.prefab == "pocketwatch_portal_entrance" then
                            inst.sg:GoToState("pocketwatch_portal_land")
                        else
                            inst.sg:GoToState("idle")
                        end
                    end
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
            inst.Physics:Stop()

            if inst.sg.statemem.isteleporting then
                inst.components.health:SetInvincible(false)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
                inst:Show()
                inst.DynamicShadow:Enable(true)
            elseif inst.sg.statemem.target ~= nil
                and inst.sg.statemem.target:IsValid()
                and inst.sg.statemem.target.components.teleporter ~= nil then
                inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
            end

            local target = inst.sg.statemem.target
            if target and target.sg then
                target:DoTaskInTime(1, function(inst)
                    if inst and inst.prefab == "wormhole" and inst.sg and inst.sg:HasStateTag("open") and
                        --inst.components.teleporter ~= nil and not inst.components.teleporter:IsBusy() and
                        inst.components.playerprox ~= nil and not inst.components.playerprox:IsPlayerClose() then
                        inst.sg:GoToState("closing")
                    end
                end)
            end
            local targetTeleporter = inst.sg.statemem.target.components.teleporter.targetTeleporter
            if targetTeleporter and targetTeleporter.sg then
                targetTeleporter:DoTaskInTime(1, function(inst)
                    if inst and inst.prefab == "wormhole" and inst.sg and inst.sg:HasStateTag("open") and
                        --inst.components.teleporter ~= nil and not inst.components.teleporter:IsBusy() and
                        inst.components.playerprox ~= nil and not inst.components.playerprox:IsPlayerClose() then
                        inst.sg:GoToState("closing")
                    end
                end)
            end
        end,
    },

    State{
        name = "jumpout",
        tags = { "busy", "canrotate", "jumping" },

        onenter = function(inst)
            ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()

            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jumpout" or "jumpout")

            inst.Physics:SetMotorVel(4, 0, 0)
        end,

        timeline =
        {
            --Heavy lifting
            TimeEvent(4 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),
            TimeEvent(12.2 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    if inst.sg.statemem.isphysicstoggle then
                        ToggleOnPhysics(inst)
                    end
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),
            TimeEvent(16 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(1, 0, 0)
                end
            end),

            --Normal
            TimeEvent(10 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(15 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),
            TimeEvent(15.2 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    if inst.sg.statemem.isphysicstoggle then
                        ToggleOnPhysics(inst)
                    end
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),

            TimeEvent(17 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.heavy and .5 or 1, 0, 0)
            end),
            TimeEvent(18 * FRAMES, function(inst)
                inst.Physics:Stop()
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

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end
        end,
    },

    State{
        name = "pocketwatch_portal_land",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "jumping", "noattack" },

        onenter = function(inst, data)
            if not inst:HasTag("pocketwatchcaster") then
                inst.sg:GoToState("pocketwatch_portal_fallout")
                return
            end
        
            inst.components.locomotor:Stop()
            StartTeleporting(inst)

            inst.AnimState:PlayAnimation("jumpportal_out")

            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
            fx.Transform:SetPosition(x, 4, z)
        end,

        timeline =
        {
            TimeEvent(16 * FRAMES, function(inst) 
                inst:Show() -- hidden by StartTeleporting
            end),

            TimeEvent(17 * FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
            end),

            TimeEvent(20 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
            end),

            TimeEvent(22 * FRAMES, function(inst)
                PlayFootstep(inst)
            end),

            TimeEvent(28 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("jumping")
                inst.sg:RemoveStateTag("busy")
                inst.sg:RemoveStateTag("nomorph")
                inst.sg:RemoveStateTag("noattack")

                DoneTeleporting(inst)
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
            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end
        end,
    },

    State{
        name = "pocketwatch_portal_fallout",
        tags = { "busy", "nopredict", "nomorph", "nodangle", "jumping", "noattack" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            StartTeleporting(inst)

            inst.AnimState:PlayAnimation("jumpportal2_out")
            inst.AnimState:PushAnimation("jumpportal2_out_pst", false)

            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab("pocketwatch_portal_exit_fx")
            fx.Transform:SetPosition(x, 4, z)
        end,

        timeline =
        {
            TimeEvent(16 * FRAMES, function(inst) 
                inst:Show() -- hidden by StartTeleporting
            end),

            TimeEvent(19 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("wanda1/wanda/jump_whoosh")
            end),

            TimeEvent(23 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
            end),

            TimeEvent(27 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),

            TimeEvent(59 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("jumping")
                inst.sg:RemoveStateTag("busy")
                DoneTeleporting(inst)
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
            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end
        end,
    },

    ------------------------
    -- Pastoralism States --
    ------------------------
    State{
        name = "mount",
        tags = { "doing", "busy", "nomorph", "nopredict", "mounting" },

        onenter = function(inst)
            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()
            inst.sg.statemem.ridingwoby = inst.components.rider.target_mount and inst.components.rider.target_mount:HasTag("woby")

            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_mount" or "mount")

            inst:PushEvent("ms_closepopups")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
        end,

        timeline =
        {
            --Heavy lifting
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
                if inst.sg.statemem.ridingwoby then
                    inst.SoundEmitter:PlaySound("dontstarve/characters/walter/woby/big/bark")
                elseif not inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/beefalo/grunt")
                end

            end),
            TimeEvent(35 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),

            --Normal
            TimeEvent(20 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("mounted_idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end,
    },

    State{
        name = "dismount",
        tags = { "doing", "busy", "pausepredict", "nomorph", "dismounting" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
            inst.AnimState:PlayAnimation("dismount")


            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline=
        {
            TimeEvent(15*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.rider:ActualDismount()
        end,
    },

    State{
        name = "mounted_idle",
        tags = { "idle", "canrotate" },

        onenter = function(inst, pushanim)
            local equippedArmor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if equippedArmor ~= nil and equippedArmor:HasTag("band") then
                inst.sg:GoToState("enter_onemanband", pushanim)
                return
            end

            if inst:IsInAnyStormOrCloud() and not inst.components.inventory:EquipHasTag("goggles") then
                if pushanim then
                    inst.AnimState:PushAnimation("sand_idle_pre")
                else
                    inst.AnimState:PlayAnimation("sand_idle_pre")
                end
                inst.AnimState:PushAnimation("sand_idle_loop", true)
                inst.sg.statemem.sandstorm = true
            else
                if pushanim then
                    inst.AnimState:PushAnimation("idle_loop", true)
                else
                    inst.AnimState:PlayAnimation("idle_loop", true)
                end
                inst.sg:SetTimeout(2 + math.random() * 8)
            end
        end,

        events =
        {
            EventHandler("sandstormlevel", function(inst, data)
                if data.level < TUNING.SANDSTORM_FULL_LEVEL then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("mounted_idle")
                    end
                elseif not (inst.sg.statemem.sandstorm or inst.components.inventory:EquipHasTag("goggles")) then
                    inst.sg:GoToState("mounted_idle")
                end
            end),
            EventHandler("miasmalevel", function(inst, data)
                if data.level < 1 then
                    if inst.sg.statemem.sandstorm then
                        inst.sg:GoToState("mounted_idle")
                    end
                elseif not (inst.sg.statemem.sandstorm or inst.components.inventory:EquipHasTag("goggles")) then
                    inst.sg:GoToState("mounted_idle")
                end
            end),
        },

        ontimeout = function(inst)
            local mount = inst.components.rider:GetMount()
            if mount == nil then
                inst.sg:GoToState("idle")
                return
            end

            if mount.components.hunger == nil then
                inst.sg:GoToState(math.random() < 0.5 and "shake" or "bellow")
            elseif mount:HasTag("woby") then
                local woby_idles = {"shake_woby", "alert_woby", "bark_woby"}
                inst.sg:GoToState(woby_idles[math.random(1, #woby_idles)])
            else
                local rand = math.random()
                inst.sg:GoToState(
                    (rand < .25 and "shake") or
                    (rand < .5 and "bellow") or
                    (mount.components.hunger:IsStarving() and "graze_empty" or "graze")
                )
            end
        end,
    },

    State{
        name = "graze",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("graze_loop", true)
            inst.sg:SetTimeout(1 + math.random() * 5)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("mounted_idle")
        end,
    },

    State{
        name = "graze_empty",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("graze2_pre")
            inst.AnimState:PushAnimation("graze2_loop")
            inst.sg:SetTimeout(1 + math.random() * 5)
        end,

        ontimeout = function(inst)
            inst.AnimState:PlayAnimation("graze2_pst")
            inst.sg:GoToState("mounted_idle", true)
        end,
    },

    State{
        name = "bellow",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bellow")
            DoMountSound(inst, inst.components.rider:GetMount(), "grunt")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("mounted_idle")
                end
            end),
        },
    },

    State{
        name = "shake",
        tags = { "idle", "canrotate" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("shake")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("mounted_idle")
                end
            end),
        },
    },

    State{
        name = "falloff",
        tags = { "busy", "pausepredict", "nomorph", "dismounting" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("fall_off")
            inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
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

        onexit = function(inst)
            inst.components.rider:ActualDismount()
        end,
    },

    State{
        name = "bucked",
        tags = { "busy", "pausepredict", "nomorph", "dismounting" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("buck")

            DoMountSound(inst, inst.components.rider:GetMount(), "yell")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline =
        {
            TimeEvent(14 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("bucked_post")
                end
            end),
        },

        onexit = function(inst)
            inst.components.rider:ActualDismount()
        end,
    },

    State{
        name = "bucked_post",
        tags = { "busy", "pausepredict", "nomorph", "nodangle", "dismounting" },

        onenter = function(inst)
            inst.AnimState:PlayAnimation("bucked")
            inst.AnimState:PushAnimation("buck_pst", false)

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
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
    },

    State{
        name = "unsaddle",
        tags = { "doing", "busy" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("unsaddle_pre")
            inst.AnimState:PushAnimation("unsaddle", false)

            inst.sg.statemem.action = inst.bufferedaction
            inst.sg:SetTimeout(21 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(15 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        ontimeout = function(inst)
            --pickup_pst should still be playing
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action and
            (inst.components.playercontroller == nil or inst.components.playercontroller.lastheldaction ~= inst.bufferedaction) then
                inst:ClearBufferedAction()
            end
        end,
    },

    ------------------------
    -- Shipwrecked States --
    ------------------------
    State{
        name = "rowl_start_ia",
        tags = { "moving", "running", "rowing", "boating", "canrotate", "autopredict" },

        onenter = function(inst)
            local boat = inst.components.sailor:GetBoat()

            inst.components.locomotor:RunForward()

            if not inst:HasTag("mime") then
                inst.AnimState:OverrideSymbol("paddle", "swap_paddle", "paddle")
            end
            --TODO allow custom paddles?
            inst.AnimState:OverrideSymbol("wake_paddle", "swap_paddle", "wake_paddle")

            --RoT has row_pre, which is identical but uses the equipped item as paddle
            inst.AnimState:PlayAnimation("row_ia_pre")
            if boat then
                boat.replica.sailable:PlayPreRowAnims()
            end

            DoFoleySounds(inst)

            local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped then
                equipped:PushEvent("startrowing", {owner = inst})
            end
            inst:PushEvent("startrowing")
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        onexit = OnExitRow,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("row_ia")
                end
            end),
        },
    },

    State{
        name = "row_ia",
        tags = { "moving", "running", "rowing", "boating", "canrotate", "autopredict" },

        onenter = function(inst)
            local boat = inst.components.sailor:GetBoat()

            if boat and boat.components.sailable.creaksound then
                inst.SoundEmitter:PlaySound(boat.components.sailable.creaksound, nil, nil, true)
            end
            inst.SoundEmitter:PlaySound("ia/common/boat/paddle", nil, nil, true)
            DoFoleySounds(inst)

            if not inst.AnimState:IsCurrentAnimation("row_loop") then
                --RoT has row_medium, which is identical but uses the equipped item as paddle
                inst.AnimState:PlayAnimation("row_loop", true)
            end
            if boat then
                boat.replica.sailable:PlayRowAnims()
            end

            if boat and boat.components.rowboatwakespawner then
                boat.components.rowboatwakespawner:StartSpawning()
            end

            if inst.components.mapwrapper
            and inst.components.mapwrapper._state > 1
            and inst.components.mapwrapper._state < 5 then
                inst.sg:AddStateTag("nomorph")
                -- TODO pause predict?
            end

            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        onexit = OnExitRow,

        timeline = {
            TimeEvent(8*FRAMES, function(inst)
                local boat = inst.components.sailor:GetBoat()
                if boat and boat.components.container then
                    local trawlnet = boat.components.container:GetItemInBoatSlot(BOATEQUIPSLOTS.BOAT_SAIL)
                    if trawlnet and trawlnet.rowsound then
                        inst.SoundEmitter:PlaySound(trawlnet.rowsound, nil, nil, true)
                    end
                end
            end),
        },

        events = {
            EventHandler("trawlitem", function(inst)
                local boat = inst.components.sailor:GetBoat()
                if boat then
                    boat.replica.sailable:PlayTrawlOverAnims()
                end
            end),
        },

        ontimeout = function(inst) inst.sg:GoToState("row_ia") end,
    },

    State{
        name = "row_stop_ia",
        tags = { "canrotate", "idle", "autopredict"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            local boat = inst.components.sailor:GetBoat()
            inst.AnimState:PlayAnimation("row_pst")
            if boat then
                boat.replica.sailable:PlayPostRowAnims()
            end

            --If the player had something in their hand before starting to row, put it back.
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:PushAnimation("item_out", false)
            end
        end,

        events = {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if equipped then
                        equipped:PushEvent("stoprowing", {owner = inst})
                    end
                    inst:PushEvent("stoprowing")
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "sail_start_ia",
        tags = {"moving", "running", "canrotate", "boating", "sailing", "autopredict"},

        onenter = function(inst)
            local boat = inst.components.sailor:GetBoat()

            inst.components.locomotor:RunForward()

            if inst.has_sailface then
                inst.AnimState:PlayAnimation("sail_pre")
            else
                inst.AnimState:PlayAnimation("sail_ia_pre")
            end
            if boat then
                boat.replica.sailable:PlayPreSailAnims()
            end

            local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equipped then
                equipped:PushEvent("startsailing", {owner = inst})
            end
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        onexit = OnExitSail,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("sail_ia")
                end
            end),
        },
    },

    State{
        name = "sail_ia",
        tags = {"canrotate", "moving", "running", "boating", "sailing", "autopredict"},

        onenter = function(inst)
            local boat = inst.components.sailor:GetBoat()

            local loopsound = nil
            local flapsound = nil

            if boat and boat.components.container and boat.components.container.hasboatequipslots then
                local sail = boat.components.container:GetItemInBoatSlot(BOATEQUIPSLOTS.BOAT_SAIL)
                if sail then
                    loopsound = sail.loopsound
                    flapsound = sail.flapsound
                end
            elseif boat and boat.components.sailable.sailsound then
                loopsound = boat.components.sailable.sailsound
            end

            if not inst.SoundEmitter:PlayingSound("sail_loop") and loopsound then
                inst.SoundEmitter:PlaySound(loopsound, "sail_loop", nil, true)
            end

            if flapsound then
                inst.SoundEmitter:PlaySound(flapsound, nil, nil, true)
            end

            if boat and boat.components.sailable.creaksound then
                inst.SoundEmitter:PlaySound(boat.components.sailable.creaksound, nil, nil, true)
            end

            if not (inst.AnimState:IsCurrentAnimation("sail_loop") or inst.AnimState:IsCurrentAnimation("sail_loop")) then
                if inst.has_sailface then
                    inst.AnimState:PlayAnimation("sail_loop", true)
                else
                    inst.AnimState:PlayAnimation("sail_ia_loop", true)
                end
            end
            if boat then
                boat.replica.sailable:PlaySailAnims()
            end

            if boat and boat.components.rowboatwakespawner then
                boat.components.rowboatwakespawner:StartSpawning()
            end

            if inst.components.mapwrapper
            and inst.components.mapwrapper._state > 1
            and inst.components.mapwrapper._state < 5 then
                inst.sg:AddStateTag("nomorph")
                --TODO pause predict?
            end
            inst.sg:SetTimeout(inst.AnimState:GetCurrentAnimationLength())
        end,

        onexit = OnExitSail,

        events = {
            --EventHandler("animover", function(inst) inst.sg:GoToState("sail_ia") end ),
            EventHandler("trawlitem", function(inst)
                local boat = inst.components.sailor:GetBoat()
                if boat then
                    boat.replica.sailable:PlayTrawlOverAnims()
                end
            end),
        },

        ontimeout = function(inst) inst.sg:GoToState("sail_ia") end,
    },

    State{
        name = "sail_stop_ia",
        tags = {"canrotate", "idle", "autopredict"},

        onenter = function(inst)
            local boat = inst.components.sailor:GetBoat()

            inst.components.locomotor:Stop()
            if inst.has_sailface then
                inst.AnimState:PlayAnimation("sail_pst")
            else
                inst.AnimState:PlayAnimation("sail_ia_pst")
            end
            if boat then
                boat.replica.sailable:PlayPostSailAnims()
            end
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    local equipped = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if equipped then
                        equipped:PushEvent("stopsailing", {owner = inst})
                    end
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "embark",
        tags = {"canrotate", "boating", "busy", "nomorph", "nopredict"},
        onenter = function(inst)
            local BA = inst:GetBufferedAction()
            if BA.target and BA.target.components.sailable and not BA.target.components.sailable:IsOccupied() then
                BA.target.components.sailable.isembarking = true
                if inst.components.sailor and inst.components.sailor:IsSailing() then
                    inst.components.sailor:Disembark(nil, true)
                else
                    inst.sg:GoToState("jumponboatstart")
                end
            else
                --go to idle first so wilson can go to the talk state if desired -M
                --and in my defence, Klei does that too, in opengift state
                inst.sg:GoToState("idle")
                inst:PushEvent("actionfailed", { action = inst.bufferedaction, reason = "INUSE" })
                inst:ClearBufferedAction()
            end
        end,

        onexit = function(inst)
        end,
    },

    State{
        name = "disembark",
        tags = {"canrotate", "boating", "busy", "nomorph", "nopredict"},
        onenter = function(inst)
            inst:PerformBufferedAction()
        end,

        onexit = function(inst)
        end,
    },

    State{
        name = "jumponboatstart",
        tags = { "doing", "nointerupt", "busy", "canrotate", "nomorph", "nopredict"},

        onenter = function(inst)
            if inst.Physics.ClearCollidesWith then
            inst.Physics:ClearCollidesWith(COLLISION.LIMITS) -- R08_ROT_TURNOFTIDES
            end
            inst.components.locomotor:StopMoving()
            -- inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.AnimState:PlayAnimation("jumpboat")
            inst.SoundEmitter:PlaySound("ia/common/boatjump_whoosh")

            local BA = inst:GetBufferedAction()
            inst.sg.statemem.startpos = inst:GetPosition()
            inst.sg.statemem.targetpos = BA.target and BA.target:GetPosition()

            inst:PushEvent("ms_closepopups")

            inst.sg:AddStateTag("temp_invincible")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        onexit = function(inst)
        -- This shouldn"t actually be reached
            if inst.Physics.ClearCollidesWith then
            inst.Physics:CollidesWith(COLLISION.LIMITS) -- R08_ROT_TURNOFTIDES
            end
            inst.components.locomotor:Stop()
            -- inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.sg:RemoveStateTag("temp_invincible")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end,

        timeline = {
            -- Make the action cancel-able until this?
            TimeEvent(7 * FRAMES, function(inst)
                inst:ForceFacePoint(inst.sg.statemem.targetpos:Get())
                local dist = inst:GetPosition():Dist(inst.sg.statemem.targetpos)
                local speed = dist / (18/30)
                inst.Physics:SetMotorVelOverride(1 * speed, 0, 0)
            end),
        },

        events = {
            EventHandler("animover", function(inst)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end

                inst.sg:RemoveStateTag("temp_invincible")
                inst.Transform:SetPosition(inst.sg.statemem.targetpos:Get())
                inst.Physics:Stop()

                inst.components.locomotor:Stop()
                -- inst.components.locomotor:EnableGroundSpeedMultiplier(true)
                inst:PerformBufferedAction()
            end),
        },
    },

    State{
        name = "jumpboatland",
        tags = { "doing", "nointerupt", "busy", "canrotate", "invisible", "nomorph", "nopredict", "amphibious"},

        onenter = function(inst, pos)
            if inst.Physics.ClearCollidesWith then
            inst.Physics:CollidesWith(COLLISION.LIMITS) --R08_ROT_TURNOFTIDES
            end
            inst.sg:AddStateTag("temp_invincible")
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("landboat")
            local boat = inst.components.sailor.boat
            if boat and boat.landsound then
                inst.SoundEmitter:PlaySound(boat.landsound)
            end
        end,

        onexit = function(inst)
            inst.sg:RemoveStateTag("temp_invincible")
            if inst.components.drydrownable ~= nil and inst.components.drydrownable:ShouldDrown() then
                inst:PushEvent("onhitcoastline")
            end
        end,

        events = {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "jumpoffboatstart",
        tags = { "doing", "nointerupt", "busy", "canrotate", "nomorph", "nopredict", "amphibious"},

        onenter = function(inst, pos)
            if inst.Physics.ClearCollidesWith then
            inst.Physics:ClearCollidesWith(COLLISION.LIMITS) --R08_ROT_TURNOFTIDES
            end
            inst.components.locomotor:StopMoving()
            --inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.AnimState:PlayAnimation("jumpboat")
            inst.SoundEmitter:PlaySound("ia/common/boatjump_whoosh")

            inst.sg.statemem.startpos = inst:GetPosition()
            inst.sg.statemem.targetpos = pos

            inst:PushEvent("ms_closepopups")

            inst.sg:AddStateTag("temp_invincible")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        onexit = function(inst)
        --This shouldn"t actually be reached
            if inst.Physics.ClearCollidesWith then
            inst.Physics:CollidesWith(COLLISION.LIMITS) --R08_ROT_TURNOFTIDES
            end
            inst.components.locomotor:Stop()
            --inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.sg:RemoveStateTag("temp_invincible")

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end,

        timeline = {
            --Make the action cancel-able until this?
            TimeEvent(7 * FRAMES, function(inst)
                inst:ForceFacePoint(inst.sg.statemem.targetpos:Get())
                local dist = inst:GetPosition():Dist(inst.sg.statemem.targetpos)
                local speed = dist / (18/30)
                inst.Physics:SetMotorVelOverride(1 * speed, 0, 0)
            end),
        },

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.Transform:SetPosition(inst.sg.statemem.targetpos:Get())
                    inst.sg:RemoveStateTag("temp_invincible")
                    inst.sg:GoToState("jumpoffboatland")
                end
            end),
        },
    },

    State{
        name = "jumpoffboatland",
        tags = { "doing", "nointerupt", "busy", "canrotate", "nomorph", "nopredict", "amphibious"},

        onenter = function(inst, pos)
            if inst.Physics.ClearCollidesWith then
            inst.Physics:CollidesWith(COLLISION.LIMITS) --R08_ROT_TURNOFTIDES
            end
            inst.sg:AddStateTag("temp_invincible")
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("land", false)
            inst.SoundEmitter:PlaySound("ia/common/boatjump_to_land")
            PlayFootstep(inst)
        end,

        onexit = function(inst)
            inst.sg:RemoveStateTag("temp_invincible")
        end,

        events = {
            EventHandler("animqueueover", function(inst)
                inst:PerformBufferedAction()
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "hack_start",
        tags = {"prehack", "working"},

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("chop_pre")
        end,

        events = {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("hack")
                end
            end),
        },
    },

    State{
        name = "hack",
        tags = {"prehack", "hacking", "working"},

        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.AnimState:PlayAnimation("chop_loop")
        end,

        timeline = {
            TimeEvent(2*FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),


            TimeEvent(9*FRAMES, function(inst)
                inst.sg:RemoveStateTag("prehack")
            end),

            TimeEvent(14*FRAMES, function(inst)
                if inst.components.playercontroller ~= nil and
                inst.components.playercontroller:IsAnyOfControlsPressed(
                CONTROL_PRIMARY, CONTROL_ACTION, CONTROL_CONTROLLER_ACTION) and
                inst.sg.statemem.action ~= nil and
                inst.sg.statemem.action:IsValid() and
                inst.sg.statemem.action.target ~= nil and
                inst.sg.statemem.action.target.components.hackable ~= nil and
                inst.sg.statemem.action.target.components.hackable:CanBeHacked() and
                inst.sg.statemem.action.target:IsActionValid(inst.sg.statemem.action.action) and
                CanEntitySeeTarget(inst, inst.sg.statemem.action.target) then
                    inst:ClearBufferedAction()
                    inst:PushBufferedAction(inst.sg.statemem.action)
                end
            end),

            TimeEvent(16*FRAMES, function(inst)
                inst.sg:RemoveStateTag("hacking")
            end),
        },

        events = {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "sink_boat",
        tags = { "busy", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst, shore_pt)
            inst:ClearBufferedAction()

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()

            inst.AnimState:Hide("swap_arm_carry")
            inst.AnimState:PlayAnimation("boat_death")

            inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/sinking")

            if inst.components.rider:IsRiding() then
                inst.sg:AddStateTag("dismounting")
            end

            if shore_pt ~= nil then
                inst.components.drownable:OnFallInOcean(shore_pt:Get())
            else
                inst.components.drownable:OnFallInOcean()
            end

            inst.components.drownable:DropInventory()

            inst.sg:SetTimeout(8) -- just in case
        end,

        timeline = {
            TimeEvent(50*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("ia/common/boat/sinking/shadow")
            end),
            TimeEvent(70*FRAMES, function(inst)
                inst.DynamicShadow:Enable(false)
            end),
        },

        ontimeout= function(inst)  -- failsafe
            StartTeleporting(inst)

            if inst.sg:HasStateTag("dismounting") then
                inst.sg:RemoveStateTag("dismounting")

                local mount = inst.components.rider:GetMount()
                inst.components.rider:ActualDismount()
                if mount ~= nil then
                    if mount.components.drownable ~= nil then
                        mount:Hide()
                        mount:PushEvent("onsink", {noanim = true, shore_pt = Vector3(inst.components.drownable.dest_x, inst.components.drownable.dest_y, inst.components.drownable.dest_z)})
                    elseif mount.components.health ~= nil then
                        mount:Hide()
                        mount.components.health:Kill()
                    end
                end
            end

            inst.components.drownable:WashAshore()
        end,

        events = {
            EventHandler("animover", function(inst)
                StartTeleporting(inst)

                if inst.sg:HasStateTag("dismounting") then
                    inst.sg:RemoveStateTag("dismounting")

                    local mount = inst.components.rider:GetMount()
                    inst.components.rider:ActualDismount()
                    if mount ~= nil then
                        if mount.components.drownable ~= nil then
                            mount:Hide()
                            mount:PushEvent("onsink", {noanim = true, shore_pt = Vector3(inst.components.drownable.dest_x, inst.components.drownable.dest_y, inst.components.drownable.dest_z)})
                        elseif mount.components.health ~= nil then
                            mount:Hide()
                            mount.components.health:Kill()
                        end
                    end
                end

                inst.components.drownable:WashAshore()
            end),

            EventHandler("on_washed_ashore", function(inst)
                -- Congrats you LIVE!
                local drownable = inst.components.drownable
                inst.sg:GoToState("washed_ashore")
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end

            inst.DynamicShadow:Enable(true)
        end,
    },

    State{
        name = "death_drown",
        tags = { "busy", "dead", "canrotate", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst, data)
            assert(inst.deathcause ~= nil, "Entered death state without cause.")

            ClearStatusAilments(inst)

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()
            inst:ClearBufferedAction()

            if inst.components.burnable ~= nil then
                inst.components.burnable:Extinguish()
            end

            inst.components.inventory:DropEverything(true)

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
                inst.components.playercontroller:Enable(false)
            end

            inst.AnimState:SetPercent(inst.deathanimoverride or "death", 1)
            inst:PushEvent("playerdied", { skeleton = false })
        end,
    },

    State{
        name = "jumpinbermuda",
        tags = {"doing", "busy", "canrotate", "nopredict", "nomorph"},

        onenter = function(inst, data)
            inst.components.locomotor:Stop()

            inst.sg.statemem.target = data.teleporter
            local target = inst.sg.statemem.target
            if target and target.prefab == "bermudatriangle" and
                target.sg and not target.sg:HasStateTag("open") then
                target.sg:GoToState("opening")
            end
            local targetTeleporter = inst.sg.statemem.target.components.teleporter.targetTeleporter
            if targetTeleporter and targetTeleporter.prefab == "bermudatriangle" and
                targetTeleporter.sg and not targetTeleporter.sg:HasStateTag("open") then
                targetTeleporter.sg:GoToState("opening")
            end

            inst.sg.statemem.teleportarrivestate = "jumpoutbermuda" -- for teleporter cmp
            inst.sg.statemem.target = data.teleporter
            if data.teleporter ~= nil and data.teleporter.components.teleporter ~= nil then
                data.teleporter.components.teleporter:RegisterTeleportee(inst)
            end

            installBermudaFX(inst)
        end,

        onexit = function(inst)
            removeBermudaFX(inst)

            if inst.sg.statemem.isteleporting then
                inst.sg:RemoveStateTag("temp_invincible")

                if TUNING.DO_SEA_DAMAGE_TO_BOAT and inst.components.sailor.boat and
                inst.components.sailor.boat.components.boathealth then
                    inst.components.sailor.boat.components.boathealth:SetInvincible(false)
                end
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
                inst:Show()
                inst.DynamicShadow:Enable(true)
            elseif inst.sg.statemem.target ~= nil
            and inst.sg.statemem.target:IsValid()
            and inst.sg.statemem.target.components.teleporter ~= nil then
                inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
            end

            local target = inst.sg.statemem.target
            if target and target.sg then
                target:DoTaskInTime(1, function(inst)
                    if inst and inst.prefab == "bermudatriangle" and inst.sg and inst.sg:HasStateTag("open") and
                        --inst.components.teleporter ~= nil and not inst.components.teleporter:IsBusy() and
                        inst.components.playerprox ~= nil and not inst.components.playerprox:IsPlayerClose() then
                        inst.sg:GoToState("closing")
                    end
                end)
            end
            local targetTeleporter = inst.sg.statemem.target.components.teleporter.targetTeleporter
            if targetTeleporter and targetTeleporter.sg then
                targetTeleporter:DoTaskInTime(1, function(inst)
                    if inst and inst.prefab == "bermudatriangle" and inst.sg and inst.sg:HasStateTag("open") and
                        --inst.components.teleporter ~= nil and not inst.components.teleporter:IsBusy() and
                        inst.components.playerprox ~= nil and not inst.components.playerprox:IsPlayerClose() then
                        inst.sg:GoToState("closing")
                    end
                end)
            end
        end,

        timeline = {
            -- this is just hacked in here to make the sound play BEFORE the player hits the wormhole
            TimeEvent(30*FRAMES, function(inst)
                inst:Hide()
                removeBermudaFX(inst)
                inst.sg:AddStateTag("temp_invincible")
                SpawnPrefab("pixel_out").Transform:SetPosition(inst:GetPosition():Get())
            end),

            TimeEvent(40*FRAMES, function(inst)
                if inst.sg.statemem.target ~= nil
                and inst.sg.statemem.target:IsValid()
                and inst.sg.statemem.target.components.teleporter ~= nil then
                    --Unregister first before actually teleporting
                    inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
                    if inst.sg.statemem.target.components.teleporter:Activate(inst) then
                        inst.sg.statemem.isteleporting = true
                        inst.sg:AddStateTag("temp_invincible")

                        if TUNING.DO_SEA_DAMAGE_TO_BOAT and inst.components.sailor.boat and
                        inst.components.sailor.boat.components.boathealth then
                            inst.components.sailor.boat.components.boathealth:SetInvincible(true)
                        end

                        if inst.components.playercontroller ~= nil then
                            inst.components.playercontroller:Enable(false)
                        end
                        inst:Hide()
                        inst.DynamicShadow:Enable(false)
                    end
                    inst.sg:GoToState("jumpoutbermuda")
                end
            end),
        },
    },

    State{
        name = "jumpoutbermuda",
        tags = {"doing", "busy", "canrotate", "nopredict", "nomorph"},

        onenter = function(inst, data)
            inst.components.locomotor:Stop()

            SpawnPrefab("pixel_in").Transform:SetPosition(inst:GetPosition():Get())
        end,

        onexit = function(inst)
            removeBermudaFX(inst)
            inst:Show()
        end,

        timeline =
        {

            TimeEvent(10*FRAMES, function(inst)
                inst:Show()
                installBermudaFX(inst)
                --inst.components.health:SetInvincible(false)
            end),

            TimeEvent(35*FRAMES, function(inst)
                inst.sg:GoToState("idle")
            end),
        },
    },

    State{
        name = "vacuumedin",
        tags = {"busy", "vacuum_in", "canrotate", "pausepredict", "amphibious"},

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.AnimState:PlayAnimation("flying_pre")
            inst.AnimState:PlayAnimation("flying_loop", true)

            RaiseFlyingPlayer(inst)
        end,

        onexit = function(inst)
            if inst.components.Health and not inst.components.health:IsDead() and IsOnWater(inst) then
                inst.components.health:Drown(true)
            end
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            LandFlyingPlayer(inst)
        end,
    },

    State{
        name = "vacuumedheld",
        tags = {"busy", "vacuum_held", "pausepredict"},

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.DynamicShadow:Enable(false)
            inst:Hide()

            RaiseFlyingPlayer(inst)
        end,

        onexit = function(inst)
            inst:Show()
            inst.DynamicShadow:Enable(true)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end

            LandFlyingPlayer(inst)
        end,
    },

    State{
        name = "vacuumedout",
        tags = {"busy", "vacuum_out", "canrotate", "pausepredict"},

        onenter = function(inst, data)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.AnimState:PlayAnimation("flying_loop", true)

            inst.sg.mem.angle = math.random(360)
            inst.sg.mem.speed = data.speed

            local rx, rz = math.rotate(math.rcos(inst.sg.mem.angle) * inst.sg.mem.speed, math.rsin(inst.sg.mem.angle) * inst.sg.mem.speed, math.rad(inst.Transform:GetRotation()))

            inst.Physics:SetMotorVelOverride(rx, 0, rz)

            inst.sg:SetTimeout(FRAMES*10)
        end,


        onupdate = function(inst)
            local rx, rz = math.rotate(math.rcos(inst.sg.mem.angle) * inst.sg.mem.speed, math.rsin(inst.sg.mem.angle) * inst.sg.mem.speed, math.rad(inst.Transform:GetRotation()))

            inst.Physics:SetMotorVelOverride(rx, 0, rz)
        end,

        ontimeout = function(inst)
            inst.Physics:ClearMotorVelOverride()

            local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if item then
                inst.components.inventory:DropItem(item)
            end

            for i = 1, 4 do
                item = nil
                local slot = math.random(1,inst.components.inventory:GetNumSlots())
                item = inst.components.inventory:GetItemInSlot(slot)
                if item then
                    inst.components.inventory:DropItem(item, true, true)
                end
            end

            inst.Physics:SetMotorVel(0,0,0)
            inst.sg:GoToState("vacuumedland")
            inst:DoTaskInTime(5, function(inst) inst:RemoveTag("NOVACUUM") end)
        end,

        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
        end,
    },

    State{
        name = "vacuumedland",
        tags = {"busy", "pausepredict"},

        onenter = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
                inst.components.playercontroller:RemotePausePrediction()
            end
            inst.AnimState:PlayAnimation("flying_land")
            inst.sg:AddStateTag("temp_invincible")
        end,

        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            inst.sg:RemoveStateTag("temp_invincible")
        end,

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "throw",
        tags = {"attack", "notalking", "abouttoattack"},

        onenter = function(inst)
            if inst:HasTag("_sailor") and inst:HasTag("sailing") then
                inst.sg:AddStateTag("boating")
            end
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("throw")

            if inst.components.combat.target then
                if inst.components.combat.target and inst.components.combat.target:IsValid() then
                    inst:FacePoint(inst.components.combat.target.Transform:GetWorldPosition())
                end
            end

        end,

        timeline=
        {
            TimeEvent(7*FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.components.combat:DoAttack(inst.sg.statemem.target)
                inst.sg:RemoveStateTag("abouttoattack")
            end),
            TimeEvent(11*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },

        events=
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "speargun",
        tags = {"attack", "notalking", "abouttoattack"},

        onenter = function(inst)
            if inst.components.rider:IsRiding() then
                inst.Transform:SetFourFaced()
            end
            if inst:HasTag("_sailor") and inst:HasTag("sailing") then
                inst.sg:AddStateTag("boating")
            end
            inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("speargun")

            if inst.components.combat.target then
                if inst.components.combat.target and inst.components.combat.target:IsValid() then
                    inst:FacePoint(inst.components.combat.target.Transform:GetWorldPosition())
                end
            end
        end,

        onexit = function(inst)
            if inst.components.rider:IsRiding() then
                inst.Transform:SetSixFaced()
            end
        end,

        timeline=
        {
            TimeEvent(12*FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.components.combat:DoAttack(inst.sg.statemem.target)
                inst.sg:RemoveStateTag("abouttoattack")
                if inst.components.combat:GetWeapon() and inst.components.combat:GetWeapon():HasTag("blunderbuss") then
                    --inst.SoundEmitter:PlaySound("dontstarve_DLC003/common/items/weapon/blunderbuss_shoot")
                    inst.SoundEmitter:PlaySound("blunderbuss/blunderbuss/blunderbuss")
                    local cloud = SpawnPrefab("cloudpuff")
                    local pt = Vector3(inst.Transform:GetWorldPosition())

                    local angle
                    if inst.components.combat.target and inst.components.combat.target:IsValid() then
                        angle = (inst:GetAngleToPoint(inst.components.combat.target.Transform:GetWorldPosition()) -90)*DEGREES
                    else
                        angle = (inst:GetAngleToPoint(inst.sg.statemem.target_position.x, inst.sg.statemem.target_position.y, inst.sg.statemem.target_position.z) -90)*DEGREES
                    end                        
                    inst.sg.statemem.target_position = nil
                    
                    local DIST = 1.5
                    local offset = Vector3(DIST * math.cos( angle+(PI/2) ), 0, -DIST * math.sin( angle+(PI/2) ))

                    local y = inst.components.rider:IsRiding() and 4.5 or 2
                    cloud.Transform:SetPosition(pt.x + offset.x, y, pt.z + offset.z)
                else
                    inst.SoundEmitter:PlaySound("ia/common/use_speargun")
                end
            end),
            TimeEvent(20*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },

        events=
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "cannon",
        tags = {"busy", "doing"},

        onenter = function(inst)
            if inst:HasTag("_sailor") and inst:HasTag("sailing") then
                inst.sg:AddStateTag("boating")
            end
            inst.AnimState:PlayAnimation("give")
        end,

        timeline = {
            TimeEvent(13*FRAMES, function(inst)
                --Light Cannon
                inst.sg:RemoveStateTag("abouttoattack")
                inst:PerformBufferedAction()
            end),
            TimeEvent(15*FRAMES, function(inst) inst.sg:RemoveStateTag("attack") end),
        },

        events = {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{
        name = "hitcoastline",
        tags = { "busy", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst, shore_pt)
            inst:ClearBufferedAction()

            inst.components.locomotor:Stop()
            inst.components.locomotor:Clear()

            inst.AnimState:PlayAnimation("dozy")
            inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/sinking")

            if shore_pt ~= nil then
                inst.components.drydrownable:OnHitCoastline(shore_pt:Get())
            else
                inst.components.drydrownable:OnHitCoastline()
            end
            inst.DynamicShadow:Enable(false)

            local sand = SpawnPrefab("townportalsandcoffin_fx")
            sand.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    local puddle = SpawnPrefab("washashore_puddle_fx")
                    puddle.Transform:SetPosition(inst.Transform:GetWorldPosition())
                    StartTeleporting(inst)
                    inst.components.drydrownable:WashAway()
                end
            end),

            EventHandler("on_washed_away", function(inst)
                inst.sg:GoToState("washed_away")
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                DoneTeleporting(inst)
            end

            inst.DynamicShadow:Enable(true)
        end,
    },

    State{
        name = "washed_away",
        tags = { "busy", "canrotate", "nopredict", "nomorph", "drowning", "nointerrupt" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("wakeup")
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
}

local hop_timelines =
{
    hop_pre =
    {
        TimeEvent(0, function(inst)
            inst.components.embarker.embark_speed = math.clamp(inst.components.locomotor:RunSpeed() * inst.components.locomotor:GetSpeedMultiplier() + TUNING.WILSON_EMBARK_SPEED_BOOST, TUNING.WILSON_EMBARK_SPEED_MIN, TUNING.WILSON_EMBARK_SPEED_MAX)
        end),
    },
    hop_loop =
    {
        TimeEvent(0, function(inst)
            inst.SoundEmitter:PlaySound("turnoftides/common/together/boat/jump")
        end),
    },
}

local function landed_in_falling_state(inst)
    if inst.components.drownable == nil then
        return nil
    end

    local fallingreason = inst.components.drownable:GetFallingReason()
    if fallingreason == nil then
        return nil
    end

    if fallingreason == FALLINGREASON.OCEAN then
        return "sink"
    elseif fallingreason == FALLINGREASON.VOID then
        return "abyss_fall"
    end

    return nil -- TODO(JBK): Fallback for unknown falling reason?
end

local hop_anims = { pre = "boat_jump_pre", loop = "boat_jump_loop", pst = "boat_jump_pst" }

CommonStates.AddRowStates(states, false)
CommonStates.AddHopStates(states, true, hop_anims, hop_timelines, "turnoftides/common/together/boat/jump_on", landed_in_falling_state, {start_embarking_pre_frame = 4*FRAMES})

return StateGraph("wx", states, events, "idle", actionhandlers)