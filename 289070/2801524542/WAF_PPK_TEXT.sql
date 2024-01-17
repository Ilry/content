--------------------------------------------------------------------------------------------------------------------------
-- WAF_PPK_TEXT
-- Author: 帅气的凯(皮皮凯)
-- DateCreated: 4/26/2022 14:30:19 PM
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO LocalizedText
		(Tag,Language,Text)
VALUES
-- English US ------------------------------------------------------------------------------------------------------------
		("LOC_PPK_STRING",    "en_US",    "stop"),
		("LOC_PPK_TOOLTIP",    "en_US",    "Stop auto AI turns[NEWLINE][NEWLINE]Hotkey: Alt+S"),
		("LOC_PPK0_STRING",    "en_US",    "Reveal All"),
		("LOC_PPK0_TOOLTIP",    "en_US",    "Open the full World Map field of view, it is conducive to watching the rise and fall of all AI civilizations in the world.[NEWLINE]You can also choose not to open the full World Map field of view, and watch the rise and fall of AI civilization from another angle[NEWLINE]Hotkey: Alt+R[NEWLINE][NEWLINE]The “Reveal All” function is adjusted and changed according to the Leader you choose in this MOD menu at the moment"),
		("LOC_WAF_PPK_STRING",    "en_US",    "AI"),
		("LOC_WAF_PPK_TOOLTIP",    "en_US",    "Start the/Close the MODwindow[NEWLINE][NEWLINE]Hotkey: Alt+L to open/close window."),
		("LOC_WAF1_PPK_STRING",    "en_US",    "Watch AI fight MOD"),
		("LOC_WAF2_PPK_STRING",    "en_US",    "Switch to"),
		("LOC_WAF2_PPK_TOOLTIP",    "en_US",    "Next turn play as selected civilization"),
		("LOC_WAF3_PPK_STRING",    "en_US",    "Autoplay turns"),
		("LOC_WAF3_PPK_TOOLTIP",    "en_US",    "AI will play all civilizations for this number of turns"),
		("LOC_WAF4_PPK_STRING",    "en_US",    "Background"),
		("LOC_WAF4_PPK_TOOLTIP",    "en_US",    "Make MODbackground opaque"),
		("LOC_WAF5_PPK_STRING",    "en_US",    "Autosave"),
		("LOC_WAF5_PPK_TOOLTIP",    "en_US",    "Automatically save the game before switching civilization"),
		("LOC_WAF6_PPK_STRING",    "en_US",    "Run and switch"),
		("LOC_WAF6_PPK_TOOLTIP",    "en_US",    "If the number of turns you set is equal to 0,AI will complete the turn of the current civilization, and you will switch to the selected civilization. [NEWLINE]If the number of turns you set is greater than 0, AI will keep running, and the number of turns you run is determined by your setting"),
		("LOC_WAF7_PPK_STRING",    "en_US",    "Hide UI"),
		("LOC_WAF7_PPK_TOOLTIP",    "en_US",    "Hide the UI, which is conducive to watching AI fighting.If you want to hide all the UI, please use the ALT + U hotkey"),
--  中文(简体)---------------------------------------------------------------------------------------------------------------
		("LOC_PPK_STRING",    "zh_Hans_CN",    "停止"),
		("LOC_PPK_TOOLTIP",    "zh_Hans_CN",    "停止AI挂机运行[NEWLINE][NEWLINE]热键:Alt+S"),
		("LOC_PPK0_STRING",    "zh_Hans_CN",    "看全图"),
		("LOC_PPK0_TOOLTIP",    "zh_Hans_CN",    "打开全图视野，有利于观看人机大战。[NEWLINE]你也可以选择不打开全图视野，从而以一个文明的角度观赏一个AI文明的兴衰[NEWLINE]热键:Alt+R[NEWLINE][NEWLINE]“看全图”功能根据你此刻在这个MOD菜单中选择的领袖进行调整和变化的"),
		("LOC_WAF_PPK_STRING",    "zh_Hans_CN",    "AI"),
		("LOC_WAF_PPK_TOOLTIP",    "zh_Hans_CN",    "启动/关闭 MOD窗口[NEWLINE][NEWLINE]热键:Alt+L打开/关闭窗口"),
		("LOC_WAF1_PPK_STRING",    "zh_Hans_CN",    "观看AI战争MOD"),
		("LOC_WAF2_PPK_STRING",    "zh_Hans_CN",    "切换到"),
		("LOC_WAF2_PPK_TOOLTIP",    "zh_Hans_CN",    "下一回合按选定文明开始"),
		("LOC_WAF3_PPK_STRING",    "zh_Hans_CN",    "自动运行几回合"),
		("LOC_WAF3_PPK_TOOLTIP",    "zh_Hans_CN",    "AI将在这个回合数内玩所有文明"),
		("LOC_WAF4_PPK_STRING",    "zh_Hans_CN",    "MOD背景板"),
		("LOC_WAF4_PPK_TOOLTIP",    "zh_Hans_CN",    "这决定背景透明还是不透明"),
		("LOC_WAF5_PPK_STRING",    "zh_Hans_CN",    "自动保存"),
		("LOC_WAF5_PPK_TOOLTIP",    "zh_Hans_CN",    "在切换文明之前自动保存游戏"),
		("LOC_WAF6_PPK_STRING",    "zh_Hans_CN",    "运行和切换"),
		("LOC_WAF6_PPK_TOOLTIP",    "zh_Hans_CN",    "如果你设置的回合数等于0，AI将完成当前文明的回合，同时你将切换到所选文明。[NEWLINE]如果你设置的回合数大于0，那么AI将保持运行，运行的回合数由你的设置决定。"),
		("LOC_WAF7_PPK_STRING",    "zh_Hans_CN",    "隐藏UI"),
		("LOC_WAF7_PPK_TOOLTIP",    "zh_Hans_CN",    "隐藏UI，这有助于观看AI战斗，如果想隐藏全部UI请通过Alt+U热键来实现"),

--  中文(繁体)---------------------------------------------------------------------------------------------------------------
		("LOC_PPK_STRING",    "zh_Hant_HK",    "停止"),
		("LOC_PPK_TOOLTIP",    "zh_Hant_HK",    "停止ai挂機運行[NEWLINE][NEWLINE]熱鍵:Alt+S"),
		("LOC_PPK0_STRING",    "zh_Hant_HK",    "看全圖"),
		("LOC_PPK0_TOOLTIP",    "zh_Hant_HK",    "打開全圖視野，有利於觀看人機大戰。[NEWLINE]你也可以選擇不打開全圖視野，從而以一個文明的角度觀賞一個AI文明的興衰[NEWLINE]熱鍵:Alt+R[NEWLINE][NEWLINE]“看全圖”功能根據你此刻在這個MOD菜單中選擇的領袖進行調整和變化的"),
		("LOC_WAF_PPK_STRING",    "zh_Hant_HK",    "AI"),
		("LOC_WAF_PPK_TOOLTIP",    "zh_Hant_HK",    "啟動/關閉 MOD窗口[NEWLINE][NEWLINE]熱鍵:Alt+L打開/關閉窗口"),
		("LOC_WAF1_PPK_STRING",    "zh_Hant_HK",    "觀看AT戰爭MOD"),
		("LOC_WAF2_PPK_STRING",    "zh_Hant_HK",    "切換到"),
		("LOC_WAF2_PPK_TOOLTIP",    "zh_Hant_HK",    "下一回合按選定文明開始"),
		("LOC_WAF3_PPK_STRING",    "zh_Hant_HK",    "自動運行幾回合"),
		("LOC_WAF3_PPK_TOOLTIP",    "zh_Hant_HK",    "AI將在這個回合數內玩所有文明"),
		("LOC_WAF4_PPK_STRING",    "zh_Hant_HK",    "MOD背景板"),
		("LOC_WAF4_PPK_TOOLTIP",    "zh_Hant_HK",    "這決定MOD背景板透明還是不透明"),
		("LOC_WAF5_PPK_STRING",    "zh_Hant_HK",    "自動保存"),
		("LOC_WAF5_PPK_TOOLTIP",    "zh_Hant_HK",    "在切換文明之前自動保存遊戲"),
		("LOC_WAF6_PPK_STRING",    "zh_Hant_HK",    "運行和切換"),
		("LOC_WAF6_PPK_TOOLTIP",    "zh_Hant_HK",    "AI將完成當前文明的回合，同時你將切換到所選文明，同時你將切換到所選文明。 [NEWLINE]如果你設置的回合數大於0，那麼AI將保持運行，運行的回合數由你的設置決定"),
		("LOC_WAF7_PPK_STRING",    "zh_Hant_HK",    "隱藏UI"),
		("LOC_WAF7_PPK_TOOLTIP",    "zh_Hant_HK",    "隱藏UI，這有助於觀看AI戰鬥，如果想隱藏全部UI請通過Alt+U熱鍵來實現");
    
