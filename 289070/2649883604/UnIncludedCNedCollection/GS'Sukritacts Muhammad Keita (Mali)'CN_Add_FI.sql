-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Sukritacts Muhammad Keita (Mali)'CN_Add_FI
-- Author: Clear8Sky
-- DateCreated: 2021/9/13 15:54:07
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Muhammad Keita (Mali)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES
		("zh_Hans_CN",	"LOC_LEADER_SUK_MANSA_MUHAMMAD_NAME",											"穆罕默德·凯塔"),

---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_EDGE_OF_THE_ATLANTIC_NAME",								"大西洋的界线"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_EDGE_OF_THE_ATLANTIC_DESCRIPTION",						"游戏开始时位于海洋单元格中，游戏初始便解锁“航海术”与“造船术”科技，同时拥有进入海洋单元格的能力。上船单位+2 [ICON_Movement] 移动力。在您的首都建立之前，每回合+25 [ICON_Gold] 金币。当友方商人首次进入或靠近帝国境内的海岸地形时，其可获得+1 [ICON_Gold] 金币；进入或靠近沙漠地形时，其可获得+2 [ICON_Gold] 金币和+1 [ICON_Food] 食物。可用 [ICON_Gold] 金币购买 [ICON_Capital] 首都城市内的区域。"),

---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_SUK_MANSAS_AMBITION_NAME",											"穆罕默德国王的野心"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_MANSAS_AMBITION_DESCRIPTION",									"讨厌那些比他探索更多地图、比他 [ICON_Gold] 金币储备更多的文明。喜欢在地图探索、追求 [ICON_Gold] 金币最大化方面不与其形成竞争的文明。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_MANSA_MUHAMMAD_REASON_ANY",							"（您没有在地图探索或金币储备中同他竞争）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_MANSAS_AMBITION_KUDO",									"穆罕默德很高兴您没有在地图探索与金币储备中与他竞争。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_MANSA_MUHAMMAD_REASON_ANY",						"（您正与他在地图探索与金币储备方面形成竞争）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_MANSAS_AMBITION_WARNING",								"穆罕默德很生气您在地图探索与金币储备中同他进行竞争。"),

---- 载入

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_MANSA_MUHAMMAD",									"阿布贝克尔二世之侄，穆罕默德国王，您远离故土，探索未知，去寻找世界的尽头。尽管历程中皆是艰难与险阻，但同样也充满了无限可能。在一片新大陆上重建马里帝国，让贸易与财富涌向您的王国。人民的命运将掌握在勇敢的您手中。"),

---- 对白
------ 初次见面

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_MANSA_MUHAMMAD_ANY",							"我是穆罕默德·伊本·曲，马里文明的领袖，寻求未知的探险家。请告诉我，你是谁？"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_MANSA_MUHAMMAD_ANY",			"我愿意让你在我的城市里稍作休息，以便有机会能更好地了解彼此。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_MANSA_MUHAMMAD_ANY",	"感谢您的热情款待。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"我想更多地了解这个世界，让我们互相交换首都的位置吧。"),

------ 议程对白

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_MANSA_MUHAMMAD_ANY",							"您没有挑战马里的卓越地位，这样很好。没人希望在财富与求知上与我们竞争。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_MANSA_MUHAMMAD_ANY",							"财富与知识是我最大的雄心壮志。但遗憾的是，你阻碍了它们。"),
		
------ 战争与和平		
-------- 受到宣战后回应
	
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",				"战争？你认为你那可怜的军队可以对抗马里的财力吗？"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",					"你不尊重我的威名。你不尊重马里帝国。你的罪孽必然会受到惩罚！"),

-------- 求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_MANSA_MUHAMMAD_ANY",			"和平，带来复苏。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_MANSA_MUHAMMAD_ANY",			"不，我并不满意。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",					"尽管我确有能力继续进行这场战争，但我还是希望它能结束。"),

-------- 战败	
		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",						"怎会如此？我怎会输给你这样的人！？"),

------ 宣布友谊

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",				"我相信友谊对我们双方都有好处。"),

-------- 玩家接受或拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"我很高兴您能同意。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"我很失望，但顺其自然吧。"),

-------- AI接受或拒绝

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"嗯……听起来还可以，那就让我们和平相处吧。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"哼！你以为你能轻易地索得我的友谊？你必须给出足够的筹码！"),

------ 代表团	

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",					"我派出了一支代表团，给您带去了一些书籍与马里棉布，还有不少金子。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",			"感谢您的礼物，它们很受欢迎。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",			"马里帝国不需要这些不值钱的小玩意儿。"),

------ 谴责

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",					"你以为我会在乎你的意见吗？可笑。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",						"我不清楚有谁会觉得你适合当统治者，但我对他们的判断心存质疑。[NEWLINE]（谴责你）"),

------- 结盟

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",				"您是少数几个我考虑与之结盟的人之一，您愿意受此殊荣吗？"),

------ 其他对白

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_MANSA_MUHAMMAD_ANY",								"欢迎。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",				"哦不，请您再想想。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",				"嗯，这提议看起来可以接受。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_MANSA_MUHAMMAD_ANY",					"让我们秉持友谊和贸易态度，开放双方的边界吧！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"马里为您提供庇护与安全通道。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"请容我拒绝，我不会只为你的请求而使我的人民蒙危。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_MANSA_MUHAMMAD_ANY",		"你想亲眼一见我的财富？那我觉得你应该派遣商队而非军队。除非，你另有打算？"),

------ 引言与百科

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_MANSA_MUHAMMAD_QUOTE",								"我并不认为要到达环绕地球的海洋之彼岸是无谓的妄想。"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_MANSA_MUHAMMAD_TITLE",								"穆罕默德·凯塔"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_MANSA_MUHAMMAD_SUBTITLE",							"默罕默德·伊本·曲国王。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_MANSA_MUHAMMAD_CHAPTER_CAPSULE_BODY",		"穆罕默德·凯塔的城市富甲一方，其也因此能够建立起一个强大的沙漠帝国。从海洋开启他的文明又为其额外增添了一些灵活性与难度。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_MANSA_MUHAMMAD_CHAPTER_DETAILED_BODY",		"马里十分专注于金币的产出，加上优惠购买的能力，其能够快速发展城市。在沙漠中开拓时马里还能够获得大量加成，能让荒凉破败之处变得欣欣向荣。穆罕默德的能力可让他能花更多时间去寻找合适的定居点。寻找一块海产丰富、或临近沙漠矿产资源的地方，使马里文明的加成获得最大化利用。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_MANSA_MUHAMMAD_CHAPTER_HISTORY_PARA_1",		"人们对马里帝国的第八位曼沙（意为统治者）——国王穆罕默德·伊本·曲知之甚少。当著名的曼沙·穆萨在开罗停歇逗留之时，我们通过他与其当时住处的房东阿布·哈桑·阿里·伊本·阿米尔·哈比卜之间的对话，了解到了一些曾经鲜为人知的事情。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_MANSA_MUHAMMAD_CHAPTER_HISTORY_PARA_2",		"在这段有记载的对话中，穆萨讲述了他如何成为马里帝国的国王：“我的前任国王并不认为到达环绕地球之洋（即大西洋）的彼岸是不可能的事，他想去到达那里，还硬要坚持作谋划和准备。他为此准备了两百艘载满人的船，如同其他许多满载金子、淡水和食物的船一样，这些东西足以维持船上的人生存好几年。他命令海军首领，让他们在到达大洋彼岸或耗尽船上补给与淡水前不准回来。他们就这样出发了。在销声匿迹了很长一段时间后，最终只有一艘船归来。在我们的询问下，船长说：‘王子殿下，我们航行了很久，直到看见大海之中似乎有一条大河在湍急地流动。我这艘船驶在最后，其他的船都在我前面。他们之中的任何一艘只要驶入了那大河里，就会被漩涡卷入，再也没有出来。我掉头航行，驶离了这个鬼地方。’但苏丹（也意为统治者）不相信他。他又下令为他和他的部下准备两千艘船，并另外准备一千艘用来储存食物与淡水。他把出行探索这段时间的摄政权交给了我，然后同那些人一起远航，之后再也没有回来。我也再没听到他的声迹，哪怕一丝一毫。”"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_MANSA_MUHAMMAD_CHAPTER_HISTORY_PARA_3",		"这段故事值得推敲，因为它并没有另外记录在其他任何地方，也没有出现在马里的口述历史中。尽管这段有记载的对话是可靠的，但也很难对这个故事信以为真，特别是因为它作为一个令人难以置信的幌子来掩盖穆萨为获得王位而使用的任何阴谋。但如果确有此事，那很可能是探险队在海上迷失了方向。然而，尽管缺乏证据，但仍有极为微弱的可能性，认为穆罕默德国王真的到达了美洲。而这样的“或许”，可能是历史上最令人浮想联翩的假设之一了。");

-- 针对游戏自带马里领袖“曼沙·穆萨”
-- 曼沙只是称号，并非他名字的一部分（它似乎在曼丁卡语中意为苏丹，尽管很明显它代表着班巴拉的祖先？）
-- 我花了很长时间才弄明白，因为所有人都叫他“曼沙·穆萨”
-- 而从未有过人提到过他的族姓：凯塔
-- 依此，更新了穆萨的名字
---- 以上为原作者注释，简单翻译了下，并添加条件语句，仅原模组启用且 Historicity++模组 未启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_LEADER_MANSA_MUSA_NAME",
		"zh_Hans_CN",
		"曼沙·穆萨·凯塔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_SUK_MANSA_MUHAMMAD_NAME")
AND NOT EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_MANSA_MUSA_TO_MUSA_KEITA" AND Text = 1));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_LEADERS_PAGE_LEADER_MANSA_MUSA_TITLE",
		"zh_Hans_CN",
		"曼沙·穆萨·凯塔"
WHERE EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_SUK_MANSA_MUHAMMAD_NAME")
AND NOT EXISTS (SELECT Tag, Text FROM BaseGameText WHERE (Tag = "SUK_MANSA_MUSA_TO_MUSA_KEITA" AND Text = 1));
