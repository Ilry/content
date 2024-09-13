local CH = locale == "zh" or locale == "zhr"
--The name of the mod displayed in the 'mods' screen.
name = CH and "搜索你的地图" or "Search Your Map!"
description = CH and
[[搜索你的地图!

设置你心目中理想的地图应该满足什么标准。本mod会重复尝试生成地图，直到找到符合你要求的地图为止。

你可以设置草、树枝、浆果的变异；可以设置你想要的地形；可以设置你想要的资源的个数（比如伏特羊有多少群）；你可以设置你想要什么彩蛋；你可以设置你想把家建在靠近哪里的位置（如果没有满足要求的地方，则重新生成）.locale
你还可以定义你喜欢的洞穴是什么样！

但是不要太贪心，以免花费太久！
]]
or
[[search your map

Set the criteria for your ideal map. This mod will repeatedly try to generate a map until it finds one that meets your requirements.

You can set the mutation of grass, twigs, and berries; you can set the terrain you want; you can set the number of resources you want (such as how many herds of lightninggoat); you can set what easter eggs you want; you can set where you want to build your home (if there is no suitable place, the world will be regenerated); you can also set the resources.
You can also define what you like the cave to be like!

But don't be too greedy, or it will take too long!
]]

author = "clearlove"
version = "1.1.0"

api_version = 10

dst_compatible = true
restart_required = false
server_only_mod = true
-- all_clients_require_mod = false
-- client_only_mod = true
icon = "search_your_map.tex"
icon_atlas = "search_your_map.xml"
priority = -2147483648

local function AddSectionTitle(title) -- 100% stole this idea from ReForged. Didn't know this was possible!
	return {
		name = title:upper(), -- avoid conflicts
		label = title, 
		options = {{description = "", data = 0}},
		default = 0,
		tags = {"ignore"},
	}
end

local dsc_task = CH and "必须要有、千万别有的地形最多各自选5个。" or "You can choose up to 5 must have and 5 must not have biomes."
local dsc_task_cave = CH and "必须要有最多选择8个，千万别有的地形最多选择10个。" or "You can choose up to 8 must have and 10 must not have biomes."
local optional_biomes_options = {
        {description = CH and "必须要有" or "must have", data = "must have"},
        {description = CH and "千万别有" or "must not have", data = "must not have"},
        {description = CH and "无所谓" or "I don't care", data = "not set"},
}

local distance_options = {}
distance_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 40 do
    distance_options[i+2] = { description = (i*10)..(CH and "个地皮" or " tiles"), data = i*10 }
end

local weight_options = {}
weight_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 1, 40 do
    weight_options[i+1] = { description = i*0.5, data = i*0.5 }
end


local num_options = {}
num_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 10 do
    num_options[i+2] = { description = i..(CH and "个" or ""), data = i }
end

local monkey_num_options = {}
monkey_num_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 10 do
    monkey_num_options[i+2] = { description = (i+4)..(CH and "个" or ""), data = i+4 }
end

local Lightninggoat_num_options = {}
Lightninggoat_num_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 2 do
    Lightninggoat_num_options[i+2] = { description = (i+2)..(CH and "群" or ""), data = i+2 }
end

local eighty_num_options = {}
eighty_num_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 80 do
    eighty_num_options[i+2] = { description = i..(CH and "个" or ""), data = i }
end

local pond_distance_options = {}
pond_distance_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 40 do
    pond_distance_options[i+2] = { description = (i*2)..(CH and "个地皮" or " tiles"), data = i*2 }
end

local connect_ancient_options = {}
connect_ancient_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 1, 40 do
    connect_ancient_options[i+1] = { description = (i*10)..(CH and "个地皮" or " tiles"), data = i*10 }
end

local one_or_two_options = {}
one_or_two_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
one_or_two_options[2] = { description = CH and "1个" or "1", data = 1 }
one_or_two_options[3] = { description = CH and "2个" or "2", data = 2 }

local zero_or_one_options = {}
zero_or_one_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
zero_or_one_options[2] = { description = CH and "0个" or "0", data = 0 }
zero_or_one_options[3] = { description = CH and "1个" or "1", data = 1 }

local SacredBarracks_hover = CH and "五个雕像，4个梦魇灯座，1个主教，2个战车" or "5 ancient statues, 4 Nightmare Light, 1 Bishop, 2 Rooks"
local Bishops_hover = CH and "8个雕像，2个主教" or "8 ancient statues, 2 Bishops"
local Spiral_hover = CH and "破损的家具" or "Broken furniture"
local BrokenAltar_hover = CH and "1个远古伪科学站，两个雕像，2个梦魇灯座" or "1 Ancient Pseudoscience Station, 2 ancient statues, 2 Nightmare Light"
local Barracks_hover = CH and "没有雕像和影灯，有发条生物" or "No ancient statues and Nightmare Light, have clockwork creatures"

configuration_options = {
    AddSectionTitle(CH and "地上设置" or "Master world Setting"),
    AddSectionTitle(CH and "资源种类" or "Type of resources"),
    {
		name = "master_grass_required",
		label = CH and "草" or "Grass",
		options =	{
						{description = CH and "经典" or "classical", data = "regular grass"},
						{description = CH and "草蜥蜴" or "grass gekko", data = "grass gekko"},
						{description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and "草或者草蜥蜴都可以接受" or "Both grass and grass gekko are acceptable"},
					},
		default = "not set",
	},
    {
        name = "master_twigs_required",
        label = CH and "树枝" or "Twigs",
        options =	{
                        {description = CH and "经典" or "classical", data = "regular twigs"},
                        {description = CH and "多枝树" or "twiggy trees", data = "twiggy trees"},
                        {description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and "树枝或者多枝树都可以接受" or "Both twigs and twiggy trees are acceptable"},
                    },
        default = "not set",
    },
    {
        name = "master_berries_required",
        label = CH and "浆果" or "Berries",
        options =	{
                        {description = CH and "经典" or "classical", data = "regular berries"},
                        {description = CH and "多汁浆果" or "juicy berries", data = "juicy berries"},
                        {description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and "浆果或者多汁浆果都可以接受" or "Both berries and juicy berries are acceptable"},
                    },
        default = "not set",
    },
    AddSectionTitle(CH and "地上可选地形" or "Master Optional Biomes"),
    {
        name = "befriend_the_pigs",
        label = CH and "小猪村" or "Befriend the pigs",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n一个森林中的小猪村，有一个沼泽" or dsc_task.."\nA small Pig Village in a Forest, and a Swamp."
    },
    {
        name = "frogs_and_bugs",
        label = CH and "平原池塘区" or "Frogs and bugs",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n普通地皮，有池塘区和蜜蜂" or dsc_task.."\nPonds and Beehives, in a Plain."
    },
    {
        name = "killer_bees",
        label = CH and "杀人蜂走廊" or "Killer bees!",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n一个全是蜜蜂和杀人蜂的区域" or dsc_task.."\nA Plain full of Bee & Killer Bee Hives."
    },
    {
        name = "kill_the_spiders",
        label = CH and "蜘蛛矿区" or "Kill the spiders",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n很多矿石，很多蜘蛛" or dsc_task.."\nA Rocky gold quarry, with hundreds of Spiders!"
    },
    {
        name = "magic_meadow",
        label = CH and "森林池塘区" or "Magic meadow",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n在森林中的池塘区" or dsc_task.."\nSome Forest, with Frogs ponds."
    },
    {
        name = "make_a_beehat",
        label = CH and "额外陨石区" or "Make a Beehat",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n普通地皮，有一些蜜蜂，还有一个额外的陨石区" or dsc_task.."\nMore Plains with Bees, and a Meteor Field!"
    },
    {
        name = "mole_colony_deciduous",
        label = CH and "没有猪王的桦树林" or "Mole Colony Deciduous",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n一个较小的桦树林，没有猪王" or dsc_task.."\nA smaller Deciduous Forest."
    },
    {
        name = "mole_colony_rocks",
        label = CH and "矿区" or "Mole Colony Rocks",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n一个矿区" or dsc_task.."\nA Rocky biome."
    },
    {
        name = "moose_breeding_task",
        label = CH and "鸭子窝" or "Moose Breeding",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n拥有四个麋鹿鹅巢穴" or dsc_task.."\nFour Moose Nests at the same place, how nice!"
    },
    {
        name = "the_hunters",
        label = CH and "海象平原" or "The hunters",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task.."\n拥有三个海象巢，为草原、石头和普通地皮" or dsc_task.."\nTriple Walrus Camp, in a Savanna, Rocky, and Plain biomes."
    },
    AddSectionTitle(CH and "资源数量" or "Entity numbers"),
    -- 发条主教， 发条战车， 发条骑士， 总发条生物个数
    -- bishop,  rook, knight, total_clockwork_creatures
    {
        name = "master_bishop",
        label = CH and "发条主教" or "Bishop",
        options = num_options,
        hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
        default = "not set",
    },
    {
        name = "master_rook",
        label = CH and "发条战车" or "Rook",
        options = num_options,
        hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
        default = "not set",
    },
    {
        name = "master_knight",
        label = CH and "发条骑士" or "Knight",
        options = num_options,
        hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
        default = "not set",
    },
    {
        name = "master_total_clockwork_creatures",
        label = CH and "发条生物总数" or "Total Clockwork Creatures",
        options = num_options,
        hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
        default = "not set",
    },
    {
        name = "master_lightninggoat_herd",
        label = CH and "伏特羊群" or "Lightninggoat Herd",
        options = Lightninggoat_num_options,
        hover = CH and "请不要设置过多" or "Please do not set too many",
        default = "not set",
    },
    {
        name = "master_tumbleweedspawner",
        label = CH and "风滚草刷新点" or "tumbleweedspawner",
        options = eighty_num_options,
        hover = CH and "请不要设置过多" or "Please do not set too many",
        default = "not set",
    },
    {
        name = "master_trap_starfish",
        label = CH and "海星" or "Anenemy",
        options = eighty_num_options,
        hover = CH and "请不要设置过多" or "Please do not set too many",
        default = "not set",
    },
    {
        name = "master_custom_entity_num",
        label = CH and "自定义实体" or "Custom entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入你任意感兴趣的实体名称及个数，用“实体:数目”表示你的某个要求，用分号分隔不同的要求。例如为：beefalo:15;livingtree:2;\n你可以订阅我发布的另一个模组“文本模组配置”，来直接在配置界面输入" or 
        "Enter the name and number of any entity you are interested in, use 'entity:number' to represent your requirements, and use semicolons to separate different requirements. For example: beefalo:15;livingtree:2;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
        default = "",
        is_text_config = true
    },
    -- 棋子的个数
    -- sculpture_rooknose, sculpture_knighthead, sculpture_bishophead, total Suspicious Marble
    -- 可疑的大理石（战车的鼻子），可疑的大理石（骑士的头），可疑的大理石（主教的头），可疑的大理石总数
    -- 这些好像是生成世界之后加载的时候加进去的？为什么没有呢？
    -- {
    --     name = "master_sculpture_rooknose",
    --     label = CH and "可疑的大理石(战车的鼻子)" or "sculpture_rook",
    --     options = num_options,
    --     hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
    --     default = "not set",
    -- },
    -- {
    --     name = "master_sculpture_knighthead",
    --     label = CH and "可疑的大理石(骑士的头)" or "sculpture_knight",
    --     options = num_options,
    --     hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
    --     default = "not set",
    -- },
    -- {
    --     name = "master_sculpture_bishophead",
    --     label = CH and "可疑的大理石(主教的头)" or "sculpture_bishop",
    --     options = num_options,
    --     hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
    --     default = "not set",
    -- },
    -- {
    --     name = "master_total_sculptures",
    --     label = CH and "可疑的大理石总数" or "Total Suspicious Marble",
    --     options = num_options,
    --     hover = CH and "请谨慎设置和发条有关的选项，单独为某一类设置过多的数量、或者为这三种类别设置不合理的个数组合都可能导致世界无法生成" or "Please be careful when setting options related to clockwork, setting too many numbers for a single category, or setting unreasonable combinations of numbers for these three categories may cause the world to fail to generate",
    --     default = "not set",
    -- },
    AddSectionTitle(CH and "布景(Setpieces)" or "Setpieces"),
    {
        name = "master_protected_resources",
        label = CH and "受保护的资源点" or "Protected resources",
        options = {
            {description = CH and "树人彩蛋" or "leif_forest", data = "leif_forest", hover = CH and "含有41棵常青树和10个树人守卫" or "have 41 evergreen trees and 10 treeguards"},
            {description = CH and "蜘蛛森林" or "spider_forest", data = "spider_forest", hover = CH and "含有12个3级蜘蛛巢，以及树林" or "have 12 level 3 spider dens, and forest"},
            {description = CH and "守卫浆果园" or "pigguard_berries", data = "pigguard_berries", hover = CH and "含有8个猪人火炬和20个浆果(或12个多汁浆果)" or "have 8 pig torches and 20 berries(or 12 juicy berries)"},
            {description = CH and "守卫浆果园(小)" or "pigguard_berries_easy", data = "pigguard_berries_easy", hover = CH and "含有1个猪人火炬和22个浆果(或16个多汁浆果)" or "have 1 pig torches and 22 berries(or 16 juicy berries)"},
            {description = CH and "简单杀人蜂草丛" or "wasphive_grass_easy", data = "wasphive_grass_easy", hover = CH and "含有46株草和3个杀人蜂巢" or "have 46 grass and 3 killer bee hives"},
            {description = CH and "猎犬石矿" or "hound_rocks", data = "hound_rocks", hover = CH and "含有16个石矿和10个猎犬巢" or "have 16 rocks and 10 hound mounds"},
            {description = CH and "触手彩蛋" or "tenticle_reeds", data = "tenticle_reeds", hover = CH and "含有76个触手和55株芦苇" or "have 76 tentacles and 55 reeds"},
            {description = CH and "高鸟彩蛋" or "tallbird_rocks", data = "tallbird_rocks", hover = CH and "含有10个高鸟巢，以及矿石" or "have 10 tallbird nests, and rocks"},
            {description = CH and "守卫草场" or "pigguard_grass", data = "pigguard_grass", hover = CH and "含有8根猪人火炬和50株草" or "have 8 pig torches and 50 grass"},
            {description = CH and "守卫草场(小)" or "pigguard_grass_easy", data = "pigguard_grass_easy", hover = CH and "含有4个猪人火炬和44株草" or "have 4 pig torches and 44 grass"},
            {description = CH and "发光浆果与蠕虫" or "lures_and_worms", data = "lures_and_worms", hover = CH and "这个受保护的资源(发光浆果和蠕虫)似乎由于地皮的限制，在洞穴中才能生成，请勿设置" or "This protected resource() seems to be limited to the cave, please do not set it"},
            {description = CH and "无所谓" or "I don't care", data = "not set"}
            },
        default = "not set",
        hover = CH and "确保刷新该受保护的资源点" or "Make sure this protected resource is spawned.",
    },
    {
        name = "master_traps",
        label = CH and "陷阱" or "Traps",
        options = {
            {description = CH and "开发者墓园" or "Dev Graveyard", data = "Dev Graveyard", hover = CH and "一群墓地，温蒂玩家可能会喜欢"},
            {description = CH and "沉睡蜘蛛陷阱" or "Sleeping Spider", data = "Sleeping Spider", hover = CH and ""},
            {description = CH and "腐烂陷阱" or "Rotted Base", data = "Rotted Base", hover = CH and ""},
            {description = CH and "皮弗娄牛农场" or "Beefalo Farm", data = "Beefalo Farm", hover = CH and ""},
            {description = CH and "冰猎犬陷阱" or "Ice Hounds", data = "Ice Hounds", hover = CH and ""},
            {description = CH and "火猎犬陷阱" or "Fire Hounds", data = "Fire Hounds", hover = CH and ""},
            {description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and ""}
            },
        default = "not set",
        hover = CH and "确保刷新该受保护的资源点" or "Make sure this protected resource is spawned.",
    },
    -- 基地选址
    {
		name = "master base location",
		label = CH and "基地选址" or "Base Location",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "设置你理想的基地应该接近哪些地点，将检查地图中是否有符合要求的地点" or "Set which locations you would like your base to be close to, and the map will be checked for a suitable location.",
		tags = {"ignore"},
	},
    -- entites
    -- pigking, dragonfly_spawner, oasislake, moonbase, beequeenhive, multiplayer_portal, monkeyqueen, hermithouse_construction1, wobster_den, saltstack
    {
        name = "master_pigking",
        label = CH and "猪王" or "Pig King",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_dragonfly_spawner",
        label = CH and "龙蝇" or "Dragonfly",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_oasislake",
        label = CH and "绿洲池塘" or "Oasis Lake",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_moonbase",
        label = CH and "月台" or "Moonbase",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_beequeenhive",
        label = CH and "蜂后" or "Bee Queen",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_multiplayer_portal",
        label = CH and "绚丽之门" or "Multiplayer Portal",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_monkeyqueen",
        label = CH and "猴子女王" or "Monkey Queen",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_hermithouse_construction1",
        label = CH and "寄居蟹隐士" or "Hermit Crab",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_wobster_den",
        label = CH and "龙虾窝" or "Wobster Den",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_saltstack",
        label = CH and "盐堆" or "Salt Stack",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_seastack",
        label = CH and "海蚀柱" or "Sea Stack",
        options = distance_options,
        default = "not set",
        hover = CH and "不要设置的太小，我认为可能至少需要设置为30" or "Don't set it too small, I think it may need to be set to at least 30",
    },
    {
        name = "master_custom_entity_near",
        label = CH and "自定义邻近实体" or "Custom nearby entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入你感兴趣的实体，以及想约束基地距离它的最小距离，用“实体:距离”表示你的某个要求，用分号分隔不同的要求。\n这里的距离仍然以地皮为单位。例如为：beefalo:15;moose_nesting_ground:10;\n你可以订阅我发布的另一个模组“文本模组配置”，来直接在配置界面输入" or 
        "Enter the name of the entity you are interested in, and the minimum distance you want to constrain the base from it, use 'entity:distance' to represent your requirements, and use semicolons to separate different requirements.\nHere the distance is still in tiles. For example: beefalo:15;moose_nesting_ground:10;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
        default = "",
        is_text_config = true
    },
    {
        name = "master_pond",
        label = CH and "(远离)池塘" or "(Far away)Pond",
        options = pond_distance_options,
        default = "not set",
        hover = CH and "如果你想要一个池塘，但是不想让它太靠近基地，可以使用这个选项" or "If you want a pond, but don't want it too close to your base, you can use this option"
    },
    -- regions
    -- Squeltch, Moon island, Ocean
    {
        name = "master_squeltch",
        label = CH and "沼泽" or "Squeltch",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_moon_island",
        label = CH and "月岛" or "Moon Island",
        options = distance_options,
        default = "not set",
    },
    -- Killer bees!
    {
        name = "master_killer_bees",
        label = CH and "杀人蜂走廊" or "Killer bees!",
        options = distance_options,
        default = "not set",
        hover = CH and "要使用这个选项，请保证在地上可选地形中将杀人蜂走廊设置为必须有" or "To use this option, make sure that the Killer bees! is set to must have in the Master Optional Biomes",
    },
    -- The hunters
    {
        name = "master_the_hunters",
        label = CH and "海象平原" or "The hunters",
        options = distance_options,
        default = "not set",
        hover = CH and "要使用这个选项，请保证在地上可选地形中将海象平原设置为必须有" or "To use this option, make sure that the The hunters is set to must have in the Master Optional Biomes",
    },
    -- {
    --     name = "master_ocean",
    --     label = CH and "海洋" or "Ocean",
    --     options = distance_options,
    --     default = "not set",
    -- },-- 这个需要知道哪里是海洋
    {
		name = "master base location(soft constraint)",
		label = CH and "基地选址（软约束）" or "Base Location(Soft constraint)",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "设置地点的重要程度，对于建家位置，将计算基地到这些地点的距离的加权求和。重复若干次，保留其中加权距离求和最小的地图" or "Set the importance of the location, for the base location, the weighted sum of the distance from the base to these locations will be calculated. Repeat several times and keep the map with the smallest weighted distance sum.",
		tags = {"ignore"},
	},
    -- entites
    -- pigking, dragonfly_spawner, oasislake, moonbase, beequeenhive, multiplayer_portal, monkeyqueen, hermithouse_construction1, wobster_den, saltstack
    {
        name = "master_repeat_times",
        label = CH and "重复次数" or "Repeat times",
        -- options = repeat_options,
        options = {
            {description = CH and "1次" or "1 times", data = 1},
            {description = CH and "10次" or "10 times", data = 10},
            {description = CH and "50次" or "50 times", data = 50},
            {description = CH and "100次" or "100 times", data = 100},
            {description = CH and "200次" or "200 times", data = 200},
            {description = CH and "500次" or "500 times", data = 500},
            {description = CH and "1000次" or "1000 times", data = 1000},
        },
        default = 1,
    },
    {
        name = "master_pigking_soft",
        label = CH and "猪王" or "Pig King",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_dragonfly_spawner_soft",
        label = CH and "龙蝇" or "Dragonfly",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_oasislake_soft",
        label = CH and "绿洲池塘" or "Oasis Lake",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_moonbase_soft",
        label = CH and "月台" or "Moonbase",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_beequeenhive_soft",
        label = CH and "蜂后" or "Bee Queen",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_multiplayer_portal_soft",
        label = CH and "绚丽之门" or "Multiplayer Portal",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_monkeyqueen_soft",
        label = CH and "猴子女王" or "Monkey Queen",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_hermithouse_construction1_soft",
        label = CH and "寄居蟹隐士" or "Hermit Crab",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_wobster_den_soft",
        label = CH and "龙虾窝" or "Wobster Den",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_saltstack_soft",
        label = CH and "盐堆" or "Salt Stack",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_seastack_soft",
        label = CH and "海蚀柱" or "Sea Stack",
        options = weight_options,
        default = "not set",
        hover = CH and "不要设置的太小，我认为可能至少需要设置为30" or "Don't set it too small, I think it may need to be set to at least 30",
        is_text_config = true
    },
    {
        name = "master_custom_entity_near_soft",
        label = CH and "自定义邻近实体" or "Custom nearby entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入你感兴趣的实体，以及它的权重，用“实体:权重”表示你的某个要求，用分号分隔不同的要求。\n例如为：beefalo:1.1;moose_nesting_ground:2.0;\n你可以订阅我发布的另一个模组“文本模组配置”，来直接在配置界面输入" or 
        "Enter the name of the entity you are interested in, and its weight, use 'entity:weight' to represent your requirements, and use semicolons to separate different requirements.\nFor example: beefalo:1.1;moose_nesting_ground:2.0;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
        default = "",
        is_text_config = true
    },
    -- regions
    -- Squeltch, Moon island, Ocean
    {
        name = "master_squeltch_soft",
        label = CH and "沼泽" or "Squeltch",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_moon_island_soft",
        label = CH and "月岛" or "Moon Island",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    -- Killer bees!
    {
        name = "master_killer_bees_soft",
        label = CH and "杀人蜂走廊" or "Killer bees!",
        options = weight_options,
        default = "not set",
        hover = CH and "要使用这个选项，请保证在地上可选地形中将杀人蜂走廊设置为必须有" or "To use this option, make sure that the Killer bees! is set to must have in the Master Optional Biomes",
        is_text_config = true
    },
    -- The hunters
    {
        name = "master_the_hunters_soft",
        label = CH and "海象平原" or "The hunters",
        options = weight_options,
        default = "not set",
        hover = CH and "要使用这个选项，请保证在地上可选地形中将海象平原设置为必须有" or "To use this option, make sure that the The hunters is set to must have in the Master Optional Biomes",
        is_text_config = true
    },
    AddSectionTitle(CH and "特殊要求" or "Special requirements"),
    -- TODO: 月岛连大陆，需要知道月岛精确的地方（或者用现在的来近似吧）
    -- TODO: 地中海可能需要保证能放下船才行吧。
    -- {
    --     name = "master_ocean_inland",
    --     label = CH and "陆地中的小片海洋" or "Ocean in land",
    --     options = distance_options,
    --     default = "not set",
    --     hover = CH  and "如果想种植疙瘩树，这可能是不错的选择" or "If you want to plant a Knobbly Tree, this might be a good choice",
    -- },
    {
        name = "master_moon_island_connect",
        label = CH and "月岛直连大陆" or "Moon Island Connect to Mainland",
        options = {
            {description = CH and "是" or "yes", data = "yes"},
            {description = CH and "无所谓" or "I don't care", data = "not set"},
        },
        default = "not set",
        hover = CH  and "月岛与大陆直接相连(至多相距2个地皮)" or "Moon Island is directly connected to the mainland (up to 2 tiles apart)",
    },
    AddSectionTitle(CH and "洞穴设置" or "Cave world Setting"),
    AddSectionTitle(CH and "洞穴可选地形" or "Cave Optional Biomes"),
    -- "SwampySinkhole",--沼泽陷洞
    -- "CaveSwamp",--洞穴沼泽
    -- "UndergroundForest",--地下森林
    -- "PleasantSinkhole",--怡人陷洞
    -- "FungalNoiseForest",--混合蘑菇森林
    -- "FungalNoiseMeadow",--混合蘑菇草地
    -- "BatCloister",--蝙蝠回廊
    -- "RabbitTown",--兔镇
    -- "RabbitCity",--兔城
    -- "SpiderLand",--蜘蛛之地
    -- "RabbitSpiderWar",--蜘蛛兔子大战
    {
        name = "SwampySinkhole",
        label = CH and "沼泽陷洞" or "SwampySinkhole",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n沼泽，有蜘蛛、芦苇、触手、荧光果。可以有一小片树林" or dsc_task_cave.."\nSwamp, with Spiders, Reeds, Tentacles, Light Flowers. Can have a small forest."
    },
    {
        name = "CaveSwamp",
        label = CH and "洞穴沼泽" or "CaveSwamp",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n沼泽，有蜘蛛、芦苇、触手、荧光果。可以有一小片洞穴透光较少的黑暗区域" or dsc_task_cave.."\nSwamp, with Spiders, Reeds, Tentacles, Light Flowers. Can have a small cave area with less light."
    },
    {
        name = "UndergroundForest",
        label = CH and "地下森林" or "UndergroundForest",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n绿色草地，有森林和蜘蛛" or dsc_task_cave.."\n Green grass, with Forest and Spiders."
    },
    {
        name = "PleasantSinkhole",
        label = CH and "怡人陷洞" or "PleasantSinkhole",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n有草和蜘蛛" or dsc_task_cave.."\n Grass and Spiders."
    },
    {
        name = "FungalNoiseForest",
        label = CH and "混合蘑菇森林" or "FungalNoiseForest",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n三种蘑菇都有，很多蘑菇树" or dsc_task_cave.."\n Three types of Mushrooms, with lots of Mushroom Trees."
    },
    {
        name = "FungalNoiseMeadow",
        label = CH and "混合蘑菇草地" or "FungalNoiseMeadow",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n三种蘑菇都有，蘑菇树不多" or dsc_task_cave.."\n Three types of Mushrooms, with less Mushroom Trees."
    },
    {
        name = "BatCloister",
        label = CH and "蝙蝠回廊" or "BatCloister",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n蝙蝠和石头" or dsc_task_cave.."\n Bat and rocks."
    },
    {
        name = "RabbitTown",
        label = CH and "兔镇" or "RabbitTown",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n兔子镇与分散的若干兔子屋" or dsc_task_cave.."\nRabbit Town with scattered Rabbit Hutches."
    },
    {
        name = "RabbitCity",
        label = CH and "兔城" or "RabbitCity",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n兔子城与更多的兔子屋" or dsc_task_cave.."\nRabbit City with more Rabbit Hutches."
    },
    {
        name = "SpiderLand",
        label = CH and "蜘蛛之地" or "SpiderLand",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n包含三个小区域，蜘蛛与蝙蝠，蜘蛛与沼泽，蜘蛛与草地" or dsc_task_cave.."\nContain three small areas, Spiders and Bats, Spiders and Swamp, Spiders and Grass."
    },
    {
        name = "RabbitSpiderWar",
        label = CH and "蜘蛛兔子大战" or "RabbitSpiderWar",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n位于绿草地上，有兔子与蜘蛛" or dsc_task_cave.."\nGreen grass, with Rabbits and Spiders."
    },
    -- "MoreAltars",--更多祭坛
    -- "CaveJungle", --洞穴丛林
    -- "SacredDanger", --危险圣地
    -- "MilitaryPits",--军事矿坑
    -- "MuddySacred",--泥泞圣地
    -- "Residential2",--住宅区2
    -- "Residential3",--住宅区3
    {
        name = "MoreAltars",
        label = CH and "更多祭坛" or "MoreAltars",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n一个远古伪科学基地" or dsc_task_cave.."\nAn extra Ancient Pseudoscience Station"
    },
    {
        name = "CaveJungle",
        label = CH and "洞穴丛林" or "CaveJungle",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n猴子，池塘区和香蕉区，没有城市遗迹" or "\nMonkey, Ponds and Bananas, no Ruins"
    },
    {
        name = "SacredDanger",
        label = CH and "危险圣地" or "SacredDanger",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n1-2个军营，1-2圣地军营，有零散的远古雕像" or "\n1-2 Barracks， 1-2 SacredBarracks， scattered Ancient Statues"
    },
    {
        name = "MilitaryPits",
        label = CH and "军事矿坑" or "MilitaryPits",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n一个入口的小房间（有一个远古雕像），三个军营，一个小迷宫" or "\n 1 entrance room with 1 Ancient Statue, 3 Barracks, 1 small maze"
    },
    {
        name = "MuddySacred",
        label = CH and "泥泞圣地" or "MuddySacred",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n泥泞地皮，加一些含远古雕像的小房间" or "\n Muddy, with some small rooms containing ancient statues"
    },
    {
        name = "Residential2",
        label = CH and "住宅区2" or "Residential2",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n猴子，少量池塘，密集的香蕉树，城市遗迹" or "\nMonkey, few Ponds, dense Bananas, Ruins"
    },
    {
        name = "Residential3",
        label = CH and "住宅区3" or "Residential3",
        options = optional_biomes_options,
        default = "not set",
        hover = CH and dsc_task_cave.."\n猴子和蜘蛛，无城市遗迹" or "\nMonkey and Spiders, no Ruins"
    },
    AddSectionTitle(CH and "地下资源数量" or "Cave Entity numbers"),
    -- monkeybarrel_spawner 
    {
        name = "cave_monkeybarrel_spawner",
        label = CH and "猴子窝(少于)" or "Monkey Barrel(fewer than)",
        options = monkey_num_options,
        default = "not set",
        hover = CH and "不要设置的过少，我尝试"
    },
    AddSectionTitle(CH and "地下特殊要求" or "Cave Special requirements"),
    {
        name = "cave_connected_ancient",
        label = CH and "远古靠近楼梯" or "Ancient near Sinkhole",
        options = connect_ancient_options,
        default = "not set",
        hover = CH and "楼梯靠近远古，只要有某个雕像/迷宫箱子距离梯子接近，就视为满足要求" or "Ancient near Sinkholes, as long as a statue/maze chest is close to the stairs, it is considered to meet the requirements",
    },
    AddSectionTitle(CH and "定制远古房间" or "Custom rooms"),
    -- ["SacredBarracks"] --圣地军营，五个雕像，4个影灯，1个主教，2个战车
    -- ["Bishops"] --8个雕像，2个主教
    -- ["Spiral"] --破损的家具
    -- ["BrokenAltar"] --1个破塔，两个雕像，2个影灯
    AddSectionTitle(CH and "定制圣地" or "Custom Sacred"),
    {
        name = "Sacred_SacredBarracks",
        label = CH and "圣地军营" or "SacredBarracks",
        options = one_or_two_options,
        default = "not set",
        hover = SacredBarracks_hover,
    },
    {
        name = "Sacred_Bishops",
        label = CH and "主教(8雕)" or "Bishops",
        options = one_or_two_options,
        default = "not set",
        hover = Bishops_hover,
    },
    {
        name = "Sacred_Spiral",
        label = CH and "家具区" or "Spiral",
        options = one_or_two_options,
        default = "not set",
        hover = Spiral_hover,
    },
    {
        name = "Sacred_BrokenAltar",
        label = CH and "远古伪科学站房间" or "BrokenAltar",
        options = one_or_two_options,
        default = "not set",
        hover = BrokenAltar_hover,
    },
    AddSectionTitle(CH and "定制泥泞圣地" or "Custom MuddySacred"),
    {
        name = "MuddySacred_SacredBarracks",
        label = CH and "圣地军营" or "SacredBarracks",
        options = zero_or_one_options,
        default = "not set",
        hover = SacredBarracks_hover,
    },
    {
        name = "MuddySacred_Bishops",
        label = CH and "主教(8雕)" or "Bishops",
        options = zero_or_one_options,
        default = "not set",
        hover = Bishops_hover,
    },
    {
        name = "MuddySacred_Spiral",
        label = CH and "家具区" or "Spiral",
        options = zero_or_one_options,
        default = "not set",
        hover = Spiral_hover,
    },
    {
        name = "MuddySacred_BrokenAltar",
        label = CH and "远古伪科学站房间" or "BrokenAltar",
        options = zero_or_one_options,
        default = "not set",
        hover = BrokenAltar_hover,
    },
    AddSectionTitle(CH and "定制危险圣地" or "Custom SacredDanger"),
    -- ["SacredBarracks"] = function() return math.random(1,2) end,
    -- ["Barracks"] = function() return math.random(1,2) end,
    {
        name = "SacredDanger_SacredBarracks",
        label = CH and "圣地军营" or "SacredBarracks",
        options = one_or_two_options,
        default = "not set",
        hover = SacredBarracks_hover,
    },
    {
        name = "SacredDanger_Barracks",
        label = CH and "军营" or "Barracks",
        options = one_or_two_options,
        default = "not set",
        hover = Barracks_hover,
    },
}
