local CH = locale == "zh" or locale == "zhr"
--The name of the mod displayed in the 'mods' screen.
name = CH and "搜索你的地图" or "Search Your Map!"
description = CH and
[[搜索你的地图!

设置你心目中理想的地图应该满足什么标准。本mod会重复尝试生成地图，直到找到符合你要求的地图为止。

你可以设置草、树枝、浆果的变异；可以设置你想要的地形；可以设置你想要的资源的个数（比如伏特羊有多少群）；你可以设置你想要什么彩蛋；你可以设置你想把家建在靠近哪里的位置（如果没有满足要求的地方，则重新生成）
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
version = "1.2.12"

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
for i = 0, 20 do
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

local meteor_distance_options = {}
meteor_distance_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 0, 15 do
    meteor_distance_options[i+2] = { description = (30+i)..(CH and "个地皮" or " tiles"), data = 30+i }
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

local shade_threshold_options = {}
shade_threshold_options[1] = { description = CH and "无所谓" or "I don't care", data = "not set" }
for i = 1, 20 do
    shade_threshold_options[i+1] = { description = (i*5).."%", data = i*0.05 }
end

local base_radius_options = {} -- from 2 to 10
for i = 2, 10 do
    base_radius_options[i-1] = { description = i..(CH and "个地皮" or " tiles"), data = i }
end

local SacredBarracks_hover = CH and "五个雕像（其中4个带宝石），4个梦魇灯座，1个主教，2个战车" or "5 ancient statues (4 with gem), 4 Nightmare Light, 1 Bishop, 2 Rooks"
local Bishops_hover = CH and "8个雕像（其中4个带宝石），2个主教" or "8 ancient statues (4 with gem), 2 Bishops"
local Spiral_hover = CH and "破损的家具" or "Broken furniture"
local BrokenAltar_hover = CH and "1个远古伪科学站，两个雕像(带宝石)，2个梦魇灯座" or "1 Ancient Pseudoscience Station, 2 ancient statues (with gem), 2 Nightmare Light"
local Barracks_hover = CH and "没有雕像和影灯，有发条生物" or "No ancient statues and Nightmare Light, have clockwork creatures"

configuration_options = {
    {
		name = "master world property",
		label = CH and "##### 地上世界属性 #####" or "##### Master World Properties #####",
		options = {{description = "", data = CH}},
		default = CH,
        hover = CH and "这部分，你可以约束地上世界的各种属性，包括基础资源种类、地形组成、彩蛋、某种资源的数量。\n你还可以寻找特别的世界，比如月岛直接与大陆相连。" or "In this part, you can constrain various properties of the master world, including basic resource types, terrain composition, easter eggs, and the number of a certain resource.\nYou can also find special worlds, such as the Moon Island directly connected to the mainland.",
		tags = {"ignore"},
	},
    AddSectionTitle(CH and "资源种类" or "Type of resources"),
    {
		name = "master_grass_required",
		label = CH and "草" or "Grass",
		options =	{
						{description = CH and "经典" or "classical", data = "regular grass", hover = CH and "普通的草为主" or "Mainly regular grass"},
						{description = CH and "草蜥蜴" or "grass gekko", data = "grass gekko", hover = CH and "草蜥蜴为主" or "Mainly grass gekko"},
						{description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and "草或者草蜥蜴都可以接受" or "Both grass and grass gekko are acceptable"},
					},
		default = "not set",
	},
    {
        name = "master_twigs_required",
        label = CH and "树枝" or "Twigs",
        options =	{
                        {description = CH and "经典" or "classical", data = "regular twigs", hover = CH and "普通的树枝" or "Regular twigs"},
                        {description = CH and "多枝树" or "twiggy trees", data = "twiggy trees", hover = CH and "多枝树" or "Twiggy trees"},
                        {description = CH and "无所谓" or "I don't care", data = "not set", hover = CH and "树枝或者多枝树都可以接受" or "Both twigs and twiggy trees are acceptable"},
                    },
        default = "not set",
    },
    {
        name = "master_berries_required",
        label = CH and "浆果" or "Berries",
        options =	{
                        {description = CH and "经典" or "classical", data = "regular berries", hover = CH and "普通的浆果" or "Regular berries"},
                        {description = CH and "多汁浆果" or "juicy berries", data = "juicy berries", hover = CH and "多汁浆果" or "Juicy berries"},
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
        name = "master_three_sculptures",
        label = CH and "三雕像" or "Three Sculptures",
        options = num_options,
        hover = CH and "请不要设置过多（似乎最多三个）。这是三个暗影棋子的雕像底座" or "Please do not set too many (Perhaps 3 at most), these are the bases of three shadow chess pieces",
        default = "not set",
    },
    {
        name = "master_custom_entity_num",
        label = CH and "自定义实体" or "Custom entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入你任意感兴趣的实体名称及个数，用“实体:数目”表示你的某个要求，用分号分隔不同的要求。\n（注意冒号和分号都需要是英文输入法输入）例如为：beefalo:15;livingtree:2;\n你可以订阅我发布的另一个模组“文本模组配置”，来直接在配置界面输入" or "Enter the name and number of any entity you are interested in, use 'entity:number' to represent your requirements, and use semicolons to separate different requirements. For example: beefalo:15;livingtree:2;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
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
    {
        name = "master_moon_island_broken",
        label = CH and "月岛破碎" or "Broken Moon Island",
        options = {
            {description = CH and "是" or "yes", data = "yes"},
            {description = CH and "无所谓" or "I don't care", data = "not set"},
        },
        default = "not set",
        hover = CH  and "月岛各个区块不连续" or "Moon Island is not continuous",
    },
    AddSectionTitle(CH and "特殊环形世界" or "Special World"),
    {
        name = "moon_island_surrouned",
        label = CH and "月岛在环形中" or "MoonIsland inside Ring",
        options = {
            {description = CH and "是" or "yes", data = "yes"},
            {description = CH and "无所谓" or "I don't care", data = "not set"},
        },
        default = "not set",
        hover = CH  and "陆地呈现环形，而月岛位于环形内部" or "The land is ring-shaped, and the Moon Island is inside the ring",
    },
    {
        name = "hermit_island_surrouned",
        label = CH and "寄居蟹岛在环形中" or "Hermit inside Ring",
        options = {
            {description = CH and "是" or "yes", data = "yes"},
            {description = CH and "无所谓" or "I don't care", data = "not set"},
        },
        default = "not set",
        hover = CH  and "陆地呈现环形，而寄居蟹岛位于环形内部" or "The land is ring-shaped, and the Hermit Island is inside the ring",
    },
    {
        name = "monkey_island_surrouned",
        label = CH and "猴岛在环形中" or "MonkeyIsland inside Ring",
        options = {
            {description = CH and "是" or "yes", data = "yes"},
            {description = CH and "无所谓" or "I don't care", data = "not set"},
        },
        default = "not set",
        hover = CH  and "陆地呈现环形，而猴岛位于环形内部" or "The land is ring-shaped, and the Monkey Island is inside the ring",
    },
    -- 基地选址
    {
		name = "Space1",
		label = CH and "  " or "  ",
		options = {{description = "", data = 0}},
		default = 0,
		tags = {"ignore"},
	},
    {
		name = "master base comstraint",
		label = CH and "##### 建家方便 #####" or "##### Convenient base #####",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "这部分, 你可以配置模组来寻找一个适合建家的地图。换言之， 地图上有一块风水宝地，去哪里都方便。" or "In this part, you can configure the mod to find a map suitable for building a base. \n In other words, there is a place on the map, it is convenient to go anywhere, which is a good place to build a base.",
		-- tags = {"ignore"},
	},
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
            {description = CH and "2000次" or "2000 times", data = 2000},
            {description = CH and "5000次" or "5000 times", data = 5000},
            {description = CH and "10000次" or "10000 times", data = 10000},
            {description = CH and "20000次" or "20000 times", data = 20000},
            {description = CH and "50000次" or "50000 times", data = 50000},
            {description = CH and "100000次" or "100000 times", data = 100000},
            {description = CH and "无限次" or "Infinite times", data = 2147483647},
        },
        default = 1,
        is_text_config = true,
        hover = CH and "生成指定个符合其他约束条件的地图，保留其中基地的交通最便利的那张地图" or "Generate the specified number of maps that meet other constraints, and keep the map with the most convenient transportation of the base",
    },
    {
        name = "ignore_error_master",
        label = CH and "忽略崩溃" or "Ignore Crashing",
        options = {
            {description = CH and "否" or "no", data = false, hower = CH and "在生成失败时停止" or "Stop when generation fails"},
            {description = CH and "是" or "yes", data = true,  hower = CH and "这可能会掩盖问题，持续出现的问题会导致永远无法生成" or "This may mask the problem, persistent problems will cause generating forever"},
        },
        default = false,
        hover = CH and "有时候游戏本身或其他mod的bug会导致生成失败，这个选项让你可以在失败时继续" or "Sometimes the game itself or bugs in other mods can cause generation to fail, this option allows you to continue",
    },
    {
        name = "master_keep_times",
        label = CH and "日志记录种子" or "logged seeds",
        -- options = repeat_options,
        options = {
            {description = CH and "最佳1个" or "best 1", data = 1},
            {description = CH and "最佳10个" or "best 10", data = 10},
            {description = CH and "最佳20个" or "best 20", data = 20},
            {description = CH and "最佳30个" or "best 30", data = 30},
            {description = CH and "最佳40个" or "best 40", data = 40},
            {description = CH and "最佳50个" or "best 50", data = 50},
        },
        default = 10,
        is_text_config = true,
        hover = CH and "在日志中记录当前得分最佳的多少个种子" or "Record the number of seeds with the best score in the log",
    },
    {
        name = "master_allow_wormwhole",
        label = CH and "虫洞视作捷径?" or "Wormhole as shortcut?",
        -- options = repeat_options,
        options = {
            {description = CH and "是" or "yes", data = true, hover = CH and "虫洞相连的两个地方即使相隔天涯，也视若比邻" or "The two places connected by the wormhole are considered to be close to each other"},
            {description = CH and "否" or "no", data = false, hover = CH and "计算距离的时候，假装虫洞不存在" or "When calculating the distance, pretend that the wormhole does not exist"},
        },
        default = true,
        hover = CH and "计算距离的时候，是否允许跳虫洞" or "When calculating the distance, is it allowed to jump the wormhole",
    },
    {
        name = "master_must_onlnad",
        label = CH and "只在陆地建家" or "Exclude sea base",
        -- options = repeat_options,
        options = {
            {description = CH and "是" or "yes", data = true, hover = CH and "在寻找可能的建家位置时，排除海洋地皮" or "When looking for possible base locations, exclude ocean tiles"},
            {description = CH and "否" or "no", data = false, hover = CH and "在寻找可能的建家位置时，不检查地皮的种类" or "When looking for possible base locations, do not check the type of tile"},
        },
        default = true,
        hover = CH and "是否检查建家位置是否是海洋" or "Whether to check if the base location is ocean",
    },
    {
		name = "master base location(soft constraint)",
		label = CH and "兴趣点权重" or "Weights of points of interest",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "设置地点的重要程度，对于建家位置，将计算基地到这些地点的距离的加权求和。本mod重复若干次，保留其中加权距离求和最小的地图\n你可以根据你去这些地方的频率来确定权重，去的越多，权重可以设置越大" or "Set the importance of the location. For the base location, the weighted sum of the distances from the base to these locations will be calculated. This mod repeats several times, and retains the map with the smallest weighted distance sum.\nYou can determine the weight according to the frequency of your visits to these places. The more you go, the greater the weight can be set",
		tags = {"ignore"},
	},
    -- entites
    -- pigking, dragonfly_spawner, oasislake, moonbase, beequeenhive, multiplayer_portal, monkeyqueen, hermithouse_construction1, wobster_den, saltstack
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
        name = "master_junkpile_soft",
        label = CH and "摇摇欲坠的垃圾堆" or "Teetering Junk Pile",
        options = weight_options,
        default = "not set",
        is_text_config = true
    },
    {
        name = "master_custom_entity_near_soft",
        label = CH and "自定义邻近实体" or "Custom nearby entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入实体和权重，用“实体:权重”表示单个要求，用分号分隔不同要求(注意为英文冒号和逗号)。\n例如为：beefalo:1.1;moose_nesting_ground:2.0;\n你可以订阅另一个模组“文本模组配置”，来直接在配置界面输入" or "Enter the entity and weight, use 'entity:weight' to represent a single requirement, and use semicolons to separate different requirements. For example: beefalo:1.1;moose_nesting_ground:2.0;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
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
    {
		name = "master base location",
		label = CH and "基地选址(硬性约束)" or "Base Location(Hard constraint)",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "强制约束基地与指定实体的距离， 当你希望在某个地点旁边建家时，不妨把相应选项设置为0地皮。\n如果对于多个实体设置本选项，可能需要精心调整参数大小，如果设置太大可能地图不够好，设置太小则生成时间可能会很长\n建议通过'兴趣点权重'进行设置" or "Force the base to be a certain distance from the specified entity. When you want to build a base next to a certain location, you can set the corresponding option to 0 tiles.\nIf you set this option for multiple entities, you may need to adjust the parameters carefully. If the setting is too large, the map may not be good, and if the setting is too small, the generation time may be very long.\nIt is recommended to set it through 'Weights of points of interest'",
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
        name = "master_junkpile",
        label = CH and "摇摇欲坠的垃圾堆" or "Teetering Junk Pile",
        options = distance_options,
        default = "not set",
    },
    {
        name = "master_custom_entity_near",
        label = CH and "自定义邻近实体" or "Custom nearby entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入实体及距离（地皮数），用“实体:距离”表示某个要求，用分号分隔不同要求(逗号、分号均为英文)。\n例如：beefalo:15;pond:10;\n你可以订阅模组“文本模组配置”，来直接在配置界面输入" or "Enter the entity and the distance (in tiles), use 'entity:distance' to represent your requirements, and use semicolons to separate different requirements (both comma and semicolon are in English).\nFor example: beefalo:15;moose_nesting_ground:10;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
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
    {
        name = "master_meteorspawner",
        label = CH and "(远离)陨石区" or "(Far away)Meteor Fields",
        options = meteor_distance_options,
        default = "not set",
        hover = CH and "设置基地与陨石区中心点的最小距离，陨石的范围是30个地皮" or "Set the minimum distance between the base and the center of the meteor field, the range of the meteor is 30 tiles"
    },
    {
        name = "master_custom_entity_far",
        label = CH and "自定义远离实体" or "Custom far away entity",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入实体及距离（地皮数），用“实体:距离”表示某个要求，用分号分隔不同要求(逗号、分号均为英文)。\n例如：beefalo:15;pond:10;\n你可以订阅模组“文本模组配置”，来直接在配置界面输入" or "Enter the entity and the distance (in tiles), use 'entity:distance' to represent your requirements, and use semicolons to separate different requirements (both comma and semicolon are in English).\nFor example: beefalo:15;moose_nesting_ground:10;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
        default = "",
        is_text_config = true
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
    {
		name = "master_under_tree",
		label = CH and "大树下好乘凉" or "Under the KnobblyTree",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "这个选项是为了筛选那些可以在旁边种植疙瘩树的基地， 你需要先假定一个基地的尺寸，然后设置这个基地被遮蔽的阈值" or "This option is to filter out the base where the Knobbly Tree can be planted next to. You need to set a size of the base first, and then set the threshold for the base to be shaded",
		tags = {"ignore"},
	},
    {
        name = "master_under_tree_threshold",
        label = CH and "遮蔽阈值" or "Shade threshold",
        options = shade_threshold_options,
        default = "not set",
        hover = CH and "设置基地被遮蔽的阈值，这个值越大，基地被遮蔽的地方越多。设置为“无所谓”则不会进行相关检查。\n我仅仅测试了30%的设置，谨慎设置太高的值，毕竟基地的形状只是粗糙的圆形估计" or "Set the threshold for the base to be shaded. The larger this value, the more the base will be shaded. Set to 'I don't care' will not perform related checks.\nI only tested 30% of the settings, be careful not to set too high values, after all, the shape of the base is just a rough circular estimate",
    },
    {
        name = "master_base_radius",
        label = CH and "基地半径" or "Base radius",
        options = base_radius_options,
        default = 3,
        hover = CH and "设置一个假象的基地半径。这个值只是用来衡量在某个地方建家的时候，基地会有多大部分处于树荫之中。\n计算时，假定基地是圆形" or "Set an imaginary base radius. This value is only used to measure how much of the base will be shaded when building a base in a certain place. \n When calculating, assume that the base is circular",
    },
    -- {
    --     name = "master_ocean",
    --     label = CH and "海洋" or "Ocean",
    --     options = distance_options,
    --     default = "not set",
    {
		name = "Space2",
		label = CH and "  " or "  ",
		options = {{description = "", data = 0}},
		default = 0,
		tags = {"ignore"},
	},
    -- },-- 这个需要知道哪里是海洋
    {
		name = "Cave world Setting",
		label = CH and "##### 洞穴世界属性 #####" or "##### Cave world Properties #####",
		options = {{description = "", data = 0}},
		default = 0,
        hover = CH and "这部分，你可以约束洞穴世界的各种属性，包括地形组成、远古房间的组成、猴子窝个数。\n你还可以寻找特别的世界，比如楼梯靠近远古。" or "In this part, you can constrain various properties of the cave world, including terrain composition, composition of ancient rooms, numbers of monkey barrel.\nYou can also find special worlds, such as stairs close to the ancients.",
		tags = {"ignore"},
	},
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
        hover = CH and "不要设置的过少" or "Don't set it too small",
    },
    {
        name = "cave_ruins_statue_all",
        label = CH and "远古雕像" or "Ruins Statue Mage",
        options = eighty_num_options,
        default = "not set",
        hover = CH and "这里是带宝石，不带宝石的两种雕像个数的总和。实际上这是由房间个数决定的，你也可以通过“定制远古房间”实现类似的效果" or "Here is the sum of the number of statues (with and without gems). In fact, this is determined by the number of rooms, you can also achieve similar effects through 'Custom rooms'",
    },
    {
        name = "cave_ruins_statue_gem",
        label = CH and "远古雕像（带宝石）" or "Ruins Statue Mage(w/ gem)",
        hover = CH and "带宝石的雕像个数，实际上这是由房间个数决定的，你也可以通过“定制远古房间”实现类似的效果" or "Ruins Statue Mage(w/ gem). In fact, this is determined by the number of rooms, you can also achieve similar effects through 'Custom rooms'",
        options = eighty_num_options,
        default = "not set",
    },
    -- custom entity num
    {
        name = "cave_custom_entity_num",
        label = CH and "自定义实体数量" or "Custom entity number",
        options = {{description = CH and "无" or "None", data = ""}},
        hover = CH and "输入实体和数量，用“实体:数量”表示单个要求，用分号分隔不同的要求。（注意是英文冒号和分号）\n例如为：beefalo:1;moose_nesting_ground:2;\n你可以订阅另一个模组“文本模组配置”，来直接在配置界面输入" or "Enter the entity and the number, use 'entity:number' to represent a single requirement, and use semicolons to separate different requirements. (Note that it is an English colon and semicolon)\nFor example: beefalo:1;moose_nesting_ground:2;\nYou can subscribe to another mod I released, 'Mod Config By Text', to enter directly in the configuration interface",
        default = "",
        is_text_config = true
    },
    AddSectionTitle(CH and "定制远古房间" or "Custom rooms"),
    -- ["SacredBarracks"] --圣地军营，五个雕像(4个带宝石)，4个影灯，1个主教，2个战车
    -- ["Bishops"] --8个雕像(4个带宝石)，2个主教
    -- ["Spiral"] --破损的家具
    -- ["BrokenAltar"] --1个破塔，两个雕像(2个带宝石)，2个影灯
    -- ["Barracks"] --没有雕像和影灯，有发条生物
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
    AddSectionTitle(CH and "地下特殊要求" or "Cave Special requirements"),
    AddSectionTitle(CH and "远古靠近楼梯" or "Ancient near stair"),
    {
        name = "cave_connected_ancient",
        label = CH and "楼梯与的远古距离" or "stairs & ancient distance",
        options = connect_ancient_options,
        default = "not set",
        hover = CH and "设置你期望的楼梯与远古的最小距离。\n这里远古的含义由下面的选项指定，彼此之间是“或”的关系" or "Set the minimum distance you expect between the stairs and the ancients,\nThe meaning of the ancient is specified by the options below, and they are 'or' to each other",
    },
    {

        name = "cave_accelerated_ancient",
        label = CH and "加速检查" or "Accelerated check",
        options = {
            {description = CH and "否" or "no", data = false, hover = CH and "不加速检查，会花费更多的时间" or "Do not accelerate the check, it will take more time"},
            {description = CH and "是" or "yes", data = true, hover = CH and "加速检查，会花费更少的时间" or "Accelerate the check, it will take less time"},
        },
        default = true,
        hover = CH and "通过限制可选地形的组成来加速远古直连楼梯的检测。开启本选项将不会刷新地下森林、怡人陷洞、混合蘑菇森林、混合蘑菇草地、兔镇、兔城。（将覆盖前面“洞穴可选地形的设置”）" or
        "Accelerate the detection of the ancients directly connected to the stairs by restricting the composition of the optional terrain. Enabling this option will not refresh the UndergroundForest, PleasantSinkhole, FungalNoiseForest, FungalNoiseMeadow, RabbitTown, RabbitCity. (Will override the previous 'Cave Optional Biomes' settings)",
    },
    {
        name = "cave_close_to_statues",
        label = CH and "将雕像视作远古？" or "Statues as Ancient?",
        options = {
            {description = CH and "否" or "no", data = false, hover = CH and "靠近雕像不算靠近远古" or "Close to the statues is not considered as 'Ancient near Sinkhole'"},
            {description = CH and "是" or "yes", data = true, hover = CH and "靠近雕像被视作靠近远古" or "Close to the statues is considered as 'Ancient near Sinkhole'"},
        },
        default = true,
        hover = CH and "设定为是，则如果有雕像靠近楼梯，即视为“远古靠近楼梯”。\n如果你还设置了迷宫箱子/远古守卫者，那么靠近其中之一即视作条件满足" or "If set to yes, if there is a statue near the stairs, it is considered as 'Ancient near Sinkhole'\nIf you also set the maze box/ancient guardian, then near one of them is considered to meet the conditions",
    },
    {
        name = "cave_close_to_maze_boxes",
        label = CH and "将迷宫箱子视作远古？" or "Maze Boxes as Ancient?",
        options = {
            {description = CH and "否" or "no", data = false, hover = CH and "靠近迷宫箱子不算靠近远古" or "Close to the maze boxes is not considered as 'Ancient near Sinkhole'"},
            {description = CH and "是" or "yes", data = true, hover = CH and "靠近迷宫箱子被视作靠近远古" or "Close to the maze boxes is considered as 'Ancient near Sinkhole'"},
        },
        default = true,
        hover = CH and "设定为是，则如果有迷宫箱子靠近楼梯，即视为“远古靠近楼梯”。\n如果你还设置了雕像/远古守卫者，那么靠近其中之一即视作条件满足" or "If set to yes, if there is a maze box near the stairs, it is considered as 'Ancient near Sinkhole'\nIf you also set the statues/ancient guardian, then near one of them is considered to meet the conditions",
    },
    {
        name = "cave_close_to_minotaur_spawner",
        label = CH and "将远古守护者视作远古？" or "Minotaur as Ancient?",
        options = {
            {description = CH and "否" or "no", data = false, hover = CH and "靠近远古守护者不算靠近远古" or "Close to the Minotaur is not considered as 'Ancient near Sinkhole'"},
            {description = CH and "是" or "yes", data = true, hover = CH and "靠近远古守护者被视作靠近远古" or "Close to the Minotaur is considered as 'Ancient near Sinkhole'"},
        },
        default = false,
        hover = CH and "设定为是，则如果有远古守护者靠近楼梯，即视为“远古靠近楼梯”。\n如果你还设置了雕像/迷宫箱子，那么靠近其中之一即视作条件满足" or "If set to yes, if there is a Minotaur near the stairs, it is considered as 'Ancient near Sinkhole'\nIf you also set the statues/maze boxes, then near one of them is considered to meet the conditions",
    },
    {
		name = "cave other setting",
		label = CH and "其他设置" or "Other Settings",
		options = {{description = "", data = 0}},
		default = 0,
		-- tags = {"ignore"},
	},
    {
        name = "cave_repeat_times",
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
            {description = CH and "2000次" or "2000 times", data = 2000},
            {description = CH and "5000次" or "5000 times", data = 5000},
            {description = CH and "10000次" or "10000 times", data = 10000},
            {description = CH and "20000次" or "20000 times", data = 20000},
            {description = CH and "50000次" or "50000 times", data = 50000},
            {description = CH and "100000次" or "100000 times", data = 100000},
            {description = CH and "无限次" or "Infinite times", data = 2147483647},
        },
        default = 1,
        is_text_config = true,
        hover = CH and "生成指定个符合其他约束条件的地图，如果你需要一次性搜索多个洞穴地图，这可能有用" or "Generate the specified number of maps that meet other constraints, if you need to search for multiple cave maps at once, this may be useful",
    },
    {
        name = "ignore_error_cave",
        label = CH and "忽略崩溃" or "Ignore Crashing",
        options = {
            {description = CH and "否" or "no", data = false, hover = CH and "在生成失败时停止" or "Stop when generation fails"},
            {description = CH and "是" or "yes", data = true,  hover = CH and "这可能会掩盖问题，持续出现的问题会导致永远无法生成" or "This may mask the problem, persistent problems will cause generating forever"},
        },
        default = false,
        hover = CH and "有时候游戏本身或其他mod的bug会导致生成失败，这个选项让你可以在失败时继续" or "Sometimes the game itself or bugs in other mods can cause generation to fail, this option allows you to continue",
    },
}
