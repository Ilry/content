-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Monopoly++ Tycoons and Investors'CN_Add_IG1
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/7 14:44:30
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Monopoly++: Tycoons and Investors” 。该文件在 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，需 Criteria ： Active_Expansion_2 与 Mode_Monopolies_ON

-- MonopolyPlus_GreatPeopleTexts.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																								Text)
VALUES

---- 基础伟人信息

		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_NAME",												"安德鲁·卡内基"),
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_NAME",													"约翰·梅纳德·凯恩斯"),

---- 伟人能力/巨作

		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_ACTIVE",											"资本家+1使用次数。[NEWLINE]此城免费获得一名资本家。"),
		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_ACTION",												"投资商1使用次数。[NEWLINE]此城免费获得一名投资商。"),

---- 伟人百科
------ 安德鲁·卡耐基

		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_CHAPTER_HISTORY_PARA_1",	"安德鲁·卡耐基（1835 - 1919），出生于苏格兰，苏格兰裔美国实业家、慈善家，卡耐基钢铁公司的创始人，被世人誉为“钢铁大王”，被世人誉为“美国慈善事业之父”。[NEWLINE][NEWLINE]卡耐基1865年与人合伙创办卡耐基科尔曼联合钢铁厂；1881年与弟弟汤姆一起成立卡耐基兄弟公司；1892年组建卡耐基钢铁公司。[NEWLINE][NEWLINE]2009年7月，《福布斯》公布“美国史上15大富豪”排行榜，安德鲁·卡耐基以2812亿美元位列第二。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_CHAPTER_HISTORY_PARA_2",	"钢铁产量占美国的1/37。并在同年结识了另一位实业家亨利·克雷·弗里克（Henry Clay Frick），两人结为商业合作伙伴。1886年10月，汤姆去世，享年43岁，几天后，卡内基的母亲也因肺炎离世。1889年，卡内基的主要助手琼斯厂长因为职场意外而死亡，安德鲁·卡内基接连遭受沉重的打击。1892年，公司改名为卡内基钢铁公司。[NEWLINE][NEWLINE]1892年，在宾夕法尼亚州荷姆斯特，安德鲁·卡内基打算降低工资，引发工人罢工。卡内基的助手福里克采取了极端的措施，用一道带铁丝网的栅栏挡住了工人们进入工厂的去路，7月1日，他关闭了在移民区的工厂。而最后则是州长出动了8000名民兵用枪镇压了这次工运，造成几十人伤亡，工会领导人乔治·迪波特被捕，被指控犯有谋杀罪；当时卡内基在苏格兰度假而得以置身事外。罢工起因是安德鲁·卡内基借由工会的力量逼迫竞争对手给予工人一样的工资，来提高竞争对手的成本，等到竞争对手纷纷倒台后，工会反而成为了沉重的负担。1900年他在《财富的福音》一书中宣布：“我不再努力挣更多的财富”。卡内基在商业人生上相信社会达尔文主义，在“财富的福音”演讲中大谈财富是社会文明的根本，竞争决定了只有少数人才能成为富人，而大多数人（穷人）只能依附于富人而生活。但他又加一条宣称富人有责任用他们手里的钱来让整个社会受益。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_CHAPTER_HISTORY_PARA_3",	"28岁时，他用全部资产设立凯斯通桥梁工程公司（Keystone Bridge Works），致力于钢铁生产行业，成为美国的钢铁业大王。平炉炼钢法刚发明时，卡内基就花费数百万美元在荷姆斯泰德新建厂房，添设新设备，多生产60%的钢。此后他还收购了一家石油公司、一条铁路，并购买了大量的汽船。到了1880年代末，卡内基钢铁已成为全世界最大的生铁和焦碳制造者，每天大约能生产2000吨生铁。1888年卡内基收购了竞争对手家园钢铁厂；1901年，他以4.8亿美元的价格卖掉了卡内基钢铁公司，当时卡内基钢铁公司生产的钢铁已经占全美钢铁销售总量的25％。在事业高峰期时，卡内基是世界第二富豪，今天他更被视人类近代历史上第二富，仅次于与他同时代的洛克菲勒。[NEWLINE][NEWLINE]1919年去世前，卡内基一共捐出3亿5069万5653美元。卡内基认为财富不应当传给自己的后代，临终前立下遗言，要把剩余的3000万美元全部捐出。他有一句名言：“一个人死的时候如果拥有巨额财富，那就是一种耻辱。”卡内基的慈善行为引得同时代的富人纷纷效仿，并且这个惯例一直延续到现在。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_ANDREW_CARNEGIE_CHAPTER_HISTORY_PARA_4",	"20世纪初美国消费者的关税负担变低，主要应当归功于安德鲁·卡耐基。高关税制度最大的坏处之一，就是受保护的卡特尔会形成偏高的生产成本。不过，卡内基一直表现得不像一个理性的卡特尔成员，虽然他在行业内的利润一直是最高的。但他支付最小的股息，将其余利润重新投资于更好的共厂、更高的机械化、更大的产出。产品价格的下降正是扩大市场份额的好机会——每次市场衰退时，卡内基的公司都扩大了市场份额：在19世纪90年代后期钢轨价格战后业界的一片狼藉中。约翰·Ⅵ·盖茨1898年的评论说得非常明白：卡内基野蛮的降价，意味着“以相对较小的产量获得高额利润”的时代结束了；盖茨领导的伊利诺伊钢铁公司将不得不投资数百万美元，以获得竞争优势。在盖茨和埃尔伯特·加里等想要组织企业联盟的美国人中，卡内基是个“不守规矩的人”。他致力于“将美国的所有钢铁企业拖垮”。[NEWLINE][NEWLINE]在大多数此类投资活动中，卡内基的公司都冲在最前面，他们为竞争对手设置钢铁价格上限一、由于他们将大部分收益用于重新投资，因此其他人也被迫效仿他们进行类似的投资。[NEWLINE][NEWLINE]在美国钢铁贸易初期，有很多富有精力和创造性的企业家，如坎布里亚和伯利恒钢铁厂的弗里茨兄弟，不过没有人像卡内基那样执着而又雄心勃勃，拥有破坏性的本能。如果没有卡内基，贝塞麦协会的“前辈们”——美国最初的钢铁卡特尔——更容易维持谨慎可控的发展策略；亚历山大·霍利的才华可能永远无法完全展示出来；像盖茨和加里这样的人可能从一开始就会控制行业。简单地说，如果没有关税。美国钢铁业的发展历程将和英国类似，高度机械化、大规模、高强度使用的工业机器——美国行业先进性的标志——将很久以后才会出现，并且给美国带来优势。"),

/*	译者注：上述背景故事是笨蛋奶自己从别处找资料写的，以后自己翻译补上，附原文：
第一段：The Scottish-born American industrialist and philanthropist Andrew Carnegie was the leader of the American steel industry from 1873 to 1901. He donated large sums of his fortune to educational, cultural, and scientific institutions.
第二段：Andrew Carnegie was born on November 25, 1835, in Dunfermline, Scotland, the son of William Carnegie, a weaver, and Margaret Morrison Carnegie. The invention of weaving machines replaced the work Carnegie's father did, and eventually the family was forced into poverty. In 1848 the family left Scotland and settled in Allegheny City, Pennsylvania. Carnegie's father found a job in a cotton factory, but he soon quit to return to his home handloom, making linens and trying to sell them door to door. Carnegie also worked in the cotton factory, but after his father died in 1855, his strong desire to help take care of the family pushed him to educate himself. He became an avid reader, a theatergoer, and a lover of music. Carnegie became a messenger boy for the Pittsburgh telegraph office. He later became a telegraph operator. Thomas A. Scott, superintendent of the western division of the Pennsylvania Railroad, made the eighteen-year-old Carnegie his secretary. Carnegie was soon earning enough salary to buy a house for his mother. During the Civil War (1861–65), when Scott was named assistant secretary of war in charge of transportation, Carnegie helped organize the military telegraph system. But he soon returned to Pittsburgh to take Scott's old job with the railroad.
第三段：Between 1865 and 1870 Carnegie made money through investments in several small iron mills and factories. He also traveled throughout England, selling the bonds of small United States railroads and bridge companies. Carnegie began to see that steel was eventually going to replace iron for the manufacture of rails, structural shapes, pipe, and wire. In 1873 he organized a steel rail company. The first steel furnace at Braddock, Pennsylvania, began to roll rails in 1874. Carnegie continued building by cutting prices, driving out competitors, shaking off weak partners, and putting earnings back into the company. He never went public (sold shares of his company in order to raise money). Instead he obtained capital (money) from profits—and, when necessary, from local banks—and he kept on growing, making heavy steel alone. By 1878 the company was valued at $1.25 million. In the 1880s Carnegie's purchases included a majority stake in the H. C. Frick.
第四段：Company, which had vast coal lands and over one thousand ovens in Connellsville, Pennsylvania, and the Homestead mills outside of Pittsburgh, Pennsylvania. Frick became his partner and eventually chairman of the Carnegie Company. Carnegie had moved to New York City in 1867 to be close to the marketing centers for steel products; Frick stayed in Pittsburgh as the general manager. They made a good team. Behind the scenes, Carnegie planned new projects, cost controls, and the improvement of plants; Frick was the working director who watched over the mass-production programs that helped keep prices down. Carnegie spent his leisure time traveling. He also wrote several books, including Triumphant Democracy (1886), which pointed out the advantages of American life over the unequal societies of Britain and other European countries. To Carnegie access to education was the key to America's political stability and industrial accomplishments. In 1889 he published an article, ''Wealth'', stating his belief that rich men had a duty to use their money to improve the welfare of the community. Carnegie remained a bachelor until his mother died in 1886. A year later he married Louise Whitfield. They had one child together. The couple began to spend six months each year in Scotland, though Carnegie kept an eye on business developments and problems.
*/

------ 约翰·梅纳德·凯恩斯

		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_CHAPTER_HISTORY_PARA_1",		"约翰·梅纳德·凯恩斯（John Maynard Keynes，1883年6月5日 - 1946年4月21日），英国经济学家，现代经济学最有影响的经济学家之一，他创立的宏观经济学与弗洛伊德所创的精神分析法和爱因斯坦发现的相对论一起并称为二十世纪人类知识界的三大革命。[NEWLINE][NEWLINE]1936年，凯恩斯的代表作《就业、利息和货币通论》（The General Theory of Employment，Interest and Money，简称《通论》）出版，他的另外两部重要的经济理论著作是《论货币改革》（A Tract on Monetary Reform，1923）和《货币论》（A Treatise on Money，1930）。[NEWLINE][NEWLINE]凯恩斯因开创了经济学的“凯恩斯革命”而称著于世，被后人称为宏观经济学之父。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_CHAPTER_HISTORY_PARA_2",		"1883年6月5日，约翰·梅纳德·凯恩斯出生于英格兰的剑桥，14岁以奖学金入伊顿公学（Eton College）主修数学，曾获托姆林奖金（Tomline Prize）。[NEWLINE][NEWLINE]毕业后，以数学及古典文学奖学金入学剑桥大学国王学院。1905年毕业，获剑桥文学硕士学位。之后又滞留剑桥一年，师从马歇尔和庇古攻读经济学，以准备英国文官考试。[NEWLINE][NEWLINE]1906年以第二名成绩通过文官考试，入选印度事务部。任职期间，为其第一部经济著作《印度通货与金融》（Indian Currency and Finance，1913）作了大量研究准备工作。[NEWLINE][NEWLINE]1908年辞去印度事务部职务，回剑桥任经济学讲师至1915年。[NEWLINE][NEWLINE]其间1909年以一篇概率论论文入选剑桥大学国王学院院士，另以一篇关于指数的论文获亚当斯密奖。概率论论文后稍经补充，于1921年以《概率论》（ATreatise on Probability）为书名出版。[NEWLINE][NEWLINE]第一次世界大战爆发不久，即应征入英国财政部，主管外汇管制、美国贷款等对外财务工作。1919年初作为英国财政部首席代表出席巴黎和会。同年6月，因对赔偿委员会有关德国战败赔偿及其疆界方面的建议愤然不平，辞去和会代表职务，复归剑桥大学任教。不久表明其对德国赔偿问题所持看法的《和平的经济后果》（The Economic consequences of the peace，1919）一书出版，引起欧洲、英国及美国各界人士的大争论，使其一时成为欧洲经济复兴问题的核心人物。在任教同时，撰写了大量经济学文章。[NEWLINE][NEWLINE]1921~1938年任全国互助人寿保险公司（National Mutual Life Insurance Company）董事长期间，其对股东的年度报告一直为金融界人士必读而且是抢先收听的新闻。[NEWLINE][NEWLINE]1940年出任财政部顾问，参与战时各项财政金融问题的决策，并在他倡议下，英国政府开始编制国民收入统计，使国家经济政策拟订有了必要的工具。[NEWLINE][NEWLINE]因其深厚学术造诣，曾长期担任《经济学杂志》主编和英国皇家经济学会会长，1929年被选为英国科学院院士，1942年晋封为勋爵。[NEWLINE][NEWLINE]1944年7月率英国政府代表团出席布雷顿森林会议，并成为国际货币基金组织和国际复兴与开发银行（世界银行）的英国理事，在1946年3月召开的这两个组织的第一次会议上，当选为世界银行第一任总裁。[NEWLINE][NEWLINE]1946年剑桥大学授予其科学博士学位。[NEWLINE][NEWLINE]1946年4月21日，因心脏病突发于在索塞克斯（Sussex）家中逝世。[NEWLINE][NEWLINE]凯恩斯（1883-1946）原是一个自由贸易论者，直至20年代末仍信奉传统的自由贸易理论，认为保护主义对于国内的经济繁荣与就业增长一无可取。甚至1929年同瑞典经济学家俄林就德国赔款问题论战时，还坚持国际收支差额会通过国内外物价水平的变动，自动恢复平衡。[NEWLINE][NEWLINE]1936年其代表作《就业、利息和货币通论》（The General Theory of Employment，Interest and Money，简称《通论》）出版时，凯恩斯一反过去的立场，转而强调贸易差额对国民收入的影响，相信保护政策如能带来贸易顺差，必将有利于提高投资水平和扩大就业，最终导致经济繁荣。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_CHAPTER_HISTORY_PARA_3",		"凯恩斯认为，传统贸易理论以各项生产要素，包括劳动力已经充分就业为前提，宣扬按照比较成本原理进行贸易，既有充分就业，又享分工之利。但现实生活中并不存在这一前提，而却经常存在大量非自愿失业，如果一国按照传统理论自由贸易，虽可从事有比较优势部门的专业化生产，取得某些分工之利，但放弃或缩小比较优势不大或无比优势部门的和平，则必然是失业更趋严重。故凯恩斯断然抗议传统贸易理论不适用于现代资本主义。[NEWLINE][NEWLINE]他还批评传统理论只注重分工的利益和强调对外收支均衡的自动调节过程，而完全忽略贸易差额对国民收入就业的影响。认为就一国而言，后者较前者更重要，因为顺差能增加收入，使资金流入，利率降低，投资提高，就业扩大；反之，若为逆差，则可能很快就会产生顽固的经济衰退。[NEWLINE][NEWLINE]由此，凯恩斯赞成贸易顺差，并重新推崇起重商主义，认为重商主义，学说里含有入学真下成分。不过在肯定重商主义某些观点的同时，他也承认实行重商主义所能取得的好处，只仅限一国，不会泽及全世界。[NEWLINE][NEWLINE]在《通论》中，凯恩斯由投资乘数原理出发，对贸易差额与国民经济盛衰的关系作了进一步阐述。他认为投资的乘数作用表现为，一个部门的新增投资，不仅会使该部门的收入增加，而且会通过连锁反应，引起其他有关部门的收入增加，而且会通过连锁反应，引起其他有关部门追加新投资获得新收入，致使国民收入总量的增长若干倍于最初那笔投资。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_CHAPTER_HISTORY_PARA_4",		"在凯恩斯之前，主导经济理论是以马歇尔为代表的新古典学派自由放任经济学说，又称传统经济学。这种学说是建立在“自由市场、自由经营、自由竞争、自动调节、自动均衡”的五大原则基础上的，其核心是“自动均衡”理论。认为在自由竞争的条件下，经济都能通过价格机制自动达到均衡；商品的价格波动能使商品供求均衡；资本的价格——利率的变动能使储蓄与投资趋于均衡；劳动力的价格——工资的涨跌能使劳工市场供求平衡，实现充分就业。因此，一切人为的干预，特别是政府干预都是多余的，什么也不管的政府是最会管理的政府，应该信守自由竞争、自动调节、自由放任的经济原则，政府对经济的干预只会破坏这种自动调节机制，反而引起经济的动荡或失衡。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JOHN_KEYNES_CHAPTER_HISTORY_PARA_5",		"约翰·梅纳德·凯恩斯，活跃于20世纪上半叶西方学术、思想和政治舞台的著名经济学家、哲学家和政治家，也是20世纪西方世界应付内外危机、实现国家和社会治理的政策和思想传统的根本转换的枢纽型人物。在30年代，凯恩斯发起了一场导致经济学研究范式和研究领域根本转变的革命（即著名的“凯恩斯革命”）：在40年代的“二战”后期及战后初期，凯恩斯参与了国际货币基金组织、国际复兴开发银行（即世界银行）和关贸总协定（世贸组织之前身）等机构（它们构成了所谓的“华盛顿体系”）的组建工作，是当今世界经济秩序的主要奠基人之一。1998年的美国经济学会年会上，在150名经济学家的投票中，凯恩斯被评为20世纪“最有影响力”的经济学家（弗里德曼排名第二）。[NEWLINE][NEWLINE]	1936年2月4日，凯恩斯的代表作《就业、利息与货币通论》（这是“凯恩斯革命”的核心文献）的出版，立即在大危机后惊魂未定的西方世界引起轰动。西方学者对此评论道：“凯恩斯是在致命危机威胁资本主义世界时挽救和巩固了这个社会。”有的学者把凯恩斯的理论比做“与哥白尼在天文学上、达尔文在生物学上、爱因斯坦在物理学上一样的革命”。[NEWLINE][NEWLINE]	他在青少年时代就有机会同一些经济学家和哲学家接触，并结识一些有文艺才能和创新精神的朋友。后进入剑桥大学专攻数学，以优异成绩毕业，后到剑桥国王学院任经济学教师。第一次世界大战爆发后被征召进财政部工作，曾以英国财政部首席代表身份参加巴黎和会并因对德国赔款问题的意见未被接受而忿然辞职回到剑桥。凯恩斯长期担任权威刊物《经济学杂志》的主编，先后出版过几本名著，从事证券投资获利数十万英镑，兼任不少公司的顾问或董事，开办过艺术剧院，担任过皇家学院总务长。二战期间凯恩斯担任了英国财政部顾问，是英国战时经济政策的主要制定者。战争结束前后，又忙于英美贷款谈判和布雷顿森林会议等一系列活动。1946年4月21日辞世。");

/*	译者注：以后自己翻译补上，原因同上，附原文：
第一段：John Maynard Keynes was born on 5 June 1883 in Cambridge into a well-to-do academic family. His father was an economist and a philosopher, his mother became the town's first female mayor. He excelled academically at Eton as well as Cambridge University, where he studied mathematics. He also became friends with members of the Bloomsbury group of intellectuals and artists.
第二段：After graduating, Keynes went to work in the India Office, and simultaneously managed to work on a dissertation - often during office hours - which earned him a fellowship at King's College. In 1908, he quit the civil service and returned to Cambridge. Following the outbreak of World War One, Keynes joined the treasury, and in the wake of the Versailles peace treaty, he published 'The Economic Consequences of the Peace' in which he criticised the exorbitant war reparations demanded from a defeated Germany and prophetically predicted that it would foster a desire for revenge among Germans. This best-selling book made him world famous.
第三段：During the inter-war years, Keynes amassed a considerable personal fortune from the financial markets and, as bursar of King's College, greatly improved the college's financial position. He became a prominent arts patron and board member of a number of companies. In 1926, he married Lydia Lopokova, a Russian ballerina.
第四段：Keynes' best-known work, 'The General Theory of Employment, Interest and Money', was published in 1936, and became a benchmark for future economic thought. It also secured his position as Britain's most influential economist, and with the advent of World War Two, he again worked for the treasury. In 1942, he was made a member of the house of lords.
第五段：During the war years, Keynes played a decisive role in the negotiations that were to shape the post-war international economic order. In 1944, he led the British delegation to the Bretton Woods conference in the United States. At the conference he played a significant part in the planning of the World Bank and the International Monetary Fund. He died on 21 April 1946.
*/

-- MonopolyPlus_ImprovementTexts.sql文件

---- 针对原模组对游戏自带科技相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = "可提供等同于其 [ICON_Production] 生产力产出的 [ICON_Tourism] 旅游业绩产出。[NEWLINE][NEWLINE]" || Text
WHERE Tag = "LOC_TECH_STEEL_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME" AND Language = "en_US"));

---- 改良设施文本
------ 基础改良设施文本变动（已整合进 Series2Collection3 的 GS'National Projects Satellites'CN_Add_IG2.sql文件中）

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																					Text)
VALUES

------ 基础改良设施信息

		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME",													"货栈"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_WAREHOUSE_DESCRIPTION",											"由投资商修建的改良设施，完成科技“零件规格化”后解锁。[NEWLINE]必须在向您开放边界的其他文明或城邦境内的奢侈品资源旁修建。[NEWLINE][NEWLINE]每家与奢侈品资源对应且与货栈相邻的公司+5 [ICON_Gold] 金币。[NEWLINE]以所在城市为目的地的国际 [ICON_TradeRoute] 贸易路线产出+5 [ICON_Gold] 金币、+2 [ICON_Production] 生产力。[NEWLINE]以此城为目的地的国际 [ICON_TradeRoute] 贸易路线，可从此城境内每家出发地文明所属的公司中获得+1 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]每座城市只能修建一个。"),

------ 相邻加成

		("zh_Hans_CN",	"LOC_WAREHOUSE_ADJ_GOLD",																"+{1_num} [ICON_Gold] 金币 来自相邻 货栈"),
		("zh_Hans_CN",	"LOC_WAREHOUSE_ADJ_PRODUCTION",															"{1_num} [ICON_Production] 生产力 来自相邻 货栈"),

------ 改良设施百科

		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_WAREHOUSE_CHAPTER_HISTORY_PARA_1",			"货栈是通常以散装形式存储货物（有人称其为“商品”）的建筑物（有人称其为“房屋”）。"),

------ 基础改良设施信息

		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_CONTAINER_PORT_NAME",												"货柜运港"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_CONTAINER_PORT_DESCRIPTION",										"由投资商修建的改良设施，完成科技“塑料”后解锁。[NEWLINE]必须在向您开放边界的其他文明或城邦境内的奢侈品资源旁的海岸上修建（且至少相邻一个陆地单元格）。[NEWLINE][NEWLINE]每家与奢侈品资源对应且与货柜运港相邻的公司+5 [ICON_Gold] 金币。[NEWLINE]以所在城市为目的地的国际 [ICON_TradeRoute] 贸易路线+5 [ICON_Gold]金币、+2 [ICON_Production] 生产力。[NEWLINE]以此城为目的地的国际 [ICON_TradeRoute] 贸易路线，可从此城境内每家出发地文明所属的公司中获得+1 [ICON_Gold] 金币、+1 [ICON_Production] 生产力。[NEWLINE][NEWLINE]每座城市只能修建一个。"),

------ 相邻加成

		("zh_Hans_CN",	"LOC_CONTAINER_PORT_ADJ_GOLD",															"+{1_num} [ICON_Gold] 金币 来自相邻 货柜运港"),
		("zh_Hans_CN",	"LOC_CONTAINER_PORT_ADJ_PRODUCTION",													"+{1_num} [ICON_Production] 生产力 来自相邻 货柜运港"),

------ 改良设施百科

		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_CONTAINER_PORT_CHAPTER_HISTORY_PARA_1",	"货柜运港是指包括港池、锚地、进港航道、泊位等水域以及货运站、堆场、码头前沿、办公生活区域等陆域范围的能够容纳完整的集装箱装卸操作过程的具有明确界限的场所。[NEWLINE][NEWLINE]货柜运港是水陆联运的枢纽站，是集装箱货物在转换运输方式时的缓冲地，也是货物的交接点，因此，货柜运港在整个集装箱运输过程中占有重要地位。"),

------ 基础改良设施信息

		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_STATION_NAME",														"火车站"),
		("zh_Hans_CN",	"LOC_IMPROVEMENT_LEU_STATION_DESCRIPTION",												"资本家为更快倾销商品而量身打造的改良设施。只能修建在平坦地形上，但所在单元格可拥有森林、泛滥平原或雨林地貌。每座城市只能修建一个，且不能与其他火车站相邻。[NEWLINE][NEWLINE]火车站可获得等同于该单元格魅力值75%的 [ICON_Production] 生产力。相邻单元格自动建立铁路，且+1魅力值。解锁科技“钢铁”后，火车站可提供等同于该单元格 [ICON_Production] 生产力产出的 [ICON_Tourism] 旅游业绩。[NEWLINE][NEWLINE]以所在城市为出发地或目的地的国内 [ICON_TradeRoute] 贸易线路产出+4 [ICON_Production] 生产力、+4 [ICON_Gold] 金币、+2 [ICON_Food] 食物、+2 [ICON_Culture] 文化值，此加成对出发地城市与目的地城市均生效；[ICON_Power] 供电充足时，此加成额外提升50%。[NEWLINE][NEWLINE]上述 [ICON_TradeRoute] 贸易路线的额外加成将使相应城市消耗的 [ICON_Power] 电力额外+2。"),

------ 相邻加成

		("zh_Hans_CN",	"LOC_STATION_ADJ_PRODUCTION",															"+{1_num} [ICON_Production] 生产力 来自相邻 火车站"),

------ 改良设施百科

		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_STATION_CHAPTER_HISTORY_PARA_1",			"铁路车站，也称火车站，是供铁路部门办理客、货运输业务和列车技术作业的场所。[NEWLINE][NEWLINE]站台可粗略地分岛式站台、侧式站台、港湾式站台、跨站式站房、特殊车站、号志站。早期的车站通常是客货两用。这类车站如今仍然有；但是在欧美，货运一般已集中在主要的车站。大部分的铁路车站都是在铁路的旁边，或者是路线的终点。部分铁路车站除了供乘客及货物上落外，亦有供机车及车辆维修或添加燃料的设施。多间铁路公司一起使用的车站一般称为联合车站或转车站。有时转车站亦指可供与其它交通工具（如电车、公共汽车或渡轮）转乘的车站。"),
		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_STATION_CHAPTER_HISTORY_PARA_2",			"世界上最早出现的铁路车站为货运用途。史托顿及达灵顿铁路（Stockton and Darlington Railway）是世上第一条商营铁路，但由于它是用来运货，所以并没有正式的火车站。第一个真正的铁路车站应该为1830年开通的英国利物浦及曼彻斯特铁路（Liverpool and Manchester Railway）而建的。今日在曼彻斯特，利物浦路车站被保留作为科学博物馆。[NEWLINE][NEWLINE]欧美国家现存的铁路车站大多建于十九世纪。这些车站反映了当时的建筑风格。它们规模宏伟，建筑得美轮美奂，是铁路公司以至整个城市的瑰宝。但亦可以说，它们是当时的铁路公司及大城市炫耀财富的方法。有些国家建设铁路的时间较迟，但仍然喜爱模仿十九世纪时的建筑。铁路车站的建筑有用不同的方式，由尽显宏伟的巴洛克式，到实用主义及现代主义都有。二十世纪后期以来兴建的铁路车站很多都和机场类似，外表表现冷酷及抽象。"),
		("zh_Hans_CN",	"LOC_PEDIA_IMPROVEMENTS_PAGE_IMPROVEMENT_LEU_STATION_CHAPTER_HISTORY_PARA_3",			"铁路在战争中的意义： 近现代史中，铁路发挥重大军事价值的例子很多。原本是海上强权的英国，也很重视在殖民地修筑铁路，作为巩固统治的工具或者进一步扩张的跳板。从19世纪40年代开始，英国开始修筑贯穿南亚次大陆的十字形铁路，在英国1857-1858年镇压印度士兵起义的战争中，铁路发挥了重要作用。1900年，英属印度铁路里程达到近2.6万英里，在当时仅次于美国、英属加拿大和沙皇俄国，居世界第四位。[NEWLINE][NEWLINE]据英国首相丘吉尔的《河流战争》（River War）一书（当时26岁的丘吉尔作为中尉和业余战地记者参与了这次战争）记载，1897年1月到1898年7月，英国军队在苏丹境内修筑了长达385英里的军用铁路，将军队从埃及开罗向南运输到苏丹阿特巴拉的时间从4个月缩短到11天。最终，英军于1898年9月2日在乌姆杜尔曼之战中以很小的代价打垮苏丹马赫迪军队，对苏丹这个非洲面积最大的国家建立起长达半个多世纪的殖民统治。[NEWLINE][NEWLINE]英国人重视铁路的传统被其前殖民地所继承。穿越整个北美大陆的铁路，让美国真正成为面对两个大洋的强权。加拿大的太平洋铁路，最终把英属不列颠哥伦比亚、英属哈德孙湾公司辖地、原来法属的魁北克等几个互不统属的殖民地，最终整合为一个国家。[NEWLINE][NEWLINE]相反，缺乏铁路的陆地大国在庞大国土上的运输成本较高、效率较低，很难应付海权强国的袭扰与机动打击，也难以应对强国支持的分裂主义挑战。俄罗斯帝国在1853-1855年的克里米亚战争、大清帝国在1857-1860年的第二次鸦片战争中，都在家门口被掌控海权的英法联军击败，就充分说明了这一点。从中法战争结束到甲午战争爆发，庞大的中国仅仅修筑了约400公里铁路。相反，日本天皇和明治元勋们较早的认识到铁路的重要性，到1893年，日本已有3281.45公里铁路。在1894-1895年的甲午战争中，日本借助新式兵役制度、战略性铁路网与运输船队，实现了高效动员、集结和兵力输送，清军的陆上动员与运输依然主要依赖徒步行军和骡马运输，其效率高下立见。1904-1905年的日俄战争中，西伯利亚铁路尚未完全建成，俄军必须通过轮渡越过烟波浩渺的贝加尔湖，兵力投送的速度大大迟滞。");

-- MonopolyPlust_UnitTexts.sql文件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																Text)
VALUES

---- 单位文本
------ 基础单位信息

		("zh_Hans_CN",	"LOC_UNIT_LEU_INVESTOR_NAME",										"投资商"),
		("zh_Hans_CN",	"LOC_UNIT_LEU_INVESTOR_DESCRIPTION",								"高成本的平民单位，只能用 [ICON_Gold] 金币购买。需所在城市拥有银行（商业中心）。[NEWLINE][NEWLINE]投资商可创建公司，让您文明创造出 [ICON_GreatWork_Product] 产品并以此获得额外的 [ICON_Gold] 金币与 [ICON_Tourism] 旅游业绩产出。投资商还可在其他文明中修建货栈和货柜运港，从而进一步强化贸易、增加公司收益。"),

------ 单位百科

		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_INVESTOR_CHAPTER_HISTORY_PARA_1",	"说起人类最早的风险投资实践，站在不同角度并且背景不同的研究者可能会有不一样的结论。有不少研究者认为，西班牙女王伊莎贝拉一世在1492年资助意大利探险家克里斯托弗。哥伦布发现“新大陆”的航海探险旅行，是人类历史上第一次风险投资的实践。[NEWLINE][NEWLINE]在那个时期，欧洲的海外贸易以及航海强权国家首推葡萄牙，但哥伦布的西向探险航海计划在当时被视为一个疯狂的冒险之举，并且彼时葡萄牙已经控制了南向去非洲以及东向去亚洲的海上航线，对充满不确定性的西向航海投资兴趣不大，所以，尽管哥伦布曾多次游说葡萄牙，但每次均无功而返。既然说服不了葡萄牙，哥伦布于是想另辟蹊径，转而去游说葡萄牙的邻居——西班牙。1489年5月，哥伦布第一次面见伊莎贝拉并向其兜售西向航海到印度的探险计划，女王的顾问团队认为计划不靠谱，哥伦布又一次被拒之门外。[NEWLINE][NEWLINE]以前有过多次被葡萄牙拒绝的经验，这位老哥当然不会因为伊莎贝拉的区区一次婉拒就放弃“募资”的努力，他仍锲而不舍地继续劝说西班牙王室。功夫不负有心人，1492年1月西班牙女王伊莎贝拉一世终于同意资助哥伦布航行所需的资金、船只、船员、补给品等等，授予后者一个“海军将军”的头衔，并答应将来自新殖民地征收的税收收入的10%奖励给哥伦布。[NEWLINE][NEWLINE]由此可见，尽管没有“风险投资基金”“GP””LP”等称呼，但哥伦布发现“新大陆”的探险航行，的确具备了现代风险投资基金的部分典型特征，堪称人类第一次风险投资实践和探索项目。一定程度上，哥伦布其实就是一个风投基金执行事务合伙人，获得了一定的基金管理费，可参与超额收益分配，而西班牙女王伊莎贝拉一世则可称得上是该探险项目的一个LP投资商。[NEWLINE][NEWLINE]当然，现在我们都知道了，该风投项目的影响不仅完全超出了哥伦布和伊莎贝拉一世两个当事人，而且里程碑式地改写了人类科学文明进程、世界政治版图、和国际经济史。[NEWLINE][NEWLINE]现代早期投资理念在文艺复兴后期出现在阿姆斯特丹。1560年代，一群荷兰商人派浩特曼至葡萄牙刺探商情，浩特曼回国后这群商人便成立一家公司，利用这个资讯往东印度地区发展。潜伏在葡属印度的扬·哈伊根·范·林斯霍滕在1595年归来，更是带回了大量从欧洲出发到东方的好望角航线的详细资料。从1595年4月至1602年间，荷兰陆续成立了14家以东印度贸易为重点的公司，为了避免过度的商业竞争，这14家公司于是合并，成为一家联合公司，也就是荷兰东印度公司。荷兰当时的国家议会授权荷兰东印度公司在东起好望角，西至南美洲南端麦哲伦海峡具有贸易垄断权。[NEWLINE][NEWLINE]荷兰东印度公司由位于阿姆斯特丹、泽兰省的密德堡市、恩克华生市、德夫特市、荷恩市、鹿特丹市六处的办公室所组成，其董事会由七十多人组成，但真正握有实权的只有十七人，被称为十七人董事会，分别是阿姆斯特丹八人、泽兰省4人，其他地区各一人。1602年，荷兰东印度公司兴高采烈的商人选择了一种出售和交易这些船只股份的方式，成立了阿姆斯特丹证券交易所，到1669年公司已经成为有史以来世界上最富有的公司，拥有150条商船，40条战舰，50000名员工和10000人的私人武装，公司投资的收益率为40%。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_INVESTOR_CHAPTER_HISTORY_PARA_2",	"虽然现在世界各地的证券交易所要多得多（其中最著名的是东京、伦敦，尤其是纽约），而且规则也已经制定好了，但它们与阿姆斯特丹的祖先有着极大的相似之处。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_INVESTOR_CHAPTER_HISTORY_PARA_3",	"投资是一个充满不确定因素的事情，现代投资者有数十个甚至数百个无法借鉴的例子。如果不谨慎，投资可能会导致一个人失去一切，然而投资者却很少谨慎。不管是1929年，2008年和2020年的重大市场崩盘并没有阻止投资者脱离他们的危险策略和计划。【译者注：理财有风险，投资需谨慎】"),

------ 基础单位信息

		("zh_Hans_CN",	"LOC_UNIT_LEU_TYCOON_NAME",											"资本家"),
		("zh_Hans_CN",	"LOC_UNIT_LEU_TYCOON_DESCRIPTION",									"高成本的平民单位，只能用 [ICON_Gold] 金币购买。需所在城市拥有工作坊（工业区）。[NEWLINE][NEWLINE]资本家可在奢侈品资源上创建公司，让您文明创造出 [ICON_GreatWork_Product] 产品。解锁科技“蒸汽动力”后，可修建铁路与火车站以用来改善您帝国境内的贸易，并提高 [ICON_Production] 生产力。"),

------ 单位百科

		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_TYCOON_CHAPTER_HISTORY_PARA_1",		"大亨（Tycoon），源自日本语对幕府将军的尊称“大君”（taikun）一词传入欧洲，19世纪成为欧洲人对富豪的称号。后中国人翻译为“大亨”，指在一个行业内拥有相当大的财富和权力的人士，例如在金融界有财有势之人会被称为“金融大亨”。很多商业模拟游戏也会以“大亨”命名，著名的例子包括地产大亨（又译大富翁）。1857年，随着佩里准将返回美国，这个词进入了英语。美国总统亚伯拉罕·林肯被他的助手约翰·尼科莱和约翰·海伊幽默地称为大亨。这个词流传到商界，“大亨”和“男爵”这些词通常用于19世纪末20世纪初北美采掘业的商业巨头，如采矿、伐木和石油，运输业如航运和铁路，制造业如汽车制造和炼钢，银行业，他们的统治地位被称为第二次工业革命时代。【译者注：其实大亨就是资本家，为了方便理解直接译为资本家】"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_TYCOON_CHAPTER_HISTORY_PARA_2",		"在19世纪后半叶，即从1870年到1900年的美国镀金时代【译者注：从南北战争结束到20世纪初叶的美国历史时期也就被定名为“镀金时代”】，这战后的30多年间，美国工业迅速发展，走向了集中、垄断。垄断资本主义逐渐成为了美国经济的生活基础，从1869年第一条横贯大陆的铁路的建成通车，科学技术的发展改变了人们的生活方式。20世纪日常生活中电灯、电话、电报、电影等在此期间诞生，工业竞争日益激烈，工业巨头不断产生。城市化进程进一步加快，边疆已宣告结束，农业革命已经完成。资产阶级将这一阶段称之为“黄金时代”。19世纪末20世纪初属于美国资本家强取豪夺时期。他们为了自己的利益而不管工人死活。当时美国工人不仅工资低、生活贫困，而且其劳动安全根本没有保障，工作伤亡事故非常严重。以至劳资关系越来越紧张，罢工频发。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_TYCOON_CHAPTER_HISTORY_PARA_3",		"像约翰·D·洛克菲勒、科尼利厄斯·范德比尔特、亨利·福特和安德鲁·卡内基这样的人的财富，以今天的标准来衡量，会有几千亿美元而且远远超过像埃隆·马斯克、比尔·盖茨、马克·扎克伯格甚至杰夫·贝佐斯这样的科技巨头，截至2019年，世界上最有钱的8个人的财富，等于最穷的那35亿人的总和。就像马克吐温在《镀金时代》揭露美国政企勾结、各“利益集团”左右政府以至贪污腐败成风的社会现实，"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_TYCOON_CHAPTER_HISTORY_PARA_4",		"但是从另一方面看，镀金时代美国取得的进步是不可否认的。作为第二次工业革命的一部分，这个国家经历了一次令人印象深刻的经济扩张，这是由当时的财富和权力的超乎寻常的数字所引领的。这种增长很大程度上得益于铁路（现在从一个海岸延伸到另一个海岸）以及工厂、钢铁和煤矿业。随着打字机、收银机等技术的发展，大企业蓬勃发展，增加的机器有助于改变人们的工作方式。经济爆炸不仅包括工业增长，还包括机械化农业等农业技术的增长。"),
		("zh_Hans_CN",	"LOC_PEDIA_UNITS_PAGE_UNIT_LEU_TYCOON_CHAPTER_HISTORY_PARA_5",		"1881年至1905年，美国先后有七百万工人举行了37000次罢工。仅1886年就有700000人罢工。罢工运动对美国社会有两大影响。一是通过罢工运动可以看出工人阶级对现行资本主义制度不满；二是通过罢工运动形成了一股强有力的集体力量，一个新生红色幽灵漂浮在欧洲上空游荡。");


