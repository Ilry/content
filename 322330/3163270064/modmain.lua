GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})
AddPrefabPostInit("evergreen",function(inst) --常青
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("pinecone_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)
AddPrefabPostInit("deciduoustree",function(inst) --桦树
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("acorn_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)
AddPrefabPostInit("twiggytree",function(inst) --多枝
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("twiggy_nut_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)
AddPrefabPostInit("evergreen_sparse",function(inst) --粗壮
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("lumpy_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)
AddPrefabPostInit("moon_tree",function(inst) --月树
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("moonbutterfly_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)
AddPrefabPostInit("palmconetree",function(inst) --棕榈
	if not TheWorld.ismastersim then
        return inst
    end
	local oldfn = inst.components.workable.onfinish
	inst.components.workable.onfinish = function(inst, chopper) 
	oldfn(inst, chopper)
	inst:DoTaskInTime(10,function() 
	if inst then
		local x,y,z = inst.Transform:GetWorldPosition()
		if TheWorld.Map:IsFarmableSoilAtPoint(x,y,z) and TheWorld.components.farming_manager ~= nil then    
		    SpawnPrefab("sand_puff_large_front").Transform:SetPosition(inst.Transform:GetWorldPosition())
			SpawnPrefab("farm_plant_happy").Transform:SetPosition(inst.Transform:GetWorldPosition())
            SpawnPrefab("palmcone_sapling").Transform:SetPosition(inst.Transform:GetWorldPosition())		
		    inst:Remove()
		end	
	end
	end)
	end
end)