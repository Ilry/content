require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/seataro.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
}

local prefabs =
{
    "foliage",
}

local function onpicked(inst)
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetScale(.7, .7, .7)
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("kyno_seataroroot.tex")

    inst.AnimState:SetBank("seataro")
    inst.AnimState:SetBuild("seataro")
    inst.AnimState:PlayAnimation("idle_plant", true)
    inst.AnimState:SetRayTestOnBB(true)
	
	inst:AddTag("aquatic")
	inst:AddTag("ignorewalkableplatforms")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	
    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("foliage")
    inst.components.pickable.onpickedfn = onpicked

    inst.components.pickable.quickpick = false

    MakeSmallBurnable(inst)
    MakeSmallPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

local function seataroplacer(inst)
	inst.AnimState:SetScale(.7, .7, .7)
end

return Prefab("kyno_seataro_planted", fn, assets),
MakePlacer("kyno_seataro_planted_placer", "seataro", "seataro", "idle_plant", false, nil, nil, nil, nil, nil, seataroplacer)