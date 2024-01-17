-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'PACHIOULI KNOWLEDGE'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 12:59:49
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “【支持风云变幻】帕秋莉领导的红魔乡文明” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,															Text)
VALUES		
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_BIGLIBRARY_DESCRIPTION",						"所有 [ICON_GreatWork_Writing] 著作+2 [ICON_Culture] 文化值、+1 [ICON_Science] 科技值。每回合额外+50% [ICON_GreatWriter] 大作家点数。所有战斗单位[COLOR_RED]-1[ENDCOLOR] [ICON_Movement] 移动力。[NEWLINE]在完成特色项目后，[ICON_GreatWork_Writing] 著作额外+3 [ICON_Science] 科技值，每回合再额外+50% [ICON_GreatWriter] 大作家点数。[NEWLINE]特殊加成：成为巴比伦（安善）城邦的宗主国时，其宗主国加成改为“建造学院建筑+30% [ICON_Production] 生产力，每件 [ICON_GreatWork_Relic] 遗物与 [ICON_GreatWork_Artifact] 文物+1 [ICON_Science] 科技值。”[NEWLINE]帕秋莉十分喜欢读书，因此能够从书中获得更多收益，当心随时都会来偷书的大盗！此外，她还十分擅长运动，这使得她的移动力更强。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_REDMIST_MUTATION_DESCRIPTION",			"所有单位获得隐形，且视野+1。所有远程单位+3 [ICON_Ranged] 远程攻击力。[NEWLINE]大小姐释放的红雾把幻想乡都遮住了，因此吸血鬼们可以正常活动。在红雾的笼罩下，吸血鬼们有着更多的视野。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_LITTLE_DEMON_DESCRIPTION",			"红魔乡文明的远古时代特色侦察单位。拥有28点 [ICON_Strength] 战斗力、26点 [ICON_Ranged] 远程攻击力，[ICON_Range] 射程为1，初始拥有一次 [ICON_Promotion] 强化。拥有1点 [ICON_Charges] 劳动力，可用来修建改良设施或者移除地貌。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_BUILDING_KOUMAKYOULIBRARY_DESCRIPTION",	"红魔乡文明的特色建筑，取代图书馆。+1 [ICON_GreatWork_Writing] 著作槽位，每回合+1 [ICON_GreatWriter] 大作家点数。[NEWLINE]帕秋莉很喜欢读书，自己也会写书，这使得她能够获得更多著作和槽位还有大作家点数。"),
		("zh_Hans_CN",	"LOC_PROJECT_LEVELUP_PATCHOULI_DESCRIPTION",					"红魔乡文明的特色项目。项目完成后，[ICON_GreatWork_Writing] 著作的 [ICON_Science] 科技值加成由+1提升至+4，[ICON_GreatWriter] 大作家点数加成由+50%提升至+100%。"),
			
---- 2020/8/10补译			
			
		("zh_Hans_CN",	"LOC_TRAIT_UNIT_RANGED_MORE_ATTACK_MODIFIER_DESCRIPTION",		"+{1_Amount} [ICON_Strength] 战斗力 来自于帕秋莉的魔导书（特性）");
			
---- 2021/2/17补更，发现帕秋莉的名言没定义，暂时先定义一个空的
---- 2022/3/7补更，原模组已定义，故此处注释掉
/*
		("en_US",		"LOC_PEDIA_LEADERS_PAGE_LEADER_PATCHOULI_KNOWLEDGE_QUOTE",		"……"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_PATCHOULI_KNOWLEDGE_QUOTE",		"（无言）");
*/
---- 为与Huzi的 Touhou - Scarlet Devil Mansion(GS) 模组 区分而做的改动，在后者启用时，前者的帕秋莉加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "帕秋莉·诺蕾姬", "帕秋莉·诺蕾姬（Knus.）")
WHERE Tag = "LOC_LEADER_PATCHOULI_KNOWLEDGE_NAME"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_remilia_UU_NAME" AND Language = "en_US"));