-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'Sukritacts Trisong Detsen (Tibet)'CN_Add_FI
-- Author: ChiYiuWong , LouisOdin , Clear8Sky
-- DateCreated: 2021/9/26 9:07:56
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Sukritact's Trisong Detsen (Tibet)” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																			Text)
VALUES

---- 吐蕃

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_TIBET_NAME",												"吐蕃"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_TIBET_DESCRIPTION",										"吐蕃帝国"),
		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_TIBET_ADJECTIVE",											"吐蕃的"),

------ RwF模组

		("zh_Hans_CN",	"LOC_CIVILIZATION_SUK_TIBET_DESCRIPTION_JFD_CIVILIZATION",						"吐蕃文明"),

---- 文明特性

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_DHARMA_KINGS_NAME",									"法王"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_DHARMA_KINGS_DESCRIPTION",							"专业化区域与帝国境内的山脉相邻时，其产出额外+2，且可用 [ICON_Faith] 信仰值购买该区域的建筑。有 [ICON_Governor] 总督就职的城市，其每次升级则该城市+5% [ICON_Faith] 信仰值产出。"),				

		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_DHARMA_KINGS_NAME_XP2",								"世界屋脊"),
		("zh_Hans_CN",	"LOC_TRAIT_CIVILIZATION_SUK_DHARMA_KINGS_DESCRIPTION_XP2",						"[ICON_Citizen] 公民可在山脉单元格中工作。在山脉单元格2格范围内：若有市中心，则其产出+2 [ICON_Food] 食物；若有其他区域，则+1各自类型的产出。专业化区域与帝国境内的山脉相邻时，可用 [ICON_Faith] 信仰值购买该区域的建筑。有 [ICON_Governor] 总督就职的城市，其每次升级则该城市+5% [ICON_Faith] 信仰值产出。"),

		("zh_Hans_CN",	"LOC_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE_TOOLTIP",							"{Value : number +#;-#}%（{ActualValue : number +#.#;-#.#}） 来自拥有{1}次{1 : plural 1?升级; other?升级;}的 [ICON_Governor] 总督"),

---- 城市
	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_LHASA",												"拉萨"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_ZHIKATSE",												"日喀则"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_GYANTSE",												"江孜"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_CHAMDO",												"昌都"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_TSETANG",												"泽当"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_SENGGE_KHABAP",										"扎布让"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_PARO",													"帕罗"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_NAKCHU",												"那曲"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_KYEGUDO",												"玉树"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_KHYUNGLUNG",											"曲隆"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_DARTSEDO",												"康定"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_NYINGTRI",												"林芝"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_NEDONG",												"乃东"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_TSOCHEN",												"措勤"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_BARKHAM",												"马尔康"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_SAKYA",												"萨迦"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_KARDZE",												"甘孜"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_PEMBAR",												"边坝"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_LHATSE",												"拉孜"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_GANGGA",												"岗嘎"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_MACHEN",												"玛沁"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_NAGORMO",												"格尔木"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_TAWANG",												"达旺"),	
		("zh_Hans_CN",	"LOC_CITY_NAME_SUK_TIBET_LE",													"列城"),

---- 公民

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_1",													"丹增"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_2",													"钦布"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_3",													"江央"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_4",													"丹巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_5",													"多杰"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_6",													"仁增"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_7",													"嘉措"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_8",													"强巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_9",													"顿珠"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MALE_10",												"贡布"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_1",												"玛吉"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_2",												"策旺"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_3",												"卓玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_4",												"洛桑"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_5",												"尼玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_6",												"拉珍"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_7",												"德芊"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_8",												"拉则"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_9",												"格桑"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_FEMALE_10",												"央金"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_1",											"晋美"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_2",											"彭措"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_3",											"桑盖"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_4",											"罗桑"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_5",											"坚错"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_6",											"拉巴"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_7",											"措姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_8",											"扎什"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_9",											"罗布"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_MALE_10",											"次旦"),

		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_1",										"索纳姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_2",										"旺姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_3",										"次仁"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_4",										"曲珍"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_5",										"布赤"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_6",										"米玛"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_7",										"拉姆"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_8",										"麦朵"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_9",										"曲措"),
		("zh_Hans_CN",	"LOC_CITIZEN_SUK_TIBET_MODERN_FEMALE_10",										"本玛"),

---- 地名

		("zh_Hans_CN",	"LOC_NAMED_RIVER_YARLUNG_TSANGPO_NAME",											"雅鲁藏布江"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_PARLUNG_TSANGPO_NAME",											"巴龙藏布江"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_LHASA_NAME",													"拉萨河"),
		("zh_Hans_CN",	"LOC_NAMED_RIVER_NYANG_NAME",													"尼洋河"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_DANGLA_NAME",												"喜马拉雅山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_TANIANTAWENG_NAME",											"他念他翁山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_NYENCHEN_TANGLHA_NAME",										"念青唐古拉山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_NALAKANKAR_HIMAL_NAME",										"西瓦利克山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_ROLWALING_HIMAL_NAME",										"喀喇昆仑山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_GANESH_HIMAL_NAME",											"冈底斯山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_NAMCHA_BARWA_HIMAL_NAME",									"阿尼玛卿山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_MAHALANGUR_HIMAL_NAME",										"马卡鲁山脉"),
		("zh_Hans_CN",	"LOC_NAMED_MOUNTAIN_KANGRI_GARPO_NAME",											"岗日嘎布山脉"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_ASHIKULE_VOLCANIC_FIELD_NAME",								"阿什库勒火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_BAMAOQIONGZONG_NAME",										"巴毛穷宗火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_YONGBOHU_NAME",												"涌波错火山"),
		("zh_Hans_CN",	"LOC_NAMED_VOLCANO_QIANGBAQIAN_NAME",											"羌巴欠火山"),	

---- 信息

		("zh_Hans_CN",	"LOC_CIVINFO_SUK_TIBET_LOCATION",												"亚洲"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_TIBET_SIZE",													"约47.4千万平方英里（122.8万平方公里）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_TIBET_POPULATION",												"约318万（2014年10月）"),
		("zh_Hans_CN",	"LOC_CIVINFO_SUK_TIBET_CAPITAL",												"拉萨"),

---- 文明百科

		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_1",	"吐蕃的统一始于松赞干布（公元604-650年）的统治，他统一了雅鲁藏布江流域的部分地区并建立了吐蕃帝国。他在位期间在西藏地区进行了诸多改革，使得吐蕃的势力快速扩张，成为了一个庞大而又强盛的王国。他的第一任妻子一般被认为是在建立藏传佛教的过程中扮演了重要角色的尼泊尔公主布丽库提。公元640年，他娶了中国唐朝太宗皇帝的侄女文成公主，相传她本人也是佛教徒。八世纪初，大批为了逃离阿拉伯和哈萨克地区穆斯林军队的中亚佛教徒涌入吐蕃，使得藏传佛家得到了很好的发展。松赞干布和其后裔也在663年至692年间征服了现今中国的青海，甘肃以及新疆等省份的大部分地区。这些边境地区的控制权将在未来几个世纪里来回易手。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_2",	"八世纪初，中国力量日渐强大，高仙芝将军的帝国军队征服了中亚的大部分地区，直到他们在751年的塔拉斯河之战中被阿拉伯人和卡鲁克人击败。中国的力量迅速衰落，吐蕃恢复对中亚大部分地区的控制。在赤松德赞的带领下，崛起的吐蕃人发挥优势，征服了印度北部的大部分地区，甚至于763年夺取了中国唐朝首都长安（今西安）。吐蕃和中国于821年或822年签署了和平条约，它划定了两个帝国之间的边界。在接下来的几十年里，吐蕃王朝主要将精力集中在了中亚地区的土地上，但因为种种原因最终这个庞大的帝国还是分裂成几个小的、不稳定的王国。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_3",	"13世纪，吐蕃精明的政治家们与带领蒙古铁骑征服世界的成吉思汗成为了朋友，因此，在蒙古族征服了中原之后，西藏地区的政权开始向蒙古进贡，但相比与其他被蒙古政府的地区，西藏地区有了更大的自治权。随着时间的推移，吐蕃被认为是蒙古统治的中国元朝的十三省之一。这一时期，吐蕃人在朝廷中对蒙古人产生了很大的影响。伟大的吐蕃精神领袖萨迦班智达成为蒙古人在吐蕃的代表。萨迦的侄子恰纳多杰嫁给了蒙古皇帝忽必烈的一个女儿。吐蕃人将他们的佛教信仰传给了东蒙古人；忽必烈汗本人曾跟随伟大的上师卓贡秋杰八巴学习吐蕃信仰。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_4",	"【译者注：后续内容或带有原作者意识形态色彩，与我国官方立场有所偏颇，请酌情阅读！】[NEWLINE][NEWLINE]当蒙古元朝帝国于1368年被汉族明朝灭亡时，吐蕃重申其独立自主权，并拒绝向新皇帝进贡。1474年，重要的藏传佛教寺院根敦珠巴的住持圆寂。一个两年后出生的孩子被认为是方丈的转世灵童，并被培养为该教派的下一任领袖根敦嘉措。两人死后被称为一世达赖喇嘛和二世达赖喇嘛。他们的教派格鲁派或“黄帽”成为藏传佛教的主要形式。第三世达赖喇嘛索南嘉措（1543-1588）是他生前第一个被命名的人。他负责让蒙古人皈依格鲁藏传佛教，很可能是蒙古统治者阿勒坦汗给索南嘉措封号为“达赖喇嘛”。虽然新命名的达赖喇嘛巩固了他的精神地位的权力，但1562年，藏巴王朝取代了吐蕃政权。国王将在接下来的80年里统治吐蕃世俗生活。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_5",	"在1630年代，中国卷入了蒙古人、衰落的明朝汉族人和中国东北（满洲）的满族人之间的权力斗争。满族最终在1644年打败了汉人，建立了中国最后一个帝国王朝——清朝（1644-1912年）。1634年，当蒙古军阀、噶举藏族佛教徒、李丹汗决定入侵吐蕃并摧毁黄帽时，吐蕃卷入了这场动乱。李丹汗在途中去世，但他的追随者措格泰吉接手了这项事业。卫拉德蒙古大将固始汗于1637年与措格泰吉作战并击败了他。可汗也杀死了仓巴藏王。在固始汗的支持下，五世达赖喇嘛罗桑嘉措措于1642年夺取了整个吐蕃的精神和世俗权力。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_6",	"拉萨的布达拉宫就是作为这种新的权力综合体的象征而建造的。1653年达赖喇嘛对清朝第二任皇帝顺治进行国事访问。两位领导人平等相待；达赖喇嘛没有磕头。每个人都互相授予荣誉和头衔，达赖喇嘛被公认为大清帝国的精神权威。罗桑嘉措于1682年去世，但他的代理人隐瞒达赖喇嘛的去世直到1696年，布达拉宫得以完工，并巩固达赖喇嘛的权力。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_7",	"1697年，即罗桑嘉措圆寂十五年后，六世达赖喇嘛终于坐床。仓央嘉措（1683-1706）是一个特立独行的人，拒绝出家生活，留长发，喝酒，享受女性陪伴。他还写下了伟大的诗歌，其中一些诗歌今天仍在吐蕃被朗诵。达赖喇嘛的非传统生活方式促使和硕蒙古的洛桑汗于1705年废黜了他。洛桑汗夺取了吐蕃的控制权，自称为国王，将仓央嘉措派往北京（他“神秘地”在途中死亡），并另立了一个冒牌达赖喇嘛。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_8",	"洛桑汗统治了吐蕃12年，直到准噶尔蒙古人入侵并夺取政权。他们杀死了达赖喇嘛的冒充者，为吐蕃人民的信仰而战，但随后又开始掠夺拉萨周围的寺院。这种破坏行为得到了出兵吐蕃的清康熙皇帝的迅速反应。准噶尔人于1718年在拉萨附近摧毁了中国的军营。1720年，愤怒的康熙向吐蕃派遣了另一支更大的军队，粉碎了准噶尔人。清军还带来了真正的七世达赖喇嘛格桑嘉措（1708-1757）到拉萨。中国清朝竭尽全力控制吐蕃。皇帝派了一名使节到拉萨，但他在1750年被杀。帝国军队随后击败了叛军，但皇帝承认他必须通过达赖喇嘛来控制吐蕃而不是直接统治。日常决策也必须由地方层面做出。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_9",	"中国清朝的力量在整个18世纪中衰落，其在与英国的鸦片战争（1839-1842年和1856-1860年）以及太平天国运动（1850-1864年）和义和团运动（1899-1901年）中的失败就是明证。中国与吐蕃的实际关系自清初以来一直不明朗，中国在国内的损失使吐蕃的地位更加不明确。对西藏控制的模糊性导致了问题的产生。1893年，在印度的英国人与北京就锡金和吐蕃的边界签订了贸易和边界条约。然而，吐蕃人断然拒绝了条约条款。1903年英军一万人入侵吐蕃，次年攻占拉萨。于是，他们又与吐蕃人，以及中国、尼泊尔和不丹的代表缔结了另一项条约，使英国自己对吐蕃事务有了一定的控制权。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_10",	"1904年，十三世达赖喇嘛土登嘉措在他的俄国弟子阿格万·多尔日耶夫的敦促下逃离了该国。他先去了蒙古，然后去了北京。中国人宣布达赖喇嘛一离开吐蕃就被废黜，不仅对吐蕃而且对尼泊尔和不丹都拥有完全的主权。达赖喇嘛到北京与光绪皇帝商量，但他断然拒绝向皇帝叩头。1909年他回到拉萨，对中国对吐蕃的政策感到失望。中国向西藏派遣了6000名士兵，达赖喇嘛于同年晚些时候逃往印度大吉岭。1911年中国辛亥革命横扫清朝，吐蕃人迅速将中国军队全部驱逐出拉萨。达赖喇嘛于1912年返回吐蕃。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_11",	"英国、中国和吐蕃的代表于1914年会面，谈判一项划定印度与其北部邻国边界线的条约。在英国声称对吐蕃南部的达旺地区拥有主权后，中国在没有签署条约的情况下退出了会议，该地区现在是印度阿鲁纳恰尔邦的一部分。吐蕃和英国都签署了条约。很快，中国内乱，无暇顾及吐蕃问题。在众多武装派别之间爆发战争之前，中华民国政府仅在四年内对中国大部分领土拥有名义上的权力。在这种情况下，中国人对吐蕃兴趣不大。十三世达赖喇嘛在1933年去世前一直和平统治着吐蕃。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_12",	"图登嘉措去世后，达赖喇嘛的新转世灵童于1935年在安多出生。现任达赖喇嘛丹增嘉措于1937年被带到拉萨，开始接受他作为吐蕃领导人的职责的训练。1950年，新成立的中华人民共和国打下了吐蕃。随着北京几十年来首次恢复稳定，毛泽东也试图维护中国对吐蕃的统治权。解放军迅速彻底击败了吐蕃的小规模军队，中国起草了“十七条协议”，将吐蕃列为中华人民共和国的一个自治区。达赖喇嘛政府代表在抗议中签署了该协议，九年后吐蕃人否认了该协议。"),
		("zh_Hans_CN",	"LOC_PEDIA_CIVILIZATIONS_PAGE_CIVILIZATION_SUK_TIBET_CHAPTER_HISTORY_PARA_13",	"1959年3月1日，达赖喇嘛接到一个奇怪的邀请，去拉萨附近的解放军总部观看一场戏剧表演。解放军军官通知达赖喇嘛的卫兵，他们不能陪同吐蕃领导人去看表演，也没有通知吐蕃人民他得离开宫殿（通常，达赖喇嘛每次冒险出去，拉萨人民都会排队迎接他）。卫兵立即公布了此事，第二天估计有30万吐蕃人包围了布达拉宫保护他们的领袖。解放军将大炮调入主要寺院和达赖喇嘛的夏宫罗布林卡。尽管吐蕃军队比对手小得多，而且装备也很差，但双方陷入了胶着的状态。3月17日，吐蕃军队为达赖喇嘛找到了逃往印度的路线。实际战斗于3月19日开始，仅持续了两天，吐蕃军队就被击败了。"),

---- 特色单位

		("zh_Hans_CN",	"LOC_UNIT_SUK_TIBET_RTA_PA_NAME",												"吐蕃骑兵"),
		("zh_Hans_CN",	"LOC_UNIT_SUK_TIBET_RTA_PA_DESCRIPTION",										"吐蕃文艺复兴时期特色远程攻击单位。[ICON_Range] 射程为1，可攻击后移动。无视丘陵地形的额外 [ICON_Movement] 移动力消耗。完成科技“天文学”后解锁。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_SUK_TIBET_RTA_PA_CHAPTER_HISTORY_PARA_1",			"“Rta Pa”是藏文，意为骑士。马和马术在吐蕃非常重要，因为他们是中亚游牧民族之一。与草原上的其他人一样，吐蕃有着悠久的骑射传统，但随着16世纪火药的引入，这演变成骑射枪术。在欧洲，火绳枪主要是步兵武器，但在吐蕃和中亚，它也像弓一样被用在马背上。作为必不可少的军事训练，以及各种仪式和节日的一部分，骑手会在疾驰而过的同时射击目标。直到20世纪中叶，吐蕃政府官员仍定期被要求在马背上展示火枪、弓箭和长矛的熟练程度。"),

		("zh_Hans_CN",	"LOC_ABILITY_SUK_TIBET_RTA_PA_NAME",											"疾风之马"),
		("zh_Hans_CN",	"LOC_ABILITY_SUK_TIBET_RTA_PA_DESCRIPTION",										"可攻击后移动。无视丘陵地形的额外 [ICON_Movement] 移动力消耗。"),				

---- 特色设施

		("zh_Hans_CN",	"LOC_DISTRICT_SUK_DZONG_NAME",													"宗"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_DZONG_DESCRIPTION",											"吐蕃的特色区域，取代圣地，[ICON_Production] 建造成本更低。[NEWLINE][NEWLINE]若至少与3个山脉单元格相邻，则奖励1个 [Icon_Governor] 总督头衔。购买宗内的建筑消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。[NEWLINE][NEWLINE]进驻单位+10[ICON_Strength]防御力。必须建在丘陵上。"),
		("zh_Hans_CN",	"LOC_DISTRICT_SUK_DZONG_DESCRIPTION_XP2",										"吐蕃的特色区域，取代圣地，[ICON_Production] 建造成本更低。[NEWLINE][NEWLINE]若至少与4个山脉单元格相邻，则奖励1个 [Icon_Governor] 总督头衔。购买宗内的建筑消耗的 [ICON_Gold] 金币或 [ICON_Faith] 信仰值减少20%。[NEWLINE][NEWLINE]进驻单位防御时+10 [ICON_Strength] 战斗力。必须建在丘陵上。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_DZONG_CHAPTER_HISTORY_PARA_1",			"“Dzong”（宗）是分布在吐蕃和不丹一种城堡。这些高耸的建筑以其巨大的规模为特征，高耸的外墙环绕着庭院、寺庙、行政办公室和僧侣住所的结合体。宗通常位于山顶或山脊上，在没有建筑规划的情况下建造。相反，建筑则需要在一位高级喇嘛的指导下进行建造，他通过精神建立起宗的每个维度。"),	
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_DISTRICT_SUK_DZONG_CHAPTER_HISTORY_PARA_2",			"在吐蕃，宗成为了国家行政管理机构。根据一些历史记载来看，是绛曲坚赞（1302-1364）开创了吐蕃制度，将广阔的领土划分为地区，每个地区都由一个宗管理。当绛曲坚赞取代“十三万界”时，他将土地划分为许多地区（也称为宗）。他任命他的追随者中那些忠心耿耿的人成为地区的主人（Dzongpon——宗本，相当于县长）。在现代吐蕃，大部分宗祠已遗失或沦为废墟，只有少数被修复成为乐博物馆。只有在不丹，我们才发现作为行政中心和修道院的宗今天仍然存在。"),

---- 领袖

		("zh_Hans_CN",	"LOC_LEADER_SUK_TRISONG_DETSEN_NAME",											"赤松德赞"),

---- 领袖特性

		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_CAPTURE_OF_CHANGAN_NAME",									"攻陷长安"),
		("zh_Hans_CN",	"LOC_TRAIT_LEADER_SUK_CAPTURE_OF_CHANGAN_DESCRIPTION",							"拥有军营和宗的城市每回合+1 [ICON_GreatGeneral] 大将军点数；若此城拥有祭祀建筑，则此城训练的陆地单位初始拥有一次免费 [ICON_Promotion] 强化。"),

---- 领袖议程

		("zh_Hans_CN",	"LOC_AGENDA_SUK_ENLIGHTENED_LORD_NAME",											"开明、神通、圣主"),
		("zh_Hans_CN",	"LOC_AGENDA_SUK_ENLIGHTENED_LORD_DESCRIPTION",									"旨在进入黄金时代和拥有大量 [ICON_Faith] 信仰值，并尊重这样做的文明。不喜欢处在黑暗时代的文明，或 [ICON_Faith] 信仰值低的文明"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_ENLIGHTENED_LORD_KUDO",									"赤松德赞钦佩你进入了黄金时代和拥有大量信仰值。"),

		("zh_Hans_CN",	"LOC_DIPLO_MODIFIER_SUK_ENLIGHTENED_LORD_WARNING",								"赤松德赞对你缺乏信心和野心感到厌恶。"),

---- 对白

		("zh_Hans_CN",	"LOC_LOADING_INFO_LEADER_SUK_TRISONG_DETSEN",									"您统治着风吹过的草原，赤松德赞。您统治着高耸的山脉。当僧侣为您的荣耀祈祷时，让钟声在高耸的寺院里响起。当您强大的骑兵踏上战场时，让大地颤抖。开悟的世尊，愿您在佛法中找到智慧，在弓箭中找到力量，让吐蕃永远矗立在世界之巅。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",		"丢人现眼。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",		"愿我们的友谊开花结果！"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_FRIEND_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",				"加入我的友谊吧！我们将一起成为世界的精神典范！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",		"不。我不这么认为。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DECLARE_FRIEND_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",		"是的，这是一个有价值的建议。"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",					"我的骑兵会践踏你的田地。为你将到来的厄运做好准备！"),
		("zh_Hans_CN",	"LOC_DIPLO_DECLARE_WAR_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",				"当然，我们的弓和我们对佛法的虔诚将保护我们免受伤害！我们不怕你。"), 
/*
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",					"我们战斗到了最后一刻……不过还是输了。我向你投降，静待你的审判。"),
*/		
		("zh_Hans_CN",	"LOC_DIPLO_DEFEAT_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",						"我不害怕死亡。我的善举将确保吉祥重生。"),
		("zh_Hans_CN",	"LOC_DIPLO_DELEGATION_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",					"我已经派出了贸易代表团，他们带着酥油茶来了。快尝尝！"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_DELEGATION_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",			"啊，你选了个很不好的时间。我目前正全神贯注于监督佛塔的建造。也许下次吧。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_DELEGATION_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",			"谢谢你的精美礼物。我会珍惜它们。"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",						"真是可怜。你精神沉闷，也没有值得注意的世俗成就。[NEWLINE]（谴责你）"),
		("zh_Hans_CN",	"LOC_DIPLO_DENOUNCE_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",					"多么愚蠢的词汇。它们暴露了你肮脏的心。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_LEADER_SUK_TRISONG_DETSEN_ANY",							"祝福你，欢迎来到吐蕃。我是赤松德赞，这片土地的领主和皇帝。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_VISIT_RECIPIENT_LEADER_SUK_TRISONG_DETSEN_ANY",			"一位著名的僧人正在开讲佛法。来加入我们吧。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NEAR_INITIATOR_POSITIVE_LEADER_SUK_TRISONG_DETSEN_ANY",	"我感谢你们的款待。"),
		("zh_Hans_CN",	"LOC_DIPLO_FIRST_MEET_NO_MANS_INFO_EXCHANGE_LEADER_SUK_TRISONG_DETSEN_ANY",		"我的首都隐藏在高山之中。如果你告诉我关于你首都的信息，我会告诉你更多。"),
		("zh_Hans_CN",	"LOC_DIPLO_GREETING_LEADER_SUK_TRISONG_DETSEN_ANY",								"欢迎。"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_EXIT_LEADER_SUK_TRISONG_DETSEN_ANY",							"没有奉献精神，也没有野心。你怎么能既没有精神的成功也没有世俗的成就呢？"),
		("zh_Hans_CN",	"LOC_DIPLO_KUDO_EXIT_LEADER_SUK_TRISONG_DETSEN_ANY",							"你在这个地球上的成就无疑是你丰功伟业的果实。确实值得称赞。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_ALLIANCE_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",				"我不愿意让吐蕃与其他国家有联系，但这对我们双方来说似乎都是明智的做法。你觉得呢？"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_MAKE_DEAL_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",				"这是不可接受的。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_MAKE_DEAL_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",				"我会让我的僧侣加持这份协议。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_ACCEPT_DEAL_LEADER_SUK_TRISONG_DETSEN_ANY",			"和平。以及对所有这些死者的超度。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_AI_REFUSE_DEAL_LEADER_SUK_TRISONG_DETSEN_ANY",			"不！吐蕃还没有准备好议和。"),
		("zh_Hans_CN",	"LOC_DIPLO_MAKE_PEACE_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",					"我的僧侣建议我为人民的精神福祉寻求和平。"),
		("zh_Hans_CN",	"LOC_DIPLO_ACCEPT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",		"你可以通过。穿越我们的山脉，祝你好运。"),
		("zh_Hans_CN",	"LOC_DIPLO_REJECT_OPEN_BORDERS_FROM_HUMAN_LEADER_SUK_TRISONG_DETSEN_ANY",		"通往吐蕃的道路将继续对您保持关闭。"),
		("zh_Hans_CN",	"LOC_DIPLO_OPEN_BORDERS_FROM_AI_LEADER_SUK_TRISONG_DETSEN_ANY",					"让我们相互开放边界！你怎么看？"),
		("zh_Hans_CN",	"LOC_DIPLO_WARNING_TOO_MANY_TROOPS_NEAR_ME_LEADER_SUK_TRISONG_DETSEN_ANY",		"我们已经从宗地里窥探到了你的士兵。你有什么想告诉我的吗？"),

---- Quote and Pedia

		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_TRISONG_DETSEN_QUOTE",								"好的牧人是羊群的父母，好的马匹是主人的托付。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_TRISONG_DETSEN_TITLE",								"赤松德赞"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_SUK_TRISONG_DETSEN_SUBTITLE",							"吐蕃皇帝"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_CAPSULE_BODY",		"吐蕃应该建设紧凑的山区城市。在一些宗教信仰的帮助下，它们会表现得更加出色。赤松德赞建设了吐蕃的强大宗教基础设施，并为战争做好了准备。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_DETAILED_BODY",		"吐蕃是一个多山地和多寺院的国家：在山脉附近建造区域不仅可以提供额外的收益，还可以让您以 [ICON_Faith] 信仰值购买这些区域中的建筑。在你的 [ICON_Governor] 总督和宗座的帮助下，你应该有足够的 [ICON_Faith] 信仰值来做到这一点。赤松德赞建设了吐蕃强大的宗教基础设施，并为战争做好了准备。在您拥有宗的任何城市建造军营，以便更快地获得 [ICON_GreatGeneral] 大将军并训练更强大的军队。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_1",		"吐蕃历史上最著名的人物之一是支持佛教并帮助佛教在西藏扎根的“法王”（藏文为Chögyal）。而所有法王中最重要的可能是赤松德赞。年轻的赤松德赞所继承的吐蕃帝国正在严重衰落。吐蕃在经历第一任法王松赞干布的光荣统治后，帝国瓦解，吐蕃失去了土耳其斯坦的几座城市，尼泊尔卷入叛乱，阿拉伯人开始蚕食吐蕃帝国的西部战线。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_2",		"赤松德赞扭转了这一趋势，并进行军事行动以确保吐蕃的扩张。763年，赤松德赞派遣20万大军到唐朝边境，打败了驻守在那里的军队，然后继续前进，攻占唐朝首都长安，迫使皇帝唐代宗逃离首都。783年，中国与吐蕃达成和约，将青海的土地全部归属吐蕃。赤松德赞还试图向西扩张，到达阿姆河并威胁阿拔斯王朝的哈里发哈伦·赖世德。哈里发坐立不安，与中国皇帝建立联盟。赤松德赞国王后来全神贯注于西方的阿拉伯战争，减轻了东方和北方中国对手的压力，直到他的统治于797年结束。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_3",		"然而，后世藏传佛教徒最为铭记的是他对佛教的大力支持。755年赤松德赞登基时，他邀请莲花生大士、释迦牟尼佛、毗玛拉米扎等印度上师到西藏传播最新的教法。两位班智开始建立桑耶寺作为西藏第一所佛教寺院。一些藏人最终成为僧人，并进行了一项庞大的翻译项目，将佛经从梵文翻译成古典藏文。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_4",		"在赤松德赞统治期间，不仅佛教的印度分支传入西藏。公元761年左右，赤松德赞派人前往益州地区接受他们在四川遇到的朝鲜禅宗大师金华相的教法，这是第一次有记载的佛教在西藏的传播，记载在后来被称为“斯巴家族的声明”中。 他们收到了金华相的教导和三篇中文文本，但金不久后就去世了。763年，赤松德赞第二次光顾中国。第二次远征由高级大臣斯巴·格萨尔斯南带领。 关于格萨尔斯南在益州遇到了谁，学术界中存在异议。早期学士认为应该是金，而后来修改为宝堂寺创始人宝堂五竹（714-774）。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_5",		"佛教的两个分支终于走到了一起。赤松德赞于792年至794年间主持了一场为期两年的著名辩论，在西方学术界被称为“拉萨会议”（虽然它发生在距离拉萨相当远的桑耶）。他赞助了代表禅宗在西藏传播的第三波有记载的禅宗摩诃衍与学者莲华戒（寂护论师的学生）之间的佛法辩论。实际上，争论是在中国和印度佛教传统之间进行的，因为它们在西藏有代表性。 关于辩论的性质和胜利者，史书记载各不相同。"),
		("zh_Hans_CN",	"LOC_PEDIA_LEADERS_PAGE_LEADER_SUK_TRISONG_DETSEN_CHAPTER_HISTORY_PARA_6",		"797年，赤松德赞退居准噶宫，将权力移交给次子木奈赞普。关于这一点，各种史料记载都非常混乱。赤松德赞死后，似乎有一场争夺继承权的斗争。目前尚不清楚赤松德赞何时去世，或者木奈赞普统治了多长时间。可以追溯到公元9世纪的藏文历史文献《巴约》声称，木奈赞普坚持按照佛教而不是传统仪式来举行他父亲的葬礼。");





