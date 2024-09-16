require "prefabutil"

-- local beefalo_sewing = require ("yotb_sewing")

local assets =
{
    Asset("ANIM", "anim/yotb_beefalo_sewingmachine.zip"),
    Asset("MINIMAP_IMAGE", "yotb_sewingmachine"),
    -- Asset("ALTAS", "images/deconstruction_m.xml"),
    -- Asset("IMAGE", "images/deconstruction_m.tex"),
}

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end

    inst.components.lootdropper:DropLoot()

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/close")
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", false)
    end
end

--anim and sound callbacks
local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")
        inst.AnimState:PushAnimation("idle_open", true)

        inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/open")
        -- inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot", "snd")
    end
end

local function OnStartdisassembly(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PushAnimation("active_loop", true)
        inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/LP", "snd")
    end

    if inst.components.container ~= nil then
        inst.components.container.canbeopened = false
    end
end

local function OnDonedisassembly(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PushAnimation("active_spit")
        inst.AnimState:PushAnimation("idle", true)
        inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/stop")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/done")
    end

    if inst.components.container ~= nil then
        inst.components.container.canbeopened = true
    end
end

local function OnContinueDone(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("idle")
    end
end

local function CheckSpawnedLoot(loot)
    if loot.components.inventoryitem ~= nil then
        loot.components.inventoryitem:TryToSink()
        -- loot:Remove()
    else
        local lootx, looty, lootz = loot.Transform:GetWorldPosition()
        if ShouldEntitySink(loot, true) or TheWorld.Map:IsPointNearHole(Vector3(lootx, 0, lootz)) then
            SinkEntity(loot)
        end
    end
end

local function SpawnLootPrefab(inst, lootprefab)
    if lootprefab == nil then
        return
    end

    local loot = SpawnPrefab(lootprefab)
    if loot == nil then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()

    if loot.Physics ~= nil then
        local angle = math.random() * TWOPI
        loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))

        if inst.Physics ~= nil then
            local len = loot:GetPhysicsRadius(0) + inst:GetPhysicsRadius(0)
            x = x + math.cos(angle) * len
            z = z + math.sin(angle) * len
        end

        -- OnStartdisassembly(inst)

        loot:DoTaskInTime(1, CheckSpawnedLoot)
    end

    loot.Transform:SetPosition(x, y, z)

    loot:PushEvent("on_loot_dropped", { dropper = inst })

    return loot
end

local function onclose(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("close")
        inst.AnimState:PushAnimation("idle_closed", true)

        inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/close")
    end

    if inst.components.container ~= nil and not inst.components.container:IsEmpty() then

        OnStartdisassembly(inst)

        inst:DoTaskInTime(3, function()
            for i, k in pairs(inst.components.container.slots) do
                if k ~= nil then
                    local recipe = AllRecipes[k.prefab]
                    if recipe == nil or FunctionOrValue(recipe.no_deconstruction, inst) then
                        inst.components.container:DropItemBySlot(i)
                    else
                        local item = inst.components.container:GetItemInSlot(i)

                        local ingredient_percent =
                            ((item.components.finiteuses ~= nil and item.components.finiteuses:GetPercent()) or
                                (item.components.fueled ~= nil and item.components.inventoryitem ~= nil and item.components.fueled:GetPercent()) or
                                (item.components.armor ~= nil and item.components.inventoryitem ~= nil and item.components.armor:GetPercent()) or
                                1
                            ) / recipe.numtogive

                        for _, v in ipairs(recipe.ingredients) do
                            if string.sub(v.type, -3) ~= "gem" or string.sub(v.type, -11, -4) == "precious" then
                                --V2C: always at least one in case ingredient_percent is 0%
                                -- print("DISASSEMBLY_RATIO", TUNING.DECONSTRUCTION_M.DISASSEMBLY_RATIO)
                                local amt = v.amount == 0 and 0 or math.max(1, math.ceil(v.amount * ingredient_percent * TUNING.DECONSTRUCTION_M.DISASSEMBLY_RATIO))
                                for n = 1, amt do
                                    SpawnLootPrefab(item, v.type)
                                end
                            end
                        end

                        if item.components.inventory ~= nil then
                            item.components.inventory:DropEverything()
                        end

                        if item.components.container ~= nil then
                            item.components.container:DropEverything(nil, true)
                        end

                        if item.components.spawner ~= nil and item.components.spawner:IsOccupied() then
                            item.components.spawner:ReleaseChild()
                        end

                        if item.components.occupiable ~= nil and item.components.occupiable:IsOccupied() then
                            local items = item.components.occupiable:Harvest()
                            if items ~= nil then
                                items.Transform:SetPosition(items.Transform:GetWorldPosition())
                                items.components.inventoryitem:OnDropped()
                            end
                        end

                        if item.components.trap ~= nil then
                            item.components.trap:Harvest()
                        end

                        if item.components.dryer ~= nil then
                            item.components.dryer:DropItem()
                        end

                        if item.components.harvestable ~= nil then
                            item.components.harvestable:Harvest()
                        end

                        if item.components.stewer ~= nil then
                            item.components.stewer:Harvest()
                        end

                        if item.components.constructionsite ~= nil then
                            item.components.constructionsite:DropAllMaterials()
                        end

                        if item.components.inventoryitemholder ~= nil then
                            item.components.inventoryitemholder:TakeItem()
                        end

                        if not item.no_delete_on_deconstruct then
                            item:Remove()
                        end
                    end
                end
            end

            OnDonedisassembly(inst)
        end)
    end
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
    inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/place")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.DEFAULT] / 2) --match kit item
    MakeObstaclePhysics(inst, .5)

    inst.MiniMapEntity:SetIcon("yotb_sewingmachine.png")

    inst.Transform:SetScale(0.9, 0.9, 0.9)

    inst:AddTag("structure")
    inst:AddTag("sewingmachine")

    inst.AnimState:SetBank("beefalo_sewingmachine")
    inst.AnimState:SetBuild("yotb_beefalo_sewingmachine")
    inst.AnimState:PlayAnimation("idle")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("deconstruction_m")
        end
        return inst
    end

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("deconstruction_m")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    MakeSnowCovered(inst)
    inst:ListenForEvent("onbuilt", onbuilt)

    MakeMediumBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

return Prefab("deconstruction_m", fn, assets),
    MakePlacer("deconstruction_m_placer", "beefalo_sewingmachine", "yotb_beefalo_sewingmachine", "placer")
