-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'RwF Great Theologians'CN_Add_IG2
-- Author: 牛奶大魔王 , Clear8Sky
-- DateCreated: 2021/9/29 8:05:41
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “RwF: Great Theologians” 。该文件在 InGame 时载入，无需任何 Criteria

---- 针对这些Tag对游戏自带“托马斯·阿奎那”伟人的背景相关文本做的改动，添加条件语句，只有原模组启用时以下替换才生效

UPDATE LocalizedText
SET Text = 
	(CASE
		WHEN (Tag = "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_1" AND Language = "zh_Hans_CN")
			THEN "扬·胡斯（又译作约翰·胡斯、约翰·胡司），哲学家、改革家，捷克伟大的爱国者，曾任布拉格查理大学校长。胡司以献身教会改革和捷克民族主义的大义而殉道留名于世，他的追随者被称为胡斯（胡司）信徒。主张建立独立于天主教的民族教会，发动反抗德国封建主的民族解放运动，一四一五年，康斯坦茨教长会议在他拒绝放弃新教教义后处以死刑，将他烧死。"
		WHEN (Tag = "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_2" AND Language = "zh_Hans_CN")
			THEN "在基督教改革理论家约翰·怀克里夫之后，胡斯被认为是第一位教会改革家，因为他生活在路德、卡尔文和茨温利时代之前。他的教义对西欧教会产生了强烈影响，最快的是通过改革后的波西米亚宗教教派，一个多世纪后，对马丁·路德本人也产生了影响。[NEWLINE][NEWLINE]他曾任布拉格查理大学校长。胡斯以献身教会改革和捷克民族主义的大义而殉道留名于世，他的追随者被称为胡斯信徒。罗马天主教视其为异教徒，于1411年革除其教籍。1414年，康斯坦茨宗教会议判罚胡斯有罪，于次年将其处以火刑。胡斯之死直接导致了胡斯战争的爆发。1999年，罗马天主教会为此进行道歉。[NEWLINE][NEWLINE]他曾经接受神父的训练，后来成为波希米亚布拉格大学神学部主任，最後成为校长。[NEWLINE][NEWLINE]早在胡斯出生前波希米亚早就已经发展出一股强烈反罗马教会的意识，在神学思想上他受英国的威克里夫很深的影响。[NEWLINE][NEWLINE]扬胡斯被处以火刑胡斯是宗教改革运动的先驱，他的许多言论，为後来的新教所接受。他对整个欧洲各国和马丁·路德也产生了重要影响。胡斯一生有多部著作，在捷克文学历史上贡献卓越。胡斯认为圣经至上，而非教宗等圣职人员所订的规条，强调教会的主权属耶稣基督，为了此种意念及想法於是撰写了《论教会》（De ecclesia，1413）一书，甚至大肆批评教宗等圣职人员，已偏离基督真道，贪爱钱财及滥权等等，真是改教的先驱之一。[NEWLINE][NEWLINE]当时教会正值“大分裂”（主后1378-1417）的状况：罗马枢机院前于所选出的两个教宗，分别是位于罗马的贵格利十二世及位于亚威农的约翰二十三世，两人互相较竞。约翰二十三世为了对抗拿坡里王（为贵格利十二世所支持）而释出赎罪券给所有需要的人，以金钱来换取，胡斯过去虽曾花大把银子买赎罪券，但如今胡斯大大地谴责此种违反圣经教导的作法，於是约翰二十三世将胡斯取消教籍，最後甚至以异端名义将他下进监牢中。[NEWLINE][NEWLINE]经过长达8个月的监禁，胡斯面容憔悴、身体虚弱，被提出监来上城门口，并将他绑在火刑柱上，终被烧死。导致“十字军”再度兴起和胡斯所在的波希米亚的信众展开了一场场的战役，直到十五世纪才结束。胡斯还创造了新的正字法，为捷克语书面语言奠定了基础。[NEWLINE][NEWLINE]胡斯逝世的7月6日被称为胡斯日，是捷克的公共假期。如今，大多数捷克人都自认为没有宗教信仰，而且捷克的天主教信徒要远多于胡斯信徒，但扬·胡斯仍然被认为是国家英雄。"
		WHEN (Tag = "LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_3" AND Language = "zh_Hans_CN")
			THEN "胡斯之死，在整个捷克引起了强烈的反应，人们把对胡斯的迫害看作对整个民族的冒犯，反抗罗马教皇和帝国皇帝的斗争更趋激烈，一四一九年七月在胡斯宗教改革的旗帜下，爆发了捷克史上伟大的农民战争——胡斯战争。[NEWLINE][NEWLINE]这一震撼整个欧洲的胡斯运动以及此后十余年的胡斯战争，给帝国和罗马教廷的统治以沉重的打击，扫除了德国上层剥削者在捷克的势力，保证了以后一个多世纪捷克完全脱离帝国的统治。[NEWLINE][NEWLINE]金色布拉格的古城广场正中，矗立着一座令人肃然起敬的巨大塑像，这就是马克思、恩格斯都曾赞扬过的捷克民族权利和人民权利的保护者、中世纪著名的宗教改革家扬·胡斯。每年夏天，在胡斯遇难的日子里，人们纷纷来到这里，向这位为真理而斗争的战士致敬。[NEWLINE][NEWLINE]十四世纪末到十五世纪中叶的捷克王国，是所谓神圣罗马帝国的一部分。捷克广大农民受着封建土地的占有者——德国僧侣把持的天主教教会和德国贵族的残酷的剥削。捷克人民不堪忍受剥削，展开了反对民族压迫和社会压迫的斗争。他们首先起来反对宗教压迫。传教士扬·胡斯是这一斗争的领袖人物。"
	END)
/*	笨蛋奶自己写的，跟原文不对应，以后自己再翻译补上。附原文：
第一段：Jan Hus, sometimes Anglicized as John Hus or John Huss, also referred to in historical texts as Iohannes Hus or Johannes Huss) was a Czech theologian, philosopher, master, dean, and rector of the Charles University in Prague who became a church reformer, an inspirer of Hussitism, a key predecessor to Protestantism and a seminal figure in the Bohemian Reformation.
第二段：After John Wycliffe, the theorist of ecclesiastical reform, Hus is considered the first church reformer, as he lived before Luther, Calvin, and Zwingli. His teachings had a strong influence on the states of Western Europe, most immediately in the approval of a reformed Bohemian religious denomination, and, more than a century later, on Martin Luther himself. He was burned at the stake for heresy against the doctrines of the Catholic Church, including those on ecclesiology, the Eucharist, and other theological topics.
第三段：After Hus was executed in 1415, the followers of his religious teachings (known as Hussites) rebelled against their Catholic rulers and defeated five consecutive papal crusades between 1420 and 1431 in what became known as the Hussite Wars. Both the Bohemian and the Moravian populations remained majority Hussite until the 1620s, when a Protestant defeat in the Battle of the White Mountain resulted in the Lands of the Bohemian Crown coming under Habsburg dominion for the next 300 years and being subject to immediate and forced conversion in an intense campaign of return to Catholicism.
*/
WHERE Tag IN
(
	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_1",
	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_2",
	"LOC_PEDIA_GREATPEOPLE_PAGE_GREAT_PERSON_INDIVIDUAL_THOMAS_AQUINAS_CHAPTER_HISTORY_PARA_3"
)
AND EXISTS (SELECT Tag, Language FROM LocalizedText WHERE (Tag = "LOC_GREAT_PERSON_INDIVIDUAL_JFD_JAN_HUS_NAME" AND Language = "en_US"));


