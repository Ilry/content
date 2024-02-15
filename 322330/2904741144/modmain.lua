Assets = {
	Asset("ANIM", "anim/spider_build.zip"),
	Asset("ANIM", "anim/spider_wolf_build.zip"),
	Asset("ANIM", "anim/spider_warrior_build.zip"),
	Asset("ANIM", "anim/spider_queen_2.zip"),
	Asset("ANIM", "anim/spider_queen_build.zip"),
	Asset("ANIM", "anim/spider_white.zip"),
	Asset("ANIM", "anim/spider_water.zip"),
	Asset("ANIM", "anim/spider_water_water.zip"),
	Asset("ANIM", "anim/DS_spider_cannon.zip"),
	Asset("ANIM", "anim/DS_spider_caves.zip"),
	Asset("ANIM", "anim/DS_spider2_caves.zip"),
	Asset("ANIM", "anim/DS_spider_moon.zip"),
	Asset("ANIM", "anim/hat_spider.zip"),
	Asset("ANIM", "anim/silk.zip"),
	Asset("ANIM", "anim/spider_cocoon.zip"),
	Asset("ANIM", "anim/spider_egg_sac.zip"),
	Asset("ANIM", "anim/spider_gland.zip"),
	Asset("ANIM", "anim/spider_mound.zip"),
	Asset("ANIM", "anim/spider_mound_mutated.zip"),

	Asset("ATLAS", "images/spiders.xml"),  
	Asset("IMAGE", "images/spiders.tex"), 	
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH 
SpawnPrefab = GLOBAL.SpawnPrefab
-------- SPIDERs 
GLOBAL.STRINGS.NAMES.SPIDER = "Spussy Cat"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER = "Look like spiders but they're not. Their name is spus."
GLOBAL.STRINGS.NAMES.SPIDER_WARRIOR = "Warrior Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_WARRIOR = "This cat is more aggressive than those around."
GLOBAL.STRINGS.NAMES.SPIDERQUEEN = "Spussy Queen"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDERQUEEN = "She's a huge puff of fur."
GLOBAL.STRINGS.NAMES.SPIDER_DROPPER = "Dangling White Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_DROPPER = "The darkness has drained the color from their fur."
GLOBAL.STRINGS.NAMES.SPIDER_HIDER = "Cave Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_HIDER = "I don't want to ruin their pots."
GLOBAL.STRINGS.NAMES.SPIDER_SPITTER = "Spitter Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_SPITTER = "They spitted in my face!"
GLOBAL.STRINGS.NAMES.SPIDER_MOON = "Shattered Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_MOON = "Is this cat made of rock?"
GLOBAL.STRINGS.NAMES.SPIDER_HEALER = "Nurse Spussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_HEALER = "They heal the queen and allies around."
GLOBAL.STRINGS.NAMES.SPIDER_WATER = "Seapussy"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDER_WATER = "These cats have gotten those long legs!!"
-------- ITEMs
GLOBAL.STRINGS.NAMES.SILK = "Fur Ball"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SILK = "A ball of fur they played with."
GLOBAL.STRINGS.NAMES.SPIDERGLAND = "Cat Gland"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDERGLAND = "Ew wherever it comes from."
GLOBAL.STRINGS.NAMES.SPIDEREGGSACK = "Spussy Egg"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDEREGGSACK = "Maybe I can place it somewhere."
GLOBAL.STRINGS.NAMES.SPIDERHAT = "Spussy Hat"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SPIDERHAT = "I chopped her head off! Now who's the queen!"
-------- STRUCTUREs (not able)

local Kitties = {
    "silk", "spider", "spider_dropper", "spider_healer", "spider_hider", "spider_moon", "spider_spitter", "spider_warrior", "spider_water", "spidereggsack", "spidergland", "spiderhat",
}

local TextureReplace = {}

for k, v in pairs(Kitties) do
    TextureReplace[v .. ".tex"] = {
        GLOBAL.resolvefilepath("images/spiders.xml"), v .. ".tex",
    }
end

local Image = GLOBAL.require('widgets/image')

local SetTexture_old = Image.SetTexture

local function SetTexture_new(self, atlas, tex, ...)
    local replace = TextureReplace[tex]

    if not replace then
        SetTexture_old(self, atlas, tex, ...)
        return
    end

    SetTexture_old(self, replace[1] or atlas, replace[2] or tex, ...)
end

Image.SetTexture = SetTexture_new