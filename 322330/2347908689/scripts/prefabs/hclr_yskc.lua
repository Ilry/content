require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/hclr_yskc.zip"),
	Asset("ATLAS", "images/inventoryimages/hclr_yskc.xml"),
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
	inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.components.container:DropEverything()
    inst.components.container:Close()
end

local hclr_thc_items = {"nitre","flint","rocks"}
local hclr_thc_num = {2,2,5}
local function on(inst)
	local container = inst.components.container
	local start = 1
	for k = 1, 3 do
		local maxlog = hclr_thc_num[k]
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

local function MakeCookPot(name, masterfn)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, 1.5)
        inst:AddTag("structure")
		
		inst.AnimState:SetBank(name)
		inst.AnimState:SetBuild(name)
		inst.AnimState:PlayAnimation("idle")
		--inst.Transform:SetScale(1.5, 1.5, 1.5)

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

return MakeCookPot("hclr_yskc", on),
		MakePlacer("hclr_yskc_placer", "hclr_yskc", "hclr_yskc", "idle")