
local lan = {
	chs = true,
	cht = true,
	zh = true,
	zht = true,
}
local chs = lan[LanguageTranslator.defaultlang]

local assets = {
	Asset("ANIM", "anim/skull_chest.zip"),
	Asset("ATLAS", "images/iai_rubbishbox.xml"),
}

local function GetPrefabName(inst)
	return (inst.name ~= nil and inst.name ~= "MISSING NAME" and inst.name) or (inst.nameoverride ~= nil and STRINGS.NAMES[string.upper(inst.nameoverride)] or inst.prefab)
end

local function onopen(inst)
	inst.AnimState:PlayAnimation("open")
	
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
	inst.AnimState:PlayAnimation("close")
	
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

local function onhammered(inst, worker)
	if inst.components.lootdropper then
		inst.components.lootdropper:DropLoot()
	end
	if inst.components.container then
		inst.components.container:DropEverything()
	end
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed", true)
	if inst.components.container then
		inst.components.container:DropEverything()
		inst.components.container:Close()
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", true)
	
	inst.SoundEmitter:PlaySound("dontstarve/common/chest_craft")
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("iai_rubbishbox.tex")
	inst.entity:AddNetwork()
	
	inst:AddTag("structure")
	inst:AddTag("chest")
	
	inst.AnimState:SetBank("skull_chest")
	inst.AnimState:SetBuild("skull_chest")
	inst.AnimState:PlayAnimation("closed", true)
	
	MakeSnowCoveredPristine(inst)
	
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("iai_rubbishbox") 
		end
		
		return inst
	end
	
	inst:AddComponent("inspectable")
	local old = inst.components.inspectable.GetDescription
	inst.components.inspectable.GetDescription = function(self, viewer)
		local desc, filter_context, author = old(self, viewer)
		desc = chs and ("隐藏着黑暗力量的箱子啊\n在我面前显示出你真正的力量！\n现在以你的主人 "..GetPrefabName(viewer).." 之名命令你——封印解除！") or "recycle rubbish"
		return desc, filter_context, author
	end
	
	inst:AddComponent("container")
	inst.components.container:WidgetSetup("iai_rubbishbox")
	inst.components.container.onopenfn = onopen
	inst.components.container.onclosefn = onclose
	
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(2)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	
	inst:AddComponent("hauntable")
	inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)
	
	inst:ListenForEvent("onbuilt", onbuilt)
	
	MakeSnowCovered(inst)
	
	return inst
end

STRINGS.NAMES.IAI_RUBBISHBOX = chs and "桌面清理大师" or "rubbish collector"
STRINGS.RECIPE_DESC.IAI_RUBBISHBOX = chs and "回收旧手机、微波炉~" or "Recycle rubbish"

return Prefab("common/iai_rubbishbox", fn, assets),
	MakePlacer("iai_rubbishbox_placer", "skull_chest", "skull_chest", "closed")
