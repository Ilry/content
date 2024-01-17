-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Rome Nero'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/23 0:08:05
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Rome: Nero” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																					Text)
VALUES

---- 模组
		
		("zh_Hans_CN",	"LOC_MOD_JFD_ROME_NERO_DESCRIPTION",													"------------------------------------[NEWLINE]领袖名称 -- 尼禄[NEWLINE][NEWLINE]领袖特性 - 五年一度的尼禄节[NEWLINE]拥有剧院广场的城市进行项目+25% [ICON_Production] 生产力。完成任何项目均可获得 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家和 [ICON_GreatWriter] 大作家点数奖励。完成市政“戏剧与诗歌”后解锁特色建筑罗马剧院。[NEWLINE][NEWLINE]特色建筑 - 罗马剧院[NEWLINE]尼禄作为领袖时的罗马特色建筑，取代古罗马剧场。可提供 [ICON_GreatMusician] 大音乐家点数，且提供一个 [ICON_GreatWork_Music] 音乐巨作槽位。[NEWLINE][NEWLINE]领袖议程 - 菲丽娜[NEWLINE]喜欢保持他人民的幸福度与文化程度，并欣赏这样做的文明。蔑视忽视人民幸福或文化的文明。"),
				
---- 领袖

		("zh_Hans_CN",	"LOC_LEADER_JFD_NERO_NAME",																"尼禄"),
				
---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_JFD_PHILHELLENE_NAME",														"菲丽娜"),
		("zh_Hans_CN",	"LOC_AGENDA_JFD_PHILHELLENE_DESCRIPTION",												"喜欢保持他人民的幸福度与文化程度，并欣赏这样做的文明。蔑视忽视人民幸福或文化的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_JFD_NERO_REASON_LEADS_CULTURE_AND_HAPPINESS",					"（您在文化和公民幸福方面很强）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_PHILHELLENE_LEADS_CULTURE_AND_HAPPINESS",				"尼禄很高兴看到您的公民很满足且有文化。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_NERO_REASON_LAGS_CULTURE",								"（您在文化方面很薄弱）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_PHILHELLENE_LAGS_CULTURE",								"尼禄鄙视你缺乏文化的野蛮公民。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_NERO_REASON_LAGS_HAPPINESS",								"（您在公民幸福方面做得很差）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_PHILHELLENE_LAGS_HAPPINESS",								"尼禄希望看到你不开心的公民能够得到满足。"),
				
---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_JFD_NERO",														"展现您的才能，伟大的尼禄皇帝，因为你的文化复兴运动已经开始。违背贵族的意愿，穿上演员的长袍，振奋人民的精神。给他们带来伟大的作品和纪念碑，并以他们的名义庆祝伟大的节日。大力复兴艺术，因为它曾经在古希腊时期蓬勃发展。"),
				
---- 特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_QUINQUENNIAL_NERONIA_NAME",										"五年一度的尼禄节"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_QUINQUENNIAL_NERONIA_DESCRIPTION",								"拥有剧院广场的城市进行项目+25% [ICON_Production] 生产力。完成任何项目均可获得 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家和 [ICON_GreatWriter] 大作家点数奖励。完成市政“戏剧与诗歌”后解锁特色建筑罗马剧院。"),
				
---- 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_TITLE",											"尼禄"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_SUBTITLE",										"罗马皇帝"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_QUOTE",											"我希望我不会写作。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_HISTORY_PARA_1",						"尼禄是公元54年至68年的罗马皇帝，也是朱里亚·克劳狄王朝的最后一位皇帝。尼禄被他的叔叔克劳狄斯收养为他的继承人，并和他一样，在禁卫军的同意下成为了皇帝。尼禄的母亲小阿格里皮娜与克劳狄斯的死和尼禄被提名为皇帝有关。她主宰了尼禄的早年生活和一切决定，直到他抛弃了她；在尼禄统治五年后，他处决了她。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_HISTORY_PARA_2",						"他在统治初期做得很好。起初，他听命于由他的母亲、他的导师卢修斯·阿内乌斯·塞内卡和他的执政官长官塞克斯图斯·阿弗拉尼乌斯·布鲁斯指导。随着时间的推移，他在政府和外交政策中扮演了更加积极和独立的角色。在他统治期间，令人敬畏的科尔布洛将军进行了一场成功的战争，并与帕提亚帝国进行了和平谈判。他的将军苏埃托尼乌斯·保利努斯镇压了英格兰的一场重大起义。博斯普兰王国被短暂地并入帝国，第一次犹太-罗马战争开始了。尼禄将他的大部分注意力集中在帝国的外交、贸易和文化生活上，下令建造剧院并推广体育运动。他以诗人、音乐家和车夫的身份公开露面；在传统主义者看来，这损害了他的心想、地位和职位的尊严和权威。他奢侈的、覆盖整个帝国的公共和私人作品计划是由税收加以资助的，这引起了中上层阶级的强烈不满。各种谋害他的阴谋被揭露，他们的头目被处决；大多数是尼禄自己的朝臣。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_HISTORY_PARA_3",						"68年，在伊斯帕尼亚塔拉哥·西班牙行省总督加尔巴的支持下，高卢总督温代克斯起义。 温代克斯的起义未能实现其直接目标，但不满的罗马文职和军事当局宣布支持加尔巴，并推举他为皇帝。尼禄逃离罗马。当他缺席审判并作为公敌被判处死刑时，他要么选择被抓获并被处决，要么选择自杀。他的死结束了朱里亚·克劳狄王朝，引发了一段短暂的内战，被称为四帝之年。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_HISTORY_PARA_4",						"尼禄的统治通常与暴政和奢侈联系在一起；他更臭名昭著的处决包括对他母亲的处决。大多数罗马史学家，例如苏埃托纽斯和卡修斯·迪奥，对他的个性和统治给予了压倒性的负面评价。塔西佗声称罗马人认为他有强迫症和腐败行为。许多罗马人认为，64年的罗马大火是由尼禄煽动的，目的是为他计划中的宫殿建筑群“金宫”扫清道路。据说他抓住基督徒作为火灾的替罪羊并将他们活活烧死，似乎不是出于公共正义而是出于个人残忍。一些现代历史学家质疑有关尼禄暴虐行为的古代资料的可靠性。一些史学家以更正面的方式描绘了尼禄。有证据表明他在罗马平民中很受欢迎，特别是在帝国东部省份，那里出现了一个流行的传说，即尼禄没有死而且会回来。至少三位短命的、失败的叛乱领导人自称“重生的尼禄”，以争取民众的支持。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_CAPSULE_BODY",							"罗马是值得您信任的文明，它可以一直发展，最终成为游戏里最强大的帝国。尼禄将进一步确保他公民的文化水平。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_CHAPTER_DETAILED_BODY",							"罗马想要快速占领城市，然后迅速沿着道路进行工程建设。在适当地方进行工程建设后，可在他们的城市添加浴场，城市会快速增长（并在尼禄专注于建筑和项目的情况下快速完善他们的基础设施）。“条条大路通罗马”的能力让他们从城市网络中获得了稳定收益（国际路线也适用，并非所有 [ICON_TradeRoute] 贸易路线都需为国内线路）。考虑到这些扩张会导致冲突，所以军团出现了。罗马军团建造堡垒的能力会比其他文明提前两个时代出现。对其进行有效使用是维持他广阔和强大帝国的关键。"),
				
---- 外交
------ 初次见面
-------- 开场白
	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_JFD_NERO_ANY",												"欢迎来到罗马，旅行者。我是伟大的尼禄，皇帝、受人喜爱的作词家、诗人、剧作家。想听听我刚写的一首诗吗？"),
				
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_JFD_NERO_ANY",								"伟大的尼禄想邀请您参加一场真正由您演奏的独奏会。我相信，全世界都不会错过它。"),
				
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_JFD_NERO_ANY",						"为什么，当然。我会很高兴的。"),
				
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_JFD_NERO_ANY",						"请让我们交换关于两个首都的信息。你没有必要与罗马保持距离。"),
				
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_JFD_NERO_ANY",												"啊，优秀的领袖。见到你总是很高兴。"),
				
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_JFD_NERO_ANY",							"是的，当然。事实上，我会做得更好。我将邀请贵国代表团参加我的下一场悲剧性的独奏音乐会。这不是很令人兴奋吗？"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_JFD_NERO_ANY",							"你认为你的代表团适合站在伟大的尼禄面前吗？我觉得不。"),
			
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_JFD_NERO_ANY",										"我已经派了一个代表团到你们的首都，连同我最新的歌剧的副本。现在，他们还不会像我一样背诵它，但是欢迎您在灵魂空虚时向我寻求听众。"),
				
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_NERO_ANY",							"是的，非常令人愉悦。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_NERO_ANY",							"不，不。外国人太多了。只有罗马人才能欣赏我的艺术。你明白的。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_JFD_NERO_ANY",									"您的人民渴望参观尼禄的大剧院。让我们开放边界，让你们的人民感到满意。"),
				
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_NERO_ANY",						"非常好。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_NERO_ANY",						"你想的太远了。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_JFD_NERO_ANY",									"尊敬的领袖，如果我们的良好友谊能够公开宣布给所有人听，我非常乐意。你怎么看？"),
				
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_NERO_ANY",							"你得到了我的感谢。"),
				
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_NERO_ANY",							"荒谬。你不知道我是伟大的尼禄吗？很明显，你不懂。"),
				
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_JFD_NERO_ANY",									"罗马很强大。她的盟友必须同样强大。你，我的朋友，会成为一个很好的盟友。你不这么认为吗？"),
				
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_JFD_NERO_ANY",												"我很高兴总是有一个志同道合的统治者的陪伴。"),
				
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_JFD_NERO_ANY",											"唉，我们的这些会谈好无聊……"),
				
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_JFD_NERO_ANY",						"我相信你很快就会从罗马边境撤走你的士兵？我不认为他们来这里是为了看我的剧院……"),
				
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_JFD_NERO_ANY",								"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_NERO_ANY}"),
				
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_JFD_NERO_ANY",								"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_NERO_ANY}"),
				
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_JFD_NERO_ANY",									"是这样吗？好吧，我向你保证，我会写一首关于你的醒目抒情诗。注意点！"),
				
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_JFD_NERO_ANY",										"你这个邪恶的野兽。你为什么要折磨和分散这位艺术家的灵魂？！[NEWLINE]（谴责你）"),
		
------ 谴责理由

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_PHILHELLENE_LAGS_CULTURE",		"（您在文化方面很薄弱）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_PHILHELLENE_LAGS_HAPPINESS",	"（您在公民幸福方面做得很差）"),
			
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_JFD_NERO_ANY",									"以神之名，很好。罗马会尽快处理你的，然后我就可以平静地回到我的剧院了。"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_JFD_NERO_ANY",									"你不是罗马的好朋友，我必须让罗马的敌人屈服。"),
				
------ 求和	
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_JFD_NERO_ANY",								"是的，很好。我受够了这些废话。"),
				
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_JFD_NERO_ANY",								"虽然我是艺术家，但我首先是罗马的皇帝。在这种情况下，我不能投降。"),
				
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_JFD_NERO_ANY",										"拜托，没有必要继续这场战争了。我有歌词要作曲，而你……好吧，我敢肯定，除了战斗，你还需要做其他事情……"),
				
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_NERO_ANY",											"一个艺术家将和我一起死去。"),
				
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_JFD_NERO_ANY",										"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_NERO_ANY}"),
						
---- 罗马剧院

		("zh_Hans_CN",	"LOC_BUILDING_JFD_THEATRUM_NAME",														"罗马剧院"),
		("zh_Hans_CN",	"LOC_BUILDING_JFD_THEATRUM_DESCRIPTION",												"尼禄作为领袖时的罗马特色建筑，取代古罗马剧场。可提供 [ICON_GreatMusician] 大音乐家点数，且提供一个 [ICON_GreatWork_Music] 音乐巨作槽位。"),
		("zh_Hans_CN",	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_JFD_THEATRUM_CHAPTER_HISTORY_PARA_1",				"古罗马戏剧指的是公元前4世纪罗马从君主制过渡到共和制时期开始的戏剧实践和表演时期。这个时代的戏剧一般分为悲剧和喜剧两种类型。普劳图斯、特伦斯和塞内卡的一些作品流传至今。最终，戏剧成为代表罗马社会的一个重要方面，因为它成为罗马人民在罗马共和和帝国时期表达政治情感的主要手段。");

---- 为与 Entarogan 的 [命运]尼禄领导的罗马 作区分而做的改动，后者启用时，前者的尼禄加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "尼禄", "尼禄（JFD.）")
WHERE Tag IN 
(
	"LOC_LEADER_JFD_NERO_NAME",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_NERO_TITLE",
	"LOC_BUILDING_JFD_THEATRUM_DESCRIPTION"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_NEROENT_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_MOD_JFD_ROME_NERO_DESCRIPTION",
		"zh_Hans_CN",
		"------------------------------------[NEWLINE]领袖名称 -- 尼禄（JFD.）[NEWLINE][NEWLINE]领袖特性 - 五年一度的尼禄节[NEWLINE]拥有剧院广场的城市进行项目+25% [ICON_Production] 生产力。完成任何项目均可获得 [ICON_GreatArtist] 大艺术家、[ICON_GreatMusician] 大音乐家和 [ICON_GreatWriter] 大作家点数奖励。完成市政“戏剧与诗歌”后解锁特色建筑罗马剧院。[NEWLINE][NEWLINE]特色建筑 - 罗马剧院[NEWLINE]尼禄（JFD.）作为领袖时的罗马特色建筑，取代古罗马剧场。可提供 [ICON_GreatMusician] 大音乐家点数，且提供一个 [ICON_GreatWork_Music] 音乐巨作槽位。[NEWLINE][NEWLINE]领袖议程 - 菲丽娜[NEWLINE]喜欢保持他人民的幸福度与文化程度，并欣赏这样做的文明。蔑视忽视人民幸福或文化的文明。"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_NEROENT_NAME");







