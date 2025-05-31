
-------------------------------------------------------------------------------------------
---[[万物百宝]]
-------------------------------------------------------------------------------------------
local assets =
{
	Asset("ANIM", "anim/tc_chest.zip"),
    Asset("ANIM", "anim/ui_tc_chest_10x15.zip"),
    Asset("ATLAS", "images/inventoryimages/tc_chest.xml"),
    Asset("IMAGE", "images/inventoryimages/tc_chest.tex"),
    Asset("SOUND", "sound/tc_chest_bank.fsb"),
    Asset("SOUNDPACKAGE", "sound/tc_chest.fev")
}

local SOUNDS = {
    open  = "wickerbottom_rework/book_spells/tentacles",
    close = "wickerbottom_rework/book_spells/tentacles",
    built = "wickerbottom_rework/book_spells/tentacles",
}

local function onopen(inst)
    -- inst.AnimState:PlayAnimation("open")

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil and skin_build == "tc_chest_moon" then
        inst.AnimState:PlayAnimation("preopen")
        inst.AnimState:PushAnimation("open", true)

        -- inst:DoTaskInTime(0  , function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-004") end)
        -- inst:DoTaskInTime(0.1, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-003") end)
        -- inst:DoTaskInTime(0.3, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-002") end)
        -- inst:DoTaskInTime(0.8, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-001") end)

        inst:DoTaskInTime(0, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.1, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.2, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.3, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
    end

    if skin_build == nil then
        inst.SoundEmitter:PlaySound(inst.sounds.open)
    end
end

local function onclose(inst)
    -- inst.AnimState:PlayAnimation("close")
    -- inst.AnimState:PushAnimation("closed", false)

    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil and skin_build == "tc_chest_moon" then
        inst.AnimState:PlayAnimation("pstopen")
        inst.AnimState:PushAnimation("idle", true)
        -- inst:DoTaskInTime(0  , function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-001") end)
        -- inst:DoTaskInTime(0.5, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-002") end)
        -- inst:DoTaskInTime(0.7, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-003") end)
        -- inst:DoTaskInTime(0.8, function() inst.SoundEmitter:PlaySound("tc_chest/tc_chest/aqol_gem_pickup_-004") end)

        inst:DoTaskInTime(0, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.1, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.2, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
        inst:DoTaskInTime(0.3, function() inst.SoundEmitter:PlaySound(PICKUPSOUNDS.gem) end)
    end
    if skin_build == nil then
        inst.SoundEmitter:PlaySound(inst.sounds.close)
    end
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local right = inst.components.entitytracker:GetEntity("right")
    if right ~= nil then
        if right.components.container ~= nil then
            right.components.container:DropEverything()
        end
        right:Remove()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
        inst.components.container:Close()
    end

    local skin_build = inst:GetSkinBuild()
    if skin_build == nil then
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", false)
    end
end

local function onbuilt(inst)
    -- inst.AnimState:PlayAnimation("place")
    -- inst.AnimState:PushAnimation("closed", false)
    inst.SoundEmitter:PlaySound(inst.sounds.built)
end

local RUBBISH_LIST = {
    crumbs = true,
}

local RUBBISH_TAG_LIST = {
    "pre-preparedfood",
    "halloweencandy",
    "winter_ornament",
    "cattoy",
    "fertilizerresearchable"
}

local function EntHasRubbishTag(ent)
    for tag in pairs(RUBBISH_TAG_LIST) do
        if ent:HasTag(tag) then
            return true
        end
    end
    return false
end

local function DoCollect(inst)
    for _, ent in pairs(Ents) do
        if ent.components.inventoryitem ~= nil and
            ent.components.inventoryitem.owner == nil and
            (inst.components.container:Has(ent.prefab, 1) or
            (RUBBISH_LIST[ent.prefab] or EntHasRubbishTag(ent)) and (RUBBISH_LIST[inst.prefab] or EntHasRubbishTag(inst)))
        then
            inst.components.container:GiveItem(ent)
        end
    end
end

local function DoWater(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ent_range = TUNING.TC_CHEST_AUTO_WATER_RANGE / 2 * 4
    local tile_range = math.floor(TUNING.TC_CHEST_AUTO_WATER_RANGE / 2 * 4)
    -- 地皮浇水施肥
    for k1 = - tile_range, tile_range, 4 do
        for k2 = - tile_range, tile_range, 4 do
            local tile = TheWorld.Map:GetTileAtPoint(x + k1, 0, z + k2)
            if tile == GROUND.FARMING_SOIL then
                TheWorld.components.farming_manager:AddSoilMoistureAtPoint(x + k1, y, z + k2, 100)
                local tile_x, tile_z = TheWorld.Map:GetTileCoordsAtPoint(x + k1, y, z + k2)
                -- 肥料最大就是100
                TheWorld.components.farming_manager:AddTileNutrients(tile_x, tile_z, 100, 100, 100)
            end
        end
    end
    -- 实体浇水施肥
    local ents = TheSim:FindEntities(x, y, z, ent_range, nil, { "INLIMBO", "NOCLICK" }, { "witherable", "barren", "crop2_legion", "needwater2", "neednutrient2", "vase" })
    for _, ent in pairs(ents) do
        -- 浇水
        if ent.components.witherable ~= nil then
            -- 如果植物可以枯萎或复苏
            if not ent.components.witherable:IsProtected() and (ent.components.witherable:CanWither() or ent.components.witherable:CanRejuvenate()) then
                ent.components.witherable:Protect(TUNING.FIRESUPPRESSOR_PROTECTION_TIME)
            end
        elseif ent.components.moisture ~= nil then
            -- 如果植物有湿度组件
            ent.components.moisture:DoDelta(ent.components.moisture:GetMaxMoisture(), true)
        end
        -- 施肥
        if ent.components.pickable ~= nil and ent.components.pickable:CanBeFertilized() then
            local poop = SpawnPrefab("poop")
            if poop ~= nil then
                ent.components.pickable:Fertilize(poop, nil)
                poop:Remove()
            end
        end
    end
end

local function DoGrowth(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ent_range = TUNING.TC_CHEST_AUTO_WATER_RANGE / 2 * 4
    local ents = TheSim:FindEntities(x, y, z, ent_range, nil, { "NOCLICK" }, { "farm_plant", "farmplantstress", "tendable_farmplant", "plant", "lichen", "oceanvine", "mushroom_farm", "kelp" })
    for _, ent in ipairs(ents) do
        -- 照料
        if ent.components.farmplanttendable ~= nil then
            ent.components.farmplanttendable:TendTo(inst)
            local fx = SpawnPrefab("farm_plant_happy")
            if fx ~= nil then
                fx.Transform:SetPosition(x, y, z)
            end
        end

        if ent.components.growable ~= nil then
            local candogrowth = true
            if ent.components.growable.stages ~= nil and #ent.components.growable.stages > 2 then
                if ent.components.growable.stage >= #ent.components.growable.stages - 1 then
                    candogrowth = false
                end
            end
            if candogrowth then
                if ent.components.growable.domagicgrowthfn ~= nil and string.find(ent.prefab, "legion") then
                    ent.magic_growth_delay = 2
                    ent.components.growable:DoMagicGrowth()
                else
                    ent.components.growable:DoGrowth()
                end
            end
        end
        if ent.components.crop ~= nil and (ent.components.crop.rate or 0) > 0 then
            ent.components.crop:DoGrow(1 / ent.components.crop.rate, true)
        end
        if ent.components.harvestable ~= nil and ent.components.harvestable:CanBeHarvested() and ent:HasTag("mushroom_farm") then
            if ent.components.harvestable:IsMagicGrowable() then
                ent.components.harvestable:DoMagicGrowth()
            else
                ent.components.harvestable:Grow()
            end
        end
    end
end

local function MakeFull(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ent_range = TUNING.TC_CHEST_AUTO_WATER_RANGE / 2 * 4
    local ents = TheSim:FindEntities(x, y, z, ent_range, nil, { "INLIMBO", "NOCLICK" })
    for _, ent in ipairs(ents) do
        if ent.components.pickable ~= nil and not ent.components.pickable.canbepicked then
            ent.components.pickable:Regen()
        end
    end
end

local function IsLunarThrallPlant(ent)
    return  ent.prefab == "lunarthrall_plant" or
            ent.prefab == "lunarthrall_plant_back" or
            ent.prefab == "lunarthrall_plant_vine" or
            ent.prefab == "lunarthrall_plant_vine_end"
end

local function DoKill(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ent_range = TUNING.TC_CHEST_AUTO_WATER_RANGE / 2 * 4
    local ents = TheSim:FindEntities(x, y, z, ent_range, nil, { "INLIMBO", "NOCLICK" }, {"lunarthrall_plant", "lunarthrall_plant_end"})
    for _, ent in ipairs(ents) do
        if ent.components.health ~= nil and IsLunarThrallPlant(ent) then
            ent.components.health:Kill()
        end
    end
end

local function HasGem(container, gem)
    for i = 6, 10 do
        if container.components.container.slots[i] ~= nil and container.components.container.slots[i].prefab == gem then
            return true
        end
    end
end

local function OnItemChanged(inst, right)
    if right == nil then
        return
    end
    local dorepair = true
    if inst._control:value() then
        -- 纯粹辉煌*5恢复耐久
        for i = 1, 5 do
            local item = right.components.container.slots[i]
            if item == nil or item.prefab ~= "purebrilliance" then
                dorepair = false
                break
            end
        end
        if dorepair then
            inst.repair_tasks = inst.repair_tasks or {}
            for i = 1, inst.components.container.numslots do
                local item = inst.components.container.slots[i]
                if item ~= nil then
                    if inst.repair_tasks[i] == nil and item.components.tcrepairable ~= nil then
                        inst.repair_tasks[i] = inst:DoPeriodicTask(TUNING.TC_CHEST_REPAIR_INTERVAL, function()
                            item.components.tcrepairable:Repair()
                            item.components.tcrepairable:UpgradeStatus()
                        end)
                    end
                elseif inst.repair_tasks[i] ~= nil then
                    inst.repair_tasks[i]:Cancel()
                    inst.repair_tasks[i] = nil
                end
            end
        end

        -- 橙宝石*1自动收集
        if HasGem(right, "orangegem") then
            if inst.collect_task ~= nil then
                inst.collect_task:Cancel()
            end
            inst.collect_task = inst:DoPeriodicTask(TUNING.TC_CHEST_AUTO_COLLECT_INTERVAL, function()
                inst:DoCollect()
            end)
        end

        -- 绿宝石*1养分水分
        if HasGem(right, "greengem") then
            --inst:DoWater()
            if inst.water_task == nil then
                if not inst.components.timer:TimerExists("water_task") then
                    inst.components.timer:StartTimer("water_task", TUNING.TC_CHEST_AUTO_WATER_INTERVAL)
                    inst:DoWater()
                end
                inst.water_task = inst:DoPeriodicTask(TUNING.TC_CHEST_AUTO_WATER_INTERVAL, function()
                    inst:DoWater()
                end)
            end
        end

        -- 黄宝石*1对话催熟
        if HasGem(right, "yellowgem") then
            --inst:DoGrowth()
            if inst.growth_task == nil then
                print("DoGrowth")
                if not inst.components.timer:TimerExists("growth_task") then
                    print("直接催熟")
                    inst.components.timer:StartTimer("growth_task", TUNING.TC_CHEST_AUTO_GROWTH_INTERVAL)
                    inst:DoGrowth()
                end
                inst.growth_task = inst:DoPeriodicTask(TUNING.TC_CHEST_AUTO_GROWTH_INTERVAL, function()
                    print("催熟任务")
                    inst:DoGrowth()
                end)
            end
        end

        -- 蓝宝石*1催熟灌木
        if HasGem(right, "bluegem") then
            --inst:MakeFull()
            if inst.full_task == nil then
                if not inst.components.timer:TimerExists("full_task") then
                    inst.components.timer:StartTimer("full_task", TUNING.TC_CHEST_AUTO_GROWTH_INTERVAL)
                    inst:MakeFull()
                end
                inst.full_task = inst:DoPeriodicTask(TUNING.TC_CHEST_AUTO_GROWTH_INTERVAL, function()
                    inst:MakeFull()
                end)
            end
        end

        -- 紫宝石*1秒杀亮茄
        if HasGem(right, "purplegem") and inst._switch:value() then
            inst:DoKill()
            if inst.kill_task == nil then
                inst.kill_task = inst:DoPeriodicTask(TUNING.TC_CHEST_AUTO_KILL_INTERVAL, function()
                    inst:DoKill()
                end)
            end
        end
    end

    -- 取消不满足条件的任务
    if not inst._control:value() or not dorepair then
        if inst.repair_tasks ~= nil then
            for i, task in pairs(inst.repair_tasks) do
                if task ~= nil then
                    task:Cancel()
                    inst.repair_tasks[i] = nil
                end
            end
        end
    end
    if not inst._control:value() or not HasGem(right, "greengem") then
        if inst.water_task ~= nil then
            inst.water_task:Cancel()
            inst.water_task = nil
        end
    end
    if not inst._control:value() or not HasGem(right, "orangegem") then
        if inst.collect_task ~= nil then
            inst.collect_task:Cancel()
            inst.collect_task = nil
        end
    end
    if not inst._control:value() or not HasGem(right, "yellowgem") then
        if inst.growth_task ~= nil then
            inst.growth_task:Cancel()
            inst.growth_task = nil
        end
    end
    if not inst._control:value() or not HasGem(right, "bluegem") then
        if inst.full_task ~= nil then
            inst.full_task:Cancel()
            inst.full_task = nil
        end
    end
    if not inst._control:value() or not HasGem(right, "purplegem") or not inst._switch:value() then
        if inst.kill_task ~= nil then
            inst.kill_task:Cancel()
            inst.kill_task = nil
        end
    end
end

local function TrackRight(inst)
    if inst.components.entitytracker:GetEntity("right") == nil then
        local right = SpawnPrefab("tc_chest_right")
        right.Transform:SetPosition(inst.Transform:GetWorldPosition())
        -- right.entity:SetParent(inst.entity)
        inst.components.entitytracker:TrackEntity("right", right)
    end

    local right = inst.components.entitytracker:GetEntity("right")
    local function OnItemChanged_Prox()
        OnItemChanged(inst, right)
    end
    inst:ListenForEvent("itemget", OnItemChanged_Prox, right)
    inst:ListenForEvent("itemlose", OnItemChanged_Prox, right)
    inst:ListenForEvent("itemget", OnItemChanged_Prox)
    inst:ListenForEvent("itemlose", OnItemChanged_Prox)
end

local function OnIsNight(inst)
    if not TheWorld.state.isnight or not ((TheWorld.state.cycles + 1) % 11 == 0) then
        return
    end

    local container = inst.components.container
    local cangive = true
    for i = 1, container.numslots do
        local item = container.slots[i]
        if item == nil or item.prefab ~= "goldnugget" then
            cangive = false
            break
        end
    end
    if cangive then
        local loots = {"redgem", "bluegem", "greengem", "yellowgem", "purplegem", "orangegem"}
        for _, loot in ipairs(loots) do
            inst.components.lootdropper:SpawnLootPrefab(loot, inst:GetPosition())
        end
    end
end

local function OnIsDay(inst)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        if not TheWorld.state.isday then
            inst.AnimState:SetBuild("tc_chest_moon_yellow")
        else
            inst.AnimState:SetBuild("tc_chest_moon")
        end
    else
        inst.AnimState:ClearOverrideSymbol("chest")
    end
end

local function OnLoadPostPass(inst)
    TrackRight(inst)
end

local CIRCLE_RADIUS_SCALE = 1896 / 150 / 2
local PLACER_SCALE = TUNING.TC_CHEST_AUTO_WATER_RANGE * 2 / CIRCLE_RADIUS_SCALE

local function OnEnableHelper(inst, enabled)
    if enabled then
        if inst.helper == nil then
            inst.helper = CreateEntity()

            --[[Non-networked entity]]
            inst.helper.entity:SetCanSleep(false)
            inst.helper.persists = false

            inst.helper.entity:AddTransform()
            inst.helper.entity:AddAnimState()

            inst.helper:AddTag("CLASSIFIED")
            inst.helper:AddTag("NOCLICK")
            inst.helper:AddTag("placer")

            -- inst.helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

            inst.helper.AnimState:SetBank("firefighter_placement")
            inst.helper.AnimState:SetBuild("firefighter_placement")
            inst.helper.AnimState:PlayAnimation("idle")
            inst.helper.AnimState:SetLightOverride(1)
            inst.helper.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
            inst.helper.AnimState:SetLayer(LAYER_BACKGROUND)
            inst.helper.AnimState:SetSortOrder(1)
            inst.helper.AnimState:SetAddColour(0, .2, .5, 0)
            inst.helper.AnimState:SetScale(PLACER_SCALE, PLACER_SCALE)

            inst.helper.entity:SetParent(inst.entity)
        end
    elseif inst.helper ~= nil then
        inst.helper:Remove()
        inst.helper = nil
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("tc_chest.tex")

    inst:AddTag("structure")
    inst:AddTag("chest")

    inst.AnimState:SetBank("tc_chest")
    inst.AnimState:SetBuild("tc_chest")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("tc_chest")
    inst:AddTag("chest")

    inst._control = net_bool(inst.GUID, "tc_chest_control", "control_dirty")
    inst._switch = net_bool(inst.GUID, "tc_chest_switch", "switch_dirty")

    -- inst:SetDeploySmartRadius(0.5) --recipe min_spacing/2

    if not TheNet:IsDedicated() then
        inst:AddComponent("deployhelper")
        inst.components.deployhelper.onenablehelper = OnEnableHelper
    end

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	inst.OnSave = function(inst, data)
        data.control = inst._control:value()
        data.switch = inst._switch:value()
    end
	inst.OnLoad = function(inst, data)
        if data then
            inst._control:set(data.control or false)
            inst._switch:set(data.switch or false)
        end
    end
    inst.sounds = SOUNDS

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("tc_chest")
    inst.components.container:EnableInfiniteStackSize(true)
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(TUNING.TC_CHEST_PREFRESH_RATE_MULI)

    inst:AddComponent("lootdropper")

    if TUNING.TC_CHEST_HARMMERABLE then
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)
    end

    inst:AddComponent("timer")

    inst:AddComponent("entitytracker")
    inst:DoTaskInTime(FRAMES * 10, TrackRight)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:ListenForEvent("onbuilt", onbuilt)
    local function OnItemChanged_Prox()
        OnItemChanged(inst, inst.components.entitytracker:GetEntity("right"))
    end
    inst:ListenForEvent("control_dirty", OnItemChanged_Prox)
    inst:ListenForEvent("switch_dirty", OnItemChanged_Prox)

    inst:WatchWorldState("isnight", OnIsNight)
    inst:WatchWorldState("isday", OnIsDay)
    inst:DoTaskInTime(FRAMES * 10, OnIsDay)
    inst:ListenForEvent("reskinned", OnIsDay)

    inst.DoCollect = DoCollect
    inst.DoWater = DoWater
    inst.DoGrowth = DoGrowth
    inst.MakeFull = MakeFull
    inst.DoKill = DoKill

    inst.OnLoadPostPass = OnLoadPostPass

    return inst
end

-------------------------------------------------------------------------------------------
---[[右侧栏]]
-------------------------------------------------------------------------------------------
local function right_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    inst:AddTag("chest")
    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("tc_chest_right")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    return inst
end

-------------------------------------------------------------------------------------------
---[[放置器]]
-------------------------------------------------------------------------------------------
local function placer_postinit_fn(inst)
    local placer2 = CreateEntity()

    --[[Non-networked entity]]
    placer2.entity:SetCanSleep(false)
    placer2.persists = false

    placer2.entity:AddTransform()
    placer2.entity:AddAnimState()

    placer2:AddTag("CLASSIFIED")
    placer2:AddTag("NOCLICK")
    placer2:AddTag("placer")

    local s = 1 / PLACER_SCALE
    -- placer2.Transform:SetScale(s, s, s)

    placer2.AnimState:SetBank("firefighter_placement")
    placer2.AnimState:SetBuild("firefighter_placement")
    placer2.AnimState:PlayAnimation("idle")
    placer2.AnimState:SetLightOverride(1)
    placer2.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    placer2.AnimState:SetLayer(LAYER_BACKGROUND)
    placer2.AnimState:SetSortOrder(1)
    placer2.AnimState:SetAddColour(0, .2, .5, 0)
    placer2.AnimState:SetScale(PLACER_SCALE, PLACER_SCALE)

    placer2.entity:SetParent(inst.entity)

    inst.components.placer:LinkEntity(placer2)
end

return  Prefab("tc_chest", fn, assets),
        MakePlacer("tc_chest_placer", "tc_chest", "tc_chest", "idle", false, nil, nil, nil, nil, nil, placer_postinit_fn),
        Prefab("tc_chest_right", right_fn)