-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Monopoly++ Celebrities'CN_Add_IG1
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/16 21:34:16
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Monopoly++: Celebrities” 。该文件在 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，需 Criteria ： Active_Expansion_2 与 Active_Mod_MonoCele

-- RockBandTextAdjustments.sql文件
---- 替换名词

INSERT OR REPLACE INTO LocalizedText	-- 对游戏自带的 摇滚乐队在各类建筑上产出旅游业绩 的百科部分 进行润色
		(Language,		Tag,											Text)
VALUES
		("zh_Hans_CN",	"LOC_UI_PEDIA_TOURISM_BOMB_VALUE_BUILDING",		"举办摇滚音乐会可+{1_Tourism} [ICON_Tourism] 旅游业绩。");

UPDATE LocalizedText
SET Text = "允许用 [ICON_Faith] 信仰值购买潮流组合。" || Text
WHERE Tag = "LOC_BUILDING_CRISTO_REDENTOR_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = "潮流组合+100 [ICON_POPULARITY] 知名度。" || Text
WHERE Tag = "LOC_BUILDING_SYDNEY_OPERA_HOUSE_DESCRIPTION" AND Language = "zh_Hans_CN";

UPDATE LocalizedText
SET Text = REPLACE(Text, "摇滚乐队", "潮流组合")
WHERE Tag = Tag;

UPDATE LocalizedText
SET Text = REPLACE(Text, "摇滚乐队", "潮流组合")
WHERE Tag = Tag;

UPDATE LocalizedText
SET Text = REPLACE(Text, "摇滚音乐会", "明星巡演")
WHERE Tag = Tag;

UPDATE LocalizedText
SET Text = REPLACE(Text, "专辑销量", "知名度")
WHERE Tag = Tag;

UPDATE LocalizedText
SET Text = REPLACE(Text, "音乐会建筑", "巡演会场")
WHERE Tag = Tag;

---- 百老汇

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES
		("zh_Hans_CN", "LOC_BUILDING_BROADWAY_DESCRIPTION",													"获得一支拥有“音乐剧” [ICON_Promotion] 强化的潮流组合。所在城市+20% [ICON_Culture] 文化值产出。必须建在邻近剧院广场的平坦地形上。"),

---- 强化

		("zh_Hans_CN", "LOC_PROMOTION_ALBUM_COVER_ART_NAME",												"宣传摄影"),
		("zh_Hans_CN", "LOC_PROMOTION_ARENA_ROCK_NAME",														"职业运动员"),
		("zh_Hans_CN", "LOC_PROMOTION_GLAM_ROCK_NAME",														"音乐剧"),
		("zh_Hans_CN", "LOC_PROMOTION_GOES_TO_NAME",														"新闻报道"),
		("zh_Hans_CN", "LOC_PROMOTION_INDIE_NAME",															"反主流文化意象"),
		("zh_Hans_CN", "LOC_PROMOTION_MUSIC_FESTIVAL_NAME",													"环保主义者"),
		("zh_Hans_CN", "LOC_PROMOTION_POP_NAME",															"魅力"),
		("zh_Hans_CN", "LOC_PROMOTION_REGGAE_ROCK_NAME",													"鳄鱼猎人"),
		("zh_Hans_CN", "LOC_PROMOTION_RELIGIOUS_ROCK_NAME",													"电视布道"),
		("zh_Hans_CN", "LOC_PROMOTION_ROADIES_NAME",														"私人飞机"),
		("zh_Hans_CN", "LOC_PROMOTION_SPACE_ROCK_NAME",														"科学怪侠"),
		("zh_Hans_CN", "LOC_PROMOTION_SURF_ROCK_NAME",														"海滩派对"),

---- 演出

		("zh_Hans_CN", "LOC_MOMENT_UNIT_TOURISM_BOMB_FIRST_IN_WORLD",										"全球首场潮流组合巡回演唱会"),
		("zh_Hans_CN", "LOC_MOMENT_UNIT_TOURISM_BOMB_FIRST_IN_WORLD_DESCRIPTION",							"您文明成为了世界上首个开展明星巡演的文明。"),
		("zh_Hans_CN", "LOC_MOMENT_UNIT_TOURISM_BOMB_FIRST_IN_WORLD_INSTANCE_DESCRIPTION",					"{LOC_GRAMMAR_CIVNAME}的潮流组合让现场欢呼雀跃。{ActingPlayerCivName}登上舞台，新的时代就此诞生。"),
		("zh_Hans_CN", "LOC_MOMENT_UNIT_TOURISM_BOMB",														"首场明星巡演"),
		("zh_Hans_CN", "LOOC_MOMENT_UNIT_TOURISM_BOMB_DESCRIPTION",											"您文明举办了首场明星巡演。"),
		("zh_Hans_CN", "LOC_MOMENT_UNIT_TOURISM_BOMB_INSTANCE_DESCRIPTION",									"来自{LOC_GRAMMAR_CIVNAME}的世界知名潮流组合{ActingPlayerCivName}，为现场狂喜的粉丝们献上了自己的首秀。"),

------ 演出结果

		("zh_Hans_CN", "LOC_GOSSIP_ROCK_CONCERT",															"{1_City_Name}的一家报社发表了一篇名为“{2_ResultName}”的文章，对“{3_BandName}”的明星巡演作了相关评价。"),

-------- 5颗星

		("zh_Hans_CN", "LOC_RESULT_LEGENDS_OF_ROCK_NAME",													"一个传奇诞生了！"),
		("zh_Hans_CN", "LOC_RESULT_LEGENDS_OF_ROCK_DESCRIPTION",											"今天，一个新的传奇诞生了。 您的潮流组合为您文明带来了声誉，世人被他们的卓越所折服。随着他们知名度的提升，您文明的威名与文化传统也逐渐受到关注。"),

-------- 4颗星

		("zh_Hans_CN", "LOC_RESULT_HEADLINERS_NAME",														"头条新闻"),
		("zh_Hans_CN", "LOC_RESULT_HEADLINERS_DESCRIPTION",													"您仍能听到人群中为您的潮流组合呐喊的尖叫声和欢呼声。他们受欢迎规模之广使其成为了全球最重要的头条新闻，他们已然成为本世纪的标志。"),

-------- 3颗星

		("zh_Hans_CN", "LOC_RESULT_RISING_STARS_NAME",														"冉冉升起的新星"),
		("zh_Hans_CN", "LOC_RESULT_RISING_STARS_DESCRIPTION",												"您的潮流组合为追随他们的粉丝带去了心灵的慰藉，因而逐渐为人所知晓。他们的名声会永垂不朽，经得起时间的考验吗？[NEWLINE]抑或自此渐渐失宠？"),

-------- 2颗星

		("zh_Hans_CN", "LOC_RESULT_OPENING_ACT_NAME",														"茶余闲谈"),
		("zh_Hans_CN", "LOC_RESULT_OPENING_ACT_DESCRIPTION",												"您的潮流组合的动向已成为当地闲余谈资的一部分，有些人已经注意到了他们的名字。虽然远不及使人印象深刻，但他们的知名度依旧可以随着时间推移而提升。"),

-------- 1颗星

		("zh_Hans_CN", "LOC_RESULT_CREATIVE_DIFFERENCES_NAME",												"绝唱"),
		("zh_Hans_CN", "LOC_RESULT_CREATIVE_DIFFERENCES_DESCRIPTION",										"您的潮流组合的生涯已经走到尽头。依然会有人怀念他们往日的灿烂，不过也算能保留他们曾经的辉煌[NEWLINE]直至最后。"),

-------- 0颗星

		("zh_Hans_CN", "LOC_RESULT_AGING_ROCKERS_NAME",														"失宠"),
		("zh_Hans_CN", "LOC_RESULT_AGING_ROCKERS_DESCRIPTION",												"由于犯了大错，您的潮流组合的知名度一落千丈。为了不到处被人嘲讽，他们最终决定引退。"),

------ 属性文本

		("zh_Hans_CN", "LOC_ROCK_CONCERT_RESULT_ALBUMS",													"获得知名度"),
		("zh_Hans_CN", "LOC_UNITOPERATION_TOURISMBOMB_DESCRIPTION",											"您的潮流组合的经纪人期望从该巡演会场中产出{1_Tourism}点 [ICON_Tourism] 旅游业绩。[NEWLINE][NEWLINE]此届巡演成为他们引退前最终演出的可能性为：{2_Death}%。"),
		("zh_Hans_CN", "LOC_ROCK_CONCERT_RESULT_ALBUMS_TOOLTIP",											"[ICON_POPULARITY] 知名度的提升增加了该潮流组合在下一场巡演中可产出的基础 [ICON_Tourism] 旅游业绩。"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_LIT_TOP_TIER_ROCK_BAND_BUFF_DESCRIPTION",			"潮流明星+75 [ICON_POPULARITY] 知名度"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_LIT_TOP_TIER_ROCK_BAND_BUFF_DESCRIPTION",			"潮流明星+75 [ICON_POPULARITY] 知名度"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_LIT_BOTTOM_TIER_ROCK_BAND_BUFF_DESCRIPTION",		"潮流明星+25 [ICON_POPULARITY] 知名度"),
		("zh_Hans_CN", "LOC_EMERGENCY_REWARD_NOBEL_PRIZE_LIT_FIRST_PLACE_ROCK_BAND_BUFF_DESCRIPTION",		"潮流明星+50 [ICON_POPULARITY] 知名度"),
		("zh_Hans_CN", "LOC_POPULARITY_FROM_MUSIC",															"潮流明星作为巨作创作者+5 [ICON_POPULARITY] 知名度"),

------ 其他文本

		("zh_Hans_CN", "LOC_BOOST_TRIGGER_DIGITAL_DEMOCRACY",												"拥有一支潮流组合。"),
		("zh_Hans_CN", "LOC_BOOST_TRIGGER_LONGDESC_DIGITAL_DEMOCRACY",										"潮流明星文化的兴起让您的政治家寻求更多方式同那些有更高参与度与影响力的人们互动。"),
		("zh_Hans_CN", "LOC_ROCK_CONCERT_RESULT_PROMOTION_TOOLTIP",											"潮流组合可从随机提供的 [ICON_Promotion] 强化中选择其一，提升他们的能力以应对下一届巡回演出。"),
		("zh_Hans_CN", "LOC_UNITOPERATION_TOURISMBOMB_LOCATION",											"需要有效的目标位置。可能的位置包括奇观、拥有所需建筑的区域，或名人活动允许的特殊目标。"),
		("zh_Hans_CN", "LOC_UNIT_ROCK_BAND_DESCRIPTION",													"现代平民单位。需要广播中心才能购买。[NEWLINE][NEWLINE]可在有效场地进行明星巡演，包括世界奇观、拥有所需建筑的区域或潮流组合等级允许的特殊目标场地。他们的 [ICON_POPULARITY] 知名度可增加下一场明星巡演预期的 [ICON_Tourism] 旅游业绩。巡演结束后，他们的 [ICON_POPULARITY] 知名度和等级可能会增加。必须用 [ICON_Gold] 金币购买。不能在同一个单元格上巡演两次。"),
		("zh_Hans_CN", "LOC_UNITOPERATION_TOURISM_BOMB_DESCRIPTION",										"明星巡演"),
		("zh_Hans_CN", "LOC_UNITOPERATION_TOURISMBOMB_REQUIRES_NAME",										"您的潮流组合需要一个艺名才能进行明星巡演");

-- RockBand_GreatPeopleText.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																								Text)
VALUES

---- 伟人基本信息

		("zh_Hans_CN", "LOC_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_NAME",												"布莱恩·爱泼斯坦"),

---- 伟人能力/巨作

		("zh_Hans_CN", "LOC_LEU_GREATPERSON_CELEBRITY_POPULARITY_SUMMARY",													"潮流组合+{Amount} [ICON_Popularity] 知名度。"),
		("zh_Hans_CN", "LOC_LEU_GREATPERSON_FREE_CELEBRITY_SUMMARY",														"此城立即获得一支拥有“新闻报道” [ICON_Promotion] 强化的潮流组合。"),

---- 伟人百科
------ 布莱恩·爱泼斯坦

		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_1",		"布莱恩·爱泼斯坦是披头士乐队成功背后的原始经理和策划者，由于他在集团的商业事务、形象和全球知名度中所扮演的角色，他被称为“披头士乐队的第五位成员”。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_2",		"他于1934年9月19日出生在英国利物浦的一个犹太裔英国家庭，原名布莱恩·塞缪尔·爱泼斯坦。爱泼斯坦的家族拥有一家商店，保罗麦卡特尼的钢琴就是在那里购买的。读了三学期后，爱泼斯坦从伦敦皇家戏剧艺术学院（RADA）退学，在那里他是彼得·奥图尔的同学。回到利物浦后，他负责父亲商店的销售记录。他还在《默西之声》杂志上定期撰写专栏，宣传甲壳虫乐队。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_3",		"爱泼斯坦的商店就在洞穴俱乐部的街对面，在一些顾客在他的商店要求播放他们的单曲之后，他去看了披头士乐队的表演。爱泼斯坦被视为贵宾入场，并在俱乐部的公开声明中受到欢迎。他记得，“我立刻被他们的音乐、节奏和舞台上的幽默感所震撼。后来，当我遇到他们时，我再次被他们的个人魅力所震撼。就在那里，真的，一切都开始了。”他还认出披头士乐队的成员是他的NEMS唱片店的常客。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_4",		"1961年12月10日，他与披头士乐队及其非正式经理艾伦·威廉姆斯进行了一次会议，会议决定爱泼斯坦将管理乐队。1962年1月24日，四名成员在当时的鼓手皮特·贝斯特的家中签署了一份为期五年的管理合同。爱泼斯坦没有在上面签名，让音乐家们有选择的自由。当时麦卡特尼和哈里森都未满21岁，所以这个合同在理论上是不合法的。他们没有人意识到这一点，这对他们来说并不重要。重要的是他们对爱泼斯坦的信任。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_5",		"爱泼斯坦坚持要与披头士乐队签署唱片协议，即使被英国各大唱片公司拒绝，如哥伦比亚、飞利浦、金莺、德卡和派伊。爱泼斯坦与HMV技术员吉姆福伊一起将演示磁带转移到光盘上，他喜欢这首歌并将其推荐给帕洛风的乔治·马丁。除了皮特·贝斯特，约翰·列侬、保罗·麦卡特尼和乔治·哈里森通过了马丁的试镜。爱泼斯坦解雇了贝斯特，林戈·斯塔尔正式成为披头士的第四位成员。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_6",		"爱泼斯坦没有艺人管理经验，但他对他们形象进行的重大改进采取了正确的步骤。他们从蓝色牛仔裤和皮夹克换成西装，并规范了他们的舞台表演。他建议他们不要在公共场合吸烟或吃零食。爱泼斯坦在演出结束时指挥了著名的同步弓。爱泼斯坦对披头士形象的整体改进甚至改变了他们的外表，足以让当时的主流媒体和公众接受他们。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_7",		"爱泼斯坦注重细节，非常注重保持干净利落的形象，称他们为“男孩”，并管理着他们职业生涯、日常生活、音乐会演出和媒体露面的方方面面。他与乔治·马丁的私人友谊也很重要。通过将录音制作和曲目工作主要交给马丁来照顾，爱泼斯坦让自己能够获得其他艺术家管理合同。他成功地签约了格里和带头人、比利·J·克莱默和达科他、西拉·布莱克及其他艺术家。他的NEMS企业阵容扩大到签约了比吉斯、吉米·亨德里克斯和克利姆。"),
		("zh_Hans_CN", "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_BRIAN_EPSTEIN_CHAPTER_HISTORY_PARA_8",		"他是披头士乐队的创意成员，是一个多才多艺的人，性格好，记忆力敏锐，注重细节。英国军队对爱泼斯坦的良好品格评价是“清醒、认真、完全值得信赖”，尽管他因“无可救药的平民”而被免职，毕竟陆军使用一套不同于娱乐业的标准来判断一个人的性格。在那些日子里，他的同性恋倾向和对处方药（巴比妥酸盐）的依赖，再加上社会和法律限制的压力，让他痛苦不堪。1967年8月27日，他因吸毒过量去世。披头士乐队失去了团结他们的创意经理，很快就分道扬镳了。");

-- RockBand_PediaAdjustments.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES
		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_ROCK_BAND_CHAPTER_HISTORY_PARA_1",						"人们可以通过多种方式成为潮流明星（或更通俗地称呼为“名人”）：因为他们的职业属性，在媒体上的抛头露面，抑或完全就是偶然所致。术语“网红”即指那些在很短的时间内成为名人的人。获得少量短暂名气（例如通过炒作或大众媒体）的人可能会被贴上“B级名人”的标签。通常，这种概括适用于那些没有达到主流或持久名气但又试图扩大或利用它的人。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_ROCK_BAND_CHAPTER_HISTORY_PARA_2",						"多亏了诸如人物之类的出版物、明星和国家询问者之类的小报，以及名人和所谓的普通人都为公众消费而赤裸裸的生活的脱口秀，名人的他者感减弱了。特写镜头、名人故居之旅（例如由爱德华·R·默罗的电视节目“个人对个人”发起的那些）以及亲密采访（例如芭芭拉·沃尔特斯为电视台开创的那些节目）已经改变了公众的观念与名人的规模。尤其是美国人，通过视觉媒体，他们对名人有很深入的了解。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_ROCK_BAND_CHAPTER_HISTORY_PARA_3",						"潮流文化是一种共生的商业关系，表演者从中获得财富、荣誉和社会权力，以换取向观众“出售”亲密感。高薪是家常便饭。与广告收入相比，运动员的数百万美元合同相形见绌，篮球运动员迈克尔·乔丹对鞋类、软饮料、内衣和汉堡的宣传就是一个缩影。明星们也会在公共媒体活动中游行，因为他们获得了赛扬棒球奖、唱片明星格莱美奖和电影明星奥斯卡奖等荣誉和奖项。虽然很难衡量明星所获得的社会力量，但披头士约翰列侬关于“披头士乐队比耶稣更受欢迎”此类有争议的断言暗示了潮流文化某种意义上所孕育出的夸张名气。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITS_PAGE_UNIT_ROCK_BAND_CHAPTER_HISTORY_PARA_4",						"对于粉丝来说，潮流文化可以在摇滚音乐会、运动场和对其他幻想对象的展示中产生强烈的认同感，无论是现场直播还是录制。这种认同可能会导致角色倒转，粉丝渴望明星们的财富、荣誉和所谓的权力。"),

---- 强化：宣传摄影（奇观。至少两个自然段）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ALBUM_COVER_ART_CHAPTER_HISTORY_PARA_1",	"Photo op（有时写为photo opp），宣传摄影的缩写，是为政治家、名人或重要事件拍摄照片的安排好的机会；尤其是在标志性的位置——美国总统理查德·尼克松的政府。威廉·萨菲尔将其归功于尼克松新闻秘书罗恩·齐格勒的助手布鲁斯·惠利汉。齐格勒会说让他们进来拍照，惠利汉会尽职尽责地向白宫新闻发布室宣布，椭圆形办公室将有拍照机会。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ALBUM_COVER_ART_CHAPTER_HISTORY_PARA_2",	"该术语具有负面含义，指的是精心策划的伪事件，通常伪装成新闻。然而，随着会议和社交媒体的出现，名人采取一切措施来获取照片，以便在新闻媒体上发布，或者让他们在在线平台上获得更多影响力。"),

---- 强化：职业运动员（巡演会场。至少一个自然段）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ARENA_ROCK_CHAPTER_HISTORY_PARA_1",			"职业运动员以运动为生。通过多年的培训，他们在自己选择的领域取得了领先地位。职业运动员是具有天赋、耐力和竞争能力的人。他们具有出色的反应能力和协调能力，并且在严格的实践和培训方面纪律严明。职业运动员往往被体育迷视为名人，甚至为世界上最重要的运动员刷卡买单。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ARENA_ROCK_CHAPTER_HISTORY_PARA_2",			"大多数职业运动员都是从优秀的业余运动员行列中崛起的。业余运动员为了比赛和获胜的乐趣而比赛，偶尔也会为了奥运奖牌等奖项而比赛。有些人为学校、大学、俱乐部或比赛打球。然而，与业余爱好者不同，职业运动员通过体育运动赚钱。他们为盈利团队效力——职业足球、棒球、篮球和曲棍球队等等。在包括高尔夫、网球和拳击在内的个人运动中，运动员参加比赛，比赛中获胜者获得奖金。"),

---- 强化：音乐剧（剧院广场。至少一个自然段）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_GLAM_ROCK_CHAPTER_HISTORY_PARA_1",			"音乐剧是一种集歌曲、口语、表演和舞蹈为一体的戏剧表演形式。音乐剧的故事和情感内容——幽默、悲情、爱、愤怒——通过文字、音乐、动作和娱乐的技术方面作为一个整体来传达。虽然音乐剧与歌剧、舞蹈等其他戏剧形式有重叠，但与对白、动作等元素相比，音乐同样重要。自20世纪初以来，音乐剧舞台作品一般被简单地称为音乐剧。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_GLAM_ROCK_CHAPTER_HISTORY_PARA_2",			"虽然音乐自古以来就是戏剧表演的一部分，但现代西方音乐剧在19世纪才出现，其中许多结构元素由英国的吉尔伯特和沙利文的作品以及美国的哈里根和哈特的作品建立。紧随其后的是众多爱德华时代的音乐喜剧以及20世纪之交乔治·M·科汉等美国创作者的音乐剧作品。公主剧院的音乐剧（1915-1918）和像为君而歌（1931）这样的精彩节目是20世纪早期的喜剧和其他泡沫娱乐之外的艺术进步，并造就了诸如演艺船（1927）和俄克拉荷马（1943）之类的开创性作品。随后几十年中最著名的音乐剧包括《西区故事》（1957）、《幻想曲》（1960）、《头发》（1967）、合唱团（1975）、悲惨世界（1985）、歌剧魅影（1986）、吉屋出租 (1996)、金牌制作人 (2001)、魔法坏女巫 (2003) 和汉密尔顿(2015)。"),

---- 强化：新闻报道（旅游业绩领域。至少一个自然段）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_GOES_TO_CHAPTER_HISTORY_PARA_1",			"名人世界和大众媒体在一种既互利又具有破坏性的关系中密不可分。名人文化在媒体中根深蒂固。没有它从媒体获得的宣传，它就不会存在，如果没有它与媒体的持续关系，它肯定不会像今天这样突出。媒体也从中受益，因为它对名人世界的不断更新使其能够吸引大量公众的注意力。媒体在试图吸引和保持公众注意力时，在对待名人时往往非常喜怒无常。它将它们建立起来，以便将来可以将它们拆除。这可以从布兰妮斯皮尔斯和迈克尔杰克逊等人物身上看出。例如，布兰妮·斯皮尔斯 (Britney Spears) 在她成功的巅峰时期获得了大量的人气和良好的媒体关注。在她的职业生涯一落千丈之后，比如 2007 年她剃光头的事件，媒体随后锁定了她是一个不稳定人物的想法，这使得他们能够以这种方式报道她，并继续围绕她制作内容，尽管她作为艺术家的受欢迎程度下降（请参阅相关视频，了解因斯皮尔斯的发型变化而引起铺天盖地的媒体报道）。同样，迈克尔杰克逊，随着他作为艺术家的知名度下降，媒体不再以积极的眼光描绘他，转向消极的焦点以保持公众的关注。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_GOES_TO_CHAPTER_HISTORY_PARA_2",			"名人世界和大众媒体在一种既互利又具有破坏性的关系中密不可分。名人文化在媒体中根深蒂固。没有它从媒体获得的宣传，它就不会存在，如果没有它与媒体的持续关系，它肯定不会像今天这样突出。媒体也从中受益，因为它对名人世界的不断更新使其能够吸引大量公众的注意力。媒体在试图吸引和保持公众注意力时，在对待名人时往往非常喜怒无常。它将它们建立起来，以便将来可以将它们拆除。这可以从布兰妮斯皮尔斯和迈克尔杰克逊等人物身上看出。例如，布兰妮·斯皮尔斯在她成功的巅峰时期获得了大量的人气和良好的媒体关注。在她的职业生涯一落千丈之后，比如2007年她剃光头的事件，媒体随后锁定了她是一个不稳定人物的想法，这使得他们能够以这种方式报道她，并继续围绕她制作内容，尽管她作为艺术家的受欢迎程度下降。同样，迈克尔杰克逊，随着他作为艺术家的知名度下降，媒体不再以积极的眼光描绘他，转向消极的焦点以保持公众的关注。"),

---- 强化：反主流文化意象（忠诚度）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_INDIE_CHAPTER_HISTORY_PARA_1",				"反文化是一个社会政治术语，表示主导或主流意识形态与替代价值体系之间的分歧点，因此创造了可以被视为重要少数群体的集体声音。反文化运动出现在1960年代中期，作为中产阶级青年运动中年轻人的自我称呼，因为政治与文化问题融合在一起。种族主义、高等教育机构与军方和企业界勾结支持越南战争的问题，以及学院和大学的本地父母法规与头发长度、公共生活、音乐品味、吸毒、性别角色的斗争和性问题等融合在一起。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_INDIE_CHAPTER_HISTORY_PARA_2",				"随着时代的变迁，出现了新的文化形式和充满活力的亚文化，它们庆祝实验、波西米亚主义的现代化身，以及嬉皮士和其他另类生活方式的兴起。这种对创造力的拥抱在披头士乐队和鲍勃·迪伦等音乐剧以及新好莱坞电影制片人的作品中尤为明显，他们的作品受到审查制度的限制要少得多。在许多学科内和跨学科，许多其他有创造力的艺术家、作家和思想家帮助定义了反文化运动。日常时尚经历了西装的衰落，尤其是帽子的佩戴；以牛仔裤为基础的款式，无论男女，成为一种重要的时尚运动，一直持续到今天。"),

---- 强化：环保主义者（自然奇观）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_MUSIC_FESTIVAL_CHAPTER_HISTORY_PARA_1",		"环保主义者是可以通过改变公共政策或个人行为来谈论我们的自然环境及其资源的可持续管理的人。这可能包括支持诸如知情消费、保护倡议、投资可再生资源、提高材料经济效率、过渡到新的会计范式（如生态经济学）、更新和振兴我们与非人类生活的联系，甚至选择少一个孩子，以减少消耗和资源压力。环保主义者和环保组织以各种方式（例如，草根激进主义和抗议活动）寻求在人类事务中让自然世界有更强的发言权。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_MUSIC_FESTIVAL_CHAPTER_HISTORY_PARA_2",		"近几十年来，名人对环境事业的倡导急剧增加。国际环保组织、海洋环境保护组织、伊恩·萨默海尔德基金会和海湾环保组织等组织由敬业的环保主义者以及名人创始人和支持者组成。随着社交媒体和新数字环境的出现，名人对环境和慈善事业的代言范围扩大了，因为名人以公共方式做出贡献或支持的能力变得像在手机上用手指轻敲屏幕一样简单。"),

---- 强化：魅力（金币）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_POP_CHAPTER_HISTORY_PARA_1",				"魅力是一种特别奢华或优雅的外表所产生的吸引或迷恋的印象，一种强化现实的印象。通常，一个人、事件、地点、技术或产品（例如一件衣服）可以是迷人的或增添魅力。“魅力”最初指的是一种魔法咒语，一种据说是由女巫施展的幻觉。 好莱坞电影公司在银幕上和精心策划的宣传场合中展示了身着设计师礼服和精美珠宝的女明星。引用琼·克劳馥的话说，“除非我看起来像电影明星琼·克劳馥，否则我从不出门。”"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_POP_CHAPTER_HISTORY_PARA_2",				"普遍观点认为名人具有魅力，因其会以更加独特、更加奢侈的方式度过日常。火爆的维鲁什卡婚礼，是B-Town迄今为止最华丽的婚礼。从选址到装修，再到着装，再到花费巨额的资金，都和普通男人的婚礼不一样。所有这些因素结合在一起，以前所未有的方式点燃了板球和宝莱坞联盟的好奇心。只要粉丝对他们的生活方式感兴趣，名人的地位就会保持不变，而这种好奇心是由魅力确保的。魅力是名人生活方式中最重要的事情，因为魅力一旦消失，好奇心就会消失，因此所有围绕名人的炒作也随之消失。他们拥有的就是我们想要的，这一事实使名人的生活方式变得迷人。无论我们的房子有多大，我们有多喜欢它，如果有机会住在安蒂拉，穆克什·安巴尼价值数十亿美元的房子，我们都会立刻抓住它。"),

---- 强化：鳄鱼猎人（水上乐园）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_REGGAE_ROCK_CHAPTER_HISTORY_PARA_1",		"鳄鱼猎人是一部野生动物纪录片电视连续剧，由史蒂夫欧文和他的妻子特丽主持。由于欧文对野生动物的非传统方式，该节目非常受欢迎。它催生了许多独立的项目，包括故事片鳄鱼猎人：碰撞课程和两个电视衍生产品：鳄鱼档案和鳄鱼猎人日记。该系列在动物星球上播出，成为当时网络收视率最高的系列，并在全球网络上传播。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_REGGAE_ROCK_CHAPTER_HISTORY_PARA_2",		"该节目非常成功，以至于它变成了一个名为《鳄鱼猎人》的系列，这就是欧文获得这个绰号的原因。这部由欧文和特丽主持的电视连续剧在国际上播出，在世界各地的野生动物爱好者中大受欢迎。除了电视作品，他也出现在国际聊天节目中，在电影中扮演客串角色，并展示其他野生动物节目，欧文继续对他父母创办的野生动物园进行改进和扩建。 迈出的一大步是1998年将其更名为澳大利亚动物园。欧文的“通过令人兴奋的教育进行保护”的方法在他工作的每一个方面都得到采用，欧文希望有一天他的公园能够成为世界上最好的动物园。家庭也是欧文生活的重要组成部分，他与特丽分享了他与两个孩子宾迪和罗伯特对野生动物的热爱，他们看起来好像要追随父亲的脚步。"),

---- 强化：电视布道（宗教传播）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_RELIGIOUS_ROCK_CHAPTER_HISTORY_PARA_1",		"电视布道是使用媒体，特别是广播和电视，来传播基督教。电视布道者是部长，无论是官方的还是自称的，他们将大部分事工投入电视广播。一些电视布道家也是他们自己礼拜场所（通常是大型教会）的常规牧师或牧师，但他们的大多数追随者来自电视和广播观众。其他人没有传统的会众，主要通过电视工作。这个词也被批评者嘲弄地用来暗示这些部长的强化。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_RELIGIOUS_ROCK_CHAPTER_HISTORY_PARA_2",		"电视布道开始是一种独特的美国现象，这是由于媒体在很大程度上放松管制，几乎任何负担得起的人都可以使用电视网络和有线电视，再加上能够提供必要资金的大量基督徒人口。它在福音派新教听众中特别受欢迎，无论是独立的还是围绕基督教教派组织的。然而，广播的日益全球化使一些美国电视布道者能够通过国际广播网络接触到更广泛的受众，包括一些具有基督教性质的广播网络，如三一广播网络和上帝频道。巴西等其他一些国家越来越多地采用国产电视节目布道。"),

---- 强化：私人飞机（移动力）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ROADIES_CHAPTER_HISTORY_PARA_1",			"商务喷气式飞机、私人喷气式飞机或商务喷气式飞机是一种专为运送小团体而设计的喷气式飞机。公务机可能适用于其他角色，例如疏散伤员或快递包裹，有些被公共机构、政府官员或武装部队使用，以及名人作为VIP生活方式的一部分。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_ROADIES_CHAPTER_HISTORY_PARA_2",			"在许多方面，私人飞机客舱的奢华布置让人回想起1940年代最早的商业客机上的管家为穿着燕尾服的乘客提供服务的魅力。虽然商业航空旅行变得更加便利，现在几乎任何人都可以穿着运动服和运动鞋享受冷漠的服务，但私人飞机旅行提供了回归的魅力和奢华——更快的速度和机上的Wi-Fi。所有这些都非常符合弗兰克·辛纳屈的口味，他同样欣赏长途飞行中机上娱乐的发展。从1925年第一次机上电影放映（从伦敦起飞的无声电影《失落的世界》），到21世纪乘客触手可及的个人屏幕，我们在空中自娱自乐的方式经历了与推动我们的飞机在天空中飞行的发动机一样多的进步和创新。私人包机航班继续提高标准，Wi-Fi速度允许直播，机舱足够宽敞，可以在旅行时携带健身器材锻炼身体。"),

---- 强化：科学怪侠（学院与宇航中心）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_SPACE_ROCK_CHAPTER_HISTORY_PARA_1",			"比尔教科学是由迪士尼与美国国家科学基金会联合推出的科教节目，它得到了美国国家科学基金会的大量资助。在制片人与博伟电视台签订发行协议后，比尔·奈饰演了一位穿着蓝色实验室外套和领结的身材高大、身材苗条的科学家。他将日常事物的严肃科学与快节奏的动作和幽默相结合。每集半小时的节目都以暖场表演为始，奈在其中介绍了剧集主题，并在电脑特效般的科学世界中展示自己，包括他头部的旋转；还展示了无线电频率和飞行的塑料玩具恐龙。对科学相关的电视和电影恶搞组成了剧集的实际主题，还有对电视广告的恶搞。该节目邀请了许多嘉宾。每集的特色是奈访问了许多与该集主题相关的地方，展示了人们谈论他们的工作和其他贡献的采访。在每集的结尾，奈感谢观众的收看，然后巧妙地描述了本次主题的活动。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_SPACE_ROCK_CHAPTER_HISTORY_PARA_2",			"在美国，比尔·奈启发了整整一代科学家和科学爱好者。该节目获得了23项艾美奖提名，并赢得了其中的19项。从教育的角度来看，它也奏效了。在美国的小学和中学，该节目经常在教师休假的日子里取代科学课——这是奈在2017年纪录片《比尔·奈：科学家》中的美国国家科学教师协会年会上开玩笑说的。"),

---- 强化：海滩派对（港口与海滨度假区）

		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_SURF_ROCK_CHAPTER_HISTORY_PARA_1",			"海滩派对是1960年代冲浪文化的一部分。1960年代南加州冲浪文化覆盖各个方面，包括伍迪、比基尼和其他沙滩装，如短裤或袋子，以及冲浪音乐。最终，他们创造了海滩派对类型，该类型专注于通过使用冲浪文化元素和无忧无虑的吸引力向当时的青少年进行营销。"),
		("zh_Hans_CN", "LOC_PEDIA_UNITPROMOTIONS_PAGE_PROMOTION_SURF_ROCK_CHAPTER_HISTORY_PARA_2",			"海滩派对电影是1960年代中期流行的一种电影子类型，从1963年弗兰基·阿瓦隆/安妮特·富尼塞洛热播海滩派对开始。1960年代共有几十部影片被归类为海滩派对类型。它们中的大多数是低成本的B级电影，几乎都是喜剧，它们依赖于愚蠢的情节、青少年趋势、浪漫的故事情节、音乐表演和一种诙谐的影射喜剧风格。它们沉默、明亮、色彩缤纷、富有音乐感。它们在1960年代吸引了无忧无虑的人们，并在观众中取得了意想不到的成功。");

-- RockBand_JNRCompatibilityTexts.sql文件
---- 原模组为兼容 JNR 的 District Expansion: Theater 模组所做的改动，故添加条件语句，只有 District Expansion: Theater 模组 启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_ROCK_BAND_DESCRIPTION",
		"zh_Hans_CN",
		"现代平民单位。需要文化区的最高阶建筑才能购买。[NEWLINE][NEWLINE]可在有效场地进行明星巡演，包括世界奇观、拥有所需建筑的区域或潮流组合等级允许的特殊目标场地。他们的 [ICON_POPULARITY] 知名度可增加下一场明星巡演预期的 [ICON_Tourism] 旅游业绩。巡演结束后，他们的 [ICON_POPULARITY] 知名度和等级可能会增加。必须用 [ICON_Gold] 金币购买。不能在同一个单元格上巡演两次。"
WHERE EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_LIBERAL_ARTS_NAME");