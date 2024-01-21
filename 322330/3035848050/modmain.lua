-- options
local do_food_drops = GetModConfigData("food_drops")
local do_basic_ornament_drops = GetModConfigData("basic_ornament_drops")
local do_special_ornament_drops = GetModConfigData("special_ornament_drops")

if do_food_drops and do_basic_ornament_drops and do_special_ornament_drops then
	return
end

LootDropper = GLOBAL.require "components/lootdropper"

AddClassPostConstruct("components/lootdropper", 
	function(self, inst) 
		if not GLOBAL.IsSpecialEventActive(GLOBAL.SPECIAL_EVENTS.WINTERS_FEAST) then
			return 
		end
		
		function LootDropper:DropLoot(pt)
			-- copied from components/lootdropper.lua: LootDropper.DropLoot

			local prefabs = self:GenerateLoot()
			if self.inst:HasTag("burnt")
				or (self.inst.components.burnable ~= nil and
					self.inst.components.burnable:IsBurning() and
					(self.inst.components.fueled == nil or self.inst.components.burnable.ignorefuel)) then

				local isstructure = self.inst:HasTag("structure")
				for k, v in pairs(prefabs) do
					if TUNING.BURNED_LOOT_OVERRIDES[v] ~= nil then
						prefabs[k] = TUNING.BURNED_LOOT_OVERRIDES[v]
					elseif GLOBAL.PrefabExists(v.."_cooked") then
						prefabs[k] = v.."_cooked"
					elseif GLOBAL.PrefabExists("cooked"..v) then
						prefabs[k] = "cooked"..v
					--V2C: This used to make hammering WHILE burning give ash only
					--     while hammering AFTER burnt give back good ingredients.
					--     It *should* ALWAYS return ash based on certain types of
					--     ingredients (wood), but we'll let them have this one :O
					elseif (not isstructure and not self.inst:HasTag("tree")) or self.inst:HasTag("hive") then -- because trees have specific burnt loot and "hive"s are structures...
						prefabs[k] = "ash"
					end
				end
			end
			for k, v in pairs(prefabs) do
				self:SpawnLootPrefab(v, pt)
			end

			-- not necessary
			-- if GLOBAL.IsSpecialEventActive(GLOBAL.SPECIAL_EVENTS.WINTERS_FEAST) then
			
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
						self:SpawnLootPrefab("winter_food"..math.random(NUM_WINTERFOOD), pt)
					end
				end
			end
			-- end

			GLOBAL.TheWorld:PushEvent("entity_droploot", { inst = self.inst })
		end
	end
)
