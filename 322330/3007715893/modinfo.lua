local L = locale ~= "zh" and locale ~= "zhr"

name = L and "More Items Stack" or "更多物品堆叠"

description = L and [[
Can set the maximum number of stacks,
while supporting stacking of bunnies, tall bird eggs, birds, fish, moles, eyeball turrets, mlavae egg, shadowheart, and minotaurhorn

Tip: Close the stack of tall birds when you need to hatch their eggs
]]
 or [[
可设置堆叠数上限,
同时支持小兔子、高脚鸟蛋、鸟类、鱼类、鼹鼠、眼球炮塔、岩浆虫卵、暗影心房、犀牛角进行堆叠

注意：需要孵化高脚鸟蛋时，请关闭高脚鸟的堆叠！
]]

author = "天涯共此时、小花朵"

version = "2.2.7"

forumthread = ""

api_version = 10

dont_starve_compatible = true
reign_of_giants_compatible = true
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon = "modicon.tex"
icon_atlas = "modicon.xml"


-- 添加分段标题
local function addTitle(title)
	return {
		name = "null",
		label = title,
		hover = nil,
		options = {
				{ description = "", data = 0 }
		},
		default = 0,
	}
end

-- 方法参数：配置名（modmain中配置用），中文显示名，英文显示名，默认是否开启，中文备注信息, 英文备注信息
local function addConfig(name, ch_label, en_label, default, ch_hover, en_hover)
	return {
		name = name,
		label = L and en_label or ch_label,
		hover = L and en_hover or ch_hover,
		options = 
		{	
			{description = L and "On" or "开启", data = true},
			{description = L and "Off" or "禁用", data = false},
		},
		default = default,
	}
end

configuration_options =
{
	{
		name = "STACK_SIZE",
		label = L and "Stack size" or "修改堆叠数值",
		hover = L and "Stack size" or "修改堆叠上限数值",
		options = 
		{	
			{description = L and "original date" or "原始数值", data = 20},
			{description = "40", data = 40},
			{description = "60", data = 60},
			{description = "80", data = 80},
			{description = "99", data = 99},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "999", data = 999},
			{description = "5000", data = 5000},
			{description = "10000", data = 10000},
		},
		default = 100,
	},
	{
		name = "STACK_SIZE1",
		label = L and "WORTOX SOUL" or "修改灵魂上限",
		hover = L and "Wortox soul maximum stack size" or "修改沃特克斯灵魂堆叠上限数值",
		options = 
		{	
			{description = L and "original data" or "原始数值", data = 20},
			{description = "40", data = 40},
			{description = "60", data = 60},
			{description = "80", data = 80},
			{description = "99", data = 99},
			{description = "100", data = 100},
			{description = "500", data = 500},
	        {description = "999", data = 999},
		},
		default = 100,
	},
	{
		name = "STACK_OTHER_OBJECTS",
		label = L and "More items stack" or "更多物品堆叠",
		hover = L and "Stacked fish, birds, tall bird egg, etc" or "堆叠鱼类、鸟类、高脚鸟原本不可堆叠物品等",
		options = 
		{	
			{description = L and "On" or "开启", data = true},
			{description = L and "Off" or "禁用", data = false},
		},
		default = true,
	},
	{
		name = "",
		label = L and "More items stack details" or "更多物品堆叠细项",
		hover = "",
		options = {
				{ description = "", data = 0 }
		},
		default = 0,
	},
	-- 分别为：配置名（modmain中配置用）,中文显示名,英文显示名,默认是否开启,中文备注提示,英文备注提示
	-- 若没有备注提示，则后两项可以不用写。也可以只写中文备注，不写英文备注。但是若是需要写英文备注，则中文备注必填
	--原版物品
	addConfig("blueprint", "常用蓝图","blueprint", false),
	addConfig("sketch", "常用草图","sketch", false),
	addConfig("wally", "厨师炊具", "Wally's stuff",true),
	addConfig("winona", "女工投石机和聚光灯", "Winona's stuff",true),
	addConfig("ancienttree_stuff", "神奇种子和树苗","Ancienttree Related stuff",  true),
	addConfig("rabbit", "兔子","Rabbit",  true),
	addConfig("mole", "鼹鼠", "Mole", true),
	addConfig("bird", "鸟类", "Bird", true),
	addConfig("crow","月盲乌鸦","Moonblind Crow", true),
	addConfig("fish", "鱼类和发光蟹", "Fish and LightCrab", true),
	addConfig("spider", "各类蜘蛛", "Spider", true),
	addConfig("eyeturret", "眼球炮塔", "Eyeturret", true),
	addConfig("tallbirdegg", "高脚鸟蛋", "Tallbirdegg", true, "如果需要孵化高鸟蛋，需要关闭堆叠","If you need to hatch tall eggs, you need to close the stack"),
	addConfig("lavae_egg", "岩浆虫卵", "Lavae egg", true, "如果需要孵化岩浆虫卵，需要关闭堆叠","If you need to hatch lavae eggs, you need to close the stack"),
	addConfig("shadowheart", "暗影心房", "Shadow heart", true),
	addConfig("glommerwings", "格罗姆翅膀", "Glommerwings", true),
	addConfig("moonrockidol", "月岩雕像,告密的心", "Moonrockidol and Reviver", true),
	addConfig("horn", "牛角和独角鲸角", "Horn", true, "注意：只能作为材料堆叠，如需作为工具，请关闭选项","Note: TURN OFF WHEN USE IT AS TOOL"),
	addConfig("deer_antler","鹿角和克劳斯钥匙","Deer Antler and Klaussackkey",true),
	addConfig("security_pulse_cage", "火花柜和约束静电", "Security Pulse Cage and Full Cage",true,"注能之前请分开一个， 一整组注能会导致整组物品数量变1","PLZ fill it 1 by 1, otherwise you will lose whole set of it."),
	addConfig("chestupgrade_stacksize", "箱子升级组件", "Chest Up Grade Set",true),
	addConfig("shell", "贝壳钟", "Singing Shell",true),
	addConfig("mooneye", "月眼", "Mooneye",true),
	addConfig("boat_stuff","船上用品及龙蝇船相关物品（无耐久）","Boat related stuff", true, "只加入了没有耐久的物品堆叠"),
	
	--模组物品
	{
		name = "",
		label = L and "Mod items stack details" or "模组物品堆叠",
		hover = "",
		options = {
				{ description = "", data = 0 }
		},
		default = 0,
	},
	
	addConfig("dengxian", "登仙：暗影玫瑰，上品，极品灵石", "Dengxian： shadow rose and stones", false),
	addConfig("myth_lotusleaf", "神话书说：荷叶和月饼", "Lotusleaf and Mooncake", false),
	addConfig("blank_certificate", "能力勋章：空白勋章和熔岩鳗鱼", "Blank certificate and LavaEel", false),
	addConfig("lg_choufish_inv", "海洋传说：小丑鱼", "Uglyfish", false),
	addConfig("aip_leaf_note", "额外物品包：树叶笔记,繁荣树种", "Aip leaf note", false),
	addConfig("foliageath", "棱镜：青枝绿叶，雨蝇", "Foliageath", false),
	addConfig("miao_packbox", "超级打包盒：超级打包盒", "Miao packbox", false,"需单个使用，整组使用会整组消耗"),
	addConfig("heap_of_foods", "Heap Of Food 更多料理", "Heap Of Foods", false),
	addConfig("tropical", "热带冒险（岛屿三合一Peng版）","Tropical Adventures(Peng Ver.)", false, "注意看作者是Peng， 其他版本不确定生效"),
	addConfig("reskin_tool", "作者自用", "For self use",false),
	
	
	
	
}
