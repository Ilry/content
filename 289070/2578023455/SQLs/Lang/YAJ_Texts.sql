-- YAJ_Texts
-- Author: Karl
-- DateCreated: 1/13/2020 9:38:55 PM
--------------------------------------------------------------
INSERT OR REPLACE INTO BaseGameText(Tag,			Text)
VALUES
-- MOD INFO
("LOC_MOD_YUGONG_AND_JINGWEI_NAME",	"[COLOR_FLOAT_GOLD]Dig Mountain & Fill Ocean [ICON_DISTRICT_WONDER][ENDCOLOR]"),
("LOC_MOD_YUGONG_AND_JINGWEI_TEASER",	"Dig Mountain, Fill Ocean. More plots, and More Resource!"),
("LOC_MOD_YUGONG_AND_JINGWEI_DESCRIPTION",	"[COLOR_FLOAT_SCIENCE]*2022 Autumn Update*[ENDCOLOR][NewLine]This mod provides new civilian units, Yugong and Jingwei, with capability of remove Mountain and fill the Ocean plots.[NewLine]Extra features and resources might be DISCOVERED when plot is terrained![NewLine]You may improve terraining efficiency with governor promotions and new policy cards and relevant game interaction added.[NewLine]This mod also enables some Wonders built on Mountain.[NewLine][NewLine]The ogirin version of this mod is [COLOR_FLOAT_FOOD]Dig Mountain, Fill Ocean[ENDCOLOR] by WindFly."),

-- Configurations
("LOC_PARAMETER_YAJ_DISCOVERY_RATES_NAME",	"Discovery Rates"),
("LOC_PARAMETER_YAJ_DISCOVERY_RATES_DESCRIPTION",	'Rarity of discovering features and resources by terraining units.'),
("LOC_YAJ_DISCOVERY_RATE_NONE_NAME",	"None"),
("LOC_YAJ_DISCOVERY_RATE_NONE_DESCRIPTION",	"No features or resources will be discovered."),
("LOC_YAJ_DISCOVERY_RATE_LOW_NAME",	"Low"),
("LOC_YAJ_DISCOVERY_RATE_LOW_DESCRIPTION",	"Mutually exclusive discovery on features or resources with a low chance."),
("LOC_YAJ_DISCOVERY_RATE_FAIR_NAME",	"Fair"),
("LOC_YAJ_DISCOVERY_RATE_FAIR_DESCRIPTION",	"Features and resources can be discovered with a fair chance."),
("LOC_YAJ_DISCOVERY_RATE_MEDIUM_NAME",	"Medium"),
("LOC_YAJ_DISCOVERY_RATE_MEDIUM_DESCRIPTION",	"Features and resources are discovered with larger concomitance."),
("LOC_YAJ_DISCOVERY_RATE_HIGH_NAME",	"High"),
("LOC_YAJ_DISCOVERY_RATE_HIGH_DESCRIPTION",	"A lottery draw of cheat map editor by terraining units."),

("LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_NAME",	"Available For AI"),
("LOC_PARAMETER_YAJ_AVAILABLE_FOR_AI_DESCRIPTION",	'Availability of terraining units for AI players.'),

-- Tech Description
("LOC_YAJ_TECH_METAL_CASTING_DESCRIPTION", "Your {LOC_UNIT_YUGONG_NAME} gains +1 [ICON_MOVEMENT] Movement."),
("LOC_YAJ_TECH_COMBUSTION_DESCRIPTION", "{LOC_TECH_COMBUSTION_DESCRIPTION}[NewLine]Your {LOC_UNIT_YUGONG_NAME} gains +1 [ICON_MOVEMENT] Movement."),
("LOC_YAJ_TECH_ROBOTICS_DESCRIPTION", "{LOC_TECH_ROBOTICS_DESCRIPTION}[NewLine]Your {LOC_UNIT_YUGONG_NAME} and {LOC_UNIT_JINGWEI_NAME} gain +1 [ICON_MOVEMENT] Movement."),
("LOC_YAJ_TECH_CARTOGRAPHY_DESCRIPTION", "{LOC_TECH_CARTOGRAPHY_DESCRIPTION}[NewLine]Your {LOC_UNIT_JINGWEI_NAME} gains +1 [ICON_MOVEMENT] Movement."),
("LOC_YAJ_TECH_STEAM_POWER_DESCRIPTION", "{LOC_TECH_STEAM_POWER_DESCRIPTION}[NewLine]Your {LOC_UNIT_JINGWEI_NAME} gains +1 [ICON_MOVEMENT] Movement."),
("LOC_YAJ_TECH_ADVANCED_POWER_CELLS_DESCRIPTION", "{LOC_TECH_ADVANCED_POWER_CELLS_DESCRIPTION}[NewLine]Your {LOC_UNIT_TIAN_KUN_HAO_NAME} gains +2 [ICON_MOVEMENT] Movements."),

("LOC_YAJ_TECH_CHEMISTRY_DESCRIPTION", "Your {LOC_UNIT_YUGONG_NAME} gains +1 [ICON_Charges] Charge."),
("LOC_YAJ_TECH_NUCLEAR_FISSION_DESCRIPTION", "Your {LOC_UNIT_YUGONG_NAME} gains +1 [ICON_Charges] Charge."),
("LOC_YAJ_TECH_MASS_PRODUCTION_DESCRIPTION", "Your {LOC_UNIT_JINGWEI_NAME} gains +1 [ICON_Charges] Charge."),
("LOC_YAJ_TECH_SYNTHETIC_MATERIALS_DESCRIPTION", "{LOC_TECH_SYNTHETIC_MATERIALS_DESCRIPTION}[NewLine]Your {LOC_UNIT_JINGWEI_NAME} gains +1 [ICON_Charges] Charge."),

-- Policies
("LOC_POLICY_TERRAINING_IMPROVEMENT_NAME", "Terrain Grades Improvement"),
("LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_NAME", "Terraining Department"),

--("LOC_POLICY_SERFDOM_DESCRIPTION", "{LOC_POLICY_SERFDOM_DESCRIPTION} Newly trained {LOC_UNIT_YUGONG_NAME} and {LOC_UNIT_JINGWEI_NAME} gain +1 extra [ICON_Charges] Charge."),
("LOC_POLICY_TERRAINING_IMPROVEMENT_DESCRIPTION", "+20% [ICON_Production] Production toward {LOC_UNIT_YUGONG_NAME} and {LOC_UNIT_JINGWEI_NAME}, and newly trained gain +1 extra [ICON_Charges] Charge."),
("LOC_POLICY_ENVIROMENTAL_ENGINEERING_DEPARTMENT_DESCRIPTION", "+30% [ICON_Production] Production toward {LOC_UNIT_YUGONG_NAME}, {LOC_UNIT_JINGWEI_NAME} and {LOC_UNIT_TIAN_KUN_HAO_NAME}, and newly trained gain +2 extra [ICON_Charges] Charges."),
-- Wonders
("LOC_BUILDING_PYRAMIDS_DESCRIPTION", "Grants a free Builder. All Builders, Yugongs and JingWeis can build 1 extra improvement. Must be built on Desert (including Desert Floodplains) without Hills."),
("LOC_BUILDING_VENETIAN_ARSENAL_DESCRIPTION", "Receive a second naval unit each time you train a naval unit.[NewLine]All {LOC_UNIT_TIAN_KUN_HAO_NAME}s receives 1 extra [ICON_Charges] Charge. [NewLine][NewLine]Must be built on a Coast tile that is adjacent to an Industrial Zone district."),
-- Abls
("LOC_ABILITY_ALL_MOUNTAIN_MOVEMENT_DISALLOWED_DESCRIPTION", "Cannot Move to Mountain plots."),
("LOC_ABILITY_TIAN_KUN_CANNOT_ATTACK_DESCRIPTION", "{LOC_UNIT_TIAN_KUN_HAO_NAME} may enter foreign lands, but cannot attack since it is for civilian usage ONLY. Restore all [ICON_MOVEMENT] when comsumes a [ICON_Charges] build charge."),

-- Improvements
("LOC_IMPROVEMENT_ETHER_WATER_NAME", "Ether Water"),
("LOC_IMPROVEMENT_ETHER_WATER_DESCRIPTION", "Unlocks the {LOC_IMPROVEMENT_ETHER_WATER_NAME} on land tiles. [NEWLINE]Once built, the plot under this improvement will be converted into a coast plot, and this improvement will be removed immediately, and ice feature of surrounding plots within 1 tile will also be removed. [NEWLINE]Extra features or resources could be discovered when a plot is converted. [NEWLINE][NEWLINE]Cannot be built on mountain tiles."),
("LOC_IMPROVEMENT_IMMORTAL_SOIL_NAME", "Immortal Soil"),
("LOC_IMPROVEMENT_IMMORTAL_SOIL_DESCRIPTION", "Unlocks the {LOC_IMPROVEMENT_IMMORTAL_SOIL_NAME} on land tiles. [NEWLINE]Once built, the plot under this improvement will be converted into a mountain plot, and this improvement will be removed immediately.[NEWLINE]Surrounding land plots within 1 tile will become rugged by chance. [NEWLINE]Extra features or resources could be discovered when a plot is converted."),
("LOC_IMPROVEMENT_WAVING_RUINS_NAME", "Waving Ruins"),
("LOC_IMPROVEMENT_WAVING_RUINS_DESCRIPTION", "Unlocks the {LOC_IMPROVEMENT_WAVING_RUINS_NAME} on water plots. [NEWLINE]Once built, water tiles within 2 tiles will also be defreezed. [NEWLINE]Extra features or resources could be discovered in influenced plots."),

-- Lua Notifications
("LOC_SCRIPT_DISCOVER_RESOURCE_HINT_TEXT", "Discover Resource: "),
("LOC_SCRIPT_TENNKUNN_DEPLETION_HINT_TEXT", " is depleted."),
("LOC_SCRIPT_TENNKUNN_RESTORATION_HINT_TEXT", " [ICON_MOVEMENT] Movement Restored!");