require "prefabutil"
--柴薪/拓荒场
local assets =
{
    Asset("ANIM", "anim/hclr_cxc_action.zip"),
    Asset("ANIM", "anim/ui_chest_3x3.zip"),

	Asset("ATLAS", "images/inventoryimages/hclr_cxc.xml"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_cxc.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_cxc.dyn"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/ui_hclr_thc_3x9.zip"),
	Asset("PKGREF", "anim/dynamic/ui_hclr_thc_3x9.dyn"),
}

local prefabs =
{
    "collapse_small",
}

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
end

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
	if inst.prefab == "hclr_thc" then
		local nightmarefuel =  inst.components.lootdropper:SpawnLootPrefab("nightmarefuel", inst:GetPosition())
		if nightmarefuel.components.stackable then
			nightmarefuel.components.stackable:SetStackSize(2)
		end
		local pinecone =  inst.components.lootdropper:SpawnLootPrefab("pinecone", inst:GetPosition())
		if pinecone.components.stackable then
			pinecone.components.stackable:SetStackSize(20)
		end
		inst.components.lootdropper:SpawnLootPrefab("hclr_thc_item", inst:GetPosition())
	end
	inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.components.container:Close()
end

local hclr_thc_items = {"log","twigs","cutgrass"}

local function on(inst)
	local container = inst.components.container
	local start = 1
	for k = 1, 3 do
		local maxlog = 10
		for i = start, start+8 do
			local item = container:GetItemInSlot(i)
			if not item then
				local newlog = SpawnPrefab(hclr_thc_items[k])
				newlog.components.stackable:SetStackSize(maxlog)
				container:GiveItem(newlog,i)
				maxlog = 0
			elseif item.components.stackable and not item.components.stackable:IsFull() then
				local num = math.min(maxlog,item.components.stackable:RoomLeft())
				local newlog = SpawnPrefab(hclr_thc_items[k])
				newlog.components.stackable:SetStackSize(num)
				container:GiveItem(newlog,i)
				maxlog = maxlog - num
			end
			if maxlog < 1 then
				break
			end
		end
		start = start + 9
	end
end

local function creatlog(inst)
	for k = 1, 10 do
		local newlog = SpawnPrefab("log")
		if not inst.components.container:GiveItem(newlog) then
			newlog:Remove()
			return
		end
	end
end

local function MakeCookPot(name, masterfn,big)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, big and 1.5 or  1)
        inst:AddTag("structure")

		inst:AddTag("for_hclr_xdhd")
		inst:AddTag("chest")

		inst.AnimState:SetBank("hclr_cxc")
		inst.AnimState:SetBuild("hclr_cxc")
		inst.AnimState:PlayAnimation(name)
		--inst.MiniMapEntity:SetIcon("cookpot.png")
		if big then
			inst.Transform:SetScale(1.5, 1.5, 1.5)
		end
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

		inst:AddComponent("container")
		inst.components.container:WidgetSetup(name)
		inst.components.container.onopenfn = onopen
		inst.components.container.onclosefn = onclose

        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(onhammered)
		inst.components.workable:SetOnWorkCallback(onhit)

		inst:WatchWorldState( "startday", function(...)
			inst:DoTaskInTime(math.random(),masterfn)
		end)
        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeCookPot("hclr_cxc", creatlog),
	MakeCookPot("hclr_thc", on,true),
	MakePlacer("hclr_cxc_placer", "hclr_cxc", "hclr_cxc", "hclr_cxc")
