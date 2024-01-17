-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'District Expansion Spirituality'CN_Add_IG7
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/16 2:50:16
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Spirituality”的 UC_REL_Text_AmunRa.sql 文件 。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_AmRa

---- 对 Precinct of Amun-Ra 模组 中部分文本进行改动，已添加 Criteria 以保证只有 Precinct of Amun-Ra模组 启用时该文件才载入；Tag 形似新定义的，故暂不设生效条件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,												Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_NUBIAN_SHRINE_DESCRIPTION_UC_JNR",		"埃及与努比亚特色建筑。所在城市境内的沼泽、绿洲与泛滥平原产出+1 [ICON_Food] 食物。[NEWLINE]此城每位 [ICON_Citizen] 公民每回合提供+0.3 [ICON_Faith] 信仰值。[NEWLINE]允许购买使徒、上师、审判官，拥有特定信仰还可购买武僧。这些宗教单位只能通过 [ICON_Faith] 信仰值购买。"),
		("zh_Hans_CN", "LOC_BUILDING_TEMPLE_AMUN_DESCRIPTION_UC_JNR",		"埃及与努比亚特色建筑。所在城市境内的沼泽、绿洲与泛滥平原产出+1 [ICON_Culture] 文化值。[NEWLINE]此城+5% [ICON_Faith] 信仰值产出。"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CONSERVATION_NAME",				"庇安所"),
		("zh_Hans_CN", "LOC_BUILDING_JNR_CONSERVATION_DESCRIPTION",			"埃及与努比亚特色建筑。所在城市境内的沼泽、绿洲与泛滥平原产出+1 [ICON_Science] 科技值。[NEWLINE]此城每件 [ICON_GreatWork_Artifact] 文物+2 [ICON_Faith] 信仰值。[NEWLINE]此城+10% [ICON_GreatPerson] 伟人点数获取。");