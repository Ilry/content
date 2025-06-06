require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/accomplishment_shrine.zip"),
	Asset("ANIM", "anim/accomplishment_fireworks.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages2.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages2.xml"),
	
	Asset("IMAGE", "images/minimapimages/tap_minimapicons.tex"),
	Asset("ATLAS", "images/minimapimages/tap_minimapicons.xml"),
}

local prefabs =
{
	"kyno_shrine_firework",
	"kyno_shrine_multifirework",
}

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local clicks_per_step = 25
local anim_steps = 29
local total_clicks = 100

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit")
	inst:DoTaskInTime(13/30, function() 
		inst.AnimState:SetPercent("active", inst.clicks/total_clicks)
		end)
end

local function GetVerb(inst)
	return STRINGS.ACTIONS.ACTIVATE.ACCOMPLISH
end


local function dospinanim(inst, startp, endp)
	if not inst.task then
			
		local target_percent = endp or inst.clicks/total_clicks
		local start_percent = startp or (inst.clicks-1)/total_clicks
		local percent = start_percent
		local dt = 1/30
		
		local percent_speed = (inst.clicks % clicks_per_step) / (clicks_per_step-1)
		
		local slow = 5
		local fast = 2

		local percent_change_rate = (percent_speed*slow + (1-percent_speed)*fast)/2



		local looped = (startp and endp) and true or false
		
		--inst.components.activatable.inactive = false

		inst.task = inst:DoPeriodicTask(dt, function()   
				percent = percent + dt*percent_change_rate
				if looped and percent > target_percent then
					percent = target_percent
					inst.task:Cancel()
					inst.task = nil
					inst.components.activatable.inactive = true
				else
					if percent >= 1 then 
						looped = true
						percent = 0
					end
				end
				
				inst.AnimState:SetPercent("active", percent)
			end)
	end
end

local function OnActivate(inst, doer)
	local old_clicks = inst.clicks
	inst.clicks = inst.clicks + 1
	if inst.clicks < total_clicks then

		inst.SoundEmitter:PlaySound("dontstarve/common/shrine/shrine_click", "click")
		inst.SoundEmitter:SetParameter( "click", "click", (inst.clicks-1) % clicks_per_step ) -- 0 through 24
		
		if inst.clicks % clicks_per_step == 0 then
			doer:PushEvent("accomplishment")
			inst.AnimState:PlayAnimation("reward")
			local firework = SpawnPrefab("kyno_shrine_firework").Transform:SetPosition(inst.Transform:GetWorldPosition())
			inst.SoundEmitter:PlaySound("dontstarve/common/shrine/sadwork_fire")
			inst:DoTaskInTime(26/30, function() inst.SoundEmitter:PlaySound("dontstarve/common/shrine/sadwork_explo") end)
			inst:DoTaskInTime(35/30, function() dospinanim(inst, 0, (inst.clicks+1)/total_clicks) end)
		else
			dospinanim(inst)
		end
	else
		doer:PushEvent("accomplishment_done")
		local firework_mult = SpawnPrefab("kyno_shrine_multifirework").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.SoundEmitter:PlaySound("dontstarve/common/shrine/sadwork_fire")
		inst:DoTaskInTime(26/30, function() inst.SoundEmitter:PlaySound("dontstarve/common/shrine/firework_explo") end)
		inst.AnimState:PlayAnimation("done")
		inst.AnimState:PushAnimation("done_pst", false)
		if old_clicks < total_clicks then
			TheGameService:AwardAchievement("achievement_10")
		end
		inst.SoundEmitter:PlaySound("dontstarve/common/shrine/shrine_final")
		inst:DoTaskInTime(2, function() inst.components.activatable.inactive = true end)
	end
end

local function onbuilt(inst)
	TheGameService:AwardAchievement("achievement_9")
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle", true)
end

local function OnSave(inst, data)
	data.clicks = inst.clicks
end

local function OnLoad(inst, data)
	if data then
		inst.clicks = data.clicks or inst.clicks

		if inst.clicks >= total_clicks then
			-- inst.components.activatable.inactive = false
			-- play done when we get it
		else
			inst.AnimState:SetPercent("active", inst.clicks/total_clicks)
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
	minimap:SetIcon("kyno_trophy.tex")
    
	MakeObstaclePhysics(inst, .4)
    
	inst.AnimState:SetBank("accomplishment_shrine")
	inst.AnimState:SetBuild("accomplishment_shrine")
	inst.AnimState:PlayAnimation("idle", true)
	
	inst:AddTag("structure")
	inst:AddTag("trophy")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")
	inst:AddComponent("lootdropper")
	
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)		

	inst:AddComponent("activatable")
    inst.components.activatable.OnActivate = OnActivate
    inst.components.activatable.getverb = GetVerb
    inst.components.activatable.inactive = true
	inst.components.activatable.quickaction = true
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	
	inst.clicks = 0
	inst:ListenForEvent("onbuilt", onbuilt)
	
	return inst
end

local function fireworkfn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("firework")
	inst.AnimState:SetBuild("accomplishment_fireworks")
	inst.AnimState:PlayAnimation("single_firework")
	
	inst:AddTag("NOCLICK")
	inst:AddTag("FX")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:DoTaskInTime(5, function() inst:Remove() end)
	
	return inst
end

local function multifireworkfn()
	local inst = CreateEntity()
    
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("firework")
	inst.AnimState:SetBuild("accomplishment_fireworks")
	inst.AnimState:PlayAnimation("multi_firework")
	
	inst:AddTag("NOCLICK")
	inst:AddTag("FX")
	
	inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:DoTaskInTime(5, function() inst:Remove() end)
	
	return inst
end

return Prefab("kyno_accomplishment_shrine", fn, assets, prefabs),
Prefab("kyno_shrine_firework", fireworkfn, assets, prefabs),
Prefab("kyno_shrine_multifirework", multifireworkfn, assets, prefabs),
MakePlacer("kyno_accomplishment_shrine_placer", "accomplishment_shrine", "accomplishment_shrine", "idle")  