name = "Alter Guardian Hat / 启蒙皇冠"

description =
	[[
Make Alterguardian hat craftable.
Do not open alterguardian hat when it's equiped.
When it's already equiped, right click to open it.
Add some extra options to make the hat even more powerful.

启蒙皇冠可以制作。
装备启蒙皇冠时不再自动打开格子。
已经戴上启蒙皇冠的情况下可以右键打开。
给启蒙皇冠增加了一些额外的选项。
]]

author = "asingingbird"

version = "4.4"

dst_compatible = true

all_clients_require_mod = true

api_version = 6

api_version_dst = 10

forumthread = ""

icon_atlas = "modicon.xml"

icon = "modicon.tex"

configuration_options = {
	{
		name = "craftable",
		label = "Craftable / 可制作",
		hover = "Alterguardian Hat Shard and Alterguardian Hat are Craftable / 皇冠碎片和皇冠可制作",
		options = {
			{description = "Disable / 关闭", data = false},
			{description = "Enable / 开启", data = true}
		},
		default = false
	},
	{
		name = "disable_auto_open",
		label = "Disable Auto Open / 装备时不自动打开",
		hover = "Disable Auto Open / 装备时不自动打开",
		options = {
			{description = "No / 自动打开", data = false},
			{description = "Yes / 不自动打开", data = true}
		},
		default = true
	},
	{
		name = "sanity_loss_when_attack",
		label = "Sanity Loss When Attack/攻击时降低理智值",
		hover = "Sanity Loss On Every Attack/每次攻击时降低的理智值",
		options = {
			{description = "2 (Gain 2 / 获得2)", data = 2},
			{description = "1 (Gain 1 / 获得1)", data = 1},
			{description = "0", data = 0},
			{description = "-1 (Default / 默认)", data = -1},
			{description = "-2 (Loss 2 / 失去2)", data = -2}
		},
		default = -1
	},
	{
		name = "activate_threshold",
		label = "Activate Threshold / 启动阈值",
		hover = "No Light Buff or Gestalt Spawned If Sanity Below This Threshold / 理智值低于这个阈值时不再提供照明，也不再生成月岛精灵辅助攻击",
		options = {
			{description = "0% (Always / 始终激活)", data = 0},
			{description = "30%", data = 0.3},
			{description = "50%", data = 0.5},
			{description = "80%", data = 0.8},
			{description = "85% (Default / 默认)", data = 0.85},
			{description = "90%", data = 0.9}
		},
		default = 0.85
	},
	{
		name = "gestalt_spawn_num",
		label = "Gestalt To Spawn / 召唤月岛精灵的个数",
		hover = "Number Of Gestalts Spawned For Every Attack / 每次攻击时召唤月岛精灵的个数",
		options = {
			{description = "0", data = 0},
			{description = "1 (Default / 默认)", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3}
		},
		default = 1
	},
	{
		name = "armor_absorb_percent",
		label = "Armor / 防御",
		hover = "Absorb Percent / 护甲值",
		options = {
			{description = "0% (Default / 默认)", data = 0},
			{description = "20%", data = 0.2},
			{description = "50%", data = 0.5},
			{description = "80%", data = 0.8},
			{description = "90%", data = 0.9},
			{description = "95%", data = 0.95},
			{description = "100%", data = 1}
		},
		default = 0
	},
	{
		name = "damage_multiplier",
		label = "More Damage / 攻击力加成",
		hover = "The Player Deals More Damage To Others / 攻击力加成",
		options = {
			{description = "1 (Default / 默认)", data = 1},
			{description = "1.25", data = 1.25},
			{description = "1.5", data = 1.5},
			{description = "2", data = 2},
			{description = "4", data = 4},
			{description = "8", data = 8}
		},
		default = 1
	},
	{
		name = "walkspeedmult",
		label = "Walk Faster/ 移速加成",
		hover = "Walk Speed Multiplier/ 移速加成",
		options = {
			{description = "1 (Default / 默认)", data = 1},
			{description = "1.25", data = 1.25},
			{description = "1.5", data = 1.5},
			{description = "1.8", data = 1.8},
			{description = "2", data = 2},
			{description = "2.5", data = 2.5}
		},
		default = 1
	},
	{
		name = "waterproofness",
		label = "Waterproofness / 防雨",
		hover = "Waterproofness / 防雨",
		options = {
			{description = "0 (Default / 默认)", data = 0},
			{description = "0.2", data = 0.2},
			{description = "0.5", data = 0.5},
			{description = "0.7", data = 0.7},
			{description = "0.9", data = 0.9},
			{description = "1", data = 1}
		},
		default = 0
	},
	{
		name = "mild_temperature",
		label = "Mild Temperature / 温度舒适",
		hover = "The Player Will Never Be Cold Or Hot / 玩家永远不会热或冷",
		options = {
			{description = "Disable / 关闭", data = false},
			{description = "Enable / 开启", data = true}
		},
		default = false
	},
	{
		name = "fire_immune",
		label = "Fire Immune / 免疫燃烧伤害",
		hover = "Fire Immune / 免疫燃烧伤害",
		options = {
			{description = "Disable / 关闭", data = false},
			{description = "Enable / 开启", data = true}
		},
		default = false
	},
	{
		name = "goggles_vision",
		label = "Goggles Vision / 护目镜效果",
		hover = "The Player Has Goggles Vision In Storms / 玩家在风暴中拥有护目镜效果",
		options = {
			{description = "Disable / 关闭", data = false},
			{description = "Enable / 开启", data = true}
		},
		default = false
	},
	{
		name = "beefalo_friendly",
		label = "Beefalo Friendly / 不会被发情的牛攻击",
		hover = "Beefalo Will Not Attack You During Mating Season / 不会被发情的牛攻击",
		options = {
			{description = "Disable / 关闭", data = false},
			{description = "Enable / 开启", data = true}
		},
		default = false
	}
}
