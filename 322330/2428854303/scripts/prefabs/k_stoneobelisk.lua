require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/quagmire_cemetery.zip"),
	
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

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("obelisk")
    inst.AnimState:PushAnimation("obelisk")
end

local function onbuilt(inst)
    inst.AnimState:PushAnimation("obelisk")
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kyno_stoneobelisk.tex")
	
    MakeObstaclePhysics(inst, .2)
	
    inst.AnimState:SetBank("quagmire_cemetery")
    inst.AnimState:SetBuild("quagmire_cemetery")
    inst.AnimState:PlayAnimation("obelisk")
    
	inst:AddTag("structure")
	inst:AddTag("cemetery_obelisk")
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("lootdropper")
	
    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "QUAGMIRE_PARK_OBELISK"
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	
	inst:ListenForEvent("onbuilt", onbuilt)
	
	MakeHauntableWork(inst)
	
    return inst
end

return Prefab("kyno_stoneobelisk", fn, assets),
MakePlacer("kyno_stoneobelisk_placer", "quagmire_cemetery", "quagmire_cemetery", "obelisk")