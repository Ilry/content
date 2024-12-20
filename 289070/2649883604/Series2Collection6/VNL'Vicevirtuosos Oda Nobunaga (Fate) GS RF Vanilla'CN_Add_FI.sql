-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Vicevirtuosos Oda Nobunaga (Fate) GS RF Vanilla'CN_Add_FI
-- Author: Clear8Sky
-- DateCreated: 2021/10/2 13:58:19
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Vicevirtuoso's Oda Nobunaga (Fate) [GS/R&F/Vanilla]” 。该文件在 FrontEnd 与 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																					Text)
VALUES

---- 功能类文本

		("zh_Hans_CN",	"LOC_LEADER_VV_NOBU_NAME",																"织田信长"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_VV_TENKA_FUBU_NAME",													"天下布武"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_VV_TENKA_FUBU_DESCRIPTION",											"在您原始 [ICON_Capital] 首都所在大陆的敌方领土内作战时：若距单位1格范围内有敌方圣地，则其+5 [ICON_Strength] 战斗力；掠夺敌方圣地可基于您当前所处时代获得 [ICON_Culture] 文化值奖励。[NEWLINE]对抗武僧时+5 [ICON_Strength] 战斗力。[NEWLINE]武士在晋升为火枪手后，可自动成为 [ICON_Corps] 军团。[NEWLINE]通往其他大陆的文明的国际 [ICON_Traderoute] 贸易路线产出+2 [ICON_Culture] 文化值、+2 [ICON_Science] 科技值。"),

--- 其他文本

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_VV_NOBU",														"织田信长，您是那些墨守旧弊的顽固派的死敌，是“神性”与“神秘”的破灭者！如今您再次被召唤，成为英灵。愿您能统一日本，并带领它走向辉煌，成为东方最耀眼的明珠！不断向前吧，避开那些小人的背叛，用您的武力团结天下！"),

---- 领袖引言

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_VV_NOBU_QUOTE",													"真没办法啊！"),

---- 百科文本

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_VV_NOBU_TITLE",													"织田信长"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_VV_NOBU_SUBTITLE",												"织田氏的大名主，战国三英杰之一。少时被称作“尾张的大傻瓜”，自称为第六天魔王。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_CAPSULE_BODY",							"织田信长的战斗加成特性可使她更易征服首都所在的大陆，尤其是解锁科技“火药”以后。在这之后（或在此期间），她会在找寻全球范围内的国际贸易机会中受益良多。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_DETAILED_BODY",							"无论织田信长选择追求哪种胜利方式，她的主要目标都是统治自己首都所在的大陆，同时与其他大陆的文明进行贸易往来，然后建立起一个繁荣的帝国。以宗教为核心的文明恐怕会是她的首要目标，因为她对这类文明拥有战斗加成，同时掠夺圣地也能让她获得文化值奖励。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_1",							"战国的风云人物、织田信长。[NEWLINE]少年时被称作“尾张的大傻瓜”，后于桶狭间击破今川义元而名震天下。[NEWLINE]那之后，不断击破强敌、统一天下迫在眉睫之时，她在明智光秀的谋反中死于本能寺。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_2",							"身高／体重：152cm·43kg[NEWLINE]出典：史实[NEWLINE]地域：日本[NEWLINE]属性：秩序·中庸[NEWLINE]性別：女性[NEWLINE]「真没办法啊！」"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_3",							"骄傲自大的自信家，喜欢新事物，有着“不能拘泥于旧弊和常识”这样的灵活思想。[NEWLINE]是实质上推番了室町幕府，为终结自应仁之乱起的漫长战国时代作出巨大影响的人物。[NEWLINE]作为Servant被召唤时身着军服，是因个人趣味而准备的。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_4",							"天下布武：Ａ[NEWLINE]时代的变革者、信长的特殊技能。[NEWLINE]在旧文明中倡导新文明的概念的变革。[NEWLINE]对具有高等级的“神性”或“神秘”的对手，[NEWLINE]或是身为体制守护者的英灵，[NEWLINE]会赋予自身有利的补正。[NEWLINE]相反，对神秘感稀薄的近代英灵，会削弱自身的各项技能及宝具效果。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_5",							"『三千世界』[NEWLINE]等级：Ｅ～Ａ[NEWLINE]种类：对军宝具[NEWLINE]长篠的三段击。展开三千把火绳枪并同时射击。[NEWLINE]由于击破战国最强的骑兵军团的传说过于出名，其对有骑乘技能的英灵的攻击力增加。[NEWLINE]对于没有骑乘技能的英灵来说，就是普通的火绳枪而已，但三千把的同时射击也是个威胁啊。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_6",							"信长的自称“第六天魔王”是宗教上的欲界魔王之名。[NEWLINE]信长生前以“火烧比叡山”为代表的暴行，使后世的人民对她抱持着恐惧和敬畏，使英灵信长作为魔王显现。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_HISTORY_PARA_7",							"向统一天下迈进的织田信长，亡于家臣的谋反。[NEWLINE]此时她却说着“也是没办法的事呢”而不是后悔。对圣杯没有什么特殊的愿望，拿她所擅长的奇思妙想用圣杯去做些什么的可能性很大，比如说，炸弹……"),

---- 能力类文本

		("zh_Hans_CN",	"LOC_COMBAT_PREVIEW_TRAIT_VV_TENKA_FUBU_HOME_RELIGION",									"+{1_Value} [ICON_Strength] 战斗力 来自于位处原始 [ICON_Capital] 首都所在大陆上靠近敌方圣地"),
		("zh_Hans_CN",	"LOC_COMBAT_PREVIEW_TRAIT_VV_TENKA_FUBU_WARRIOR_MONKS",									"+{1_Value} [ICON_Strength] 战斗力 来自于对抗武僧"),

---- 议程类文本

		("zh_Hans_CN",	"LOC_AGENDA_VV_DEMON_KING_6_NAME",														"第六天魔王"),
		("zh_Hans_CN",	"LOC_AGENDA_VV_DEMON_KING_6_DESCRIPTION",												"尽可能地在她首都所在大陆上快速扩张，而不愿意向其他大陆扩张领土。倾向于宣布领土扩张战争。喜欢在其他大陆上的、科技值与文化值产出较高的文明，讨厌那些在她首都所在大陆上创立宗教的文明。"),

---- 外交类文本

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_VV_HIGH_SCIENCE_OTHER_CONTINENT",									"织田信长对位于其他大陆的您文明的科技发展很感兴趣。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_VV_HIGH_CULTURE_OTHER_CONTINENT",									"织田信长被位于其他大陆的您文明的艺术与人文发展所吸引。"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_VV_RELIGION_FOUNDED_SAME_CONTINENT",								"织田信长不喜欢她首都所在大陆受到“神性”威胁。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_VV_NOBU_ANY",												"唔哈哈哈哈！尽情地注视着吾吧，吾便是魔人Archer，第六天魔王，信长！什么？觉得吾是女性这点实在可笑吗……？呵，看来汝也想成为骷髅了吗……？"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_VV_NOBU_ANY",								"来呀，沐浴在升阳大地的荣光下吧！我会在你的首都亲自为你跳敦盛舞！大！家！都！A-TSU-MO-RI!"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_VV_NOBU_ANY",						"有趣的提议！吾很乐意借此机会从汝的文化中学习新的东西，吾可以用它来巩固吾自身的力量！"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_VV_NOBU_ANY",						"吾可以安排访问彼此首都的事情吗？嘛，到吾来访的时候，汝可能得告诉汝的僧侣们，要用木板封住他们的房子。不然的话，吾不会保证他们的安全！"),
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_VV_NOBU_ANY",												"哟！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_VV_NOBU_ANY",						"哦！吾接受汝的提议！吾等二人可以参加日本的传统活动，来庆祝吾与汝新建立的友谊，比如一丝不挂地躺着看电视！嗯？ 汝觉得吾早在电视机发明以前就拥有它很奇怪？汝真是蠢到只关注这些事！惊讶之处难道不应该是“一丝不挂”这几个字吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_VV_NOBU_ANY",						"第六天魔王不需要结交新的朋友！"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_VV_NOBU_ANY",									"汝得到了一生中最大的荣誉！向吾献上汝的友谊吧，吾是群英之首，吾是天下之统领。接受吧！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_VV_NOBU_ANY",							"大善！吾等二人要喝点吾最好的茶来庆祝一下。作为奖励，吾就屈尊亲自为汝点茶吧。这可是汝的荣幸！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_VV_NOBU_ANY",							"Nobu？！汝居然不愿与第六天魔…唔唔，这么大声地拒绝吾，吾或许知道原因了……"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_VV_NOBU_ANY",									"…嘿嘿嘿，嘿哈哈哈哈哈！与魔王信长直接对峙需要很大的勇气！好啊，吾将接受汝的挑战！尝尝织田信长的力量吧！"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_VV_NOBU_ANY",										"吾早已厌倦汝的厚颜无耻！立于吾面前者，悉数歼灭！"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_VV_NOBU_ANY",											"吾…吾筋疲力尽了。不过，也是无可奈何的。人生五十年…嘛，除了在这个一国之领袖甚至能活6050年的游戏世界里…不管怎样，吾庆贺汝的胜利！"),
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_VV_NOBU_ANY",										"吾…吾筋疲力尽了。不过，也是无可奈何的。人生五十年…嘛，除了在这个一国之领袖甚至能活6050年的游戏世界里…不管怎样，吾庆贺汝的胜利！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"哦！汝的代表团很受吾的宫廷的热情招待！啊，顺便一提，“吾的宫廷”指的是吾的侄女茶茶，她似乎把代表团送来的金币一个个都藏起来了！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"其他国家的代表团在织田信长的宫廷中都颇受欢迎，但…至于汝呢？汝的代表团身上却令吾厌恶。"),
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_VV_NOBU_ANY",										"吾让织田信雄送去了一份礼物到汝的首都，收下吧！唔…等等，说法不太对，应该是吾把他作为礼物送给汝，吾不想让他回来，请务必把他收下！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_AI_LEADER_VV_NOBU_ANY",								"哈哈哈哈！善，大善！和谐善终！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_AI_LEADER_VV_NOBU_ANY",								"不～要～啊～！吾不想再听到他回来痛骂吾了！"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_VV_NOBU_ANY",										"这样的吗…第六天魔王肯定会记得汝对她说过的那些恶语……"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_EMBASSY_FROM_HUMAN_LEADER_VV_NOBU_ANY",								"就让吾不停地发展日本的国际影响力吧！前进！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_EMBASSY_FROM_HUMAN_LEADER_VV_NOBU_ANY",								"唔唔…或许过些时再议？现在吾在忙着收集量子…对，就是汝常说的…刷QP本…？吾倒是不明白其含义啦……"),
		("zh_Hans_CN",	"LOC_DIPLO_EMBASSY_FROM_AI_LEADER_VV_NOBU_ANY",											"吾厌倦了参加这些琐碎的会议。吾更愿参加家臣们的婚礼。在此处，吾的家臣们将会在汝的首都建立一座大使馆，如此吾便可以沉浸在生活中那些美好事物里！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_EMBASSY_FROM_AI_LEADER_VV_NOBU_ANY",									"善！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_EMBASSY_FROM_AI_LEADER_VV_NOBU_ANY",									"唔，这不是很遗憾吗……"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_VV_NOBU_ANY",										"日本第六天魔王会让全世界知道她对汝的看法！…唔，或许吾应试着给自己换个更平易近人的头衔，如果吾想以此来表达对其他领袖任何意见的话……[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_VV_NOBU_ANY",											"“神性”的恶臭已从汝的领土飘到吾这里了！汝应该清楚吾会对寺庙和僧侣做什么吧？"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_VV_NOBU_REASON_ANY",											"（您在她首都所在大陆上创立了宗教）"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_VV_NOBU_ANY",												"吾十分崇尚汝国家的科技与文化的先进发展！特别是吾可借此来摧毁吾国那些“拘泥于旧弊和常识”的顽固传统！之后再用强权一统天下！"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_VV_NOBU_REASON_ANY",												"（您对她而言是一股强大的海外文明势力，她可以通过与您贸易获得颇多收益）"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_ALLIANCE_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"汝已经和一位魔王签订契约啦！吾认为汝现在是第七天魔王了，唔哈哈哈哈哈！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_ALLIANCE_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"谢绝。如果送给吾10个或20个蛮神心脏，吾倒还可以考虑一下。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_DEAL_AI_ACCEPT_DEAL_LEADER_VV_NOBU_ANY",								"好啊！"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_DEAL_AI_REFUSE_DEAL_LEADER_VV_NOBU_ANY",								"不行！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY",								"吾这样可以吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY",								"Nobu？！"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_DEAL_AI_ADJUST_DEAL_LEADER_VV_NOBU_ANY",								"尽情使用汝的眼睛来见证吾这此慷慨的提议吧！"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_VV_NOBU_ANY",								"好啊，吾也满足了。不过，还是很有趣！改天再来一次吧！唔哈哈哈哈！"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_VV_NOBU_ANY",								"吾的三千把火绳枪依然装满弹药！汝是无法从织田信长的手中逃掉的！"),
		("zh_Hans_CN",	"LOC_DIPLO_AI_REFUSE_DEMAND_LEADER_VV_NOBU_ANY",										"居然敢向魔王提出索求？！汝可真是活腻了！！"),
		("zh_Hans_CN",	"LOC_DIPLO_AI_ACCEPT_DEMAND_LEADER_VV_NOBU_ANY",										"唔…也是无可奈何呀。"),
		("zh_Hans_CN",	"LOC_DIPLO_HUMAN_ACCEPT_DEMAND_FROM_AI_LEADER_VV_NOBU_ANY",								"{LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY}"),
		("zh_Hans_CN",	"LOC_DIPLO_HUMAN_REFUSE_DEMAND_FROM_AI_LEADER_VV_NOBU_ANY",								"{LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY}"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_VV_NOBU_ANY",										"想到即使是伟大的织田信长，也会被逼无奈去议和。唔…就这样吧……"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"向其他文明开放边界，此举将会颠覆日本上千年来的文化结构，这当然是吾最喜欢做的事情。嘛…除了冲田的瞬移，和火烧那些妇女儿童仍在里面的寺庙…总之，这个提议吾准许了！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_VV_NOBU_ANY",							"吾愿同汝的国家进行贸易，但彻底向汝的人民开放边境，有亿～点过分，汝不觉得吗？"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_VV_NOBU_ANY",									"向吾开放汝的国家边境，一定是个有趣的决定！"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_AI_LEADER_VV_NOBU_ANY",								"{LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY}"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_AI_LEADER_VV_NOBU_ANY",								"{LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_VV_NOBU_ANY}"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_POSITIVE_LEADER_VV_NOBU_ANY",	"不要害怕，他们只是来镇压吾国内其他氏族的叛乱。他们不会用来进攻汝的国家！"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_AI_RESPONSE_NEGATIVE_LEADER_VV_NOBU_ANY",	"织田信长可以随心所欲地驻军！"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_VV_NOBU_ANY",							"吾已经为每一支军队，每一支汝驻扎在吾边境、对吾构成威胁的军队，都准备了一把装好弹药的火绳枪。嗯？不如吾等之间做一次“小测试”？");

---- 为与 CIVITAS 的 Oda Nobunaga 作区分而做的改动，后者启用时，前者的织田信长加上个人署名

UPDATE LocalizedText
SET Text = REPLACE(Text, "织田信长", "织田信长（Vv.）")
WHERE Tag IN 
(
	"LOC_LEADER_VV_NOBU_NAME",
	"LOC_PEDIA_LEADERS_PAGE_VV_NOBU_TITLE",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_CAPSULE_BODY",
	"LOC_PEDIA_LEADERS_PAGE_LEADER_VV_NOBU_CHAPTER_DETAILED_BODY"
)
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_VLR_ODA_NAME");
