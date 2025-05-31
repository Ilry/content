name = "WX78机械飞升"
author = "wiefean"
version = "1.79"

description = "版本: "..version.."\n"..
"为WX78提供强化效果。当然，只要你想，也可以是削弱。\n\n"..
"WX78：充电更快；雷击充电优化；可使用土豆或硝石充电；更快干燥；生物数据可换纸。\n\n"..
"电气化电路：去除冷却；伤害穿甲；群体反伤；攻击额外伤害；快充。\n"..
"制冷电路：稍微更冷；火焰免疫；左键灭火；在掉电前清空潮湿。\n"..
"热能电路：稍微更热；冰冻免疫；右键烹饪；潮湿免疫。\n"..
"豆增压电路：治疗更快；酸雨免疫；噩梦光环免疫；移除精神上限提升效果。\n"..
"合唱盒电路：精神恢复更快；移速加成；战斗加成；潮湿目标；音乐默认静音。\n"..
"处理器电路：科技加持；其他玩家靠近可共享效果。\n"..
"胃增益电路：减伤和位面防御。\n"..
"照明电路：更亮；移速加成。\n"..
"光电电路：在地图上实时显示部分实体位置。"


server_filter_tags = {"wx", "wx78"}

forumthread = ""
priority = 78
api_version = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
dont_starve_compatible = false
all_clients_require_mod = true

--标题
local function Title(title)
	return	{
		name = "",
		label = title,
		options = {{description = "", data = 0}},
		default = 0,
	}
end

--物品制作难度配置
local function RecipeOptions(Name, Label, defaultRecipe, originalRecipe)
	return	{
		name = "recipe_"..Name,
		hover = "配方 / Recipes",
		label = Label,
		options = {
			{description = "困难 / Hard", hover = defaultRecipe, data = true},
			{description = "原版 / Vanilla", hover = originalRecipe, data = false},
		},
		default = true,
	}
end

--电气化电路伤害范围配置
local function TaserRangeOptions1()
	local range = 1
	local options = {
		[1] = {description = "单体 / Single", data = 0},
		[17] = {description = "4", data = 4},
		[36] = {description = "7.8 !", data = 7.8}
	}

	for i = 2,16 do
		options[i] = {description = range, data = range}
		range = range + 0.2
	end
	range = 4.2
	for i = 18,35 do
		options[i] = {description = range, data = range}
		range = range + 0.2
	end
	
	return options
end
local function TaserRangeOptions2()
	local range = 1
	local options = {
		[1] = {description = "单体 / Single", data = 0},
		[36] = {description = "7.8 !", data = 7.8}
	}

	for i = 2,35 do
		options[i] = {description = range, data = range}
		range = range + 0.2
	end
	
	return options
end

--合唱盒电路音量配置
local function MusicVolumeOptions()
	local volume = 0
	local options = {
		[6] = {description = "1", data = 1},
	}

	for i1 = 1,5 do
		options[i1] = {description = volume, data = volume}
		volume = volume + 0.2
	end
	volume = 1.2
	for i2 = 7,16 do
		options[i2] = {description = volume, data = volume}
		volume = volume + 0.2
	end
	
	return options
end

--光电电路揭示实体位置配置
local function NightOptions(Name, Label)
	return 	{
        name = "night_"..Name,
        label = Label,
        hover = "实时显示位置 / Show position in real time",
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    }
end

--总开关配置
local function MainSwitch(Name)
	return 	{
        name = Name..'_main',
        label = "总开关 / Main Switch",
        hover = "关闭后改动完全失效 / Make the modifier invalid completely",
        options = {
            {description = "启用 / On", data = true},
            {description = "禁用 / Off", data = false},
        },
        default = true
    }
end

configuration_options = {
	Title("WX78"),
	MainSwitch("wx78"),
    {
        name = "wx78_chargeperiod",
        label = "充电间隔 / Charge Period",
        hover = "单位：秒 / Unit: Second",
        options = {
            {description = "5", data = 5},
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20},
            {description = "25", data = 25},
            {description = "30", data = 30},
            {description = "40", data = 40},
            {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "78 !", data = 78},
            {description = "90", data = 90},
        },
        default = 30
    },	
	{
		name = "wx78_potatocharge",
		label = "土豆充电 / Potato Charge",
		hover = "用生土豆充电 / Use raw potatoes to charge",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},	
	{
		name = "wx78_lightningcharge",
		label = "雷击优化 / Better Lightning",
		hover = "被雷击将恢复6格电量，扣除33精神值并进入一段时间的僵直，多余的电量将转化为15生命值\n绝缘状态下也受影响，但无精神值扣除和僵直，恢复的电量降低为2",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},	
	{
		name = "wx78_nitrecharge",
		label = "硝石充电 / Nitre Charge",
		hover = "用硝石充电 / Use nitre to charge",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},	
	{
        name = "wx78_discharge",
        label = "输电晨星 / Charge Night Stick",
        hover = '消耗电量为晨星恢复耐久',
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    },
	{
		name = "wx78_dry",
		label = "更快干燥 / Dry faster",
		hover = "潮湿度下降速率提升\n(身为机器人，比热容更小，很合理吧)",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "wx78_scandatacrafts",
		label = "生物数据工艺 / Data Crafts",
		hover = "1莎草纸 + 5精神值 = 10生物数据；10生物数据 + 10精神值 = 1莎草纸",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},


	Title("配方调整 / Recipes"),
	MainSwitch("recipes"),
	RecipeOptions("scanner", "扫描仪 / Scanner", "1电子元件 + 1蜘蛛丝 + 1齿轮 + 1废铁", "1电子元件 + 1蜘蛛丝"),
	RecipeOptions("sanity1", "处理器 / Processing", "1生物数据 + 1金块 + 10花瓣", "1生物数据 + 1花瓣"),
	RecipeOptions("sanity", "超级处理器/ Processing2", "3生物数据 + 2噩梦燃料 + 4电子原件 + 1处理器电路", "3生物数据 + 1噩梦燃料 + 1处理器电路"),
	RecipeOptions("bee", "豆增压 / Beanbooster", "20生物数据 + 2蜂巢 + 4蜂王浆", "8生物数据 + 1蜂王浆 + 1超级处理器电路"),
	RecipeOptions("music", "合唱盒 / Chorusbox", "20生物数据 + 三种贝壳钟 + 1独奏乐器 + 1水壶", "4生物数据 + 1低音贝壳钟"),
	RecipeOptions("hunger1", "胃增益 / Gastrogain", "2生物数据 + 3狗牙 + 2大肉 + 2怪物肉", "2生物数据 + 1狗牙"),
	RecipeOptions("hunger", "超级胃增益 / Gastrogain2", "3生物数据 + 1饥饿腰带 + 1胃增益电路", "3生物数据 + 1啜食者皮 + 1胃增益电路"),	
	RecipeOptions("heat", "热能 / Thermal", "6生物数据 + 1红宝石 + 10木炭", "4生物数据 + 1红宝石"),
	RecipeOptions("cold", "制冷 / Refrigerant", "6生物数据 + 1蓝宝石 + 10冰块", "4生物数据 + 1蓝宝石"),
	RecipeOptions("taser", "电气化 / Electrification", "10生物数据 + 1晨星 + 1羊奶", "5生物数据 + 1羊奶"),
	RecipeOptions("night", "光电 / Optoelectronic", "8生物数据 + 1紫宝石 + 1鼹鼠", "4生物数据 + 1鼹鼠 + 1萤火虫"),
	RecipeOptions("light", "照明 / Illumination", "6生物数据 + 1黄宝石 + 10荧光果", "6生物数据 + 1荧光果"),


	Title("扫描仪"),
	MainSwitch("scanner"),
	{
		name = "scanner_container",
		label = "容器 / Container",
		hover = "扫描仪在物品状态时具有6格空间\n可储存电路，电路提取器，生物数据，齿轮，电子原件，废铁和烂电线",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "scanner_repair",
		label = "电路修复 / Circuit Repairer",
		hover = "自动修复装在扫描仪中的电路",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "scanner_repairperiod",
		label = "修复间隔 / Repair Period",
		hover = "单位：秒 / Unit: Second",
        options = {	
            {description = "5", data = 5},
			{description = "7.8 !", data = 7.8},
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20},
            {description = "25", data = 25},
            {description = "30", data = 30},
            {description = "40", data = 40},
            {description = "50", data = 50},
            {description = "60 (默认)", data = 60},
            {description = "78 !", data = 78},
            {description = "90 !", data = 90},
        },
		default = 60,
	},
	{
		name = "scanner_spd",
		label = "移速 / Speed",
		hover = "",
		options = {
			{description = "x1", data = 1},
			{description = "x1.5", data = 1.5},
			{description = "x2", data = 2},
			{description = "x2.5", data = 2.5},
			{description = "x3", data = 3},
			{description = "x4", data = 4},
		},
		default = 1.5,
	},
	{
		name = "scanner_scantime",
		label = "扫描时间 / Scan Time",
		hover = "单位：秒 / Unit: Second",
        options = {
            {description = "1", data = 1},
            {description = "3", data = 3},
            {description = "5", data = 5},
            {description = "7.8 !", data = 7.8},
            {description = "10", data = 10},
            {description = "15", data = 15},
        },
		default = 5,
	},
	{
		name = "scanner_scantime2",
		label = "史诗级扫描时间 / Epic Scan Time",
		hover = "单位：秒 / Unit: Second",
        options = {
            {description = "0", data = 0},
            {description = "1", data = 1},
            {description = "3", data = 3},			
            {description = "5", data = 5},
			{description = "7.8 !", data = 7.8},
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20},
        },
		default = 10,
	},


	Title("电气化 / Electrification"),
	MainSwitch("taser"),		
    {
        name = "taser_dmg1",
        label = "反伤 / Damage Back",
        hover = "对常规目标1.5倍；对潮湿目标2.5倍；对绝缘目标不造成伤害",
        options = {
            {description = "无", data = -1},
            {description = "0", hover = "仍受增伤影响", data = 0},
            {description = "7", data = 7},
            {description = "10", data = 10},
            {description = "20", data = 20},
            {description = "30", data = 30},
            {description = "40", data = 40},
            {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "70", data = 70},
            {description = "78 !", data = 78},
        },
        default = 20
    },
    {
        name = "taser_range1",
        label = "半径 / Radius",
        hover = "单位：墙体 / Unit: Wall",
        options = TaserRangeOptions1(),
        default = 4
    },	
    {
        name = "taser_dmg2",
        label = "增伤 / Damage Boost",
        hover = "对常规目标1.5倍；对潮湿目标2.5倍；对绝缘目标不造成伤害",
        options = {
            {description = "无", data = -1},
            {description = "11", data = 11},
            {description = "15", data = 15},
            {description = "20", data = 20},
            {description = "25", data = 25},
            {description = "30", data = 30},
            {description = "35", data = 35},
            {description = "40", data = 40},
            {description = "50", data = 50},
            {description = "60", data = 60},
            {description = "70", data = 70},
            {description = "78 !", data = 78},
        },
        default = 15
    },
    {
        name = "taser_range2",
        label = "半径 / Radius",
        hover = "单位：墙体 / Unit: Wall",
        options = TaserRangeOptions2(),
        default = 0
    },
    {
        name = "taser_dmgtype",
        label = "伤害类型 / Damage Type",
        hover = "物理伤害可以被护甲抵挡\n穿甲伤害不能被护甲抵挡，但可以被减伤效果抵挡",
        options = {
            {description = "物理 / Physic", data = 1},
            {description = "穿甲 / Ignore Armor", data = 2},
            {description = "扣血 / To HP", data = 3},
        },
        default = 2
    },	
    {
        name = "taser_pvp",
        label = "PVP",
        hover = "决定反伤和增伤是否对玩家生效\n(不得不说，这玩意儿在原版除了PVP还真没啥用)",
        options = {
            {description = "是 / On", data = 1},
            {description = "自动 / Auto", data = 2},
            {description = "否 / Off", data = 3},
        },
        default = 2
    },
	{
		name = "taser_fastcharge",
		label = "饥饿充电 / Hunger Charge",
		hover = "无论是否激活，在电量未满的情况下，每隔3秒消耗饥饿值恢复一格电量\n饥饿值低于78%时不生效",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "taser_fastchargecost",
		label = "饥饿消耗 / Hunger Cost",
		hover = "",
		options = {
			{description = "0", data = 0},
			{description = "5", data = 5},
			{description = "7.8 !", data = 7.8},
			{description = "10", data = 10},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
			{description = "40", data = 40},
			{description = "50", data = 50},
		},
		default = 10,
	},	


	Title("制冷 & 热能 / Thermal & Refrigerant"),
	{
		name = "coldheat_temperature",
		label = "温度额外影响 / Extra temprature modifier",
		hover = "在原来影响20度的温度上下限的基础上再增加影响",
		options = {
			{description = "0", data = 0},
			{description = "4", data = 4},
			{description = "6", data = 6},
			{description = "7.8 !", data = 7.8},
			{description = "10", data = 10},
			{description = "12", data = 12},
			{description = "15", data = 15},
			{description = "20", data = 20},
		},
		default = 10,
	},	


	Title("制冷 / Refrigerant"),
	MainSwitch("cold"),
	{
		name = "cold_extinguish",
		label = "灭火 / Extinguish",
		hover = "左键灭火，也可扑灭闷烧物品",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},	
	{
		name = "cold_ice",
		label = "结冰潮湿值 / Icey Moisture",
		hover = "",
		options = {
			{description = "5", data = 4},
			{description = "7.8 !", data = 7.8},
			{description = "10", data = 9},
			{description = "14", data = 13},
			{description = "16", data = 18},
			{description = "20", data = 19},
			{description = "30", data = 29},
			{description = "40", data = 39},
			{description = "50", data = 49},
			{description = "95", data = 94},
		},
		default = 9,
	},	
	{
		name = "cold_icenum",
		label = "结冰数量 / Ice Num",
		hover = "",
		options = {
			{description = "0", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
		},
		default = 1,
	},	
	{
		name = "cold_fireresist",
		label = "火焰抗性 / Fire Resistance",
		hover = "",
		options = {
			{description = "0", data = 0},
			{description = "40%", data = 0.4},
			{description = "50%", data = 0.5},
			{description = "60%", data = 0.6},
			{description = "78% !", data = 0.78},
			{description = "90%", data = 0.9},
			{description = "100%", data = 1},
		},
		default = 1,
	},	


	Title("热能 / Thermal"),
	MainSwitch("heat"),
	{
		name = "heat_cooker",
		label = "烹饪 / Cooker",
		hover = "右键烹饪，队友也可以用你来烹饪物品",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "heat_freezeimmune",
		label = "冰冻免疫 / No Freeze",
		hover = "被冰冻时自动解除冰冻，不损失电量\n需要激活才能生效",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "heat_waterproof",
		label = "潮湿免疫 / Moisture Immunity",
		hover = "",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},


	Title("豆增压 / Beanbooster"),
	MainSwitch("bee"),
	{
		name = "bee_heal",
		label = "治疗量 / Heal Value",
		hover = "",
		options = {
			{description = "2", data = 2},
			{description = "5", data = 5},
			{description = "7.8 !", data = 7.8},
			{description = "10", data = 10},
			{description = "12", data = 12},
			{description = "15", data = 15},
			{description = "20", data = 20},
		},
		default = 5,
	},	
	{
		name = "bee_healperiod",
		label = "治疗间隔 / Heal Period",
		hover = "单位：秒 / Unit: Second",
		options = {
			{description = "2", data = 2},
			{description = "5", data = 5},
			{description = "7.8 !", data = 7.8},
			{description = "10", data = 10},
			{description = "12", data = 12},
			{description = "15", data = 15},
			{description = "20", data = 20},
			{description = "30", data = 30},
		},
		default = 5,
	},
	{
		name = "bee_negsanimmune",
		label = "噩梦光环免疫 / Neg-sanity Aura Immunity",
		hover = "免疫靠近怪物等带来的精神降低效果\n对影刀等装备带来的精神降低效果无效",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},
	{
		name = "bee_acidimmune",
		label = "酸雨免疫 / Acid Immunity",
		hover = "",
		options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
		},
		default = true,
	},


	Title("合唱盒电路"),
	MainSwitch("music"),
    {
        name = "music_sanityaura",
        label = "精神光环 / Sanity Aura",
        hover = "单位：每分钟",
        options = {
            {description = "0", data = 1},
            {description = "2.22", data = 2},
            {description = "4.44", data = 3},
            {description = "6.66", data = 4},
            {description = "7.8 !", data = 5},
            {description = "10", data = 6},
            {description = "20", data = 7},
        },
        default = 4
    },
    {
        name = "music_spd",
        label = "移速加成 / Speed Up",
        hover = "不可叠加 / No stack",
        options = {
            {description = "0", data = 1},
            {description = "10%", data = 1.1},
            {description = "15%", data = 1.15},
            {description = "20%", data = 1.2},
            {description = "25%", data = 1.25},
            {description = "30%", data = 1.3},
            {description = "40%", data = 1.4},
            {description = "50%", data = 1.5},
            {description = "60%", data = 1.6},
            {description = "70%", data = 1.7},
            {description = "78% !", data = 1.78},
        },
        default = 1.15
    },
    {
        name = "music_beatcombo",
        label = "战斗模式 / Combat Mode",
		hover = "不可叠加 / No stack",
        options = {
            {description = "无", hover = "不加成", data = 0},
            {description = "自动取消后摇 (默认)", hover = "攻击间隔缩短大约40%，出现模组冲突时建议切换至其他项", data = 1},
            {description = "伤害倍率", hover = "伤害x1.4，兼容性较好", data = 2},
        },
        default = 1
    },
	{
        name = "music_wet",
        label = "潮湿目标 / Wet Taget",
        hover = '',
        options = {
			{description = "是 / On", data = true},
			{description = "否 / Off", data = false},
        },
        default = true
    },	
	{
        name = "music_music",
        label = "音乐 / Music",
        hover = "",
        options = {
            {description = "无 / Off", data = 0},
            {description = "原版 / Vanilla", data = 1},
            {description = "死亡魅力", data = 2},
        },
        default = 0
    },
	{
        name = "music_volume",
        label = "音量 / Volume",
        hover = "",
        options = MusicVolumeOptions(),
        default = 1
    },

	
	Title("处理器 / Processing"),
	MainSwitch("sanity"),
    {
        name = "sanity_tech",
        label = "科技加持 / Tech",
        hover = "提供科学机器,制图台,智囊团,钓具容器效果\n超级版额外提供炼金引擎和灵子分解器效果",
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    },
    {
        name = "sanity_quickpick",
        label = "快速采集 / Quick Pick",
        hover = "超级版比普通版更快\n出现模组冲突时建议关闭该项",
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    },	
    {
        name = "sanity_quickcraft",
        label = "快速制造 / Quick Craft",
        hover = "超级版比普通版更快\n出现模组冲突时建议关闭该项",
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    },
    {
        name = "sanity_sailmult",
        label = "航海加成 / Sail Up",
        hover = "普通版和超级版无区别；加成系数同沃尔夫冈强壮形态\n不可叠加",
        options = {
            {description = "是 / On", data = true},
            {description = "否 / Off", data = false},
        },
        default = true
    },	
    {
        name = "sanity_workmult1",
        label = "砍伐和挖掘效率加成 / Chop and Dig Up",
        hover = "超级版为2倍\n相同电路不叠加效果",
        options = {
            {description = "0", data = 1},
            {description = "15%", data = 1.15},
            {description = "20%", data = 1.2},
            {description = "30%", data = 1.3},
            {description = "40%", data = 1.4},
            {description = "50%", data = 1.5},
            {description = "60%", data = 1.6},
            {description = "70%", data = 1.7},
            {description = "78% !", data = 1.78},
        },
        default = 1.5
    },
    {
        name = "sanity_workmult2",
        label = "敲击效率加成 / Mine and Hammer Up",
        hover = "普通版和超级版无区别\n相同电路不叠加效果",
        options = {
            {description = "0", data = 1},
            {description = "15%", data = 1.15},
            {description = "20%", data = 1.2},
            {description = "30%", data = 1.3},
            {description = "40%", data = 1.4},
            {description = "50%", data = 1.5},
            {description = "60%", data = 1.6},
            {description = "70%", data = 1.7},
            {description = "78% !", data = 1.78},
        },
        default = 1.5
    },


	Title("胃增益 / Gastrogain"),
	MainSwitch("hunger"),
    {
        name = "hunger_absorb",
        label = "减伤 / Absorption",
        hover = "超级版为2倍\n相同电路不叠加效果",
        options = {
            {description = "0", data = 0},
            {description = "5%", data = 0.05},
            {description = "7.8% !", data = 0.078},
            {description = "10%", data = 0.1},
            {description = "15%", data = 0.15},
            {description = "20%", data = 0.2},
        },
        default = 0.2
    },
    {
        name = "hunger_planardef",
        label = "位面防御 / Planar DEF",
        hover = "超级版为2倍\n相同电路不叠加效果",
        options = {
            {description = "0", data = 0},
            {description = "3", data = 3},
            {description = "5", data = 5},
            {description = "7.8 !", data = 7.8},
            {description = "10", data = 10},
            {description = "15", data = 15},
        },
        default = 5
    },


	Title("照明 / Illumination"),
	MainSwitch("light"),	
    {
        name = "light_radius",
        label = "半径",
        hover = "单位：墙体 / Unit: Wall",
        options = {
            {description = "3.5", data = 3.5},
            {description = "4", data = 4},
            {description = "5", data = 5},
            {description = "6", data = 6},
            {description = "7", data = 7},
            {description = "7.8", data = 7.8},
            {description = "10", data = 10},
            {description = "15", data = 15},
            {description = "20", data = 20},
        },
        default = 7.8
    },
    {
        name = "light_spd",
        label = "移速加成 / Speed Up",
        hover = "不可叠加 / No stack",
        options = {
            {description = "0", data = 1},
            {description = "10%", data = 1.1},
            {description = "15%", data = 1.15},
            {description = "20%", data = 1.2},
            {description = "25%", data = 1.25},
            {description = "30%", data = 1.3},
            {description = "35%", data = 1.35},
            {description = "40%", data = 1.4},
            {description = "50%", data = 1.5},
            {description = "60%", data = 1.6},
            {description = "70%", data = 1.7},
            {description = "78% !", data = 1.78},
        },
        default = 1.3
    },
	
	Title("光电 / Optoelectronic"),
	MainSwitch("night"),
	NightOptions("altar", "远古祭坛 / Altar"),
	NightOptions("archive_orchestrina", "远古合奏机 / Orchestrina"),
	NightOptions("atrium_gate", "远古大门 / Atrium Gate"),
	NightOptions("antlion", "蚁狮 / Antlion"),
	NightOptions("beefalo", "皮弗娄牛 / Beefalo"),
	NightOptions("beequeen", "巨大蜂窝 / Bee Queen"),
	NightOptions("chester", "眼骨和星空 / Eye Bone and Star-sky"),
	NightOptions("crabking", "帝王蟹 / Crab King"),
	NightOptions("daywalker", "大疯猪 / Werepig"),
	NightOptions("gears", "发条生物 / Gear creatures"),
	NightOptions("hermithouse", "隐士之家 / Hermit Home"),
	NightOptions("klaus_sack", "赃物袋 / Loot Stash"),
	NightOptions("lightninggoat", "伏特羊 / Volt Goat"),
	NightOptions("livingtree", "活木树 / Living Tree"),
	NightOptions("mandrake", "曼德拉草 / Mandrake"),
	NightOptions("minotaur", "远古守护者 / Ancient Guardian"),
	NightOptions("moonbase", "月台 / Moon Stone"),
	NightOptions("monkeyqueen", "猴女王 / Monkey Queen"),
	NightOptions("pigking", "猪王 / Pig King"),
	NightOptions("saltstack", "盐堆 / Salt Stack"),
	NightOptions("sculpture", "可疑大理石 / Suspicious Marble"),
	NightOptions("toadstool", "毒菌蟾蜍 / Toadstool"),
	NightOptions("terrarium", "盒中泰拉 / Terrarium"),
	NightOptions("walrus", "海象 / Walrus"),
	
}