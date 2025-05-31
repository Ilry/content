--[[
部分内容已被原作者采纳，因此补丁自然会随着更新减少
被采纳但仍实装存在问题的部分将被注释或保留以便参考
]]

name = "WX自动化补丁"
author = "wiefean"
version = "1.5"

description = "版本: "..version.."\n"..
'这个模组的起因是"WX自动化"存在一些不太舒适的现象\n'..
'该模组只是一个补丁，非模组本体，请在开启"WX自动化"的情况下使用该模组\n'..
'部分内容已被原作者采纳，因此补丁自然会随着更新减少\n'..
'所有补丁内容除标注外默认开启\n\n'..

'杂项：月晷可取水；羽毛笔制作只需树枝(默关)；全人物可制作电路 (默关)\n\n'..

'操纵杆：静音；快速动作；施法可通过移动打断；对自己使用时，将跟随自己的机器人传送至附近 (不会传送到海里)\n\n'..

'WX机器人：装备管理优化；移除给予操作；更清楚地显示位置；'..
'冰冻不掉电；不能被锤；落水不丢失物品；免疫偷窃；自动修理特殊物品(眼面具/盾，骨甲等)；\n'..
'免疫潮湿 (默关)；可搬运重物 (默关)；死亡齿轮全返还 (默关)；\n'..
'可装备永不妥协诅咒物品 (默关)'


server_filter_tags = {"wx", "wx78"}

forumthread = ""
priority = -78
api_version = 10

dst_compatible = true
dont_starve_compatible = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"


--标题
local function Title(title)
	return	{
		name = "",
		label = title,
		options = {{description = "", data = 0}},
		default = 0,
	}
end

--是否型配置
local function Bool(Name, Label, Hover)
	return {
        name = Name,
        label = Label,
		hover = Hover,
		options = {
			{description = "是 (默认)", data = true},
			{description = "否", data = false},
		},
		default = true,	
	}
end

--是否型配置(默认为"否")
local function Bool2(Name, Label, Hover)
	return {
        name = Name,
        label = Label,
		hover = Hover,
		options = {
			{description = "是", data = true},
			{description = "否 (默认)", data = false},
		},
		default = false,	
	}
end

--横轴位置修正配置
local function OffsetX(Name, Label, Hover)
	local opt = {
        name = Name,
        label = Label,
		hover = Hover,
		options = {},
		default = 0,
	}

	local offset = -1000
	for i = 1,41 do
		opt.options[i] = {description = (offset == 0 and "无 (默认)") or offset, data = offset}
		offset = offset + 50
	end

	return opt
end

--纵轴位置修正配置
local function OffsetY(Name, Label, Hover)
	local opt = {
        name = Name,
        label = Label,
		hover = Hover,
		options = {},
		default = 0,
	}

	local offset = -100
	for i = 1,6 do
		opt.options[i] = {description = (offset == 0 and "无 (默认)") or offset, data = offset}
		offset = offset + 20
	end
	for i = 7,27 do
		opt.options[i] = {description = offset, data = offset}
		offset = offset + 50
	end

	return opt
end

configuration_options = {
	Title("杂项"),	
	Bool("moondial_water", "月晷可取水", "让水壶可以在月晷处装水，方便机器人种田\n新月，月亮风暴，或在洞穴中时不能取水 (毕竟没水)"),
	Bool2("easy_featherpencil", "羽毛笔制作只需树枝", "非常舒服"),
	Bool2("everyone_modu", "全人物可制作电路", "无需生物数据，在科技栏制作电路和提取器"),


	Title("操纵杆"),
	Bool("rod_mute", "静音", "去掉烦人又鸡肋的机器人距离探测功能"),
	Bool("rod_quick", "快速动作", "减少原地罚站的时间\n施法可通过移动打断"),
	Bool("rod_teleport", "传送机器人", "对自己使用时，将跟随自己的机器人传送至附近 (不会传送到海里)\n(这屑机器人在加载范围外不会自动传送，导致每次跳虫洞都要等半天才走过来)"),

	Title("WX机器人"),
	Bool("wx_equipbar", "装备管理优化", "存放于机器人的物品可以右键直接给予机器人\n玩家装备的背包等容器装备也可以右键直接给予机器人"),
	Bool("wx_no_give", "移除给予操作", "有装备栏的情况下，给予操作就可以舍弃了，不然还妨碍存东西"),
	Bool("wx_map_reveal", "更清楚地显示位置", "玩家装备操纵杆时，机器人的位置将突出显示"),
	Bool("wx_no_structure_collision", "建筑不挡机器人", "看着机器人卡住很烦人"),
	Bool("wx_no_freeze_charge_down", "冰冻不掉电", "方便打巨鹿或冰狗等"),
	Bool("wx_no_hammer", "不能被锤", "不用担心被建筑破坏属性秒杀了"),
	Bool("wx_repair_special", "自动修理特殊物品", "详见下"),
	Bool("wx_no_drown_loss", "落水不丢失物品", "掉进海里时不会丢失物品\n登船意外保险"),
	Bool("wx_no_steal", "免疫偷窃", "猴子或青蛙等不能从机器人身上偷东西"),
	Bool2("wx_moisture_immune", "免疫潮湿", "字面意思，如果懒得做防潮措施的话"),
	Bool2("wx_lift_heavy", "可搬运重物", "玩家搬运重物时对机器人右键，可以让机器人搬运重物\n(机器人不会被装备减速，因此默认关闭)"),
	Bool2("wx_return_gears", "死亡齿轮全返还", "死亡时掉落6个齿轮而不是3个\n相当于重造只需再消耗1个电子原件和1个烂电线"),
	Bool2("wx_vetcurse", "可装备永不妥协诅咒物品", "让机器人可以装备来自永不妥协模组的诅咒物品\n兼容性未知，至少目前没什么问题，以防万一还是默认关闭了"),
	
	Title("WX机器人.自动修理特殊物品"),
	Bool("wx_repair_special_skeleton", "骨甲", "噩梦燃料"),
	Bool("wx_repair_special_watch", "警钟", "噩梦燃料；纯粹恐惧"),
	Bool("wx_repair_special_eye", "眼面具/盾", "腐烂食物；生怪物肉"),
}