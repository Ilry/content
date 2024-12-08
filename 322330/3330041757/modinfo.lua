name = "WX-78 电路增强/Circuit Boost"
description = [[
【请点击右下角的小螺丝图标进行各种设置。】
【You can click the small gear icon in the lower right to access settings.】

兼容WX-78接口翻倍模组。
Compatible WX-78 Interface Doubling Mod.

V1.7
更新日志：/ Patch Notes: 
(超级)强化电路加强 / (SUPER) HARDY CIRCUIT BOOST
默认数值为原版数值。/ The default values are set to the original game values.
]]
author = "装比过度"
version = "1.7"
api_version = 10
icon_atlas = "img.xml"
icon = "img.tex"
priority = 99999999999  -- 优先其他mod加载

dst_compatible = true --联机版兼容
all_clients_require_mod = false --所有客机都需要该mod
client_only_mod = false --只有客户端有这mod是否运行
server_only_mod = true --只有服务端有这mod是否运行

configuration_options = {
	{
        name = "SCANNER_SCANPERIOD",
        label = "扫描所需时间/SCANNER SCANPERIOD",
        options = {
            {description = "原版/Original", data = 10},
            {description = "短/Fast", data = 5},
			{description = "很短/Very Fast", data = 3},
        },
        default = 10, 
		hover = "让你的扫描仪更快地完成扫描生物的任务。\n"..
		"Make your scanner finish scanning creatures faster.",
    },
	{
        name = "CHARGE_REGENTIME",
        label = "充电恢复所需时间/CHARGE REGENTIME",
        options = {
            {description = "原版/Original", data = 90},
            {description = "快/Fast", data = 60},
			{description = "很快/Very Fast", data = 30},
			{description = "非常快/Ultra Fast", data = 15},
        },
        default = 90, 
		hover = "拔掉电路之后可以迅速恢复充电。\n"..
		"Quickly recharge after removing the circuit.",
    },
	{
        name = "MINACCEPTABLEMOISTURE",
        label = "抗潮湿能力/MIN ACCEPTABLE MOISTURE",
        options = {
            {description = "原版/Original", data = 15},
            {description = "中等/Medium", data = 25},
			{description = "高/High", data = 33},
			{description = "很高/Very High", data = 50},
        },
        default = 15, 
		hover = "即使很潮湿也不容易丢失电量。\n"..
		"Even in wet conditions, you won't easily lose charge.",
    },
	{
        name = "MODULE_USES",
        label = "电路使用耐久/CIRCUIT USES",
        options = {
            {description = "原版/Original", data = 4},
            {description = "多次/Multiple", data = 10},
			{description = "很多次/Extensive", data = 100},
        },
        default = 4, 
		hover = "为你的机器人争取自由更换电路的基本权利。\n"..
		"Changing circuits is a basic right for every robot.",
    },
	{
        name = "MAXHEALTH_BOOST",
        label = "(超级)强化电路加强/(SUPER) HARDY CIRCUIT BOOST",
        options = {
            {description = "原版/Original", data = 50},
            {description = "加强/Hardy", data = 60},
			{description = "很强/Hardy+", data = 70},
			{description = "炒鸡强/Hardy++", data = 80},
        },
        default = 50, 
		hover = "扛揍铁皮罩。\n"..
		"Fortified Iron Shell.",
    },
	
    {
        name = "Brightness",
        label = "照明电路范围/ILLUMINATION CIRCUIT RANGE",
        options = {
            {description = "原版/Original", data = 3.5},
            {description = "中等/Medium", data = 6},
			{description = "广阔/Wide", data = 8},
        },
        default = 3.5, 
		hover = "照亮你的队友。\n"..
		"Light up your teammates.",
    },
	{
        name = "MUSIC",
        label = "合唱盒电路加强/CHORUSBOX CIRCUIT BOOST",
        options = {
            {description = "原版/Original", data = 4.5},
            {description = "动听/Melodious", data = 1},
			{description = "非常动听/Very Melodious", data = 0.5},
        },
        default = 4.5, 
		hover = "记得演奏给你的伙伴们听。\n"..
		"Don't forget to play it for your companions.",
    },
	{
        name = "SLOWPERCENT",
        label = "超级胃增益电路加强/SUPER GASTROGAIN CIRCUIT BOOST",
        options = {
            {description = "原版/Original", data = 0.80},
            {description = "低能耗/Low Consumption", data = 0.70},
			{description = "超低能耗/Ultra-low consumption", data = 0.50},
        },
        default = 0.80, 
		hover = "节能环保。\n"..
		"Energy-saving and environmentally friendly.",
    },
	{
        name = "TASERDAMAGE",
        label = "电气化电路伤害/TASER CIRCUIT DAMAGE",
        options = {
            {description = "原版/Original", data = 20},
            {description = "中等/Medium", data = 40},
			{description = "高/High", data = 50},
        },
        default = 20, 
		hover = "电击疗法。\n"..
		"Electrotherapy.",
    },
	{
        name = "BEE_TICKPERIOD",
        label = "豆增压电路健康恢复速率/BEANBOOSTER CIRCUIT HEALTH RECOVERY RATE",
        options = {
            {description = "原版/Original", data = 30},
            {description = "快/Fast", data = 15},
			{description = "很快/Very Fast", data = 10},
			{description = "非常快/Ultra Fast", data = 5},
        },
        default = 30, 
		hover = "击败蜂王的奖励。\n"..
		"Rewards for defeating the Bee Queen.",
    },
	{
        name = "MAXSANITY_DAPPERNESS",
        label = "豆增压和超级处理器电路理智恢复速率/BEANBOOSTER AND SUPER PROCESSOR CIRCUIT SANITY RECOVERY RATE",
        options = {
            {description = "原版/Original", data = 0},
            {description = "快/Fast", data = 0.1},
			{description = "很快/Very Fast", data = 0.2},
			{description = "非常快/Ultra Fast", data = 0.3},
        },
        default = 0, 
		hover = "理性的电线哥。\n"..
		"A Rational Wire Man.",
    },
	{
        name = "MOVESPEED",
        label = "超级加速电路加强/SUPER ACCELERATION CIRCUIT BOOST",
        options = {
            {description = "原版/Original", data = 0},
            {description = "开/On", data = 1},
        },
        default = 0, 
		hover = "最多3个超级加速电路无衰减叠加。\n"..
		"Up to 3 Super Acceleration Circuit with No Diminishing Returns.",
    },
	{
        name = "COLDRATE",
        label = "制冷电路保鲜/REFRIGERANT CIRCUIT PRESERVATION",
        options = {
            {description = "原版/Original", data = 0.75},
            {description = "中等/High Preservation", data = 0.5},
			{description = "高/Superior Preservation", data = 0.25},
			{description = "永鲜/Perpetual Freshness", data = 0},
			{description = "反鲜/Freshness Restoration", data = -0.5},
        },
        default = 0.75, 
		hover = "一台行走的冰箱。\n"..
		"A Moving Fridge.",
    },
	{
        name = "ICE",
        label = "制冷电路制冰/REFRIGERANT CIRCUIT MAKE ICE CUBS",
        options = {
            {description = "原版/Original", data = 0},
            {description = "开/On", data = 1},
        },
        default = 0, 
		hover = "再见，眼球伞。\n"..
		"Goodbye, Eyebrella!",
    },
}