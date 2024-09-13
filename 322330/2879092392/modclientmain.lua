PrefabFiles = {"wonderwhy_none"}
Assets = {
    Asset( "IMAGE", "images/inventoryimages/whyehat.tex"),
    Asset( "ATLAS", "images/inventoryimages/whyehat.xml"),
    Asset( "IMAGE", "images/inventoryimages/whycrank.tex"),
    Asset( "ATLAS", "images/inventoryimages/whycrank.xml"),
    Asset( "IMAGE", "images/inventoryimages/whyearmor_incomplete.tex"),
    Asset( "ATLAS", "images/inventoryimages/whyearmor_incomplete.xml"),
    Asset( "IMAGE", "images/inventoryimages/why_refined_redgem.tex"),
    Asset( "ATLAS", "images/inventoryimages/why_refined_redgem.xml"),
    Asset( "IMAGE", "bigportraits/wonderwhy.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy.xml" ),
    Asset( "IMAGE", "images/saveslot_portraits/wonderwhy.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/wonderwhy.xml" ),
    Asset( "IMAGE", "images/names_gold_wonderwhy.tex" ),
    Asset( "ATLAS", "images/names_gold_wonderwhy.xml" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_none.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_none.xml" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_elder.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_elder.xml" ),
    Asset( "IMAGE", "bigportraits/wonderwhy_demon.tex" ),
    Asset( "ATLAS", "bigportraits/wonderwhy_demon.xml" ),}
--
local STRINGS = GLOBAL.STRINGS
STRINGS.CHARACTER_SURVIVABILITY.wonderwhy= "Laughable"
STRINGS.NAMES.WONDERWHY = "Why"
STRINGS.CHARACTER_QUOTES.wonderwhy = "\"Why? I wonder why?\""
STRINGS.CHARACTER_TITLES.wonderwhy = "The Ancient Memory"
STRINGS.CHARACTER_NAMES.wonderwhy = "Why"
STRINGS.CHARACTER_DESCRIPTIONS.wonderwhy = "*Mind is their core\n*Discovers Ancient knowledge\n*Fragile\n*Bad sight"
STRINGS.CHARACTER_ABOUTME.wonderwhy = "Wonder Why was the main engineer of the ancients, living once among the forgotten civilization, now a husk seeking an answer."
STRINGS.CHARACTER_BIOS.wonderwhy = {
		{ title = "Birthday", desc = "August 16" },
		{ title = "Favorite Food", desc = "Glow Berry" },
		{ title = "Decayed Guardian", desc = "Wonder or Why, the ancient memory. They were the main engineer of the ancients, living among the forgotten civilization. The ancients fled to the moon, while they remained hoping for the ancient emperor to return someday. Using an ancient mask, Wonder put themselves to sleep while their body decayed away. Awaken now by a strange shockwave of lunar energy, Wonder needs to rebuild themselves, go find the relics of their past and most important - survive."}}
--
TUNING.WONDERWHY_SANITY = 80
TUNING.WONDERWHY_HUNGER = 120
TUNING.WONDERWHY_HEALTH = 6
--
local skin_modes = {
{ type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.66, 
        offset = { 0, -25 }},}
--
GLOBAL.PREFAB_SKINS["wonderwhy"] = { "wonderwhy_none",}
GLOBAL.PREFAB_SKINS_IDS["wonderwhy"] = {["wonderwhy_none"] = 1} 
--
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.WONDERWHY = {("whyehat"), ("whyearmor_incomplete"), ("why_refined_redgem")}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["whyehat"] = {
    atlas = "images/inventoryimages/whyehat.xml",
    image = "whyehat.tex",}
--TUNING.STARTING_ITEM_IMAGE_OVERRIDE["whycrank"] = {
--    atlas = "images/inventoryimages/whycrank.xml",
--    image = "whycrank.tex",}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["whyearmor_incomplete"] = {
    atlas = "images/inventoryimages/whyearmor_incomplete.xml",
    image = "whyearmor_incomplete.tex",}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["why_refined_redgem"] = {
    atlas = "images/inventoryimages/why_refined_redgem.xml",
    image = "why_refined_redgem.tex",}
AddModCharacter("wonderwhy", "PLURAL", skin_modes)
modimport("scripts/modstrings.lua")