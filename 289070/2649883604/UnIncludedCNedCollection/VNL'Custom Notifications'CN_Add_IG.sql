-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Custom Notifications'CN_Add_IG
-- Author: DeepLogic , Clear8Sky
-- DateCreated: 2021/11/14 5:40:27
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Custom Notifications” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,							Text)
VALUES
		("zh_Hans_CN",	"LOC_CN_BUTTON_TOOLTIP",		"自定义提示"),
		("zh_Hans_CN",	"LOC_CN_TITLE",					"自定义提示"),
		("zh_Hans_CN",	"LOC_CN_CITY_POP_CHECKBOX",		"城市人口增长的提示"),
		("zh_Hans_CN",	"LOC_CN_CITY_BORDER_CHECKBOX",	"城市边界扩张的提示"),
		("zh_Hans_CN",	"LOC_CN_TRADE_DEAL_CHECKBOX",	"提示交易到期的提示"),
		("zh_Hans_CN",	"LOC_CN_RELIGION_CHECKBOX",		"提示宗教传播的提示"),
		("zh_Hans_CN",	"LOC_CN_CITY_POP_TITLE",		"城市人口增长"),
		("zh_Hans_CN",	"LOC_CN_CITY_POP_MESSAGE",		"{1_CN_City_Name}的人口增长了"),
		("zh_Hans_CN",	"LOC_CN_CITY_POP_MESSAGE_1",	"公民选择了{1_CN_City_Name}作为他们的新家。"),
		("zh_Hans_CN",	"LOC_CN_RELIGION_TITLE",		"宗教传播"),
		("zh_Hans_CN",	"LOC_CN_RELIGION_MESSAGE",		"{1_CN_Religion_Name}现在是{2_CN_City_Name}的主流宗教"),
		("zh_Hans_CN",	"LOC_CN_RELIGION_MESSAGE_1",	"{1_CN_Religion_Name}不再是{2_CN_City_Name}的主流宗教"),
		("zh_Hans_CN",	"LOC_CN_CITY_BORDER_TITLE",		"边界扩张"),
		("zh_Hans_CN",	"LOC_CN_CITY_BORDER_MESSAGE",	"{1_CN_City_Name}城市扩张了其边界。"),
		("zh_Hans_CN",	"LOC_CN_TRADE_DEAL_TITLE",		"交易到期"),
		("zh_Hans_CN",	"LOC_CN_TRADE_DEAL_MESSAGE",	"您与{1_CN_Player_Name}的交易到期了。");

