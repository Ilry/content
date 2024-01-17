local function pair(tbl, fallback)
	setmetatable(tbl, {
		__index = fallback,
		__metatable = "Locked metatable"
	})
	for key, value in pairs(tbl) do
		if type(value) == "table" then
			pair(value, fallback[key])
		end
	end
end

local iconsfn = loadfile("scripts/language/icons.lua")
local englishfn = loadfile("scripts/language/english.lua")
local chinesefn = loadfile("scripts/language/chinese.lua")

function setup1()
	local english = englishfn()
	local icons = iconsfn()

	pair(icons, english)

	return icons
end

function setup2()
	local english = englishfn()
	local icons = iconsfn()
	local chinese = chinesefn()

	pair(icons, chinese)
	pair(chinese, english)

	return icons
end


local icons_lstr = setup2()
print(icons_lstr.bingo)
print(icons_lstr.test.wack)

print(icons_lstr.test.blah.mingo2)