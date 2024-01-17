-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Gedemo Napoleon'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/1 18:21:56
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Gedemo Napoleon” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ：Active_Expansion_1

-- Napoleon_Text.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES
		("zh_Hans_CN",	"LOC_CITY_NAME_RHEIMS",							                        	"兰斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BRIANCON",					                                "尼斯"),
		("zh_Hans_CN",	"LOC_CITY_NAME_GAP",							                        	"里尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_JARNAC",							                        	"奥尔良"),
		("zh_Hans_CN",	"LOC_CITY_NAME_TOUL",							                        	"土伦"),
		("zh_Hans_CN",	"LOC_CITY_NAME_ALBA_LA_ROMAINE",				                        	"斯特拉斯堡"),
		("zh_Hans_CN",	"LOC_CITY_NAME_BOULOGNE",					                            	"布雷斯特"),
		("zh_Hans_CN",	"LOC_CITY_NAME_DIEPPE",						                            	"勒阿弗尔"),
		("zh_Hans_CN",	"LOC_CITY_NAME_VERDUN",					                            		"克莱蒙费朗"),
		("zh_Hans_CN",	"LOC_CITY_NAME_AMBOISE",					                            	"昂热"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CHARTRES",					                            	"勒芒"),
		("zh_Hans_CN",	"LOC_CITY_NAME_MONTELIMAR",				                                	"圣埃蒂安"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CARCASSONNE",				                            	"佩皮尼昂"),
		("zh_Hans_CN",	"LOC_CITY_NAME_CALAIS",					                                    "尼姆"),

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_NAPOLEON_NAME",					                "大军团"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_GEDEMO_NAPOLEON_DESCRIPTION",				            	"所有单位维护费-1 [ICON_Gold] 金币。解锁科技“军事学”后可获得一个额外的 [ICON_Policy] 军事政策槽位。建造 [ICON_DISTRICT_ENCAMPMENT] 军营耗时减半。"),

		("zh_Hans_CN",	"LOC_LEADER_GEDEMO_NAPOLEON",					                            "拿破仑·波拿巴"),

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_GEDEMO_NAPOLEON",				                	"胜利、万岁，法国的第一执政官和皇帝，拿破仑一世，您是法国人民的统治者。法国位于欧洲的核心地带，长久以来巴黎一直是文化、艺术及文学的世界中心。虽然被竞争者包围着——也可以说是敌人们——法国以大国风范走过这一切。法国的军队在世界各地的战争中，都凯旋而归，拥有着历史上最好的士兵和军官。拿破仑，法国渴望您重建您的帝国，再一次领导她回到光荣和伟大，再一次让法国成为文化和文雅的中心。皇帝，您能够再一次和敌人对抗吗？您能建起一个经得住时间考验的文明吗？"),

---- 百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_NAPOLEON_TITLE",				    	"拿破仑·波拿巴"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_NAPOLEON_SUBTITLE",					"法兰西第一共和国第一执政"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_NAPOLEON_QUOTE",					    "我的字典里没有不可能！"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_NAPOLEON_CHAPTER_HISTORY_PARA_1",		"拿破仑·波拿巴生于科西嘉岛，十岁时进入当地军事学校，在数学，历史和地理上极具天赋，对文学和人文学科则完全漠不关心。14岁那年他被委任为一个炮兵团的少尉。当法国革命爆发时，拿破仑站在革命派一边并升任炮兵中校，他迅速建立起了能征善战的名望。拿破仑在很早的时候就表现出过人的军事天赋，在法国大革命时期危机四伏的政坛上也显得游刃有余——在当时的法国，政治上走错一步就可能会丢掉脑袋。1794年时他还只是一位准将，到1795年就受命指挥法国本土的全部军队，那时他才25岁。之后的几年里拿破仑领导法国军队保护新成立的共和国，击败了许多敌人，包括强大的奥地利。拿破仑在战场上不断赢得胜利，使他在民众和军队中的声望达到顶峰，他于1800年推翻前政府自任“第一执政”，五年后又宣布自己为“皇帝兼终身执政”，这显示他一步步地抛弃了赋予他荣耀和权力的民主精神。作为非常时期的统治者，拿破仑迅速重组政府，废除了革命党人过于激进和暴力的法律，重新开放了教堂，赢得了被多年的革命和动乱耗尽心力的法国人民的热爱和支持。但此时的法国仍与欧洲各国处于交战状态，于是拿破仑再次走上战场并取得了对奥地利的决定性胜利，迫使该国和英国接受和平条约。法国的称霸野心令英国惴惴不安，战争在1803年再次爆发，此时法国面对的是一个由英国、奥地利、俄国和瑞典组成的强大同盟。拿破仑的行动快速而巧妙，他用“内线作战”的方式集中兵力打击分散的敌人。他迅速穿越整个欧洲，占领了奥地利首都，紧接着在奥斯特里茨战役中击溃了俄国军队。奥地利再次被迫求和，但是俄国和英国仍然坚持与法国对抗。最终拿破仑确信只要俄国和英国仍然存在，他在欧洲就永远无法获得安全保障。背信弃义的英国躲在海峡对岸，又有优势的海军保护，于是他决定先对付俄国。1812年，拿破仑率领50万大军远征莫斯科。俄国军队在他进攻前就撤退了，烧毁了所有入侵者可资利用的东西，后方的哥萨克骑兵则不断骚扰破坏他的补给线。拿破仑的军队到达并占领了莫斯科，俄国人却再次转移或烧毁了所有可能供给法国人的物资。法军被迫开始撤退，俄军在他们漫长的归途上发起袭击，然而更致命的还是俄国的严冬。到远征结束时，拿破仑已经损失了96%的士兵。一回到巴黎，拿破仑立即招募了一支35万人的新军，但是他不可战胜的神话已经被打破，整个欧洲都开始起来反对他。普鲁士、俄国和奥地利再次结盟对抗他。英国则在西班牙战场上投入更多部队。虽然他再次取得辉煌的胜利，他的敌人却从挫败中迅速恢复，继续无情的攻击。最终反法同盟军进入巴黎，拿破仑被迫退位并被流放到厄尔巴岛，由法国新政府提供六百万法郎作为他退位的补偿。后来拿破仑一度返回法国重新获得权力，并在比利时的滑铁卢与英国和普鲁士的联军展开最后决战，结果遭到无法挽回的失败，他被流放到距非洲海岸一千英里的圣赫勒拿岛度过余生。他于1821年在那里去世。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_GEDEMO_NAPOLEON_CHAPTER_HISTORY_PARA_2",		"拿破仑是有史以来最卓越的军事统帅之一。他的部队来去如风，他总是明白攻击哪里可以给敌人造成最大的损失。他也是一个不错的统治者，法国在他的治理下兴旺繁荣（直到他无尽的战争侵蚀了她的力量和战斗精神）。但是他虽然能在陆地上称雄，却一直无法建立起一支可以在海上与英国对抗的舰队。最终，他无法击败联合起来的所有敌人。"),

---- 外交
------ 初次见面
-------- 开场白			

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_GEDEMO_NAPOLEON_ANY",					        "欢迎，陌生人！我是拿破仑，法兰西的皇帝！我对我的朋友忠诚，对我的敌人则毫不手软。你会是哪一种？"),
			
-------- 到附近城市的邀请			

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_GEDEMO_NAPOLEON_ANY",			"欢迎。我是法国的拿破仑，世界历史上最具智慧的将军！"),
			
-------- AI接受玩家邀请			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_GEDEMO_NAPOLEON_ANY",	"我感谢你对法国的款待！"),
			
-------- AI邀请玩家交换首都信息			
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_GEDEMO_NAPOLEON_ANY",	"啊。我们终于见面了。我是拿破仑，法国的皇帝。来吧，让我们来讨论一下我们两个伟大国家之间的世界划分。"),
			
------ 问候			
	
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_GEDEMO_NAPOLEON_ANY",				        	"我们又见面了。"),
			
------ 代表团
-------- AI接受			

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",		"你的作用已被注意到。谢谢你！"),
			
-------- AI拒绝			
	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",		"你的提议是对皇帝本人的侮辱，也就是说，是对我的侮辱。我以最傲慢的姿态拒绝你。"),
			
-------- AI请求			
		
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",					"法国向你们提供了这个特殊的礼物。我恳求你接受。"),
			
------ 开放边境
-------- AI接受			
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",		"当然可以。皇帝都是出奇地慷慨的！"),
			
-------- AI拒绝			
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",		"我的时间很宝贵。别把时间浪费在这些废话上。"),
			
-------- AI请求			
			
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",				"你能允许我们的部队通过你的领土吗？"),
			
------ 宣布友谊
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",	"我接受你的友谊。我相信我们两国人民都能从这一安排中获益。"),
			
-------- AI拒绝
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",	"一定是弄错了。我相信你不会故意用这样一个荒谬的提议来侮辱伟大的法国人民。"),
			
-------- AI请求
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",				"我亲爱的朋友，我相信你会喜欢这项交易的。"),
			
-------- 玩家接受后AI回应
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",		"谢谢你，朋友。"),
			
-------- 玩家拒绝后AI回应
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",		"真遗憾。"),
			
------ 结盟
-------- AI请求
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",				"你愿意结成同盟吗？"),
			
------ 赞成与警告
-------- AI赞成
			
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_GEDEMO_NAPOLEON_ANY",				        	"哈哈！你有野心，我喜欢！"),
			
-------- AI警告
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_GEDEMO_NAPOLEON_ANY",				    	"你是在玩火。"),
			
-------- AI警告玩家离开边境
			
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_GEDEMO_NAPOLEON_ANY",		"我的朋友，法国需要的是：把你的士兵从我们的边境撤出。我相信你不会使我们失望。"),
			
------ 贸易
-------- AI接受交易
			
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",			"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY}"),
			
-------- AI拒绝交易
			
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",			"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY}"),
			
------ 谴责
-------- 受到谴责回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",					"确定吗？你相信你不会活到能看到自己后悔自己的短见的那一天。"),
			
-------- AI谴责玩家			
			
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",					"我开始怀疑这是一个阴谋。滚开！[NEWLINE]（谴责你）"),
			
------ 宣战
-------- 受到宣战后回应
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",				"这是你最后一次侮辱法国的机会了。"),
			
-------- AI宣战
			
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",					"你落入了我的陷阱，我要将你埋葬……"),
			
------ 求和
-------- AI接受求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_GEDEMO_NAPOLEON_ANY",			"如果我非得这么做的话。"),
			
-------- AI拒绝求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_GEDEMO_NAPOLEON_ANY",			"当然不行。"),
			
-------- AI求和
			
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",					"看来我大大低估了你。我保证我不会再犯同样的错误了。"),

------ 击败
-------- AI被击败
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY",				    	"我失败了。除了荣誉，我什么也没有留下，随便你吧。"),
			
-------- 玩家被击败（在热座模式中会显示）
			
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_GEDEMO_NAPOLEON_ANY",					"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_GEDEMO_NAPOLEON_ANY}"),

		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_NAPOLEON_NAME",					                        "拿破仑战争"),
		("zh_Hans_CN",	"LOC_AGENDA_GEDEMO_NAPOLEON_DESCRIPTION",				                    "喜欢与法国以外的强国交战的文明。不喜欢处于和平的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_GEDEMO_NAPOLEON_REASON_ANY",		    			"（您没有参与世界这盘棋）"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SHORT_LIFE_GLORY_AT_WAR",					            "领袖很高兴看到你的文明与他人交战。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SHORT_LIFE_GLORY_NOT_AT_WAR",				            "你的文明处于和平状态，领袖很不悦。");

-- General.xml文件
---- 原文件对游戏本体的拿破仑文本做了改动，故这里加上条件，仅Ge.的拿破仑启用改动才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GREAT_PERSON_INDIVIDUAL_NAPOLEON_BONAPARTE_NAME",
		"zh_Hans_CN",
		"拉费耶特"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_NAPOLEON" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_NAPOLEON_BONAPARTE_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"拉费耶特（La Fayette）侯爵家族来自奥弗涅（Auvergne）一个非常古老的贵族。14岁那年，他开始了军事生涯，然后于1775年成为路易十六国王的后卫。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_NAPOLEON" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_NAPOLEON_BONAPARTE_CHAPTER_HISTORY_PARA_2",
		"zh_Hans_CN",
		"拉费耶特侯爵以其在美国独立战争（1775-1783）中的英勇军事闻名，这使他赢得了“两个世界的英雄”的绰号。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_NAPOLEON" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_NAPOLEON_BONAPARTE_CHAPTER_HISTORY_PARA_3",
		"zh_Hans_CN",
		"美国使他萌生了自由思想，他允诺返回法国起草第一份《人权和公民权宣言》。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_NAPOLEON" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_NAPOLEON_BONAPARTE_CHAPTER_HISTORY_PARA_4",
		"zh_Hans_CN",
		"革命时期国民警卫队司令官在君主主义者和革命者之间摇摆不定，他被迫逃往国外。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_GEDEMO_NAPOLEON" AND Language = "en_US"));