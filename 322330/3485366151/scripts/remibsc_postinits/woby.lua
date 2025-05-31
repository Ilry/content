local function CreateLight()
	local inst = _G.CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddLight()
	inst.entity:AddFollower()
	inst.entity:SetCanSleep(false)
	inst.persists = false

	inst.Light:SetIntensity(.2)
	inst.Light:SetColour(1,1,1)
	inst.Light:SetRadius(1)
	inst.Light:Enable(true)

	inst:AddTag("NOCLICK")
	inst:AddTag("FX")

	return inst
end

local function CanUseWobyCommands(inst, user)
	return user.woby_commands_classified and user.woby_commands_classified:GetWoby() == inst and not inst:HasTag("transforming")
end

local function WobyPostInit(inst)
	if not _G.TheWorld.ismastersim then		
		inst._bsc_light = CreateLight()
		inst._bsc_light.Follower:FollowSymbol(inst.GUID)
		--inst.AnimState:SetLightOverride(1)
		local oldfn = inst.OnRemoveEntity
		inst.OnRemoveEntity = function(inst)
			if oldfn then oldfn(inst) end
			inst._bsc_light:Remove()
		end
	end

	inst:DoTaskInTime(0, function(inst)
		inst._remi_nofocus = true -- using a tag didn't work
		
		if not inst.components.spellbook then return end
		inst.components.spellbook:SetCanUseFn(CanUseWobyCommands)
	end)
end

AddPrefabPostInit("wobysmall", WobyPostInit)
AddPrefabPostInit("wobybig", WobyPostInit)