require("prefabutil")

local assets =
{
	Asset("ANIM", "anim/quagmire_safe.zip"),
	Asset("ANIM", "anim/ui_chest_3x2.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
}

local function onopen(inst) 
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("open")
		inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/safe/key")
	end
end

local function onclose(inst)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("closed")
		inst.SoundEmitter:PlaySound("dontstarve/quagmire/common/safe/key")
	end
end

local function onhammered(inst, worker)
    if inst:HasTag("fire") and inst.components.burnable then
        inst.components.burnable:Extinguish()
    end
	inst.components.lootdropper:DropLoot()
	if inst.components.container then inst.components.container:DropEverything() end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("closed", true)
		if inst.components.container then 
			inst.components.container:DropEverything() 
			inst.components.container:Close()
		end
	end
end

local function onbuilt(inst)
	inst.AnimState:PushAnimation("closed", true)
	inst.SoundEmitter:PlaySound("dontstarve/common/craftable/chest")
end	

local function GetStatus(inst, viewer)
    if inst._chestupgrade_stacksize then
        return "UPGRADED_STACKSIZE"
    end

    return "GENERIC"
end

local function OnUpgrade(inst, performer, upgraded_from_item)
    local numupgrades = inst.components.upgradeable.numupgrades
	
    if numupgrades == 1 then
        inst._chestupgrade_stacksize = true
		
        if inst.components.container ~= nil then
            inst.components.container:Close()
            inst.components.container:EnableInfiniteStackSize(true)
            inst.components.inspectable.getstatus = GetStatus
        end
		
        if upgraded_from_item then
            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab("chestupgrade_stacksize_fx")
            fx.Transform:SetPosition(x, y, z)
        end
    end
	
    inst.components.upgradeable.upgradetype = nil
	
	if inst.components.lootdropper ~= nil then
        inst.components.lootdropper:SetLoot({"alterguardianhatshard"})
    end
end

local function OnLoadPostPass(inst, newents, data)
    if inst.components.upgradeable ~= nil and inst.components.upgradeable.numupgrades > 0 then
        OnUpgrade(inst)
    end
end

local function OnDecontructStructure(inst, caster)
    if inst.components.upgradeable ~= nil and inst.components.upgradeable.numupgrades > 0 then
        if inst.components.lootdropper ~= nil then
            inst.components.lootdropper:SpawnLootPrefab("alterguardianhatshard")
        end
    end
end

local function fn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("quagmire_safe.png")
	
	inst.AnimState:SetBank("quagmire_safe")
	inst.AnimState:SetBuild("quagmire_safe")
	inst.AnimState:PlayAnimation("closed", true)
	
	inst:AddTag("structure")
	inst:AddTag("safe_chest")
	inst:AddTag("chest")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) inst.replica.container:WidgetSetup("treasurechest") end
        return inst
    end
	
	inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "QUAGMIRE_SAFE"
	
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	inst:AddComponent("container")
    inst.components.container:WidgetSetup("treasurechest")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	inst.components.container.skipclosesnd = true
	inst.components.container.skipopensnd = true
	
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	inst.components.workable:SetWorkLeft(2)
	
	inst:AddComponent("upgradeable")
	inst.components.upgradeable.upgradetype = UPGRADETYPES.CHEST
	inst.components.upgradeable:SetOnUpgradeFn(OnUpgrade)
   
	inst:ListenForEvent("onbuilt", onbuilt)
	inst:ListenForEvent("ondeconstructstructure", OnDecontructStructure)
	
	inst.OnLoadPostPass = OnLoadPostPass

	return inst
end

return Prefab("kyno_safechest", fn, assets, prefabs),
MakePlacer("kyno_safechest_placer", "quagmire_safe", "quagmire_safe", "closed")