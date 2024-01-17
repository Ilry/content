-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Macedon Philip II'CN_Add_FI
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/9/20 14:36:16
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Macedon: Philip II” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_DLC_PersiaMacedon

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																									Text)
VALUES

---- 模组

		("zh_Hans_CN",	"LOC_MOD_JFD_MACEDON_PHILIP_II_DESCRIPTION",															"------------------------------------[NEWLINE]LEADER -- PHILIP II[NEWLINE][NEWLINE]领袖特性 - 科林斯联盟[NEWLINE]每次隐退 [ICON_GreatGeneral] 大将军可获得1位 [ICON_Envoy] 使者，从城邦征兵消耗的 [ICON_Gold] 金币减半。完成科技“铸铜术”可解锁特色单位伙友步兵。[NEWLINE][NEWLINE]特色单位 - 伙友步兵[NEWLINE]腓力二世作为领袖时的马其顿特色近战单位，取代枪兵。比枪兵更强大，每次 [ICON_Promotion] 强化可获得 [ICON_GreatGeneral] 大将军点数。[NEWLINE][NEWLINE]领袖议程 - 皇帝将军[NEWLINE]确保拥有众多城邦盟友和一支强大的常备军。喜欢远离城邦政治的文明。喜欢与寻求拉拢城邦的其他文明竞争，特别是那些拥有庞大且训练有素的军队的文明。"),
		
---- 领袖

		("zh_Hans_CN",	"LOC_LEADER_JFD_PHILIP_II_NAME",																		"腓力二世"),
		
---- 议程

		("zh_Hans_CN",	"LOC_AGENDA_JFD_STRATEGOS_AUTOKRATOR_NAME",																"皇帝将军"),
		("zh_Hans_CN",	"LOC_AGENDA_JFD_STRATEGOS_AUTOKRATOR_DESCRIPTION",														"确保拥有众多城邦盟友和一支强大的常备军。喜欢远离城邦政治的文明。喜欢与寻求拉拢城邦的其他文明竞争，特别是那些拥有庞大且训练有素的军队的文明。"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_LEADER_JFD_PHILIP_II_REASON_NOT_COMPETING_MINORS",										"（您没有与他们竞争同一个城邦）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_STRATEGOS_AUTOKRATOR_NOT_COMPETING_MINORS",								"腓力二世感谢你不插手他的事务。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_PHILIP_II_REASON_COMPETING_MINORS",										"（您正在与他们竞争同样的城邦）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_STRATEGOS_AUTOKRATOR_COMPETING_MINORS",									"腓力二世将你视为政治对手。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_LEADER_JFD_PHILIP_II_REASON_LEADS_STANDING_ARMY",									"（您拥有一支强大的常备军）"),
		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_AGENDA_JFD_STRATEGOS_AUTOKRATOR_LEADS_STANDING_ARMY",								"腓力二世将你视为军事对手。"),
		
---- 载入
		
		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_JFD_PHILIP_II",																"强者尽其所能，弱者则将受苦。如果没有盟友，我们只能算在弱者之中。腓力二世，周围的国家必须屈服并团结在我们的旗帜下。结成联盟，我们将在未来几个世纪内确保马其顿的权威。"),
		
---- 特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_LEAGUE_CORINTH_NAME",																"科林斯联盟"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_JFD_LEAGUE_CORINTH_DESCRIPTION",														"每次隐退 [ICON_GreatGeneral] 大将军可获得1位 [ICON_Envoy] 使者，从城邦征兵消耗的 [ICON_Gold] 金币减半。完成科技“铸铜术”可解锁特色单位伙友步兵。"),
		
---- 领袖百科
		
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_TITLE",													"腓力二世"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_SUBTITLE",													"马其顿国王"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_QUOTE",													"哦，雄心勃勃地为追寻整个世界而活的我们！在终将归去之时，世界安纳我们的只有这一隅之地。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_1",									"虽然人们常常只记得他是亚历山大大帝的父亲，但马其顿的腓力二世（公元前359年至公元前336年在位）本身就是一位多才多艺的国王和军事指挥官，为他的儿子战胜大流士三世，征服波斯奠定了基础。腓力继承了一个软弱落后的国家，军队效率低下，在他的领导下有了重大改变，军队纪律严明，并成为一支强大而高效的军队，最终征服了马其顿周围的领土，并征服了希腊的大部分地区。他使用贿赂、战争和威胁来保护他的王国。然而，如果没有他的洞察力和决心，历史将永远不会记载下亚历山大的名号。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_2",									"与希腊的许多城邦不同，马其顿是一个君主制国家，被希腊其他地区视为原始和落后的象征。尽管人们说希腊方言，但许多人认为该国的作用仅仅是用来提供木材和建造牧场。这片蛮荒之地的王族是阿基德人，他们的根源可以追溯到阿尔戈斯岛和宙斯之子赫拉克勒斯。腓力出生于公元前383年左右，是阿敏塔斯三世三个儿子中最小的一个。他的哥哥帕迪卡斯三世在马其顿北部边境与伊利里亚人作战时被杀。由于阿格德最年长的兄弟亚历山大二世也死了，腓力被任命为他的侄子阿明塔斯四世的摄政王。公元前359年，年仅23岁的腓力登上马其顿王位。他有两个当务之急：保卫马其顿的边界和重组军队。他的主要敌人是伊利里亚人（他最终将在公元前 359 年击败他们）和雅典人。他们不仅拥有附近的金银矿，而且还支持马其顿王位的觊觎者。幸运的是，由于希腊大部分地区都卷入了一系列内战，腓力有时间解决马其顿最紧迫的问题。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_3",									"改组军队后，他重修了首都佩拉，邀请了诗人、作家和哲学家；亚里士多德将被要求教腓力的儿子亚历山大。再次，他的做法是合理的：为了确保他的邻居不会对他发起攻击，他邀请他们的儿子到佩拉接受教育，其实也充当了人质。为了维护他在国内的权威，他建立了皇家学院，以确保王位免受可能的阴谋。然而，他最关心的仍然是马其顿的安全和保障。公元前357年，他占领了雅典在安菲波利斯的殖民地，从而获得了那里的金矿和银矿，这激怒了雅典人。他暂时将其归还给城邦，然后再重新夺回。公元前356年，他从那里夺取了希腊北部城市波蒂迪亚和皮德纳。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_4",									"公元前356年，腓力二世卷入第三次神圣战争后，很快展现了他的实力。福西斯人占领了著名神谕的故乡德尔斐市。雅典和斯巴达都站在福西斯人的一边加入了冲突。色萨利联盟请求腓力提供帮助，尽管他最初被击败，但他和色萨利骑兵在公元前352年的番红花战场战役中击败了福西斯人和他们的指挥官奥诺马库斯。因为无法与腓力结成联盟，雅典仍继续发动战争，直到公元前346年的菲洛克拉底和约。这场持续不断的战争进一步削弱了希腊南部。在此期间，腓力于公元前355年攻占克雷尼德斯，将其更名为腓立比，从而扩大了对希腊的控制。公元前354年，他将其夷为平地；并在公元前348年与奥林匹亚斯待在哈尔西迪斯半岛上。但他并没有在负伤的情况下——失明的眼睛、骨折的肩膀和残废的腿，脱离这些战斗。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_5",									"在腓力掌权和他在整个希腊取得胜利的过程中，他身边不断批评他的是伟大的雅典演说家德摩斯梯尼，他在一系列名为“腓力斯”的演讲中不断抨击腓力。他激烈的演讲——甚至后来称亚历山大为小子——最终在公元前338年的喀罗尼亚战役中达到高潮，这场战役展示了马其顿的力量和权威。腓力和他的儿子亚历山大（当时只有18岁）彻底击败了雅典和底比斯的联军。最终，在科林斯召开了泛希腊代表大会（斯巴达没参加），和平终于得以重建。随着他成为国会主席并承诺保护爱奥尼亚的希腊殖民地，腓力开始计划入侵波斯。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_6",									"在征服希腊的过程中，菲利普曾七次在战场上抽空结婚。这些婚姻中最著名的是与伊庇鲁斯的尼奥普托勒摩斯的女儿和波斯未来征服者亚历山大的母亲奥林匹亚斯（还有一个女儿名叫克利奥帕特拉）。公元前356年亚历山大出生时，腓力正在波提迪亚战斗。 历史学家普鲁塔克在他的亚历山大传记中这样写道：“腓力刚攻下波提迪亚，就一次性收到三个消息，帕梅尼奥在一场大战中推翻了伊利里亚人，他的赛马在奥运会上夺冠，他的妻子生下了亚历山大……” 然而，随着亚历山大的成长和他的才华逐渐显露，父子之间的紧张局势加剧。因为亚历山大的母亲来自邻国伊庇鲁斯，国王被迫嫁给一个真正的马其顿人，并为这个国家提供一个纯血统的继承人。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_7",									"公元前337年，一位密友兼马其顿指挥官阿塔罗斯说服腓力娶他的侄女克利奥帕特拉·欧律狄刻，并提供一个更合适的继承人。普鲁塔克写道：“在腓力爱上并与之结婚的克利奥帕特拉的婚礼上，她对他来说太年轻了，她的叔叔阿塔罗斯在喝酒时希望马其顿人恳求众神给他们一个合法的继承人。”在婚宴上，亚历山大对这个想法大发雷霆，并对阿塔罗斯的言论和他父亲的醉酒表示愤怒。因为他的言论，他和他的母亲都被暂时流放了——她在伊庇鲁斯，他在伊利里亚。回到佩拉后不久，亚历山大就坐上了王位。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_HISTORY_PARA_8",									"公元前336年，菲利普的前朋友兼护卫保萨尼亚斯因私事对腓力感到不满，并刺死了他。亚历山大很快被加冕为国王。普鲁塔克写道：“……保萨尼亚斯在阿塔罗斯和克利奥帕特拉的事件中对他感到愤怒，当他发现他受到耻辱无法得到赔偿时，他抓住了机会并谋杀了他。事实上这一罪责在很大程度上应归咎于奥林匹亚斯，据说奥林匹亚斯鼓励和激怒了这位愤怒的年轻人进行报复……”虽然奥林匹亚斯在暗杀中所扮演的角色从未得到证实，但是，众所周知，她一直想让亚历山大继承王位。腓力的新妻和孩子很快被奥林匹亚斯处死，消灭了任何重要的王位继承人。在征服了对他的统治的可能存在的任何严重威胁后，亚历山大实现了他父亲的梦想，入侵了波斯。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_CAPSULE_BODY",										"腓力二世治下的马其顿在游戏中要么是正在备战，要么就是已经开战。凭借着强大的联盟网络，廉价的征兵花费和大将军隐退时带来的使者奖励，腓力二世得以一路高歌猛进，直到天涯海角。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_JFD_PHILIP_II_CHAPTER_DETAILED_BODY",									"古典时期的腓力二世堪称最为敬畏的对手之一。马其顿是少有的能在此时代同时拥有两种特色单位的文明。如单位在皇家学堂中受训，马其顿无需花费时间建立学院即可获得科技进步。凭借着特色单位伙友步兵，腓力二世最容易让附近的城邦为其效力，这些城邦征集来的军队也能提高军事力量。因此腓力二世可以火力全开四方征战，直到征服全世界。"),
		
---- 外交
------ 初次见面
-------- 开场白
			
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_JFD_PHILIP_II_ANY",														"我是腓力二世，马其顿以及这些山脉的领主，希望你不会在这里谋划着同我战斗。"),
				
-------- 到附近城市的邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_JFD_PHILIP_II_ANY",										"和我一起去我们附近的城市吧，好谈谈你在我的边境旁做些什么。"),
				
-------- AI接受玩家邀请

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_JFD_PHILIP_II_ANY",								"很好，但我要求带上我最信任的侍卫。"),
				
-------- AI邀请玩家交换首都信息

		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_JFD_PHILIP_II_ANY",									"我不相信你我势均力敌。让我看看你的首都，然后我会给出我的判断。"),
				
------ 问候

		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_JFD_PHILIP_II_ANY",															"你回来了……"),
				
------ 代表团	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",										"我已同意会见贵国代表团。希望他们带来了值得我听的话。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",										"你凭什么认为我会会见你的代表团？我不能把时间浪费在你身上。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_JFD_PHILIP_II_ANY",												"我已派出一支代表团，请接待他们，收下我送去的精美武器，我会把这看作是你善意的表现。"),
				
------ 开放边境	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",									"很好。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",									"这只会使我们的关系恶化。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_JFD_PHILIP_II_ANY",												"如果我们要和平相处，你必须允许我的人民不受阻碍地通过你的边界。"),
				
------ 宣布友谊	
-------- AI接受

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",									"确实。"),
				
-------- AI拒绝

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",									"接受它将成为我的一个弱点。"),
				
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_JFD_PHILIP_II_ANY",											"你的友谊宣言大大表明了你有一些常识。"),
				
-------- 玩家接受后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_PHILIP_II_ANY",										"很好。"),
				
-------- 玩家拒绝后AI回应

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_PHILIP_II_ANY",										"你看上去并不精通外交。"),
				
------ 结盟	
-------- AI请求

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_JFD_PHILIP_II_ANY",												"作为盟友，我们将共同避免敌人的扩张。你可以选择同意，或者让你的头掉在地上。"),
				
------ 赞成与警告	
-------- AI赞成

		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_JFD_PHILIP_II_ANY",															"您的军队训练有素。"),
				
-------- AI警告

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_JFD_PHILIP_II_ANY",														"你最好离开，猎犬已经饥渴难耐了。"),
				
-------- AI警告玩家离开边境

		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_JFD_PHILIP_II_ANY",									"我不会被你这样的人吓倒。滚出我的边界。"),
				
------ 贸易	
-------- AI接受交易

		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_JFD_PHILIP_II_ANY",											"{LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_PHILIP_II_ANY}"),
				
-------- AI拒绝交易

		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_JFD_PHILIP_II_ANY",											"{LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_JFD_PHILIP_II_ANY}"),
				
------ 谴责		
-------- 受到谴责回应

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",												"你的意思是你在诽谤我吗？"),
				
-------- AI谴责玩家

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_JFD_PHILIP_II_ANY",													"试图与你这样的人进行外交是毫无意义的。[NEWLINE]（谴责你）"),
		
------ 谴责理由

		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_STRATEGOS_AUTOKRATOR_COMPETING_MINORS",		"（您正在与他们竞争同样的城邦）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_REASON_FROM_AI_LEADER_ANY_REASON_JFD_STRATEGOS_AUTOKRATOR_LEADS_STANDING_ARMY",		"（您拥有一支强大的常备军）"),
			
------ 宣战	
-------- 受到宣战后回应

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",											"你犯了一个严重的错误。也许你应该听听大使的话。"),
				
-------- AI宣战

		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_JFD_PHILIP_II_ANY",												"与你和平相处是不可能的。我们必须上战场一决胜负。"),
				
------ 求和	
-------- AI接受求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_JFD_PHILIP_II_ANY",											"我同意。让和平胜利。"),
				
-------- AI拒绝求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_JFD_PHILIP_II_ANY",											"我不接受来自你的和平。"),
					
-------- AI求和

		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_JFD_PHILIP_II_ANY",												"外交必须战胜流血。让我们放下武器。"),
			
------ 击败	
-------- AI被击败

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_PHILIP_II_ANY",													"那就杀了我，让文明崩溃吧。"),
		
-------- 玩家被击败（在热座模式中会显示）

		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_JFD_PHILIP_II_ANY",													"{LOC_DIPLO_DEFEAT_FROM_AI_LEADER_JFD_PHILIP_II_ANY}"),

---- 伙友步兵
		
		("zh_Hans_CN",	"LOC_UNIT_JFD_PEZHETAIROS_NAME",																		"伙友步兵"),
		("zh_Hans_CN",	"LOC_UNIT_JFD_PEZHETAIROS_DESCRIPTION",																	"腓力二世作为领袖时的马其顿特色近战单位，取代枪兵。比枪兵更强大，每次 [ICON_Promotion] 强化可获得 [ICON_GreatGeneral] 大将军点数。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_JFD_PEZHETAIROS_CHAPTER_HISTORY_PARA_1",										"伙友步兵是马其顿军队和迪亚多奇王国的中坚力量。他们简直就是“徒步伙伴”。马其顿方阵几乎全部由伙友步兵组成。伙友步兵对抗骑兵和步兵都非常有效，因为他们的长矛可以用来刺穿骑在马上冲锋的敌人，或者用较短的武器挡住步兵。它们最早出现在腓力二世统治时期，尤其是在公元前338年腓力二世在查罗内亚战役中征服希腊时发挥了重要作用。");

---- 针对原模组对游戏自带文本的改动，添加条件语句，只有原模组启用且 文明扩展（CX） 未启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_UNIT_MACEDONIAN_HETAIROI_DESCRIPTION",
		"zh_Hans_CN",
		"亚历山大作为领袖时的马其顿特色重骑兵单位，取代骑手。与大将军相邻时额外+5 [ICON_Strength] 战斗力。击杀敌方单位可+5 [ICON_GreatGeneral] 大将军点数。初始拥有一次免费 [ICON_Promotion] 强化。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_LEADER_JFD_PHILIP_II_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "P0K_LOC_TRAIT_LEADER_BLACK_QUEEN_NAME");
