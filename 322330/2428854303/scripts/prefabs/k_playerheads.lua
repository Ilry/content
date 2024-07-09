require("prefabutil")

local assets =
{
	Asset("ANIM", "anim/kyno_playerheads.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
}

local function OnFinish(inst)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    if TheWorld.state.isfullmoon then
        inst.components.lootdropper:SpawnLootPrefab("nightmarefuel")
    end
    inst.components.lootdropper:DropLoot()
    inst:Remove()
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

local function common()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	MakeObstaclePhysics(inst, .2)
	
    inst.AnimState:SetBank("kyno_playerheads")
    inst.AnimState:SetBuild("kyno_playerheads")
    
	inst:AddTag("structure")
	inst:AddTag("dead_players")
	inst:AddTag("chewable")  
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.flies = inst:SpawnChild("flies")
    inst.awake = nil
	
	inst:AddComponent("lootdropper")

    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "KYNO_PLAYERHEAD"
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(OnFinish)
	
	inst:AddComponent("hauntable")
	inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_MEDIUM
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	MakeHauntableWork(inst)
	MakeSmallBurnable(inst, nil, nil, true)
    MakeSmallPropagator(inst)

    inst.OnSave = onsave
    inst.OnLoad = onload
	
    return inst
end

local function wilson()
    local inst = common()
    inst.AnimState:PlayAnimation("wilson_idle", false)
    return inst
end

local function willow()
    local inst = common()
    inst.AnimState:PlayAnimation("willow_idle", false)
    return inst
end

local function wolfgang()
    local inst = common()
    inst.AnimState:PlayAnimation("wolfgang_idle", false)
    return inst
end

local function wendy()
    local inst = common()
    inst.AnimState:PlayAnimation("wendy_idle", false)
    return inst
end

local function wx78()
    local inst = common()
    inst.AnimState:PlayAnimation("wx78_idle", false)
    return inst
end

local function wickerbottom()
    local inst = common()
    inst.AnimState:PlayAnimation("wickerbottom_idle", false)
    return inst
end

local function woodie()
    local inst = common()
    inst.AnimState:PlayAnimation("woodie_idle", false)
    return inst
end

local function wes()
    local inst = common()
    inst.AnimState:PlayAnimation("wes_idle", false)
    return inst
end

local function waxwell()
    local inst = common()
    inst.AnimState:PlayAnimation("waxwell_idle", false)
    return inst
end

local function wagstaff()
    local inst = common()
    inst.AnimState:PlayAnimation("wagstaff_idle", false)
    return inst
end

local function wathgrithr()
    local inst = common()
    inst.AnimState:PlayAnimation("wathgrithr_idle", false)
	
	inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.components.inspectable.nameoverride = "KYNO_WATHGRITHRHEAD"
    return inst
end

local function webber()
    local inst = common()
    inst.AnimState:PlayAnimation("webber_idle", false)
    return inst
end

local function walani()
    local inst = common()
    inst.AnimState:PlayAnimation("walani_idle", false)
    return inst
end

local function warly()
    local inst = common()
    inst.AnimState:PlayAnimation("warly_idle", false)
    return inst
end

local function wilbur()
    local inst = common()
    inst.AnimState:PlayAnimation("wilbur_idle", false)
    return inst
end

local function woodlegs()
    local inst = common()
    inst.AnimState:PlayAnimation("woodlegs_idle", false)
    return inst
end

local function wilba()
    local inst = common()
    inst.AnimState:PlayAnimation("wilba_idle", false)
    return inst
end

local function wormwood()
    local inst = common()
    inst.AnimState:PlayAnimation("wormwood_idle", false)
    return inst
end

local function wheeler()
    local inst = common()
    inst.AnimState:PlayAnimation("wheeler_idle", false)
    return inst
end

local function winona()
    local inst = common()
    inst.AnimState:PlayAnimation("winona_idle", false)
    return inst
end

local function wortox()
    local inst = common()
    inst.AnimState:PlayAnimation("wortox_idle", false)
    return inst
end

local function wurt()
    local inst = common()
    inst.AnimState:PlayAnimation("wurt_idle", false)
    return inst
end

local function walter()
    local inst = common()
    inst.AnimState:PlayAnimation("walter_idle", false)
    return inst
end

local function warbucks()
    local inst = common()
    inst.AnimState:PlayAnimation("warbucks_idle", false)
    return inst
end

local function wanda()
	local inst = common()
	inst.AnimState:PlayAnimation("wanda_idle", false)
	return inst
end

local function wonkey()
	local inst = common()
	inst.AnimState:PlayAnimation("wonkey_idle", false)
	return inst
end

return Prefab("kyno_wilsonhead", wilson, assets),
Prefab("kyno_willowhead", willow, assets),
Prefab("kyno_wolfganghead", wolfgang, assets),
Prefab("kyno_wendyhead", wendy, assets),
Prefab("kyno_wx78head", wx78, assets),
Prefab("kyno_wickerbottomhead", wickerbottom, assets),
Prefab("kyno_woodiehead", woodie, assets),
Prefab("kyno_weshead", wes, assets),
Prefab("kyno_waxwellhead", waxwell, assets),
Prefab("kyno_wagstaffhead", wagstaff, assets),
Prefab("kyno_wathgrithrhead", wathgrithr, assets),
Prefab("kyno_webberhead", webber, assets),
Prefab("kyno_walanihead", walani, assets),
Prefab("kyno_warlyhead", warly, assets),
Prefab("kyno_wilburhead", wilbur, assets),
Prefab("kyno_woodlegshead", woodlegs, assets),
Prefab("kyno_wilbahead", wilba, assets),
Prefab("kyno_wormwoodhead", wormwood, assets),
Prefab("kyno_wheelerhead", wheeler, assets),
Prefab("kyno_winonahead", winona, assets),
Prefab("kyno_wortoxhead", wortox, assets),
Prefab("kyno_wurthead", wurt, assets),
Prefab("kyno_walterhead", walter, assets),
Prefab("kyno_warbuckshead", warbucks, assets),
Prefab("kyno_wandahead", wanda, assets),
Prefab("kyno_wonkeyhead", wonkey, assets),
MakePlacer("kyno_wilsonhead_placer", "kyno_playerheads", "kyno_playerheads", "wilson_idle"),
MakePlacer("kyno_willowhead_placer", "kyno_playerheads", "kyno_playerheads", "willow_idle"),
MakePlacer("kyno_wolfganghead_placer", "kyno_playerheads", "kyno_playerheads", "wolfgang_idle"),
MakePlacer("kyno_wendyhead_placer", "kyno_playerheads", "kyno_playerheads", "wendy_idle"),
MakePlacer("kyno_wx78head_placer", "kyno_playerheads", "kyno_playerheads", "wx78_idle"),
MakePlacer("kyno_wickerbottomhead_placer", "kyno_playerheads", "kyno_playerheads", "wickerbottom_idle"),
MakePlacer("kyno_woodiehead_placer", "kyno_playerheads", "kyno_playerheads", "woodie_idle"),
MakePlacer("kyno_weshead_placer", "kyno_playerheads", "kyno_playerheads", "wes_idle"),
MakePlacer("kyno_waxwellhead_placer", "kyno_playerheads", "kyno_playerheads", "waxwell_idle"),
MakePlacer("kyno_wagstaffhead_placer", "kyno_playerheads", "kyno_playerheads", "wagstaff_idle"),
MakePlacer("kyno_wathgrithrhead_placer", "kyno_playerheads", "kyno_playerheads", "wathgrithr_idle"),
MakePlacer("kyno_webberhead_placer", "kyno_playerheads", "kyno_playerheads", "webber_idle"),
MakePlacer("kyno_walanihead_placer", "kyno_playerheads", "kyno_playerheads", "walani_idle"),
MakePlacer("kyno_warlyhead_placer", "kyno_playerheads", "kyno_playerheads", "warly_idle"),
MakePlacer("kyno_wilburhead_placer", "kyno_playerheads", "kyno_playerheads", "wilbur_idle"),
MakePlacer("kyno_woodlegshead_placer", "kyno_playerheads", "kyno_playerheads", "woodlegs_idle"),
MakePlacer("kyno_wilbahead_placer", "kyno_playerheads", "kyno_playerheads", "wilba_idle"),
MakePlacer("kyno_wormwoodhead_placer", "kyno_playerheads", "kyno_playerheads", "wormwood_idle"),
MakePlacer("kyno_wheelerhead_placer", "kyno_playerheads", "kyno_playerheads", "wheeler_idle"),
MakePlacer("kyno_winonahead_placer", "kyno_playerheads", "kyno_playerheads", "winona_idle"),
MakePlacer("kyno_wortoxhead_placer", "kyno_playerheads", "kyno_playerheads", "wortox_idle"),
MakePlacer("kyno_wurthead_placer", "kyno_playerheads", "kyno_playerheads", "wurt_idle"),
MakePlacer("kyno_walterhead_placer", "kyno_playerheads", "kyno_playerheads", "walter_idle"),
MakePlacer("kyno_warbuckshead_placer", "kyno_playerheads", "kyno_playerheads", "warbucks_idle"),
MakePlacer("kyno_wandahead_placer", "kyno_playerheads", "kyno_playerheads", "wanda_idle"),
MakePlacer("kyno_wonkeyhead_placer", "kyno_playerheads", "kyno_playerheads", "wonkey_idle")