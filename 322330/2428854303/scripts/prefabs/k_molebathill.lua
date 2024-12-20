local assets =
{
    Asset("ANIM", "anim/molebathill.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
}

local prefabs =
{
    "lightbulb",
    "twigs",
}

local BAT_AGGRO_DISTANCE = 5
local BAT_TARGET_MUST_TAGS = { "_combat", "bat" }
local BAT_TARGET_CANT_TAGS = { "DECOR", "FX", "INLIMBO", "noattack", "notarget" }

local function dig_up(inst, digger)
    inst.components.lootdropper:DropLoot()

    local ix, iy, iz = inst.Transform:GetWorldPosition()
    local nearby_bats = TheSim:FindEntities(
        ix, iy, iz,
        BAT_AGGRO_DISTANCE,
        BAT_TARGET_MUST_TAGS,
        BAT_TARGET_CANT_TAGS
    )
    for _, bat in ipairs(nearby_bats) do
        if bat.entity:IsVisible() then
            bat.components.sleeper:WakeUp()
            if bat.components.combat:CanTarget(digger) then
                bat.components.combat:SetTarget(digger)
            end
        end
    end

    inst:Remove()
end

local function on_sucked_up(inst)
    if inst.persists ~= false then
        inst.persists = false
        inst:AddTag("NOCLICK")
        inst.components.workable:SetWorkable(false)

        inst.AnimState:PlayAnimation("suck")
        inst:ListenForEvent("animover", inst.Remove)
    end
end

local function AdoptChild(inst, child)
    if child.components.entitytracker ~= nil then
        child.components.entitytracker:TrackEntity("burrow", inst)
    end

    if child.components.knownlocations ~= nil then
        child.components.knownlocations:RememberLocation("home", inst:GetPosition())
    end
end

local function on_molebat_travelled_here(molebat)
    if molebat then
        molebat:Nap()
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("mucusnest")
    inst.AnimState:SetBuild("molebathill")
    inst.AnimState:PlayAnimation("spawn")
    inst.AnimState:PushAnimation("idle", true)

    inst:AddTag("molebathill")
	inst:AddTag("structure")
	
	inst:SetPrefabNameOverride("molebathill")

    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
    end

    inst:AddComponent("lootdropper")
    inst:AddComponent("inspectable")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.DIG)
    inst.components.workable:SetOnFinishCallback(dig_up)
    inst.components.workable:SetWorkLeft(1)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_SMALL)

	-- inst._is_being_cleaned = nil
    inst:ListenForEvent("suckedup", on_sucked_up)

    inst.AdoptChild = AdoptChild
    inst.travel_action_fn = on_molebat_travelled_here

    return inst
end

return Prefab("kyno_molebathill", fn, assets, prefabs),
MakePlacer("kyno_molebathill_placer", "mucusnest", "molebathill", "idle")