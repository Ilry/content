locale = "xd"
translations = {
	en = {
		duck = "en duck2",
		animal = {
			dog = "en dog2",
			mammal = {
				human = "en human2"
			}
		},
	},
	xd = {
		duck = "xd duck2",
		animal = {
			dog = "xd dog2",
			mammal = {
				human = "xd human2"
			}
		},
	},
}

--[[
local function T(x) -- Translate
	if not locale then
		return translations.en[x]
	end

	return ("" .. translations[locale][x]) or translations["en"][x] or ("![" .. locale .. "] @ " .. x)
end

--]]

local function T(x) -- Translate
	local current = (locale and translations[locale]) or translations.en
	local backup = translations.en

	for field in string.gmatch(x, "[^.]+") do
		current = current[field]
		backup = backup[field]
	
		if not current then
			current = backup -- this could also be just "break", but that would cause translation to return a table if it was in the middle of a chain. this allows us to resort to the backup and keep going
			if not backup then
				-- NOW we abort
				break
			end
		end
	end

	if not current and not backup then
		-- unable to find ANY translation
		return ("!ERROR[" .. locale .. "] @ " .. x)
	end

	return current or backup
end


print("duck", T"duck")
print("dog", T"animal.dog")
print("human", T"animal.mammal.human")

return "a", "b", "c"