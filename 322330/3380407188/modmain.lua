--GLOBAL相关照抄
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

--获取modinfo的配置值

--洞察点上限
local insights_max = GetModConfigData("insights_max")
--洞察点取消限制条件
local insights_lock = GetModConfigData("insights_lock")


--预制物文件
PrefabFiles = {}

--载入资源
Assets = {}

--技能点突破上限
local base_SKILL_THRESHOLDS = GLOBAL.TUNING.SKILL_THRESHOLDS
local function addNumberFive(times)
times = times - 15
	if times > 0 then
		for i = 1, times do
			table.insert(base_SKILL_THRESHOLDS, 1)
		end
	end
end

addNumberFive(insights_max)
GLOBAL.TUNING.SKILL_THRESHOLDS = base_SKILL_THRESHOLDS

--解锁条件修改
GLOBAL.setfenv(1, GLOBAL)
local skilltree_defs = require("prefabs/skilltree_defs")
if insights_lock == 0 then
	--威尔逊月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wilson"].wilson_allegiance_lock_5.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "shadow_favor", skillselection) >= 0
	end
	skilltree_defs.SKILLTREE_DEFS["wilson"].wilson_allegiance_lock_4.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "lunar_favor", skillselection) >= 0
	end
	--伍迪四级变身不锁定其他两形态
	skilltree_defs.SKILLTREE_DEFS["woodie"].woodie_curse_beaver_lock.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "beaver", skillselection) >= 3
	end
	skilltree_defs.SKILLTREE_DEFS["woodie"].woodie_curse_moose_lock.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "moose", skillselection) >= 3
	end
	skilltree_defs.SKILLTREE_DEFS["woodie"].woodie_curse_goose_lock.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "goose", skillselection) >= 3
	end
	--伍迪月影亲和不互锁（去掉对应亲和标记，绕开另一线路第三个锁：有另外亲和标记上锁）
	skilltree_defs.SKILLTREE_DEFS["woodie"].woodie_allegiance_shadow.tags = {"allegiance","shadow"}
	skilltree_defs.SKILLTREE_DEFS["woodie"].woodie_allegiance_lunar.tags = {"allegiance","lunar"}
	--大力士月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_shadow_1.tags = {"allegiance","shadow"}
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_shadow_2.tags = {"allegiance","shadow"}
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_shadow_3.tags = {"allegiance","shadow"}
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_lunar_1.tags = {"allegiance","lunar"}
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_lunar_2.tags = {"allegiance","lunar"}
	skilltree_defs.SKILLTREE_DEFS["wolfgang"].wolfgang_allegiance_lunar_3.tags = {"allegiance","lunar"}
	--女武神月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wathgrithr"].wathgrithr_allegiance_shadow.tags = {"shadow"}
	skilltree_defs.SKILLTREE_DEFS["wathgrithr"].wathgrithr_allegiance_lunar.tags = {"lunar"}
	--植物人不存在此问题
	--火女月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["willow"].willow_allegiance_lock_1.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "shadow_favor", skillselection) >= 0
	end
	skilltree_defs.SKILLTREE_DEFS["willow"].willow_allegiance_lock_4.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "lunar_favor", skillselection) >= 0
	end
	--女工月影亲和不互锁（亲和条件改为点数计数，不对比其他）
	skilltree_defs.SKILLTREE_DEFS["winona"].winona_charlie_2_lock.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "charlie", skillselection) >= 1
	end
	skilltree_defs.SKILLTREE_DEFS["winona"].winona_wagstaff_2_lock.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "wagstaff", skillselection) >= 1
	end
	--鱼妹月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wurt"].wurt_shadow_allegiance_1.tags = {"allegiance", "shadow"}
	skilltree_defs.SKILLTREE_DEFS["wurt"].wurt_lunar_allegiance_1.tags = {"allegiance", "lunar"}
	--恶魔月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wortox"].wortox_allegiance_shadow.tags = {"allegiance", "shadow"}
	skilltree_defs.SKILLTREE_DEFS["wortox"].wortox_allegiance_lunar.tags = {"allegiance", "lunar"}
	--沃尔特月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["walter"].walter_ammo_shadow.tags = {"allegiance","slingshotammo_crafting", "shadow", "shadow"}
	skilltree_defs.SKILLTREE_DEFS["walter"].walter_ammo_lunar.tags = {"allegiance","slingshotammo_crafting", "shadow", "lunar"}
	skilltree_defs.SKILLTREE_DEFS["walter"].walter_woby_shadow.tags = {"allegiance", "shadow"}
	skilltree_defs.SKILLTREE_DEFS["walter"].walter_woby_lunar.tags = {"allegiance", "lunar"}
	--温蒂月影亲和不互锁
	skilltree_defs.SKILLTREE_DEFS["wendy"].wendy_shadow_lock_2.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "lunar_favor", skillselection) >= 0
	end
	skilltree_defs.SKILLTREE_DEFS["wendy"].wendy_lunar_lock_2.lock_open = function(prefabname, skillselection)
		return skilltree_defs.FN.CountTags(prefabname, "shadow_favor", skillselection) >= 0
	end
end

