

-- options
local do_food_drops = GetModConfigData("food_drops")
local do_basic_ornament_drops = GetModConfigData("basic_ornament_drops")
local do_special_ornament_drops = GetModConfigData("special_ornament_drops")

local override_pig_token_chance = GetModConfigData("pig_token_chance")             -- default is 0.01
local override_pig_token_chance_yotp = GetModConfigData("pig_token_chance_yotp")   -- default is 0.5


if (do_food_drops and do_basic_ornament_drops and do_special_ornament_drops) then
	-- do nothing
	return
end

local function validize_chance(c)
	return type(c) == "number" and math.min(math.max(0, c), 1) or nil
end

LootDropper = GLOBAL.require "components/lootdropper"
local OldDropLoot = LootDropper.DropLoot
local hook_env = GLOBAL.setmetatable({
	-- we don't want to directly hook this function on GLOBAL field, 
	-- like: GLOBAL.IsSpecialEventActive = function(e) ... end
	-- cuz I afraid it will cause some terrible error

	-- 替换LootDropper的DropLoot函数的env, hook掉IsSpecialEventActive这个函数,  
	-- 让原来函数跳过这个判断的分支，转而走我们修改过的分支
	-- 不使用替换法了, 尽量让模组适应未来的官方变动
	-- 也不直接在GLOBAL里hook掉这个函数再在逻辑结束后改回来,  
	-- 因为变动作用域太大了, 鬼知道会出现什么问题
	IsSpecialEventActive = function(special_event)
		if special_event == GLOBAL.SPECIAL_EVENTS.WINTERS_FEAST then
			-- just return false, 
			-- let the original function skip that branch
			return false
		else
			return GLOBAL.IsSpecialEventActive(special_event)
		end
	end
}, { __index = GLOBAL.getfenv(OldDropLoot) })	

AddPrefabPostInit("world", function()

	if GLOBAL.IsSpecialEventActive(GLOBAL.SPECIAL_EVENTS.WINTERS_FEAST) then
		GLOBAL.setfenv(OldDropLoot, hook_env)

		LootDropper.DropLoot = function(self, pt)
			-- modify that branch
			local prefabname = string.upper(self.inst.prefab)
			local num_decor_loot = self.GetWintersFeastOrnaments ~= nil and self.GetWintersFeastOrnaments(self.inst) or TUNING.WINTERS_FEAST_TREE_DECOR_LOOT[prefabname] or nil
			if num_decor_loot ~= nil then
				-- 掉落普通饰品
				if do_basic_ornament_drops then
					for i = 1, num_decor_loot.basic do
						self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
					end
				end
				-- 掉落特别饰品
				if do_special_ornament_drops then
					if num_decor_loot.special ~= nil then
						self:SpawnLootPrefab(num_decor_loot.special, pt)
					end
				end
			elseif not TUNING.WINTERS_FEAST_LOOT_EXCLUSION[prefabname] and (self.inst:HasTag("monster") or self.inst:HasTag("animal")) then
				local loot = math.random()
				if loot < 0.005 then
					-- 掉落普通饰品
					if do_basic_ornament_drops then
						self:SpawnLootPrefab(GetRandomBasicWinterOrnament(), pt)
					end
				elseif loot < 0.20 then
					-- 掉落盛宴食物
					if do_food_drops then
						self:SpawnLootPrefab("winter_food"..math.random(GLOBAL.NUM_WINTERFOOD), pt)
					end
				end
			end
		
			return OldDropLoot(self, pt)
		end
	end

	--猪人金腰带概率
	if override_pig_token_chance then
		local chance = validize_chance(override_pig_token_chance)
		if chance then
			TUNING.PIG_TOKEN_CHANCE = chance
		end
	end
	-- 开启事件 猪王之年 时猪人金腰带概率
	if override_pig_token_chance_yotp then
		-- YOTP: year of the pig
		local chance = validize_chance(override_pig_token_chance_yotp)
		if chance then
			TUNING.PIG_TOKEN_CHANCE_YOTP = chance
		end
	end

end)
