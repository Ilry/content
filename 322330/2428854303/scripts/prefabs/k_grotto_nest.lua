require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/kyno_grottonest.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
}

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeObstaclePhysics(inst, 1)
	
	local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("kyno_grottonest.tex")
	
    inst.AnimState:SetBank("kyno_grottonest")
    inst.AnimState:SetBuild("kyno_grottonest")
    inst.AnimState:PlayAnimation("idle")
    
	inst:AddTag("structure")
	inst:AddTag("grotto_structure")
	inst:AddTag("rotatableobject")
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	MakeHauntableWork(inst)
	
    return inst
end

local function goofn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeObstaclePhysics(inst, 1)
	
	local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("kyno_grottonest.tex")
	
    inst.AnimState:SetBank("kyno_grottonest")
    inst.AnimState:SetBuild("kyno_grottonest")
    inst.AnimState:PlayAnimation("idle2")
    
	inst:AddTag("structure")
	inst:AddTag("grotto_structure")
	inst:AddTag("no_goo")
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	MakeHauntableWork(inst)
	
    return inst
end

return Prefab("kyno_grottonest1", fn, assets),
Prefab("kyno_grottonest2", goofn, assets),
MakePlacer("kyno_grottonest1_placer", "kyno_grottonest", "kyno_grottonest", "idle"),
MakePlacer("kyno_grottonest2_placer", "kyno_grottonest", "kyno_grottonest", "idle2")