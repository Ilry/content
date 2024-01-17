-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'TouHou mod marionette'CN_Fix_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/1 17:40:16
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[TouHou mod]marionette-人偶族-人形” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES		

-- Localization_zh.xml文件

		("zh_Hans_CN",	"LOC_CIVILIZATION_MARIONETTE_ADJECTIVE",					                        "人偶族的"),
		("zh_Hans_CN",	"LOC_LEADER_ALICE_MARIONETTE_NAME",					                                "爱丽丝·玛格特罗依德（主宰型）"),
		("zh_Hans_CN",	"LOC_TRAIT_SELF_DISCIPLINE_DESCRIPTION",					                        "城市中每位 [ICON_Citizen] 公民产出+1 [ICON_Production] 生产力。军事单位获得人偶修正（三倍夹击和支援加成）。[ICON_Citizen] 人口不能自然增长，仅能通过“生产人偶”项目增长。"),
		("zh_Hans_CN",	"LOC_TRAIT_MARIONETTE_MAKER_DESCRIPTION",					                        "绝对支配：+1通配符槽位。[NEWLINE]布加勒斯特的人偶师：进行人偶项目+100% [ICON_Production] 生产力，训练单位+30% [ICON_Production] 生产力。"),
		("zh_Hans_CN",	"LOC_TRAIT_ALICENET_DESCRIPTION",					                                "全民共和：+1经济政策槽位。[NEWLINE]思维链接：文明的 [ICON_Science] 科技值与 [ICON_Culture] 文化值产出+20%。"),
		("zh_Hans_CN",	"LOC_TRAIT_MARIONETTE_LIBERATIO_FRONT_DESCRIPTION",					                "领袖独裁：+1军事政策槽位。[NEWLINE]You are free!：击杀敌方单位时有概率将其俘获。"),
		("zh_Hans_CN",	"LOC_DISTRICT_MARIONETTE_MAKE_DESCRIPTION",					                        "人偶文明的特色区域，取代工业区。初始即可解锁，可无视 [ICON_Citizen] 人口限制建造，仅能从市中心、人偶工坊和人偶剧院中获得大量相邻加成，在人偶工坊工作的 [ICON_Citizen] 专家产出增加，提供两个 [ICON_Citizen] 专家槽位。"),
		("zh_Hans_CN",	"LOC_DISTRICT_MARIONETTE_SHOW_DESCRIPTION",					                        "人偶文明的特色区域，取代剧院广场。初始即可解锁，可无视 [ICON_Citizen] 人口限制建造，仅能从市中心、人偶工坊和人偶剧院中获得大量相邻加成，在人偶剧院工作的 [ICON_Citizen] 专家产出增加，提供两个 [ICON_Citizen] 专家槽位。"),
		("zh_Hans_CN",	"LOC_UNIT_AWACS_MARIONETTE_DESCRIPTION",					                        "为2格范围内的所有单位提供+5 [ICON_Strength] 战斗力、+1 [ICON_Movement] 移动力，为1格范围内的攻城单位额外提供+5 [ICON_Strength] 战斗力、+1 [ICON_Range] 射程。"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_ABILITY_AWACS_MARIONETTE_DESCRIPTION",					"{LOC_UNIT_AWACS_MARIONETTE_DESCRIPTION}"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_AWACS_MARIONETTE_NAME",								"信息战人偶"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_UNIT_AWACS_MARIONETTE_DESCRIPTION",					        "{LOC_UNIT_AWACS_MARIONETTE_DESCRIPTION}[NEWLINE]训练信息战人偶不消耗 [ICON_Production] 生产力，训练完成后所在城市-1 [ICON_Citizen] 人口。"),
		("zh_Hans_CN",	"LOC_PROJECT_MAKE_MARIONETTE_DESCRIPTION",					                        "人偶文明的特色项目。完成后该城市+1 [ICON_Citizen] 人口。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_ALICE_MARIONETTE_ANY",					        "我不喜欢你，人偶们也不喜欢你。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_ALICE_MARIONETTE_REASON_ANY",					            "（爱丽丝讨厌战争贩子）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_MARIONETTES_ANY",					            "我们不喜欢你。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_MARIONETTES_REASON_ANY",					                "（她们讨厌战争贩子）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_MEDICINE_ANY",				                	"梅蒂欣讨厌你！[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_MEDICINE_REASON_ANY",				                        "（梅蒂欣讨厌您保持和平）"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_MEDICINE_ANY",					            "你是梅蒂欣的好朋友，要一直一起玩哦～"),

-- CivilopediaDiplomacy_zh.xml文件

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MARIONETTE_CHAPTER_HISTORY_PARA_3",		"种族修正（每位 [ICON_Citizen] 公民产出+1 [ICON_Production] 生产力）：人偶是天生的工人、生产者，自出生之日起便能对一切工作达到熟练程度（若是存在大师的话，即使只有一个，全民都会成为大师），堪比机器人一样的精准度与准确性，使整个种族所有人都是最最顶级的生产者，而且完全不需要休息。完全可以认为人偶们具有机器人和控制者两者各自的优点，而弥补了各自的缺点。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MARIONETTE_CHAPTER_HISTORY_PARA_4",		"军事修正（三倍夹击和支援加成）：如果提到人偶族的军队的话，所有人最先想到的一定是他们那绝对性的纪律和组织度，对他们而言唯一能让他们离开阵地的就只有命令。如果说让几支精锐达到这种程度，那么所有种族都可以（妖精除外），然而全民都达到这种程度，甚至包括非战斗人员的话就只有人偶族了。爱丽丝网络使得整个战场尽在他们的掌握，只要一个人看到，所有人就都看到，一个听到，所有人就都听到，不要试图去欺骗他们或者和他们进行情报战，那毫无意义，当然消耗战也是最坏的选择之一，毕竟没有人知道他们到底有多少人。对于人偶族人而言，失去手脚，甚至失去头部变得四分五裂都不是无法完成任务的理由，失去手脚就去找替代品，没有替代品或者来不及就会使用牙齿，即使失去头部变得四分五裂也会通过自爆的方式坚决完成任务。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_MARIONETTE_CHAPTER_HISTORY_PARA_5",		"种族特质（[ICON_Citizen] 人口不能自然增长，仅能通过“生产人偶”项目增长）：人偶族无需进食，也不会通过常规方式繁殖。他们通过制造的方式扩大种族，也不存在所谓的儿童期，出厂即劳动力，若不是幻想乡中缺乏大面积开采资源的条件的话，可以想象，不需要多久他们便会充满幻想乡的各个角落。");