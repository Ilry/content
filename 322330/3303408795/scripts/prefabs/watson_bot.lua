local easing = require("easing") -- mod 滅火

local assets =
{
    Asset("ANIM", "anim/watson_bot.zip"),
    
    Asset("ATLAS", "images/inventoryimages/watson_bot_item.xml"),
    Asset("IMAGE", "images/inventoryimages/watson_bot_item.tex"),
    
    Asset("ATLAS", "images/inventoryimages/watson_bot_item_on.xml"),
    Asset("IMAGE", "images/inventoryimages/watson_bot_item_on.tex"),
}

local scanner_prefabs = {}

local brain = require "brains/watson_botbrain"


-------------------------------------------------------------------------------------------------------------------
-- 跟隨速度
local function IsInRangeOfOwner(inst, owner)
    local DISTANCE = 2

    if inst:GetDistanceSqToInst(owner) < DISTANCE*DISTANCE then
        return true
    else
        return false
    end
end

local function OnUpdateOwnerWalkSpeedChange(inst)
    local owner = inst.components.follower ~= nil
              and inst.components.follower.leader ~= nil
              and inst.components.follower.leader.components.inventoryitem ~= nil
              and inst.components.follower.leader.components.inventoryitem:GetGrandOwner() or nil
    
    if owner and owner.components.locomotor then
        local speed = owner.components.locomotor:GetRunSpeed()
        if IsInRangeOfOwner(inst, owner) then
            inst.components.locomotor.walkspeed = speed
        else
            inst.components.locomotor.walkspeed = speed*2
        end
    end
end

--------------------------
-- 理智光環
local function aurafallofffn(inst, observer, distsq)
	return 1
end

--------------------------
-- 光源
local function ToggleLight(inst, leader, initializing)
    local robot_active_light_spell = leader._robot_active_light_spell:value()
    
    if (not initializing and robot_active_light_spell == "toggle_light_on") or (initializing and robot_active_light_spell == "toggle_light_off") then
        inst.Light:Enable(true)
        leader._robot_active_light_spell:set("toggle_light_off")
        leader:UpdateActiveSpells()
        
        inst.AnimState:Show("bottom_light")
        return true
    elseif (not initializing and robot_active_light_spell == "toggle_light_off") or (initializing and robot_active_light_spell == "toggle_light_on") then
        inst.Light:Enable(false)
        leader._robot_active_light_spell:set("toggle_light_on")
        leader:UpdateActiveSpells()
        
        inst.AnimState:Hide("bottom_light")
        return true
    end
	return false
end

--------------------------
-- 冷熱源
local function stop_all_heater_fx(inst)
    if inst.heater_fx_task ~= nil then
        inst.heater_fx_task:Cancel()
        inst.heater_fx_task = nil
    end
end

local function start_heater_hot_fx(inst)
    stop_all_heater_fx(inst)
    
    inst.heater_fx_task = inst:DoPeriodicTask(0.26, function()
        local fx = SpawnPrefab("dr_warmer_loop")
        fx.entity:AddFollower()
        fx.Follower:FollowSymbol(inst.GUID, "propeller", 0, 0, 0)
    end, 0)
end

local function start_heater_cold_fx(inst)
    stop_all_heater_fx(inst)
    
    inst.heater_fx_task = inst:DoPeriodicTask(2, function()
        local fx = SpawnPrefab("crab_king_icefx")
        fx.Transform:SetScale(0.5, 0.5, 0.5)
        fx.entity:AddFollower()
        fx.Follower:FollowSymbol(inst.GUID, "body", 0, 0, 0)
    end, 0)
end

local function ChangeHeaterMode(inst, leader, initializing)
    local robot_active_heater_spell = leader._robot_active_heater_spell:value()
    
    if (not initializing and robot_active_heater_spell == "change_heater_hot") or (initializing and robot_active_heater_spell == "change_heater_cold") then
        inst.components.heater.heat = 60
        inst.components.heater:SetThermics(true, false)
        leader._robot_active_heater_spell:set("change_heater_cold")
        leader:UpdateActiveSpells()
        
        start_heater_hot_fx(inst)
        return true
    elseif (not initializing and robot_active_heater_spell == "change_heater_cold") or (initializing and robot_active_heater_spell == "change_heater_neutral") then
        inst.components.heater.heat = 10
        inst.components.heater:SetThermics(false, true)
        leader._robot_active_heater_spell:set("change_heater_neutral")
        leader:UpdateActiveSpells()
        
        start_heater_cold_fx(inst)
        return true
    elseif (not initializing and robot_active_heater_spell == "change_heater_neutral") or (initializing and robot_active_heater_spell == "change_heater_hot") then
        inst.components.heater:SetThermics(false, false)
        leader._robot_active_heater_spell:set("change_heater_hot")
        leader:UpdateActiveSpells()
        
        stop_all_heater_fx(inst)
        return true
    end
    return false
end

--[[
local function OnSeasonChange(inst, season)
    if season == "winter" then
        inst.components.heater.heat = 60
        inst.components.heater:SetThermics(true, false)
    elseif season == "summer" then
        inst.components.heater.heat = 10
        inst.components.heater:SetThermics(false, true)
    else
        inst.components.heater:SetThermics(false, false)
    end
end
]]

--------------------------
-- 開關雪球機 --
local function toggle_snowball_on_fx(inst, name)
    local fx = SpawnPrefab(name)
    fx.entity:AddFollower()
    fx.Follower:FollowSymbol(inst.GUID, "body", 0, 0, 0)
    fx.Transform:SetScale(0.8, 0.8, 0.8)
end

local function ToggleSnowball(inst, leader, initializing)
    local robot_active_snowball_spell = leader._robot_active_snowball_spell:value()
    
    if (not initializing and robot_active_snowball_spell == "toggle_snowball_on") or (initializing and robot_active_snowball_spell == "toggle_snowball_off") then
        inst.components.firedetector:Activate()
        leader._robot_active_snowball_spell:set("toggle_snowball_off")
        leader:UpdateActiveSpells()

        inst.AnimState:Show("top_light")
        toggle_snowball_on_fx(inst, "wagpunksteam_armor_down")
        toggle_snowball_on_fx(inst, "wagpunksteam_armor_up")
        return true
    elseif (not initializing and robot_active_snowball_spell == "toggle_snowball_off") or (initializing and robot_active_snowball_spell == "toggle_snowball_on") then
        inst.components.firedetector:Deactivate()
        leader._robot_active_snowball_spell:set("toggle_snowball_on")
        leader:UpdateActiveSpells()
        
        inst.AnimState:Hide("top_light")
        return true
    end
	return false
end

-- 雪球機滅火功能 --
local function SpreadProtectionAtPoint(inst, fire_pos) 
    inst.components.wateryprotection:SpreadProtectionAtPoint(fire_pos:Get())
end

local function OnFindFire(inst, fire_pos)
    if inst:IsAsleep() then
        inst:DoTaskInTime(1 + math.random(), SpreadProtectionAtPoint, fire_pos)
    else
        inst:PushEvent("putoutfire", {fire_pos = fire_pos})
    end
end

local MAX_SPIT_RANGE_SQ = TUNING.OCEANFISH.SPRINKLER_DETECT_RANGE * TUNING.OCEANFISH.SPRINKLER_DETECT_RANGE
local SPIT_SPEED_BASE = 5
local SPIT_SPEED_ADD = 7
local function LaunchProjectile(inst, target_position)
    local x, y, z = inst.Transform:GetWorldPosition()

    local projectile = SpawnPrefab("snowball")
    projectile.Transform:SetPosition(x, y, z)

    local dx, dz = target_position.x - x, target_position.z - z
    local range_sq = (dx * dx) + (dz * dz)
    local speed = easing.linear(range_sq, SPIT_SPEED_BASE, SPIT_SPEED_ADD, MAX_SPIT_RANGE_SQ)

    projectile.components.complexprojectile:SetHorizontalSpeed(speed)
    projectile.components.complexprojectile:SetLaunchOffset(Vector3(1.0, 2.85, 0))
    projectile.components.complexprojectile:SetGravity(-16)
    projectile.components.complexprojectile:Launch(target_position, inst, inst)
end

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

local function start_looping_sound(inst)
    inst.SoundEmitter:PlaySound("WX_rework/scanner/movement_lp", "movement_lp")
end

local function stop_looping_sound(inst)
    inst.SoundEmitter:KillSound("movement_lp")
end

-------------------------------------------------------------------------------------------------------------------

local function scannerfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    --inst.entity:AddMiniMapEntity()
    inst.entity:AddLight()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

    MakeTinyFlyingCharacterPhysics(inst, 1, 0.5)

    inst.Transform:SetFourFaced()

    --inst.MiniMapEntity:SetIcon("wx78_scanner_item.png")
    --inst.MiniMapEntity:SetCanUseCache(false)

    inst.DynamicShadow:SetSize(1.2, 0.75)

    inst:AddTag("companion")
    inst:AddTag("NOBLOCK")
    inst:AddTag("scarytoprey")
    
    --HASHEATER (from heater component) added to pristine state for optimization
    inst:AddTag("HASHEATER")
    
    inst:AddTag("watson_bot")

    inst.AnimState:SetBank("scanner")
    inst.AnimState:SetBuild("watson_bot")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:Hide("top_light")
    --inst.AnimState:Hide("bottom_light")
    
    inst.Light:SetFalloff(0.5)
    inst.Light:SetIntensity(.8)
    inst.Light:SetRadius(4)
    inst.Light:SetColour(180 / 255, 195 / 255, 150 / 255)

    --MakeInventoryFloatable(inst, nil, 0.15, ITEM_FLOATER_SCALE)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        --[[
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("hutch") -- 似乎是因為mod使用遊戲本體定義的容器，才需要額外加這段客戶端(replica)的。若是在mod程式裡有自定義的容器，測試起來是不用加這段的樣子。
        end
        ]]
        return inst
    end

    -------------------------------------------------------------------
    inst:AddComponent("entitytracker")

    -------------------------------------------------------------------
    inst:AddComponent("follower")

    -------------------------------------------------------------------
    inst:AddComponent("inspectable")

    -------------------------------------------------------------------
    inst:AddComponent("locomotor")
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)
    inst.components.locomotor.pathcaps = { allowocean = true, ignorecreep = true }
    inst.components.locomotor.walkspeed = 6

    -------------------------------------------------------------------
    inst:AddComponent("updatelooper")
    inst.components.updatelooper:AddOnUpdateFn(OnUpdateOwnerWalkSpeedChange)

    -------------------------------------------------------------------
    inst:ListenForEvent("onremove", stop_looping_sound)

    -------------------------------------------------------------------
    inst.startloopingsound = start_looping_sound
    inst.stoploopingsound = stop_looping_sound
    inst:startloopingsound()

    -------------------------------------------------------------------
    inst:SetStateGraph("SGwatson_bot")
    inst:SetBrain(brain)

    -------------------------------------------------------------------
    MakeHauntable(inst)

    -------------------------------------------------------------------
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 0.25 -- 15 per min
    inst.components.sanityaura.max_distsq = 49
    inst.components.sanityaura.fallofffn = aurafallofffn
    
    -------------------------------------------------------------------
    
    inst:AddComponent("heater")
    
    --inst:WatchWorldState("season", OnSeasonChange)
    --OnSeasonChange(inst, TheWorld.state.season)
    
    -------------------------------------------------------------------
    
    local firedetector = inst:AddComponent("firedetector")
    firedetector:SetOnFindFireFn(OnFindFire)
    firedetector.range = TUNING.OCEANFISH.SPRINKLER_DETECT_RANGE -- 7
    firedetector.detectPeriod = TUNING.OCEANFISH.SPRINKLER_DETECT_PERIOD -- 4
    firedetector.fireOnly = true
    firedetector:Activate(true)

    local wateryprotection = inst:AddComponent("wateryprotection")
    wateryprotection.extinguishheatpercent = TUNING.FIRESUPPRESSOR_EXTINGUISH_HEAT_PERCENT
    wateryprotection.temperaturereduction = TUNING.FIRESUPPRESSOR_TEMP_REDUCTION
    wateryprotection.witherprotectiontime = TUNING.FIRESUPPRESSOR_PROTECTION_TIME
    wateryprotection.addcoldness = TUNING.FIRESUPPRESSOR_ADD_COLDNESS
    wateryprotection:AddIgnoreTag("player")

    inst.LaunchProjectile = LaunchProjectile

    -------------------------------------------------------------------
    
    inst:AddComponent("container")
    --inst.components.container:WidgetSetup("hutch") --本來設定成 "hutch"，所以才有上面 OnEntityReplicated 的筆記
    inst.components.container:WidgetSetup("watson_bot")
    --inst.components.container.onopenfn = OnOpen
    --inst.components.container.onclosefn = OnClose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    
    -------------------------------------------------------------------
    
    inst.ToggleLight = ToggleLight
    inst.ChangeHeaterMode = ChangeHeaterMode
    inst.ToggleSnowball = ToggleSnowball
    
        -------------------------------------------------------------------

    return inst
end

return Prefab("watson_bot", scannerfn, assets, scanner_prefabs)