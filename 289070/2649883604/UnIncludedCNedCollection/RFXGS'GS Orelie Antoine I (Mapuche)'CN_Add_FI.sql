-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'GS Orelie Antoine I (Mapuche)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/30 17:54:52
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “[GS] Orelie Antoine I (Mapuche)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

-- DiploText_Oreliex.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																	Text)
VALUES

---- 历史议程
------ 议程

		("zh_Hans_CN",	"LOC_AGENDA_LEU_ORELIE_NAME",											"温卡国王"),
		("zh_Hans_CN",	"LOC_AGENDA_LEU_ORELIE_DESCRIPTION",									"重视开放边界协议，喜欢与他签署开放边界协议的文明。不喜欢清除蛮族营地的文明。"),
		
------ 赞成

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_ORELIE_POSITIVE",								"奥雷利耶·安托万喜欢与他签署开放边界协议的文明"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_LEU_ORELIE_ANY",							"有了这个协议，阿劳坎尼亚的人民将能够自由地漫游这些美丽的土地。我感激不尽。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_LEU_ORELIE_REASON_ANY",							"（您和他签署了开放边界协议）"),
		
------ 警告

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_LEU_ORELIE_NEGATIVE",								"奥雷利耶·安托万不喜欢清除蛮族营地的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_LEU_ORELIE_ANY",							"你为了你的贪婪而消灭这些当地人！你看不出这里是他们的合法土地吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_LEU_ORELIE_REASON_ANY",						"（您清除了蛮族哨站）"),

------ 初次见面
-------- 开场白

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_LEU_ORELIE_ANY",							"我，美丽的阿劳坎尼亚和巴塔哥尼亚王国之王，奥雷利耶·安托万。愿这次相遇为我们两国带来繁荣"),

-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_LEU_ORELIE_ANY",			"我们可能还没有宫殿，但我向你保证佩尔琴科拥有标准首都所应该有的一切。而这些土地本身就已经足够雄伟了！"),

-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_LEU_ORELIE_ANY",	"阿劳坎尼亚和巴塔哥尼亚国王优雅地接受了"),

-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_LEU_ORELIE_ANY",		"请允许我了解您的人民。这肯定会有助于我们之间未来的任何协议"),

------ 代表团
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_LEU_ORELIE_ANY",					"马普切人制作了一些我见过的最好的雨披。我已经和托基人安排好送你一些"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",			"我会把你送来的小饰品带给马普切的孩子们，他们会喜欢的！"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",			"你认为这些礼物适合国王吗？恐怕我不得不拒绝你简单的礼品"),

------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_LEU_ORELIE_ANY",								"我很高兴总与另一位伟大领袖打招呼！"),

------ 开放边境
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_LEU_ORELIE_ANY",					"在与托基人和朗科斯人会面之后，我们的王国决定向您敞开大门！你愿意接受这个盛大的邀请吗？"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",		"漫游阿劳坎尼亚将是您的荣幸"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",		"马普切的托基人不够信任你，我同意他们的看法。"),

------ 宣布友谊
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_LEU_ORELIE_ANY",					"我怀着与你们人民交朋友的马普切精神，对伸出友谊之手深感荣幸！"),

-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",		"这是我们共同胜利的时刻！"),

-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",		"马普切的托基人认为你是个威胁，我很害怕。"),

------ 谴责
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",					"你怎么敢骂我？托基人会听到这句话的！"),

-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_LEU_ORELIE_ANY",						"你的出现，破坏了原本美丽的风景！我，国王，谴责你的恶行！[NEWLINE]（谴责你）"),

------ 贸易
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_LEU_ORELIE_ANY",				"我们非常客气地接受了。"),

-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_LEU_ORELIE_ANY",				"不要侮辱阿劳坎尼亚和巴塔哥尼亚王国！"),

------ 其他对白
-------- AI请求结盟

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_LEU_ORELIE_ANY",				"加入我吧，我的朋友。与我结盟，帮助我为马普切人建设这个美丽的王国。"),

-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_LEU_ORELIE_ANY",		"一些马普切人已经注意到你在我们边境旁的存在。谨慎行事，马普切人的意志比你想象的要强大。"),

------ 战争与和平
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",				"我一直在努力和平地建立这个王国……马普切人会阻止你！"),

-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_LEU_ORELIE_ANYY",					"托基人认为你太危险了，不能活下去。我无法阻止他们的愤怒，你也不能。"),

-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_ORELIE_ANY",			"我告诉过你不能玩弄阿劳坎尼亚人。我很高兴我们可以签署这个和平条约。让我们在我的宫殿中庆祝吧！"),

-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_LEU_ORELIE_ANY",			"就算我想签署和平条约，托基人也一心想杀了你……"),

-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_LEU_ORELIE_ANY",					"我祈求你！让我们结束这场战争！让我们文明一点！"),

-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_LEU_ORELIE_ANY",					"我想通过和平方式建立这个王国……但马普切人是凶猛的战士，他们向你展示了他们对渴望鲜血的人无所畏惧。"),

-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_LEU_ORELIE_ANY",						"你可能认为我是个疯子……我的疯狂是相信这个美丽的王国……相信这个美丽的文化……但如果要说我学到了什么，那就是马普切人永远不会真正被打败……即使没有我，他们仍然会崛起。");
		
-- LeaderText_Orelie.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 基本领袖信息
------ 领袖名称

		("zh_Hans_CN",	"LOC_LEADER_LEU_ORELIE_NAME",										"奥雷利耶·安托万"),
		
------ 全名

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_TITLE",					"奥雷利耶·安托万·德·图龙"),
		
------ 头衔

		("zh_Hans_CN",	"PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_SUBTITLE",					"阿劳坎尼亚和巴塔哥尼亚王国国王"),
		
------ 首都名称（可用时）

		("zh_Hans_CN",	"LOC_CITY_NAME_LEU_ORELIE_01",										"佩尔琴科"),
		
------ 引言

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_QUOTE",					"阿劳坎尼亚是勇敢的民族，智利嫉妒他们的独立，却徒劳地试图驯服他们。"),
		
------ 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_LEU_ORELIE",								"你的探险将你带到这片美丽而令人向往的土地，你将成为最受尊敬的国王，并扛起最伟大的职责。当您漫游阿劳坎尼亚和巴塔哥尼亚时，说服托基人与您一起努力建立一个强大的王国。广而远之，与所有在心中寻求自由的人缔结契约。正是通过智慧和语言的力量，您将带领马普切的人民走向他们向往的独立和自由。"),

---- 领袖能力
------ 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LEU_ORELIE_NAME",									"南星之王"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_LEU_ORELIE_DESCRIPTION",							"“开放边境”协议每回合将为双方+1 [ICON_Favor] 外交支持。当成为世界议会决议的目标、抑或参与紧急情况时，您文明所有城市境内的单元格+2魅力值；若此城有 [ICON_Governor] 总督就职，则魅力值加成翻倍。"),

------ 能力描述

		("zh_Hans_CN",	"LOC_ABILITY_LEU_ORELIE_FOREIGN_TERRITORY_NAME",					"南星骑士"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_ORELIE_FOREIGN_TERRITORY_DESCRIPTION",				"可在没有开放边境的情况下进入其他文明境内。"),
		("zh_Hans_CN",	"LOC_ABILITY_LEU_ORELIE_FOREIGN_TERRITORY_DESCRIPTION",				"可在没有开放边境的情况下进入其他文明境内。"),
		("zh_Hans_CN",	"LOC_EMEGENCY_LEU_ORELIE_BUFF_DESCRIPTION",							"当成为世界议会决议的目标、抑或参与紧急情况时，您文明所有城市境内的单元格将获得额外的魅力值。"),

---- 玩法
------ 简略

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_CAPSULE_BODY",	"奥雷利耶是一个擅长外交的伟大领袖。通过开放边界以赢得支持和总督。"),
		
------ 详细

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_DETAILED_BODY",	"当奥雷利耶作为马普切的领袖时，积累外交支持很重要，以便在世界议会上使用。通过世界大会决议可以帮助你获得更多的总督，这将使您的单位变得更强大。"),

	------ 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_1",	"奥雷利耶·安托万·德·图龙是一位法国探险家，他于1825年5月12日出生在阿摩尔的小村庄拉谢茲，离图尔图瓦拉克不远。他于1878年9月17日在图尔图瓦拉克去世。他是一个农民家庭中的第八个儿子，这个家庭总共有九个孩子。他的父母是让·图南斯和凯瑟琳·贾登。他是一个才华横溢且敏感的孩子，对历史非常感兴趣。"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_2",	"安托万在家人的支持下于1858年乘船离开，在南安普敦停留，前往智利，并于1858年8月28日抵达那里。在最初的两年里，他学习了西班牙语并接触了很多当地人。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_3",	"他还与居住在阿劳坎尼亚地区的马丘佩印第安人取得了联系，他们为争取独立而与智利政府作战。他决定站在他们那边并支持他们，1860年阿劳坎尼亚地区重新获得了独立。他或许有着独特的个人魅力，在1860年11月20日，也就是他35岁时，他被任命为阿劳坎尼亚和巴塔哥尼亚王国的国王：奥雷利耶·安托万·德·图龙国王。通过这种方式，他声称他的王国从安第斯山脉延伸到大西洋和麦哲伦海峡。他立即实行了法国的政体形式。"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_4",	"安托万希望依靠于法国的热情和支持，毕竟多年来法国在海外失去了许多殖民地，但法国没有表现出帮助的兴趣和意图。1862年1月5日，他再次组建军队，却被智利军队打败并俘虏。他在法国领事的帮助下获释，并于1862年10月返回法国。回到家乡，他的王国和国王头衔没有得到承认，在为自己的事业而战时，他四处碰壁。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_5",	"在1860-1862年间，阿劳坎尼亚和巴塔哥尼亚王国在某种程度上确实存在。但是我们在皇室成员名单上看到的拉谢茲和德方丹大臣并不存在。第一个名字对应于“La Chèze”，也就是安托万出生的那个小村庄的名字，第二个对应于 “Les Fontaines”，一个离第一个小村庄不远的小村庄的名字。"),

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_LEU_ORELIE_CHAPTER_HISTORY_PARA_6",	"在国家图书馆里可以找到1866年夏天支持奥雷利耶·安托万的签名集，尤其是在波尔多。他还得到了经济支持，并于1869年返回智利，在那里一直待到1871年。回到法国后，他组织了第三次远征，但当他到达智利时，几乎是立即被捕、入狱，并在法国政府的帮助下于2个月后获释。1876-1877年，他第四次回到智利，但得了重病，最后回到法国。");


