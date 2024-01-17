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

version = "2.0.2"

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
			{description = "99", data = 99},
			{description = "100", data = 100},
			{description = "200", data = 200},
			{description = "500", data = 500},
			{description = "999", data = 999},
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
	addConfig("rabbit", "兔子","Rabbit",  true),
	addConfig("mole", "鼹鼠", "Mole", true),
	addConfig("bird", "鸟类", "Bird", true),
	addConfig("fish", "鱼类", "Fish", true),
	addConfig("spider", "各类蜘蛛", "Spider", true),
	addConfig("eyeturret", "眼球炮塔", "Eyeturret", true),
	addConfig("tallbirdegg", "高脚鸟蛋", "Tallbirdegg", true, "如果需要孵化高鸟蛋，需要关闭堆叠","If you need to hatch tall eggs, you need to close the stack"),
	addConfig("lavae_egg", "岩浆虫卵", "Lavae egg", true, "如果需要孵化岩浆虫卵，需要关闭堆叠","If you need to hatch lavae eggs, you need to close the stack"),
	addConfig("shadowheart", "暗影心房", "Shadowheart", true),
	addConfig("minotaurhorn", "犀牛角", "Minotaurhorn", true),
	addConfig("aip_leaf_note", "树叶笔记", "Aip_leaf_note", true),
	addConfig("miao_packbox", "超级打包盒", "Miao_packbox", true),
	addConfig("glommerwings", "格罗姆翅膀", "Glommerwings", true),
	addConfig("moonrockidol", "月岩雕像", "Moonrockidol", true),
	addConfig("horn", "牛角", "Horn", false, "注意：使用时处于多个堆叠状态牛角时会有bug","Note: There are bugs when using horns in multiple stacked states"),
	addConfig("myth_lotusleaf", "荷叶(神话书说)", "Myth_lotusleaf", true),
	addConfig("blank_certificate", "空白勋章(能力勋章)", "Blank certificate", true),
}
