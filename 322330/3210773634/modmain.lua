GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
GLOBAL.require("components/desolationspawner")._ctor=function()end
--去除循环生长的树木

-- ①-1：常青树、多枝树列表
local plantregrowth_evergreen_list={}
	if GetModConfigData("EVERGREEN_EVERGREENSPARSE") then
		plantregrowth_evergreen_list["evergreen"]=true
		plantregrowth_evergreen_list["evergreen_sparse"]=true
		plantregrowth_evergreen_list["twiggytree"]=true
	end


-- ②-1：桦树、月树、蘑菇树列表
local plantregrowth_list={}

	if GetModConfigData("DECIDUOUSTREE") then
		table.insert(plantregrowth_list,"deciduoustree")
	end
	
	if GetModConfigData("MOON_TREE") then
		table.insert(plantregrowth_list,"moon_tree")
	end
	
	if GetModConfigData("MUSHTREE") then
		table.insert(plantregrowth_list,"mushtree_tall")
		table.insert(plantregrowth_list,"mushtree_medium")
		table.insert(plantregrowth_list,"mushtree_small")
	end

	if GetModConfigData("MARBLE") then
		table.insert(plantregrowth_list,"marbleshrub")
	end

function table_key_exists(tables, key)
    return tables[key] ~= nil
end

-- ①-2：常青树、多枝树去除循环
for k,v in pairs(plantregrowth_evergreen_list) do
	AddPrefabPostInit(k, function(inst)
		if TheWorld.ismastersim then
			if inst.components and inst.components.growable then
				inst.components.growable.loopstages = false
				-- print("============loopstages"..k)打印日志天涯说不用了
			end
		end
	end)
end

-- ①-3：常青树、多枝树只生长到第三级（第四级为枯萎状态）
AddComponentPostInit("growable",
	function(self)
		-- 获取作物的下一阶段
		function self:GetNextStage()
			local stage = self.stage + 1
			if stage > #self.stages then
				if self.loopstages then
					stage = self.loopstages_start or 1
				else
					stage = #self.stages
				end
			end
			-- 若为常青树、多枝树等树，则最高阶段为第三阶段
			if table_key_exists(plantregrowth_evergreen_list, self.inst.prefab) then
				if #self.stages > 3 then 
					table.remove(self.stages)
				end
			end
			return stage
		end
	end
)

-- ②-2：桦树、月树、蘑菇树列表
for k,v in pairs(plantregrowth_list) do
	AddPrefabPostInit(v, function(inst)
		if TheWorld.ismastersim then
			if inst.components and inst.components.growable then
				inst.components.growable.loopstages = false
			end
		end
	end)
end

