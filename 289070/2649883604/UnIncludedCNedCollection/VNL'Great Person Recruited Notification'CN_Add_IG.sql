-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Great Person Recruited Notification'CN_Add_IG
-- Author: DeepLogic , Clear8Sky
-- DateCreated: 2021/11/14 5:57:17
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Great Person Recruited Notification” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES
		("zh_Hans_CN",	"LOC_NOTIFICATION_OTHER_PLAYER_RECRUITED_GREATPERSON_MESSAGE",	"伟人被招募"),
		("zh_Hans_CN",	"LOC_NOTIFICATION_OTHER_PLAYER_RECRUITED_GREATPERSON_SUMMARY",	"{1_recruiter}已招募了{2_greatPersonType}——{3_greatPersonName}！");


