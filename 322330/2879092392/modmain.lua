require "printTable"

GLOBAL.WonderAPI = env
PrefabFiles = {
	"wonderwhy",
	--
	"whyehat",
	"whyehat_face",
	"whyehat_helm",
	"whyehat_helmet",
	"whyehat_dreadstone",
	"whyehat_dreadstone_green", -- actually whyehat_prothesis
	"whyearmor",
	"whyearmor_prosthesis",
	"whyearmor_backpack",
	"whyearmor_incomplete",
	"whyearmor_pile",

	"whyjewellab",
	"whyglobelab",
	"whycrusher",
	"whyfreezer",
	"why_wonderbox",
	"liquid_mirror",
    "why_crystal_flowers",
    "why_churchstatue_red",
    "why_churchstatue_blue",
    "why_churchstatue_purple",
    "why_churchstatue_green",
    "why_churchstatue_orange",
    "why_churchstatue_yellow",
    "why_churchstatue_opal",
	--
	"whycrank",
	"whytorch",
    "whyspear",
	"whypiercer",
	"whylifepeeler",
	"whytepadlo",
	"whybrella",
	"whyflutoscope",
	"whylantern",
    "whylunarwhip",
	"why_arsenal_red",
	"why_arsenal_blue",
	"why_arsenal_purple",
	"why_arsenal_orange",
	"why_arsenal_yellow",
	"why_arsenal_green",
	"why_arsenal_opal",
	--
    "ancientdreams_armour_polish",
    "ancientdreams_moss",
    "ancientdreams_mineral_dust",
    "ancientdreams_fairy_dust",
    "why_goatshard",
	"mineralmeteor",
    --
    
	"ancientdreams_gemshard",
	"ancientdreams_preparedfoods",
	--
	"why_redgem_seed",
	"why_redgem_overgrown",
	"why_bluegem_seed",
	"why_bluegem_overgrown",
	"why_purplegem_seed",
	"why_purplegem_overgrown",
	"why_greengem_seed",
	"why_greengem_overgrown",
	"why_orangegem_seed",
	"why_orangegem_overgrown",
	"why_yellowgem_seed",
	"why_yellowgem_overgrown",
	"why_opalgem_seed",
	"why_opalgem_overgrown",
	--
	"why_refined_lureplant",
	"why_refined_plantera",
	"why_refined_desertstone",
	"why_refined_gold",
	"why_refined_marble",
	"why_refined_moonrock",
	"why_refined_flint",
	"why_refined_glasswhites",
	"why_refined_milky",
	"why_refined_lightbulb",
	"why_refined_butterfly",
	"why_refined_butterfly_moon",
	--
	"why_refined_redgem",
	"why_refined_bluegem",
	"why_refined_purplegem",
	"why_refined_greengem",
	"why_refined_orangegem",
	"why_refined_yellowgem",
	"why_refined_opalgem",
	"why_nothingnessgem",
	"why_perfectiongem",
	"why_klaus_sack_piece",
	-- buffs
	"perfection_gem_buff",
	"refined_purple_gem_buff",
	"refined_blue_eye_in_face_buff",
	-- fxs
	"aureola_boom",
	-- geology update
	"ancientdreams_minerals",
	"ancientdreams_chiseltool",
	}

Assets = {
--------------------------------------------------anim
	Asset( "ANIM", "anim/aureola_boom.zip"),
	Asset( "ANIM", "anim/status_meter_endurance.zip"),
	Asset( "ANIM", "anim/status_endurance.zip"),
	Asset( "ANIM", "anim/xs_endurance.zip"),
	Asset( "ANIM", "anim/why_klaus_sack_piece.zip"),
    Asset( "ANIM", "anim/why_goatshard.zip"),
--------------------------------------------------vision
	Asset( "IMAGE", "images/fx/whye_fx.tex"),
	Asset( "ATLAS", "images/fx/whye_fx.xml"),
	Asset( "IMAGE", "images/fx/gemvision_deerclops.tex"),
	Asset( "ATLAS", "images/fx/gemvision_deerclops.xml"),
	Asset( "IMAGE", "images/fx/gemvision_lureplant.tex"),
	Asset( "ATLAS", "images/fx/gemvision_lureplant.xml"),
	Asset( "IMAGE", "images/fx/gemvision_plantera.tex"),
	Asset( "ATLAS", "images/fx/gemvision_plantera.xml"),
	Asset( "IMAGE", "images/fx/gemvision_blue.tex"),
	Asset( "ATLAS", "images/fx/gemvision_blue.xml"),
	Asset( "IMAGE", "images/fx/gemvision_green.tex"),
	Asset( "ATLAS", "images/fx/gemvision_green.xml"),
	Asset( "IMAGE", "images/fx/gemvision_nothingness.tex"),
	Asset( "ATLAS", "images/fx/gemvision_nothingness.xml"),
	Asset( "IMAGE", "images/fx/gemvision_opal.tex"),
	Asset( "ATLAS", "images/fx/gemvision_opal.xml"),
	Asset( "IMAGE", "images/fx/gemvision_orange.tex"),
	Asset( "ATLAS", "images/fx/gemvision_orange.xml"),
	Asset( "IMAGE", "images/fx/gemvision_perfection.tex"),
	Asset( "ATLAS", "images/fx/gemvision_perfection.xml"),
	Asset( "IMAGE", "images/fx/gemvision_purple.tex"),
	Asset( "ATLAS", "images/fx/gemvision_purple.xml"),
	Asset( "IMAGE", "images/fx/gemvision_red.tex"),
	Asset( "ATLAS", "images/fx/gemvision_red.xml"),
	Asset( "IMAGE", "images/fx/gemvision_yellow.tex"),
	Asset( "ATLAS", "images/fx/gemvision_yellow.xml"),
--------------------------------------------------save
    Asset( "IMAGE", "images/saveslot_portraits/wonderwhy.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wonderwhy.xml" ),
    Asset( "IMAGE", "images/selectscreen_portraits/wonderwhy.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wonderwhy.xml" ),
    Asset( "IMAGE", "images/selectscreen_portraits/wonderwhy_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/wonderwhy_silho.xml" ),
--------------------------------------------------hud
    Asset( "ATLAS", "images/hud/tab_globe_dreams.xml"),
    Asset( "IMAGE", "images/hud/tab_globe_dreams.tex"),
    Asset( "ATLAS", "images/hud/tab_refine_dreams.xml"),
    Asset( "IMAGE", "images/hud/tab_refine_dreams.tex"),
    Asset( "IMAGE", "images/avatars/avatar_wonderwhy.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_wonderwhy.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_ghost_wonderwhy.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_wonderwhy.xml" ),
    Asset( "IMAGE", "images/avatars/self_inspect_wonderwhy.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_wonderwhy.xml" ),
    Asset( "IMAGE", "images/crafting_menu_avatars/avatar_wonderwhy.tex" ),
    Asset( "ATLAS", "images/crafting_menu_avatars/avatar_wonderwhy.xml" ),
    Asset( "IMAGE", "images/names_wonderwhy.tex" ),
    Asset( "ATLAS", "images/names_wonderwhy.xml" ),
    Asset( "IMAGE", "images/names_gold_wonderwhy.tex" ),
    Asset( "ATLAS", "images/names_gold_wonderwhy.xml" ),
    Asset( "ATLAS", "images/hud/whyeball_slot.xml"),
    Asset( "IMAGE", "images/hud/whyeball_slot.tex"),
    Asset( "ANIM", "anim/ui_whyehat_1x1.zip"),
    Asset( "ANIM", "anim/ui_lightpackpremium_2x8.zip"),
	Asset( "ANIM", "anim/ui_why_freezer.zip"),
--------------------------------------------------character
    Asset( "IMAGE", "bigportraits/wonderwhy_none.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_none.xml" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_elder.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_elder.xml" ),
	Asset( "IMAGE", "bigportraits/wonderwhy_demon.tex" ),
	Asset( "ATLAS", "bigportraits/wonderwhy_demon.xml" ),
	Asset( "IMAGE", "bigportraits/wonderwhy_abyss.tex" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_abyss.tex" ),
	Asset( "ATLAS", "bigportraits/wonderwhy_abyss.xml" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_fairy.tex" ),
	Asset( "ATLAS", "bigportraits/wonderwhy_fairy.xml" ),
    Asset( "IMAGE", "images/map_icons/wonderwhy.tex" ),
    Asset( "ATLAS", "images/map_icons/wonderwhy.xml" ),
    Asset( "SOUNDPACKAGE", "sound/wonderwhy.fev"),
    Asset( "SOUND", "sound/wonderwhy.fsb"),
    Asset( "SOUNDPACKAGE", "sound/whyfunnysounds.fev"),
    Asset( "SOUND", "sound/whyfunnysounds.fsb"),
    Asset( "SOUNDPACKAGE", "sound/wonderwhyisnotasinger.fev"),
    Asset( "SOUND", "sound/wonderwhyisnotasinger.fsb"),
--------------------------------------------------other
    Asset("ATLAS", "images/inventoryimages/ancientdreams_why_fragment.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_why_fragment.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_why_thulecite.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_why_thulecite.tex"),
	Asset("ATLAS", "images/inventoryimages/why_redgem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_redgem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/why_bluegem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_bluegem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/why_purplegem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purplegem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/why_orangegem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_orangegem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/why_yellowgem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_yellowgem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/why_opalgem_seed_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/why_opalgem_seed_greencombo.tex"),
	Asset("ATLAS", "images/inventoryimages/liquid_mirror_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/liquid_mirror_greencombo.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_cutgrass.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_cutgrass.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_twigs.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_twigs.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_log.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_log.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_flint.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_flint.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_gold.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_gold.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_nf.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_nf.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_nitre.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_nitre.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_rocks.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_rocks.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_moonrock.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_moonrock.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_seeds.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_seeds.tex"),
    Asset("ATLAS", "images/inventoryimages/why_purple_packet.xml"),
	Asset("IMAGE", "images/inventoryimages/why_purple_packet.tex"),
    Asset("ATLAS", "images/inventoryimages/dust_gemshard.xml"),
	Asset("IMAGE", "images/inventoryimages/dust_gemshard.tex"),
    Asset("ATLAS", "images/inventoryimages/dust_cutgrass.xml"),
	Asset("IMAGE", "images/inventoryimages/dust_cutgrass.tex"),
    Asset("ATLAS", "images/inventoryimages/dust_livinglog.xml"),
	Asset("IMAGE", "images/inventoryimages/dust_livinglog.tex"),
    Asset("ATLAS", "images/inventoryimages/dust_rocks.xml"),
	Asset("IMAGE", "images/inventoryimages/dust_rocks.tex"),
    Asset("ATLAS", "images/inventoryimages/liquid_mirror_greencombo.xml"),
	Asset("IMAGE", "images/inventoryimages/liquid_mirror_greencombo.tex"),
    Asset("ATLAS", "images/inventoryimages/singingshell_why.xml"),
    Asset("IMAGE", "images/inventoryimages/singingshell_why.tex"),
    Asset("ATLAS", "images/inventoryimages/why_goatshard.xml"),
    Asset("IMAGE", "images/inventoryimages/why_goatshard.tex"),
-----------------------------------------------turfs
	Asset("ATLAS", "images/inventoryimages/why_church_turf.xml"),
	Asset("IMAGES", "images/inventoryimages/why_church_turf.tex"),
	Asset("ATLAS", "images/inventoryimages/why_church_turf_pink.xml"),
	Asset("IMAGES", "images/inventoryimages/why_church_turf_pink.tex"),
	Asset("ATLAS", "images/inventoryimages/why_church_turf_red.xml"),
	Asset("IMAGES", "images/inventoryimages/why_church_turf_red.tex"),
     Asset("ATLAS", "images/inventoryimages/why_church_turf_green.xml"),
	Asset("IMAGES", "images/inventoryimages/why_church_turf_green.tex"),
    Asset("ATLAS", "images/inventoryimages/why_church_turf_purple.xml"),
	Asset("IMAGES", "images/inventoryimages/why_church_turf_purple.tex"),
    -----------------------------------------------loading screens
    Asset("IMAGE", "images/bg_spiral_fill1.tex"),
    Asset("ATLAS", "images/bg_spiral_fill1.xml"),
    Asset("IMAGE", "images/bg_spiral_fill2.tex"),
    Asset("ATLAS", "images/bg_spiral_fill2.xml"),
    Asset("IMAGE", "images/bg_spiral_fill3.tex"),
    Asset("ATLAS", "images/bg_spiral_fill3.xml"),
    Asset("IMAGE", "images/bg_spiral_fill4.tex"),
    Asset("ATLAS", "images/bg_spiral_fill4.xml"),
    Asset("IMAGE", "images/bg_spiral_fill5.tex"),
    Asset("ATLAS", "images/bg_spiral_fill5.xml"),
    Asset("IMAGE", "images/bg_spiral_fill6.tex"),
    Asset("ATLAS", "images/bg_spiral_fill6.xml"),
    Asset("IMAGE", "images/bg_spiral_fill7.tex"),
    Asset("ATLAS", "images/bg_spiral_fill7.xml"),
    Asset("IMAGE", "images/bg_spiral_fill8.tex"),
    Asset("ATLAS", "images/bg_spiral_fill8.xml"),
}


modimport("scripts/libs/env.lua")
modimport("scripts/libs/jeweldream.lua")
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local fn = require("play_commonfn")
local fns = require("play_commonfn")
local push_acting = require("play_commonfn")
local general_scripts = require("play_generalscripts")


--------------------------------------------------SETTINGS
TUNING.WHY_CAVELESS_RECIPE = GetModConfigData("why_caveless_recipes")
TUNING.WHY_DIFFICULTY = GetModConfigData("why_difficulty")
TUNING.WHY_EYES = GetModConfigData("why_pairofeyes")
TUNING.WHY_EYEDMG = GetModConfigData("why_eye_option")
TUNING.WHYEHAT_SLOT = GetModConfigData("whyehat_slot_option")
TUNING.WHYEHAT_HP = GetModConfigData("whyehat_hp_option")
--TUNING.WHY_HAT_OPTION = GetModConfigData("why_hat_option") -- Not needed in endurance version
TUNING.WHY_LANGUAGE = GetModConfigData("why_language_option")
TUNING.WHY_OVERLAY = GetModConfigData("why_overlay")
TUNING.WHY_HAT_OVERLAY = GetModConfigData("why_hat_overlay")
TUNING.WHY_BOREALIS_CYCLE = GetModConfigData("why_borealis_light")
TUNING.WHY_ENDURANCE_HEAL = GetModConfigData("why_endurance_heal")
TUNING.WHY_NOTHINGNESS_DMGMULT = GetModConfigData("nothingness_option")
--------------------------------------------------TUNING
TUNING.WONDERWHY_HEALTH = 6
TUNING.WONDERWHY_SANITY = 80
TUNING.WONDERWHY_HUNGER = 120
--------------------------------------------------STRINGS
if TUNING.WHY_LANGUAGE == "spanish" then
STRINGS.CHARACTERS.WONDERWHY = require "speech_wonderwhy_spanish"
STRINGS.CHARACTER_TITLES.wonderwhy = "La memoria ancestral"
STRINGS.CHARACTER_NAMES.wonderwhy = "Why"
STRINGS.NAMES.wonderwhy = "Why"
STRINGS.CHARACTER_DESCRIPTIONS.wonderwhy = "*La mente es su núcleo\n*Descubre el conocimiento ancestral\n*Frágil\n*Mala vista"
STRINGS.CHARACTER_ABOUTME.wonderwhy = "Wonder Why fue el ingeniero principal de los ancestros, viviendo una vez entre la civilización olvidada, ahora una coraza que busca una respuesta."
STRINGS.CHARACTER_QUOTES.wonderwhy = "\"¿Por qué? Me pregunto ¿por qué?\""
STRINGS.CHARACTER_SURVIVABILITY.wonderwhy = "Risible"
STRINGS.SKIN_NAMES.wonderwhy_none = "Why"
elseif TUNING.WHY_LANGUAGE == "chinese" then -- TODO
	STRINGS.CHARACTERS.WONDERWHY = require "speech_wonderwhy_chinese"
	STRINGS.CHARACTER_TITLES.wonderwhy = "远古的记忆"
	STRINGS.CHARACTER_NAMES.wonderwhy = "Why"
	STRINGS.NAMES.wonderwhy = "Why"
	STRINGS.CHARACTER_DESCRIPTIONS.wonderwhy = "*思想是它们的核心\n*探寻远古的知识\n*脆弱\n*视力很差"
	STRINGS.CHARACTER_ABOUTME.wonderwhy = "Wonder Why是远古部族的主工程师, 曾经生活在被遗忘的文明中, 现在是一具寻求答案的躯壳."
	STRINGS.CHARACTER_QUOTES.wonderwhy = "\"为什么? 我想知道为什么?\""
	STRINGS.CHARACTER_SURVIVABILITY.wonderwhy = "可笑"
	STRINGS.SKIN_NAMES.wonderwhy_none = "Why"
else
STRINGS.CHARACTERS.WONDERWHY = require "speech_wonderwhy"
STRINGS.CHARACTER_TITLES.wonderwhy = "The Ancient Memory"
STRINGS.CHARACTER_NAMES.wonderwhy = "Why"
STRINGS.NAMES.wonderwhy = "Why"
STRINGS.CHARACTER_DESCRIPTIONS.wonderwhy = "*Mind sharp like a glass shard\n*Discovers Ancient knowledge\n*Fragile\n*Bad sight"
STRINGS.CHARACTER_ABOUTME.wonderwhy = "Wonder Why was the main engineer of the ancients, living  once among the forgotten civilization, now a husk seeking an answer."
STRINGS.CHARACTER_QUOTES.wonderwhy = "\"Why? I wonder why?\""
STRINGS.CHARACTER_SURVIVABILITY.wonderwhy = "Laughable"
STRINGS.SKIN_NAMES.wonderwhy_none = "Why"
STRINGS.STAGEACTOR.WONDERWHY1 =
{
    "We used to research the unknown.",
    "Whether it was the moon or the shadows.",
    "We'd have someone on the case.",
    "I dealt with both before... we were erased.",
    "We've been interrupted and everything got destroyed.",
    "The Experiment made me live to tell the tale.",
	"At a cost... all to prevail.",
	"I now seek an answer.",
	"Who am I?",
}


general_scripts.WONDERWHY1 = {
    cast = { "wonderwhy" },
    lines = {	
		{roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[1]},
        {roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[2]},	
        {roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[3]},
        {roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[4]},
        {roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[5]},
		{roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[6]},
		{roles = {"wonderwhy"},        duration = 4.0, line = STRINGS.STAGEACTOR.WONDERWHY1[7]},
		{roles = {"wonderwhy"},        duration = 3.5, line = STRINGS.STAGEACTOR.WONDERWHY1[8]},
		{roles = {"wonderwhy"},        duration = 5.0, line = STRINGS.STAGEACTOR.WONDERWHY1[9]},
		{actionfn = fn.actorsbow,   duration = 0.2, },
    },
}
end
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WONDERWHY = {("whyehat"), ("whyearmor_incomplete"), ("why_refined_redgem")}
local wonderwhystartingitem = {
    whyehat = {atlas = "images/inventoryimages/whyehat.xml"},
    --whycrank = {atlas = "images/inventoryimages/whycrank.xml"},
    whyearmor_incomplete = {atlas = "images/inventoryimages/whyearmor_incomplete.xml"},
    why_refined_redgem = {atlas = "images/inventoryimages/why_refined_redgem.xml"},}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE = type(TUNING.STARTING_ITEM_IMAGE_OVERRIDE) == "table"
and GLOBAL.MergeMaps(TUNING.STARTING_ITEM_IMAGE_OVERRIDE, wonderwhystartingitem) or wonderwhystartingitem

GLOBAL.PREFAB_SKINS["wonderwhy"] = { "wonderwhy_none",}
GLOBAL.PREFAB_SKINS_IDS["wonderwhy"] = {["wonderwhy_none"] = 1}
--Sounds
RemapSoundEvent( "dontstarve/characters/wonderwhy/talk_LP", "wonderwhy/wonderwhy/talk_LP" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/ghost_LP", "wonderwhy/wonderwhy/ghost_LP" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/hurt", "wonderwhy/wonderwhy/hurt" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/death_voice", "wonderwhy/wonderwhy/death_voice" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/emote", "wonderwhy/wonderwhy/emote" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/yawn", "wonderwhy/wonderwhy/yawn" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/eye_rub_vo", "wonderwhy/wonderwhy/eye_rub_vo" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/pose", "wonderwhy/wonderwhy/pose" )
RemapSoundEvent( "dontstarve/characters/wonderwhy/carol", "wonderwhyisnotasinger/wonderwhyisnotasinger/carol" )
RemapSoundEvent( "dontstarve/HUD/wonderwhy/goingtosleep", "wonderwhy/wonderwhy/goingtosleep" )
--
RemapSoundEvent( "dontstarve/HUD/whyfunnysounds/whylovedeerclops", "whyfunnysounds/whyfunnysounds/whylovedeerclops" )
RemapSoundEvent( "dontstarve/HUD/whyfunnysounds/phukin eyes", "whyfunnysounds/whyfunnysounds/phukin eyes" )

local RegisterItem =
{
	"whyehat",
	"whyehat_dreadstone",
	"whyehat_dreadstone_broken",
	"whyehat_face",
    "whyspear",
    "whyearmor_backpack",
    "why_wonderbox",
	"why_refined_glasswhites",
}

for k,v in pairs(RegisterItem) do
	RegisterInventoryItemAtlas("images/inventoryimages/"..v..".xml", v..".tex")
end

--[[
local obc_recentTarget = {
	flag = 0,
	entity = nil,
	x = 0, y = 0, z = 0,
}
]]
--[[
AddClassPostConstruct("cameras/followcamera", function(Camera)
	Camera.old = Camera.SetDefault
	function Camera:SetDefault()
		if Camera.target ~= nil and Camera.target.entity and Camera.target.entity:GetParent() ~= nil and Camera.target.entity:GetParent().prefab=="wonderwhy" then
		Camera.maxdist = 50 else
		Camera.maxdist = 40 end end end)
]]
--[[
local function ChangeCameraTarget()
	if IsDefaultScreen() then
		local entity = 
		if entity ~= nil then
			local x, y, z = entity.Transform:GetWorldPosition()
			if x ~= nil and y ~= nil and z ~= nil then
				GLOBAL.TheCamera.target = entity
				GLOBAL.TheCamera.targetpos.x, GLOBAL.TheCamera.targetpos.y, GLOBAL.TheCamera.targetpos.z = x, y, z
				obc_recentTarget.flag = 1
				obc_recentTarget.entity = entity
				obc_recentTarget.x, obc_recentTarget.y, obc_recentTarget.z = x, y, z else
				--GLOBAL.ThePlayer.components.talker:Say("Out of range") end end end end
]]
local skin_modes = {{ 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 }},}
if TUNING.WHY_LANGUAGE == "spanish" then
	modimport("scripts/modstrings_spanish.lua")
	modimport("scripts/describestrings_spanish.lua")
elseif TUNING.WHY_LANGUAGE == "chinese" then
	modimport("scripts/modstrings_chinese.lua")
	modimport("scripts/describestrings_chinese.lua") -- TODO
else
modimport("scripts/modstrings.lua")
modimport("scripts/describestrings.lua")
end
modimport("scripts/why_whyearmor_backpack")
modimport("scripts/why_whyehat")
modimport("scripts/why_freezer")
modimport("scripts/why_wonderbox")
modimport("scripts/recipes.lua")
AddMinimapAtlas("images/map_icons/wonderwhy.xml")
AddMinimapAtlas("images/map_icons/whyjewellabmap.xml")
AddMinimapAtlas("images/map_icons/whyglobelabmap.xml")
AddMinimapAtlas("images/map_icons/whycrushermap.xml")
AddMinimapAtlas("images/map_icons/whyfreezermap.xml")
AddMinimapAtlas("images/map_icons/why_redgem_formation.xml")
AddMinimapAtlas("images/map_icons/why_bluegem_formation.xml")
AddMinimapAtlas("images/map_icons/why_purplegem_formation.xml")
AddMinimapAtlas("images/map_icons/why_greengem_formation.xml")
AddMinimapAtlas("images/map_icons/why_orangegem_formation.xml")
AddMinimapAtlas("images/map_icons/why_yellowgem_formation.xml")
AddMinimapAtlas("images/map_icons/why_opalgem_formation.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_red.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_blue.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_purple.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_orange.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_green.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_yellow.xml")
AddMinimapAtlas("images/map_icons/why_churchstatue_opal.xml")
AddModCharacter("wonderwhy", "PLURAL", skin_modes)
--modimport("scripts/libs/skins_base_api.lua")
--modimport("scripts/skinsaffinity.lua")
------------------------------------------------------------------
AddPrefabPostInit("redgem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("bluegem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("purplegem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("greengem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("orangegem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("yellowgem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("opalpreciousgem", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("deerclops_eyeball", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("trinket_22", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("acorn", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("rocks", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("slingshotammo_rock", function(inst)
	inst:AddTag("whyeball") end)
--[[AddPrefabPostInit("slingshotammo_marble", function(inst)
	inst:AddTag("whyeball") end)]]
AddPrefabPostInit("bird_egg", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("sewing_mannequin", function(inst)
	inst:AddTag("canholdwhyehat") end)
--[[AddPrefabPostInit("winley_eye", function(inst)
	inst:AddTag("whyeball") end)
AddPrefabPostInit("gnarcoon_eye", function(inst)
	inst:AddTag("whyeball") end)]]

local whybox_accept = {"cutgrass", "goldnugget", "rocks", "flint", "log", "twigs", "moonrocknugget","nitre", "ancientdreams_gemshard","ancientdreams_mineral_dust","ancientdreams_moss", "livinglog", "nightmarefuel"}
	for _, v in pairs(whybox_accept) do
		AddPrefabPostInit(v, function(inst)
		inst:AddTag("whybox_accept")
	end)
end
AddClassPostConstruct( "widgets/controls", function(self)
	if self.owner == nil then 
		return end
if TUNING.WHY_HAT_OVERLAY == "1" then
	local Red_fx = require "widgets/red_fx"
	self.red_fx = self:AddChild(Red_fx(self.owner))
	self.red_fx:MoveToBack()
--
	local Blue_fx = require "widgets/blue_fx"
	self.blue_fx = self:AddChild(Blue_fx(self.owner))
	self.blue_fx:MoveToBack()
--
	local Purple_fx = require "widgets/purple_fx"
	self.purple_fx = self:AddChild(Purple_fx(self.owner))
	self.purple_fx:MoveToBack()
--
	local Green_fx = require "widgets/green_fx"
	self.green_fx = self:AddChild(Green_fx(self.owner))
	self.green_fx:MoveToBack()
--
	local Orange_fx = require "widgets/orange_fx"
	self.orange_fx = self:AddChild(Orange_fx(self.owner))
	self.orange_fx:MoveToBack()
--
	local Yellow_fx = require "widgets/yellow_fx"
	self.yellow_fx = self:AddChild(Yellow_fx(self.owner))
	self.yellow_fx:MoveToBack()
--
	local Opal_fx = require "widgets/opal_fx"
	self.opal_fx = self:AddChild(Opal_fx(self.owner))
	self.opal_fx:MoveToBack()
--
	local Perfection_fx = require "widgets/perfection_fx"
	self.perfection_fx = self:AddChild(Perfection_fx(self.owner))
	self.perfection_fx:MoveToBack()
--
	local Nothingness_fx = require "widgets/nothingness_fx"
	self.nothingness_fx = self:AddChild(Nothingness_fx(self.owner))
	self.nothingness_fx:MoveToBack()
--
	local Deerclops_fx = require "widgets/deerclops_fx"
	self.deerclops_fx = self:AddChild(Deerclops_fx(self.owner))
	self.deerclops_fx:MoveToBack()
--
	local Lureplant_fx = require "widgets/lureplant_fx"
	self.lureplant_fx = self:AddChild(Lureplant_fx(self.owner))
	self.lureplant_fx:MoveToBack()
--
	local Plantera_fx = require "widgets/plantera_fx"
	self.plantera_fx = self:AddChild(Plantera_fx(self.owner))
	self.plantera_fx:MoveToBack()
end
if TUNING.WHY_OVERLAY == "1" and TUNING.WHY_DIFFICULTY ~= "-1" then
	local Oneeyevision = require "widgets/oneeyevision"
	self.oneeyevision = self:AddChild(Oneeyevision(self.owner))
	self.oneeyevision:MoveToBack()
end
end)


AddPrefabPostInit("nightmarefuel", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("gears", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("thulecite", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("thulecite_pieces", function(inst)
	inst:AddTag("fitsforgempack") end)
AddPrefabPostInit("moonrocknugget", function(inst)
	inst:AddTag("fitsforgempack") end)

local function OnForcedNightVisionDirty(target)
	if target.components.playervision ~= nil then
		local nightvision_purple
		local nightvision_wx

		if target._has_purple_gem_buff then
			nightvision_purple = target._has_purple_gem_buff:value()
		end
		if target._forced_nightvision then
			nightvision_wx = target._forced_nightvision:value()
		end
		target.components.playervision:ForceNightVision(nightvision_purple or nightvision_wx)
	end
end

local function OnPlayerDeactivated(inst)
	inst:RemoveEventCallback("onremove", OnPlayerDeactivated)
	if not TheNet:IsDedicated() then
		inst:RemoveEventCallback("purplegembuffdirty", OnForcedNightVisionDirty)
	end
end

local function OnPlayerActivated(inst)
	inst:ListenForEvent("onremove", OnPlayerDeactivated)
	if not TheNet:IsDedicated() then
		inst:ListenForEvent("purplegembuffdirty", OnForcedNightVisionDirty)
		OnForcedNightVisionDirty(inst)
	end
end


local COLOURCUBES ={
	-- day = "images/colour_cubes/purple_moon_cc.tex",
	-- dusk = "images/colour_cubes/purple_moon_cc.tex",
	-- night = "images/colour_cubes/purple_moon_cc.tex",
	-- full_moon = "images/colour_cubes/purple_moon_cc.tex",
	day = "images/colour_cubes/day05_cc.tex",
	dusk = "images/colour_cubes/dusk03_cc.tex",
	night = "images/colour_cubes/purple_moon_cc.tex",
	full_moon = "images/colour_cubes/purple_moon_cc.tex",
}

local function SetDreadStoneVision(inst)
	local isequipped = inst._why_dreadstone_nightvision:value()
	if isequipped then
		if inst.components.playervision then
			inst.components.playervision:ForceNightVision(true)
			inst.components.playervision:ForceGoggleVision(true)
			inst.components.playervision:SetCustomCCTable(COLOURCUBES)
		end
	else
		if inst.components.playervision then
			-- inst.components.playervision:ForceNightVision(false)
			inst.components.playervision:ForceNightVision(false)
			inst.components.playervision:ForceGoggleVision(false)
			inst.components.playervision:SetCustomCCTable(nil)
		end
	end
end


-- Thanks to Medal
AddPlayerPostInit(function(inst)
	inst._has_purple_gem_buff = net_bool(inst.GUID, "refined_purple_gem_buff.forced_nightvision", "purplegembuffdirty")
	if inst.prefab == "wonderwhy" then
		inst._why_dreadstone_nightvision = GLOBAL.net_bool(inst.GUID, "why_dreadstone_nightvision.forced_nightvision", "why_dreadstone_nightvisiondirty")
		inst:ListenForEvent("why_dreadstone_nightvisiondirty", SetDreadStoneVision)
	end
	inst:ListenForEvent("playeractivated", OnPlayerActivated)
	inst:ListenForEvent("playerdeactivated", OnPlayerDeactivated)
end)

-- add endurance bonus to origin armors

local function Save_and_Load(inst)
	local oldOnSave = inst.OnSave
	local oldOnLoad = inst.OnLoad

	if oldOnSave then
		inst.OnSave = function(inst, data)
			if inst.current_endurance_bonus then
				data.current_endurance_bonus = inst.current_endurance_bonus
				oldOnSave(inst, data)
			end
		end
	else
		inst.OnSave = function(inst, data)
			if inst.current_endurance_bonus then
				data.current_endurance_bonus = inst.current_endurance_bonus
			end
		end
	end

	if oldOnLoad then
		inst.OnLoad = function(inst, data)
			if data and data.current_endurance_bonus then
				inst.current_endurance_bonus = data.current_endurance_bonus
				oldOnLoad(inst, data)
			end
		end
	else
		inst.OnLoad = function(inst, data)
			if data and data.current_endurance_bonus then
				inst.current_endurance_bonus = data.current_endurance_bonus
			end
		end
	end
end

local function endurance_bonus_tier1(inst)
	inst.endurance_bonus = 1
	Save_and_Load(inst)
end

local function endurance_bonus_tier2(inst)
	inst.endurance_bonus = 2
	Save_and_Load(inst)
end

local function endurance_bonus_tier3(inst)
	inst.endurance_bonus = 3
	Save_and_Load(inst)
end

local function endurance_bonus_tier4(inst)
	inst.endurance_bonus = 4
	Save_and_Load(inst)
end

AddPrefabPostInit("armorgrass",endurance_bonus_tier1)
AddPrefabPostInit("armor_bramble",endurance_bonus_tier1)
AddPrefabPostInit("armorwood",endurance_bonus_tier2)
AddPrefabPostInit("armor_sanity",endurance_bonus_tier2)
AddPrefabPostInit("armormarble",endurance_bonus_tier2)
AddPrefabPostInit("armordragonfly",endurance_bonus_tier2)
AddPrefabPostInit("armorsnurtleshell",endurance_bonus_tier3)
AddPrefabPostInit("armorruins",endurance_bonus_tier3)
AddPrefabPostInit("armor_voidcloth",endurance_bonus_tier4)
AddPrefabPostInit("armor_lunarplant",endurance_bonus_tier4)

local moddir = KnownModIndex:GetModsToLoad(true)
local enablemods = {}

for k, dir in pairs(moddir) do
	local info = KnownModIndex:GetModInfo(dir)
	local name = info and info.name or "unknow"
	enablemods[dir] = name
end
-- If mod is enabled
local function IsModEnable(name)
	for k, v in pairs(enablemods) do
		if v and (k:match(name) or v:match(name)) then return true end
	end
	return false
end

local function StatusPostConstructForWonder(self)
	if ThePlayer.prefab == "wonderwhy" then
		if not IsModEnable("Combined Status") then
			self.stomach:SetPosition(40, 20, 0)
			self.heart:SetPosition(-40, 20, 0)
		else
			self.stomach:SetPosition(62, 35)
			self.heart:SetPosition(-62, 35)
		end
	end
end

AddClassPostConstruct("widgets/statusdisplays", StatusPostConstructForWonder)

--UM food fix for the people who needs it
local gemfoodlist = {
	"ancientdreams_gegg",
	"ancientdreams_candy",
	"ancientdreams_cube",
	"ancientdreams_geocake",
	"ancientdreams_hyubsip",
	"ancientdreams_kozisip",
	"ancientdreams_tart",
	"ancientdreams_evilbred",
	"ancientdreams_gell",
	"ancientdreams_quaso",
	"ancientdreams_fhish",
	"ancientdreams_lombter",
	"ancientdreams_pizza",
	"ancientdreams_ser",
}

local function UM_Food_Compat(inst, health_delta, hunger_delta, sanity_delta, food, feeder)
	if not food:HasTag("ancientdreams_gemfood") then
		if health_delta <= 0 then
			health_delta = 0
		end

		if sanity_delta then
			sanity_delta = 0
		end
	end

	return health_delta, hunger_delta, sanity_delta
end

if IsModEnable("󰀕 Uncompromising Mode") then
	for _, v in pairs(gemfoodlist) do
		AddPrefabPostInit(v, function(inst)
			inst:AddTag("ancientdreams_gemfood")
		end)
	end

	AddPrefabPostInit("wonderwhy", function(inst)
		if not TheWorld.ismastersim then
			return
		end

		inst:AddTag("ignores_healthregen")

		if inst.components.eater then
			inst.components.eater.custom_stats_mod_fn = UM_Food_Compat
		end
	end)
end

local function BuilderEnduranceHook(inst)
	local oldHasCharacterIngredient = inst.HasCharacterIngredient
	inst.HasCharacterIngredient = function(self, ingredient)
		if self.inst:HasTag("health_as_endurance") then
			if ingredient.type == CHARACTER_INGREDIENT.HEALTH then
				if self.inst.components.health ~= nil then
					local amount_required = math.ceil(ingredient.amount / 20)
					local current = math.ceil(self.inst.components.health.currenthealth)
					return current > amount_required, current --Don't die from crafting!
				end
			else
				return oldHasCharacterIngredient(self, ingredient)
			end
		else
			return oldHasCharacterIngredient(self, ingredient)
		end
	end
end

AddComponentPostInit("builder", BuilderEnduranceHook)

local function GreenEyeBuilderHook(self)
	local _DoBuild = self.DoBuild

	function self:DoBuild(recname, pt, rotation, skin, ...)
		local _recipe = GetValidRecipe(recname) --kinda didn't want to redefine the og local recipe...
		if _recipe ~= nil and (self:IsBuildBuffered(recname) or self:HasIngredients(_recipe)) and not PREFAB_SKINS_SHOULD_NOT_SELECT[skin] then
			if self.inst:HasTag("whyancientmaker") and (self.inst.components.sanity and self.inst.components.sanity.current < 7.5) then
				return false, "GREENEYE_INSANE"
			else
				return _DoBuild(self, recname, pt, rotation, skin, ...)
			end
		else
			return _DoBuild(self, recname, pt, rotation, skin, ...)
		end
	end
end

AddComponentPostInit("builder", GreenEyeBuilderHook)

local function BuilderReplicaEnduranceHook(inst)
	local oldHasCharacterIngredient = inst.HasCharacterIngredient
	inst.HasCharacterIngredient = function(self, ingredient)
		if self.inst:HasTag("health_as_endurance") then
			if self.inst.components.builder ~= nil then
				return self.inst.components.builder:HasCharacterIngredient(ingredient)
			elseif self.classified ~= nil then
				if ingredient.type == CHARACTER_INGREDIENT.HEALTH then
					local health = self.inst.replica.health
					if health ~= nil then
						local amount_required = math.ceil(ingredient.amount / 20)
						local current = math.ceil(health:GetCurrent())
						return current > amount_required, current --Don't die from crafting!
					end
				else
					return oldHasCharacterIngredient(self, ingredient)
				end
			end
		else
			return oldHasCharacterIngredient(self, ingredient)
		end
	end
end

AddClassPostConstruct("components/builder_replica", BuilderReplicaEnduranceHook)

local CraftHint = {

}

local function CraftHintHook(inst)
	local oldUpdateBuildButton = inst.UpdateBuildButton
	inst.UpdateBuildButton = function(self, from_pin_slot)
		if self.data == nil then
			return
		end
		local recipe = self.data.recipe
		if recipe.builder_tag == "cheapergemseedmaker" then
			local meta = self.data.meta
			local teaser = self.build_button_root.teaser
			local button = self.build_button_root.button

			if meta.build_state == "hint" or meta.build_state == "hide" or self.ingredients.hint_tech_ingredient ~= nil then
				local str
				if self.owner:HasTag(recipe.builder_tag) then
					if TUNING.WHY_LANGUAGE == "spanish" then
						str = "Usa un Reloj divino de globo en el que fabricar esto."
					elseif TUNING.WHY_LANGUAGE == "chinese" then
						str = "使用神圣球钟来制作这个。"
					else
						str = "Use a Divine Globe Clock to craft this."
					end
				else
					if TUNING.WHY_LANGUAGE == "spanish" then
						str = "Lleva el COMBO VERDE para fabricar esto."
					elseif TUNING.WHY_LANGUAGE == "chinese" then
						str = "装备绿色连击套装来制作这个。"
					else
						str = "Wear GREEN COMBO to craft this."
					end
				end
				teaser:SetSize(20)
				teaser:UpdateOriginalSize()
				teaser:SetMultilineTruncatedString(str, 2, (self.panel_width / 2) * 0.8, nil, false, true)

				teaser:Show()
				button:Hide()
			else
				return oldUpdateBuildButton(self, from_pin_slot)
			end
		elseif recipe.builder_tag == "whygemseedmaker" then
			local meta = self.data.meta
			local teaser = self.build_button_root.teaser
			local button = self.build_button_root.button

			if meta.build_state == "hint" or meta.build_state == "hide" or self.ingredients.hint_tech_ingredient ~= nil then
				local str
				if self.owner:HasTag(recipe.builder_tag) then
					if TUNING.WHY_LANGUAGE == "spanish" then
						str = "Usa un Reloj divino de globo en el que fabricar esto."
					elseif TUNING.WHY_LANGUAGE == "chinese" then
						str = "使用神圣球钟来制作这个。"
					else
						str = "Use a Divine Globe Clock to craft this."
					end
				else
					if TUNING.WHY_LANGUAGE == "spanish" then
						str = "placeholder."
					elseif TUNING.WHY_LANGUAGE == "chinese" then
						str = "佩戴精制绿宝石来制作这个。"
					else
						str = "Wear a refined green gem to craft this."
					end
				end
				teaser:SetSize(20)
				teaser:UpdateOriginalSize()
				teaser:SetMultilineTruncatedString(str, 2, (self.panel_width / 2) * 0.8, nil, false, true)

				teaser:Show()
				button:Hide()
			else
				return oldUpdateBuildButton(self, from_pin_slot)
			end
		else
			return oldUpdateBuildButton(self, from_pin_slot)
		end
	end
end
---

if TUNING.WHY_LANGUAGE == "spanish" then
	STRINGS.UI.CRAFTING["NEEDSJEWELDREAM_ONE"] = "Usa una Piedra de afilar de joyas ancestral para fabricar esto."
	STRINGS.UI.CRAFTING["NEEDSGLOBEDREAM_ONE"] = "Usa un Reloj divino de globo en el que fabricar esto."
elseif TUNING.WHY_LANGUAGE == "chinese" then
	STRINGS.UI.CRAFTING["NEEDSJEWELDREAM_ONE"] = "使用远古宝石磨石来制作这个。"
	STRINGS.UI.CRAFTING["NEEDSGLOBEDREAM_ONE"] = "使用神圣球钟来制作这个。"
else
	STRINGS.UI.CRAFTING["NEEDSJEWELDREAM_ONE"] = "Use a Ancient Jewel Grindstone to craft this."
	STRINGS.UI.CRAFTING["NEEDSGLOBEDREAM_ONE"] = "Use a Divine Globe Clock to craft this."
end

AddClassPostConstruct("widgets/redux/craftingmenu_details", CraftHintHook)

AddPrefabPostInit("klaus", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("why_klaus_sack_piece", 1)
	end
end)

AddPrefabPostInit("krampus", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("why_klaus_sack_piece", .5)
	end
end)

AddPrefabPostInit("lightninggoat", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("why_goatshard", 1)
	end
end)

AddPrefabPostInit("rock1", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral_dust", 1)
	end
end)

AddPrefabPostInit("rock2", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral_dust", 1)
	end
end)

AddPrefabPostInit("rock_flintless", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral_dust", 1)
	end
end)

AddPrefabPostInit("rock7", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral_dust", 1)
	end
end)

AddPrefabPostInit("rock_avocado_fruit", function(inst)
	if inst.components.lootdropper then
		inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral_dust", 0.1)
	end
end)

function MossPostInit(inst)    
	if GLOBAL.TheWorld.ismastersim then
		local oldonfinish = inst.components.workable.onfinish
		inst.components.workable.onfinish = function(inst, chopper)
			if chopper and inst.components.growable then
				if inst.noleif == true then
					inst.components.lootdropper:AddChanceLoot("ancientdreams_mineral", 1)
					inst.components.lootdropper:AddChanceLoot("ancientdreams_moss", .25)
				elseif inst.components.growable.stage == 3 then
					inst.components.lootdropper:AddChanceLoot("ancientdreams_moss", 1)
				elseif inst.components.growable.stage == 2 then
					inst.components.lootdropper:AddChanceLoot("ancientdreams_moss", .6)
				else
					inst.components.lootdropper:AddChanceLoot("ancientdreams_moss", .4)
				end
			elseif chopper then
				inst.components.lootdropper:AddChanceLoot("ancientdreams_moss", 1)
			end
			if oldonfinish then
				oldonfinish(inst, chopper)
			end
		end
	end
		return inst
end 

local trees = {"evergreen", 
    "evergreen_normal", 
    "evergreen_tall", 
    "evergreen_short", 
    "evergreen_sparse",
    "evergreen_sparse_normal", 
    "evergreen_sparse_tall", 
    "evergreen_sparse_short",
    "deciduoustree",
    "deciduoustree_normal",
    "deciduoustree_tall",
    "deciduoustree_short",
    "twiggytree",
    "twiggy_tall",
    "twiggy_normal",
    "twiggy_short",
    "mushtree_small",
    "mushtree_medium",
    "mushtree_tall",
    "rock_petrified_tree",
    "rock_petrified_tree_short",
    "rock_petrified_tree_tall",
    "rock_petrified_tree_old"} for k,v in pairs(trees) do AddPrefabPostInit(v, MossPostInit)
end

AddReplicableComponent("why_endurance")

-- Thanks to Medal
AddComponentPostInit("workable", function(workable,inst)
	local oldDestroyFn=workable.Destroy
	workable.Destroy=function (self,destroyer)
		if not self.inst:HasTag("cantdestroy") then
			oldDestroyFn(self,destroyer)
		end
	end
	local oldWorkedByFn = workable.WorkedBy
	workable.WorkedBy=function(self,worker,numworks)
		if self.inst:HasTag("cantdestroy") and not worker:HasTag("player") then
			return
		end
		if oldWorkedByFn then
			oldWorkedByFn(self,worker,numworks)
		end
	end
end)

modimport("scripts/wonder_skins")
modimport("scripts/turfs")
modimport("scripts/actions/why_actions")

local minisign_show_list = {
	"whyehat",
	"whyehat_face",
	"whyehat_helm",
	"whyehat_helmet",
	"whyehat_dreadstone",
	"whyearmor",
	"whyearmor_prosthesis",
	"whyearmor_backpack",
	"whyearmor_incomplete",
	"whyearmor_pile",

	"liquid_mirror",
	--
	"whycrank",
	"whytorch",
    "whyspear",
	"whypiercer",
	"whylifepeeler",
	"whytepadlo",
	"whybrella",
	"whyflutoscope",
	"whylantern",
	"whylunarwhip",
	--
    "ancientdreams_armour_polish",
    "ancientdreams_moss",
    "ancientdreams_mineral_dust",
    "ancientdreams_fairy_dust",
    "why_goatshard",
    --
	"ancientdreams_gemshard",
	"ancientdreams_preparedfoods",
    "ancientdreams_hyubsip",
    "ancientdreams_kozisip",
    "ancientdreams_tart",
    "ancientdreams_evilbred",
    "ancientdreams_gell",
    "ancientdreams_quaso",
    "ancientdreams_fhish",
    "ancientdreams_lombter",
    "ancientdreams_pizza",
    "ancientdreams_ser",
	--
	"why_redgem_seed",
	"why_bluegem_seed",
	"why_purplegem_seed",
	"why_greengem_seed",
	"why_orangegem_seed",
	"why_yellowgem_seed",
	"why_opalgem_seed",
	--
	"why_refined_desertstone",
	"why_refined_gold",
	"why_refined_moonrock",
	"why_refined_flint",
	"why_refined_glasswhites",
	"why_refined_milky",
	"why_refined_lightbulb",
	"why_refined_butterfly",
	"why_refined_butterfly_moon",
	--
	"why_refined_redgem",
	"why_refined_bluegem",
	"why_refined_purplegem",
	"why_refined_greengem",
	"why_refined_orangegem",
	"why_refined_yellowgem",
	"why_refined_opalgem",
	"why_nothingnessgem",
	"why_perfectiongem",
	"why_klaus_sack_piece",
    "why_wonderbox",
}

local function draw(inst)
	if inst.components.drawable then
		local oldondrawnfn = inst.components.drawable.ondrawnfn or nil
		inst.components.drawable.ondrawnfn = function(inst, image, src, atlas, bgimagename, bgatlasname)
			if oldondrawnfn ~= nil then
				oldondrawnfn(inst, image, src, atlas, bgimagename, bgatlasname)
			end
			print(image,atlas)
			if image ~= nil and table.contains(minisign_show_list,image) then --是我的物品
				if atlas==nil then
					atlas="images/inventoryimages/"..image..".xml"
				end
				local atlas_path=softresolvefilepath(atlas)
				print(atlas_path)
				if atlas_path then
					inst.AnimState:OverrideSymbol("SWAP_SIGN", atlas_path, image..".tex")
				end
			end
		end
	end
end

AddPrefabPostInit("minisign", draw)
AddPrefabPostInit("minisign_drawn", draw)
AddPrefabPostInit("decor_pictureframe", draw)
local gemList = {
	"redgem",
	"bluegem",
	"purplegem",
	"greengem",
	"orangegem",
	"yellowgem",
	"opalpreciousgem",
	"why_refined_redgem",
	"why_refined_bluegem",
	"why_refined_purplegem",
	"why_refined_greengem",
	"why_refined_orangegem",
	"why_refined_yellowgem",
	"why_refined_opalgem",
}

local gemshardNumList = {
	redgem = 2,
	bluegem = 2,
	purplegem = 4,
	greengem = 5,
	orangegem = 5,
	yellowgem = 5,
	opalpreciousgem = 8,
	why_refined_redgem = 1,
	why_refined_bluegem = 1,
	why_refined_purplegem = 2,
	why_refined_greengem = 3,
	why_refined_orangegem = 3,
	why_refined_yellowgem = 3,
	why_refined_opalgem = 6,
}

local function AbleToAcceptTest(inst, item, giver, count)
	if inst._crushingtask ~= nil then
		return false, "BUSY"
	end

	if count == nil then
		return false
	end
	print(item.prefab)
	if not table.contains(gemList,item.prefab) then
		return false
	end

	return true
end

local function GiveOrDropItem(item, doer, inst, pos)
	local pos = inst:GetPosition()

	if doer and doer:IsValid() and doer.components.inventory ~= nil and inst:IsNear(doer, TUNING.RESEARCH_MACHINE_DIST) then
		doer.components.inventory:GiveItem(item, nil, pos)
	else
		inst.components.lootdropper:FlingItem(item, pos)
	end
end

local function GiveGemshards(inst, giver, item, count)
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	inst._crushingtask = nil

	inst.AnimState:PlayAnimation(inst.components.prototyper.on and "proximity_loop" or "idle", inst.components.prototyper.on)

	local moisture, iswet
	if item then
		moisture, iswet = item.components.inventoryitem:GetMoisture(), item.components.inventoryitem:IsWet()
	else
		moisture, iswet = TheWorld.state.wetness, TheWorld.state.iswet
	end
	local pos = inst:GetPosition()

	local gemshardNum = gemshardNumList[item.prefab] * count

	while gemshardNum > 0 do
		local loot = SpawnPrefab("ancientdreams_gemshard")
		local lootMaxStackSize = loot.components.stackable:StackSize()
		if gemshardNum >= lootMaxStackSize then
			loot.components.stackable:SetStackSize(lootMaxStackSize)
			loot.components.inventoryitem:InheritMoisture(moisture, iswet)
		else
			loot.components.stackable:SetStackSize(gemshardNum)
			loot.components.inventoryitem:InheritMoisture(moisture, iswet)
		end
		gemshardNum = gemshardNum - lootMaxStackSize
		GiveOrDropItem(loot, giver, inst, pos)
	end
end

local function OnGemsGiven(inst, giver, item, count)
	if count == nil then
		return
	end

	inst._crushingtask = inst:DoTaskInTime(28 * FRAMES, GiveGemshards, giver, item, count)
end

AddPrefabPostInit("turfcraftingstation", function(inst)
	if not TheWorld.ismastersim then
		return inst
	end
	if inst.components.trader == nil then
		local trader = inst:AddComponent("trader")
		trader:SetAcceptStacks()
		trader:SetAbleToAcceptTest(AbleToAcceptTest)
		trader:SetOnAccept(OnGemsGiven)
	else
		local oldabletoaccepttest = inst.components.trader.abletoaccepttest
		local oldonaccept = inst.components.trader.onaccept
		inst.components.trader:SetAbleToAcceptTest(function(inst, item, giver, count)
			local canAccept = AbleToAcceptTest(inst, item, giver, count)
			return canAccept or oldabletoaccepttest(inst, item, giver, count)
		end)
		inst.components.trader:SetOnAccept(function(inst, giver, item, count)
			if table.contains(gemList,item.prefab) then
				OnGemsGiven(inst, giver, item, count)
			else
				oldonaccept(inst, giver, item, count)
			end
		end)
	end
end)

AddPrefabPostInit("reskin_tool", function(inst)
	if inst.components.spellcaster then
		local oldcancastfn = inst.components.spellcaster.can_cast_fn
		inst.components.spellcaster.can_cast_fn = function(doer, target, pos)
			if target.prefab == "why_crystal_flowers" then
				return true
			else
				return oldcancastfn(doer, target, pos)
			end
		end
		local oldspell = inst.components.spellcaster.spell
		inst.components.spellcaster.spell = function(tool, target, pos, caster)
			if target and target.prefab == "why_crystal_flowers" then
				local fx = SpawnPrefab("explode_reskin")
				local fx_pos_x, fx_pos_y, fx_pos_z = target.Transform:GetWorldPosition()
				fx.Transform:SetPosition(fx_pos_x, fx_pos_y, fx_pos_z)
				if target.animname then
					local flower_num  = tonumber(string.sub(target.animname,7))
					if flower_num == 64 then
						return
					else
						flower_num = flower_num + 1
						if flower_num > 22 then
							flower_num = 1
						end
						local animname = "cryflo"..tostring(flower_num)
						target.animname = animname
						target.AnimState:PlayAnimation(target.animname)
					end
				end
			else
				return oldspell(tool, target, pos, caster)
			end
		end
	end
end)

AddComponentPostInit("meteorshower", function(self)

	if not TheWorld.ismastersim then
		return
	end

	local easing = require("easing")
	local _SpawnMeteor = self.SpawnMeteor

	function self:SpawnMeteor(mod)
		if math.random() <= 0.15 then
			--Randomize spawn point
			local x, y, z = self.inst.Transform:GetWorldPosition()
			local theta = math.random() * TWOPI
			-- Do some easing fanciness to make it less clustered around the spawner prefab
			local radius = easing.outSine(math.random(), math.random() * 7, TUNING.METEOR_SHOWER_SPAWN_RADIUS, 1)

			local map = TheWorld.Map
			local fan_offset = FindValidPositionByFan(theta, radius, 30,
				function(offset)
					return map:IsPassableAtPoint(x + offset.x, y + offset.y, z + offset.z)
				end)

			if fan_offset ~= nil then
				local met = SpawnPrefab("mineralmeteor")
				met.Transform:SetPosition(x + fan_offset.x, y + fan_offset.y, z + fan_offset.z)

				local peripheral = radius > TUNING.METEOR_SHOWER_SPAWN_RADIUS - TUNING.METEOR_SHOWER_CLEANUP_BUFFER
				if mod == nil then
					mod = 1
				end
				
				local cost = math.floor(1 / mod + .5)
				if (self.medium_remaining == nil or self.medium_remaining >= cost) then
					met:SetSize("medium", mod)
					if self.medium_remaining ~= nil then
						self.medium_remaining = self.medium_remaining - cost
					end
				end

				met:SetPeripheral(peripheral)

				return met
			end
		end

		return _SpawnMeteor(self, mod)
	end
end)

AddPrefabPostInit("cavein_boulder", function(inst)

	if not TheWorld.ismastersim then
		return
	end

	local chis = inst:AddComponent("chiselablerock")
	chis:SetMineralLoot("why_geo_fruit")

end)