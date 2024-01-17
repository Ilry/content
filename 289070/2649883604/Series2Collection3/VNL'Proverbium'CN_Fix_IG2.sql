-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Proverbium'CN_Fix_IG2
-- Author: 邓半仙人 , Clear8Sky
-- DateCreated: 2021/11/14 13:48:38
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Proverbium”（其实是借该模组之名，对部分它尚未涉及到的引言进行简中修缮） 。该文件在 InGame 时载入，需高 LoadOrder 以保证其最后载入，需 Criteria ： Active_Mod_ProverbPlus

UPDATE LocalizedText
SET Text = 
	(CASE

------ 游戏自带的额外部分中文引言

		WHEN (Tag = "LOC_BUILDING_ALHAMBRA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "这里的一切似乎都是精心设计的，旨在激发灵感和幸福的情感，因为周围一切都是如此的精致与美丽。[NEWLINE]——华盛顿·欧文[NEWLINE][COLOR:ResCultureLabelCS]（美国短篇小说作家、诗人、散文家、传记作家、外交官、“美国文学之父”）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_PANTANAL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "潘塔纳尔是地球上最复杂的热带冲积平原，也许是世界上最不为人知的地区。[NEWLINE]——阿齐兹·阿布萨伯[NEWLINE][COLOR:ResCultureLabelCS]（巴西地理学家、巴西最受尊敬的科学家之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_DEAD_SEA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "就像死海岸边的苹果，一口全是灰烬的味。[NEWLINE]——乔治·戈登·拜伦[NEWLINE][COLOR:ResCultureLabelCS]（英国诗人、革命家、浪漫主义文学泰斗、世袭男爵、“拜伦勋爵（Lord Byron）”）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_YOSEMITE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "对我来说，约塞米蒂山谷永远是一个日出时，一个在巨大岩石和天地造化之间闪烁着绿光和金光的奇迹。[NEWLINE]——安塞尔·伊士顿·亚当斯[NEWLINE][COLOR:ResCultureLabelCS]（美国摄影师）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_EVEREST_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我们要征服的不是高山，而是我们自己。[NEWLINE]——艾德蒙·珀西瓦尔·希拉里[NEWLINE][COLOR:ResCultureLabelCS]（新西兰登山家、探险家、和丹增·诺盖成了可证明的记录中最早成功攀登珠峰峰顶的人）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_ULURU_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在雨季，这一定是一幅多么壮观的景象啊！到处都是瀑布！[NEWLINE]——威廉·克里斯蒂·戈斯[NEWLINE][COLOR:ResCultureLabelCS]（澳大利亚探险家）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_EYE_OF_THE_SAHARA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "奇怪的是，它似乎不是陨石留下的痕迹，而是一个深受侵蚀的穹顶，并有着彩虹般的配色。[NEWLINE]——克里斯·哈德菲尔[NEWLINE][COLOR:ResCultureLabelCS]（加拿大宇航员、工程师、加拿大皇家空军战斗机飞行员）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_TEMPLE_OF_ARTEMIS_QUOTE" AND Language = "zh_Hans_CN")
			THEN "当我看到阿尔忒弥斯神庙顶端直入云霄时，其他的奇观仿佛都失去了光彩，我说：“看啊，除了奥林匹斯山，太阳都还从未像它这么壮丽过。”[NEWLINE]——西顿的安提帕特[NEWLINE][COLOR:ResCultureLabelCS]（古希腊公元前2世纪诗人）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_PAMUKKALE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在美索吉旁，与劳迪希亚相对的便是希拉波利斯古城，那里盛产温泉，还有一座冥府之门（一座有通往地下含有毒气体通道的冥王神庙），而这两者的属性皆十分奇异。这里的泉水十分容易沉积石头。如果通过水道流通，就会形成由一整块石头组成的大坝。[NEWLINE]——斯特拉波[NEWLINE][COLOR:ResCultureLabelCS]（古希腊1世纪历史学家、地理学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_DEVILSTOWER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "七名女孩被熊追赶，当熊正要抓住它们时，女孩们跳上了一块低矮的岩石。其中一个女孩向岩石祈祷：“岩石可怜我们，岩石救救我们吧！”岩石听到并响应她们，开始向上生长，把女孩们推往天际。[NEWLINE]——基奥瓦人传说[NEWLINE][COLOR:ResCultureLabelCS]（基奥瓦人是美国大平原上的一个印第安人部落）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_VESUVIUS_QUOTE" AND Language = "zh_Hans_CN")
			THEN "海水似乎在翻滚，仿佛被大地剧烈运动从堤岸冲了出来；可以肯定，至少海岸变宽了，岸上还留下了几只海洋动物。另一边则是一片漆黑可怕的云团，飞快闪烁着锯齿形的光芒，在这后面则是形状各异的火团……[NEWLINE]——盖尤斯·普林尼·采西利尤斯·塞孔都斯[NEWLINE][COLOR:ResCultureLabelCS]（古罗马律师、作家、地方执政官）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_BERMUDA_TRIANGLE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "无人知晓这片海洋隐藏着的美妙秘密，它那温柔却骇人的波涛似乎在诉说，深处隐藏着某些灵魂…那里有着无数暗影、溺亡的梦想和幻想，那些被我们称为生命和灵魂的东西，仍在梦中反复沉溺。[NEWLINE]——赫尔曼·梅尔维尔[NEWLINE][COLOR:ResCultureLabelCS]（美国文艺复兴时期小说家、短篇小说家、诗人，代表作《白鲸记》被认为是美国最伟大的小说之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_CLIFFS_DOVER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在白色悬崖城垛上的王国政府里，一片寂静，比安息日还要寂静。[NEWLINE]——威廉·华兹华斯[NEWLINE][COLOR:ResCultureLabelCS]（英国浪漫主义诗人、桂冠诗人、湖畔诗人的代表）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_CRATER_LAKE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我再也没能看到地球上的美景，这些景色是我见过的最美好的事物。火山口湖是最美的景观。[NEWLINE]——杰克·伦敦[NEWLINE][COLOR:ResCultureLabelCS]（美国20世纪现实主义作家、世界文学史上最早的商业作家之一、商业作家的先锋、代表作《野性的呼唤》等）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_DELICATE_ARCH_QUOTE" AND Language = "zh_Hans_CN")
			THEN "如精致拱门蕴含重要意义，我将探索其中奥妙。自然之力怪奇无比，颠覆世人之常态感观。[NEWLINE]——爱德华·保罗·艾比[NEWLINE][COLOR:ResCultureLabelCS]（美国环保主义作家、散文家）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_GIANTS_CAUSEWAY_QUOTE" AND Language = "zh_Hans_CN")
			THEN "这里有深棕色的非晶玄武岩和红色的赭石，下面则是纤细而独特的木炭层。[NEWLINE]——《都柏林便士杂志》[NEWLINE][COLOR:ResCultureLabelCS]（1832～1836年每周六发行于爱尔兰首都都柏林的期刊杂志，内容关注有关爱尔兰的历史，传奇故事，地形地理和爱尔兰人身份问题，并用许多地图和木刻版画进行了插图说明）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_LYSEFJORDEN_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在这片海和无尽的孤独中出现了一条昏暗的道路，一条没有人类足迹的道路。没有人曾经过此地；亦没有船只曾在此航行。[NEWLINE]——维克多·雨果[NEWLINE][COLOR:ResCultureLabelCS]（法国作家、法国19世纪前期积极浪漫主义文学的代表作家、人道主义的代表人物、法国文学史上资产阶级民主作家代表、“法兰西的莎士比亚”）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_MATTERHORN_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我欲转身离去。最后一丝残阳落入厚重血红而深邃无边的远方，与它的峰巅在空中交汇。此刻，我为曾经向往的马特洪峰献出由衷的尊敬和赞美。[NEWLINE]——弗洛伦斯·克劳福德·格罗夫[NEWLINE][COLOR:ResCultureLabelCS]（英国登山家、作家）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_AMUNDSEN_SCOTT_RESEARCH_STATION_QUOTE" AND Language = "zh_Hans_CN")
			THEN "论科学领导力，斯科特首屈一指；而论行进之迅速高效，阿蒙森当仁不让。[NEWLINE]——雷蒙德·普雷斯特利[NEWLINE][COLOR:ResCultureLabelCS]（英国地质学家、南极探险家）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_APADANA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我的祖先大流士一世修建了这座阿帕达纳宫，但它却被无情烧毁。托阿胡拉·马兹达（祆教主神）、阿娜希塔（古波斯象征幸运和美丽的水之女神）和密特拉（原始伊朗宗教的主神，祆教化后成阿胡拉·马兹达创造出来的助手）的鸿福，我让它重见天日。[NEWLINE]——阿尔塔薛西斯二世[NEWLINE][COLOR:ResCultureLabelCS]（波斯阿契美尼德王朝国王）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_EIFFEL_TOWER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我应该嫉妒这座塔。她比我更出名。[NEWLINE]——亚历山大·古斯塔夫·埃菲尔[NEWLINE][COLOR:ResCultureLabelCS]（法国建筑大师、结构工程师、金属结构专家、作家、“用钢铁创造了奇迹的人”）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_HERMITAGE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "博物馆处于文化斗争的前沿，扬善抑恶——总之，一直在同陈腐和原始的东西做斗争。[NEWLINE]——米哈伊尔·鲍里索维奇·皮特罗夫斯基[NEWLINE][COLOR:ResCultureLabelCS]（俄罗斯东方学家、艾米尔塔什博物馆馆长）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_BROADWAY_QUOTE" AND Language = "zh_Hans_CN")
			THEN "轻歌曼舞好营生，娱乐业至上。[NEWLINE]——欧文·柏林，喜剧歌舞片《飞燕金枪》中的插曲[NEWLINE][COLOR:ResCultureLabelCS]（俄罗斯裔美国作曲家、流行音乐词作家、美国历史上最伟大的词曲作者之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_POTALA_PALACE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我第一次踏上布达拉宫房顶时，像步入生命的巅峰一般，这种感觉是前所未有的：整个人进入到从未有过的意识范围之中。[NEWLINE]——皮柯·耶尔[NEWLINE][COLOR:ResCultureLabelCS]（英国散文家、小说家）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_KILWA_KISIWANI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "基尔瓦基斯瓦尼是世界上建设得最为美丽的城市之一。房屋均为木制结构，房顶由草绳铺成，雨后生机勃勃。[NEWLINE]——伊本·白图泰[NEWLINE][COLOR:ResCultureLabelCS]（摩洛哥穆斯林学者、旅行家、伊斯兰教法官、世界上最伟大的旅行家之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_PYRAMIDS_QUOTE" AND Language = "zh_Hans_CN")
			THEN "四十个世纪从这些金字塔的顶端，俯瞰着我们。[NEWLINE]——拿破仑·波拿巴[NEWLINE][COLOR:ResCultureLabelCS]（法国军事家、政治家、法兰西第一帝国的缔造者、法兰西第一帝国皇帝、“法国人的皇帝”）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_ESTADIO_DO_MARACANA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "纵观历史，只有三个人能让马拉卡纳球场安静下来：教皇、法兰克·辛纳屈、我。[NEWLINE]——阿尔西德斯·吉贾[NEWLINE][COLOR:ResCultureLabelCS]（乌拉圭足球运动员）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_MEENAKSHI_TEMPLE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "向您致敬，伟大的米纳克希女神。您如若千万太阳般耀眼夺目，满身手镯花环更是五彩缤纷…您是吉祥的化身，亦是万物的象征。我愿永远臣服于您，因您的慈悲宛如无边汪洋。[NEWLINE]——阿迪·商羯罗[NEWLINE][COLOR:ResCultureLabelCS]（印度中世纪婆罗门教哲学家、吠檀多不二论理论家、）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_BOLSHOI_THEATER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "莫斯科大剧院芭蕾舞团是充满想象力的地方，一个具有魔法和吸引力的美丽浪漫之地。优雅的舞者、气势磅礴的音乐以及华丽的服饰让世人为之震撼。[NEWLINE]——特鲁迪·加芬克尔[NEWLINE][COLOR:ResCultureLabelCS]（美国芭蕾舞演员）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_UNIVERSITY_SANKORE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "学者皆是先知的子嗣。先知并未在世间留下任何财富，而是将宝贵的知识传给后人。[NEWLINE]——《穆斯纳德·阿尔·巴扎尔》[NEWLINE][COLOR:ResCultureLabelCS]（伊斯兰历史上哈菲兹·阿布·巴克尔·艾哈迈德·巴扎尔在公元3世纪写的圣训之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_MONT_ST_MICHEL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "教会和国家、灵魂和身体、神和人类，这些都是圣米歇尔山上的一个整体，主要任务是进行战斗，各行其事，或为彼此守卫。[NEWLINE]——亨利·亚当斯[NEWLINE][COLOR:ResCultureLabelCS]（美国历史学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_TAJ_MAHAL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "见过建造在空中的城堡吗？此物只应天上有，下凡人间便为岁月奇观。[NEWLINE]——贝亚德·泰勒[NEWLINE][COLOR:ResCultureLabelCS]（美国诗人、文学评论家、翻译、旅行作家、外交官）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_VENETIAN_ARSENAL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "威尼斯联邦的军械库上有这样一段题词：快乐是城市在和平时期想起战争的痛苦。[NEWLINE]——罗伯特·伯顿[NEWLINE][COLOR:ResCultureLabelCS]（英国作家、牛津大学研究员）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_SYDNEY_OPERA_HOUSE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在幕布拉起前很久，歌剧已经开始，在幕布降下后很久，歌剧才结束。它开始于我的想象中，变成了我的生命，在我离开歌剧院很久之后，它依然是我生活的一部分。[NEWLINE]——玛丽亚·卡拉斯[NEWLINE][COLOR:ResCultureLabelCS]（希腊裔美国女高音歌唱家、历史上最有影响力的女高音之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_ORSZAGHAZ_QUOTE" AND Language = "zh_Hans_CN")
			THEN "自由是自治之基础，而公正与爱国则是自由的根本。[NEWLINE]——科苏特·拉约什[NEWLINE][COLOR:ResCultureLabelCS]（匈牙利革命家、律师，记者、政治家）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_HUEY_TEOCALLI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "但维齐洛波奇特利（阿兹特克战神、特诺奇蒂特兰守护神、太阳神）非常生气，作为牺牲，穿过了4个房间，献身于太阳神，天空中的太阳消失了，或再次出现了。[NEWLINE]——弗雷·迭戈·杜兰[NEWLINE][COLOR:ResCultureLabelCS]（阿兹特克道明会修道士、西方著作中最知名的阿兹特克人）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_STATUE_OF_ZEUS_QUOTE" AND Language = "zh_Hans_CN")
			THEN "神的头上戴着一个橄榄叶桂冠，右手则握着带翅膀的胜利女神雕像。[NEWLINE]——塞缪尔·奥古斯都·米切尔[NEWLINE][COLOR:ResCultureLabelCS]（美国地理学家、教师）[ENDCOLOR]"
		WHEN (Tag = "LOC_BUILDING_STATUE_LIBERTY_QUOTE" AND Language = "zh_Hans_CN")
			THEN "海水冲刷，落日掩映，港口所在之处立有一巨大女子，手执火炬，散发自由之光芒。[NEWLINE]——艾玛·拉撒路[NEWLINE][COLOR:ResCultureLabelCS]（犹太裔美国女诗人、翻译家、犹太人积极分子）[ENDCOLOR]"
		WHEN (Tag = "LOC_TECH_ADVANCED_AI_QUOTE_1" AND Language = "zh_Hans_CN")
			THEN "我能恳求你以赞许的眼光来看待你所造之物吗？我在此祈求你的善良与恻隐之心。[NEWLINE]——玛丽·雪莱[NEWLINE][COLOR:ResCultureLabelCS]（英国女小说家、短篇作家、剧作家、随笔家、传记作家、旅游作家、“科幻小说之母”）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_WHITEDESERT_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我从我的族人那里取了满满一袋水，然后去了沙漠，[NEWLINE]在荒野中行走，而狼在嚎叫，就像一个因家人饥饿而冒险的赌徒。[NEWLINE]——伊姆鲁·盖斯[NEWLINE][COLOR:ResCultureLabelCS]（阿拉伯公元6世纪诗人、“阿拉伯诗歌之父”）[ENDCOLOR]"

------ 对部分奇观模组的中文引言进行修缮

		WHEN (Tag = "LOC_FEATURE_SUK_GRANDCANYON_QUOTE" AND Language = "zh_Hans_CN")
			THEN "亚利桑那州有座举世无双的伟大奇观，就在这科罗拉多大峡谷之中。你无法去改良它，多少世纪的时光塑造它如今的瑰丽，而人类的“改良”只会适得其反。[NEWLINE]——西奥多·罗斯福[NEWLINE][COLOR:ResCultureLabelCS]（荷兰裔美国军事家、政治家、外交家、第26任美国总统、美国历史上最年轻的在任总统、美国历史上最伟大的总统之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_SUK_FUJI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "一寸寸，[NEWLINE]小蜗牛，[NEWLINE]爬向富士山！[NEWLINE]——小林一茶[NEWLINE][COLOR:ResCultureLabelCS]（日本江户时期俳句诗人）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_SUK_GREATBLUEHOLE_QUOTE" AND Language = "zh_Hans_CN")
			THEN "自出生伊始，人就将地心引力负于肩上，缚于大地。然而，仅需潜入水中，他就自由了。[NEWLINE]——雅克·伊夫·库斯托[NEWLINE][COLOR:ResCultureLabelCS]（法国海军军官、探险家、生态学家、电影制片人、摄影家、作家、海洋、海洋生物研究者、法兰西学院院士）[ENDCOLOR]"
		WHEN (Tag = "LOC_FEATURE_SUK_NGORONGORO_CRATER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "没人敢说自己能永远定居于某处；只有群山，能岿然不动，安于此地。[NEWLINE]——马赛人谚语"
		WHEN (Tag = "LOC_FEATURE_SUK_TONLESAP_QUOTE" AND Language = "zh_Hans_CN")
			THEN "一年中有五个多月的时间，柬埔寨的大片土地都被洞里萨湖的湖面覆盖；这段时期过后，湖水深度虽因大量蒸发而降低，但其面积却几乎不变。[NEWLINE]——亨利·穆奥[NEWLINE][COLOR:ResCultureLabelCS]（法国博物学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_BARRINGER_CRATER_QUOTE" AND Language = "zh_Hans_CN")
			THEN "事实上，我们现在可以证明，该陨石坑是由一个地外天体，可能是颗金属陨星与地球碰撞造成的。[NEWLINE]——丹尼尔·巴林杰[NEWLINE][COLOR:ResCultureLabelCS]（美国地质学家、确认陨石撞击地球而形成撞击坑的第一人）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_BIOLUMINESCENT_BAY_QUOTE" AND Language = "zh_Hans_CN")
			THEN "火焰、闪电、繁星或生物发出的光会吸引任何人的注意。而在众多生物的光亮里，有一种奇异的淡芒，魔幻而又神秘。[NEWLINE]——卡西乌斯·斯蒂瓦尼[NEWLINE][COLOR:ResCultureLabelCS]（巴西基础化学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_CERRO_DE_POTOSI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我是富饶的波托西，世界之宝，群山之王，万王之羡。[NEWLINE]——玻利维亚波托西第一纹章"
		WHEN (Tag = "LOC_TM_FEATURE_DALLOL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "那就是地狱，黑暗，炽焰与糜腐！死灭与绝顶！[NEWLINE]——威廉·莎士比亚《李耳王》[NEWLINE][COLOR:ResCultureLabelCS]（英国文艺复兴时期剧作家、诗人、演员、英国大文豪）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_GRAND_MESA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "保护意味着明智合理地利用地球和它的资源来为人类带来长久利益。[NEWLINE]——吉福德·平肖[NEWLINE][COLOR:ResCultureLabelCS]（美国护林员、政治家、美国林业局第1\4任局长、宾夕法尼亚州第28任州长）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_KAILASH_QUOTE" AND Language = "zh_Hans_CN")
			THEN "如此指示众神之后，梵天带着他的祖先和人民的领袖离开了他自己的地方，去了湿婆神的住所——冈底斯山，众山之中最为珍贵的圣地。[NEWLINE]——《薄伽梵往世书》[NEWLINE][COLOR:ResCultureLabelCS]（印度教经典、印度教的十八个大往世书之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_KRAKATOA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我惊讶地看到，克拉卡托岛在我们眼前被完全烧毁，荒芜不堪，有四个地方都在不停喷火。[NEWLINE]——约翰·威廉·沃格尔[NEWLINE][COLOR:ResCultureLabelCS]（德国司机、山地督察、作家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_LAKE_VICTORIA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我真切看到老尼罗河发源于维多利亚尼亚扎河，正如我所预言的那样；那湖是圣河的伟大源头，孕育了我们宗教信仰的首位阐释者。[NEWLINE]——约翰·汉宁·斯佩克[NEWLINE][COLOR:ResCultureLabelCS]（英国英属印度陆军军官、探险家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_LENCOIS_MARANHENSES_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我看到白色与金色沙粒组成的‘草地’，随着熙风的心血来潮不断改变着它们的‘生长’形状。[NEWLINE]——吉尔特·毛里西奥·巴斯[NEWLINE][COLOR:ResCultureLabelCS]（比利时旅行社总经理）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_MOSI_OA_TUNYA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我怀着敬畏的心情爬到悬崖边上，从一处大裂口向下望去：只见一条上千码宽的溪流跃下一百英尺，随后骤然挤压进十五至二十码的空间，这是我在非洲见过的最美妙的景象了。[NEWLINE]——大卫·利文斯通[NEWLINE][COLOR:ResCultureLabelCS]（苏格兰裔英国医生、非洲探险家、公理派传教士、伦敦传教士协会的基督教先驱、非洲探险的最伟大人物之一、19世纪末维多利亚时代最受欢迎的英国英雄之一）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_MOTLATSE_CANYON_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我相信南非是地球上最美丽的地方。诚然，我是有偏见的，但我认为即使是最严谨的评论家也会同意，我们有幸拥有一片真正美好的土地。[NEWLINE]——纳尔逊·罗利赫拉赫拉·曼德拉[NEWLINE][COLOR:ResCultureLabelCS]（南非总统、首位黑人总统、非国大青年联盟全国书记/主席、“南非国父”）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_NAMIB_QUOTE" AND Language = "zh_Hans_CN")
			THEN "我喜欢听沙丘发出的声音，我是那些在许多传世绘作中感知到绝景韵味的人之一，也是成千上万知晓‘我已归乡’的游子之一。[NEWLINE]——姆瓦拉·亚·南戈洛[NEWLINE][COLOR:ResCultureLabelCS]（纳米比亚新闻工作者、诗人）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_OLD_FAITHFUL_QUOTE" AND Language = "zh_Hans_CN")
			THEN "在我们逗留期间，它定期喷水九次，每次喷出的沸水柱从九十英尺到一百二十五英尺不等，持续十五到二十分钟。所以我们叫它老忠实泉。[NEWLINE]——纳撒尼尔·皮特·朗福德[NEWLINE][COLOR:ResCultureLabelCS]（美国探险家、商人、官僚主义者、义务警员、历史学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_OUNIANGA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "最初，沙漠的语言是迎风生长的青草，高大的棕榈树在播种季节摇曳，灰烬被空气带到温暖的沙滩上迎接那抹‘蓝色’的拥抱。她是我们的第一涌喷泉，是我们的母亲，将我们拥入怀中，最终又把我们送入已候多时的城市时代。[NEWLINE]——阿尔·蒙西夫·瓦海比[NEWLINE][COLOR:ResCultureLabelCS]（中东诗人）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_GIBRALTAR_QUOTE" AND Language = "zh_Hans_CN")
			THEN "看看四周吧，我的孩子们，看那岩石在熊熊火焰的照耀下显得多么美丽。[NEWLINE]——乔治·奥古斯都·艾略特[NEWLINE][COLOR:ResCultureLabelCS]（英国军官）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_SALAR_DE_UYUNI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "每当听见来自沙漠中盐粒的怖音，我就越发颤抖，倍感孤独。[NEWLINE]——巴勃罗·聂鲁达[NEWLINE][COLOR:ResCultureLabelCS]（智利外交官、诗人）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_SINAI_QUOTE" AND Language = "zh_Hans_CN")
			THEN "耶和华在西奈山上对摩西说完了话，就把两块约律法的版交给摩西，就是　神用指头刻的石版。[NEWLINE]——《旧约圣经》出埃及记31:18[NEWLINE][COLOR:ResCultureLabelCS]（犹太教与基督教的共同经典）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_SRI_PADA_QUOTE" AND Language = "zh_Hans_CN")
			THEN "一幅极其奇妙的景象，被赋予了至高无上的光辉。[NEWLINE]——《摩诃婆罗多》[NEWLINE][COLOR:ResCultureLabelCS]（印度民族史诗、“印度的灵魂”）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_VREDEFORT_DOME_QUOTE" AND Language = "zh_Hans_CN")
			THEN "近150年前，当地质学家第一次漫步于跨越佛雷德福北部瓦尔河的壮观环山时，他们突然意识到，这些异常破碎和隆起的岩石见证了遥远过去发生的一次极其惨烈的灾难。[NEWLINE]——沃尔夫·乌韦·赖莫尔德[NEWLINE][COLOR:ResCultureLabelCS]（南非地质学家、矿学家）[ENDCOLOR]"
		WHEN (Tag = "LOC_TM_FEATURE_WULINGYUAN_QUOTE" AND Language = "zh_Hans_CN")
			THEN "万壑树参天，[NEWLINE]千山响杜鹃。[NEWLINE]山中一夜雨，[NEWLINE]树杪百重泉。[NEWLINE]——王维《送梓州李使君》[NEWLINE][COLOR:ResCultureLabelCS]（中国唐朝诗人、画家、“诗佛”、南宗山水画之祖、与孟浩然合称“王孟”）[ENDCOLOR]"
	END)
WHERE Tag IN
(
	"LOC_BUILDING_ALHAMBRA_QUOTE",
	"LOC_FEATURE_PANTANAL_QUOTE",
	"LOC_FEATURE_DEAD_SEA_QUOTE",
	"LOC_FEATURE_YOSEMITE_QUOTE",
	"LOC_FEATURE_EVEREST_QUOTE",
	"LOC_FEATURE_ULURU_QUOTE",
	"LOC_FEATURE_EYE_OF_THE_SAHARA_QUOTE",
	"LOC_BUILDING_TEMPLE_OF_ARTEMIS_QUOTE",
	"LOC_FEATURE_PAMUKKALE_QUOTE",
	"LOC_FEATURE_DEVILSTOWER_QUOTE",
	"LOC_FEATURE_VESUVIUS_QUOTE",
	"LOC_FEATURE_BERMUDA_TRIANGLE_QUOTE",
	"LOC_FEATURE_CLIFFS_DOVER_QUOTE",
	"LOC_FEATURE_CRATER_LAKE_QUOTE",
	"LOC_FEATURE_DELICATE_ARCH_QUOTE",
	"LOC_FEATURE_GIANTS_CAUSEWAY_QUOTE",
	"LOC_FEATURE_LYSEFJORDEN_QUOTE",
	"LOC_FEATURE_MATTERHORN_QUOTE",
	"LOC_BUILDING_AMUNDSEN_SCOTT_RESEARCH_STATION_QUOTE",
	"LOC_BUILDING_APADANA_QUOTE",
	"LOC_BUILDING_EIFFEL_TOWER_QUOTE",
	"LOC_BUILDING_HERMITAGE_QUOTE",
	"LOC_BUILDING_BROADWAY_QUOTE",
	"LOC_BUILDING_POTALA_PALACE_QUOTE",
	"LOC_BUILDING_KILWA_KISIWANI_QUOTE",
	"LOC_BUILDING_PYRAMIDS_QUOTE",
	"LOC_BUILDING_ESTADIO_DO_MARACANA_QUOTE",
	"LOC_BUILDING_MEENAKSHI_TEMPLE_QUOTE",
	"LOC_BUILDING_BOLSHOI_THEATER_QUOTE",
	"LOC_BUILDING_UNIVERSITY_SANKORE_QUOTE",
	"LOC_BUILDING_MONT_ST_MICHEL_QUOTE",
	"LOC_BUILDING_TAJ_MAHAL_QUOTE",
	"LOC_BUILDING_VENETIAN_ARSENAL_QUOTE",
	"LOC_BUILDING_SYDNEY_OPERA_HOUSE_QUOTE",
	"LOC_BUILDING_ORSZAGHAZ_QUOTE",
	"LOC_BUILDING_HUEY_TEOCALLI_QUOTE",
	"LOC_BUILDING_STATUE_OF_ZEUS_QUOTE",
	"LOC_BUILDING_STATUE_LIBERTY_QUOTE",
	"LOC_TECH_ADVANCED_AI_QUOTE_1",
	"LOC_FEATURE_WHITEDESERT_QUOTE",
	"LOC_FEATURE_SUK_GRANDCANYON_QUOTE",
	"LOC_FEATURE_SUK_FUJI_QUOTE",
	"LOC_FEATURE_SUK_GREATBLUEHOLE_QUOTE",
	"LOC_FEATURE_SUK_NGORONGORO_CRATER_QUOTE",
	"LOC_FEATURE_SUK_TONLESAP_QUOTE",
	"LOC_TM_FEATURE_BARRINGER_CRATER_QUOTE",
	"LOC_TM_FEATURE_BIOLUMINESCENT_BAY_QUOTE",
	"LOC_TM_FEATURE_CERRO_DE_POTOSI_QUOTE",
	"LOC_TM_FEATURE_DALLOL_QUOTE",
	"LOC_TM_FEATURE_GRAND_MESA_QUOTE",
	"LOC_TM_FEATURE_KAILASH_QUOTE",
	"LOC_TM_FEATURE_KRAKATOA_QUOTE",
	"LOC_TM_FEATURE_LAKE_VICTORIA_QUOTE",
	"LOC_TM_FEATURE_LENCOIS_MARANHENSES_QUOTE",
	"LOC_TM_FEATURE_MOSI_OA_TUNYA_QUOTE",
	"LOC_TM_FEATURE_MOTLATSE_CANYON_QUOTE",
	"LOC_TM_FEATURE_NAMIB_QUOTE",
	"LOC_TM_FEATURE_OLD_FAITHFUL_QUOTE",
	"LOC_TM_FEATURE_OUNIANGA_QUOTE",
	"LOC_TM_FEATURE_GIBRALTAR_QUOTE",
	"LOC_TM_FEATURE_SALAR_DE_UYUNI_QUOTE",
	"LOC_TM_FEATURE_SINAI_QUOTE",
	"LOC_TM_FEATURE_SRI_PADA_QUOTE",
	"LOC_TM_FEATURE_VREDEFORT_DOME_QUOTE",
	"LOC_TM_FEATURE_WULINGYUAN_QUOTE"
);
	