local Ch = (locale == 'zh' or locale == 'zhr')
name = Ch and "防卡好多招" or "Lag Remover"
author = "大大果汁、凉时白开、小瑾、天涯共此时、小花朵"
version = "2.6.4"
description1 = Ch and [[
特别感谢：大大果汁、凉时白开、小瑾
功能包括：
 ・ 1.掉落物自动堆叠；
 ・ 2.设置物品最大堆叠数量(40-999)；
 ・ 3.更多原本不可堆叠物品可进行堆叠；
 ・ 4.定期清理服务器垃圾物品(可配置。超过配置数量部分会被清理);
 ・ 5.按U私聊框，输入命令#clean_world可立即清理；
 ・ 6.鱼人王、猪王、鸟笼、蚁狮可以批量交互；
 ・ 7.禁止树木重生；
 ・ 8.普通小树枝替换多枝树；
 ・ 9.砍树不留根；
 ・ 10.更多内容查看创意工坊介绍页；
 
 ・ 只清理【自动清理细项】中的内容，其余物品不会被清理。
 ・ 有用物品记得放宝箱，超过配置数量部分会被清理！
]]  or [[
Special thanks: 大大果汁、凉时白开、小瑾
Features include:
 ・ 1. Falling objects are automatically stacked;
 ・ 2. Set the maximum number of stacked items(40-200);
 ・ 3. More non-stackable items can be stacked;
 ・ 4. Remove server garbage regularly(configurable).
 ・ 5. Press the U private chat box and enter the command #clean_world to clean it immediately
 ・ 6. Fast trading with Pigking, Mermking, birds
 ・ 7. Prohibit the regeneration of trees;
 ・ 8. Common twigs replace multi-branched trees;
 ・ 9. Cut down trees without leaving roots;
 ・ 10. See the introduction page of Creative Workshop for more information;
]]

description = '〔望月〕版本号: ' .. version .. '\n\n' .. description1

forumthread = ""
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = false
dst_compatible = true
client_only_mod = false
all_clients_require_mod = true
server_filter_tags = {"stack", "clean"}


local cleancycle = {}
cleancycle[1] = {description=""..(1).."", data=1}
cleancycle[2] = {description=""..(3).."", data=3}
for i=5,20,5 do cleancycle[i/5+2] = {description=""..(i).."", data=i} end

local stackradius = {}
for i=5,45,5 do stackradius[i/5] = {description=""..(i).."", data=i} end

local cleanunitx1 = {}
for i=0,40 do cleanunitx1 [i+1] = {description=""..(i).."", data=i} end

local cleanunitx5 = {}
for i=0,40 do cleanunitx5 [i+1] = {description=""..(i*5).."", data=(i*5)} end

local cleanunitx10 = {}
for i=0,40 do cleanunitx10 [i+1] = {description=""..(i*10).."", data=(i*10)} end

if Ch then
	cleanunitx1[0]  = {description="全清理", data=0}
	cleanunitx5[0]  = {description="全清理", data=0}
	cleanunitx10[0] = {description="全清理", data=0}
	
	cleanunitx1[42]  = {description="不清理", data=99999}
	cleanunitx5[42]  = {description="不清理", data=99999}
	cleanunitx10[42] = {description="不清理", data=99999}
else
	cleanunitx1[42]  = {description="Never clean up", data=99999}
	cleanunitx5[42]  = {description="Never clean up", data=99999}
	cleanunitx10[42] = {description="Never clean up", data=99999}
end

-- 添加分段标题
local function addTitle(title)
	return {
		name = "EmptyNull",
		label = title,
		hover = nil,
		options = {
				{ description = "", data = 0 }
		},
		default = 0,
	}
end

configuration_options =
Ch and
{
	addTitle("==基本功能配置=="),
		{
			name = "CH_LANG",
			label = "语言(Language)",
			options =
			{
				{description = "中文", data = true},
				{description = "English", data = false},
			},
			default = true,
		},
		{
			name = "AUTO_STACK",
			label = "掉落堆叠",
			hover = "设置是否开启掉落物自动堆叠",
			options =
			{
				{description = "开", data = true, hover = "掉落相同的物品会自动堆叠在一起"},
				{description = "关", data = false,hover = "掉落相同的物品不会自动堆叠"},
			},
			default = true,
		},
		
		{
			name = 'STACK_RADIUS',
			label = '堆叠半径',
			hover = "设置你的堆叠半径",
			options = stackradius,
			default = 10,
		},
		{
			name = "STACK_SIZE",
			label = "堆叠数值",
			hover = "设置可堆叠物品的堆叠上限数值，建议最大999",
			options = 
			{	
				{description = "原始数值", data = 0},
				{description = "40", data = 40},
				{description = "99", data = 99},
				{description = "100", data = 100},
				{description = "200", data = 200},
				{description = "500", data = 500},
				{description = "999", data = 999},
				{description = "100000", data = 100000,hover = "可能存在异常，建议最大999"},
			},
			default = 100,
		},
	
		
		{
			name = "STACK_OTHER_OBJECTS",
			label = "更多堆叠",
			hover = "可堆叠鱼类、鸟类、高脚鸟等原本不可堆叠的物品",
			options = 
			{	
				{description = "开启A", data = "A", hover = "此配置下可堆叠小兔子、鼹鼠、鸟类、蜘蛛类等等，包括高鸟蛋和岩浆虫卵"},
				{description = "开启B", data = "B",hover = "此配置下可堆叠小兔子、鼹鼠、鸟类、蜘蛛类等等，不包括高鸟蛋和岩浆虫卵"},
				{description = "禁用", data = "OFF"},
			},
			default = "A",
		},
		{
			name = "BATCH_TRADE",
			label = "批量交易",
			hover = "支持猪王、鸟笼、鱼人王批量交易，不兼容永不妥协",
			options = 
			{	
				{description = "开启", data = true},
				{description = "禁用", data = false},
			},
			default = true,
		},
		{
		    name = "TREES_NO_STUMP",
			label = "伐树无根",
			hover = "砍伐树木后，自动移除树根(掉落1个木头)，防止卡顿",
			options = 
			{	
				{description = "开启", data = true, hover = "砍伐树木后，自动移除树根，防止卡顿。不出树精，慎用",},
				{description = "禁用", data = false},
			},
			default = true,
		},
		{
		    name = "TREES_NO_REGROWTH",
			label = "禁止树木循环",
			hover = "部分树木和大理石树长到第三阶段即停止循环生长， 防止卡顿",
			options = 
			{	
				{description = "开启", data = true},
				{description = "禁用", data = false},
			},
			default = true,
		},
		{
		    name = "TWIGGY",
			label = "我不要多枝树",
			hover = "世界所有多枝树变成普通可采集小树苗",
			options = 
			{	
				{description = "开启", data = true},
				{description = "禁用", data = false},
			},
			default = false,
		},
		{
			name = "AUTO_CLEAN",
			label = "自动清理",
			hover = "设置是否开启定时清理服务器无用物品",
			options =
			{
				{description = "开", data = true, hover = "每过 N 天自动清理服务器无用物品"},
				{description = "关", data = false, hover = "啥事儿都不发生"},
			},
			default = true,
		},
		{
			name = "CLEAN_DAYS",
			label = "清理周期",
			options = cleancycle,
			default = 5,	
			hover = "每N天清理进行一次清理",
		},
		{
			name = "ANNOUNCE_MODE",
			label = "清理宣告",
			options =
			{
				{description = "关", data = false},
				{description = "开", data = true},
			},
			default = false,
			hover = "在游戏中以公告的形式说明具体清理内容",
		},
		{
			name = "TEST_MODE",
			label = "测试模式",
			options =
			{
				{description = "开", data = true, hover = "测试模式开，清理周期变为10秒一次"},
				{description = "关", data = false, hover = "测试模式关。"},
			},
			default = false,
			hover = "测试模式_非必要请勿修改",
		},
	addTitle("==自动清理细项=="),
		{
			name = "tentaclespike",
			label = "触手尖刺",
			options = cleanunitx5,
			default = 5,	
			hover = "触手尖刺的最大数量",
		},
		{
			name = "grassgekko",
			label = "草蜥蜴",
			options = cleanunitx5,
			default = 15,	
			hover = "草蜥蜴的最大数量",
		},
		{
			name = "armor_sanity",
			label = "影甲",
			options = cleanunitx1,
			default = 3,	
			hover = "影甲的最大数量",
		},
		{
			name = "shadowheart",
			label = "影心",
			options = cleanunitx1,
			default = 3,	
			hover = "影心的最大数量",
		},
		{
			name = "hound",
			label = "狗",
			options = cleanunitx1,
			default = 10,	
			hover = "狗的最大数量",
		},
		{
			name = "firehound",
			label = "火狗",
			options = cleanunitx1,
			default = 10,	
			hover = "火狗的最大数量",
		},
		{
			name = "spider",
			label = "蜘蛛/蜘蛛战士",
			options = cleanunitx1,
			default = 10,	
			hover = "蜘蛛/蜘蛛战士最大数量",
		},
		{
			name = "flies",
			label = "苍蝇/蚊子",
			options = cleanunitx1,
			default = 10,	
			hover = "苍蝇/蚊子的最大数量",
		},
		{
			name = "bee",
			label = "蜜蜂/杀人蜂",
			options = cleanunitx1,
			default = 10,	
			hover = "蜜蜂/杀人蜂的最大数量",
		},
		{
			name = "frog",
			label = "青蛙",
			options = cleanunitx1,
			default = 20,	
			hover = "青蛙的最大数量",
		},
		{
			name = "beefalo",
			label = "牛",
			options = cleanunitx5,
			default = 50,	
			hover = "牛的最大数量",
		},
		{
			name = "deer",
			label = "鹿",
			options = cleanunitx1,
			default = 10,	
			hover = "鹿的最大数量",
		},
		{
			name = "slurtle",
			label = "鼻涕虫/蜗牛",
			options = cleanunitx1,
			default = 5,	
			hover = "鼻涕虫/蜗牛的最大数量",
		},
		{
			name = "rocky",
			label = "石虾",
			options = cleanunitx1,
			default = 20,	
			hover = "石虾的最大数量",
		},
		{
			name = "evergreen_sparse",
			label = "常青树",
			options = cleanunitx10,
			default = 150,	
			hover = "常青树的最大数量",
		},
		{
			name = "twiggytree",
			label = "树枝树",
			options = cleanunitx10,
			default = 150,	
			hover = "树枝树的最大数量",
		},
		{
			name = "marsh_tree",
			label = "针刺树",
			options = cleanunitx10,
			default = 100,	
			hover = "针刺树的最大数量",
		},
		{
			name = "rock_petrified_tree",
			label = "石化树",
			options = cleanunitx10,
			default = 150,	
			hover = "石化树的最大数量",
		},
		{
			name = "skeleton_player",
			label = "玩家尸体",
			options = cleanunitx1,
			default = 20,	
			hover = "玩家尸体的最大数量",
		},
		{
			name = "spiderden",
			label = "蜘蛛巢",
			options = cleanunitx5,
			default = 40,	
			hover = "蜘蛛巢的最大数量",
		},
		{
			name = "burntground",
			label = "陨石痕跡",
			options = cleanunitx1,
			default = 5,	
			hover = "陨石痕跡的最大数量",
		},
		{
			name = "seeds",
			label = "种子",
			options = cleanunitx1,
			default = 3,	
			hover = "种子的最大数量",
		},
		{
			name = "log",
			label = "木头",
			options = cleanunitx5,
			default = 50,	
			hover = "木头的最大数量",
		},
		{
			name = "pinecone",
			label = "松果",
			options = cleanunitx5,
			default = 50,	
			hover = "松果的最大数量",
		},
		{
			name = "cutgrass",
			label = "草",
			options = cleanunitx5,
			default = 50,	
			hover = "草的最大数量",
		},
		{
			name = "twigs",
			label = "树枝",
			options = cleanunitx5,
			default = 50,	
			hover = "树枝的最大数量",
		},
		{
			name = "rocks",
			label = "石头",
			options = cleanunitx5,
			default = 50,	
			hover = "石头的最大数量",
		},
		{
			name = "nitre",
			label = "硝石",
			options = cleanunitx5,
			default = 50,	
			hover = "硝石的最大数量",
		},
		{
			name = "flint",
			label = "燧石",
			options = cleanunitx5,
			default = 50,	
			hover = "燧石的最大数量",
		},
		{
			name = "poop",
			label = "屎",
			options = cleanunitx1,
			default = 5,	
			hover = "屎的最大数量",
		},
		{
			name = "guano",
			label = "鸟屎",
			options = cleanunitx1,
			default = 1,	
			hover = "鸟屎的最大数量",
		},
		{
			name = "manrabbit_tail",
			label = "兔毛",
			options = cleanunitx1,
			default = 20,	
			hover = "兔毛的最大数量",
		},
		{
			name = "silk",
			label = "蜘蛛丝",
			options = cleanunitx1,
			default = 10,	
			hover = "蜘蛛丝的最大数量",
		},
		{
			name = "spidergland",
			label = "蜘蛛腺体",
			options = cleanunitx1,
			default = 10,	
			hover = "蜘蛛腺体的最大数量",
		},
		{
			name = "stinger",
			label = "蜂刺",
			options = cleanunitx1,
			default = 2,	
			hover = "蜂刺的最大数量",
		},
		{
			name = "houndstooth",
			label = "狗牙",
			options = cleanunitx1,
			default = 2,	
			hover = "狗牙的最大数量",
		},
		{
			name = "mosquitosack",
			label = "蚊子血袋",
			options = cleanunitx1,
			default = 10,	
			hover = "蚊子血袋的最大数量",
		},
		{
			name = "glommerfuel",
			label = "格罗姆粘液",
			options = cleanunitx1,
			default = 10,	
			hover = "格罗姆粘液的最大数量",
		},
		{
			name = "slurtleslime",
			label = "鼻涕虫粘液/鼻涕虫壳碎片",
			options = cleanunitx1,
			default = 2,	
			hover = "鼻涕虫粘液/鼻涕虫壳碎片的最大数量",
		},
		{
			name = "spoiled_food",
			label = "腐烂食物",
			options = cleanunitx1,
			default = 2,	
			hover = "腐烂食物的最大数量",
		},
		{
			name = "festival",
			label = "节日小饰品/食物/玩具",
			options = cleanunitx1,
			default = 2,	
			hover = "节日小饰品/食物/玩具的最大数量",
		},
		{
			name = "blueprint",
			label = "蓝图",
			options = cleanunitx1,
			default = 3,	
			hover = "蓝图的最大数量",
		},
		{
			name = "axe",
			label = "斧子",
			options = cleanunitx1,
			default = 3,	
			hover = "斧子的最大数量",
		},
		{
			name = "torch",
			label = "火炬",
			options = cleanunitx1,
			default = 3,	
			hover = "火炬的最大数量",
		},
		{
			name = "pickaxe",
			label = "镐子",
			options = cleanunitx1,
			default = 3,	
			hover = "镐子的最大数量",
		},
		{
			name = "hammer",
			label = "锤子",
			options = cleanunitx1,
			default = 3,	
			hover = "锤子的最大数量",
		},
		{
			name = "shovel",
			label = "铲子",
			options = cleanunitx1,
			default = 3,	
			hover = "铲子的最大数量",
		},
		{
			name = "razor",
			label = "剃刀",
			options = cleanunitx1,
			default = 3,	
			hover = "剃刀的最大数量",
		},
		{
			name = "pitchfork",
			label = "草叉",
			options = cleanunitx1,
			default = 3,	
			hover = "草叉的最大数量",
		},
		{
			name = "bugnet",
			label = "捕虫网",
			options = cleanunitx1,
			default = 3,	
			hover = "捕虫网的最大数量",
		},
		{
			name = "fishingrod",
			label = "鱼竿",
			options = cleanunitx1,
			default = 3,	
			hover = "鱼竿的最大数量",
		},
		{
			name = "spear",
			label = "矛",
			options = cleanunitx1,
			default = 3,	
			hover = "矛的最大数量",
		},
		{
			name = "earmuffshat",
			label = "兔耳罩",
			options = cleanunitx1,
			default = 3,	
			hover = "兔耳罩的最大数量",
		},
		{
			name = "winterhat",
			label = "冬帽",
			options = cleanunitx1,
			default = 3,	
			hover = "冬帽的最大数量",
		},
		{
			name = "heatrock",
			label = "热能石",
			options = cleanunitx1,
			default = 10,	
			hover = "热能石的最大数量",
		},
		{
			name = "trap",
			label = "动物陷阱",
			options = cleanunitx1,
			default = 30,	
			hover = "动物陷阱的最大数量",
		},
		{
			name = "birdtrap",
			label = "鸟陷阱",
			options = cleanunitx1,
			default = 10,	
			hover = "鸟陷阱的最大数量",
		},
		{
			name = "compass",
			label = "指南針",
			options = cleanunitx1,
			default = 3,	
			hover = "指南針的最大数量",
		},
		{
			name = "driftwood_log",
			label = "浮木桩",
			options = cleanunitx10,
			default = 130,	
			hover = "浮木桩的最大数量",
		},
		{
			name = "spoiled_fish",
			label = "变质的鱼/小鱼",
			options = cleanunitx1,
			default = 2,	
			hover = "变质的鱼/小鱼的最大数量",
		},
		{
			name = "rottenegg",
			label = "腐烂的蛋",
			options = cleanunitx1,
			default = 2,	
			hover = "腐烂的蛋的最大数量",
		},
		{
			name = "feather",
			label = "羽毛、啜食者毛",
			options = cleanunitx1,
			default = 2,	
			hover = "羽毛、啜食者毛的最大数量",
		},
		{
			name = "pocket_scale",
			label = "弹簧秤",
			options = cleanunitx1,
			default = 3,	
			hover = "弹簧秤的最大数量",
		},
		{
			name = "oceanfishingrod",
			label = "海钓竿",
			options = cleanunitx1,
			default = 3,	
			hover = "海钓竿的最大数量",
		},
		{
			name = "sketch",
			label = "图纸",
			options = cleanunitx1,
			default = 1,	
			hover = "",
		},
		{
			name = "tacklesketch",
			label = "广告",
			options = cleanunitx1,
			default = 1,	
			hover = "",
		},
} or
{
	addTitle("Basic Function Configurations"),
		{
			name = "CH_LANG",
			label = "语言(Language)",
			options =
			{
				{description = "中文", data = true},
				{description = "English", data = false},
			},
			default = false,
		},
		{
			name = "AUTO_STACK",
			label = "Auto stack",
			options =
			{
				{description = "On", data = true, hover = "Auto stack the same items on the ground."},
				{description = "Off", data = false, hover = "Nothing will happen."},
			},
			default = true,
		},
		
		{
			name = 'STACK_RADIUS',
			label = 'Stack sadius',
			options = stackradius,
			default = 10,
		},
		{
			name = "STACK_SIZE",
			label = "Stack size",
			hover = "Stack size，The recommended maximum is 999",
			options = 
			{	
				{description = "Raw value", data = 0},
				{description = "40", data = 40},
				{description = "99", data = 99},
				{description = "100", data = 100},
				{description = "200", data = 200},
				{description = "500", data = 500},
				{description = "999", data = 999},
				{description = "100000", data = 100000,hover = "An exception may occur. The recommended maximum is 999"},
			},
			default = 100,
		},
		{
			name = "STACK_OTHER_OBJECTS",
			label = "Additional Items Stackable",
			hover = "Now you can stack fish, birds, tall bird egg, horn etc",
			options = 
			{	
				{description = "On", data = "A"},
				{description = "Off", data = "OFF"},
			},
			default = "A",
		},
		{
			name = "BATCH_TRADE",
			label = "Batch trade",
			hover = "instead of trade 1 by 1 , now you can trade a stack of item at once. Works to PigKing, Birds, MerdKing",
			options = 
			{	
				{description = "On", data = true},
				{description = "Off", data = false},
			},
			default = true,
		},
		{
		    name = "TREES_NO_STUMP",
			label = "Trees no stump",
			hover = "After chopping down trees, the stumps are automatically removed",
			options = 
			{	
				{description = "On", data = true},
				{description = "Off", data = false},
			},
			default = true,
		},
		{
		    name = "TREES_NO_REGROWTH",
			label = "Trees no Regrowth",
			hover = "Evergreen, Marble trees and few other trees will stop regrowth at their 3rd stage.",
			options = 
			{	
				{description = "On", data = true},
				{description = "Off", data = false},
			},
			default = true,
		},
		{
		    name = "TWIGGY",
			label = "No Twiggy",
			hover = "No more Twiggy in the game.",
			options = 
			{	
				{description = "On", data = true},
				{description = "Off", data = false},
			},
			default = false,
		},
		{
			name = "AUTO_CLEAN",
			label = "Auto Clean",
			hover = "Clean the world in centain time, to make sure you game smooth. ",
			options =
			{
				{description = "On", data = true, hover = "All servers clean every N days"},
				{description = "Off", data = false, hover = "Nothing will happen."},
			},
			default = true,
		},
		{
			name = "CLEAN_DAYS",
			label = "Cleaning cycle",
			hover = "Clean up per N days",
			options = cleancycle,
			default = 5,	
			
		},
		{
			name = "ANNOUNCE_MODE",
			label = "Cleaning announcements",
			hover = "List what items cleaned by the mod",
			options =
			{
				{description = "Off", data = false},
				{description = "On", data = true},
			},
			default = false,
			
		},
		{
			name = "TEST_MODE",
			label = "Test mode",
			options =
			{
				{description = "On", data = true, hover = "Test mode on, clean cycle = 10s."},
				{description = "Off", data = false, hover = "Test mode off"},
			},
			default = false,
			hover = "only for writer, leave it off",
		},
	addTitle("Automatic Cleaning Of Details"),
		{
			name = "tentaclespike",
			label = "tentaclespike",
			options = cleanunitx5,
			default = 5,	
			hover = "the maximum amount of the tentaclespike",
		},
		{
			name = "grassgekko",
			label = "grassgekko",
			options = cleanunitx5,
			default = 15,	
			hover = "the maximum amount of the grassgekko",
		},
		{
			name = "armor_sanity",
			label = "armor_sanity",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the armor_sanity",
		},
		{
			name = "shadowheart",
			label = "shadowheart",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the shadowheart",
		},
		{
			name = "hound",
			label = "hound",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the hound",
		},
		{
			name = "firehound",
			label = "firehound",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the firehound",
		},
		{
			name = "spider",
			label = "spider/spider_warrior",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the spider/spider_warrior",
		},
		{
			name = "flies",
			label = "flies/mosquito",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the flies/mosquito",
		},
		{
			name = "bee",
			label = "bee/killerbee",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the bee/killerbee",
		},
		{
			name = "frog",
			label = "frog",
			options = cleanunitx1,
			default = 20,	
			hover = "the maximum amount of the frog",
		},
		{
			name = "beefalo",
			label = "beefalo",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the beefalo",
		},
		{
			name = "deer",
			label = "deer",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the deer",
		},
		{
			name = "slurtle",
			label = "slurtle/snurtle",
			options = cleanunitx1,
			default = 5,	
			hover = "the maximum amount of the slurtle/snurtle",
		},
		{
			name = "rocky",
			label = "rocky",
			options = cleanunitx1,
			default = 20,	
			hover = "the maximum amount of the rocky",
		},
		{
			name = "evergreen_sparse",
			label = "evergreen_sparse",
			options = cleanunitx10,
			default = 150,	
			hover = "the maximum amount of the evergreen_sparse",
		},
		{
			name = "twiggytree",
			label = "twiggytree",
			options = cleanunitx10,
			default = 150,	
			hover = "the maximum amount of the twiggytree",
		},
		{
			name = "marsh_tree",
			label = "marsh_tree",
			options = cleanunitx10,
			default = 100,	
			hover = "the maximum amount of the marsh_tree",
		},
		{
			name = "rock_petrified_tree",
			label = "rock_petrified_tree",
			options = cleanunitx10,
			default = 150,	
			hover = "the maximum amount of the rock_petrified_tree",
		},
		{
			name = "skeleton_player",
			label = "skeleton_player",
			options = cleanunitx1,
			default = 20,	
			hover = "the maximum amount of the skeleton_player",
		},
		{
			name = "spiderden",
			label = "spiderden",
			options = cleanunitx5,
			default = 40,	
			hover = "the maximum amount of the spiderden",
		},
		{
			name = "burntground",
			label = "burntground",
			options = cleanunitx1,
			default = 5,	
			hover = "the maximum amount of the burntground",
		},
		{
			name = "seeds",
			label = "seeds",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the seeds",
		},
		{
			name = "log",
			label = "log",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the log",
		},
		{
			name = "pinecone",
			label = "pinecone",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the pinecone",
		},
		{
			name = "cutgrass",
			label = "cutgrass",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the cutgrass",
		},
		{
			name = "twigs",
			label = "twigs",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the twigs",
		},
		{
			name = "rocks",
			label = "rocks",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the rocks",
		},
		{
			name = "nitre",
			label = "nitre",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the nitre",
		},
		{
			name = "flint",
			label = "flint",
			options = cleanunitx5,
			default = 50,	
			hover = "the maximum amount of the flint",
		},
		{
			name = "poop",
			label = "poop",
			options = cleanunitx1,
			default = 5,	
			hover = "the maximum amount of the poop",
		},
		{
			name = "guano",
			label = "guano",
			options = cleanunitx1,
			default = 1,	
			hover = "the maximum amount of the guano",
		},
		{
			name = "manrabbit_tail",
			label = "manrabbit_tail",
			options = cleanunitx1,
			default = 20,	
			hover = "the maximum amount of the manrabbit_tail",
		},
		{
			name = "silk",
			label = "silk",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the silk",
		},
		{
			name = "spidergland",
			label = "spidergland",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the spidergland",
		},
		{
			name = "stinger",
			label = "stinger",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the stinger",
		},
		{
			name = "houndstooth",
			label = "houndstooth",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the houndstooth",
		},
		{
			name = "mosquitosack",
			label = "mosquitosack",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the mosquitosack",
		},
		{
			name = "glommerfuel",
			label = "glommerfuel",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the glommerfuel",
		},
		{
			name = "slurtleslime",
			label = "slurtleslime/slurtle_shellpieces",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the slurtleslime/slurtle_shellpieces",
		},
		{
			name = "spoiled_food",
			label = "spoiled_food",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the spoiled_food",
		},
		{
			name = "festival",
			label = "winter_ornament_plain/winter_ornament_boss/halloweencandy/trinket/winter_food",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the winter_ornament_plain/winter_ornament_boss/halloweencandy/trinket/winter_food",
		},
		{
			name = "blueprint",
			label = "blueprint",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the blueprint",
		},
		{
			name = "axe",
			label = "axe",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the axe",
		},
		{
			name = "torch",
			label = "torch",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the torch",
		},
		{
			name = "pickaxe",
			label = "pickaxe",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the pickaxe",
		},
		{
			name = "hammer",
			label = "hammer",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the hammer",
		},
		{
			name = "shovel",
			label = "shovel",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the shovel",
		},
		{
			name = "razor",
			label = "razor",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the razor",
		},
		{
			name = "pitchfork",
			label = "pitchfork",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the pitchfork",
		},
		{
			name = "bugnet",
			label = "bugnet",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the bugnet",
		},
		{
			name = "fishingrod",
			label = "fishingrod",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the fishingrod",
		},
		{
			name = "spear",
			label = "spear",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the spear",
		},
		{
			name = "earmuffshat",
			label = "earmuffshat",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the earmuffshat",
		},
		{
			name = "winterhat",
			label = "winterhat",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the winterhat",
		},
		{
			name = "heatrock",
			label = "heatrock",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the heatrock",
		},
		{
			name = "trap",
			label = "trap",
			options = cleanunitx1,
			default = 30,	
			hover = "the maximum amount of the trap",
		},
		{
			name = "birdtrap",
			label = "birdtrap",
			options = cleanunitx1,
			default = 10,	
			hover = "the maximum amount of the birdtrap",
		},
		{
			name = "compass",
			label = "compass",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the compass",
		},
		{
			name = "driftwood_log",
			label = "driftwood_log",
			options = cleanunitx10,
			default = 130,	
			hover = "the maximum amount of the driftwood_log",
		},
		{
			name = "spoiled_fish",
			label = "spoiled_fish/small",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the spoiled_fish/small",
		},
		{
			name = "rottenegg",
			label = "rottenegg",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the rottenegg",
		},
		{
			name = "feather",
			label = "feather/slurper_pelt",
			options = cleanunitx1,
			default = 2,	
			hover = "the maximum amount of the feather/slurper_pelt",
		},
		{
			name = "pocket_scale",
			label = "pocket_scale",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the pocket_scale",
		},
		{
			name = "oceanfishingrod",
			label = "oceanfishingrod",
			options = cleanunitx1,
			default = 3,	
			hover = "the maximum amount of the oceanfishingrod",
		},
		{
			name = "sketch",
			label = "sketch",
			options = cleanunitx1,
			default = 1,	
			hover = "the maximum amount of all the sketch",
		},
		{
			name = "tacklesketch",
			label = "tacklesketch",
			options = cleanunitx1,
			default = 1,	
			hover = "the maximum amount of all the tacklesketch",
		},
}
