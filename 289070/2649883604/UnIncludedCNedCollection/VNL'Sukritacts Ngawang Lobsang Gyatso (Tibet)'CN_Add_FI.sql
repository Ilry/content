-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Sukritacts Ngawang Lobsang Gyatso (Tibet)'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/26 20:34:39
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Ngawang Lobsang Gyatso (Tibet)” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 领袖

		("zh_Hans_CN",	"LOC_LEADER_SUK_LOBSANG_GYATSO_NAME",											"阿旺罗桑嘉措"),

---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_HISTORY_OF_TIBET_NAME",									"吐蕃的历史"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_HISTORY_OF_TIBET_DESCRIPTION",							"在您建立的城市中，每座世界奇观与每座宗内的建筑各+1 [ICON_GreatWork_Writing] 著作槽位。当一个宗教单位在友好领土外消耗使用次数时，可获得 [ICON_GreatWriter] 大作家点数。"),												

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_HISTORY_OF_TIBET_NOTIFICATION",							"+{1} [ICON_GreatWriter] 大作家点数"),												

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_SUK_ABODE_OF_AVALOKITESVARA_NAME",									"观世音菩萨的住处"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_ABODE_OF_AVALOKITESVARA_DESCRIPTION",							"对建有许多奇观并专注于获得 [ICON_Faith] 信仰值的文明印象深刻，但对建造许多奇观却忽视 [ICON_Faith] 信仰的文明感到厌恶。"),

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_SUK_LOBSANG_GYATSO_REASON_ANY",							"（您建造了许多奇观并专注于获得信仰值）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_ABODE_OF_AVALOKITESVARA_KUDO",							"阿旺罗桑嘉措对你的高信仰值和拥有许多奇观印象深刻"),

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_SUK_LOBSANG_GYATSO_REASON_ANY",						"（您建造了很多奇观但并不在意信仰）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_ABODE_OF_AVALOKITESVARA_WARNING",						"阿旺罗桑嘉措担心你对世俗奇观的执着和缺乏信仰"),

---- 对白

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_LOBSANG_GYATSO",									"神圣的达赖喇嘛，智慧而博学的吐蕃之主，您的学问为您的人民带来和平。是您的思想带领您的比丘宣示佛法的真相。是您的智慧带领您的使者在世界传递他们的信仰。阿旺罗桑嘉措，让您的著作为所有凡人带来启迪，您的名字将永垂不朽。"),
		
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",				"我们的宗祠坚固无比。我们的骑士准备好了。你犯了一个严重的错误。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",					"如果我的话不能让你节制，那么我的骑兵就必须这样做。"),	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_LOBSANG_GYATSO_ANY",							"我是五世达赖喇嘛阿旺罗桑嘉措。你也是一个寻求启蒙的学者吗？"),	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_LOBSANG_GYATSO_ANY",			"欢迎您的代表来到我的首都及修道院。毫无疑问，他们会在图书馆中找到智慧和启迪。"),	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_LOBSANG_GYATSO_ANY",	"我会记住你的恩情。"),	
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_LOBSANG_GYATSO_ANY",		"知识是需要分享的。告诉我你的首都，你也可以了解到我的首都。"),	
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_LOBSANG_GYATSO_ANY",							"你的土地是一个天堂般的领域——一个美丽而辉煌的精神启蒙之地。真的很令人印象深刻！"),	
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_LOBSANG_GYATSO_ANY",							"对世俗之美的渴望应该通过信仰来缓和。你堕入了深渊。"),	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",		"一个人应该总是和那些有智慧的人在一起。你用你的智慧给了我以荣幸。"),	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",		"我不能被世俗的执着所纠缠——我不能接受你的友谊。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",				"你和你的人民值得称赞。吐蕃能成为你的朋友就很幸运了。"),	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",		"太好了。"),	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",		"这是无法接受的。"),	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",			"我不需要世俗的礼物——但我接受并真诚地感谢你。"),	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",			"吐蕃不需要这些小饰品。佛祖三宝足矣。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",					"我给你带来了香、经书、经轮。送给您属世属灵的礼物。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",					"你的脏话只会给你自己带来坏处。天堂会让你为你的罪付出代价。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",						"你这个肮脏的生物！你的存在玷污了地球！你在今生和来世都无法被超度！（谴责你）"),	
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_LOBSANG_GYATSO_ANY",								"祝福你。"),	
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",				"你通过言行证明了自己的高尚。如果你接受，吐蕃就会把你视作盟友。"),	
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_LOBSANG_GYATSO_ANY",			"我想，和平会受到我们双方的欢迎。"),	
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_LOBSANG_GYATSO_ANY",			"不可能是这样就结束。"),	
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",					"人要有同情心，让我们寻求结束这场冲突吧。"),	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",		"吐蕃允许你通行。安全旅行。"),	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_LOBSANG_GYATSO_ANY",		"不行，你不能通过这里。我劝你不要再追问此事。"),	
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",					"让我通过你的土地吧，我也会让你通过我的领土。"),	
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_LOBSANG_GYATSO_ANY",		"你的军队在我的边界旁游荡。我不想看到这样的军力展示。移走他们。"),	
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",						"世俗的一切都会随着时间流逝。吐蕃的辉煌已经走到尽头，我并不感到惊讶。"),	
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",				"这种贪婪对你来说是不合时宜的。我不能接受。"),	
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_LOBSANG_GYATSO_ANY",				"是的，这笔交易适合我们。"),

---- 百科与引言

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_LOBSANG_GYATSO_QUOTE",								"雪域独尊，请赐予您的庇佑，让我今生和来生的所有愿望都能实现！"),
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_LOBSANG_GYATSO_TITLE",								"阿旺罗桑嘉措"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_LOBSANG_GYATSO_SUBTITLE",							"五世达赖喇嘛阿旺罗桑嘉措"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_CAPSULE_BODY",		"吐蕃应该建设紧凑的山区城市。在一些宗教信仰的帮助下，它们会表现得更加出色。阿旺罗桑嘉措给吐蕃带来了学者的气息——将吐蕃的宗祠和奇观变成了文化中心。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_DETAILED_BODY",		"吐蕃是一个多山地和多寺院的国家：在山脉附近建造区域不仅可以提供额外的收益，还可以让您以 [ICON_Faith] 信仰值购买这些区域中的建筑。在你的 [ICON_Governor] 总督和宗祠的帮助下，你应该有足够的 [ICON_Faith] 信仰值来做到这一点。阿旺罗桑嘉措能获得大量的伟人点数，帮助吐蕃走向文化胜利。通过广泛传播您的宗教，赚取额外的 [ICON_GreatWriter] 大作家点数以填补您众多的[ICON_GreatWork_Writing]著作槽位。"),		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_1",		"五世达赖喇嘛的前六年就像一部小说。他于1617年出生于前贵族家族琼结巴。1618年，他的父亲Düdül Rabten参与了反对王室政府的密谋，这引来了国王的不满。虽然国王禁止寻找达赖喇嘛的转世灵童，但Düdül Rabten在三位候选人在拉登寺圣像前抽签后，偷偷选择他的儿子为四世达赖喇嘛的转世灵童。Düdül Rabten试图逃往吐蕃东部，但被皇家使节阻止并被带回藏巴王朝，之后他一直被囚禁，直到他1626年去世，都没有再见过他的儿子。他的妻子和儿子（三岁）被迫留在德吉岭，然后去了拉宗。由于战争造成的威胁，国王建议他们住在桑珠的宫廷里。但母亲怀疑国王的真实意图，宁愿无视他的要求，回到纳卡茨城堡的家人身边。转世禁令一解除，在蒙古使节的陪同下，以班禅洛桑秋金派使团为借口，派使节前往朝廷，请求正式承认现在住在纳卡茨的男孩。作为四世达赖喇嘛的转世灵童。在哲蚌寺就任达赖喇嘛后，罗桑嘉措立即承担起了职责，主持了藏历四月的新年祭祀和萨嘎达瓦庆祝活动。他还开始了他的学业、语法和诗歌、占星术和占卜以及相关主题的培训。罗桑嘉措于1638年受戒。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_2",		"五世达赖喇嘛仍记得童年的痛苦回忆，在那时，与轮回概念相关的哲学和宗教戒律服务于政治目的。在他的著作中，他经常讽刺地回忆起他自己学校的政治操纵，其中涉及蒙古人的所有事务。1637年，当罗桑嘉措25岁的时候，和硕特蒙古的首领固始汗（1582-1655）带着八百名士兵来到吐蕃，表面上是为了朝圣，但几乎可以肯定是为了控制吐蕃和为他们的统治寻找本土盟友。这在当时并不罕见——随着蒙古民族的分裂，各部落的领袖纷纷在吐蕃寻找宗教领袖，以期重建忽必烈创造的守护神模式。固始汗的使命是应四世达赖喇嘛的司库索南秋培的要求，这是后者在与吐蕃的斗争中寻找蒙古盟友的努力的一部分。达赖喇嘛此时会见了固始汗，并封他为丹增秋杰“法王”。这次访问期间，固始汗与达赖喇嘛讨论了固始汗入侵康区并摧毁苯波王国的计划，借口是一封伪造的信件，其中写道贝利国王打算入侵拉萨。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_3",		"1641年，经过一年的激战，固始汗打败了贝利国王。五世达赖喇嘛与索南秋斐在讨伐贝利时，讨论了固始汗和他的部下是否应该返回科克诺尔的问题。他们决定派使者到康区联络蒙古首领。在达赖喇嘛和使者在场的情况下，索南秋培假装同意达赖喇嘛的意见，即固始汗在吐蕃东南部的战役结束后应返回科克诺尔。然而，就在使者即将离开的时候，索南秋培命令他告诉固始汗带领他的军队对抗藏族。然后固始汗继续进入吐蕃。达赖喇嘛声称对此感到震惊，并要求索南秋培停止他的工作，并说服固始汗返回，但他拒绝这样做，固始汗围攻纳卡茨大约一年，最终粉碎了所有抵抗并控制了罗桑。达赖喇嘛随后在桑珠采登基为吐蕃国王，固始汗将他对吐蕃中部和东部的征服作为礼物赠送给他。1642年是关键的一年，标志着吐蕃历史的转折点，因为达赖喇嘛第一次成为国家元首，这个达赖喇嘛以前只是修道院的住持和一所宗教学校的领袖。他上台的产生的影响将是巨大的。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_4",		"达赖喇嘛在接下来的几十年里巩固权力，这个过程包括建造宫殿、自称为观音菩萨（长期以来被认为是吐蕃的守护神）的化身、对北京进行国事访问，以及带领吐蕃帝国进入黄金时代。1645年，五世达赖喇嘛开始在拉萨红山上修建布达拉宫，以观世音菩萨的净土布达拉卡命名，并安放在公元七世纪吐蕃皇帝松赞干布的都城遗址上。固始汗和他一起参加了该遗址的开光仪式。在五世达赖喇嘛的领导下，拉萨蓬勃发展。外国商人和知识分子涌入这座城市，为艺术、医学和建筑做出了巨大贡献。他在世俗和宗教事务方面建立了广泛的税收制度和行政基础设施。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_5",		"除了政治成就之外，五世达赖喇嘛更关心精神方面的问题。写作是他大的爱好，无论在什么情况下他都不会打断这个习惯，无论是旅行还是静修。他的作品有二十七卷。除了写许多关于各种主题的论文外，他还讲述了他的异象经历，由于他自己的宗教学校不赞成这些事情，他一直保密。他以一种非常自由和个人的风格写作，让他能够表达自己的感受，既坦率又讽刺。他的自传的特点是他的自发性、他的讽刺和他对自己的转世身份和他自己的学校格鲁派的原教旨主义态度的幽默评论。很多时候，与其他传统格鲁派作家不同，他给出了自己的独立解释，他从未试图强加于人。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_LOBSANG_GYATSO_CHAPTER_HISTORY_PARA_6",		"五世达赖喇嘛继续写作，直到他于1682年去世前的几个月，享年65岁。他非凡的个性，既复杂又吸引人，使他无可否认地成为吐蕃历史上最重要的人物之一。他的政治遗产几乎对该国文化的各个方面都产生了深远的影响，特别是建筑、诗歌、史学、民政、绘画，当然还有哲学和佛教冥想。他既是一位杰出的政治家，又是一位佛教僧侣，体现了佛教“伟大人物”的理想。藏族传统仍然尊他为“伟大的第五”。他严格的寺院戒律掩盖了他精神生活的另一个方面：他对密宗或多或少的魔法仪式的极大兴趣，以及最重要的是他对神秘冥想的倾向，这为他的一生提供了一系列有见地的经历。他只在他的著作中揭示了这些，这些著作在他那个时代鲜为人知，这表明他从未停止过对国家和人民的福祉的关注。");



