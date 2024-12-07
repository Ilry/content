---@diagnostic disable: undefined-global
---@type string
local modid = 'lol_wp' -- 定义唯一modid

---@type LAN_TOOL_COORDS
LOLWP_C = require('core_'..modid..'/utils/coords')
---@type LAN_TOOL_SUGARS
LOLWP_S = require('core_'..modid..'/utils/sugar')

rawset(GLOBAL,'LOLWP_C',LOLWP_C)
rawset(GLOBAL,'LOLWP_S',LOLWP_S)

local new_PrefabFiles = {
	-- 'lol_wp_module_dishes',
	-- 'lol_wp_module_particle',
	'lol_wp_sheen',
	'lol_wp_divine',
	'lol_wp_trinity',
	'fx_lol_wp_trinity',
	'lol_wp_terraprisma',
	-- S6
    'lol_wp_overlordbloodarmor',
	'lol_wp_warmogarmor',
	'lol_wp_demonicembracehat',
	-- S7
	'lol_wp_s7_cull',
	'lol_wp_s7_doranblade',
	'lol_wp_s7_doranshield',
	'lol_wp_s7_doranring',
	'lol_wp_s7_tearsofgoddess',
	'lol_wp_s7_obsidianblade',
	-- s8
	'lol_wp_s8_deathcap',
	'lol_wp_s8_uselessbat',
	'lol_wp_s8_lichbane',
	-- s9
	'lol_wp_s9_guider',
	'lol_wp_s9_eyestone_low',
	'lol_wp_s9_eyestone_high',
}

local new_Assets = {
    Asset("ATLAS","images/tab_lol_wp.xml"),

	Asset("SOUNDPACKAGE","sound/soundfx_lol_wp_divine.fev"),
	Asset("SOUND","sound/soundfx_lol_wp_divine.fsb"),

	-- 其他码师的物品的invimg
	Asset("ATLAS","images/inventoryimages/gallop_bloodaxe.xml"),
	Asset("ATLAS","images/inventoryimages/gallop_breaker.xml"),
	Asset("ATLAS","images/inventoryimages/gallop_whip.xml"),
}

for _, v in pairs(new_Assets) do table.insert(Assets, v) end
for _, v in pairs(new_PrefabFiles) do table.insert(PrefabFiles, v) end

-- 导入常量表
modimport('scripts/core_'..modid..'/data/tuning.lua')

-- 导入工具
modimport('scripts/core_'..modid..'/utils/_register.lua')

-- 导入功能API
modimport('scripts/core_'..modid..'/api/_register.lua')

-- 导入mod配置
TUNING['CONFIG_'..string.upper(modid)..'_LANG'] = currentlang == 'zh' and 'cn' or 'en'
TUNING[string.upper('CONFIG_'..modid..'eyestone_allow_lolamulet_only')] = GetModConfigData('eyestone_allow_lolamulet_only')

-- 导入语言文件
modimport('scripts/core_'..modid..'/languages/'..TUNING['CONFIG_'..string.upper(modid)..'_LANG']..'.lua')

-- 导入调用器
-- modimport('scripts/core_'..modid..'/callers/caller_badge.lua')
modimport('scripts/core_'..modid..'/callers/caller_ca.lua')
modimport('scripts/core_'..modid..'/callers/caller_container.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_dish.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_keyhandler.lua')
modimport('scripts/core_'..modid..'/callers/caller_recipes.lua')
-- modimport('scripts/core_'..modid..'/callers/caller_stack.lua')


-- 导入UI

-- 注册客机组件
AddReplicableComponent('lol_wp_s7_cull_counter')
AddReplicableComponent('lol_wp_s7_tearsofgoddess')

-- 导入钩子
modimport('scripts/core_'..modid..'/hooks/fix_bug_souljump.lua')
modimport('scripts/core_'..modid..'/hooks/sup.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_sheen.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_divine.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_trinity.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_overlordbloodarmor.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_warmogarmor.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_demonicembracehat.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s7_cull.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s7_doranring.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s7_tearsofgoddess.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s7_obsidianblade.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s7_doranshield.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s8_deathcap.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s8_uselessbat.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s8_lichbane.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s9_guider.lua')
modimport('scripts/core_'..modid..'/hooks/lol_wp_s9_eyestone_container.lua')


-- 导入sg
modimport('scripts/core_'..modid..'/sg/leap_atk.lua')



