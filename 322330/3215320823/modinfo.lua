-- This information tells other players more about the mod
local Ch = locale =="zh"or locale=="zhr"
name = Ch and
"更多无限容器" or
"More Infinite Containers"  --mod名字
description = Ch and
"使弹性空间能做用于更多容器" or
"Apply infinite stacksize to more containers"  --mod描述  --mod描述
author = "Lilith" --作者
version = "0.0.10" -- mod版本 上传mod需要两次的版本不一样

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
forumthread = ""


-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10

-- Compatible with Don't Starve Together
dst_compatible = true --兼容联机

-- Not compatible with Don't Starve
dont_starve_compatible = false --不兼容原版
reign_of_giants_compatible = false --不兼容巨人DLC

-- Character mods need this set to true
all_clients_require_mod = true --所有人mod

icon_atlas = "modicon.xml" --mod图标
icon = "modicon.tex"

-- The mod's tags displayed on the server list
server_filter_tags = {  --服务器标签
}

configuration_options =
	Ch and
{
	{
		name = "Language",
		label = "语言",
		options =   {
						{description = "English", data = false},
						{description = "简体中文", data = true},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "制作材料设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Recipeiron",
		label = "废铁数量",
		options =   {
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "4", data = 4},
					},
			default = 4,
	},
	{
		name = "Recipebra",
		label = "辉煌数量",
		options =   {
						{description = "0", data = 0},
						{description = "1", data = 1},
						{description = "2", data = 2},
					},
			default = 2,
	},
	{
		name = "Recipeshard",
		label = "碎片数量",
		options =   {
						{description = "0", data = 0},
						{description = "1", data = 1},
					},
			default = 1,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "外观设定", options = {{description = "", data = ""}}, default = ""},
	{
		name = "chestskin",
		label = "改变箱子外观",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "dragonchestskin",
		label = "改变龙鳞箱子外观",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "可升级容器", options = {{description = "", data = ""}}, default = ""},
	{
		name = "upgradeicebox",
		label = "升级冰箱",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradesaltbox",
		label = "升级盐盒",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgrademagicinechest",
		label = "升级魔术师箱子",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradebackpack",
		label = "升级背包",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradeicepack",
		label = "升级熊包",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradepigpack",
		label = "升级猪包",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradeseedpack",
		label = "升级种子袋",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradechefpack",
		label = "升级厨师包",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradecandypack",
		label = "升级糖果袋",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradekrampuspack",
		label = "升级坎普斯背包",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradeshellbox",
		label = "升级钓具箱",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradebearbox",
		label = "升级熊罐头",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradehoundpipe",
		label = "升级嚎弹炮",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgrademermstruct",
		label = "升级鱼人建筑",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradegelblob",
		label = "升级恶液箱",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradeammobag",
		label = "升级弹药袋",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
	{
		name = "upgradepicbox",
		label = "升级野餐盒",
		options =   {
						{description = "可以", data = true},
						{description = "不行", data = false},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "模组容器升级工具", options = {{description = "", data = ""}}, default = ""},
	{
		name = "useupgrademoditem",
		label = "启用模组物品空间升级",
		hover = "测试中，目前直接将容器设置为弹性空间，加载后需重新升级",
		options =   {
						{description = "启用", data = true},
						{description = "关闭", data = false},
					},
			default = false,
	},
}or
{
	{
		name = "Language",
		label = "Language",
		options =   {
						{description = "English", data = false},
						{description = "Chinese", data = true},
					},
		default = false,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "Recipe Setting", options = {{description = "", data = ""}}, default = ""},
	{
		name = "Recipeiron",
		label = "iron num",
		options =   {
						{description = "0", data = 0},
						{description = "1", data = 1},
						{description = "2", data = 2},
						{description = "4", data = 4},
					},
			default = 4,
	},
	{
		name = "Recipebra",
		label = "brilliance num",
		options =   {
						{description = "0", data = 0},
						{description = "1", data = 1},
						{description = "2", data = 2},
					},
			default = 2,
	},
	{
		name = "Recipeshard",
		label = "shard num",
		options =   {
						{description = "0", data = 0},
						{description = "1", data = 1},
					},
			default = 1,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "Appearance Settings", options = {{description = "", data = ""}}, default = ""},
	{
		name = "chestskin",
		label = "change chest appearfance",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "dragonchestskin",
		label = "change dragonchest appearfance",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "upgragable container", options = {{description = "", data = ""}}, default = ""},
	{
		name = "upgradeicebox",
		label = "upgrade icebox",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	
	{
		name = "upgradesaltbox",
		label = "upgrade saltbox",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgrademagicinechest",
		label = "upgrade magicianchest",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradebackpack",
		label = "upgrade backpack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradeicepack",
		label = "upgrade bearger pack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradepigpack",
		label = "upgrade pigpack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradeseedpack",
		label = "upgrade seedpack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradechefpack",
		label = "upgrade chefpack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradecandypack",
		label = "upgrade candypack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradekrampuspack",
		label = "upgrade krampussack",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradeshellbox",
		label = "upgrade tackle container",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradebearbox",
		label = "upgrade polar bearger bin",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradehoundpipe",
		label = "upgrade howlitzer",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgrademermstruct",
		label = "upgrade merm structure",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradegelblob",
		label = "upgrade gelblobbox",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradeammobag",
		label = "ammo bag",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
	{
		name = "upgradepicbox",
		label = "picnic box",
		options =   {
						{description = "yes", data = true},
						{description = "no", data = false},
					},
			default = true,
	},
{name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
{name = "Title", label = "upgrade item for mod container", options = {{description = "", data = ""}}, default = ""},
	{
		name = "useupgrademoditem",
		label = "use this function",
		hover = "on test, set mod container to infinite stacksize",
		options =   {
						{description = "on", data = true},
						{description = "off", data = false},
					},
			default = false,
	},
} --mod设置