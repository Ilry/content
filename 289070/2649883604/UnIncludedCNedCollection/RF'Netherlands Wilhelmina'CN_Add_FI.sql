-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Netherlands Wilhelmina'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/21 19:01:52
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Netherlands: Wilhelmina” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

-- DutchJuliana_GameText.xml文件
---- 领袖

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,								Text)
VALUES
		("zh_Hans_CN",	"LOC_LEADER_JFD_JULIANA_NAME",		"朱莉安娜");

---- 领袖百科，针对原模组对迭起兴衰中威廉明娜相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_TITLE" AND Language = "zh_Hans_CN")
			THEN "朱莉安娜" 
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_SUBTITLE" AND Language = "zh_Hans_CN")
			THEN "荷兰女王"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "朱莉安娜从1948年开始担任荷兰女王，直到1980年退位。她是威廉明娜女王和亨德里克亲王的独生女。从出生起，她就是荷兰王位的指定继承人，受过私人教育。1937年，她与利珀-比斯特费尔德的伯恩哈德王子结婚，并育有四个孩子：碧翠丝、艾琳、玛格丽特和克里斯蒂娜。她在位将近32年。 在她的统治下，荷属东印度群岛（现为印度尼西亚）和苏里南实现了非殖民化，并从荷兰王国独立出来。在她94岁去世时，她是当时世界上最长寿的前在位君主。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "1940年5月12日，在第二次世界大战德国入侵荷兰期间，伯恩哈德王子和朱莉安娜公主被疏散到英国，次日威廉明娜女王和荷兰政府官员紧随其后，流亡海外。公主在那里待了一个月，然后带着孩子们去了加拿大首都渥太华，在那里她住在洛克克利夫公园郊区的斯托诺韦。她的母亲和丈夫随荷兰流亡政府留在英国。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN "当她的第三个孩子玛格丽特公主出生时，加拿大总督阿斯隆勋爵批准了一项特别法律，宣布朱莉安娜公主在渥太华市政医院的房间具有治外法权，以便婴儿拥有完全的荷兰国籍而非双重国籍。如果没有这项法律，玛格丽特公主就无法获得继承权。加拿大政府在议会的和平塔上飘扬着荷兰三色旗，而随着玛格丽特公主出生的消息，它的钟琴伴随着荷兰音乐响起。伯恩哈德王子与威廉明娜女王和流亡的荷兰政府成员留在伦敦，她得以探望她在加拿大的家人，并在那里迎接玛格丽特的出生。朱莉安娜公主的真诚与热情和她的东道主加拿大建立了起了一种特殊持久的关系，当加拿大士兵在1944年和1945年为从纳粹手中解放荷兰而战死数千人时，这种关系得到了加强。1945年5月2日，她与威廉明娜女王乘坐军用运输机返回荷兰解放区，赶往布雷达建立临时荷兰政府。回到家后，她向渥太华市发去了10万个郁金香球茎，以表达对加拿大的感激之情。荷兰的朱莉安娜公主竖立了一个木制讲台和黄铜牌匾，以感谢圣安德鲁长老会（渥太华）在第二次世界大战期间朱莉安娜公主在渥太华居住时的热情款待。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_4" AND Language = "zh_Hans_CN")
			THEN "1945年6月24日，她乘坐RMS伊丽莎白女王号从苏格兰古罗克前往美国，并将她的最后一个永久居住地定为英国伦敦。次年（1946年），朱莉安娜又捐赠了20500个球茎，并要求将其中的一部分种植在她生下玛格丽特的渥太华市政医院的场地上。同时，她承诺在有生之年里每年都向渥太华赠送郁金香礼物，以表达她对加拿大战时热情好客的感激。每年渥太华都会举办加拿大郁金香节来庆祝。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_5" AND Language = "zh_Hans_CN")
			THEN ""
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_6" AND Language = "zh_Hans_CN")
			THEN ""
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_7" AND Language = "zh_Hans_CN")
			THEN ""
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_CAPSULE_BODY" AND Language = "zh_Hans_CN")
			THEN "朱莉安娜的荷兰帝国地处河川入海的平原。荷兰人填海造陆打造圩田发展国家，建造港口开拓贸易路线与全球联系起来，并将她对她人民的爱传播到世界各地。"
		WHEN (Tag = "LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_DETAILED_BODY" AND Language = "zh_Hans_CN")
			THEN "荷兰需要沿开局位置附近的海岸线进行探索，寻找河流和天然海湾作为帝国的根基。在每个沿海城市中修建港口获取额外的单元格，精心部署圩田能获取的水域单元格。在世界各地开拓贸易路线以确保荷兰的黄金时代，并结识尽可能多的城邦朋友为您的国家积累大量的文化值。有了这些，任何胜利类型都将成为荷兰的理想选择，尤其是文化胜利。"
	END)
WHERE Tag IN
(
	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_TITLE",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_SUBTITLE",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_1",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_2",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_3",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_4",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_5",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_6",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_HISTORY_PARA_7",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_CAPSULE_BODY",
 	"LOC_PEDIA_LEADERS_PAGE_LEADER_WILHELMINA_CHAPTER_DETAILED_BODY"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_JULIANA_NAME" AND Language = "en_US"));

---- 领袖议程

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,									Text)
VALUES
		("zh_Hans_CN",	"LOC_AGENDA_JFD_HOOFD_DER_UNIE_NAME",	"工会主席");

---- 载入，针对原模组对迭起兴衰中威廉明娜相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LOADING_INFO_LEADER_WILHELMINA",
		"zh_Hans_CN",
		"朱莉安娜女王，你的母亲给你留下了一项重要的任务：爱护荷兰的子民，并将这种爱分享到全世界。将您国家的色彩传播到全球。漂洋过海，建立新的殖民地。跨越国界，结交新的朋友。有了这些，即使在危机时刻，荷兰人也将毫不畏惧。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_JULIANA_NAME" AND Language = "en_US"));

---- 领袖特性

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,													Text)
VALUES
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_FESTIVALS_TULIPS_NAME",			"郁金香节"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_FESTIVALS_TULIPS_DESCRIPTION",	"成为任何类型战争的目标时，获得两位 [ICON_Envoy] 使者。每位城邦 [ICON_Envoy] 使者提供+1 [ICON_Culture] 文化值。"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_FESTIVAL_TULIPS_NOTIFICATION",	"您将郁金香送予您的朋友以求和平。[COLOR_GREEN]获得{1_Num}位  [ICON_Envoy] 使者。[ENDCOLOR]");
		
---- 外交，针对原模组对迭起兴衰中威廉明娜相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_FIRST_MEET_LEADER_WILHELMINA_ANY",
		"zh_Hans_CN",
		"我是荷兰女王朱莉安娜。很高兴终于见到了你。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_JULIANA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_AGENDA_BILLIONAIRE_TRADE",
		"zh_Hans_CN",
		"（您没有与他们进行交易）"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_JULIANA_NAME" AND Language = "en_US"));		

-- DutchWilhelmina_GameText.xml文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																						Text)
VALUES

---- 模组

		("zh_Hans_CN",	"LOC_MOD_JFD_NETHERLANDS_WILHELMINA_DESCRIPTION",											"------------------------------------[NEWLINE]领袖名称 -- 威廉明娜[NEWLINE][NEWLINE]领袖能力 - 橙色电台[NEWLINE]在加入紧急状况时，所有城市每回合+1忠诚度；位于非原始首都所在大陆的城市改为+2。忠诚度为满的城市+15% [ICON_Culture] 文化值产出。[NEWLINE][NEWLINE]领袖议程 - 荷兰抵抗运动[NEWLINE]设法维持她公民的忠诚度。喜欢那些让她进入紧急状况的文明，尤其是那些同样维持公民忠诚度的文明。[NEWLINE][NEWLINE]------------------------------------[NEWLINE]领袖名称 -- 朱莉安娜[NEWLINE][NEWLINE]领袖能力 - 郁金香节[NEWLINE]成为任何类型战争的目标时，获得两位 [ICON_Envoy] 使者。每位城邦 [ICON_Envoy] 使者提供+1 [ICON_Culture] 文化值。[NEWLINE][NEWLINE]领袖议程 - 工会主席[NEWLINE]喜欢与之进行交易的文明，讨厌不与之交易的文明。"),
		
---- 领袖百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_TITLE",										"威廉明娜"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_SUBTITLE",									"荷兰女王"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_QUOTE",										"堤坝开启之刻，水存十尺之深。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_1",						"自牙牙学语之时起，威廉明娜便知道如何当好（或者说以后如何当好）荷兰女王。她是在位时间最久的荷兰君主，带领人民度过了数个动荡时代——20世纪的曙光、20世纪30年代的经济崩溃，以及两次世界大战。她高贵端庄，泰然自若，全心全意地维护荷兰的主权。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_2",						"威廉明娜生于1880年，父母是威廉三世和他的第二任妻子埃玛公主。四岁时，同父异母的兄弟和叔祖父相继去世，她因此成为荷兰王位的继承人。威廉明娜十岁生日后不久，父亲威廉三世去世。埃玛王后便担任这位年轻女王的摄政王，直到威廉明娜18岁正式登基。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_3",						"威廉明娜女王坚强而优雅地应对着执政初期的诸多挑战。年轻的女王的确给人留下了极为深刻的印象。英国女王维多利亚认为年轻的威廉明娜美丽、文雅、聪颖，而德国的威廉二世也见证了她的敏锐机智。第一次世界大战前的一次会议中，威廉二世表示自己的卫兵有“两米高”，而威廉明娜的卫兵的身高则“只及肩膀”。她则优雅地回答：“陛下所言非虚，你们的卫兵身高两米，但我们的堤坝水深三米！”荷兰在之后的第一次世界大战中保持中立——也许德国皇帝难以忘记她的警言。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_4",						"荷兰虽为中立国，但威廉明娜却在一战期间支持强有力的国防政策。她对国家的军事保持关注，并坚持在国境上执行警戒协议，甚至连她的丈夫亨利亲王出境前往德国探亲也不得例外。她经常进行全国视察，访问部队，发放救济金。然而后来荷兰意外卷入日益蔓延的第一次世界大战，威廉明娜对此十分不满。协约国的封锁政策让荷兰的贸易受挫，这对商贾之国来说简直是直戳痛处。战争结束时，协约国也强烈反对威廉明娜给予威廉二世政治庇护的决定。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_5",						"威廉明娜女王以战止战，在二战开始之前稳固统治。她埋葬了丈夫与母亲，为女儿朱丽安娜公主找到合适的夫婿，确保皇室血脉的未来继承。当时正值世界经济崩溃，谨慎而精明的投资选择使她成为了世界上最富有的人之一。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_6",						"1940年5月10日，德国入侵，将二战战火烧到荷兰。威廉明娜女王对入侵事件发表了“激烈的抗议”。她被迫离开荷兰前往英格兰避难，并将家人送往加拿大。她的撤离经过深思熟虑，而非懦弱之举。因为只要女王不死，荷兰人民便会协作抗敌。威廉明娜的离开实际昭示着她的抵抗。她的流亡政府一直设在伦敦，直到战争结束。她在橙色电台上鼓励沦陷地区的人名保持抵抗。在她的鼓舞之下，荷兰的抵抗运动一直持续至1945年女王回国。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_HISTORY_PARA_7",						"经历两次世界大战和58年的统治后，威廉明娜在1948年将王位传给女儿朱丽安娜。她统治期间所作的决策帮助荷兰度过了现代史上最困难的时期。时至今日，她仍被荷兰人民深深怀念。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_CAPSULE_BODY",						"威廉明娜的荷兰帝国地处河川入海的平原。荷兰人填海造陆打造圩田发展国家，开拓贸易路线以联系全球，并在紧急状况时召集她的子民。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_WILHELMINA_CHAPTER_DETAILED_BODY",						"荷兰需要沿开局位置附近的海岸线进行探索，寻找河流和天然海湾作为帝国的根基。在每个沿海城市中修建港口获取额外的单元格，精心部署圩田能获取的水域单元格。在世界各地开拓贸易路线以确保荷兰的黄金时代，并积极加入紧急状况以确保公民的忠诚和他们的文化素养。有了这些，任何胜利类型都将成为荷兰的理想选择，尤其是文化胜利。"),
				
---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_JFD_WILHELMINA",													"威廉明娜女王，您将长久地守卫荷兰，至死不渝。荷兰人的奇思妙想可将海岸变为农田。在强大战舰的保护之下，您的子民们将积极高效地进行劳作。而最重要的则是贸易经商。良好的贸易足可以化敌为友；如陷入战争，充足的资金也能助您抵御外敌。"),
				
---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_JFD_DUTCH_RESISTANCE_NAME",														"荷兰抵抗运动"),
		("zh_Hans_CN",	"LOC_AGENDA_JFD_DUTCH_RESISTANCE_DESCRIPTION",												"设法维持她公民的忠诚度。喜欢那些让她进入紧急状况的文明，尤其是那些同样维持公民忠诚度的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_JFD_WILHELMINA_REASON_IN_JOINT_EMERGENCY",							"（您让她加入了紧急状况）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_DUTCH_RESISTANCE_IN_JOINT_EMERGENCY",						"威廉明娜感谢您的支持。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_JFD_WILHELMINA_REASON_IN_JOINT_EMERGENCY_AND_GAINING_CITIES",		"（在加入紧急情况时，您还维持了公民的忠诚度）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_DUTCH_RESISTANCE_IN_JOINT_EMERGENCY_AND_GAINING_CITIES",		"威廉明娜为你的人民感到高兴。"),
				
---- 特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_RADIO_ORANJE_NAME",													"橙色电台"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_RADIO_ORANJE_DESCRIPTION",											"在加入紧急状况时，所有城市每回合+1忠诚度；位于非原始首都所在大陆的城市改为+2。忠诚度为满的城市+15% [ICON_Culture] 文化值产出。"),
				
---- 外交
------ 初次见面
-------- 开场白
		
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_JFD_WILHELMINA_ANY",											"向你致敬，伟大的领袖。我是荷兰与荷兰人民的威廉明娜女王。欢迎来到荷兰。"),
		
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_JFD_WILHELMINA_ANY",							"请和我一起到我附近的城市，这样我们就可以在那讨论未来。"),
		
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_JFD_WILHELMINA_ANY",					"那就好。我或许应该期望得到一些茶点？会见新领袖总会让人筋疲力尽。"),
		
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_JFD_WILHELMINA_ANY",						"别害羞，告诉我你的首都在哪。当然，我也会这样做。"),
		
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_JFD_WILHELMINA_ANY",												"欢迎回来。"),
		
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",							"我礼貌地接受你的代表团。愿它带来美好的事物。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",							"我不会在你的政治游戏上浪费时间。不要再费心派一个代表团了。"),
		
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_JFD_WILHELMINA_ANY",									"向你致以亲切的问候，我刚刚派了一个代表团带去一些新鲜的橘子。我希望你会喜欢，它们来自我们海外最好的橘子产地。"),
				
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",						"我很高兴我们达成了这个协议。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",						"我的边界将保持关闭。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_JFD_WILHELMINA_ANY",									"如果我们要通过外交取得任何进展，我们之间的贸易就必须蓬勃发展。来吧，让我们开放边境。"),
				
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",						"值得的友谊。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",						"我对你和你的人民没有爱，等我有此念头再说吧。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_JFD_WILHELMINA_ANY",								"我非常尊重并热爱你们的人民和习俗。你能给我一份友谊宣言吗？"),
				
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_WILHELMINA_ANY",						"非常好。"),
				
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_WILHELMINA_ANY",						"可以肯定的是，这很遗憾。"),
				
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_JFD_WILHELMINA_ANY",								"我们将一起走得更远，向世界展示力量是通过和平而不是战争来实现的。"),
				
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_JFD_WILHELMINA_ANY",											"你们人民的持续支持对荷兰民族意义重大。"),
		
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_JFD_WILHELMINA_ANY",						"你的士兵可能很高，但我们的堤防有10英尺深！把他们挪到别处会更明智。"),
		
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_JFD_WILHELMINA_ANY",								"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_WILHELMINA_ANY}"),
				
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_JFD_WILHELMINA_ANY",								"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_WILHELMINA_ANY}"),
				
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",									"那么，您将不会赢得我们的爱戴。"),
				
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_JFD_WILHELMINA_ANY",										"你是彻头彻尾的政治家，我讨厌政治家。[NEWLINE]（谴责你）"),
		
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",								"你今天在这里的行动真的值得你的人民为此付出的代价吗？"),
			
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_JFD_WILHELMINA_ANY",									"那就不用通过外交手段来对付你了。我们必须改为测试我们武器的强度。理想情况下，在海上是最好的……"),
				
------ 求和	
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_JFD_WILHELMINA_ANY",							"可以肯定的是这是一种解脱。"),
				
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_JFD_WILHELMINA_ANY",							"这是不可能的。"),
				
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_JFD_WILHELMINA_ANY",									"外交和贸易必须赢得胜利。我们是否应该回到这些话题中而不是继续这场毫无意义的战争？"),
				
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_WILHELMINA_ANY",										"对我的人民和世界和平主义者来说这是一场灾难。"),
				
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_JFD_WILHELMINA_ANY",									"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_WILHELMINA_ANY}");




