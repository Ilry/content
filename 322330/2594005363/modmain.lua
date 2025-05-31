--	冰箱
	TUNING.PERISH_FRIDGE_MULT = GetModConfigData("fridge_config");
	
--	冰块
	local ice_refroze = GetModConfigData("fridge_ice_config");
	if ice_refroze and TUNING.PERISH_FRIDGE_MULT < 0 then
		TUNING.PERISH_COLD_FROZEN_MULT = -1;
	end
	
--	盐罐
	TUNING.PERISH_SALTBOX_MULT = GetModConfigData("saltbox_config");
	
-- 盐晶
	TUNING.SALTROCK_PRESERVE_PERCENT_ADD = GetModConfigData("saltrock_config");
	AddPrefabPostInit("lightbulb", function(inst)
		inst:AddComponent("cookable")
	end)
	AddPrefabPostInit("wormlight", function(inst)
		inst:AddComponent("cookable")
	end)
	AddPrefabPostInit("wormlight_lesser", function(inst)
		inst:AddComponent("cookable")
	end)

--	极地熊獾桶
	TUNING.BEARGERFUR_SACK_PRESERVER_RATE = GetModConfigData("beargerfur_sack_config")
	
-- 蘑菇灯
	TUNING.PERISH_MUSHROOM_LIGHT_MULT = GetModConfigData("mushroom_light_config");
	
-- 种子袋
	TUNING.SEEDPOUCH_PRESERVER_RATE = GetModConfigData("seedpouch_config")

-- 背包
	local backpack = GetModConfigData("backpack_config");
	
	AddPrefabPostInit("backpack", function(inst)
		if backpack == 1 then
			inst:AddTag("fridge")
		end
		if backpack == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)
	
-- 小猪包
	local piggyback = GetModConfigData("piggyback_config");
	
	AddPrefabPostInit("piggyback", function(inst)
		if piggyback == 1 then
			inst:AddTag("fridge")
		end
		if piggyback == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)

-- 隔热背包
	local icepack = GetModConfigData("icepack_config");

	AddPrefabPostInit("icepack", function(inst)
		if icepack == 1 then
			inst:RemoveTag("nocool")
		end
	end)

-- 种子包
	local seedpouch = GetModConfigData("seedpouch_config");

	AddPrefabPostInit("seedpouch", function(inst)
		if seedpouch == 1 then
			inst:AddTag("fridge")
		end
		if seedpouch == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)
	
-- 威尔逊 胡子
local beard_sack = GetModConfigData("beard_sack_config");

	AddPrefabPostInit("beard_sack_1", function(inst)
		if beard_sack == 1 then
			inst:AddTag("fridge")
		end
		if beard_sack == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)
	
	AddPrefabPostInit("beard_sack_2", function(inst)
		if beard_sack == 1 then
			inst:AddTag("fridge")
		end
		if beard_sack == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)
	
	AddPrefabPostInit("beard_sack_3", function(inst)
		if beard_sack == 1 then
			inst:AddTag("fridge")
		end
		if beard_sack == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)

-- 小偷包
	local krampus_sack = GetModConfigData("krampus_sack_config");

	AddPrefabPostInit("krampus_sack", function(inst)
		if krampus_sack == 1 then
			inst:AddTag("fridge")
		end
		if krampus_sack == 2 then
			inst:AddTag("fridge")
			inst:AddTag("nocool")
		end
	end)

--骨灰盒
	local sisturn = GetModConfigData("sisturn_config");
	
	if sisturn then
		TUNING.WENDY_SISTURN_PETAL_PRESRVE = 0
	end

--烹饪锅
	local cookpot = GetModConfigData("cookingPot_config")

	AddPrefabPostInit("cookpot", function(inst)
		if cookpot then
			inst:AddTag("fridge")
		end
	end)

-- 普通钓具
	local tackelContainer = GetModConfigData("tackelContainer_config")
	
	AddPrefabPostInit("tacklecontainer", function(inst)
		if tackelContainer then
			inst:AddTag("fridge")
			end
	end)
	
	AddPrefabPostInit("supertacklecontainer", function(inst)
		if tackelContainer then
			inst:AddTag("fridge")
			end
	end)
	
-- 鱼人食堂
	local offeringPot = GetModConfigData("offeringPot_config")
	
	AddPrefabPostInit("offering_pot", function(inst)
		if offeringPot then
			inst:AddTag("fridge")
			end
	end)
	
	AddPrefabPostInit("offering_pot_upgraded", function(inst)
		if offeringPot then
			inst:AddTag("fridge")
			end
	end)
--哈奇
	local cookpot = GetModConfigData("hutch_config")

	AddPrefabPostInit("hutch", function(inst)
		if cookpot then
			inst:AddTag("fridge")
		end
	end)

