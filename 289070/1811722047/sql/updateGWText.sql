-- updateGWText
-- Author: Hunter Pen
-- DateCreated: 7/21/2019 20:45:06 PM

-- Base.
UPDATE LocalizedText SET
Text='Unlocks the Builder ability to construct the Great Wall, unique to China.[NEWLINE][NEWLINE]Provides an increase to [ICON_Strength] Defense. Bonus to [ICON_Gold] Gold, [ICON_Food] Food, [ICON_Production] Production, [ICON_Science] Science, [ICON_Culture] Culture, [ICON_Faith] Faith and [ICON_Amenities] Amenities if adjacent to other segments. Additional [ICON_Tourism] Tourism as you advance through the Technology Tree for adjacent segments.'
WHERE Tag='LOC_IMPROVEMENT_GREAT_WALL_DESCRIPTION' AND Language='en_US';

UPDATE LocalizedText SET
Text='解锁建造者建造长城（中国特有）的能力。[NEWLINE][NEWLINE]提高[ICON_Strength] 防御力。如果和其他段相邻，获得 [ICON_Gold] 金币， [ICON_Food] 食物， [ICON_Production] 生产力， [ICON_Science] 科技值， [ICON_Culture] 文化值， [ICON_Faith] 信仰值和 [ICON_Amenities] 宜居度加成。随着您在科技不断取得进步，与长城相邻也可获得额外的 [ICON_Tourism] 旅游业绩。'
WHERE Tag='LOC_IMPROVEMENT_GREAT_WALL_DESCRIPTION' AND Language='zh_Hans_CN';

-- Compatible with GS.
UPDATE LocalizedText SET
Text='Unlocks the Builder ability to construct the Great Wall, unique to China.[NEWLINE][NEWLINE]Provides an increase to [ICON_Strength] Defense. Bonus to [ICON_Gold] Gold, [ICON_Food] Food, [ICON_Production] Production, [ICON_Science] Science, [ICON_Culture] Culture, [ICON_Faith] Faith and [ICON_Amenities] Amenities if adjacent to other segments. Additional [ICON_Tourism] Tourism as you advance through the Technology Tree for adjacent segments.'
WHERE Tag='LOC_IMPROVEMENT_GREAT_WALL_EXPANSION2_DESCRIPTION' AND Language='en_US';

UPDATE LocalizedText SET
Text='解锁建造者建造长城（中国特有）的能力。[NEWLINE][NEWLINE]提高[ICON_Strength] 防御力。如果和其他段相邻，获得 [ICON_Gold] 金币， [ICON_Food] 食物， [ICON_Production] 生产力， [ICON_Science] 科技值， [ICON_Culture] 文化值， [ICON_Faith] 信仰值和 [ICON_Amenities] 宜居度加成。随着您在科技不断取得进步，与长城相邻也可获得额外的 [ICON_Tourism] 旅游业绩。'
WHERE Tag='LOC_IMPROVEMENT_GREAT_WALL_EXPANSION2_DESCRIPTION' AND Language='zh_Hans_CN';
