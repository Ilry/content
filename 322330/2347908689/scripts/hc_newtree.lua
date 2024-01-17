
local _G = GLOBAL
local require = _G.require

local TechTree = require("techtree")

table.insert(TechTree.AVAILABLE_TECH, "HCLR_TECHTREE")

TechTree.Create = function(t)
	t = t or {}
	for i, v in ipairs(TechTree.AVAILABLE_TECH) do
	    t[v] = t[v] or 0
	end
	return t
end---------------------------------------------------

_G.TECH.NONE.HCLR_TECHTREE = 0
_G.TECH.HCLR_TECHTREE_ONE = { HCLR_TECHTREE = 1 }
_G.TECH.HCLR_TECHTREE_TWO = { HCLR_TECHTREE = 2 }

for k,v in pairs(TUNING.PROTOTYPER_TREES) do
    v.HCLR_TECHTREE = 0
end

TUNING.PROTOTYPER_TREES.HCLR_TECHTREE_ONE = TechTree.Create({
    HCLR_TECHTREE = 1,
})
TUNING.PROTOTYPER_TREES.HCLR_TECHTREE_TWO = TechTree.Create({
    HCLR_TECHTREE = 2,
})

for i, v in pairs(_G.AllRecipes) do
	if v.level.HCLR_TECHTREE == nil then
		v.level.HCLR_TECHTREE = 0
	end
end