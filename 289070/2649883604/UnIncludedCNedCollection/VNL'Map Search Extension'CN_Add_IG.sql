-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Map Search Extension'CN_Add_IG
-- Author: DeepLogic , Clear8Sky
-- DateCreated: 2021/11/14 4:43:57
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Map Search Extension” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																	Text)
VALUES

		("zh_Hans_CN",	"LOC_MSE_WINDOW_TITLE",													"地图搜索扩展"),
	
---- 主界面

		("zh_Hans_CN",	"LOC_MSE_BTN_REMOVE_LAST_WORD",											"←"),
		("zh_Hans_CN",	"LOC_MSE_BTN_REMOVE_LAST_WORD_TT",										"删除输入框内最后一条术语（多条术语以空格分隔）。"),
		("zh_Hans_CN",	"LOC_MSE_APPEND",														"追加搜索项目"),
		("zh_Hans_CN",	"LOC_MSE_APPEND_TT",													"将右侧面板中所选项目追加至输入框中（取消勾选则会直接替代）。"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA",													"搜索满足下列条件的单元格"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_TT",												"至少满足下列所选条件之一的单元格才会被搜索。"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_ME",												"本文明境内"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_ME_TT",											"在玩家文明境内的单元格将被搜索。"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_OTHER",											"其他文明境内"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_OTHER_TT",											"在其他文明境内的单元格将被搜索。"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_NONE",												"无主单元格"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_NONE_TT",											"所有无主单元格将被搜索。"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_PURCHASED_BY_ME",									"本文明城市附近"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_AREA_PURCHASED_BY_ME_TT",								"在玩家城市3格范围内的单元格将被搜索。"),

---- 地图搜索扩展的搜索设定

		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_BTN",											"↗"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_BTN_TT",										"“地图搜索扩展”相关设定"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_WND_TITLE",										"搜索扩展选项"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_COLOR_TITLE",									"单元格颜色"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_COLOR_FILL",									"被标记单元格的填充色"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_COLOR_BORDER1",									"被标记单元格的边框色"),
		("zh_Hans_CN",	"LOC_MSE_SEARCH_OPTIONS_COLOR_BORDER2",									"被标记单元格的边框阴影色"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_BLACK",													"黑"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_BLACK_TRANS",											"透明黑"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_WHITE",													"白"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_WHITE_TRANS",											"透明白"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_GREY",													"灰"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_GREY_TRANS",												"透明灰"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_GREEN",													"绿"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_GREEN_TRANS",											"透明绿"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_GREEN_DEFAULT",											"默认的绿色"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_BLUE",													"蓝"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_BLUE_TRANS",												"透明蓝"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_RED",													"红"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_RED_TRANS",												"透明红"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_YELLOW",													"黄"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_YELLOW_TRANS",											"透明黄"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_CYAN",													"天蓝"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_CYAN_TRANS",												"透明天蓝"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_MAGENTA",												"品红"),
		("zh_Hans_CN",	"LOC_MSE_COLOR_MAGENTA_TRANS",											"透明品红"),

---- 快速搜索选择器窗口

		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_DEST_SEARCH_TT",										"所选项目将进入搜索栏。单击改为进入过滤栏。"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_DEST_FILTER_TT",										"所选项目将进入过滤栏。单击改为进入搜索栏。"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_RESOURCE_TT",											"显示资源扩展搜索"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_CITY_TT",												"显示城市扩展搜索"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_CIVILIZATION_TT",										"显示文明扩展搜索"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_IMPROVEMENT_TT",										"显示改良设施扩展搜索"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_UNIT_TT",												"显示单位扩展搜索"),
		("zh_Hans_CN",	"LOC_MSE_EXT_SEL_WONDER_TT",											"显示奇观扩展搜索"),

---- 快速搜索窗口

		("zh_Hans_CN",	"LOC_MSE_EXT_WINDOW_TITLE",												"选择搜索项目"),
		("zh_Hans_CN",	"LOC_MSE_EXT_WINDOW_TITLE_FILTER",										"选择过滤项目"),

---- 额外搜索项目
---- 搜索项目悬停提示

		("zh_Hans_CN",	"LOC_MSE_EXT_SEARCH_TERMS_IMPROVEMENT_DOES_NOT_MATCH_RESOURCE_DESC",	"搜索因未被正确改良而无法享受收益的资源"),

		("zh_Hans_CN",	"LOC_MSE_EXT_SEARCH_TERMS_IMPROVEMENT_DOES_NOT_MATCH_RESOURCE",			"未被正确改良的资源");