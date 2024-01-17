insert or replace into EnglishText
    (Tag,                                       Text)
values
    ("LOC_FF16_NUMOF_CUSTOM_NOTATIONS",         "2"),
    ("LOC_HD_RECOMMENDED_MODS_NAME",            "Harmony in Diversity Recommanded"),
    ("LOC_HD_FULL_MODS_LIST",                   "521b8777-0977-4859-a5ee-3e411a732e5c,
                                                 c086b5a6-90d2-4dea-a32f-c642639b9469,
                                                 c0417322-9747-42d5-9717-b0df5a4c6e5d"),
    ("LOC_HD_NON_COMPATIBLE_MODS_NAME",         "HD Known [COLOR_Red]NOT Compatible[ENDCOLOR]"),
    ("LOC_HD_NON_COMPATIBLE_MODS_LIST",         ""),
    ("LOC_FF16_CUSTOM_NOTATION_1",              "[COLOR_Civ6LightBlue] HD [ENDCOLOR];{LOC_HD_RECOMMENDED_MODS_NAME};{LOC_HD_FULL_MODS_LIST}"),
    ("LOC_FF16_CUSTOM_NOTATION_2",              "[COLOR_Red] HD [ENDCOLOR];{LOC_HD_NON_COMPATIBLE_MODS_NAME};{LOC_HD_NON_COMPATIBLE_MODS_LIST}");

insert or replace into LocalizedText
    (Language,      Tag,                                Text)
values
    ("zh_Hans_CN",  "LOC_HD_RECOMMENDED_MODS_NAME",     "和而不同核心"),
    ("zh_Hans_CN",  "LOC_HD_NON_COMPATIBLE_MODS_NAME",  "和而不同[COLOR_Red]已知不兼容[ENDCOLOR]");

-- Title Localization
-- Please include the original English title below.
insert or replace into EnglishText
    (Tag,                                       Text)
values
    -- Mod Manager 
    ("LOC_47dccacdf1d04f25bb02deb2b528c833",    "LOC_MTL_ENHANCED_MOD_MANAGER_NAME"),
    ("LOC_MTL_ENHANCED_MOD_MANAGER_NAME",       "Enhanced Mod Manager");

-- 此处添加中文标题
insert or replace into LocalizedText
    (Language,      Tag,                                            Text)
values
    ("zh_Hans_CN",  "LOC_MTL_ENHANCED_MOD_MANAGER_NAME",            "加强版MOD管理器");

------------------------------------------------------------------------------------------------------
-- World Wonders
insert or replace into EnglishText
    (Tag,                                       Text)
values
    ("LOC_b21b40173e534e35ae381b5d7501e6d0",    "LOC_MTL_WW_WAT_ARUN_NAME"), -- Sukritact's Wat Arun
    ("LOC_MTL_WW_WAT_ARUN_NAME",                "[World Wonder] Wat Arun (Sukritact)"),
    ("LOC_943808b859134cfc93a80d5d4a0bc4af",    "LOC_MTL_WW_TEMPLE_OF_HEAVEN_NAME"), -- Temple Of Heaven
    ("LOC_MTL_WW_TEMPLE_OF_HEAVEN_NAME",        "[World Wonder] Temple Of Heaven (Isukaci)"),
    ("LOC_9f162187934247ca908578fc3f80f25d",    "LOC_MTL_WW_YELLOW_CRANE_TOWER_NAME"), -- Yellow Crane Tower
    ("LOC_MTL_WW_YELLOW_CRANE_TOWER_NAME",      "[World Wonder] Yellow Crane Tower (Windfly)"),
    ("LOC_cfba692ba7f84d6eaa4ba25aa704867c",    "LOC_MTL_WW_THREE_GORGES_DAM_NAME"), -- Three Gorges Dam
    ("LOC_MTL_WW_THREE_GORGES_DAM_NAME",        "[World Wonder] Three Gorges Dam (Windfly)"),
    ("LOC_3db98abad7ca4b4d9596e2344e593ed0",    "LOC_MTL_WW_NOTRE_DAME_NAME"), -- Notre Dame
    ("LOC_MTL_WW_NOTRE_DAME_NAME",              "[World Wonder] Notre Dame (Windfly)"),
    ("LOC_06d0b21887e44b699a16f620e1019150",    "LOC_MTL_WW_TEMPLE_OF_POSEIDON_NAME"), -- p0kiehl's Temple of Poseidon
    ("LOC_MTL_WW_TEMPLE_OF_POSEIDON_NAME",      "[World Wonder] Temple of Poseidon (p0kiehl)"),
    ("LOC_7f75eef47c104d00a1fb1de83f11db85",    "LOC_MTL_WW_NEUSCHWANSTEIN_CASTLE_NAME"), -- Neuschwanstein Castle (World Wonder)
    ("LOC_MTL_WW_NEUSCHWANSTEIN_CASTLE_NAME",   "[World Wonder] Neuschwanstein Castle (Deliverator)"),
    ("LOC_be61704aa0b545e5b2d86dfc524c31c1",    "LOC_MTL_WW_GLOBE_THEATRE_NAME"), -- Globe Theatre (World Wonder)
    ("LOC_MTL_WW_GLOBE_THEATRE_NAME",           "[World Wonder] Globe Theatre (Deliverator)"),
    ("LOC_6366039a6cd848d599ced7832a617629",    "LOC_MTL_WW_BURJ_KHALIFA_NAME"), -- Burj Khalifa (World Wonder)
    ("LOC_MTL_WW_BURJ_KHALIFA_NAME",            "[World Wonder] Burj Khalifa (Deliverator)"),
    ("LOC_e12c350ddf6a4d2193024466cab4353c",    "LOC_MTL_WW_UFFIZI_NAME"), -- Uffizi (World Wonder)
    ("LOC_MTL_WW_UFFIZI_NAME",                  "[World Wonder] Uffizi (Deliverator)"),
    ("LOC_f655675335314d36b4485a4053064524",    "LOC_MTL_WW_BOROBUDUR_NAME"), -- Borobudur (World Wonder)
    ("LOC_MTL_WW_BOROBUDUR_NAME",               "[World Wonder] Borobudur (Deliverator)"),
    ("LOC_fd3f13ba3d51442f94353aeca0116b46",    "LOC_MTL_WW_BUDDHAS_OF_BAMYAN_NAME"), -- Buddhas of Bamyan (World Wonder)
    ("LOC_MTL_WW_BUDDHAS_OF_BAMYAN_NAME",       "[World Wonder] Buddhas of Bamyan (Deliverator)"),
    ("LOC_f87fe104c6c54e119251db958c80c589",    "LOC_MTL_WW_ITSUKUSHIMA_SHRINE_NAME"), -- Itsukushima Shrine (World Wonder)
    ("LOC_MTL_WW_ITSUKUSHIMA_SHRINE_NAME",      "[World Wonder] Itsukushima Shrine (Deliverator)"),
    ("LOC_d1c3ef1600ed4d72a4681e584fdb85ad",    "LOC_MTL_WW_LEANING_TOWER_OF_PISA_NAME"), -- Leaning Tower of Pisa (World Wonder)
    ("LOC_MTL_WW_LEANING_TOWER_OF_PISA_NAME",   "[World Wonder] Leaning Tower of Pisa (Deliverator)"),
    ("LOC_b8a7c566c2ab44d4a52da97416faf690",    "LOC_MTL_WW_ABU_SIMBEL_NAME"), -- Abu Simbel (World Wonder)
    ("LOC_MTL_WW_ABU_SIMBEL_NAME",              "[World Wonder] Abu Simbel (Deliverator)"),
    ("LOC_89a948de5e48460881a4c52bd68bc4eb",    "LOC_MTL_WW_PROCELAIN_TOWER_NAME"), -- Porcelain Tower (World Wonder)
    ("LOC_MTL_WW_PROCELAIN_TOWER_NAME",         "[World Wonder] Porcelain Tower (Deliverator)"),
    ("LOC_aab332834b8f46a483c0784a8bfa177e",    "LOC_MTL_WW_BRANDENBURG_GATE_NAME"), -- Brandenburg Gate (World Wonder)
    ("LOC_MTL_WW_BRANDENBURG_GATE_NAME",        "[World Wonder] Brandenburg Gate (Deliverator)"),
    ("LOC_1cfe2a52233b4d4c8bdf209ec10352c1",    "LOC_MTL_WW_TOWER_BRIDGE_NAME"), -- Tower Bridge (World Wonder)
    ("LOC_MTL_WW_TOWER_BRIDGE_NAME",            "[World Wonder] Tower Bridge (Deliverator)"),
    ("LOC_ce086704334c43cdb26a478365503137",    "LOC_MTL_WW_MOTHERLAND_CALLS_STATUE_NAME"), -- The Motherland Calls Statue
    ("LOC_MTL_WW_MOTHERLAND_CALLS_STATUE_NAME", "[World Wonder] The Motherland Calls Statue (Windfly)"),
    ("LOC_5a5601c5090c417289fe8f1da9e2b96d",    "LOC_MTL_WW_ARECIBO_OBSERVATORY_NAME"), -- CIVILIZATION VI: ARECIBO OBSERVATORY
    ("LOC_MTL_WW_ARECIBO_OBSERVATORY_NAME",     "[World Wonder] Arecibo Observatory (Albro)"),
    ("LOC_a3c1c60d76e0408894e2497f5e85d888",    "LOC_MTL_WW_KINKAKU_JI_NAME"), -- CIVILIZATION VI: KINKAKU JI
    ("LOC_MTL_WW_KINKAKU_JI_NAME",              "[World Wonder] Kinkaku Ji (Albro)"),
    ("LOC_ecc4e31d8c794e4b98e7d96226cb95d9",    "LOC_MTL_WW_EMPIRE_STATE_BUILDING_NAME"), -- CIVILIZATION VI: EMPIRE STATE BUILDING
    ("LOC_MTL_WW_EMPIRE_STATE_BUILDING_NAME",   "[World Wonder] Empire State Building (Albro)"),
    ("LOC_ffa02d2fe5d443fdbb970a4868c7b3a7",    "LOC_MTL_WW_CN_TOWER_NAME"), -- CIVILIZATION VI: CN Tower
    ("LOC_MTL_WW_CN_TOWER_NAME",                "[World Wonder] CN Tower (Albro)"),
    ("LOC_e5f66e35a7104f89afe7a42e3e51cf9f",    "LOC_MTL_WW_ST_PETERS_BASILICA_NAME"), -- CIVILIZATION IV: ST PETERS BASILICA
    ("LOC_MTL_WW_ST_PETERS_BASILICA_NAME",      "[World Wonder] ST Peters Basilica (Albro)"),
    ("LOC_22e526eac0154c88b243d6476be0cbf0",    "LOC_MTL_WW_AREA51_NAME"),
    ("LOC_MTL_WW_AREA51_NAME",                  "[World Wonder] Area 51 (JNR)"),
    ("LOC_8719d97f0db44c18986382eb9b0c6175",    "LOC_MTL_NATIONAL_WONDERS_NAME"),
    ("LOC_MTL_NATIONAL_WONDERS_NAME",           "CIVLIZATION VI: NATIONAL WONDERS"),
    ("LOC_0fe4104b80e1434a88fc914ce2632944",    "LOC_MTL_NATIONAL_WONDERS_PACK1_NAME"),
    ("LOC_MTL_NATIONAL_WONDERS_PACK1_NAME",     "CIVLIZATION VI: NATIONAL WONDERS PACK 1");

-- 世界奇观
insert or replace into LocalizedText
    (Language,      Tag,                                            Text)
values
    ("zh_Hans_CN",  "LOC_MTL_WW_WAT_ARUN_NAME",                     "[世界奇观]郑王庙 (Sukritact)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_TEMPLE_OF_HEAVEN_NAME",             "[世界奇观]天坛 (Isukaci)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_YELLOW_CRANE_TOWER_NAME",           "[世界奇观]黄鹤楼 (Windfly)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_THREE_GORGES_DAM_NAME",             "[世界奇观]三峡大坝 (Windfly)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_NOTRE_DAME_NAME",                   "[世界奇观]巴黎圣母院 (Windfly)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_TEMPLE_OF_POSEIDON_NAME",           "[世界奇观]波塞冬神庙 (p0kiehl)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_NEUSCHWANSTEIN_CASTLE_NAME",        "[世界奇观]新天鹅堡 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_GLOBE_THEATRE_NAME",                "[世界奇观]环球剧院 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_BURJ_KHALIFA_NAME",                 "[世界奇观]哈利法塔 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_UFFIZI_NAME",                       "[世界奇观]乌菲兹 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_BOROBUDUR_NAME",                    "[世界奇观]婆罗浮屠 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_BUDDHAS_OF_BAMYAN_NAME",            "[世界奇观]巴米扬大佛 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_ITSUKUSHIMA_SHRINE_NAME",           "[世界奇观]严岛神社 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_LEANING_TOWER_OF_PISA_NAME",        "[世界奇观]比萨斜塔 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_ABU_SIMBEL_NAME",                   "[世界奇观]阿布辛贝神庙 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_PROCELAIN_TOWER_NAME",              "[世界奇观]大报恩寺塔 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_BRANDENBURG_GATE_NAME",             "[世界奇观]勃兰登堡门 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_TOWER_BRIDGE_NAME",                 "[世界奇观]伦敦塔桥 (Deliverator)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_MOTHERLAND_CALLS_STATUE_NAME",      "[世界奇观]祖国母亲在召唤 (Windfly)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_ARECIBO_OBSERVATORY_NAME",          "[世界奇观]阿雷西博天文台 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_KINKAKU_JI_NAME",                   "[世界奇观]金阁寺 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_EMPIRE_STATE_BUILDING_NAME",        "[世界奇观]帝国大厦 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_CN_TOWER_NAME",                     "[世界奇观]加拿大国家电视塔 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_ST_PETERS_BASILICA_NAME",           "[世界奇观]圣彼得大教堂 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_WW_AREA51_NAME",                       "[世界奇观]51区 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_NATIONAL_WONDERS_NAME",                "[国家奇观] 本体包 (Albro)"),
    ("zh_Hans_CN",  "LOC_MTL_NATIONAL_WONDERS_PACK1_NAME",          "[国家奇观] 扩展包1 (Albro)");

------------------------------------------------------------------------------------------------------
-- Natural Wonders
insert or replace into EnglishText
    (Tag,                                               Text)
values
    ("LOC_74c5c3d9540843159e0ab0c369f82bcd",            "LOC_MTL_NW_TERRA_MIRABILIS_NAME"), -- Terra Mirabilis
    ("LOC_MTL_NW_TERRA_MIRABILIS_NAME",                 "[Natural Wonders] Terra Mirabilis"),
    ("LOC_07c535c226ee48d196aa8b4964dad44b",            "LOC_MTL_NW_SUKRITACTS_FUJI_NAME"), -- Sukritact's Fuji
    ("LOC_MTL_NW_SUKRITACTS_FUJI_NAME",                 "[Natural Wonder] Fuji (Sukritact)"),
    ("LOC_28e0e437f32443e9b6b14d344ce0f98e",            "LOC_MTL_NW_SUKRITACTS_TONLE_SAP_NAME"), -- Sukritact's Tonlé Sap
    ("LOC_MTL_NW_SUKRITACTS_TONLE_SAP_NAME",            "[Natural Wonder] Tonlé Sap (Sukritact)"),
    ("LOC_cac375a0c4654ccf9d8c735c3c968560",            "LOC_MTL_NW_SUKRITACTS_GREAT_BLUE_HOLE_NAME"), -- Sukritact's Great Blue Hole
    ("LOC_MTL_NW_SUKRITACTS_GREAT_BLUE_HOLE_NAME",      "[Natural Wonder] Great Blue Hole (Sukritact)"),
    ("LOC_de67eeb962534b5f99e47e74bcd7d549",            "LOC_MTL_NW_SUKRITACTS_GRAND_CANYON_NAME"), -- Sukritact's Grand Canyon
    ("LOC_MTL_NW_SUKRITACTS_GRAND_CANYON_NAME",         "[Natural Wonder] Grand Canyon (Sukritact)"),
    ("LOC_981c503848a644b5af64bf2ebcde63f9",            "LOC_MTL_NW_SUKRITACTS_NGORONGORO_CRATER_NAME"), -- Sukritact's Ngorongoro Crater
    ("LOC_MTL_NW_SUKRITACTS_NGORONGORO_CRATER_NAME",    "[Natural Wonder] Ngorongoro Crater (Sukritact)");

-- 自然奇观
insert or replace into LocalizedText
    (Language,      Tag,                                                Text)
values
    ("zh_Hans_CN",  "LOC_MTL_NW_TERRA_MIRABILIS_NAME",                  "[自然奇观合集]奇异之地"),
    ("zh_Hans_CN",  "LOC_MTL_NW_SUKRITACTS_FUJI_NAME",                  "[自然奇观]富士山 (Sukritact)"),
    ("zh_Hans_CN",  "LOC_MTL_NW_SUKRITACTS_TONLE_SAP_NAME",             "[自然奇观]洞里萨湖 (Sukritact)"),
    ("zh_Hans_CN",  "LOC_MTL_NW_SUKRITACTS_GREAT_BLUE_HOLE_NAME",       "[自然奇观]大蓝洞 (Sukritact)"),
    ("zh_Hans_CN",  "LOC_MTL_NW_SUKRITACTS_GRAND_CANYON_NAME",          "[自然奇观]亚利桑那大峡谷 (Sukritact)"),
    ("zh_Hans_CN",  "LOC_MTL_NW_SUKRITACTS_NGORONGORO_CRATER_NAME",     "[自然奇观]恩戈罗恩戈罗火山口 (Sukritact)");

------------------------------------------------------------------------------------------------------
-- JNR District Expansion
insert or replace into EnglishText
    (Tag,                                                   Text)
values
    ("LOC_cf1615ca15434c679da91d518f31c0e7",                "LOC_MTL_UC_DISTRICT_EXPANSION_GOVERNMENT_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_GOVERNMENT_NAME",       "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_GOVERNMENT] Government"),
    ("LOC_93e0f97aa9cc494d8560b3b6b9aabdf2",                "LOC_MTL_UC_DISTRICT_EXPANSION_ENTERTAINMENT_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_ENTERTAINMENT_NAME",    "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_ENTERTAINMENT] Entertainment"),
    ("LOC_39c78c558c394f0db4c80097f6bcd87a",                "LOC_MTL_UC_DISTRICT_EXPANSION_INDUSTRY_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_INDUSTRY_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_INDUSTRIAL_ZONE] Industry"),
    ("LOC_1373373af34d4041a0f849e2004e19a1",                "LOC_MTL_UC_DISTRICT_EXPANSION_AQUEDUCT_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_AQUEDUCT_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_AQUEDUCT] Aqueduct"),
    ("LOC_8be477ae8642462dbcad768fda353127",                "LOC_MTL_UC_DISTRICT_EXPANSION_WORSHIP_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_WORSHIP_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_RELIGION] Worship"),
    ("LOC_1047a26938a84ceeb70aa7681015eed7",                "LOC_MTL_UC_DISTRICT_EXPANSION_SPIRITUALITY_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_SPIRITUALITY_NAME",     "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_HOLYSITE] Spirituality"),
    ("LOC_ccd2f70b2257400fbc599e1919f37473",                "LOC_MTL_UC_DISTRICT_EXPANSION_THEATER_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_THEATER_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_THEATER] Theater"),
    ("LOC_7d1c74a22f3e452c8d3e16b6e383ab9d",                "LOC_MTL_UC_DISTRICT_EXPANSION_CAMPUS_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_CAMPUS_NAME",           "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_CAMPUS] Campus"),
    ("LOC_52c17bf1d63042c8a2d6f20d8e019993",                "LOC_MTL_UC_DISTRICT_EXPANSION_COMMERCE_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_COMMERCE_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_COMMERCIAL_HUB] Commerce"),
    ("LOC_72d77fd97d34453997d9f5c23de67814",                "LOC_MTL_UC_DISTRICT_EXPANSION_MILITARY_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_MILITARY_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_ENCAMPMENT] Military"),
    ("LOC_cc42ab931a064095b0a464ca2aab241a",                "LOC_MTL_UC_DISTRICT_EXPANSION_SUBURBS_NAME"),
    ("LOC_MTL_UC_DISTRICT_EXPANSION_SUBURBS_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - District Expansion: [ICON_DISTRICT_NEIGHBORHOOD] Suburbs"),
    ("LOC_48a2ffab93d44ec4bc92a84dc3e063b9",                "LOC_MTL_UC_BONUS_RESOURCE_IMPROVEMENTS_NAME"),
    ("LOC_MTL_UC_BONUS_RESOURCE_IMPROVEMENTS_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR] - Bonus Resource Improvements");

-- 区域扩展
insert or replace into LocalizedText
    (Language,      Tag,                                                    Text)
values
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_GOVERNMENT_NAME",       "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_GOVERNMENT] 市政广场"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_ENTERTAINMENT_NAME",    "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_ENTERTAINMENT] 娱乐"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_INDUSTRY_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_INDUSTRIAL_ZONE] 工业"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_AQUEDUCT_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_AQUEDUCT] 水渠"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_WORSHIP_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_RELIGION] 祭祀建筑"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_SPIRITUALITY_NAME",     "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_HOLYSITE] 圣地"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_THEATER_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_THEATER] 剧院"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_CAMPUS_NAME",           "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_CAMPUS] 学院"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_COMMERCE_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_COMMERCIAL_HUB] 商业"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_MILITARY_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_ENCAMPMENT] 军事"),
    ("zh_Hans_CN",  "LOC_MTL_UC_DISTRICT_EXPANSION_SUBURBS_NAME",          "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]区域扩展: [ICON_DISTRICT_NEIGHBORHOOD] 郊区"),
    ("zh_Hans_CN",  "LOC_MTL_UC_BONUS_RESOURCE_IMPROVEMENTS_NAME",         "[COLOR:ResProductionLabelCS]UC[ENDCOLOR]加成资源改良设施");

-- HD recomended
insert or replace into EnglishText
    (Tag,                                               Text)
values
    ("LOC_d85b5f9b502547d99f70872175bcb17f",            "LOC_MTL_CAPTURE_UNIQUE_IMPROVEMENTS_NAME"),
    ("LOC_MTL_CAPTURE_UNIQUE_IMPROVEMENTS_NAME",        "Capture Unique Improvements"),
    ("LOC_73b1478a73bf49078914b1b5acca388b",            "LOC_MTL_CB_WETLANDS_NAME"),
    ("LOC_MTL_CB_WETLANDS_NAME",                        "[COLOR:ResScienceLabelCS]CB[ENDCOLOR] - Wetlands"),
    ("LOC_664d17a5f3be493a93328e20da1166fa",            "LOC_MTL_CIVITAS_RESOURCES_NAME"),
    ("LOC_MTL_CIVITAS_RESOURCES_NAME",                  "CIVITAS [ICON_GreatProphet] [COLOR_FLOAT_CULTURE]Resources[ENDCOLOR]"),
    ("LOC_78aa4d0b742a4d7abe7da8317d69fb30",            "LOC_MTL_LATIN_AMERICAN_RESOURCES_NAME"),
    ("LOC_MTL_LATIN_AMERICAN_RESOURCES_NAME",           "Latin American [COLOR:ResCultureLabelCS]Resources[ENDCOLOR]"),
    ("LOC_37fdca0b927542359c18c7ec348f930e",            "LOC_MTL_SUKRITACT_RESOURCES_NAME"),
    ("LOC_MTL_SUKRITACT_RESOURCES_NAME",                "Sukritact's Resources"),
    ("LOC_23879c667cbb4320a891ad24026f1b6b",            "LOC_MTL_RESOURCEFUL2_NAME"),
    ("LOC_MTL_RESOURCEFUL2_NAME",                       "Resourceful 2 [NFP Compatible]"),
    ("LOC_01159f417ca0418184cf2f2c912edfdd",            "LOC_MTL_ST_UNIT_EXPANSION_NAME"),
    ("LOC_MTL_ST_UNIT_EXPANSION_NAME",                  "Steel and Thunder: Unit Expansion"),
    ("LOC_a1fe0ce2ca984998a0c92aa1639eb6d0",            "LOC_MTL_ST_UNIQUE_UNITS_NAME"),
    ("LOC_MTL_ST_UNIQUE_UNITS_NAME",                    "Steel and Thunder: Unique Units"),
    ("LOC_a64e1c66ce484d80822547402db353aa",            "LOC_MTL_LEUGI_MONOPOLY_ADJUSTMENTS_NAME"),
    ("LOC_MTL_LEUGI_MONOPOLY_ADJUSTMENTS_NAME",         "Leugi's [COLOR:ResGoldLabelCS]Monopoly++:[ENDCOLOR] Corporation and Product Adjustments"),
    ("LOC_b248a3223e2a4a6a830a6b0d1f3435fc",            "LOC_MTL_LEUGI_MONOPOLY_TYCOONS_INVESTORS_NAME"),
    ("LOC_MTL_LEUGI_MONOPOLY_TYCOONS_INVESTORS_NAME",   "Leugi's [COLOR:ResGoldLabelCS]Monopoly++:[ENDCOLOR] Tycoons and Investors"),
    ("LOC_7d0b57ba6a5c4de0ac10e1e464ac82f6",            "LOC_MTL_CIVITAS_CITY_STATES_NAME"),
    ("LOC_MTL_CIVITAS_CITY_STATES_NAME",                "CIVITAS [ICON_ENVOY] City-States"),
    ("LOC_7ce74c2841ba4453b3d1d30ef8013887",            "LOC_MTL_REMOVABLE_DISTRICTS_NAME"),
    ("LOC_MTL_REMOVABLE_DISTRICTS_NAME",                "[COLOR_FLOAT_SCIENCE]Removable Districts[ENDCOLOR]"),
    ("LOC_63c4a8ac9ada4b2d927a2a99527980e2",            "LOC_MTL_MOVABLE_DISTRICTS_NAME"),
    ("LOC_MTL_MOVABLE_DISTRICTS_NAME",                  "Movable Districts"),
    ("LOC_4922ba4761e14b159281db996b14522d",            "LOC_MTL_SUKRITACT_OCEANS_NAME"),
    ("LOC_MTL_SUKRITACT_OCEANS_NAME",                   "Sukritact's Oceans"),
    ("LOC_7295028490dc424dba044a1d8de2b336",            "LOC_MTL_WATCHTOWER_IMPROVEMENT_NAME"),
    ("LOC_MTL_WATCHTOWER_IMPROVEMENT_NAME",             "[COLOR:ResProductionLabelCS]Watchtower Improvement[ENDCOLOR]");

-- HD推荐mod
insert or replace into LocalizedText
    (Language,      Tag,                                                Text)
values
    ("zh_Hans_CN",  "LOC_MTL_CAPTURE_UNIQUE_IMPROVEMENTS_NAME",        "夺取特色改良"),
    ("zh_Hans_CN",  "LOC_MTL_CB_WETLANDS_NAME",                        "[COLOR:ResScienceLabelCS]CB[ENDCOLOR]湿地系统"),
    ("zh_Hans_CN",  "LOC_MTL_CIVITAS_RESOURCES_NAME",                  "[资源]CIVITAS [ICON_GreatProphet] [COLOR_FLOAT_CULTURE]资源扩展[ENDCOLOR]"),
    ("zh_Hans_CN",  "LOC_MTL_LATIN_AMERICAN_RESOURCES_NAME",           "[资源]拉丁美洲[COLOR:ResCultureLabelCS]资源扩展[ENDCOLOR]"),
    ("zh_Hans_CN",  "LOC_MTL_SUKRITACT_RESOURCES_NAME",                "[资源]Sukritact的资源扩展"),
    ("zh_Hans_CN",  "LOC_MTL_RESOURCEFUL2_NAME",                       "[资源]丰富资源2(兼容新纪元)"),
    ("zh_Hans_CN",  "LOC_MTL_ST_UNIT_EXPANSION_NAME",                  "[钢铁雷霆]单位扩展"),
    ("zh_Hans_CN",  "LOC_MTL_ST_UNIQUE_UNITS_NAME",                    "[钢铁雷霆]特色单位"),
    ("zh_Hans_CN",  "LOC_MTL_LEUGI_MONOPOLY_ADJUSTMENTS_NAME",         "Leugi的[COLOR:ResGoldLabelCS]行业++:[ENDCOLOR] 公司与产品调整"),
    ("zh_Hans_CN",  "LOC_MTL_LEUGI_MONOPOLY_TYCOONS_INVESTORS_NAME",   "Leugi的[COLOR:ResGoldLabelCS]行业++:[ENDCOLOR] 大亨与投资人"),
    ("zh_Hans_CN",  "LOC_MTL_CIVITAS_CITY_STATES_NAME",                "CIVITAS [ICON_ENVOY] 城邦扩展"),
    ("zh_Hans_CN",  "LOC_MTL_REMOVABLE_DISTRICTS_NAME",                "[COLOR_FLOAT_SCIENCE]可移除的区域[ENDCOLOR]"),
    ("zh_Hans_CN",  "LOC_MTL_MOVABLE_DISTRICTS_NAME",                  "区域迁移"),
    ("zh_Hans_CN",  "LOC_MTL_SUKRITACT_OCEANS_NAME",                   "Sukritact的海洋模式"),
    ("zh_Hans_CN",  "LOC_MTL_WATCHTOWER_IMPROVEMENT_NAME",             "[COLOR:ResProductionLabelCS]瞭望塔改良设施[ENDCOLOR]");

-- UI mods
insert or replace into EnglishText
    (Tag,                                                   Text)
values
    -- "Better" series
    ("LOC_6f2888d479dc415fa8fff9d81d7afb53",                "LOC_MTL_BETTER_REPORT_SCREEN_NAME"),
    ("LOC_MTL_BETTER_REPORT_SCREEN_NAME",                   "[UI] Better Report Screen"),
    ("LOC_d1f39cf8d044468db468b03dd491b9b3",                "LOC_MTL_BETTER_CIVILOPEDIA_NAME"),
    ("LOC_MTL_BETTER_CIVILOPEDIA_NAME",                     "[UI] Better Civilopedia"),
    ("LOC_38C7FAFB58EB0C14737792A810E9860B",                "LOC_MTL_BETTER_LOADING_SCREEN_NAME"),
    ("LOC_MTL_BETTER_LOADING_SCREEN_NAME",                  "[UI] Better Loading Screen"),
    ("LOC_fbb7b86a9ac94a8e94399ded6aceda0e",                "LOC_MTL_BETTER_DEAL_WINDOW_NAME"),
    ("LOC_MTL_BETTER_DEAL_WINDOW_NAME",                     "[UI] Better Deal Window"),
    ("LOC_74D4FDCC14FE5F52767603B229E7845D",                "LOC_MTL_BETTER_WORLD_RANKINGS_NAME"),
    ("LOC_MTL_BETTER_WORLD_RANKINGS_NAME",                  "[UI] Better World Rankings"),
    ("LOC_67B4DBCB82AD3F90159543C677C1301E",                "LOC_MTL_BETTER_RELIGION_WINDOW_NAME"),
    ("LOC_MTL_BETTER_RELIGION_WINDOW_NAME",                 "[UI] Better Religion Window"),
    ("LOC_ebdf2824352e49c390c1743a89180da8",                "LOC_MTL_BETTER_ESPIONAGE_SCREEN_NAME"),
    ("LOC_MTL_BETTER_ESPIONAGE_SCREEN_NAME",                "[UI] Better Espionage Screen"),
    ("LOC_8d4fa23aef43440c84222bec11f8f5d7",                "LOC_MTL_BETTER_TRADE_SCREEN_NAME"),
    ("LOC_MTL_BETTER_TRADE_SCREEN_NAME",                    "[UI] Better Trade Screen"),
    ("LOC_13E8BCDF98EC4C03364172D519B0047C",                "LOC_MTL_BETTER_CITY_STATES_NAME"),
    ("LOC_MTL_BETTER_CITY_STATES_NAME",                     "[UI] Better City States"),
    -- 
    ('LOC_5aceed0386394a818cbf03f54d543502',                "LOC_MTL_QUICK_DEALS_NAME"),
    ('LOC_MTL_QUICK_DEALS_NAME',                            "[UI] Quick Deals"),
    ("LOC_4ecfcc6254714435b295590df213e8d8",                "LOC_MTL_DETAILED_MAP_TACKS_NAME"),
    ("LOC_MTL_DETAILED_MAP_TACKS_NAME",                     "[UI] Detailed Map Tacks"),
    ("LOC_382a187fc8ba4094a6a70d5315661f33",                "LOC_MTL_EXTENDED_POLICY_CARDS_NAME"),
    ("LOC_MTL_EXTENDED_POLICY_CARDS_NAME",                  "[UI] Extended Policy Cards"),
    ("LOC_2778f75d9c724919a081620f6482f5d6",                "LOC_MTL_POLICY_CHANGE_REMINDER_NAME"),
    ("LOC_MTL_POLICY_CHANGE_REMINDER_NAME",                 "[UI] Policy Change Reminder"),
    ("LOC_382a187fc8ba4094a6a70d5315661f32",                "LOC_MTL_EXTENDED_DIPLOMACY_RIBBON_NAME"),
    ("LOC_MTL_EXTENDED_DIPLOMACY_RIBBON_NAME",              "[UI] Extended Diplomacy Ribbon"),
    ("LOC_23e2436b2f6e4ec4bee9e27c2005fac1",                "LOC_MTL_RADIAL_MEASURING_TOOL_NAME"),
    ("LOC_MTL_RADIAL_MEASURING_TOOL_NAME",                  "[UI] Radial Measuring Tool"),
    ("LOC_bcdbbbea984f474cb9216ea0be143600",                "LOC_MTL_GREAT_WORKS_VIEWER_NAME"),
    ("LOC_MTL_GREAT_WORKS_VIEWER_NAME",                     "[UI] Great Works Viewer"),
    ("LOC_81423aeb17fa4b7bab730a25bfcb0e8c",                "LOC_MTL_MAP_SEARCH_EXTENSION_NAME"),
    ("LOC_MTL_MAP_SEARCH_EXTENSION_NAME",                   "[UI] Map Search Extension"),
    ("LOC_e83d69777baf4e4fabd22a9f59a537ad",                "LOC_MTL_CUSTOM_NOTIFICATIONS_NAME"),
    ("LOC_MTL_CUSTOM_NOTIFICATIONS_NAME",                   "[UI] Custom Notifications"),
    ("LOC_d3375ed7abb24480be4c33e61161b6d3",                "LOC_MTL_SUKRITACT_GLOBAL_RELATIONS_PANEL_NAME"),
    ("LOC_MTL_SUKRITACT_GLOBAL_RELATIONS_PANEL_NAME",       "[UI] Sukritact's Global Relations Panel"),
    ("LOC_6f4fb9f0362d4ac5b8f419095add8af2",                "LOC_MTL_MIGUEL_SUPERTIMER_NAME"),
    ("LOC_MTL_MIGUEL_SUPERTIMER_NAME",                      "[UI] Miguel's SuperTimer"),
    ("LOC_6a18ae19df934322a3d533c5a5087b36",                "LOC_MTL_REAL_GREAT_PEOPLE_NAME"),
    ("LOC_MTL_REAL_GREAT_PEOPLE_NAME",                      "[UI] Real Great People"),
    ("LOC_805cc499c5344e0abdce32fb3c53ba38",                "LOC_MTL_SUKRITACT_SIMPLE_UI_ADJUSTMENTS_NAME"),
    ("LOC_MTL_SUKRITACT_SIMPLE_UI_ADJUSTMENTS_NAME",        "[UI] Sukritact's Simple UI Adjustments"),
    ("LOC_35f33319ad934d6bbf27406fac382d06",                "LOC_MTL_MORE_LENSES_NAME"),
    ("LOC_MTL_MORE_LENSES_NAME",                            "[UI] More Lenses"),
    ("LOC_9ec7d8429ca34c1b893f2672dcaca71f",                "LOC_MTL_GREATEST_CITIES_NAME"),
    ("LOC_MTL_GREATEST_CITIES_NAME",                        "[UI]Greatest Cities"),
    ("LOC_6745dafcd6334781a28ad3fa5ada0f46",                "LOC_MTL_GREAT_PERSON_RECRUITED_NOTIFICATION_NAME"),
    ("LOC_MTL_GREAT_PERSON_RECRUITED_NOTIFICATION_NAME",    "[UI] Great Person Recruited Notification"),
    ("LOC_da4f400053a04005bb255354f781bef6",                "LOC_MTL_ENDGAME_MAP_REPLAY_NAME"),
    ("LOC_MTL_ENDGAME_MAP_REPLAY_NAME",                     "[UI] Endgame Map Replay"),
    ("LOC_185e05a2c6ac4e09b2572bdb1f3714cd",                "LOC_MTL_AUTO_RECORD_GOODY_HUTS_NAME"),
    ("LOC_MTL_AUTO_RECORD_GOODY_HUTS_NAME",                 "[UI] Auto Record Goody Huts"),
        -- 
    ("LOC_389034b7460b40c1be0ca3240ebeff7b",                "LOC_MTL_ENVOY_QUEST_LIST_NAME"),
    ("LOC_MTL_ENVOY_QUEST_LIST_NAME",                       "[UI] Envoy Quest List"),
    ("LOC_60092bddce394319aef6baea505c7c45",                "LOC_MTL_SUKRITACT_CIV_SELECTION_SCREEN_NAME"),
    ("LOC_MTL_SUKRITACT_CIV_SELECTION_SCREEN_NAME",         "[UI] Sukritact's Civ Selection Screen"),
    ("LOC_86c7a76de7ea46afb20e546b98f0ac19",                "LOC_MTL_RIHLA_GLOBAL_RANKINGS_NAME"),
    ("LOC_MTL_RIHLA_GLOBAL_RANKINGS_NAME",                  "[UI] Rihla - Global Rankings"),
    ("LOC_61fc740b3a394d04b5788b41068c2fa2",                "LOC_MTL_EVEN_MORE_REPORTS_NAME"),
    ("LOC_MTL_EVEN_MORE_REPORTS_NAME",                      "[UI] Even More Reports"),
    ("LOC_508fe56f9ac24212b673b55f427c472e",                "LOC_MTL_CIV_V_DEMOGRAPHICS_PANEL_NAME"), -- CIVIG
    ("LOC_MTL_CIV_V_DEMOGRAPHICS_PANEL_NAME",               "[UI] Civ V Demographics Panel in Civ 6"),
        -- 
    ("LOC_dc3dfc0de4e9450c871699c4e748d5f2",                "LOC_MTL_WHAT_DID_I_PROMISE_NAME"),
    ("LOC_MTL_WHAT_DID_I_PROMISE_NAME",                     "What Did I Promise?"),
    ("LOC_a37c6eda1c444c61b66fc5048af62b88",                "LOC_MTL_BUILDER_MILITARY_ENGINEER_LAG_FIX_NAME"),
    ("LOC_MTL_BUILDER_MILITARY_ENGINEER_LAG_FIX_NAME",      "Builder / Military Engineer Lag Fix"),
    ("LOC_577c52849691458ca861db802265a325",                "LOC_MTL_ENHANCED_CAMERA_NAME"),
    ("LOC_MTL_ENHANCED_CAMERA_NAME",                        "Enhanced Camera"),
    ("LOC_3fe34c3b915c47769cb8f42ab5b92f80",                "LOC_MTL_QUICK_START_NAME"),
    ("LOC_MTL_QUICK_START_NAME",                            "Quick Start"),
    -- Arts
    ("LOC_837100985cae4c9fa1e48dc652a537fe",                "LOC_MTL_LEUGI_UNIQUE_DISTRICT_ICONS_NAME"),
    ("LOC_MTL_LEUGI_UNIQUE_DISTRICT_ICONS_NAME",            "[Art] Leugi's [COLOR:ResCultureLabelCS]Unique District Icons[ENDCOLOR]"),
    ("LOC_a01ede98fa74422ebdcf96179cfe125b",                "LOC_MTL_COLORIZED_HISTORIC_MOMENTS_NAME"),
    ("LOC_MTL_COLORIZED_HISTORIC_MOMENTS_NAME",             "[Art] Colorized Historic Moments"),
    ("LOC_f00f068ec47b4fcb974d7e86ae0cae46",                "LOC_MTL_BETTER_CIVILIZATION_ICONS_LITE_NAME"),
    ("LOC_MTL_BETTER_CIVILIZATION_ICONS_LITE_NAME",         "[Art] Better Civilization Icons Lite"),
    ("LOC_b4c4adadc2544c04be39d5e828e34d10",                "LOC_MTL_TSUNAMI_WAVES_LITE_NAME"),
    ("LOC_MTL_TSUNAMI_WAVES_LITE_NAME",                     "[Art] Tsunami Waves Lite"),
    ("LOC_511c8fce8dd44393994103925e105422",                "LOC_MTL_CITY_SPRAWL_GRAPHICS_NAME"),
    ("LOC_MTL_CITY_SPRAWL_GRAPHICS_NAME",                   "[Art] City Sprawl Graphics"),
    ("LOC_e74ef4d9d12a4d7897aed9c13e765a59",                "LOC_MTL_PRISMATIC_COLOR_AND_JERSEY_OVERHAUL_NAME"),
    ("LOC_MTL_PRISMATIC_COLOR_AND_JERSEY_OVERHAUL_NAME",    "[Art] Prismatic - Color and Jersey Overhaul"),
    ("LOC_9735472b05d144278fc2b44ff2c39088",                "LOC_MTL_HILLIER_HILLS_COLDER_TUNDRA_EDITION_NAME"),
    ("LOC_MTL_HILLIER_HILLS_COLDER_TUNDRA_EDITION_NAME",    "[Art] Hillier Hills (Colder Tundra Edition)"),
    ("LOC_7324453430444ffbb82cf06b93240ae3",                "LOC_MTL_PRETTIER_LAKES_NAME"),
    ("LOC_MTL_PRETTIER_LAKES_NAME",                         "[Art] Prettier Lakes"),
    ("LOC_ea58c92e1a7341eba36c8158cd759f82",                "LOC_MTL_GREEN_MOUNTAINS_NAME"),
    ("LOC_MTL_GREEN_MOUNTAINS_NAME",                        "[Art] Green Mountains"),
    ("LOC_30c9d85a22154126ac9a3ccc4171dc10",                "LOC_MTL_ORANGE_DESERT_NAME"),
    ("LOC_MTL_ORANGE_DESERT_NAME",                          "[Art] Orange Desert"),
    ("LOC_c099721cf17130fb8e29c5f0b5d4f941",                "LOC_MTL_STYLISH_CIVILIZATION_COLORS_NAME"),
    ("LOC_MTL_STYLISH_CIVILIZATION_COLORS_NAME",            "[Art] Stylish Civilization Colors"),
    ("LOC_9ad06b3afd974652b844577e7d6e5136",                "LOC_MTL_SEOWON_DISTRICT_UNQIUE_MODELS_NAME"),
    ("LOC_MTL_SEOWON_DISTRICT_UNQIUE_MODELS_NAME",          "[Art] SEOWON DISTRICT: Unqiue Models"),
    ("LOC_1017b788f72947afb4edec9bb74dd02c",                "LOC_MTL_THANH_DISTRICT_UNIQUE_MODELS_NAME"),
    ("LOC_MTL_THANH_DISTRICT_UNIQUE_MODELS_NAME",           "[Art] THANH DISTRICT: Unique Models"),
    ("LOC_1537c0eb67704f99858446687381b780",                "LOC_MTL_THRONES_AND_PALACES_NAME"),
    ("LOC_MTL_THRONES_AND_PALACES_NAME",                    "[Art] Thrones and Palaces"),
    ("LOC_2e6d109366894dd5a47a9539bc3f8a29",                "LOC_MTL_TOMATEKH_HISTORICAL_RELIGIONS_NAME"),
    ("LOC_MTL_TOMATEKH_HISTORICAL_RELIGIONS_NAME",          "[Art] Tomatekh's Historical Religions"),
    ("LOC_aa42d2060aa14bbf9ac027d338e2d91e",                "LOC_MTL_REAL_STYLISH_GREAT_PEOPLE_NAME"),
    ("LOC_MTL_REAL_STYLISH_GREAT_PEOPLE_NAME",              "[Art] Real [COLOR_GREEN]*Stylish*[ENDCOLOR] Great People"),
    ("LOC_d0fc03f937c14262a90ba6fd3573397d",                "LOC_MTL_GREAT_PEOPLE_PORTRAITS_FOR_MONOPOLY_NAME"),
    ("LOC_MTL_GREAT_PEOPLE_PORTRAITS_FOR_MONOPOLY_NAME",    "[Art] Great People Portraits for Leugi's Monopoly expansion"),
    -- Logs
    ("LOC_736a13ed465a4722b759873058c03763",                "LOC_MTL_NOTIFICATION_LOG_NAME"),
    ("LOC_MTL_NOTIFICATION_LOG_NAME",                       "Notification Log"),
    ("LOC_05e672a24e144d0ca804dda6d66b7b82",                "LOC_MTL_SIMPLIFIED_COMBAT_REPORTS_NAME"),
    ("LOC_MTL_SIMPLIFIED_COMBAT_REPORTS_NAME",              "Simplified Combat Reports"),
    ("LOC_9e9923e568424e7d97e7c9a56a85cf03",                "LOC_MTL_SIMPLIFIED_GOSSIP_NAME"),
    ("LOC_MTL_SIMPLIFIED_GOSSIP_NAME",                      "Simplified Gossip");
    -- Others
    -- ("LOC_fba4a93506f0414b973d5ffcd80c6d0e",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Happiness and Growth Indicators"),
    -- ("LOC_d86c4fedd391472baa36022e9e00574e",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Z Unit Selection History Navigation"),
    -- ("LOC_3057e5a2a48de626331a181c4126875b",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Better Unit Flags"),
    -- ("LOC_54bd4d3de8c44771860730e77d7a3f73",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Civilopedia Cities");

-- 界面mod
insert or replace into LocalizedText
    (Language,      Tag,                                                    Text)
values
    ("zh_Hans_CN",  "LOC_MTL_BETTER_REPORT_SCREEN_NAME",                   "[UI]更好的报告界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_CIVILOPEDIA_NAME",                     "[UI]更好的文明百科"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_LOADING_SCREEN_NAME",                  "[UI]更好的加载界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_DEAL_WINDOW_NAME",                     "[UI]更好的交易界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_WORLD_RANKINGS_NAME",                  "[UI]更好的世界排名"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_RELIGION_WINDOW_NAME",                 "[UI]更好的宗教界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_ESPIONAGE_SCREEN_NAME",                "[UI]更好的间谍界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_TRADE_SCREEN_NAME",                    "[UI]更好的贸易路线界面"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_CITY_STATES_NAME",                     "[UI]更好的城邦界面"),
    -- 
    ("zh_Hans_CN",  "LOC_MTL_QUICK_DEALS_NAME",                            "[UI]快速交易"),
    ("zh_Hans_CN",  "LOC_MTL_DETAILED_MAP_TACKS_NAME",                     "[UI]详细的地图钉(收益显示)"),
    ("zh_Hans_CN",  "LOC_MTL_EXTENDED_POLICY_CARDS_NAME",                  "[UI]扩展政策卡(收益显示)"),
    ("zh_Hans_CN",  "LOC_MTL_POLICY_CHANGE_REMINDER_NAME",                 "[UI]更换政策卡提醒"),
    ("zh_Hans_CN",  "LOC_MTL_EXTENDED_DIPLOMACY_RIBBON_NAME",              "[UI]领袖头像外交条扩展"),
    ("zh_Hans_CN",  "LOC_MTL_RADIAL_MEASURING_TOOL_NAME",                  "[UI]半径测量工具(规划辐射辅助工具)"),
    ("zh_Hans_CN",  "LOC_MTL_GREAT_WORKS_VIEWER_NAME",                     "[UI]巨作查看器"),
    ("zh_Hans_CN",  "LOC_MTL_MAP_SEARCH_EXTENSION_NAME",                   "[UI]地图搜索扩展"),
    ("zh_Hans_CN",  "LOC_MTL_CUSTOM_NOTIFICATIONS_NAME",                   "[UI]自定义通知"),
    ("zh_Hans_CN",  "LOC_MTL_SUKRITACT_GLOBAL_RELATIONS_PANEL_NAME",       "[UI]Sukritact的全球关系面板"),
    ("zh_Hans_CN",  "LOC_MTL_MIGUEL_SUPERTIMER_NAME",                      "[UI]Miguel的超级计时器"),
    ("zh_Hans_CN",  "LOC_MTL_REAL_GREAT_PEOPLE_NAME",                      "[UI]真正的伟人"),
    ("zh_Hans_CN",  "LOC_MTL_SUKRITACT_SIMPLE_UI_ADJUSTMENTS_NAME",        "[UI]Sukritact的简明UI调整"),
    ("zh_Hans_CN",  "LOC_MTL_MORE_LENSES_NAME",                            "[UI]更多滤镜"),
    ("zh_Hans_CN",  "LOC_MTL_GREATEST_CITIES_NAME",                        "[UI]最伟大的城市"),
    ("zh_Hans_CN",  "LOC_MTL_GREAT_PERSON_RECRUITED_NOTIFICATION_NAME",    "[UI]伟人招募提示"),
    ("zh_Hans_CN",  "LOC_MTL_ENDGAME_MAP_REPLAY_NAME",                     "[UI]游戏结束时的地图回放"),
    ("zh_Hans_CN",  "LOC_MTL_AUTO_RECORD_GOODY_HUTS_NAME",                 "[UI]村子记录器"),
    ("zh_Hans_CN",  "LOC_MTL_ENVOY_QUEST_LIST_NAME",                       "[UI]城邦使者任务列表"),
    ("zh_Hans_CN",  "LOC_MTL_SUKRITACT_CIV_SELECTION_SCREEN_NAME",         "[UI]Sukritact的文明选择界面"),
    ("zh_Hans_CN",  "LOC_MTL_RIHLA_GLOBAL_RANKINGS_NAME",                  "[UI]Rihla的全球排名"),
    ("zh_Hans_CN",  "LOC_MTL_EVEN_MORE_REPORTS_NAME",                      "[UI]更多的报告"),
    ("zh_Hans_CN",  "LOC_MTL_CIV_V_DEMOGRAPHICS_PANEL_NAME",               "[UI]文明5的统计数据表"),
    ("zh_Hans_CN",  "LOC_MTL_WHAT_DID_I_PROMISE_NAME",                     "我做过什么承诺？"),
    ("zh_Hans_CN",  "LOC_MTL_BUILDER_MILITARY_ENGINEER_LAG_FIX_NAME",      "工人和军工卡顿修复"),
    ("zh_Hans_CN",  "LOC_MTL_ENHANCED_CAMERA_NAME",                        "缩放范围更大的相机"),
    ("zh_Hans_CN",  "LOC_MTL_QUICK_START_NAME",                            "快速启动"),
    ("zh_Hans_CN",  "LOC_MTL_LEUGI_UNIQUE_DISTRICT_ICONS_NAME",            "[Art]Leugi的[COLOR:ResCultureLabelCS]特色区域图标[ENDCOLOR]"),
    ("zh_Hans_CN",  "LOC_MTL_COLORIZED_HISTORIC_MOMENTS_NAME",             "[Art]彩色历史时刻"),
    ("zh_Hans_CN",  "LOC_MTL_BETTER_CIVILIZATION_ICONS_LITE_NAME",         "[Art]更好的文明图标(轻量版)"),
    ("zh_Hans_CN",  "LOC_MTL_TSUNAMI_WAVES_LITE_NAME",                     "[Art]海啸浪潮(轻量版)"),
    ("zh_Hans_CN",  "LOC_MTL_CITY_SPRAWL_GRAPHICS_NAME",                   "[Art]城市蔓延图像"),
    ("zh_Hans_CN",  "LOC_MTL_PRISMATIC_COLOR_AND_JERSEY_OVERHAUL_NAME",    "[Art]棱镜 - 颜色和领袖配色大修"),
    ("zh_Hans_CN",  "LOC_MTL_HILLIER_HILLS_COLDER_TUNDRA_EDITION_NAME",    "[Art]更起伏的丘陵(更冷的冻土版本)"),
    ("zh_Hans_CN",  "LOC_MTL_PRETTIER_LAKES_NAME",                         "[Art]更漂亮的湖泊"),
    ("zh_Hans_CN",  "LOC_MTL_GREEN_MOUNTAINS_NAME",                        "[Art]绿色山脉"),
    ("zh_Hans_CN",  "LOC_MTL_ORANGE_DESERT_NAME",                          "[Art]橙色沙漠"),
    ("zh_Hans_CN",  "LOC_MTL_STYLISH_CIVILIZATION_COLORS_NAME",            "[Art]个性化的文明配色"),
    ("zh_Hans_CN",  "LOC_MTL_SEOWON_DISTRICT_UNQIUE_MODELS_NAME",          "[Art]书院：特色模型"),
    ("zh_Hans_CN",  "LOC_MTL_THANH_DISTRICT_UNIQUE_MODELS_NAME",           "[Art]城池：特色模型"),
    ("zh_Hans_CN",  "LOC_MTL_THRONES_AND_PALACES_NAME",                    "[Art]王座厅与宫殿"),
    ("zh_Hans_CN",  "LOC_MTL_TOMATEKH_HISTORICAL_RELIGIONS_NAME",          "[Art]Tomatekh的历史上的宗教"),
    ("zh_Hans_CN",  "LOC_MTL_REAL_STYLISH_GREAT_PEOPLE_NAME",              "[Art]真正的[COLOR_GREEN]*个性化的*[ENDCOLOR]伟人"),
    ("zh_Hans_CN",  "LOC_MTL_GREAT_PEOPLE_PORTRAITS_FOR_MONOPOLY_NAME",    "[Art]Leugi行业扩展的伟人肖像"),
    ("zh_Hans_CN",  "LOC_MTL_NOTIFICATION_LOG_NAME",                       "[UI]通知日志"),
    ("zh_Hans_CN",  "LOC_MTL_SIMPLIFIED_COMBAT_REPORTS_NAME",              "简化的战斗报告"),
    ("zh_Hans_CN",  "LOC_MTL_SIMPLIFIED_GOSSIP_NAME",                      "简化的小道消息");

------------------------------------------------------------------------------------------------------
-- Misc
insert or replace into EnglishText
    (Tag,                                                   Text)
values
    -- Large projects
    ("LOC_16c2195a13af4032920c8de1d6858c6f",                "LOC_MTL_PROJECT_METROPOLIS_NAME"),
    ("LOC_MTL_PROJECT_METROPOLIS_NAME",                     "Project Metropolis - A Civilization 6 District & Building Extension Mod"),
    ("LOC_95b955fc2dd141c5989e0265d98a28bd",                "LOC_MTL_CITY_LIGHTS_NAME"),
    ("LOC_MTL_CITY_LIGHTS_NAME",                            "CIVILIZATION VI: [COLOR:ResGoldLabelCS]CITY LIGHTS[ENDCOLOR]"),
    ("LOC_8445693ae82d44efb4df499727e5f1bf",                "LOC_MTL_CITY_LIGHTS_CHINESE_TRANSLATION_NAME"),
    ("LOC_MTL_CITY_LIGHTS_CHINESE_TRANSLATION_NAME",        "CITY LIGHTS - Chinese Translation"),
--     ("LOC_644fa20f06864195b71a68ff3392daa7",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Civilizations Expanded"),
--     ("LOC_650ff78247b44b4693fb00bef8da8b8e",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "JFDLC: [COLOR_FLOAT_GOLD]Rule with Faith[ENDCOLOR]"),
    -- Setup
    -- ("LOC_05eb2603db5a4cf5ae5f50c40cf2ff0f",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Take your Time Ultimate - Slower Research Trees"),
    ("LOC_d2248d973a0347afb19df1aea499995b",                "LOC_MTL_CONFIGURE_MAP_SIZE_NAME"),
    ("LOC_MTL_CONFIGURE_MAP_SIZE_NAME",                     "Configure Map Size"),
    -- ("LOC_a3a3f7cbc12046cd9769b407fb0bf782",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Larger Map Sizes"),
    ("LOC_84f74b4e59824e358579831d98fd226b",                "LOC_MTL_CONFIGURE_MINIMAL_CITY_DISTANCE_NAME"),
    ("LOC_MTL_CONFIGURE_MINIMAL_CITY_DISTANCE_NAME",        "[COLOR:ResGoldLabelCS]Configure Minimal City Distance[ENDCOLOR]");
    -- ("LOC_bf6acd3869f7405cb26f2d4f19ca42c5",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Customization VI"),
    -- ("LOC_68d5274ee82b4d9e9c522b1dfc7429e3",                "LOC_MTL_ZEGANGANIS_REAL_ALLIES_NAME"),
    -- ("LOC_MTL_ZEGANGANIS_REAL_ALLIES_NAME",                 "[COLOR:DiplomaticLabelCS]Zegangani's: Real Allies[ENDCOLOR]"),
--     -- Cheat
--     ("LOC_6b9a23f0cc694a8a93c9aaf5868d588a",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Cheat Menu For [COLOR_Civ6Yellow]Units[ENDCOLOR]"),
--     ("LOC_b8fb5dd4d2da4a7196c0858913f9c610",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Cheat Map Editor"),
--     -- Misc ()
--     ("LOC_58ecce8ad3df430ab135280908153662",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "More Maritime: Seaside Sectors"),
--     ("LOC_56382b3605be46a3831d06df8e48c12a",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "No Trait Challenge: Player Leading Normal Civ"),
--     ("LOC_cbd1ac40a90741fa93d344855742170a",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Mod Version Checker"),
--     ("LOC_fda41661187f407995469c88b6de0b1d",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Aircraft Carriers Perfected"),
--     ("LOC_1b4953d4423c11e9b210d663bd873d93",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Gift It To Me"),
--     ("LOC_95f89921a4be4cce841da6a67b48a0f8",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "[COLOR:ResScienceLabelCS]CB[ENDCOLOR] - Renewable Energy Complexity"),
--     ("LOC_5b24d36675224a6b806ab5869ef2377b",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
--     ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "UC - Satellites");
    -- Others
    -- ("LOC_8103feb63844455dbf73d169cda9ad9d",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Extended Techtree"),
    -- ("LOC_960c7ce4c96143c890bf282eb7b260ea",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Truly Abundant Resources"),
    -- ("LOC_de9dd0295bc84f7cb6f06ab89210245e",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Dynamic Diplomacy (Friendship Bonuses Version)"),
    -- ("LOC_4e12695f0ae840c49230aa605c284b64",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Alliances Expanded"),
    -- ("LOC_3abeb412605f4e928f63bd88e803780c",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "A Mountain [COLOR_FLOAT_PRODUCTION]Is Fine Too [ICON_GreatWork_Landscape]"),
    -- ("LOC_3ea3d41074454eb599756fbe948154d6",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "First to Circumnagivate"),
    -- ("LOC_fdffc98a859149d7f153f54828d9db60",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Nere's No normal Camps in barb mode"),
    -- ("LOC_ac22067c44f84bf0bbe0fa75c3c1dd76",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Historicity++"),
    -- ("LOC_a974ac99efbf4f47bc1102e5e0645089",                "LOC_MTL_456789abcdefghijklmnopq_NAME"),
    -- ("LOC_MTL_456789abcdefghijklmnopq_NAME",                "Hutatsuiwa - Tanuki Empire");

-- Misc 杂项
insert or replace into LocalizedText
    (Language,      Tag,                                                    Text)
values
    ("zh_Hans_CN",  "LOC_MTL_PROJECT_METROPOLIS_NAME",                      "大都会 - 文明6建筑与区域扩展模组"),
    ("zh_Hans_CN",  "LOC_MTL_CITY_LIGHTS_NAME",                             "城市之光"),
    ("zh_Hans_CN",  "LOC_MTL_CITY_LIGHTS_CHINESE_TRANSLATION_NAME",         "城市之光——汉化"),
    ("zh_Hans_CN",  "LOC_MTL_CONFIGURE_MAP_SIZE_NAME",                      "自定义地图大小"),
    ("zh_Hans_CN",  "LOC_MTL_CONFIGURE_MINIMAL_CITY_DISTANCE_NAME",         "自定义城市最小间距"),
    ("zh_Hans_CN",  "LOC_MPH_TITLE",                                        "联机助手");

------------------------------------------------------------------------------------------------------
-- insert or replace into EnglishText
--     (Tag,                                       Text)
-- values
--     -- Misc
--     ('LOC_18e2afaf0db048119acb6f08723efe13',    'LOC_MTL_INFINITY_LIFESPAN_NAME'),
--     ('LOC_7f08e350aac242428ffc919a704ecc99',    'LOC_MTL_L4D_ZOMBIE_NAME'),
--     ('LOC_093f382d39fb4871aa8479fdfc35c7b6',    'LOC_MTL_VEGETATION_VARIETY_NAME'),
--     ('LOC_39da9e0fc9ed46e69aa9842223b5da60',    'LOC_MTL_BETTER_HILL_GRAPHICS_NAME'),
--     ('LOC_be8ec8445b7d4245a35cb9a7227c3538',    'LOC_MTL_RAUBAK_BLACK_MARKET_NAME'),
--     ('LOC_c7da8b40a71342af9f5829dd38a842ca',    'LOC_BETTER_TRADE_SCREEN_FIX_NAME'),

--     ('zh_Hans_CN',  'LOC_MTL_GIFT_IT_TO_ME_NAME',                   '赠送单位'),
--     ('zh_Hans_CN',  'LOC_MTL_ZEGANGANIS_REAL_ALLIES_NAME',          '盟友不攻击盟友宗主国城邦'),
--     ('zh_Hans_CN',  'LOC_MTL_INFINITY_LIFESPAN_NAME',               '英雄无限寿命'),
--     ('zh_Hans_CN',  'LOC_MTL_L4D_ZOMBIE_NAME',                      '僵尸'),
--      ('zh_Hans_CN', 'LOC_MTL_VEGETATION_VARIETY_NAME',              '[COLOR:ResScienceLabelCS]CB[ENDCOLOR] 植被多样性'),
--     ('zh_Hans_CN',  'LOC_MTL_BETTER_HILL_GRAPHICS_NAME',            '[COLOR:OperationChance_Green]更好的地形'),
--     ('zh_Hans_CN',  'LOC_MTL_RAUBAK_BLACK_MARKET_NAME',             '黑市'),
--     ('zh_Hans_CN',  'LOC_BETTER_TRADE_SCREEN_FIX_NAME',             '更好的贸易路线修复'),
