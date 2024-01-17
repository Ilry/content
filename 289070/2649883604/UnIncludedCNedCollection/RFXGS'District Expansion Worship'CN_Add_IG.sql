-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- RFXGS'District Expansion Worship'CN_Add_IG
-- Author: ChiYiuWong , Clear8Sky
-- DateCreated: 2021/10/2 19:34:32
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “District Expansion: Worship”的 UC_REL_Worship_Text_AmunRa.sql 文件。该文件在 InGame 时载入，需 Criteria ： Active_Expansion_1 与 Active_Expansion_2 与 Active_Mod_AmRa

---- 对 Precinct of Amun-Ra 模组 中部分文本进行改动，已添加 Criteria 以保证只有 Precinct of Amun-Ra模组 启用时该文件才载入；Tag 形似新定义的，故暂不设生效条件

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES
		("zh_Hans_CN",	"LOC_BUILDING_TEMPLE_AMUN_DESCRIPTION_UC_JNR",	"埃及和努比亚文明特色建筑。所在城市境内所有沼泽、绿洲与泛滥平原产出+1 [ICON_Culture] 文化值。[NEWLINE]阿蒙神庙可从此城皈依主流宗教的不同祭祀建筑中获得以下加成：[NEWLINE]每回合+1 [ICON_Favor] 外交支持（宝塔或希腊神殿）。[NEWLINE]+1 [ICON_Amenities] 宜居度（独居庇所或窣堵波）。[NEWLINE]+2 [ICON_Food] 食物、+1 [ICON_Housing] 住房（谒师所或供奉神龛）。[NEWLINE]+2 [ICON_Production] 生产力（礼拜堂或羽蛇神庙）。[NEWLINE]+4 [ICON_Gold] 金币（禅寺或主教座堂）。[NEWLINE]+2 [ICON_Science] 科技值（清真寺或佛寺）。[NEWLINE]+2 [ICON_Culture] 文化值（大教堂或日式神社）。[NEWLINE]+2 [ICON_Faith] 信仰值（道观、拜火神庙、印度神庙或犹太教堂）。");