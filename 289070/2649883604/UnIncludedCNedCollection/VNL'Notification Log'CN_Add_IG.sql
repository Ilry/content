-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Notification Log'CN_Add_IG
-- Author: DeepLogic , Clear8Sky
-- DateCreated: 2021/11/10 12:29:27
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Notification Log” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_FF16_NOTIFICATION_LOG_TITLE",		"消息记录"),
		("zh_Hans_CN",	"LOC_FF16_LOGSIZE_OPTION",				"面板尺寸："),
		("zh_Hans_CN",	"LOC_FF16_MAXLOGSIZE_OPTION",			"条数上限："),
		("zh_Hans_CN",	"LOC_FF16_LOGSIZE_AUTO",				"自动"),
		("zh_Hans_CN",	"LOC_FF16_CLEARLOG_OPTION",				"下一回合自动清空"),
		("zh_Hans_CN",	"LOC_FF16_LOG_OPTIONS_TITLE",			"消息记录偏好设置"),
		("zh_Hans_CN",	"LOC_FF16_NOTIFICATION_LOG_TOOLTIP",	"偏好设置"),
		("zh_Hans_CN",	"LOC_FF16_LOG_ENTRY_SINGLE",			"有新消息，右键清空记录。"),
		("zh_Hans_CN",	"LOC_FF16_LOG_ENTRY_MULTIPLE",			"{LOC_FF16_LOG_ENTRY_SINGLE}");	-- 2021/12/25修复此处严重错误（文本引用死循环），感谢“wu0593”的细心指正