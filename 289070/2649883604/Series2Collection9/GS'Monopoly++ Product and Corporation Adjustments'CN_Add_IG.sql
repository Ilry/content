-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- GS'Monopoly++ Product and Corporation Adjustments'CN_Add_IG
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/10/7 13:46:10
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Monopoly++: Product and Corporation Adjustments” 。该文件在 InGame 时载入，LoadOrder 需要在5000以上以确保最后载入，需 Criteria ： Active_Expansion_2 与 Mode_Monopolies_ON

-- MonopolyPlus_Texts.sql文件
---- 针对原模组对游戏自带产品相关文本的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = REPLACE(Text, "Moving the [ICON_GREATWORK_PRODUCT] Product to another city or civilization grants this Corporation's tile +1 [ICON_GOLD] Gold. Consumes 2 [ICON_POWER] Power while produced.", "将 [ICON_GreatWork_Product] 产品送往其他城市或文明时，该公司单元格产出 [Icon_Gold] 金币。生产产品时消耗2点 [ICON_Power] 电力。")
WHERE Tag LIKE "LOC_PROJECT_CREATE_CORPORATION_PRODUCT_%_DESCRIPTION" AND Language = "zh_Hans_CN"
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_NAME" AND Language = "en_US"));

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_CORPORATIONS_PARA_2" AND Language = "zh_Hans_CN")
			THEN "公司可提供等同于其 [ICON_Gold] 金币加成的额外 [ICON_Tourism] 旅游业绩产出。可通过将 [ICON_GreatWork_Product] 产品送往其他城市来增加 [ICON_Gold] 金币加成，或根据公司单元格修建的可增加 [ICON_Gold] 金币产出的改良设施来获得加成。"
		WHEN (Tag = "LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION" AND Language = "zh_Hans_CN")
			THEN "一种致力于开发某一特定奢侈品资源的公司。允许城市创造 [ICON_GreatWork_Product] 产品，一种全新类型的巨作，可给予其所在城市大量加成。只能被自然灾害掠夺（无法被摧毁）。[NEWLINE]提供等同于其 [ICON_Gold] 金币加成的 [ICON_Tourism] 旅游业绩产出。可从其他城市送往此城的 [ICON_GreatWork_Product] 产品中获得+2 [ICON_Gold] 金币；此外，任何提升公司单元格 [ICON_Gold] 金币产出的改良设施亦可获得+2 [ICON_Gold] 金币。"
		WHEN (Tag = "LOC_TUTORIAL_CORPORATION_OPPORTUNITY_B" AND Language = "zh_Hans_CN")
			THEN "如今我们能够在帝国境内的奢侈品资源基础上组建公司。一旦我们改良了某种奢侈品的三处资源，就可创建公司，之后公司即可创造 [ICON_GreatWork_Product] 产品。当这些 [ICON_GreatWork_Product] 产品被送往其他城市时，亦可为公司单元格提供 [ICON_Gold] 金币产出，且进一步增加 [ICON_Tourism] 旅游业绩！"
	END)
WHERE Tag IN
(
	"LOC_PEDIA_CONCEPTS_PAGE_MONOPOLIES_CHAPTER_CORPORATIONS_PARA_2",
	"LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION",
	"LOC_TUTORIAL_CORPORATION_OPPORTUNITY_B"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_NAME" AND Language = "en_US"));

-- MonopolyPlusAdjustments_GreatPeopleTexts.sql文件

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,																						Text)
VALUES

---- 基础伟人信息

		("zh_Hans_CN",	"LOC_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_NAME",												"马云"),

---- 为人能力/巨作

		("zh_Hans_CN",	"LOC_LEU_GREATPERSON_PRODUCT_GOLD_SUMMARY",													"此城每拥有一件产品，则可获得{Amount} [ICON_Gold] 金币。"),
		("zh_Hans_CN",	"LOC_LEU_GREATPERSON_PRODUCT_TOURISM_SUMMARY",												"帝国境内所有 [ICON_GreatWork_Product] 产品的 [ICON_Tourism] 旅游业绩产出+{ScalingFactor}%。"),

---- 伟人百科
------ 马云
		
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_CHAPTER_HISTORY_PARA_1",	"马云，男，汉族，中共党员，1964年9月10日生于浙江省杭州市，祖籍浙江省嵊州市谷来镇，阿里巴巴集团主要创始人，现担任日本软银董事、大自然保护协会中国理事会主席兼全球董事会成员、华谊兄弟董事、生命科学突破奖基金会董事、联合国数字合作高级别小组联合主席。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_CHAPTER_HISTORY_PARA_2",	"1988年毕业于杭州师范学院外语系，同年担任杭州电子工业学院英文及国际贸易教师，1995年创办中国第一家互联网商业信息发布网站“中国黄页”，1998年出任中国国际电子商务中心国富通信息技术发展有限公司总经理，1999年创办阿里巴巴，并担任阿里集团CEO、董事局主席。2013年5月，辞任阿里巴巴集团CEO，继续担任阿里集团董事局主席。6月30日，马云当选全球互联网治理联盟理事会联合主席。2019年9月，马云卸任阿里巴巴董事局主席，继续担任阿里巴巴集团董事会成员。2021年4月，马云以484亿美元财富位列《2021福布斯全球富豪榜》第26名。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_CHAPTER_HISTORY_PARA_3",	"1995年，马云代表杭州市政府访问美国，第一次接触到互联网，他认为缺乏互联网中文网站是一个巨大的商机。回国后，他创办了中国网页公司，为中国企业创建网站，是中国最早的互联网公司之一。然而，两年后他离开了这家公司，部分原因是来自通信公司杭州电信的强大竞争，后者曾创建了一家竞争对手Chinesepage。从1998年到1999年，马云是北京一家由对外贸易经济合作部支持的互联网公司的负责人。然而，他觉得，如果他继续留在政府，他将错过互联网带来的经济机会。马云说服铁道部的团队和他一起回到杭州，找到了阿里巴巴集团，该集团推出了一个网站，为小企业之间的交易提供便利。马云坚信，小企业对小企业的互联网市场比企业对消费者的互联网市场具有更大的增长潜力。小企业需要支付会员费才能在阿里巴巴上被认证为值得信赖的卖家，而那些希望向中国以外的客户销售产品的企业则需要支付更高的费用。为了给网上销售注入信心，支付宝成立于2003年，作为交易的第三方。阿里巴巴发展迅速。2005年，它引起了美国门户网站雅虎的注意！，这家公司收购了40%的股份，在2007的阿里巴巴公司在香港的首次公开募股（IPO）中筹集了17亿美元。"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_CHAPTER_HISTORY_PARA_4",	"1991年，马云初次接触商业活动，集资3000人民币创办海博翻译社。头一个月，收入人民币700元，但房租高达人民币1500元。他于是利用转手小商品交易的方式，从广州、义乌等地进货，成功养活了翻译社，还组织了杭州第一个英语角。1995年，马云在出访美国时首次接触到因特网，回国后和他的妻子，还有同为老师的何一兵于1995年4月创办网站“中国黄页”，专为中国公司制作网页，其后不到三年时间，他们利用该网站赚到了人民币500万元。1997年，他为中国外经贸部开发其官方站点及中国产品网上交易市场。[NEWLINE][NEWLINE]1999年，马云正式辞去公职，创办阿里巴巴网站，开拓电子商务应用，尤其是B2B业务。2003年秘密成立淘宝网，2004年创立独立的第三方电子支付平台支付宝，两者目前在中国市场都处于领先地位，同时，阿里巴巴是全球领先的B2B网站。2006年马云成为央视二套《赢在中国》评委，还用中国雅虎和阿里巴巴为《赢在中国》官方网站提供平台。2013年5月10日，在淘宝十周年晚会上宣布，马云卸任阿里巴巴集团首席执行官（CEO）一职，由陆兆禧接任。2018年6月，马云访问马来西亚，与时任马来西亚首相马哈迪·莫哈末会面；他表示自己当年（1997年）正是看到马哈迪提出多媒体超级走廊的想法后，才受到启发，最终创立阿里巴巴集团。[NEWLINE][NEWLINE]2018年8月29日，支付宝（中国）信息技术有限公司法人发生变更，由马云变更为叶郁青；2018年9月10日，马云宣布2019年9月10日起，他将不再担任集团董事局主席（董事长），届时由张勇接任。2020年10月1日，马云卸任阿里巴巴集团董事。[NEWLINE][NEWLINE]2020年11月2日，中国人民银行、中国银保监会、中国证监会、国家外汇管理局对蚂蚁集团实际控制人马云等人进行了监管约谈"),
		("zh_Hans_CN",	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_LEU_JACK_MA_CHAPTER_HISTORY_PARA_5",	"马云是一个非常成功的企业家，但在创业历程中也是一个充满各种争议的创始人。[NEWLINE][NEWLINE]支付宝解除与阿里巴巴的协议控制[NEWLINE][NEWLINE]2011年，在未获董事会通过的情况下，马云决定终止支付宝与阿里巴巴集团之间的协议控制关系，以获取央行发放的支付牌照。由于此事件影响阿里巴巴集团这一上市公司的估值，故对投资者造成冲击。[NEWLINE][NEWLINE]2014年7月3日，有网友发布了马云等人此次拜访江西萍乡气功师王林的照片，随即引爆网络。马云发微博称，对未知的探索、欣赏和好奇是他的爱好，“即便是魔幻术，挑战背后的奥秘也快乐无穷”。他还说，“人类很容易以有限的科学知识去自以为是地判断世界”，“过度的沉溺信仰和迷失信仰都是迷信”。[NEWLINE][NEWLINE]2015年1月，马云对竞争对手京东“京东的模式存在巨大问题，将来会成为悲剧”的评论被媒体披露，引发争议，随后马云致歉。[NEWLINE][NEWLINE]2019年4月，996工作制引发争议后，马云在内部交流会中肯定996工作制，他认为，“能做996是一种巨大的福气，很多公司想996都没有机会”，“商业是最大的公益”，“所以今天中国BAT这些公司能够996，我认为是我们这些人修来的福报”，“我不要说996，到今天为止，我肯定是12x12以上”，“我很幸运，我没有后悔12x12，我从没有改变过自己这一点”，并称员工到阿里巴巴来，待遇和工作环境不是最重要，最重要的是阿里巴巴能把员工塑造为有理想、热爱工作的“不同的人”。但马云之前在一档节目中却说自己后悔终日忙工作，根本没时间陪家人，“要是能再活一次，我绝对不会再这样了”。[NEWLINE][NEWLINE]马云的上述言论受到质疑，对此，马云又通过新浪微博改口称“任何公司不应该，也不能强制员工996”，“没有人喜欢在一个强制996的企业里工作，这既不人道，也不健康，更难以持久，员工、家人、法律都不允许。”但是同时又强调“真正的996不是简单的加班，不是单调的体力活，和被剥削没有关系。而应该是花时间在学习、思考和自我的提升上”，“但是年轻人自己要明白，幸福是奋斗出来的！不为996辩护，但向奋斗者致敬！”[NEWLINE][NEWLINE]2020年10月，中国金融四十人论坛（CF40）联合各组委会成员机构在上海召开第二届外滩金融峰会。峰会主题为“危与机：新格局下的新金融与新经济”。10月24日，马云以联合国数字合作高级别小组联合主席、联合国可持续发展目标倡导者的身份进行了演讲。他说：“巴塞尔协议像一个老年人俱乐部。”“今天的银行延续的还是当铺思想，抵押和担保就是当铺。”“借10万块，你怕银行；借1000万，你和银行都有点慌；借10个亿，银行怕你。”此番言论引起社会广泛关注和议论。[NEWLINE][NEWLINE]11月2日，中国人民银行、中国银保监会、中国证监会、国家外汇管理局对蚂蚁集团实际控制人马云、董事长井贤栋、首席执行官胡晓明进行了监管约谈。[NEWLINE][NEWLINE]11月3日晚，上海证券交易所发布关于暂缓蚂蚁科技集团股份有限公司科创板上市的决定。香港交易所当晚也发表声明，暂缓蚂蚁集团H股上市。12月24日，受到中国人民银行、中国银保监会、中国证监会、国家外汇管理局将约谈蚂蚁集团涉嫌垄断行为立案调查，阿里巴巴的股价开市既跌超过15%，市值蒸发超过1100亿美金。");
