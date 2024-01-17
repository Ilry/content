-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Russia Elisabeth'CN_Add_FI
-- Author: 春 , Clear8Sky
-- DateCreated: 2021/9/2 1:15:46
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Russia: Elisabeth” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

---- 文明特性（原文件对游戏本体的文本做了改动，故这里加上条件，只有原模组启用且 文明扩展（CX） 未启用 时以下才生效）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_CIVILIZATION_MOTHER_RUSSIA_DESCRIPTION",
		"zh_Hans_CN",
		"建立或征服城市可获得额外领土。冻土产出+1 [ICON_Faith] 信仰值、+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_MOD_JFD_RUSSIA_ELISABETH_DESCRIPTION" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");

---- 领袖特性（原文件对游戏本体的文本做了改动，故这里加上条件，只有原模组启用且 文明扩展（CX） 未启用且 模组Russia: Peter I 未启用 时以下才生效）

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_TRAIT_LEADER_GRAND_EMBASSY_DESCRIPTION",
		"zh_Hans_CN",
		"与比您更领先的文明建立 [ICON_TradeRoute] 贸易路线时，可从中获得额外加成（同您文明相比，其每多解锁三项科技或市政，则产出+1 [ICON_Science] 科技值或 [ICON_Culture] 文化值）；且当这些文明完成科技“军事学”时，您文明可免费获得一名哥萨克骑兵。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_MOD_JFD_RUSSIA_ELISABETH_DESCRIPTION" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME")
AND NOT EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_UNIT_JFD_PREOBRAZHENSKY_NAME" AND Language = "en_US"));

---- 模组

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																							Text)
VALUES			
		("zh_Hans_CN",	"LOC_MOD_JFD_RUSSIA_ELISABETH_DESCRIPTION",														"------------------------------------[NEWLINE]领袖名称 -- 伊丽莎白[NEWLINE][NEWLINE]领袖特性 - 宫廷舞会[NEWLINE]每次使用一位 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家或 [ICON_GreatWriter] 大作家时可奖励一位 [ICON_Envoy] 使者。完成市政“人文主义”后可解锁特色建筑艺术学院。[NEWLINE][NEWLINE]特色建筑 - 艺术学院[NEWLINE]伊丽莎白作为领袖时的特色建筑。拥有两个槽位，可放置任意类型的 [ICON_GreatWork_Portrait] 巨作。每回合提供+1 [ICON_GreatArtist] 大艺术家点数，+1 [ICON_GreatMusician] 大音乐家点数和+1 [ICON_GreatWriter] 大作家点数。提供+1 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]领袖议程 - 宫廷辉煌[NEWLINE]喜欢招募文化型伟人，对拥有高额 [ICON_Culture] 文化产出的文明印象深刻。嫉妒那些拥有她所没有的奢侈品的文明。"),
		
---- 领袖

		("zh_Hans_CN",	"LOC_LEADER_JFD_ELISABETH_NAME",																"伊丽莎白"),
		
---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_JFD_COURT_SPLENDOUR_NAME",															"宫廷辉煌"),
		("zh_Hans_CN",	"LOC_AGENDA_JFD_COURT_SPLENDOUR_DESCRIPTION",													"喜欢招募文化型伟人，对拥有高额 [ICON_Culture] 文化产出的文明印象深刻。嫉妒那些拥有她所没有的奢侈品的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_ELISABETH_REASON_DESIRED_LUXURY",									"（您拥有她所没有的奢侈品）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_COURT_SPLENDOUR_DESIRED_LUXURY",									"伊丽莎白嫉妒你的奢侈品资源。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_ELISABETH_REASON_LEADS_PATRONAGE",								"（您与她竞争伟人）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_COURT_SPLENDOUR_LEADS_PATRONAGE",								"伊丽莎白觊觎你的伟人。"),
		
---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_JFD_ELISABETH",														"衣着华丽，宾客济济，俄罗斯宫廷请求您的光临，美丽的伊丽莎白皇后！您将启蒙运动的辉煌带到了俄罗斯。你在文化和服饰上的风度，让你们的宫廷成为全世界君主仰慕的对象。"),
		
---- 特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_COURT_MASQUERADES_NAME",													"宫廷舞会"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_COURT_MASQUERADES_DESCRIPTION",											"消耗 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家或 [ICON_GreatWriter] 大作家时奖励一位 [ICON_Envoy] 使者。完成市政“人文主义”后解锁特色建筑艺术学院。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_COURT_MASQUERADES_NOTIFICATION",											"伊丽莎白举办了一场宫廷舞会，邀请了众多达官贵人来到宫廷。[COLOR_GREEN]获得{1_Num}位 [ICON_Envoy] 使者。[ENDCOLOR]"),
		
---- 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_TITLE",											"伊丽莎白"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_SUBTITLE",											"俄罗斯女皇"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_QUOTE",											"失去民族信任的权力，什么都不是。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_CHAPTER_HISTORY_PARA_1",							"【译者注：正在翻译……】[NEWLINE][NEWLINE]Daughter of Peter I and Catherine I, grand princess and cReplacen princess from 1709 to 1741, Elizabeth (Elizaveta Petrovna) was the second of ten offspring to reach maturity. She was born in the Moscow suburb of Kolomenskoye on December 29, 1709, the same day a Moscow parade celebrated the Poltava victory. Elizabeth grew up carefree with her sister Anna (1708–1728). Doted on by both parents, the girls received training in European languages, social skills, and Russian traditions of singing, religious instruction, and dancing. Anna married Duke Karl Friedrich of Holstein-Gottorp in 1727 and died in Holstein giving birth to Karl Peter Ulrich (the future Peter III). Elizabeth never married officially or traveled abroad, her illegitimate birth obstructing royal matches. Because she wrote little and left no diary, her inner thoughts are not well-known.[NEWLINE][NEWLINE]Hints of a political role came after her mother's short reign when Elizabeth was named to the joint regency for young Peter II, whose favor she briefly enjoyed. But when he died childless in 1730 she was overlooked in the surprise selection of Anna Ivanovna. Under Anna she was kept under surveillance, her yearly allowance cut to 30,000 rubles, and only Biron's influence prevented commitment to a convent. At Aleksandrovka near Moscow she indulged in amorous relationships with Alexander Buturlin, Alexei Shubin, and the Ukrainian chorister Alexei Razumovsky. During Elizabeth's reign male favoritism flourished; some of her preferred men assumed broad cultural and artistic functions—for instance, Ivan Shuvalov (1717–1797), a well-read Francophile who cofounded Moscow University and the Imperial Russian Academy of Fine Arts in the 1750s.[NEWLINE][NEWLINE]Anna Ivanovna was succeeded in October 1740 by infant Ivan VI of the Brunswick branch of Romanovs who reigned under several fragile regencies, the last headed by his mother, Anna Leopoldovna (1718–1746). This Anna represented the Miloslavsky/Brunswick branch, whereas Elizabeth personified the Naryshkin/Petrine branch. Elizabeth naturally worried the inept regency regime, which she led her partisans in the guards to overthReplace on December 5–6, 1741, with aid from the French and Swedish ambassadors (Sweden had declared war on Russia in July 1741 ostensibly in support of Elizabeth). The bloodless coup was deftly accomplished, the regent and her family arrested and banished, and Elizabeth's claims explicated on the basis of legitimacy and blood kinship. Though Elizabeth's accession unleashed public condemnation of both Annas as agents of foreign domination, it also reaffirmed the primacy of Petrine traditions and conquests, promising to restore Petrine glory and to counter Swedish invasion, which brought Russian gains in Finland by the Peace of Åbo in August 1743.[NEWLINE][NEWLINE]Elizabeth was cReplacened in Moscow in spring 1742 amid huge celebrations spanning several months; she demonstratively cReplacened herself. With Petrine, classical feminine, and ''restorationist'' rhetoric, Elizabeth's regime resembled Anna Ivanovna's in that it pursued an active foreign policy, witnessed complicated court rivalries and further attempts to resolve the succession issue, and made the imperial court a center of European cultural activities. In 1742 the empress, lacking offspring, brought her nephew from Holstein to be converted to Orthodoxy, renamed, and designated cReplacen prince Peter Fyodorovich. In 1744 she found him a German bride, Sophia of Anhalt-Zerbst, the future Catherine II. The teenage consorts married in August 1745, and hopes for a male heir came true only in 1754. Elizabeth took charge of Grand Prince Pavel Petrovich. Nevertheless, the ''Young Court'' rivaled Elizabeth's in competition over dynastic and succession concerns.[NEWLINE][NEWLINE]While retaining ultimate authority, Elizabeth restored the primacy of the Senate in policymaking, exercised a consultative style of administration, and assembled a government comprising veteran statesmen, such as cosmopolitan Chancellor Alexei Bestuzhev-Ryumin and newly elevated aristocrats like the brothers Petr and Alexander Shuvalov (and their younger cousin Ivan Shuvalov), Mikhail and Roman Vorontsov, Alexei and Kirill Razumovsky, and court surgeon Armand Lestocq. Her reign generally avoided political repression, but she took revenge on the Lopukhin family, descendents of Peter I's first wife, by having them tortured and exiled in 1743 for loose talk about the Brunswick family and its superior rights. Later she abolished the death penalty in practice. Lestocq and Bestuzhev-Ryumin, who was succeeded as chancellor by Mikhail Vorontsov, fell into disgrace for alleged intrigues, although Catherine II later pardoned both.[NEWLINE][NEWLINE]In cultural policy Elizabeth patronized many, including Mikhail Lomonosov, Alexander Sumarokov, Vasily Tredyakovsky, and the Volkov brothers, all active in literature and the arts. Foreign architects, composers, and literary figures such as Bartolomeo Rastrelli, Francesco Araja, and Jakob von Stählin also enjoyed Elizabeth's support. Her love of pageantry resulted in Petersburg's first professional public theater in 1756. Indeed, the empress set a personal example by frequently attending the theater, and her court became famous for elaborate festivities amid luxurious settings, such as Rastrelli's new Winter Palace and the Catherine Palace at Tsarskoye Selo. Elizabeth loved fancy dress and followed European fashion, although she was criticized by Grand Princess Catherine for quixotic transvestite balls and crudely dictating other ladies'style and attire. Other covert critics such as Prince Mikhail Shcherbatov accused Elizabeth of accelerating the ''corruption of manners'' by pandering to a culture of corrupt excess, an inevitable accusation from disgruntled aristocrats amid the costly ongoing Europeanization of a cosmopolitan high society. The Shuvalov brothers introduced significant innovations in financial policy that fueled economic and fiscal gReplaceth and reinstituted recodification of law.[NEWLINE][NEWLINE]Elizabeth followed Petrine precedent in foreign policy, a field she took special interest in, although critics alleged her geographical ignorance and laziness. Without firing a shot, Russia helped conclude the war of the Austrian succession (1740–1748), but during this conflict Elizabeth and Chancellor Bestuzhev-Ryumin became convinced that Prussian aggression threatened Russia's security. Hence alliance with Austria became the fulcrum of Elizabethan foreign policy, inevitably entangling Russia in the reversal of alliances in 1756 that exploded in the worldwide Seven Years' War (1756–1763). This complex conflict pitted Russia, Austria, and France against Prussia and Britain, but Russia did not fight longtime trading partner Britain. Russia held its own against Prussia, conquered East Prussia, and even briefly occupied Berlin in 1760. The war was directed by a new institution, the Conference at the Imperial Court, for Elizabeth's declining health limited her personal attention to state affairs. The war dragged on too long, and the belligerents began looking for a way out when Elizabeth's sudden death on Christmas Day (December 25, 1761) brought her nephew Peter III to power. He was determined to break ranks and to ally with Prussia, despite Elizabeth's antagonism to King Frederick II. So just as Elizabeth's reign started with a perversely declared war, so it ended abruptly with Russia's early withdrawal from a European-wide conflict and Peter III's declaration of war on longtime ally Denmark. Elizabeth personified Russia's post-Petrine eminence and further emergence as a European power with aspirations for cultural achievement."),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_CHAPTER_CAPSULE_BODY",								"伊丽莎白领导下的俄罗斯，就如同不断摊开的阿米巴一般，谁都不愿当她的邻居。她十分乐于向周围扩张，善于将所有的土地、伟人以及人民都纳为己有。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_ELISABETH_CHAPTER_DETAILED_BODY",							"经过“伊丽莎白领袖”模组的改动后，俄罗斯的加成特性十分有利于扩张并占据大片领土。首要原因是每座新建的城市都可以额外获得领土，其次是因为每当一位伟人被消耗，拉夫拉修道院将为其所在城市获得额外单元格。俄罗斯的城市可以快速获得领土，再配合伊丽莎白的能力，从文化类伟人的消耗上获得文化值和使者的加成。如此，您就拥有了一个强大的帝国，可以实现任何类型的胜利。"),
		
---- 外交
------ 初次见面
-------- 开场白
	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_JFD_ELISABETH_ANY",												"很高兴认识你。我是俄罗斯的伊丽莎白。我参加化妆舞会要迟到了，如果你不介意的话，我们赶紧走吧。"),
		
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_JFD_ELISABETH_ANY",								"我正在附近的一座宫殿里举办化妆舞会。你不和我一起去吗？当然，你得换件好一点的衣服。"),
		
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_JFD_ELISABETH_ANY",						"当然，太好了。"),
		
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_JFD_ELISABETH_ANY",							"我可以多了解一下你们的首都吗？了解那些贫困国家的宫廷生活不失为一种消遣。"),
		
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_JFD_ELISABETH_ANY",													"欢迎。"),
		
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",								"贵国代表团的服装风格确实不同凡响。我随时欢迎他们到我的宫廷来。"),
		
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",								"我拒绝你的代表团，他们穿着太不体面了。你应该知道不该让你的马夫去觐见俄罗斯的君主。"),
		
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_JFD_ELISABETH_ANY",										"我已经派遣了一个俄罗斯代表团到你们的首都，邀请你参加我的下一次化妆舞会。当然，你得穿上你最好的衣服，要么干脆就别来了。"),
		
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",							"同意。"),
		
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",							"我不想让任何人来到我的国家，所以答案是否定的。"),
		
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_JFD_ELISABETH_ANY",										"我的一些商人在你的边境附近遇到了一些困难。所以你会同意向我开放边界，让他们通过的。你不会让我失望吧？"),
		
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",							"当然，为什么不呢？我谦和地接过你的友谊之手。"),
		
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",							"朋友？和你？啊哈！"),
		
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_JFD_ELISABETH_ANY",									"如果我们成为好朋友，我会很高兴的。你觉得怎么样？"),
		
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_ELISABETH_ANY",								"嗯，当然。谁不想和我成为朋友？"),
		
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_ELISABETH_ANY",								"你肯定在开玩笑，对吧？"),
		
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_JFD_ELISABETH_ANY",										"我想多花点时间在我的宫廷里，而不是整天跟我的军事大臣们待在一起。所以我要依靠你们来帮助捍卫俄罗斯的利益。你愿意接受这个同盟吗？"),
		
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_JFD_ELISABETH_ANY",													"欢迎您随时来访，英明的君主！"),
		
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_JFD_ELISABETH_ANY",												"坦率地说，我认为你是在暴殄天物。"),
		
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_JFD_ELISABETH_ANY",							"我的一些朝臣认为应该停止我的娱乐活动，他们提醒我你的军队正在我的边境集结。这让我很不舒服，我要求你马上把它们撤走。"),
		
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_JFD_ELISABETH_ANY",									"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_ELISABETH_ANY}"),
		
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_JFD_ELISABETH_ANY",									"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_ELISABETH_ANY}"),
		
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",										"别指望我会邀请你参加我的下一次化妆舞会。"),
		
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_JFD_ELISABETH_ANY",											"你真是让人恼火。[NEWLINE]（谴责你）"),

------ 谴责理由

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_COURT_SPLENDOUR_DESIRED_LUXURY",		"（您拥有她所没有的奢侈品）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_COURT_SPLENDOUR_LEADS_GREAT_PEOPLE",	"（您与她竞争伟人）"),
	
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",									"来吧。我曾经在我的朝堂里跟比你凶狠百倍的敌人斗争过。"),
		
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_JFD_ELISABETH_ANY",										"你们的政策是对俄罗斯利益的威胁。准备动员你的部队吧，我们走向战争了。"),
		
------ 求和	
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_JFD_ELISABETH_ANY",									"明智的提议。"),
		
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_JFD_ELISABETH_ANY",									"不，我不这么认为。"),
		
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_JFD_ELISABETH_ANY",										"现在到了停止这场乏味的战争，恢复和平的时候了。"),
		
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_ELISABETH_ANY",											"没有我，朝廷就不一样了……我敢说，再也没有哪个宫廷会象现在这样辉煌了。"),
		
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_JFD_ELISABETH_ANY",											"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_ELISABETH_ANY}"),

---- 艺术学院

		("zh_Hans_CN",	"LOC_BUILDING_JFD_ART_INSTITUTE_NAME",															"艺术学院"),
		("zh_Hans_CN",	"LOC_BUILDING_JFD_ART_INSTITUTE_DESCRIPTION",													"伊丽莎白作为领袖时的特色建筑。每次使用一位 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家或 [ICON_GreatWriter] 大作家时可奖励一位 [ICON_Envoy] 使者。提供+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_JFD_ART_INSTITUTE_CHAPTER_HISTORY_PARA_1",					"【译者注：正在翻译……】[NEWLINE][NEWLINE]The Russian Academy of Arts in Saint Petersburg, informally known as the Saint Petersburg Academy of Arts, was founded in 1757 by Ivan Shuvalov under the name Academy of the Three Noblest Arts, under the patronage of Elisabeth Petrovna. Catherine the Great renamed it the Imperial Academy of Arts and commissioned a new building, completed 25 years later in 1789 by the Neva River. The academy promoted the neoclassical style and technique, and sent its promising students to European capitals for further study. Training at the academy was virtually required for artists to make successful careers.");