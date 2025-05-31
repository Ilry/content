--名字
name = "月影双修+全技能解锁（含恶魔温蒂沃尔特）"
version = "1.2.2"
--描述
description = (
	"当前版本："..version..
	"\恶魔温蒂沃尔特！"..
	"\n-------------------------------------------------------"..
	"\n技能点上限默认30，若只想体验月影双修配置可改回15"..
	"\n解除锁定条件，月影双修"..
	"\n增加恶魔温蒂沃尔特技能解锁"..
	"\n旧存档有女工存在的档别中途开启此mod，女工玩家会加载不进去。可以先换人再开mod再换女工。创建世界的时候就开启此mod也不会有问题"
)

--作者
author = "寒天之水"

--匹配版本（默认）
api_version = 10
--联机版兼容
dst_compatible = true
--所有进入服务器的人必须有此mod
all_clients_require_mod = true

--预览图标
icon_atlas = "modicon.xml"
icon = "modicon.tex"

--标签
server_filter_tags = {"hantian"}

--优先级调高
priority = -9999

configuration_options = 
{
	{
		name = "insights_max",
		label = "洞察点上限数量",
		hover = "洞察点上限数量，15以下68天拿满，15以上每天获得一点",
		options =
		{
			{description = "15", data = 15, hover = "洞察点上限15，原版"},
			{description = "16", data = 16, hover = "洞察点上限16"},
			{description = "17", data = 17, hover = "洞察点上限17"},
			{description = "18", data = 18, hover = "洞察点上限18"},
			{description = "19", data = 19, hover = "洞察点上限19"},
			{description = "20", data = 20, hover = "洞察点上限20"},
			{description = "21", data = 21, hover = "洞察点上限21"},
			{description = "22", data = 22, hover = "洞察点上限22"},
			{description = "23", data = 23, hover = "洞察点上限23"},
			{description = "24", data = 24, hover = "洞察点上限24"},
			{description = "25", data = 25, hover = "洞察点上限25"},
			{description = "26", data = 26, hover = "洞察点上限26"},
			{description = "27", data = 27, hover = "洞察点上限27"},
			{description = "28", data = 28, hover = "洞察点上限28"},
			{description = "29", data = 29, hover = "洞察点上限29"},
			{description = "30", data = 30, hover = "洞察点上限30，默认"},
			{description = "40", data = 40, hover = "洞察点上限40"},
			{description = "50", data = 50, hover = "洞察点上限50"},
			{description = "100", data = 100, hover = "洞察点上限100"},
		},
		default = 30,
	},
	{
		name = "insights_lock",
		label = "洞察点限制条件",
		hover = "取消技能间的限制条件，可以月影双休",
		options =
		{
			{description = "取消限制", data = 0, hover = "取消限制条件，可月影双修"},
			{description = "原有限制", data = 1, hover = "保持原有限制条件"},
		},
		default = 0,
	}
}