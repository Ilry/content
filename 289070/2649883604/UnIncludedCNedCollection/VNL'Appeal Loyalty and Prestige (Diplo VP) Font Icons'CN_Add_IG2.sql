-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Appeal Loyalty and Prestige (Diplo VP) Font Icons'CN_Add_FI2
-- Author: Clear8Sky
-- DateCreated: 2021/9/30 13:52:24
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Appeal, Loyalty and Prestige (Diplo VP) Font Icons” 。该文件在 FrontEnd 与 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，Priority 需要确保在“……1.sql”后载入（初设为-1），需 Criteria ： Active_Mod_AppLoyPresIcon

---- 魅力值
------ 整体替换，针对 除去“……1.sql”中所有改动过的Tag、除去不推荐加图标的Tag之外，且“魅力”为某一段开头 的文本部分

CREATE TRIGGER C8S_LEUGI_ADD_APPEAL_ICON_1_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN (NEW.Text NOT LIKE "%CON\_APPEA%" ESCAPE "\" AND (NEW.Text LIKE "魅力%" OR NEW.Text LIKE "（魅力%"))	-- 排除所有已添加图标的文本段，并挑选所有“魅力”为某一段开头、或类似“（魅力为……）”的文本
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "魅力", "[ICON_APPEAL] 魅力")
	WHERE Tag = NEW.Tag
	AND Tag NOT LIKE "LOC_PEDIA_%"	-- 在上述排除基础上，再排除所有百科文本；而百科中需要添加图标的已在“……1.sql”中逐个添加过了
	AND Tag NOT IN	-- 排除不推荐添加图标的Tag
	(
		"LOC_HUD_APPEAL_LENS",	-- “魅力”；在滤镜UI里的文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_APPEAL",	-- “魅力”；在滤镜UI里的文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_APPEAL_HELP",	-- “切换至魅力滤镜。”；在滤镜UI里的文本，不推荐加图标
		"LOC_TOOLTIP_APPEAL",	-- “魅力：{1_AppealDesc}（{2_AppealValue}）”；单元格浮窗中显示的文本，已在“……1.sql”中单独改了
		"LOC_LOADING_INFO_LEADER_CLEOPATRA",	-- “克利欧佩特拉女王，总会有人低估您，但……”；克利欧佩特拉领袖的载入文本，不推荐加图标
		"LOC_UNITCOMMAND_GRANT_ENVOY_DESCRIPTION",	-- “卑弥呼的魅力”；英雄卑弥呼的能力名称，不推荐加图标
		"LOC_DIPLO_KUDO_LEADER_QIN_REASON_AGENDA_SYCOPHANT_GOLDEN_AGE",	-- “您的个人魅力在文明的荣光中熠熠生辉！”；对白文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_BULL_MOOSE_POSITIVE_APPEAL",	-- “您的帝国中有很多高魅力地区，他们十分羡慕”；对白文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_BULL_MOOSE_NEGATIVE_APPEAL",	-- “您的帝国中缺乏高魅力地区，他们非常失望”；对白文本，不推荐加图标
		"LOC_DIPLO_KUDO_LEADER_T_ROOSEVELT_REASON_ANY",	-- “（您的帝国中有大量高魅力地区。）”；莽骑兵罗斯福DLC中的对白文本，不推荐加图标
		"LOC_DIPLO_WARNING_LEADER_T_ROOSEVELT_REASON_ANY",	-- “您的帝国中没有足够的高魅力地区。）”；莽骑兵罗斯福DLC中的对白文本，不推荐加图标
		"LOC_POLICY_CHARISMATIC_LEADER_NAME",	-- “魅力型领袖”；政策卡名称，不推荐加图标
		"LOC_DIPLO_KUDO_LEADER_YNL_TAIHO_REASON_AGENDA_FLIRTATIOUS_POSITIVE",	-- “我觉得你非常有魅力。最信任你……”；模组 Yossie's NewLeader - Kancolle Imperial Japanese Navy 中 大凤 的对白文本，不推荐加图标
		"LOC_DIPLO_REJECT_MAKE_ALLIANCE_FROM_HUMAN_LEADER_CONS_DANA_ANY",	-- “虽然是很有魅力的提案，但是……”；模组 VA-11 HALL-A - Dana Zane, Julianne Stingray's Glitch City 中 达娜·赞恩 的对白文本，不推荐加图标
		"LOC_DIPLO_FIRST_MEET_LEADER_GEDEMO_CATHERINE2_ANY",	-- “……如果你像你的魅力一样……”；模组 Gedemo Catherine 中 叶卡捷琳娜二世 的对白文本，不推荐加图标
		"LOC_DIPLO_FIRST_MEET_LEADER_JFD_LLYWELYN_ANY",	-- “……我用强大的军队与天生的魅力……”；模组 Wales: Llywelyn 中 卢埃林 的对白文本，不推荐加图标
		"LOC_BOOST_TRIGGER_LONGDESC_DAPPEALMIN_NBH_4"	-- “居住在您这片魅力惊艳的社区里……”；模组 Real Eurekas 中 尤里卡 的描述性文本，不推荐加图标
	);
END;

---- 忠诚度
------ 整体替换，除去不推荐添加图标的Tag之外，且“忠诚度”这一词在文段中间 的文本部分

CREATE TRIGGER C8S_LEUGI_ADD_LOYALTY_ICON_2_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN (NEW.Text NOT LIKE "%CON\_LOYALT%" ESCAPE "\" AND NEW.Text NOT LIKE "%诚度压%" AND NEW.Text LIKE "%忠诚度%")	-- 排除所有已添加图标的文本段、排除所有可能包含“忠诚度压力”的文本段，并挑选所有“忠诚度”这一词在文段中间 的文本
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "忠诚度", " [ICON_LOYALTY] 忠诚度")
	WHERE Tag = NEW.Tag
	AND Tag NOT IN	-- 排除不推荐添加图标的Tag
	(
		"LOC_EXPANSION1_MOD_TEASER",	-- “此资料片包含大时代、忠诚度、总督……”；官方资料片介绍文本，不推荐加图标
		"LOC_EXPANSION1_MOD_DESCRIPTION",	-- “……其中有大时代、忠诚度、总督和……”；官方资料片介绍文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_LOYALTY",	-- “忠诚度”；在滤镜UI里的文本，不推荐加图标
		"LOC_OPTIONS_HOTKEY_LENSES_LOYALTY_HELP",	-- “开关忠诚度滤镜”；在滤镜UI里的文本，不推荐加图标
		"LOC_SECRETSOCIETY_VOIDSINGERS_DESCRIPTION",	-- “……他们侧重于宗教、遗物及忠诚度。”；秘密结社“虚空吟唱者”的介绍文本，不推荐加图标
		"LOC_EXPANSION1_DESCRIPTION",	-- “……其中有大时代、忠诚度、总督和……”；官方资料片介绍文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_SPIRIT_OF_TUCAPEL_GAINING_CITIES",	-- “莱夫扎茹认可以忠诚度获得土地的文明”；对白文本，不推荐加图标
		"LOC_DIPLO_MODIFIER_SPIRIT_OF_TUCAPEL_LOSING_CITIES",	-- “莱夫扎茹厌恶不能维持人民忠诚度的文明”；对白文本，不推荐加图标
		"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_AGENDA_SPIRIT_OF_TUCAPEL_LOSING_CITIES",	-- “（您因忠诚度降低而失去了城市。）”；对白文本，不推荐加图标
		"LOC_PEDIA_CONCEPTS_PAGE_WORLD_7_CHAPTER_CONTENT_PARA_2",	-- “……另外还将显示单元格中的忠诚度减益……”；百科相关文本，在前面已作改动
		"LOC_PEDIA_CONCEPTS_PAGE_LOYALTY_1_CHAPTER_CONTENT_TITLE",	-- “忠诚度”；百科相关文本，不推荐加图标
		"LOC_REPORTS_LOYALTY",	-- “忠诚度”；帝国报告UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_LOYALTY_SUBSECTION",	-- “忠诚度”；UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_ACCUMULATED_IDENTITY_SUBSECTION",	-- “忠诚度累积：”；UI相关文本，不推荐加图标
		"LOC_CULTURAL_IDENTITY_LOYALTY_LINE",	-- “每回合忠诚度：”；UI相关文本，不推荐加图标
		"LOC_HUD_CULTURAL_IDENTITY_LENS",	-- “忠诚度”；UI相关文本，不推荐加图标
		"LOC_LOYALTY_LEVEL_2_NAME",	-- “忠诚度摇摆”；UI相关文本，不推荐加图标
		"LOC_HUD_CITY_FULL_LOYALTY",	-- “忠诚度满”；UI相关文本，不推荐加图标
		"LOC_HUD_CITY_CULTURE_TOOLTIP",	-- “忠诚度与总督”；UI相关文本，不推荐加图标
		"LOC_GOVERNOR_IDENTITY_PRESSURE",	-- “每回合忠诚度”；UI相关文本，不推荐加图标
		"LOC_LOYALTY_STATUS_TT",	-- “{1_LoyaltyIcon}忠诚度{2_CurrentLoyalty}/{3_MaxLoyalty}[NEWLINE]状态：{4_LoyaltyStatus}”；UI相关文本，不推荐加图标
		"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_OTTOMAN_CHAPTER_HISTORY_PARA_4"	-- “他们被禁止结婚或拥有大宗财产，忠诚度非常高……”；百科相关文本，不推荐加图标
	);
END;