-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Appeal Loyalty and Prestige (Diplo VP) Font Icons'CN_Add_FI3
-- Author: Clear8Sky
-- DateCreated: 2021/9/30 13:59:44
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Appeal, Loyalty and Prestige (Diplo VP) Font Icons” 。该文件在 FrontEnd 与 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，Priority 需要确保在“……2.sql”后载入（初设为-2），需 Criteria ： Active_Mod_AppLoyPresIcon

------ 整体替换，针对 除去“……1.sql”与“……2.sql”中改动过的Tag、除去不推荐加图标的Tag之外，且“魅力”这一词在文段中间 的文本部分

CREATE TRIGGER C8S_LEUGI_ADD_APPEAL_ICON_2_zh_Hans_CN
AFTER INSERT ON LocalizedText
WHEN (NEW.Text NOT LIKE "%CON\_APPEA%" ESCAPE "\" AND NEW.Text LIKE "%魅力%")	-- 排除所有已添加图标的文本段，并挑选所有“魅力”这一词在文段中间 的文本
BEGIN
	UPDATE LocalizedText
	SET Text = REPLACE(NEW.Text, "魅力", " [ICON_APPEAL] 魅力")
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

