local zh = "zh" --Chinese(default)
local en = "en" --English
local variable = (locale == "zh" or locale == "zhr" or locale == "zht") and "zh" or "en"

local info = {
	information = {
		mod_name = {
            [zh] = "成熟的箱子",
            [en] = "Smart Chest"
        },
		description_text = {
			[zh] = "你已经是个成熟的箱子了，要学会自己捡东西\n基本功能：使附近插有小木牌的箱子可以收集对应的物品。\n\t收集的物品由附近的（小木牌图案）决定\n\t（丢弃物品、战利品掉落、周期性掉落）的物品会被收集\n\t（打开箱子）会使这个箱子主动收集一次\n特殊木牌：\n\t1.收集所有物品\n\t2.收集箱子内部存在的物品\n\t3.哪个木牌具有特殊功能可以设置\n其他功能：\n\t1.小木牌防火\n\t2.特殊木牌重命名\n解释：\n\tminisign_drawn：在这里表示绘制了物品的小木牌。\n\tminisign_drawn_minisign：在这里表示绘制了minisign_drawn的小木牌",
			[en] = "You are a mature chest. Learn to collect itemss up by yourself\nBasic function: Enable the nearby chest with minisign to collect corresponding items.\n\tThe items collected are determined by the nearby (minisign image)\n\t(drop items, loot drops, periodic drops) items will be collected\n\t(opening the chest) causes the chest to actively collect once\nSpecial minisign:\n\t1. Collect all the items\n\t2. Collect the items that exist inside the box\n\t3. Which minisign has special function can be set\nOther features:\n\t1. minisign fire protection\n\t2. minisign renamed\nExplanation:\n\tminisign_drawn: the minisign that has drawn a item.\n\tminisign_drawn_minisign: minisign with minisign_drawn drawn."
		}
	},
	chesttype = {
		titlename = {
			[zh] = "箱子种类",
            [en] = "Chest type"
		},
		open = {
			[zh] = "开启自动收集",
			[en] = "open auto collect"
		},
		close = {
			[zh] = "关闭自动收集",
			[en] = "close auto collect"
		},
		treasurechest = {
			label = {
				[zh] = "木箱",
				[en] = "wooden chest"
			}
		},
		dragonflychest = {
			label = {
				[zh] = "龙蝇箱子",
				[en] = "dragon fly chest"
			}
		},
		icebox = {
			label = {
				[zh] = "冰箱",
				[en] = "ice box"
			}
		},
		saltbox = {
			label = {
				[zh] = "盐盒",
				[en] = "salt box"
			}
		},
		allcontainers = {
			label = {
				[zh] = "所有箱子(包括mod的)",
				[en] = "all chest(include mod's chest)"
			},
			hover = {
				[zh] = "！！！慎用，不保证兼容性！！！",
				[en] = "!!! Use with caution, compatibility is not guaranteed !!!"
			}
		}
	},
	iscollectone = {
		label = {
			[zh] = "收集种类限制",
			[en] = "Collection type restrictions"
		},
		onlyone = {
			[zh] = "每个箱子是否只收集一种",
			[en] = "is only collect one kind pre chest"
		},
		one = {
			[zh] = "只能一种",
			[en] = "only one kind"
		},
		many = {
			[zh] = "可以多种",
			[en] = "can many kinds"
		}
	},
	distance = {
		label = {
			[zh] = "距离设置 (4 == 一块地皮)",
			[en] = "distance setting (4 == A piece of land)"
		},
		hover = {
			[zh] = "4 == 一块地皮",
			[en] = "4 == A piece of land"
		},
		minisign = {
			[zh] = "检测小木牌半径",
			[en] = "Test the radius of small wooden sign"
		},
		collect0 = {
			[zh] = "收集物品半径 十位",
			[en] = "Radius of items collected (ten)"
		},
		collect1 = {
			[zh] = "收集物品半径 个位",
			[en] = "Radius of items collected (one)"
		},
		collecthover = {
			[zh] = "实际半径是 10*十位 + 个位",
			[en] = "The actual radius is 10 * tenValue + oneValue"
		}
	},
	collectTime = {
		label = {
			[zh] = "收集时机",
			[en] = "Timing of collection"
		},
		yes = {
			[zh] = "收集",
			[en] = "yes"
		},
		no = {
			[zh] = "不收集",
			[en] = "no"
		},
		drop = {
			[zh] = "丢弃时是否收集物品",
			[en] = "is collect when drop?"
		},
		open = {
			[zh] = "打开时是否收集物品",
			[en] = "is collect when open?"
		},
		take = {
			[zh] = "取出整组物品时是否收集物品",
			[en] = "is collect when take items?"
		},
		period = {
			label = {
				[zh] = "是否收集周期性掉落物品",
				[en] = "is collect periodic dropped items?"
			},
			hover = {
				[zh] = "例如格罗姆掉落的粘液",
				[en] = "such as glommer fuel"
			}
		},
		loot = {
			label = {
				[zh] = "是否收集战利品",
				[en] = "is collect spoils?"
			},
			hover = {
				[zh] = "例如格罗姆死亡掉落的怪物肉、粘液、翅膀",
				[en] = "such as the monster meat, fule, wings dropped by glommer's death"
			}
		},
		ash = {
			label = {
				[zh] = "是否收集燃烧产生的灰",
				[en] = "is collect ash when item burnt?"
			},
		},
		oceantrawler = {
			label = {
				[zh] = "是否收集海洋拖网捕鱼器溢出的鱼",
				[en] = "is collect fish spilled from examine ocean trawler?"
			},
		},
		all = {
			label = {
				[zh] = "收集几乎所有类型的掉落物",
				[en] = "Collect almost every type of drop"
			}
		},
	},
	specialminisign = {
		label = {
			[zh] = "特殊木牌",
			[en] = "Special minisign"
		},
		hover = {
			[zh] = "特殊木牌具有其他功能，而不是收集对应物品。",
			[en] = "Special minisign have other functions, not collecting corresponding items."
		},
		turnoff = {
			description = {
				[zh] = "关闭",
				[en] = "turn off"
			},
			data = 0,
		},
		minisign_drawn_minisign = {
			description = {
				[zh] = "minisign_drawn_minisign",
				[en] = "minisign_drawn_minisign"
			},
			data = "minisign_drawn",
		},
		opalpreciousgem = {
			description = {
				[zh] = "彩虹宝石",
				[en] = "Iridescent gem"
			},
			data = "opalpreciousgem",
		},
		hermit_pearl = {
			description = {
				[zh] = "珍珠的珍珠",
				[en] = "Pearl's Pearl",
			},
			data = "hermit_pearl",
		},
		hermit_cracked_pearl = {
			description = {
				[zh] = "开裂珍珠",
				[en] = "Cracked Pearl",
			},
			data = "hermit_cracked_pearl",
		},
		miniflare = {
			description = {
				[zh] = "信号弹",
				[en] = "Flare"
			},
			data = "miniflare",
		},
		minifan = {
			description = {
				[zh] = "旋转的风扇",
				[en] = "Whirly Fan"
			},
			data = "minifan",
		},
		grass_umbrella = {
			description = {
				[zh] = "花伞",
				[en] = "Pretty Parasol"
			},
			data = "grass_umbrella",
		},
		kelphat = {
			description = {
				[zh] = "海花环",
				[en] = "Seawreath"
			},
			data = "kelphat",
		},
		watermelonhat = {
			description = {
				[zh] = "西瓜帽",
				[en] = "Fashion Melon"
			},
			data = "watermelonhat",
		},
		icehat = {
			description = {
				[zh] = "冰帽",
				[en] = "Ice Cube"
			},
			data = "icehat",
		},
		collectAll = {
			label = {
				[zh] = "收集所有物品",
				[en] = "Collect all items"
			},
			hover = {
				[zh] = "具有反选功能，附近的其他木牌表示为不收集对应物品。",
				[en] = "Have anti-selection function, and other nearby minisign indicate that corresponding items are not collected."
			}
		},
		collectChestSlot = {
			label = {
				[zh] = "收集箱子中存在的物品",
				[en] = "Collect items that exist in chest"
			},
			hover = {
				[zh] = "具有反选功能，附近的其他木牌表示为不收集对应物品。",
				[en] = "Have anti-selection function, and other nearby minisign indicate that corresponding items are not collected."
			}
		},
	},
	common = {
		label = {
			[zh] = "其他设置",
			[en] = "Other Settings"
		},
		yes = {
			[zh] = "打开",
			[en] = "yes"
		},
		no = {
			[zh] = "关闭",
			[en] = "no"
		},
		minisignnofire = {
			label = {
				[zh] = "绘制并且插在地上的小木牌防火",
				[en] = "The drawn and deployed minisign fire prevention"
			},
			hover = {
				[zh] = "没有绘制物品的小木牌不防火",
				[en] = "Ordinary minisign without painting items are not fire prevention"
			}
		},
		renameSpecialMinisign = {
			label = {
				[zh] = "重命名特殊木牌",
				[en] = "Rename special minisign"
			},
			hover = {
				[zh] = "重命名为具体的功能",
				[en] = "Rename to a specific function"
			}
		},
	}
}

-- name = info.information.mod_name[variable]
name = "Smart Chest"
-- info.information.description_text[variable]
description = info.information.description_text[variable]
author = "little_xuuu"
version = "2.3.1"
forumthread = ""
api_version = 10
all_clients_require_mod = true
server_only_mod = false
client_only_mod=false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
-- folder_name = folder_name or "workshop-"
-- description = "Mod文件夹：" .. folder_name .."\n" .. description
priority = 2147483646  -- 调高优先级，因为涉及到一部分覆盖式修改。我没有想到如何用更加恰当的方式实现。如果有大佬看到请帮帮我。在modmain.lua中搜索 ！！！ 就可以找到那部分。
					   -- Raise the priority because some override changes are involved.  I haven't thought of a more appropriate way to do it.  If any of the friends see this please help me.  Search in modmain.lua "！！！" you can find that part. 
					   -- 现在的覆盖式改动，仅覆盖游戏的官方函数那个部分。不会修改mod添加的部分。如果没有人和我用相同的方式覆盖的话。因为我要实现的功能需要官方函数返回一个item。但是他没有返回，只是一个局部变量，用upvalue也取不到。
-- Refer to other mod designs 增加标题
local function ModOptions(title, hover)
    return {
        name = title,
        hover = hover,
        options = {{description = "", data = false}},
        default = false
    }
end

-- Add mod setting/增加MOD设置
local function AddConfig(name, label, hover, options, default)
    return {
        name = name,
        label = label,
        hover = hover or "",
        options = options,
        default = default
    }
end

configuration_options =
{
	ModOptions(info.chesttype.titlename[variable]),
	AddConfig("treasurechest", 
		info.chesttype.treasurechest.label[variable],
		nil, 
		{
			{description = info.chesttype.open[variable], data = 1},
			{description = info.chesttype.close[variable], data = 0},
		},
		1
	),
	AddConfig("dragonflychest", 
		info.chesttype.dragonflychest.label[variable],
		nil, 
		{
			{description = info.chesttype.open[variable], data = 1},
			{description = info.chesttype.close[variable], data = 0},
		},
		1
	),
	AddConfig("icebox", 
		info.chesttype.icebox.label[variable],
		nil, 
		{
			{description = info.chesttype.open[variable], data = 1},
			{description = info.chesttype.close[variable], data = 0},
		},
		1
	),
	AddConfig("saltbox", 
		info.chesttype.saltbox.label[variable],
		nil, 
		{
			{description = info.chesttype.open[variable], data = 1},
			{description = info.chesttype.close[variable], data = 0},
		},
		1
	),
	AddConfig("allcontainers", 
		info.chesttype.allcontainers.label[variable],
		info.chesttype.allcontainers.hover[variable],
		{
			{description = info.chesttype.open[variable], data = 1},
			{description = info.chesttype.close[variable], data = 0},
		},
		0
	),
	ModOptions(info.iscollectone.label[variable]),
	AddConfig("iscollectone", 
		info.iscollectone.onlyone[variable],
		nil, 
		{
			{description = info.iscollectone.one[variable], data = 1},
			{description = info.iscollectone.many[variable], data = 0},
		},
		1
	),
	ModOptions(info.distance.label[variable], info.distance.hover[variable]),
	AddConfig("minisign_dist", 
		info.distance.minisign[variable],
		nil, 
		{
			{description = "0.1", data = 0.1},
			{description = "0.5", data = 0.5},
			{description = "1", data = 1},
			{description = "1.5", data = 1.5},
			{description = "2", data = 2},
			{description = "2.5", data = 2.5},
			{description = "3", data = 3},
		},
		1.5
	),
	AddConfig("collect_items_dist0", 
		info.distance.collect0[variable],
		info.distance.collecthover[variable],
		{
			{description = "0", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
		},
		1
	),
	AddConfig("collect_items_dist1", 
		info.distance.collect1[variable],
		info.distance.collecthover[variable],
		{
			{description = "0", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
		},
		6
	),
	ModOptions(info.collectTime.label[variable]),
	AddConfig("is_collect_drop", 
		info.collectTime.drop[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_open", 
		info.collectTime.open[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_take", 
		info.collectTime.take[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_periodicspawner", 
		info.collectTime.period.label[variable],
		info.collectTime.period.hover[variable],
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_lootdropper", 
		info.collectTime.loot.label[variable],
		info.collectTime.loot.hover[variable],
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_oceantrawler", 
		info.collectTime.oceantrawler.label[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	AddConfig("is_collect_all", 
		info.collectTime.all.label[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),
	--[[AddConfig("is_collect_ash", 
		info.collectTime.ash.label[variable],
		nil,
		{
			{description = info.collectTime.yes[variable], data = 1},
			{description = info.collectTime.no[variable], data = 0},
		},
		1
	),]]
	ModOptions(info.specialminisign.label[variable], info.specialminisign.hover[variable]),
	AddConfig("collectAll",
		info.specialminisign.collectAll.label[variable],
		info.specialminisign.collectAll.hover[variable],
		{
			{description = info.specialminisign.turnoff.description[variable], data = info.specialminisign.turnoff.data},
			{description = info.specialminisign.minisign_drawn_minisign.description[variable], data = info.specialminisign.minisign_drawn_minisign.data},
			{description = info.specialminisign.opalpreciousgem.description[variable], data = info.specialminisign.opalpreciousgem.data},
			{description = info.specialminisign.hermit_pearl.description[variable], data = info.specialminisign.hermit_pearl.data},
			{description = info.specialminisign.hermit_cracked_pearl.description[variable], data = info.specialminisign.hermit_cracked_pearl.data},
			{description = info.specialminisign.miniflare.description[variable], data = info.specialminisign.miniflare.data},
			{description = info.specialminisign.minifan.description[variable], data = info.specialminisign.minifan.data},
			{description = info.specialminisign.grass_umbrella.description[variable], data = info.specialminisign.grass_umbrella.data},
			{description = info.specialminisign.kelphat.description[variable], data = info.specialminisign.kelphat.data},
			{description = info.specialminisign.watermelonhat.description[variable], data = info.specialminisign.watermelonhat.data},
			{description = info.specialminisign.icehat.description[variable], data = info.specialminisign.icehat.data},
		},
		0
	),
	AddConfig("collectChestSlot",
		info.specialminisign.collectChestSlot.label[variable],
		info.specialminisign.collectChestSlot.hover[variable],
		{
			{description = info.specialminisign.turnoff.description[variable], data = info.specialminisign.turnoff.data},
			{description = info.specialminisign.minisign_drawn_minisign.description[variable], data = info.specialminisign.minisign_drawn_minisign.data},
			{description = info.specialminisign.opalpreciousgem.description[variable], data = info.specialminisign.opalpreciousgem.data},
			{description = info.specialminisign.hermit_pearl.description[variable], data = info.specialminisign.hermit_pearl.data},
			{description = info.specialminisign.hermit_cracked_pearl.description[variable], data = info.specialminisign.hermit_cracked_pearl.data},
			{description = info.specialminisign.miniflare.description[variable], data = info.specialminisign.miniflare.data},
			{description = info.specialminisign.minifan.description[variable], data = info.specialminisign.minifan.data},
			{description = info.specialminisign.grass_umbrella.description[variable], data = info.specialminisign.grass_umbrella.data},
			{description = info.specialminisign.kelphat.description[variable], data = info.specialminisign.kelphat.data},
			{description = info.specialminisign.watermelonhat.description[variable], data = info.specialminisign.watermelonhat.data},
			{description = info.specialminisign.icehat.description[variable], data = info.specialminisign.icehat.data},
		},
		0
	),
	ModOptions(info.common.label[variable]),
	AddConfig("minisignnofire",
		info.common.minisignnofire.label[variable],
		info.common.minisignnofire.hover[variable],
		{
			{description = info.common.yes[variable], data = 1},
			{description = info.common.no[variable], data = 0},
		},
		1
	),
	AddConfig("renameSpecialMinisign",
		info.common.renameSpecialMinisign.label[variable],
		info.common.renameSpecialMinisign.hover[variable],
		{
			{description = info.common.yes[variable], data = 1},
			{description = info.common.no[variable], data = 0},
		},
		1
	)
}

--[[
if isLocal then
	table.insert(configuration_options, 1, ModOptions("本地mod"))
end]]--