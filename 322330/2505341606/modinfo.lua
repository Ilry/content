name = "防卡两招_改(Antistun_changed)"
description = 
[[能够把掉落物自动堆叠，同时定期清理服务器。
清理机制：以腐烂食物为例：假设整个世界有5组腐烂食物，他们各自的堆叠数量为(1,6,18,40,40),清理过程会将5组腐烂食物清理至2组，至于删除哪3组，随机。
所以服务器会清理的东西如果想不被清理掉：
一定要放箱子里或者随手做个背包扔地上放背包里！！！
一定要放箱子里或者随手做个背包扔地上放背包里！！！
一定要放箱子里或者随手做个背包扔地上放背包里！！！

v2.3: 新增自定义修改萤火虫是否堆叠。
v2.2: 新增可自定义修改堆叠范围检测。
v2.1: 新增boss图纸清理、boss广告清理、新增测试模式。
v2.0: 新增！！：可自定义修改物品的最大清理阈值。
v1.0: 新增自定义修改清理天数周期(1~40天，默认15天)。
可在游戏内以公告的形式显示当次具体清理内容(默认开)
公告格式：(物品名称)(物品代码)(原有个数)(清理个数)(剩余个数)
详细介绍见mod详情页。
]]
author = "小瑾"
version = "2.3.0"
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
for i=1,40 do cleancycle[i] = {description=""..(i).."", data=i} end
local cleanunitx1 = {}
for i=1,40 do cleanunitx1 [i] = {description=""..(i).."", data=i} end
local cleanunitx5 = {}
for i=1,40 do cleanunitx5 [i] = {description=""..(i*5).."", data=(i*5)} end
local cleanunitx10 = {}
for i=1,40 do cleanunitx10 [i] = {description=""..(i*10).."", data=(i*10)} end


configuration_options =
{
    {
        name = "stack",
        label = "自动堆叠(Stacking)",
        options =
        {
            {description = "开", data = true, hover = "掉落相同的物品会 boom 的一声堆叠起来。Auto stack the same loots."},
            {description = "关", data = false, hover = "啥事儿都不发生。Nothing will happen."},
        },
        default = true,
    },
	{
        name = "stack_fireflies",
        label = "堆叠萤火虫(Stack fireflies)",
        options =
        {
            {description = "开", data = true, hover = "萤火虫启用堆叠。Auto stack fireflies."},
            {description = "关", data = false, hover = "萤火虫不启用堆叠。Fireflies won't be stacked."},
        },
        default = true,
    },
    {
        name = "clean",
        label = "自动清理(Cleaning)",
        options =
        {
            {description = "开", data = true, hover = "每过 N 天自动清理服务器无用物品。All servers clean every N days"},
            {description = "关", data = false, hover = "啥事儿都不发生。Nothing will happen."},
        },
        default = true,
    },
    {
        name = "lang",
        label = "语言(Language)",
        options =
        {
            {description = "中文", data = true},
            {description = "English", data = false},
        },
        default = true,
    },
	{
		name = "CLEANDAYS",
		label = "清理周期(天)(Cleaning cycle(days))",
		options = cleancycle,
		default = 15,	
		hover = "每N天清理进行一次清理(Clean up per N days)",
	},
	{
		name = "stack_scanning_range",
		label = "堆叠检测范围(stack_scanning_range)",
		options = cleanunitx1,
		default = 10,	
		hover = "堆叠检测范围。Stack scanning range",
	},
    {
        name = "ANNOUNCE_MODE",
        label = "局内宣告(Announce in game)",
        options =
        {
            {description = "开", data = true},
            {description = "关", data = false},
        },
        default = true,
		hover = "在游戏中以公告的形式说明具体清理内容。Explain the specific cleanup content in the form of announcements in the game",
    },
	{
		name = "hound",
		label = "狗(hound)",
		options = cleanunitx1,
		default = 10,	
		hover = "狗的最大数量(the maximum amount of the hound)",
	},
	{
		name = "firehound",
		label = "火狗(firehound)",
		options = cleanunitx1,
		default = 10,	
		hover = "火狗的最大数量(the maximum amount of the firehound)",
	},
	{
		name = "spider",
		label = "蜘蛛/蜘蛛战士(spider/spider_warrior)",
		options = cleanunitx1,
		default = 10,	
		hover = "蜘蛛/蜘蛛战士最大数量(the maximum amount of the spider/spider_warrior)",
	},
	{
		name = "flies",
		label = "苍蝇/蚊子(flies/mosquito)",
		options = cleanunitx1,
		default = 10,	
		hover = "苍蝇/蚊子的最大数量(the maximum amount of the flies/mosquito)",
	},
	{
		name = "bee",
		label = "蜜蜂/杀人蜂(bee/killerbee)",
		options = cleanunitx1,
		default = 10,	
		hover = "蜜蜂/杀人蜂的最大数量(the maximum amount of the bee/killerbee)",
	},
	{
		name = "frog",
		label = "青蛙(frog)",
		options = cleanunitx1,
		default = 20,	
		hover = "青蛙的最大数量(the maximum amount of the frog)",
	},
	{
		name = "beefalo",
		label = "牛(beefalo)",
		options = cleanunitx5,
		default = 50,	
		hover = "牛的最大数量(the maximum amount of the beefalo)",
	},
	{
		name = "deer",
		label = "鹿(deer)",
		options = cleanunitx1,
		default = 10,	
		hover = "鹿的最大数量(the maximum amount of the deer)",
	},
	{
		name = "slurtle",
		label = "鼻涕虫/蜗牛(slurtle/snurtle)",
		options = cleanunitx1,
		default = 5,	
		hover = "鼻涕虫/蜗牛的最大数量(the maximum amount of the slurtle/snurtle)",
	},
	{
		name = "rocky",
		label = "石虾(rocky)",
		options = cleanunitx1,
		default = 20,	
		hover = "石虾的最大数量(the maximum amount of the rocky)",
	},
	{
		name = "evergreen_sparse",
		label = "常青树(evergreen_sparse)",
		options = cleanunitx10,
		default = 150,	
		hover = "常青树的最大数量(the maximum amount of the evergreen_sparse)",
	},
	{
		name = "twiggytree",
		label = "树枝树(twiggytree)",
		options = cleanunitx10,
		default = 150,	
		hover = "树枝树的最大数量(the maximum amount of the twiggytree)",
	},
	{
		name = "marsh_tree",
		label = "针刺树(marsh_tree)",
		options = cleanunitx10,
		default = 100,	
		hover = "针刺树的最大数量(the maximum amount of the marsh_tree)",
	},
	{
		name = "rock_petrified_tree",
		label = "石化树(rock_petrified_tree)",
		options = cleanunitx10,
		default = 150,	
		hover = "石化树的最大数量(the maximum amount of the rock_petrified_tree)",
	},
	{
		name = "skeleton_player",
		label = "玩家尸体(skeleton_player)",
		options = cleanunitx1,
		default = 20,	
		hover = "玩家尸体的最大数量(the maximum amount of the skeleton_player)",
	},
	{
		name = "spiderden",
		label = "蜘蛛巢(spiderden)",
		options = cleanunitx5,
		default = 40,	
		hover = "蜘蛛巢的最大数量(the maximum amount of the spiderden)",
	},
	{
		name = "burntground",
		label = "陨石痕跡(burntground)",
		options = cleanunitx1,
		default = 5,	
		hover = "陨石痕跡的最大数量(the maximum amount of the burntground)",
	},
	{
		name = "seeds",
		label = "种子(seeds)",
		options = cleanunitx1,
		default = 3,	
		hover = "种子的最大数量(the maximum amount of the seeds)",
	},
	{
		name = "log",
		label = "木头(log)",
		options = cleanunitx5,
		default = 50,	
		hover = "木头的最大数量(the maximum amount of the log)",
	},
	{
		name = "pinecone",
		label = "松果(pinecone)",
		options = cleanunitx5,
		default = 50,	
		hover = "松果的最大数量(the maximum amount of the pinecone)",
	},
	{
		name = "cutgrass",
		label = "草(cutgrass)",
		options = cleanunitx5,
		default = 50,	
		hover = "草的最大数量(the maximum amount of the cutgrass)",
	},
	{
		name = "twigs",
		label = "树枝(twigs)",
		options = cleanunitx5,
		default = 50,	
		hover = "树枝的最大数量(the maximum amount of the twigs)",
	},
	{
		name = "rocks",
		label = "石头(rocks)",
		options = cleanunitx5,
		default = 50,	
		hover = "石头的最大数量(the maximum amount of the rocks)",
	},
	{
		name = "nitre",
		label = "硝石(nitre)",
		options = cleanunitx5,
		default = 50,	
		hover = "硝石的最大数量(the maximum amount of the nitre)",
	},
	{
		name = "flint",
		label = "燧石(flint)",
		options = cleanunitx5,
		default = 50,	
		hover = "燧石的最大数量(the maximum amount of the flint)",
	},
	{
		name = "poop",
		label = "屎(poop)",
		options = cleanunitx1,
		default = 5,	
		hover = "屎的最大数量(the maximum amount of the poop)",
	},
	{
		name = "guano",
		label = "鸟屎(guano)",
		options = cleanunitx1,
		default = 1,	
		hover = "鸟屎的最大数量(the maximum amount of the guano)",
	},
	{
		name = "manrabbit_tail",
		label = "兔毛(manrabbit_tail)",
		options = cleanunitx1,
		default = 20,	
		hover = "兔毛的最大数量(the maximum amount of the manrabbit_tail)",
	},
	{
		name = "silk",
		label = "蜘蛛丝(silk)",
		options = cleanunitx1,
		default = 10,	
		hover = "蜘蛛丝的最大数量(the maximum amount of the silk)",
	},
	{
		name = "spidergland",
		label = "蜘蛛腺体(spidergland)",
		options = cleanunitx1,
		default = 10,	
		hover = "蜘蛛腺体的最大数量(the maximum amount of the spidergland)",
	},
	{
		name = "stinger",
		label = "蜂刺(stinger)",
		options = cleanunitx1,
		default = 2,	
		hover = "蜂刺的最大数量(the maximum amount of the stinger)",
	},
	{
		name = "houndstooth",
		label = "狗牙(houndstooth)",
		options = cleanunitx1,
		default = 2,	
		hover = "狗牙的最大数量(the maximum amount of the houndstooth)",
	},
	{
		name = "mosquitosack",
		label = "蚊子血袋(mosquitosack)",
		options = cleanunitx1,
		default = 10,	
		hover = "蚊子血袋的最大数量(the maximum amount of the mosquitosack)",
	},
	{
		name = "glommerfuel",
		label = "格罗姆粘液(glommerfuel)",
		options = cleanunitx1,
		default = 10,	
		hover = "格罗姆粘液的最大数量(the maximum amount of the glommerfuel)",
	},
	{
		name = "slurtleslime",
		label = "鼻涕虫粘液/鼻涕虫壳碎片(slurtleslime/slurtle_shellpieces)",
		options = cleanunitx1,
		default = 2,	
		hover = "鼻涕虫粘液/鼻涕虫壳碎片的最大数量(the maximum amount of the slurtleslime/slurtle_shellpieces)",
	},
	{
		name = "spoiled_food",
		label = "腐烂食物(spoiled_food)",
		options = cleanunitx1,
		default = 2,	
		hover = "腐烂食物的最大数量(the maximum amount of the spoiled_food)",
	},
	{
		name = "festival",
		label = "节日小饰品/食物/玩具(winter_ornament_plain/winter_ornament_boss/halloweencandy/trinket/winter_food)",
		options = cleanunitx1,
		default = 2,	
		hover = "节日小饰品/食物/玩具的最大数量(the maximum amount of the winter_ornament_plain/winter_ornament_boss/halloweencandy/trinket/winter_food)",
	},
	{
		name = "blueprint",
		label = "蓝图(blueprint)",
		options = cleanunitx1,
		default = 3,	
		hover = "蓝图的最大数量(the maximum amount of the blueprint)",
	},
	{
		name = "axe",
		label = "斧子(axe)",
		options = cleanunitx1,
		default = 3,	
		hover = "斧子的最大数量(the maximum amount of the axe)",
	},
	{
		name = "torch",
		label = "火炬(torch)",
		options = cleanunitx1,
		default = 3,	
		hover = "火炬的最大数量(the maximum amount of the torch)",
	},
	{
		name = "pickaxe",
		label = "镐子(pickaxe)",
		options = cleanunitx1,
		default = 3,	
		hover = "镐子的最大数量(the maximum amount of the pickaxe)",
	},
	{
		name = "hammer",
		label = "锤子(hammer)",
		options = cleanunitx1,
		default = 3,	
		hover = "锤子的最大数量(the maximum amount of the hammer)",
	},
	{
		name = "shovel",
		label = "铲子(shovel)",
		options = cleanunitx1,
		default = 3,	
		hover = "铲子的最大数量(the maximum amount of the shovel)",
	},
	{
		name = "razor",
		label = "剃刀(razor)",
		options = cleanunitx1,
		default = 3,	
		hover = "剃刀的最大数量(the maximum amount of the razor)",
	},
	{
		name = "pitchfork",
		label = "草叉(pitchfork)",
		options = cleanunitx1,
		default = 3,	
		hover = "草叉的最大数量(the maximum amount of the pitchfork)",
	},
	{
		name = "bugnet",
		label = "捕虫网(bugnet)",
		options = cleanunitx1,
		default = 3,	
		hover = "捕虫网的最大数量(the maximum amount of the bugnet)",
	},
	{
		name = "fishingrod",
		label = "鱼竿(fishingrod)",
		options = cleanunitx1,
		default = 3,	
		hover = "鱼竿的最大数量(the maximum amount of the fishingrod)",
	},
	{
		name = "spear",
		label = "矛(spear)",
		options = cleanunitx1,
		default = 3,	
		hover = "矛的最大数量(the maximum amount of the spear)",
	},
	{
		name = "earmuffshat",
		label = "兔耳罩(earmuffshat)",
		options = cleanunitx1,
		default = 3,	
		hover = "兔耳罩的最大数量(the maximum amount of the earmuffshat)",
	},
	{
		name = "winterhat",
		label = "冬帽(winterhat)",
		options = cleanunitx1,
		default = 3,	
		hover = "冬帽的最大数量(the maximum amount of the winterhat)",
	},
	{
		name = "heatrock",
		label = "热能石(heatrock)",
		options = cleanunitx1,
		default = 10,	
		hover = "热能石的最大数量(the maximum amount of the heatrock)",
	},
	{
		name = "trap",
		label = "动物陷阱(trap)",
		options = cleanunitx1,
		default = 30,	
		hover = "动物陷阱的最大数量(the maximum amount of the trap)",
	},
	{
		name = "birdtrap",
		label = "鸟陷阱(birdtrap)",
		options = cleanunitx1,
		default = 10,	
		hover = "鸟陷阱的最大数量(the maximum amount of the birdtrap)",
	},
	{
		name = "compass",
		label = "指南針(compass)",
		options = cleanunitx1,
		default = 3,	
		hover = "指南針的最大数量(the maximum amount of the compass)",
	},
	{
		name = "driftwood_log",
		label = "浮木桩(driftwood_log)",
		options = cleanunitx10,
		default = 130,	
		hover = "浮木桩的最大数量(the maximum amount of the driftwood_log)",
	},
	{
		name = "spoiled_fish",
		label = "变质的鱼/小鱼(spoiled_fish/small)",
		options = cleanunitx1,
		default = 2,	
		hover = "变质的鱼/小鱼的最大数量(the maximum amount of the spoiled_fish/small)",
	},
	{
		name = "rottenegg",
		label = "腐烂的蛋(rottenegg)",
		options = cleanunitx1,
		default = 2,	
		hover = "腐烂的蛋的最大数量(the maximum amount of the rottenegg)",
	},
	{
		name = "feather",
		label = "羽毛、啜食者毛(feather/slurper_pelt)",
		options = cleanunitx1,
		default = 2,	
		hover = "羽毛、啜食者毛的最大数量(the maximum amount of the feather/slurper_pelt)",
	},
	{
		name = "pocket_scale",
		label = "弹簧秤(pocket_scale)",
		options = cleanunitx1,
		default = 3,	
		hover = "弹簧秤的最大数量(the maximum amount of the pocket_scale)",
	},
	{
		name = "oceanfishingrod",
		label = "海钓竿(oceanfishingrod)",
		options = cleanunitx1,
		default = 3,	
		hover = "海钓竿的最大数量(the maximum amount of the oceanfishingrod)",
	},
	{
		name = "sketch",
		label = "图纸(sketch)",
		options = cleanunitx1,
		default = 1,	
		hover = "(the maximum amount of all the sketch)",
	},
	{
		name = "tacklesketch",
		label = "广告(tacklesketch)",
		options = cleanunitx1,
		default = 1,	
		hover = "(the maximum amount of all the tacklesketch)",
	},
	
	
	
	
	
	{
		name = "test_mode",
		label = "测试模式_非必要请勿修改",
		options =
        {
            {description = "开", data = true, hover = "测试模式开，清理周期变为10秒一次。Test mode on, clean cycle = 10s."},
            {description = "关", data = false, hover = "测试模式关。"},
        },
        default = false,
		hover = "测试模式_非必要请勿修改(Test mode, please don't change if unnecessary)",
	},
}