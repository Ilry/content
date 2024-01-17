-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RF'p0kiehls Precinct of Amun-Ra'CN_Add_FI
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/23 12:05:13
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “p0kiehl's Precinct of Amun-Ra” 。该文件在 FrontEnd 与 InGame 时载入，需 Criteria ： Active_Expansion_1

---- 区域

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,																				Text)
VALUES
		("zh_Hans_CN",	"LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME",											"阿蒙拉区"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_PRECINCT_AMUN_RA_DESCRIPTION",									"埃及与努比亚文明特色宗教活动区域，取代圣地，[ICON_Production] 建造成本更低。所在城市境内沼泽、绿洲与平原产出+1 [ICON_Faith] 信仰值。"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_PRECINCT_AMUN_RA_DESCRIPTION_ADJACENCY",							"相邻加成：从自然奇观、绿洲与沼泽单元格中获得大量 [ICON_Faith] 信仰值相邻加成。从泛滥平原与森林单元格中获得标准 [ICON_Faith] 信仰值相邻加成。从区域单元格中获得少量 [ICON_Faith] 信仰值相邻加成。"),
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_POK_DISTRICT_PRECINCT_AMUN_RA_CHAPTER_HISTORY_PARA_1",	"阿蒙（Amun；古埃及语：ἰmn，意为“隐藏者”（也拼作“Amon”），是八元神（Ogdoad）之一，与妻子姆特、儿子孔斯并称三柱神。当底比斯成为全埃及的都城后，他便成为埃及新王国时期的国神和新的太阳神。后来，阿蒙和拉融合为阿蒙拉。阿蒙是古埃及-底比斯的主神，因底比斯的兴起而成为国家的主神。这个名字意指“The Hidden One”，圣兽是鹅和公羊。阿蒙与拉神一样是太阳神。与拉神不同的是，阿蒙神一般以一位英俊威严的男子出现，而拉却是以慈祥年迈的老者出现。与原来拉神组合了阿图姆（Atum）不同，阿蒙并没有融入九柱天神系统。阿蒙作为底比斯的地方主神的时候有着自己不太完整的家族系统——这是埃及很多地方主神的共同特点——他有自己的妻子和儿子。成为全埃及主神后，这个系统依旧伴随着阿蒙。阿蒙的妻子是一位美丽的女神，叫穆特（Mut），儿子叫孔斯（Chons），是月神。阿蒙与妻子和儿子同住在底比斯的卡尔纳克神庙。阿蒙和儿子之间还有这样一个故事：阿蒙从来没有对人露出自己真正的形象，对儿子孔斯也不例外。孔斯要求阿蒙在他面前显现真正的形象，阿蒙却不愿意破例，但又不忍心拒绝儿子的请求。于是他用一只公羊的皮和头把自己包起来，在儿子面前出现。孔斯以为自己见到了父亲的真相，然后把这个秘密告诉所有人。埃及从此不杀公羊，只有每年阿蒙的生日才杀一只，并会用它的皮把阿蒙的神像包裹起来。"),	
		("zh_Hans_CN",	"LOC_PEDIA_DISTRICTS_PAGE_POK_DISTRICT_PRECINCT_AMUN_RA_CHAPTER_HISTORY_PARA_2",	"卢克索神庙（LuxorAmonTemple）证明了卢克索辉煌过去。它是古埃及第十八王朝的第十九个法老（公元前1398－1361年在位）艾米诺菲斯三世为祭奉太阳神阿蒙、他的妃子及儿子月亮神而修建的。到第十八王朝后期，又经拉美西斯二世扩建，形成现今留存下来的规模。阿蒙神庙（TheAmunTempleofKarnak）位于卢克索镇北4公里处，是卡尔纳克神庙（Karnak）的主体部分。许多游客都把阿蒙神庙当作卡尔纳克神庙的全部，其实卡尔纳克神庙共有三部分——供奉太阳神阿蒙（Amun）的阿蒙神庙阿蒙神庙供奉的是底比斯主神——太阳神阿蒙，始建于三千多年前的十七王朝，在此后的一千三百多年不断增修扩建，共有十座巍峨的门楼、三座雄伟的大殿。阿蒙神庙的石柱大厅最为著名，内有134根要6个人才能抱的巨柱，每根21米，顶上据说能站百来个人。这些石柱历经三千多年无一倾倒，令人赞叹。庙内的柱壁和墙垣上都刻有精美的浮雕和鲜艳的彩绘，它们记载着古埃及的神话传说和当时人们的日常生活。此外，庙内还有闻名遐迩的方尖碑和法老及后妃们的塑像。神庙内部的圣地放置着圣船，外面有一个圣湖，祭司在行礼之前先在圣水中洗涤。圣湖旁有一座倒下的方尖碑和金龟子形状的雕刻，据说未婚女子绕金龟子雕塑跑上七圈，很快就会出嫁了。"),
/*
译者注：此处笨蛋奶没按照原模组的文本翻译，从别处找的背景故事应该是。以后自己重新翻译补上。
原文第一段：Amun was a major Egyptian deity and part of the Hermopolitan ogdoad. Attested from the Old Kingdom, he was initially a more minor deity, but with the 11th dynasty he became the patron god of Thebes and then eventually acquired national prominence after his fusion with the solar god Ra as Amun-Ra. Throughout the New Kingdom, Amun-Ra retained chief importance in the Egyptian pantheon. He was the transcendeltal, self-created creator deity. His position as King of the Gods developed to the point of virtual monotheism, in which other gods became manifestations of him. Amun-Ra came to be worshipped outside of Egypt; in Greece, he was identified with Zeus as Zeus Ammon. Along with Osiris, Amun-Ra is the most widely recorded of the Egyptian gods.
原文第二段：The Precinct of Amun-Ra is the largest main temple enclosure of the Karnak Temple Complex (ancient Thebes). It was built under Senusret I of the 11th dynasty. More major construction occurred during the 18th dynasty, as Thebes became the capital of ancient Egypt. Construction of the Hypostyle Hall may have also begun during the 18th dynasty, though most building was undertaken under Seti I and Ramesses II. Merneptah commemorated his victories over the Sea Peoples on the walls of the Cachette Court. The last major change to the layout of the Precinct of Amun-Ra was the addition fo the first pylon and the massive enclosure walls that surround the Precinct, both constructed by Nectanebo I of the last native Egyptian dynasty.
*/
		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_OASIS_FAITH",												"+{1_num} [ICON_Faith] 信仰值 来自相邻 绿洲单元格"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_FLOODPLAINS_FAITH",										"+{1_num} [ICON_Faith] 信仰值 来自相邻 沙漠泛滥平原单元格"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_GRASS_FLOODPLAINS_FAITH",									"+{1_num} [ICON_Faith] 信仰值 来自相邻 草原泛滥平原单元格"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_PLAINS_FLOODPLAINS_FAITH",								"+{1_num} [ICON_Faith] 信仰值 来自相邻 平原泛滥平原"),
		("zh_Hans_CN",	"LOC_POK_DISTRICT_AMUN_RA_MARSH_FAITH",												"+{1_num} [ICON_Faith] 信仰值 来自相邻 沼泽单元格");

---- 建筑，其中部分 Tag 涉及改动游戏自带“努比亚情景”中部分文本，保险起见，全部添加条件语句，只有原模组启用时以下替换才生效。

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_OBELISK_NAME",
		"zh_Hans_CN",
		"方尖碑"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_OBELISK_DESCRIPTION",
		"zh_Hans_CN",
		"埃及与努比亚文明特色建筑。允许所在城市用 [ICON_Faith] 信仰值购买传教士。[NEWLINE][NEWLINE]此城境内所有沼泽、绿洲与泛滥平原产出+1 [ICON_Gold] 金币。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_OBELISK_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"方尖碑（obelisk）是古埃及的杰作之一，是古埃及崇拜太阳的纪念碑，也是除金字塔以外，古埃及文明最富有特色的象征。方尖碑外形呈尖顶方柱状，由下而上逐渐缩小，顶端形似金字塔尖，塔尖常以金、铜或金银合金包裹，当旭日东升照到碑尖时，它像耀眼的太阳一样闪闪发光。碑高度不等，一般修长比为9~10:1，用整块花岗岩制成。碑身刻有象形文字的阴刻图案。古埃及的方尖碑后被大量搬运到西方国家。"
/*
译者注：此处需以后自己重新翻译补上，理由同上。
原文：The Precinct of Amun-Ra is the largest main temple enclosure of the Karnak Temple Complex (ancient Thebes). It was built under Senusret I of the 11th dynasty. More major construction occurred during the 18th dynasty, as Thebes became the capital of ancient Egypt. Construction of the Hypostyle Hall may have also begun during the 18th dynasty, though most building was undertaken under Seti I and Ramesses II. Merneptah commemorated his victories over the Sea Peoples on the walls of the Cachette Court. The last major change to the layout of the Precinct of Amun-Ra was the addition fo the first pylon and the massive enclosure walls that surround the Precinct, both constructed by Nectanebo I of the last native Egyptian dynasty.
*/
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_NUBIAN_SHRINE_NAME",
		"zh_Hans_CN",
		"古神殿"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_NUBIAN_SHRINE_DESCRIPTION",
		"zh_Hans_CN",
		"埃及与努比亚文明特色建筑。允许所在城市用 [ICON_Faith] 信仰购买使徒和审判官。[NEWLINE][NEWLINE]此城境内所有沼泽、绿洲与泛滥平原产出+1 [ICON_Food] 食物。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_NUBIAN_SHRINE_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"古埃及宗教建筑。公元前16世纪～前11世纪埃及新王国时期的主要建筑形式。多以石块砌筑。分带有柱廊的内院、大柱厅和神堂。大门前有方尖碑或法老雕像。正面墙上刻有着色浅浮雕。大柱厅内柱直径大于柱间间距，借以强化圣庙的气氛。建筑实例有卢克索的阿蒙神庙。"
/*
译者注：此处需以后自己重新翻译补上，理由同上。
原文：Naos is the Greek word for shrine. Small temple shrines littered the Nile region, dedicated to both the gods and to people seen as godly—though the latter were ostensibly religious, such dedications were certainly quite political. These shrines contained religious artifacts and were attended by both the priests assigned to them and the guards who kept away thieves.
*/
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TEMPLE_AMUN_NAME",
		"zh_Hans_CN",
		"阿蒙神庙"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_BUILDING_TEMPLE_AMUN_DESCRIPTION",
		"zh_Hans_CN",
		"埃及与努比亚文明特色建筑。[NEWLINE][NEWLINE]所在城市境内所有沼泽、绿洲与泛滥平原产出+1 [ICON_Culture] 文化值。阿蒙神庙可从此城皈依的主流宗教中获得其祭祀信仰加成。"
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));

INSERT OR REPLACE INTO LocalizedText
		(Tag,	Language,	Text)
SELECT	"LOC_PEDIA_BUILDINGS_PAGE_BUILDING_TEMPLE_AMUN_CHAPTER_HISTORY_PARA_1",
		"zh_Hans_CN",
		"卢克索神庙坐落在开罗以南670多公里处的上埃及尼罗河畔，位于古埃及中王国和新王国的都城底比斯南半部遗址上。卢克索古迹中最引人注目的是尼罗河东岸的卡纳克神庙(karnaktemple)和卢克索神庙(luxortemple)。卢克索已成为一座现代旅游城市、埃及的旅游胜地，那里弥漫着一股节日和欢快的气氛，位于市中心的庙宇神殿给卢克索打上了特殊的标记，每年都有几十万游客从世界各地慕名而来。埃及人常说：“没有到过卢克索，就不算到过埃及”。"
/*
译者注：此处需以后自己重新翻译补上，理由同上。
原文：To understand the god Amun’s importance to the Nile region, look to his temples. The Temple of Amun at Karnak is so vast it could hold five Great Pyramids. The Temple of Amun at Jebel Barkal in Nubia might have attained such splendor, if the Romans hadn't smashed it to pieces in 25 BCE.
*/
WHERE EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_POK_DISTRICT_PRECINCT_AMUN_RA_NAME" AND Language = "en_US"));



