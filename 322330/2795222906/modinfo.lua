name = "便携雕塑"
author = "铭之所名"
version = "1.1"
description = [[

可捡入物品栏【可疑的大理石、13个领主雕塑、三暗影雕塑、陶伦自带2雕塑、玻璃尖刺、部分雕塑、岩石】

显示地图图标【天体祭坛、天体圣殿、帝王蟹、邪天翁、水中木、可疑大理石、大理石雕像、毒菌蟾蜍、远古伪科学站、远古大门】
]]

forumthread = ""
api_version = 10

dst_compatible = true
server_only_mod = true
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

local function AddTitle(title) return { name = "null",label = title,options = {{ description = "", data = 0 },},default = 0,} end

configuration_options = 
{
	AddTitle("雕塑"),
	{
		name = "keyidalishi",
		label = "可疑的大理石",
		hover = "可疑的大理石(组装部件):主教、骑士、战车\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "主教、骑士、战车组装部件可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "主教、骑士、战车组装部件可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "taolundiaosu",
		label = "陶伦雕塑",
		hover = "丰饶角、泡泡烟斗雕塑\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "丰饶角、泡泡烟斗雕塑可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "丰饶角、泡泡烟斗雕塑可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "diaosusanjilao",
		label = "三暗影雕塑",
		hover = "三暗影雕塑\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "三暗影雕塑可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "三暗影雕塑可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "jutoulingzhu",
		label = "13领主",
		hover = "13领主雕塑\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "13巨头领主雕塑可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "13巨头领主雕塑可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "tiantizuzhuang",
		label = "天体科学组装物",
		hover = "天体祭坛(3部分)、天体贡品(1部分)、天体圣殿(2部分)\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "天体祭坛(3部分)、天体贡品(1部分)、天体圣殿(2部分)可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "天体祭坛(3部分)、天体贡品(1部分)、天体圣殿(2部分)可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "bolidiaosu",
		label = "玻璃尖刺",
		hover = "玻璃尖刺(4部分)、玻璃城堡\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "玻璃尖刺(4部分)、玻璃城堡可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "玻璃尖刺(4部分)、玻璃城堡可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "qitadiaosu",
		label = "其他部分雕塑",
		hover = "魔眼、猫、牛、国王、女王、卒子、座狼、猎犬、月亮、月娥、锚、胡萝卜鼠雕塑\n注意：搬运拾起选项是移除了可装备功能",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "魔眼、猫、牛、国王、女王、卒子、座狼、猎犬、月亮、月娥、锚、胡萝卜鼠雕塑可右键搬运拖入物品栏"},
			{description = "搬运拾起", data = 2, hover = "魔眼、猫、牛、国王、女王、卒子、座狼、猎犬、月亮、月娥、锚、胡萝卜鼠雕塑可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	{
		name = "yanshi",
		label = "岩石",
		hover = "可搬运的岩石",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "搬运拖入", data = 1, hover = "可搬运的岩石可右键搬运捡入物品栏"},
		},
		default = 1,
	},
	AddTitle("地图图标"),
	{
		name = "tubiao_keyidalishi",
		label = "可疑大理石",
		hover = "地图上显示可疑大理石",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示可疑大理石的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_dalishi",
		label = "大理石雕像",
		hover = "地图上显示大理石雕像",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示大理石雕像的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_tiantizuzhuang",
		label = "天体科学组装物",
		hover = "地图上显示天体祭坛(3部分)、天体贡品(1部分)、天体圣殿(2部分)\n这6部分需探取，若未探取则不显示。此选项适合给其他玩家显示位置",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "其他未探明地图的玩家，也显示天体祭坛(3部分)、天体贡品(1部分)、天体圣殿(2部分)的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_tiantishengdian",
		label = "未探取的天体圣殿",
		hover = "未探取的天体圣殿2部分在地图上显示图标",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示天体圣殿(2部分)的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_tiantijipin",
		label = "未开采的天体祭品",
		hover = "未开采的天体祭品3部分在地图上显示图标",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示天体祭品(3部分)的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_diwangxie",
		label = "帝王蟹",
		hover = "地图上显示帝王蟹\n显示帝王蟹以便捞取天体贡品",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示帝王蟹的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_shuizhongmu",
		label = "水中木",
		hover = "地图上显示水中木",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示水中木的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_xietianweng",
		label = "邪天翁",
		hover = "地图上显示邪天翁",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示1", data = 1, hover = "若存在邪天翁则显示其位置"},
			{description = "显示2", data = 2, hover = "地图显示鱼群刷新点，且若存在邪天翁则显示其位置"},
		},
		default = 2,
	},
	{
		name = "tubiao_xietianweng1",
		label = "邪天翁图标",
		hover = "邪天翁图标的选择\n邪天翁没有地图图标的贴图，借用其他贴图",
		options ={
			{description = "龙虾", data = "wobster_den", hover = "用龙虾显示地图上的邪天翁(龙虾只在岸边，而邪天翁在鱼群刷新点附近)"},
			{description = "船", data = "boat", hover = "用船显示地图上的邪天翁"},
			{description = "远古伪科学站", data = "tab_crafting_table", hover = "用远古伪科学站显示地图上的邪天翁"},
		},
		default = "wobster_den",
	},
	{
		name = "tubiao_yuangukeji",
		label = "远古伪科学站",
		hover = "地图上显示远古伪科学站",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示远古伪科学站的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_yuangudamen",
		label = "远古大门",
		hover = "地图上显示远古大门",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示远古大门的位置"},
		},
		default = 1,
	},
	{
		name = "tubiao_chanchu",
		label = "毒菌蟾蜍",
		hover = "地图上显示毒菌蟾蜍",
		options ={
			{description = "关闭", data = false, hover = "不启用"},
			{description = "显示", data = 1, hover = "未探明的地图，也显示毒菌蟾蜍的位置"},
		},
		default = 1,
	},
}