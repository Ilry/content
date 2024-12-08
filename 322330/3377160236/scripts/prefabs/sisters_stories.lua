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
            else
                doer.components.talker:Say(STRINGS.WENDY_READ_SISTERS_STORIES_WITHOUT_ABIGAIL)
            end
        end
    end
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

-- 最终的法术表
local BASESPELLS = {
    {
        label = STRINGS.WENDY_SPELL.SWEET_MEMORY,
        atlas = "images/spell_icons/sweet_memory.xml",
        normal = "sweet_memory.tex",
        execute = function(inst)
            SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "sweet_memory", inst)
        end,
        widget_scale = ICON_SCALE,
        hit_radius = ICON_RADIUS
    },
    {
        label = STRINGS.WENDY_SPELL.CASTLING,
        atlas = "images/spell_icons/castling.xml",
        normal = "castling.tex",
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
        widget_scale = ICON_SCALE,
        hit_radius = ICON_RADIUS
    },
    {
        label = STRINGS.WENDY_SPELL.SAME_HEART,
        atlas = "images/spell_icons/same_heart.xml",
        normal = "same_heart.tex",
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
        widget_scale = ICON_SCALE,
        hit_radius = ICON_RADIUS
    },
    {
        label = STRINGS.WENDY_SPELL.SMALL_CONTRADICTION,
        atlas = "images/spell_icons/small_contradiction.xml",
        normal = "small_contradiction.tex",
        execute = function(inst)
            SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "small_contradiction", inst)
        end,
        widget_scale = ICON_SCALE,
        hit_radius = ICON_RADIUS,
    }
}

local Moon_Spell = {
    label = STRINGS.WENDY_SPELL.MOON_ESSENCE,
    atlas = "images/spell_icons/moon_essence.xml",
    normal = "moon_essence.tex",
    execute = function(inst)
        SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "moon_essence", inst)
    end,
    widget_scale = ICON_SCALE,
    hit_radius = ICON_RADIUS
}

local Shadow_Spell = {
    label = STRINGS.WENDY_SPELL.SHADOW_PRESENT,
    atlas = "images/spell_icons/shadow_present.xml",
    normal = "shadow_present.tex",
    execute = function(inst)
        SendModRPCToServer(MOD_RPC["wendy"]["read_sisters_stories"], "shadow_present", inst)
    end,
    widget_scale = ICON_SCALE,
    hit_radius = ICON_RADIUS
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
    local moon = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_moon_abigail")
    local shadow = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_shadow_abigail")

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
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetAllowWaterFn
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