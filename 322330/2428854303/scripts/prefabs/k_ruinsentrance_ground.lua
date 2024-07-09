require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/kyno_ruinsentrance_ground.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
}

local function OnHammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local s = 2.5

local function fn(shard)
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, 1)
	
	inst.AnimState:SetScale(s, s, s)
	
	inst.AnimState:SetBank("kyno_ruinsentrance_ground")
	inst.AnimState:SetBuild("kyno_ruinsentrance_ground")
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(3)
	
	inst:AddTag("structure")
	inst:AddTag("entrance")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	local SHARD = GetModConfigData("SHARD", KnownModIndex:GetModActualName("The Architect Pack"))
	if SHARD == 1 and shard then
		inst:AddComponent("worldmigrator")
	end
	
	inst:AddComponent("lootdropper")
	inst:AddComponent("inspectable")
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetOnFinishCallback(OnHammered)
	inst.components.workable:SetWorkLeft(4)

	return inst
end

local function entrance1()
    local inst = fn()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kyno_ruinsentrance_ground1.tex")
	
	inst.AnimState:PlayAnimation("idle1", false)
    return inst
end

local function entrance2()
    local inst = fn(true)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kyno_ruinsentrance_ground2.tex")
	
	inst.AnimState:PlayAnimation("idle2", false)
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.lootdropper:SetLoot({"cutstone", "flint"})
    return inst
end

local function entrance3()
    local inst = fn()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kyno_ruinsentrance_ground3.tex")
	
	inst.AnimState:PlayAnimation("idle3", false)
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.lootdropper:SetLoot({"cutstone", "flint"})
    return inst
end

local function entranceplacerfn(inst)
	inst.AnimState:SetScale(s, s, s)
	
	inst.ApplySkin = function(inst, skin)
		if skin == "kyno_ruinsentrance_ground2" then
			inst.AnimState:PlayAnimation("idle2", false)
		elseif skin == "kyno_ruinsentrance_ground3" then
			inst.AnimState:PlayAnimation("idle3", false)
		end
	end
end

local function placerfn(inst)
	inst.AnimState:SetScale(s, s, s)
end

return Prefab("kyno_ruinsentrance_ground1", entrance1, assets, prefabs),
Prefab("kyno_ruinsentrance_ground2", entrance2, assets, prefabs),
Prefab("kyno_ruinsentrance_ground3", entrance3, assets, prefabs),
MakePlacer("kyno_ruinsentrance_ground1_placer", "kyno_ruinsentrance_ground", "kyno_ruinsentrance_ground", "idle1", false, nil, nil, nil, nil, nil, entranceplacerfn),
MakePlacer("kyno_ruinsentrance_ground2_placer", "kyno_ruinsentrance_ground", "kyno_ruinsentrance_ground", "idle2", false, nil, nil, nil, nil, nil, placerfn),
MakePlacer("kyno_ruinsentrance_ground3_placer", "kyno_ruinsentrance_ground", "kyno_ruinsentrance_ground", "idle3", false, nil, nil, nil, nil, nil, placerfn)
--[[,
CreateModPrefabSkin("kyno_ruinsentrance_ground2",
	{
		assets = {
			Asset("ANIM", "anim/kyno_ruinsentrance_ground.zip"),
		},
		base_prefab = "kyno_ruinsentrance_ground1",
		fn = entrance2,
		rarity = "Timeless",
		reskinable = true,
		
		build_name_override = "kyno_ruinsentrance_ground",
		
		type = "item",
		skin_tags = { },
		release_group = 0,
	}),
CreateModPrefabSkin("kyno_ruinsentrance_ground3",
	{
		assets = {
			Asset("ANIM", "anim/kyno_ruinsentrance_ground.zip"),
		},
		base_prefab = "kyno_ruinsentrance_ground1",
		fn = entrance3,
		rarity = "Timeless",
		reskinable = true,
		
		build_name_override = "kyno_ruinsentrance_ground",
		
		type = "item",
		skin_tags = { },
		release_group = 0,
	})
]]--