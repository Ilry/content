insert or replace into Modifiers(ModifierId,	ModifierType) select
	'E_'||DistrictType||'_ON_'||FeatureType,	'MODIFIER_PLAYER_CITIES_ADJUST_VALID_FEATURES_DISTRICTS'
	from Districts, Features 
	WHERE FeatureType NOT IN('FEATURE_BURNING_FOREST','FEATURE_BURNT_FOREST','FEATURE_BURNING_JUNGLE','FEATURE_BURNT_JUNGLE');

insert or replace into ModifierArguments(ModifierId,		Name,	Value) select
	'E_'||DistrictType||'_ON_'||FeatureType,		'DistrictType',		DistrictType
	from Districts, Features 
	WHERE FeatureType NOT IN('FEATURE_BURNING_FOREST','FEATURE_BURNT_FOREST','FEATURE_BURNING_JUNGLE','FEATURE_BURNT_JUNGLE');

insert or replace into ModifierArguments(ModifierId,		Name,	Value) select
	'E_'||DistrictType||'_ON_'||FeatureType,		'FeatureType',		FeatureType
	from Districts, Features 
	WHERE FeatureType NOT IN('FEATURE_BURNING_FOREST','FEATURE_BURNT_FOREST','FEATURE_BURNING_JUNGLE','FEATURE_BURNT_JUNGLE');

insert or replace into TraitModifiers(TraitType,		ModifierId) select
	'TRAIT_LEADER_MAJOR_CIV',	'E_'||DistrictType||'_ON_'||FeatureType
	from Districts, Features 
	WHERE FeatureType NOT IN('FEATURE_BURNING_FOREST','FEATURE_BURNT_FOREST','FEATURE_BURNING_JUNGLE','FEATURE_BURNT_JUNGLE');