local assets =
{
    Asset("ANIM", "anim/moonglass_bigwaterfall_steam.zip"),
    Asset("ANIM", "anim/moonglasspool_tile.zip"),
    
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
}

local prefabs =
{
    "grotto_moonglass_1",
    "grotto_moonglass_3",
    "grotto_moonglass_4",
    "grotto_waterfall_big",
    "grottopool_sfx",
}

local prefab_layout =
{
    {name = "grotto_waterfall_big",   x = 0,      z = 0},
    {name = "grotto_moonglass_1",     x = 1.15,   z = -2.77},
    {name = "grotto_moonglass_3",     x = -1.15,  z = 2.77},
    {name = "grotto_moonglass_4",     x = 2.49,   z = 1.16},
    {name = "grotto_moonglass_4",     x = -2.49,  z = -1.16},
}

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function setup_children(inst)
    inst._children = inst._children or {}

    local ix, iy, iz = inst.Transform:GetWorldPosition()
    for i, child_data in ipairs(prefab_layout) do
        if inst._children[i] == nil then
            local p = SpawnPrefab(child_data.name)
            p.Transform:SetPosition(ix + child_data.x, iy, iz + child_data.z)

            inst._children[i] = p
        end

        if inst._children[i] ~= nil then
            inst._children[i]:ListenForEvent("onremove", function() inst._children[i] = nil end)
        end
    end
end

local function register_pool(inst)
    TheWorld:PushEvent("ms_registergrottopool", {pool = inst, small = false})
end

local function on_save(inst, data)
    data.children_ids = {}
    if inst._children ~= nil then
        data.children_indexes = {}
        for i=1, #prefab_layout do
            local child = inst._children[i]
            if child ~= nil then
                table.insert(data.children_ids, child.GUID)
                table.insert(data.children_indexes, i)
            end
        end
    end
    return data.children_ids
end

local function on_load_postpass(inst, newents, data)
    if data ~= nil and data.children_ids ~= nil and data.children_indexes ~= nil then
        inst._children = {}
        for id_ix, child_id in ipairs(data.children_ids) do
            local child = newents[child_id]
            if child ~= nil then
                local ix = data.children_indexes[id_ix]
                inst._children[ix] = child.entity
            end
        end
    end
end

local function on_removed(inst)
    if inst._children ~= nil then
        for i = #prefab_layout, 1, -1 do
            local c = inst._children[i]
            if c ~= nil and c:IsValid() then
                c:Remove()
            end
        end
    end
end

local function makebigmist(proxy)
    if not proxy then
        return nil
    end

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    local parent = proxy.entity:GetParent()
    if parent ~= nil then
        inst.entity:SetParent(parent.entity)
    end

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.Transform:SetFromProxy(proxy.GUID)

    inst.AnimState:SetBuild("moonglass_bigwaterfall_steam")
    inst.AnimState:SetBank("moonglass_bigwaterfall_steam")
    inst.AnimState:PlayAnimation("steam_big", true)
    inst.AnimState:SetLightOverride(0.5)

    proxy:ListenForEvent("onremove", function() inst:Remove() end)

    return inst
end

local COLOUR_R, COLOUR_G, COLOUR_B = 227/255, 227/255, 227/255
local function poolfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, makebigmist)
    end

    MakeObstaclePhysics(inst, TUNING.GROTTO_POOL_BIG_RADIUS)

    inst.AnimState:SetBuild("moonglasspool_tile")
    inst.AnimState:SetBank("moonglasspool_tile")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    inst.AnimState:SetLightOverride(0.25)

    inst.MiniMapEntity:SetIcon("grotto_pool_big.png")

    inst.Light:SetColour(COLOUR_R, COLOUR_G, COLOUR_B)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(0.9)

    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    inst:AddTag("watersource")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)
	
	inst:SetPrefabNameOverride("grotto_pool_big")

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, register_pool)
    end

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("watersource")

	inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)

    inst:ListenForEvent("onremove", on_removed)
	
	if TheNet:IsDedicated() then
		inst:DoTaskInTime(0, setup_children)	
	else
		inst:DoTaskInTime(0, setup_children)
	end

    inst.OnSave = on_save
    inst.OnLoadPostPass = on_load_postpass

    return inst
end

local function poolfn2()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    MakeObstaclePhysics(inst, TUNING.GROTTO_POOL_BIG_RADIUS)

    inst.AnimState:SetBuild("moonglasspool_tile")
    inst.AnimState:SetBank("moonglasspool_tile")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)
    inst.AnimState:SetLightOverride(0.25)

    inst.MiniMapEntity:SetIcon("grotto_pool_big.png")

    inst.Light:SetColour(COLOUR_R, COLOUR_G, COLOUR_B)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetFalloff(0.6)
    inst.Light:SetRadius(0.9)

    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")
    inst:AddTag("watersource")

    inst.no_wet_prefix = true

    inst:SetDeployExtraSpacing(2)
	
	inst:SetPrefabNameOverride("grotto_pool_big")

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, register_pool)
    end

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("watersource")

	inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)

    inst:ListenForEvent("onremove", on_removed)

    inst.OnSave = on_save
    inst.OnLoadPostPass = on_load_postpass

    return inst
end

return Prefab("kyno_vitreoasis_big", poolfn, assets, prefabs),
Prefab("kyno_vitreoasis2_big", poolfn2, assets, prefabs),
MakePlacer("kyno_vitreoasis_big_placer", "moonglasspool_tile", "moonglasspool_tile", "idle", true),
MakePlacer("kyno_vitreoasis2_big_placer", "moonglasspool_tile", "moonglasspool_tile", "idle", true)