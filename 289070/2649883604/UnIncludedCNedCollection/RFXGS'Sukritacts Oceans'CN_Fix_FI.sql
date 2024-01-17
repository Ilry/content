-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'Sukritacts Oceans'CN_Fix_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/6 17:54:52
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Oceans”的 Suk_Oceans_Localisation.sql文件 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																		Text)
VALUES

---- 游戏模式

		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_OCEANS_NAME",												"Sukritact的[COLOR_FLOAT_GOLD]缤[COLOR_FLOAT_FOOD]纷[COLOR:Civ6Blue]海洋"),
		("zh_Hans_CN",	"LOC_GAMEMODE_SUK_OCEANS_DESCRIPTION",										"该游戏模式为世界海洋注入了新的活力，带来了新的资源、新的功能和新的游戏玩法。[NEWLINE][NEWLINE]海藻森林遍布海岸，提供食物的同时，还会减缓海上单位在其上的移动速度；增添了诸多新资源（如海豹、鱿鱼和珊瑚等），提升了海洋资源的多样性，静候您的探索；对于不同大陆的海岸，将会提供截然不同的奢侈品资源，因而，探索远方将意味着发现财富；水上乐园、渔场等区域与建筑也对以上内容进行了适当调整。");

/*
---- 鱿鱼（此处及以下百科内容部分为笨蛋奶二创，但由于原模组已有中文，故此处注释掉）
		("zh_Hans_CN",	"LOC_RESOURCE_SUK_SQUID_NAME",												"鱿鱼"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_SQUID_CHAPTER_HISTORY_PARA_1",		"鱿鱼，也称柔鱼、枪乌贼，是软体动物门头足纲鞘亚纲十腕总目管鱿目开眼亚目的动物。体圆锥形，体色苍白，有淡褐色斑，头大，前方生有触足10条，尾端的肉鳍呈三角形，常成群游弋于深约20米的海洋中。已经存在大约五亿年，鱿鱼在世界各地的海洋中都有。一些鱿鱼喜欢温暖的热带水域，而另一些鱿鱼则在寒冷的海洋中繁衍生息。它们是最聪明的无脊椎动物之一，其中两个物种“大王乌贼”和“大王酸浆鱿”它们甚至能和巨型抹香鲸搏斗，并且在欧洲中世纪成为触手状海怪的原型。"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_SQUID_CHAPTER_HISTORY_PARA_2",		"鱿鱼体内具有二片鳃作为呼吸器官；身体分为头部、很短的颈部中国枪乌贼（俗称“鱿鱼”），肉质细嫩，干制品称“鱿鱼干”，肉质特佳，在国内外海味市场负有盛名，年产4至5万吨，主要渔场在中国海南北部湾、福建南部、台湾、广东、河北渤海湾和广西近海，以及菲律宾、越南和泰国近海，其中以南海北部湾、渤海湾出产的鱿鱼为最佳。[NEWLINE][NEWLINE]鱿鱼，虽然习惯上称它们为鱼，其实它并不是鱼，而是生活在海洋中的软体动物，身体细长，呈长锥形，前端有吸盘。鱿鱼体内具有二片鳃作为呼吸器官；身体分为头部、很短的颈部和躯干部。身体细长，呈长锥形，其中两只较长。在分类学上，鱿鱼是属于软体动物门——头足纲——二鳃亚纲——十腕目的动物。头部两侧具有一对发达的眼和围绕口周围的腕足。"),

---- 海豹

		("zh_Hans_CN",	"LOC_RESOURCE_SUK_SEALS_NAME",												"海豹"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_SEALS_CHAPTER_HISTORY_PARA_1",		"今天有33种鳍足动物存活，其中大部分被称为海豹。在地球上的每一个大陆上都可以发现鳍足动物，尽管大多数物种都生活在寒冷的环境中。虽然物种之间有很多差异，但所有的海豹都有脚状的鳍。事实上，单词pinniped在拉丁语中的意思是“鳍足的”。海豹的体型大不相同，从体型庞大的南象海豹到相对纤细的100磅贝加尔湖海豹，南象海豹的重量可以超过一辆皮卡车。"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_SEALS_CHAPTER_HISTORY_PARA_2",		"海豹的前脚较后脚为短，覆有毛的鳍脚皆有指甲，指甲为5趾。耳朵变得极小或退化成只剩下两个洞，游泳时可自由开闭。游泳时大都靠后脚，但后脚不能向前弯曲，脚跟已退化与海狮及海狗等相异，不能行走，所以当它在陆地上活动时，总是拖著累赘的后肢，将身体弯曲爬行，并在地面上留下一行扭曲痕迹。海狮、海象是海豹的近亲，它们有耳壳，后肢能转向前方来支持身体。[NEWLINE][NEWLINE]从历史上看，猎人们一直狩猎海豹。这种做法导致海豹种类的灭绝：例如，加勒比僧海豹在20世纪70年代从地球上消失了。尽管狩猎在今天受到了更严格的管制，但这些动物仍然面临许多威胁，包括缺乏食物、被渔具缠住以及与渔民发生冲突。一些物种，如夏威夷僧海豹和地中海僧海豹，仍然非常接近灭绝。然而气候变化是最大的威胁."),

---- 珊瑚礁

		("zh_Hans_CN",	"LOC_RESOURCE_SUK_CORAL_NAME",												"珊瑚礁"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_CORAL_CHAPTER_HISTORY_PARA_1",		"珊瑚礁是石珊瑚目的动物形成的一种结构，这个结构可以大到影响其周围环境的物理和生态条件。在深海和浅海中均有珊瑚礁存在，它们是成千上万的由碳酸钙组成的珊瑚虫的骨骼在数百年至数千年的生长过程中形成的。珊瑚礁为许多动植物提供了生活环境，其中包括蠕虫、软体动物、海绵、棘皮动物和甲壳动物，此外珊瑚礁还是大洋带的鱼类的幼鱼生长地"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_CORAL_CHAPTER_HISTORY_PARA_2",		"由于对水温、水质极端敏感，随着全球暖化的发生，自20世纪末起已造成多数的珊瑚迅速死亡，因而今天许多礁岩岸其实是曾存在珊瑚群的，但都已经消失了。珊瑚在长达5亿年的演变过程中保持了顽强的生命力，不论是狂风暴雨、火山爆发还是海平面的升降都没能让珊瑚灭绝，然而珊瑚能抵御地球以万年为单位的生态变化，却不能应付人类近百年带来的快速环境变动。2004年由联合国环境规划署提供的数据表明，全世界的珊瑚礁有11%遭灭顶之灾，16%已不能发挥生态功能，60%正面临严重威胁。"),

---- 龙虾

		("zh_Hans_CN",	"LOC_RESOURCE_SUK_LOBSTER_NAME",											"龙虾"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_LOBSTER_CHAPTER_HISTORY_PARA_1",		"龙虾是一个大型海洋甲壳类动物科。它们的身体很长，尾巴肌肉发达，生活在海底的裂缝或洞穴中。它们的五对腿中有三对有爪子，其中第一对通常比其他的大得多。龙虾肉质鲜美口感绝佳，是十分贵重的海产。而且在它们居住的沿海地区常常作为重要的出口食品。"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_LOBSTER_CHAPTER_HISTORY_PARA_2",		"龙虾体内很重要的虾青素是科学发现的最强的一种抗氧化剂，颜色越深说明虾青素含量越高。广泛用在化妆品、食品添加剂、以及药品。日本大阪大学的科学家发现，虾体内的虾青素有助于消除因时差反应而产生的“时差症”。 水产品的营养素种类与含量都不亚于畜禽肉，而各种虾体内的营养成分几乎是一致的。各种虾体内含的都是高蛋白、低脂肪，蛋白含量占总体的16%～20%左右，脂肪含量不到0.2%。而且所含的脂肪主要是由不饱合脂肪酸组成的。虾肉内锌、碘、硒等微量元素的含量要高于其它食品。 龙虾不仅是肉洁白细嫩，味道鲜美，高蛋白，低脂肪，营养丰富。"),

---- 鱼子酱

		("zh_Hans_CN",	"LOC_RESOURCE_SUK_CAVIAR_NAME",												"鱼子酱"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_CAVIAR_CHAPTER_HISTORY_PARA_1",		"如果说有一种食物与纯粹的奢侈有关，那就是鱼子酱。传统意义上的鱼子酱是指经过盐渍的鲟鱼子，它的价值等于植物界里的松露，价格昂贵，很久以来都是西方餐桌上的“奢侈品”。鱼子酱来自几种鲟鱼，但白鲸鱼子酱是最大，最稀有，最昂贵的鱼子酱。鱼子酱的价格接近每磅3500美元，因此不愧为“黑金”的绰号。根据国家的不同，鱼子酱还可以用来形容其他鱼类的鱼卵，如鲑鱼、钢头鱼、鳟鱼、团鱼、白鱼或鲤鱼。"),
		("zh_Hans_CN",	"LOC_PEDIA_RESOURCES_PAGE_RESOURCE_SUK_CAVIAR_CHAPTER_HISTORY_PARA_2",		"鲟鱼的数量在全球范围内已经减少，部分原因是鱼子酱作为一种奢侈食品的受欢迎程度，现在许多地方都有严格的捕捞限制甚至禁令。其他导致鱼类数量下降的原因还包括水污染和河坝造成的栖息地丧失，这些河坝阻碍了鱼类到达产卵地。许多鲟鱼都在濒危物种名单上。为了减轻野生鲟鱼数量减少的压力，在20个国家有公司养殖鲟鱼。在绝大多数情况下，鱼卵是在杀死鱼后取出的。其他公司也尝试了一种更持久的方法，先把鱼养到可以产卵的时候，然后，在剖腹产下鱼卵后，把鱼缝起来，再养起来，以便生产更多的鱼。这个过程对鱼来说非常困难，而且在一些国家已经被禁止。"),

---- 海藻林

		("zh_Hans_CN",	"LOC_FEATURE_SUK_KELP_NAME",												"海藻林"),
		("zh_Hans_CN",	"LOC_PEDIA_FEATURES_PAGE_FEATURE_SUK_KELP_CHAPTER_HISTORY_PARA_1",			"海藻林是由海带目（Laminariales）大型褐藻所构成的海底森林，为最富有丰富生产力与多样性的地球生态系统。[NEWLINE][NEWLINE]较小片的海藻林又被称为海藻床。全球海藻林分布海藻林分布于温带到极地地区的沿岸海域。[NEWLINE][NEWLINE]在2007年，于厄瓜多尔附近的热带海域也发现有海藻林分布。和热带的珊瑚礁一样，海藻林为许多生物提供生活环境，包括软体动物、甲壳动物、棘皮动物、鱼类及海洋哺乳动物等；同时也为人类提供生产力丰富的渔场。然而，人类活动正逐渐影响海藻林的分布。针对某些物种的过度捕捞会使得部分草食动物（例如：海胆、褐蓝子鱼）的数量失控，进而将海藻啃食殆尽。");
*/

---- 水上乐园改动，针对原模组对游戏自带文本的改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText	-- NOT 条件是 Entertainment District Expansion模组 也对此做了基于“缤纷海洋”的改动，且载入顺序：缤纷(5)→EDE(273)；仿照原顺序，在 靠前的 此处添加条件以保证 靠后的 确实能覆盖成功
		(Tag,	Language,	Text)
SELECT	"LOC_DISTRICT_WATER_ENTERTAINMENT_COMPLEX_DESCRIPTION",
		"zh_Hans_CN",
		"只能建在海岸与湖泊上的区域，可增加城市的 [ICON_Amenities] 宜居度。若与海藻森林相邻，则额外+1 [ICON_Amenities] 宜居度。不能建在拥有娱乐中心的城市。不能建在礁石上。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RESOURCE_SUK_SQUID_NAME" AND Language = "en_US"))
AND NOT EXISTS (SELECT Tag FROM EnglishText WHERE Tag = "LOC_BUILDING_JNR_MARINA_NAME");

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_AQUARIUM_DESCRIPTION",
		"zh_Hans_CN",
		"[ICON_Amenities] 宜居度加成可延伸至9格范围内的所有城市（前提是它们没有获得来自其他水族馆的加成）。此城每处珊瑚、海藻森林与海难遗址产出+1 [ICON_Science] 科技值；若其与水上乐园相邻，则额外产出+1 [ICON_Science] 科技值。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RESOURCE_SUK_SQUID_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_AQUATICS_CENTER_DESCRIPTION",
		"zh_Hans_CN",
		"[ICON_Amenities] 宜居度加成可延伸至9格范围内的所有城市（前提是它们没有获得来自其他水族馆的加成）。每相邻一处海岸地貌，则+2 [ICON_Tourism] 旅游业绩。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RESOURCE_SUK_SQUID_NAME" AND Language = "en_US"));

---- 渔场改动，针对原模组对游戏自带文本的改动，添加条件语句，只有原模组启用时以下替换才生效

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_GOVERNOR_PROMOTION_AQUACULTURE_DESCRIPTION",
		"zh_Hans_CN",
		"可修建渔场改良设施。+1 [ICON_Housing] 住房。若渔船与之相邻，则+2 [ICON_Food] 食物；若所在城市有 [ICON_Governor] 总督“梁”就职，则额外+1 [ICON_Production] 生产力。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RESOURCE_SUK_SQUID_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_IMPROVEMENT_FISHERY_DESCRIPTION",
		"zh_Hans_CN",
		"一种 [ICON_Governor] 总督特色改良设施，可在拥有“水产养殖”头衔的“梁”就职的城市中修建。[NEWLINE][NEWLINE]该单元格不能分配 [ICON_Citizen] 公民。若渔船与渔场相邻，则+2 [ICON_Food] 食物；若所在城市有 [ICON_Governor] 总督“梁”就职，则额外+1 [ICON_Production] 生产力。+1 [ICON_Housing] 住房。必须建在于海洋资源相邻的海岸与湖泊单元格上。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_RESOURCE_SUK_SQUID_NAME" AND Language = "en_US"));






