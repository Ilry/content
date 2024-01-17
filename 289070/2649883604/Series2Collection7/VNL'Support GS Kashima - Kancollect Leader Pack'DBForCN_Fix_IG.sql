-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Support GS Kashima - Kancollect Leader Pack'DBForCN_Fix_FI1
-- Author: Clear8Sky
-- DateCreated: 2021/8/10 22:50:01
--------------------------------------------------------------

-- 该文件对应修正模组 “[Support G&S] 鹿岛 - Kancollect Leader Kashima Pack”的 Kashima_Text.xml 文件。该文件在 FrontEnd 与 InGame 时载入 UpdateText ，无需任何 Criteria

/*	以下修正全部作废，原因可见 Agreement_of_Translation.txt 后面的笔记
---- Kashima_Text.xml 文件内 BaseGameText 表中的 LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD 这个 Tag 也存在于 佐世保镇守府 - Kancollect Civilization Sasebo Pack 模组中的 Sasebo_Text.xml 文件内同样的表中。而在游戏加载文件时，由于两文件各自所属的 Action 都未定义 LoadOrder ，故均默认为0，即同时加载；而后，由于 Kashima_Text.xml 以K开头，而 Sasebo_Text.xml 以S开头，则按字母顺序前者先加载，故而导致报错中显示后者文件中存在 Tag 与前者重复，致使 Sasebo_Text.xml 文件内 LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD 往后所有 Tag 的文本赋值均失效。
---- 为解决此问题，拟定本文件为O开头，并且特别为其开设一个 Action ，同样不定义 LoadOrder ，令其与上述两文件一起参与 LoadOrder = 0 的加载过程。而因本文件首字母为O，则将排在 Kashima_Text.xml 之后， Sasebo_Text.xml 之前，故可在 Kashima_Text.xml 加载完之后用本文件将其中的 LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD 给 DELETE 掉，再重新定义不引起重复的新 Tag 并赋值。之后再加载 Sasebo_Text.xml 也不会导致重复冲突了。
---- 注：游戏文件载入的排序是把文件夹路径也给加上的，之前放在 Series2Collection7 文件夹里，虽然还是以O开头，但实际游戏排序时认定该文件为 “Series2Collection7/O_VNL'Support GS Kashima - Kancollect Leader Pack'Bug_Fix_FI1.sql”，还是比 “Sasebo_Text.xml”靠后（原模组为根目录下）。故决定将此文件移出 Series2Collection7 ，也放在根目录下。
---- 或许会有疑问：删掉该 Tag 后，在游戏中如果 鹿岛 模组用到了该 Tag ，会不会无法显示？其实不会，因为后面加载的 Sasebo_Text.xml 又补上了这里的空缺，本文件只是将前面会引起重复的部分给“挪了出去”，后面进来的自然会补全。
---- 但是又发现问题：如果对于只订阅 鹿岛 而未订阅 佐世保镇守府 的玩家，不就无法补空缺了吗？确实是个问题，也能解决，只是麻烦些，需要把所有引用到 LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD 的文件里的该 Tag 给 Update 掉。但这里暂不解决此问题，因为 鹿岛 启用的前提是 佐世保 启用，故不存在上述假设。

DELETE FROM LocalizedText
WHERE Tag = "LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD"
AND EXISTS (SELECT Tag FROM BaseGameText WHERE Tag = "LOC_LEADER_KASHIMA_NAME");

INSERT OR IGNORE INTO BaseGameText
		(Tag,												Text)
VALUES		
		("LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD_BACKUP",		"+{1_num} [ICON_Gold] Gold from adjacent Sasebo Naval Harbour.");

INSERT OR REPLACE INTO LocalizedText
		(Language,		Tag,											Text)
VALUES		
		("zh_Hans_CN",	"LOC_DISTRICT_SASEBO_NAVY_HARBOR_GOLD_BACKUP",	"+{1_num} [ICON_Gold] 金币 来自相邻 佐世保海军港口");
*/

