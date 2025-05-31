-- 姐妹故事书

local assets =
{
    Asset("ANIM", "anim/sisters_stories.zip"),

    Asset( "IMAGE", "images/inventoryimages/sisters_stories.tex" ),
    Asset( "ATLAS", "images/inventoryimages/sisters_stories.xml" ),

    Asset( "IMAGE", "images/spell_icons/sweet_memory.tex" ),
    Asset( "ATLAS", "images/spell_icons/sweet_memory.xml" ),

    Asset( "IMAGE", "images/spell_icons/castling.tex" ),
    Asset( "ATLAS", "images/spell_icons/castling.xml" ),

    Asset( "IMAGE", "images/spell_icons/same_heart.tex" ),
    Asset( "ATLAS", "images/spell_icons/same_heart.xml" ),

    Asset( "IMAGE", "images/spell_icons/small_contradiction.tex" ),
    Asset( "ATLAS", "images/spell_icons/small_contradiction.xml" ),

    Asset( "IMAGE", "images/spell_icons/moon_essence.tex" ),
    Asset( "ATLAS", "images/spell_icons/moon_essence.xml" ),

    Asset( "IMAGE", "images/spell_icons/shadow_present.tex" ),
    Asset( "ATLAS", "images/spell_icons/shadow_present.xml" ),
}

local function WatchSkillRefresh_Server(inst, owner)
    if inst._owner then
        inst:RemoveEventCallback("onactivateskill_server", inst._onskillrefresh_server, inst._owner)
        inst:RemoveEventCallback("ondeactivateskill_server", inst._onskillrefresh_server, inst._owner)
    end
    inst._owner = owner
    if owner then
        inst:ListenForEvent("onactivateskill_server", inst._onskillrefresh_server, owner)
        inst:ListenForEvent("ondeactivateskill_server", inst._onskillrefresh_server, owner)
    end
end

local function WatchSkillRefresh_Client(inst, owner)
    if inst._owner then
        inst:RemoveEventCallback("onactivateskill_client", inst._onskillrefresh_client, inst._owner)
        inst:RemoveEventCallback("ondeactivateskill_client", inst._onskillrefresh_client, inst._owner)
    end
    inst._owner = owner
    if owner then
        inst:ListenForEvent("onactivateskill_client", inst._onskillrefresh_client, owner)
        inst:ListenForEvent("ondeactivateskill_client", inst._onskillrefresh_client, owner)
    end
end

local ICON_SCALE = .5
local SPELLBOOK_RADIUS = 100
local ICON_RADIUS = 35

local function SpellCost(pct)
    return pct * TUNING.LARGE_FUEL * -4
end

local function StartAOETargeting(inst)
    local playercontroller = ThePlayer.components.playercontroller
    if playercontroller ~= nil then
        playercontroller:StartAOETargetingUsing(inst)
    end
end

local function CastlingFn(inst, doer, pos)
    if doer ~= nil then
        if doer.components.ghostlybond ~= nil then
            if doer.components.ghostlybond.ghost ~= nil and doer.components.ghostlybond.summoned then

                local ghost = doer.components.ghostlybond.ghost
                local x1, y1, z1 = doer.Transform:GetWorldPosition()
                local x2, y2, z2 = ghost.Transform:GetWorldPosition()

                doer:DoTaskInTime(1.25, function(self)
                    doer.components.talker:Say(STRINGS.WENDY_READ_CASTLING)

                    local doer_health_percent = doer.components.health:GetPercent()
                    local ghost_health_percent = ghost.components.health:GetPercent()

                    doer.components.health:SetPercent(ghost_health_percent, true)
                    ghost.components.health:SetPercent(doer_health_percent, true)

                    doer.Transform:SetPosition(x2, y2, z2)

                    ghost.Transform:SetPosition(x1, y1, z1)
                end)

                inst.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.CASTLING), doer)
                doer.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.CASTLING)

                doer.components.spellbookcooldowns:RestartSpellCooldown("castling", TUNING.SISTERS_STORIES_SPELL_COST.CASTLING_CD)

                return true
            elseif doer.components.ghostlybond.ghost == nil then
                doer.components.talker:Say(STRINGS.WENDY_READ_SISTERS_STORIES_WITHOUT_ABIGAIL)
                return false, "NO_ABIGAIL"
            elseif doer.components.spellbookcooldowns and doer.components.spellbookcooldowns:IsInCooldown("castling") then
                return false, "SPELL_IN_COOLDOWN"
            end
        end
    end
    return false
end

local function SameHeartFn(inst, doer, pos)
    if doer ~= nil then
        if doer.components.ghostlybond ~= nil then
            if doer.components.ghostlybond.ghost ~= nil and doer.components.ghostlybond.summoned then
                local ghost = doer.components.ghostlybond.ghost

                if ghost.is_defensive then
                    if ghost.same_heart_task ~= nil then
                        ghost.same_heart_task:Cancel()
                        ghost.same_heart_task = nil
                    end
                    if ghost.cancel_same_heart_task ~= nil then
                        ghost.cancel_same_heart_task:Cancel()
                        ghost.cancel_same_heart_task = nil
                    end
                    doer.components.talker:Say(STRINGS.WENDY_READ_SAME_HEART)
                    -- 可以打影怪
                    ghost:AddTag("crazy")
                    -- 提升速度
                    ghost.components.locomotor.walkspeed = doer.components.locomotor.walkspeed
                    ghost.components.locomotor.runspeed = doer.components.locomotor.runspeed
                    -- 紧随温蒂
                    ghost.same_heart_task = ghost:DoPeriodicTask(0.2,function()
                        -- 提升速度
                        ghost.components.locomotor.walkspeed = doer.components.locomotor.walkspeed
                        ghost.components.locomotor.runspeed = doer.components.locomotor.runspeed
                        local inrange = ghost:GetDistanceSqToInst(ghost._playerlink) <= 4
                        if not inrange then
                            local x,y,z = ghost._playerlink.Transform:GetWorldPosition()
                            local position = Vector3(x,0,z)
                            ghost.components.locomotor:GoToPoint(position, nil, true)
                        end
                    end)
                    ghost.cancel_same_heart_task = ghost:DoTaskInTime(60, function()
                        if ghost.same_heart_task ~= nil then
                            ghost.same_heart_task:Cancel()
                            ghost.same_heart_task = nil

                            doer.components.talker:Say(STRINGS.WENDY_END_SAME_HEART)
                        end

                        -- 回归速度
                        ghost.components.locomotor.walkspeed = TUNING.ABIGAIL_SPEED*.5
                        ghost.components.locomotor.runspeed = TUNING.ABIGAIL_SPEED
                        -- 取消可以打影怪
                        ghost:RemoveTag("crazy")
                    end)

                    inst.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.SAME_HEART), doer)
                    doer.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.SAME_HEART)
                else
                    doer.components.talker:Say(STRINGS.WENDY_READ_SAME_HEART_BUT_ABIGAIL_IS_AGGRESSIVE)
                end
            else
                doer.components.talker:Say(STRINGS.WENDY_READ_SISTERS_STORIES_WITHOUT_ABIGAIL)
            end
        end
    end
end

local function single_reticule_mouse_target_function(inst, mousepos)
    if mousepos == nil then
        return nil
    end
    local inventoryitem = inst.replica.inventoryitem
    local owner = inventoryitem:IsHeldBy(ThePlayer) and ThePlayer
    if owner then
        local pos = Vector3(owner.Transform:GetWorldPosition())
        return pos
    end
end

local function single_reticule_target_function(inst)
    if ThePlayer and ThePlayer.components.playercontroller ~= nil and ThePlayer.components.playercontroller.isclientcontrollerattached then
        local inventoryitem = inst.replica.inventoryitem
        local owner = inventoryitem and inventoryitem:IsGrandOwner(ThePlayer) and ThePlayer
        if owner then
            local pos = Vector3(owner.Transform:GetWorldPosition())
            return pos
        end
    end
end

local function single_reticule_update_position_function(inst, pos, reticule, ease, smoothing, dt)

    local inventoryitem = inst.replica.inventoryitem
    local owner = inventoryitem and inventoryitem:IsGrandOwner(ThePlayer) and ThePlayer

    if owner then
        reticule.Transform:SetPosition(Vector3(owner.Transform:GetWorldPosition()):Get())
        reticule.Transform:SetRotation(0)
    end
end

local function ReticuleTargetAllowWaterFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    --Cast range is 8, leave room for error
    --4 is the aoe range
    for r = 7, 0, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos.x, 0, pos.z, true) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function ReticuleFireBallTargetFn()
    return Vector3(ThePlayer.entity:LocalToWorldSpace(5, 0.001, 0)) -- Raised this off the ground a touch so it wont have any z-fighting with the ground biome transition tiles.
end

local function CheckNotRiding(player)
    --client safe
    local rider = player and player.replica.rider
    return not (rider and rider:IsRiding())
end

local function CheckCooldown(spell_name)
    return function(player)
        --client safe
        return player
                and player.components.spellbookcooldowns
                and player.components.spellbookcooldowns:GetSpellCooldownPercent(spell_name)
                or nil
    end
end

-- 最终的法术表
local BASESPELLS = {
    {
        label = STRINGS.WENDY_SPELL.SWEET_MEMORY,
        execute = function(inst)
            SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "sweet_memory", inst)
        end,
        bank = "sisters_stories_spell_icon",
        build = "sisters_stories_spell_icon",
        anims =
        {
            idle = { anim = "sweet_memory" },
            focus = { anim = "sweet_memory_focus" },
            down = { anim = "sweet_memory_pressed" },
            disabled = { anim = "sweet_memory_disabled" },
            cooldown = { anim = "sweet_memory_cooldown" },
        },
        widget_scale = ICON_SCALE
    },
    {
        label = STRINGS.WENDY_SPELL.CASTLING,
        onselect = function(inst)

            inst.components.spellbook:SetSpellName(STRINGS.WENDY_SPELL.CASTLING)
            inst.components.aoetargeting:SetDeployRadius(0)
            inst.components.aoetargeting:SetShouldRepeatCastFn(nil)
            inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoefiretarget_1"
            inst.components.aoetargeting.reticule.pingprefab = "reticuleaoefiretarget_1ping"

            inst.components.aoetargeting.reticule.mousetargetfn = single_reticule_mouse_target_function
            inst.components.aoetargeting.reticule.targetfn = single_reticule_target_function
            inst.components.aoetargeting.reticule.updatepositionfn = single_reticule_update_position_function

            if TheWorld.ismastersim then
                inst.components.aoetargeting:SetTargetFX(nil)
                inst.components.aoespell:SetSpellFn(CastlingFn)
                inst.components.spellbook:SetSpellFn(nil)
            end
        end,
        execute = StartAOETargeting,
        bank = "sisters_stories_spell_icon",
        build = "sisters_stories_spell_icon",
        anims =
        {
            idle = { anim = "castling" },
            focus = { anim = "castling_focus" },
            down = { anim = "castling_pressed" },
            disabled = { anim = "castling_disabled" },
            cooldown = { anim = "castling_cooldown" },
        },
        widget_scale = ICON_SCALE,
        checkenabled = CheckNotRiding,
        checkcooldown = CheckCooldown("castling"),
        cooldowncolor = { 0.65,0.65,0.65, 0.75 },
    },
    {
        label = STRINGS.WENDY_SPELL.SAME_HEART,
        onselect = function(inst)
            inst.components.spellbook:SetSpellName(STRINGS.WENDY_SPELL.SAME_HEART)
            inst.components.aoetargeting:SetDeployRadius(0)
            inst.components.aoetargeting:SetShouldRepeatCastFn(nil)
            inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoefiretarget_1"
            inst.components.aoetargeting.reticule.pingprefab = "reticuleaoefiretarget_1ping"

            inst.components.aoetargeting.reticule.mousetargetfn = single_reticule_mouse_target_function
            inst.components.aoetargeting.reticule.targetfn = single_reticule_target_function
            inst.components.aoetargeting.reticule.updatepositionfn = single_reticule_update_position_function

            if TheWorld.ismastersim then
                inst.components.aoetargeting:SetTargetFX(nil)
                inst.components.aoespell:SetSpellFn(SameHeartFn)
                inst.components.spellbook:SetSpellFn(nil)
            end
        end,
        execute = StartAOETargeting,
        bank = "sisters_stories_spell_icon",
        build = "sisters_stories_spell_icon",
        anims =
        {
            idle = { anim = "same_heart" },
            focus = { anim = "same_heart_focus" },
            down = { anim = "same_heart_pressed" },
            disabled = { anim = "same_heart_disabled" },
            cooldown = { anim = "same_heart_cooldown" },
        },
        widget_scale = ICON_SCALE,
    }
}

local function DoGhostSpell(doer, event, state, ...)
    local spellbookcooldowns = doer.components.spellbookcooldowns
    local ghostlybond = doer.components.ghostlybond

    if spellbookcooldowns ~= nil and spellbookcooldowns:IsInCooldown("ghostcommand") then
        return false
    end

    if ghostlybond == nil or ghostlybond.ghost == nil then
        return false
    end

    if ghostlybond.ghost.components.health:IsDead() then
        return false
    end

    if event ~= nil then
        ghostlybond.ghost:PushEvent(event, ...)

    elseif state ~= nil then
        ghostlybond.ghost.sg:GoToState(state, ...)
    end

    if spellbookcooldowns ~= nil then
        spellbookcooldowns:RestartSpellCooldown("ghostcommand", TUNING.WENDYSKILL_COMMAND_COOLDOWN)
    end

    return true
end

local function GhostEscapeSpell(inst, doer)
    return DoGhostSpell(doer, "do_ghost_escape")
end

local function GhostAttackAtSpell(inst, doer, pos)
    return DoGhostSpell(doer, "do_ghost_attackat", nil, pos)
end

local function GhostHauntSpell(inst, doer, pos)
    return DoGhostSpell(doer, "do_ghost_hauntat", nil, pos)
end

local function ReticuleGhostTargetFn(inst)
    return Vector3(ThePlayer.entity:LocalToWorldSpace(7, 0.001, 0))
end

local Get_Out_Spell = {
    label = STRINGS.WENDY_SPELL.GET_OUT,
    onselect = function(inst)
        local spellbook = inst.components.spellbook
        spellbook:SetSpellName(STRINGS.WENDY_SPELL.GET_OUT)
        spellbook:SetSpellAction(nil)

        if TheWorld.ismastersim then
            inst.components.aoespell:SetSpellFn(nil)
            spellbook:SetSpellFn(GhostEscapeSpell)
        end
    end,
    execute = function(inst)
        if ThePlayer.replica.inventory then
            ThePlayer.replica.inventory:CastSpellBookFromInv(inst)
        end
    end,
    bank = "sisters_stories_spell_icon",
    build = "sisters_stories_spell_icon",
    anims =
    {
        idle = { anim = "get_out" },
        focus = { anim = "get_out_focus", loop = true },
        down = { anim = "get_out_pressed" },
        disabled = { anim = "get_out_disabled" },
        cooldown = { anim = "get_out_cooldown" },
    },
    widget_scale = ICON_SCALE,
    checkcooldown = CheckCooldown("ghostcommand"),
    cooldowncolor = { 0.65, 0.65, 0.65, 0.75 },
}

local Dash_Spell = {
    label = STRINGS.WENDY_SPELL.DASH,
    onselect = function(inst)
        local spellbook = inst.components.spellbook
        local aoetargeting = inst.components.aoetargeting

        spellbook:SetSpellName(STRINGS.WENDY_SPELL.DASH)
        spellbook:SetSpellAction(nil)
        aoetargeting:SetDeployRadius(0)
        aoetargeting:SetRange(20)
        aoetargeting.reticule.reticuleprefab = "reticuleaoeghosttarget"
        aoetargeting.reticule.pingprefab = "reticuleaoeghosttarget_ping"

        aoetargeting.reticule.mousetargetfn = nil
        aoetargeting.reticule.targetfn = ReticuleGhostTargetFn
        aoetargeting.reticule.updatepositionfn = nil
        aoetargeting.reticule.twinstickrange = 15

        if TheWorld.ismastersim then
            aoetargeting:SetTargetFX("reticuleaoeghosttarget")
            inst.components.aoespell:SetSpellFn(GhostAttackAtSpell)
            spellbook:SetSpellFn(nil)
        end
    end,
    execute = StartAOETargeting,
    bank = "sisters_stories_spell_icon",
    build = "sisters_stories_spell_icon",
    anims =
    {
        idle = { anim = "dash" },
        focus = { anim = "dash_focus", loop = true },
        down = { anim = "dash_pressed" },
        disabled = { anim = "dash_disabled" },
        cooldown = { anim = "dash_cooldown" },
    },
    widget_scale = ICON_SCALE,
    checkcooldown = CheckCooldown("ghostcommand"),
    cooldowncolor = { 0.65, 0.65, 0.65, 0.75 },
}

local Haunt_Spell = {
    label = STRINGS.WENDY_SPELL.HAUNT,
    onselect = function(inst)
        local spellbook = inst.components.spellbook
        local aoetargeting = inst.components.aoetargeting

        spellbook:SetSpellName(STRINGS.WENDY_SPELL.HAUNT)
        spellbook:SetSpellAction(nil)
        aoetargeting:SetDeployRadius(0)
        aoetargeting:SetRange(20)
        aoetargeting.reticule.reticuleprefab = "reticuleaoeghosttarget"
        aoetargeting.reticule.pingprefab = "reticuleaoeghosttarget_ping"

        aoetargeting.reticule.mousetargetfn = nil
        aoetargeting.reticule.targetfn = ReticuleGhostTargetFn
        aoetargeting.reticule.updatepositionfn = nil
        aoetargeting.reticule.twinstickrange = 15

        if TheWorld.ismastersim then
            aoetargeting:SetTargetFX("reticuleaoeghosttarget")
            inst.components.aoespell:SetSpellFn(GhostHauntSpell)
            spellbook:SetSpellFn(nil)
        end
    end,
    execute = StartAOETargeting,
    bank = "sisters_stories_spell_icon",
    build = "sisters_stories_spell_icon",
    anims =
    {
        idle = { anim = "haunt" },
        focus = { anim = "haunt_focus", loop = true },
        down = { anim = "haunt_pressed" },
        disabled = { anim = "haunt_disabled" },
        cooldown = { anim = "haunt_cooldown" },
    },
    widget_scale = ICON_SCALE,
    checkcooldown = CheckCooldown("ghostcommand"),
    cooldowncolor = { 0.65, 0.65, 0.65, 0.75 },
}

local Moon_Spell = {
    label = STRINGS.WENDY_SPELL.MOON_ESSENCE,
    execute = function(inst)
        SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "moon_essence", inst)
    end,
    bank = "sisters_stories_spell_icon",
    build = "sisters_stories_spell_icon",
    anims =
    {
        idle = { anim = "moon_essence" },
        focus = { anim = "moon_essence_focus" },
        down = { anim = "moon_essence_pressed" },
        disabled = { anim = "moon_essence_disabled" },
        cooldown = { anim = "moon_essence_cooldown" },
    },
    widget_scale = ICON_SCALE,
}

local Shadow_Spell = {
    label = STRINGS.WENDY_SPELL.SHADOW_PRESENT,
    execute = function(inst)
        SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "shadow_present", inst)
    end,
    bank = "sisters_stories_spell_icon",
    build = "sisters_stories_spell_icon",
    anims =
    {
        idle = { anim = "shadow_present" },
        focus = { anim = "shadow_present_focus" },
        down = { anim = "shadow_present_pressed" },
        disabled = { anim = "shadow_present_disabled" },
        cooldown = { anim = "shadow_present_cooldown" },
    },
    widget_scale = ICON_SCALE,
    checkcooldown = CheckCooldown("shadow_present")
}


local function OnOpenSpellBook(inst)
end

local function OnCloseSpellBook(inst)
end

local function OnTakeFuel(inst)
end

local function OnFuelDepleted(inst)
end

local function updatespells(inst, owner)
    local spells = shallowcopy(BASESPELLS)

    local skilltreeupdater = owner and owner.components.skilltreeupdater or nil

    local get_out = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_get_out")
    local dash = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_dash")
    local haunt = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_abigail_haunt")

    local moon = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_moon_abigail")
    local shadow = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_shadow_abigail")


    if get_out then
        table.insert(spells, Get_Out_Spell)
    end

    if dash then
        table.insert(spells, Dash_Spell)
    end

    if haunt then
        table.insert(spells, Haunt_Spell)
    end

    if moon then
        table.insert(spells, Moon_Spell)
    elseif shadow then
        table.insert(spells, Shadow_Spell)
    end

    inst.components.spellbook:SetItems(spells)
end

local function DoClientUpdateSpells(inst, force)
    local owner = inst.replica.inventoryitem:IsHeld() and ThePlayer or nil
    if owner ~= inst._owner then
        if owner then
            updatespells(inst, owner)
        end
        WatchSkillRefresh_Client(inst, owner)
    elseif force and owner then
        updatespells(inst, owner)
    end
end

local function OnUpdateSpellsDirty(inst)
    inst:DoTaskInTime(0, DoClientUpdateSpells)
end

local function DoOnClientInit(inst)
    inst:ListenForEvent("willow_ember._updatespells", OnUpdateSpellsDirty)
    DoClientUpdateSpells(inst)
end

local function ToPocket(inst, owner)
    inst.persists = true

    if owner ~= inst._owner then
        inst._updatespells:push()
        updatespells(inst, owner)
        WatchSkillRefresh_Server(inst, owner)
    end
end

local function ToGround(inst)
    inst.persists = false

    if inst._owner then
        WatchSkillRefresh_Server(inst, nil)
        inst._updatespells:push()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sisters_stories")
    inst.AnimState:SetBuild("sisters_stories")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("book")
    inst:AddTag("sisters_stories")

    MakeInventoryFloatable(inst, "med", nil, 0.75)

    inst:AddComponent("spellbook")
    inst.components.spellbook:SetRequiredTag("wendy_sisters_stories")
    inst.components.spellbook:SetRadius(SPELLBOOK_RADIUS)
    inst.components.spellbook:SetFocusRadius(SPELLBOOK_RADIUS)
    inst.components.spellbook:SetOnOpenFn(OnOpenSpellBook)
    inst.components.spellbook:SetOnCloseFn(OnCloseSpellBook)
    inst.components.spellbook:SetItems(BASESPELLS)

    inst:AddComponent("aoespell")

    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting:SetAllowWater(true)

    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true
    inst.components.aoetargeting.reticule.twinstickmode = 1
    inst.components.aoetargeting.reticule.twinstickrange = 8

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:DoTaskInTime(0,DoOnClientInit)
        inst._onskillrefresh_client = function(owner) DoClientUpdateSpells(inst, true) end

        return inst
    end

    inst._onskillrefresh_server = function(owner) updatespells(inst, owner) end

    inst.scrapbook_fueled_rate = SpellCost(TUNING.WAXWELLJOURNAL_SPELL_COST.SHADOW_PILLARS)
    inst.scrapbook_fueled_uses = true

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sisters_stories.xml"

    inst:AddComponent("fueled")
    inst.components.fueled.accepting = true
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
    inst.components.fueled:SetDepletedFn(OnFuelDepleted)
    inst.components.fueled:InitializeFuelLevel(TUNING.LARGE_FUEL * 4)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.MED_FUEL

    inst._updatespells = net_event(inst.GUID, "sisters_stories._updatespells")

    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    inst:ListenForEvent("onputininventory", ToPocket)
    inst:ListenForEvent("ondropped", ToGround)

    return inst
end

return Prefab("sisters_stories", fn, assets)