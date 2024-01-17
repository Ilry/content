-- 由CLear8Sky对Mod Buddy内生成的SQL文件模板进行改动，以便于写入中文
-- VNL'Radial Measuring Tool'CN_Add_IG
-- Author: DeepLogic , Clear8Sky
-- DateCreated: 2021/11/10 13:58:07
--------------------------------------------------------------

-- 该文件对应补译/润色模组 “Radial Measuring Tool” 。该文件在 InGame 时载入，无需任何 Criteria

INSERT OR REPLACE INTO LocalizedText 
		(Language,		Tag,							Text)
VALUES

---- 主界面

		("zh_Hans_CN",	"LOC_RMT_BTN",					"RMT"),
		("zh_Hans_CN",	"LOC_RMT_BTN_TT",				"范围测量工具[NEWLINE]Alt + 4 开启/关闭模组窗口[NEWLINE]Esc 关闭模组窗口"),
		("zh_Hans_CN",	"LOC_RMT_WND_TITLE",			"范围测量工具"),
		("zh_Hans_CN",	"LOC_RMT_LBL1",					"点击地图上任意位置以高亮显示其给定范围内的单元格"),
		("zh_Hans_CN",	"LOC_RMT_RAD_LBL",				"半径："),
		("zh_Hans_CN",	"LOC_RMT_RAD_CB_TT",			"高亮区域范围"),
		("zh_Hans_CN",	"LOC_RMT_ALT_RAD_CB_TT",		"另式范围计数。选中此项后，下拉列表中将采用“在 X 格内”的计数方式"),
		("zh_Hans_CN",	"LOC_RMT_ALT_RAD_PREFIX",		"在"),
		("zh_Hans_CN",	"LOC_RMT_ALT_RAD_SUFIX",		"格内"),
		("zh_Hans_CN",	"LOC_RMT_CB_SUGGESTIONS",		"在地图上标出显著点（测试版）"),
		("zh_Hans_CN",	"LOC_RMT_CB_SUGGESTIONS_TT",	"“范围测量工具”将尝试在该范围内找出建立城市的最佳位置。可能与游戏内默认推荐位置有所不同，也可能并非“最佳”。"),
		("zh_Hans_CN",	"LOC_RMT_CB_MULTI",				"多重范围叠加高亮"),
		("zh_Hans_CN",	"LOC_RMT_CB_MULTI_TT",			"范围内单元格至多有8种颜色"),
		("zh_Hans_CN",	"LOC_RMT_CB_INTERSECT",			"禁用颜色交叉"),
		("zh_Hans_CN",	"LOC_RMT_CB_INTERSECT_TT",		"禁用多重范围叠加高亮下的颜色交叉"),
		("zh_Hans_CN",	"LOC_RMT_CB_DIMMING",			"禁用黯淡效果"),
		("zh_Hans_CN",	"LOC_RMT_CB_DIMMING_TT",		"禁用范围外单元格的颜色黯淡效果"),
		("zh_Hans_CN",	"LOC_RMT_CB_CITY_ONLY",			"仅高亮市中心"),
		("zh_Hans_CN",	"LOC_RMT_CB_CITY_ONLY_TT",		"只对市中心单元格进行高亮"),
		("zh_Hans_CN",	"LOC_RMT_CB_IGNORE_VIS",		"忽略可见限制"),
		("zh_Hans_CN",	"LOC_RMT_CB_IGNORE_VIS_TT",		"对范围内所有单元格（包含尚未探索的）进行高亮与产出计算"),
		("zh_Hans_CN",	"LOC_RMT_CB_BONUS_RES",			"忽略加成资源"),
		("zh_Hans_CN",	"LOC_RMT_CB_BONUS_RES_TT",		"对奢侈品或战略资源单元格进行高亮，忽略加成及其他资源单元格"),
		("zh_Hans_CN",	"LOC_RMT_KEYS_TT",				"与先前所设范围（范围中心#2）相比，当前范围内单元格的相关变化"),
		("zh_Hans_CN",	"LOC_RMT_LBL_TERR_YIELS_DEF",	"地形产出"),
		("zh_Hans_CN",	"LOC_RMT_CB_TRANSP",			"窗口透明化"),
		("zh_Hans_CN",	"LOC_RMT_CB_WND_POS",			"窗口位置"),
		("zh_Hans_CN",	"LOC_RMT_UNLEASHED_OPTION",		"移至解限版本"),
		("zh_Hans_CN",	"LOC_RMT_UNLEASHED_OPTION_TT",	"该项或许并不适合联机对局，已被移至本模组的“解限版本（Unleashed version）”。"),
		("zh_Hans_CN",	"LOC_RMT_CB_BONUS_RES",			"忽略加成资源"),
	
---- 代码主界面		
		
		("zh_Hans_CN",	"LOC_RMT_MAX_CITY_RAD",			"- 公民可工作范围"),
		("zh_Hans_CN",	"LOC_RMT_GAME_BUG_WARN",		"（游戏Bug，黯淡效果已关闭）"),
		("zh_Hans_CN",	"LOC_RMT_RES_OVERFLOW",			"……"),
		("zh_Hans_CN",	"LOC_RMT_RES_OVERFLOW_TT",		"某些资源并不适合该行，故此处未显示。"),

		("zh_Hans_CN",	"LOC_RMT_KEY_CITY_CEN",			"市中心 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_RES",				"资源 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_RES_WATER",		"海岸与湖泊中的资源 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_RES_RANGE",		"其他城市待扩张区内的资源 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_RES_OWNED",		"其他城市境内的资源 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_TILE_RANGE",		"其他城市待扩张区的单元格 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_TILE_OWNED",		"其他城市境内的单元格 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_TILE_NOT_PASS",	"不可逾越地形单元格 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_TILE_WATER",		"海岸与湖泊单元格 "),
		("zh_Hans_CN",	"LOC_RMT_KEY_TILE_NOTHING",		"普通单元格 "),
		
		("zh_Hans_CN",	"LOC_RMT_YIELDS_TT",			"与先前所设范围（范围中心#2）相比，当前范围内的地形产出变化。[NEWLINE]仅对非其他城市境内的单元格进行产出统计。"),

		("zh_Hans_CN",	"LOC_RMT_RES_TT",				"与先前所设范围（范围中心#2）相比，当前范围内的资源可见性变化。[NEWLINE]仅对非其他城市境内的单元格进行产出统计。[NEWLINE]忽略重复资源。[NEWLINE]前缀：[NEWLINE]无——资源在先后两个范围内均可见；[NEWLINE][COLOR_GREEN]+[ENDCOLOR]——资源仅在当前范围内可见；[NEWLINE][COLOR_RED]-[ENDCOLOR]——资源仅在先前范围内可见。[NEWLINE][NEWLINE]{1_res}"),

---- 总览视角的地图钉
		
		("zh_Hans_CN",	"LOC_RMT_RAD_PIN_TXT",			"RMT"),
		("zh_Hans_CN",	"LOC_RMT_RAD_PIN_TT",			"先前所设范围中心位置#{1_radIdx}[NEWLINE]{2_YieldsTT}[NEWLINE][NEWLINE]{3_ResTT}[NEWLINE][NEWLINE]左键单击以激活此范围。[NEWLINE]右键单击以移除此范围。"),
		("zh_Hans_CN",	"LOC_RMT_RAD_PIN_YIELDS_TT",	"[NEWLINE]对所设范围与当前范围进行比较："),
		("zh_Hans_CN",	"LOC_RMT_REC_PIN_TT",			"“范围测量工具”评估此处为在该范围内建立城市的最佳位置之一……[NEWLINE]评估参考值：");