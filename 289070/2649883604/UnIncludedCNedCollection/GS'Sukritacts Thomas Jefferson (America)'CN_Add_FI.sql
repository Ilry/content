-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Sukritacts Thomas Jefferson (America)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/29 7:47:41
-------------------------

-- 该文件对应补译/润色模组 “Sukritact's Thomas Jefferson (America)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES
		("zh_Hans_CN",	"LOC_LEADER_SUK_T_JEFFERSON_NAME",											"托马斯·杰斐逊"),

---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_LOUISIANA_PURCHASE_NAME",								"路易斯安那购地"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_LOUISIANA_PURCHASE_DESCRIPTION",						"购买单元格消耗的 [ICON_Gold] 金币减少40%。拥有图书馆的城市境内所有未改良的单元格产出+1 [ICON_Gold] 金币、+1 [ICON_Science] 科技值；若城市拥有大学，则改为+1 [ICON_Gold] 金币、+2 [ICON_Science] 科技值。触发 [ICON_TechBoosted] 尤里卡或解锁一项科技可获得 [ICON_Favor] 外交支持。"),

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_LOUISIANA_PURCHASE_EUREKA",							"+{1} [ICON_Favor] 外交支持 来自触发科技“{2}”的 [ICON_TechBoosted] 尤里卡"), 

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_LOUISIANA_PURCHASE_RESEARCH",							"+{1} [ICON_Favor] 外交支持 来自解锁科技“{2}”"), 

---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_SUK_JEFFERSONIAN_DEMOCRACY_NAME",								"杰斐逊民主"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_JEFFERSONIAN_DEMOCRACY_DESCRIPTION",						"不喜欢在城市中建造很多专业化区域的文明，除非他的 [ICON_Science] 科技值很高。喜欢 [ICON_Science] 科技值高且少建造专业化区域的文明。"),

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_T_JEFFERSON_REASON_ANY",							"（您专注于科技且城市内的特色区域较少）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_JEFFERSONIAN_DEMOCRACY_KUDO",						"杰斐逊的灵感来自您不拥挤的城市和受过教育的民众。"),

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_T_JEFFERSON_REASON_ANY",						"（您在努力建造城市，却忽视了科技值）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_JEFFERSONIAN_DEMOCRACY_WARNING",					"杰斐逊对你拥挤的城市和没有受过教育的公民感到不安。"),

---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_T_JEFFERSON",									"托马斯·杰斐逊，您是美国独立宣言的起草者，您有责任确保共和国继续蓬勃发展。在您的帮助下，国家将迅速扩张并建立新的城市。在您的指导下，人民将变得博学多才。让人民的美德与可靠为您指明道路，美国永远不会动摇。" ),

---- 对白
------ 初次见面

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_T_JEFFERSON_ANY",							"我，托马斯·杰斐逊，作为美国正式选定的代表向你致意。愿美国与您的政府保持友好关系。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_T_JEFFERSON_ANY",			"每年这个时候都是蒙蒂塞洛最舒适的时期。如果你想看看我的国家，我很乐意接待你。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_T_JEFFERSON_ANY",	"美国接受你的慷慨提议。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_T_JEFFERSON_ANY",	"分享我们首都的信息是建立良好外交关系的好方法，你也同意这一点吧？"),

------ 议程对白

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_T_JEFFERSON_ANY",							"我认为教育是促进人类美德和幸福最重要的手段。很高兴看到您遵循着相同的理念。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_T_JEFFERSON_ANY",						"臃肿的城市和无知的公民对人类的道德和自由是有害的。为什么这些会是你们政府的标志？"),

------ 战争与和平		
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",				"美国的独立来之不易。我们的人民不会落入你这种人之手！"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",					"我们的共和国不能容忍暴君。我将为保护我和我们同胞的自由而战！"),

-------- 求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_T_JEFFERSON_ANY",			"我们的共和国欢迎和平。愿它持续下去。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_T_JEFFERSON_ANY",			"虽然不公正仍然存在，但战争必须继续。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",					"我们的同胞遭受了巨大的痛苦。让我们寻求结束这场战争的方法。"),

-------- 战败	
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",						"历史的一章就这样结束了。我真希望我没有活着看到这一天。"),

------ 宣布友谊

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",				"如果您愿意，美国视您为她的朋友之一。"),

-------- 玩家接受或拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",		"太棒了。让我带些酒来庆祝一下。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",		"不幸的是我不能答应。尽管如此，愿我们继续保持友好的关系。"),

-------- AI接受或拒绝

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",	"任何自由的朋友都是美国的朋友。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",	"我希望再观望一段时间，看看我们的利益是否一致。"),

------ 代表团	

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",					"我已派出一个代表团作为美国善意的表示。为了表达我的尊重，我还给您带来了我制作的转椅模型。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",		"谢谢你给美国的礼物。愿这是我们之间友好关系的开始。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",		"不幸的是，我现在得处理一些内部事务。或许下次吧。"),

------ 谴责

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",					"这些话来自像你这样的暴君？这真是一场闹剧。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",					"你给予你同胞的待遇是非常离谱的。我无法理解为什么你的人民没有推翻你。[NEWLINE]（谴责你）"),

------- 结盟

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",				"美国一直在寻求与那些坚持自由的人结盟。我认为你会在这方面成为一个很好的盟友。"),

------ 其他对白

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_T_JEFFERSON_ANY",							"美好的一天。"),

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",			"我不能同意这些条款。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",			"太好了，我会起草一份文件让我们签字。"),

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_T_JEFFERSON_ANY",				"知识和财富是相辅相成的。为了促进这些事情，美国寻求与你们开放边界"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",		"我们可能会从彼此间学到很多……而且商业机会是巨大的……是的，我同意这一点。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_T_JEFFERSON_ANY",		"不，我不能将我国家的主权置于一个我不完全信任的政治实体上。"),

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_T_JEFFERSON_ANY",		"面对这种侮辱，美国不会袖手旁观。请把你的部队从我们的边界转移出去。"),

------ 引言与百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_T_JEFFERSON_QUOTE",								"教育将告知全体人民：知识是维护我们自由的唯一可靠依据。" ),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_T_JEFFERSON_TITLE",								"托马斯·杰斐逊"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_T_JEFFERSON_SUBTITLE",							"托马斯·杰斐逊，美国开国元勋，美国第三任总统"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_CAPSULE_BODY",		"杰斐逊领导的美国旨在扩大领土和研究科技。大片未改良的土地可以成为美国最大的恩赐之一。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_DETAILED_BODY",		"美国早期游戏最突出的奖励可能是他们大幅降低的单元格购买费用。尽早扩张并尽可能多地占领领土。 杰斐逊的图书馆将确保任何未经改善的单元格仍然有利可图，并且当建造国家公园时，这项奖励将与国家公园协同增效。随着外交政策槽位变成通配符槽位，他们对政体的选择非常重要；与杰斐逊的特殊能力相结合，他们将成为一个强大的外交玩家。凭借他们的电影制片厂和特色单位，他们将从20世纪开始大放异彩。"),		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_1",		"律师、父亲、科学家、作家、州长、副总统、总统、哲学家、建筑师、奴隶主。虽然有很多词来形容托马斯·杰斐逊，但最令人难忘的是作为《独立宣言》的起草者和美国第三任总统。早年生活帮助杰斐逊塑造了他的职业生涯和成就。他于1743年4月13日出生于弗吉尼亚州中部的沙德维尔种植园，奴隶在那里种植烟草。他是农民兼测量师彼得·杰斐逊和弗吉尼亚一个著名家庭的女儿简·兰道夫的孩子，排行第三。他的父亲在杰斐逊14岁时去世，留给他的是对书籍、数学和户外活动的热爱。杰斐逊开始学习拉丁语、希腊语和法语。1760年，他进入弗吉尼亚州威廉斯堡的威廉与玛丽学院。他喜欢每天学习十五个小时。毕业后，他学习法律，并于1767年取得律师资格。他从业多年，被描述为“身材高大、关节松散、棕褐色头发和雀斑”的男人，是一位技艺精湛的骑手和天才的音乐家。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_2",		"当他的父亲去世时，杰斐逊继承了大约三千英亩的土地和三十个奴隶。后来他从岳父那里继承了更多的土地和奴隶。当杰斐逊26岁时，奴隶们开始建造蒙蒂塞洛（在意大利语中意为小山）。房子、花园、工作农场和工作室都是由杰斐逊设计的。杰斐逊是一个5000英亩种植园的负责人。它由被分成四个片区的农场和大约200名奴隶组成。奴隶们在蒙蒂塞洛及其周围进行各种强迫劳动，种植烟草和小麦，并以其他方式巩固种植园。五十年来，种植园的照料和建设占据了杰斐逊的注意力和想象力。他记录了在蒙蒂塞洛发生的一切。这包括关于他买卖什么的笔记，他在种植园观察到的情况，以及他给奴隶的口粮。他被描述为“天气观察者之父”，记录每日降雨量和温度，并记下园艺日记。这些记录是关于蒙蒂塞洛生活的宝贵信息。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_3",		"1772年元旦，杰斐逊与寡妇玛莎·韦尔斯·斯克尔顿结婚。玛莎是一位“非常讨人喜欢的明智且富有成就的女士”。她带来了土地、奴隶和她父亲的债务。在他们结婚的十年里，杰斐逊一家有六个孩子。两个女儿和一个儿子在婴儿时期就夭折了。两岁的露西死于百日咳。两个女儿玛莎和玛丽亚则活到成年。1782年，他的妻子玛莎去世，留下三个女儿玛莎、玛丽亚和露西。杰斐逊因妻子的去世而悲痛欲绝。他成为了女儿们的好父亲，从未再婚。杰斐逊后来与一位名叫莎莉·海明斯的女人生了至少六个孩子。她在蒙蒂塞洛被杰斐逊奴役，他们四个幸存的孩子也被奴役直到他们成年。贝弗利和哈丽特是最年长的两个，他们在没有被父亲正式释放的情况下离开了蒙蒂塞洛。麦迪逊和埃斯顿是最小的两个，他们的父亲在他去世时释放了他们。他们的母亲莎莉·海明斯没有被释放，但她被允许与她的儿子在夏洛茨维尔度过余生。杰斐逊和海明斯从未写过他们的关系，但他们的儿子麦迪逊海明斯和其他住在或访问过蒙蒂塞洛的人写过。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_4",		"1775年, 杰斐逊当选为大陆会议议员。他被选中成为《独立宣言》的主要起草人。该文件阐明了个人权利和自由以及人的平等的重要性。它宣布被殖民者想要摆脱英格兰国王统治的原因。杰斐逊相信《独立宣言》的理念，但他一生奴役了600多人。这是关于杰斐逊的一个很大的复杂性问题。他和他的同龄人对不是白人的人有偏见，这些错误的想法助长了他们为奴役辩护的理由。杰斐逊认为每个人都应该有信仰任何宗教的自由，因此他起草了《弗吉尼亚宗教自由法》，确立了弗吉尼亚的宗教自由。25年后的1786年，该法案正式通过。杰斐逊于1779年至1781年担任弗吉尼亚州州长。他当选时，美国人民已经进行了四年的独立战争。任期结束后，他回到蒙蒂塞洛并照料他的种植园。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_5",		"1785年，杰斐逊被任命为法国公使。在国王统治的法国生活的五年里，他看到了底层阶级的贫困。这坚定了他的民主信念。他还热爱法国文化，并将书籍、种子、艺术和科学仪器送回蒙蒂塞洛。杰斐逊于1789年离开法国。乔治华盛顿总统任命他为新政府下的第一任国务卿。在1796年的总统选举中，杰斐逊输给了约翰·亚当斯。得票第二高的杰斐逊成为副总统。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_6",		"四年后，杰斐逊成为了美国总统。1800年，他以民主共和党代表的身份与联邦党人约翰·亚当斯竞选总统，并获胜。杰斐逊连任了两届。在他担任总统期间，他策划了路易斯安那购地案，为美国增加了827000平方英里的领土。他派刘易斯和克拉克去探索西部土地并收集信息。在旅途中，他们遇到了40多个美洲原住民部落，这些部落的人们在那里生活了数千年。在杰斐逊担任总统期间，英法之间的冲突不断加剧。杰斐逊试图让美国保持中立，但与英国的关系变得更糟。作为回应，杰斐逊颁布了1807年的禁运法案，禁止美国船只在所有外国港口进行贸易。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_T_JEFFERSON_CHAPTER_HISTORY_PARA_7",		"杰斐逊就任总统后一直很忙。他设计并创立了弗吉尼亚大学，还担任其第一任校长。他在蒙蒂塞洛的家人陪伴中度过晚年。在那里，他可以自由地追求自己对天文学、阅读、园艺、设计和园林绿化的兴趣。杰斐逊于1826年7月4日在蒙蒂塞洛去世，享年八十三岁。这一天也是《独立宣言》通过五十周年。因为杰斐逊负债累累，他的房子、土地和大部分财产都被卖掉了。他在遗嘱中释放了他被奴役的儿子和另外三个人，但其他130名奴隶在拍卖会上被卖掉了。在他的墓志铭上，杰斐逊希望人们记住他给予美国人民最重要的东西（至少在他眼中是这样）：“托马斯·杰斐逊——《美国独立宣言》、《弗吉尼亚宗教自由法》的起草者和弗吉尼亚大学之父，安葬于此。”");






