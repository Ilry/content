-- https://github.com/penguin0616/Insight/pull/29/files
-- Needed to convert the modinfo translations to the new V3 format.

local fn = loadfile("from.lua")
local old_modinfo = {}
setfenv(fn, old_modinfo)
fn()

local fn = loadfile("modinfo.lua")
local modinfo = {}
setfenv(fn, modinfo)
fn()

local f = io.open("modinfo.lua")
local modinfo_src = f:read("*a")
f:close()

local languages = old_modinfo.translations
--local old_configuration_options = modinfo.configuration_options
local configuration_options = modinfo.configuration_options

loadfile("dumper.lua")()

--[[
a, b = modinfo_src:find(
	'["zh"] = "Fertilizer"',
1, true)

print(a, b, modinfo_src:sub(a, b))
--]]

for i,v in pairs(configuration_options) do
	if v.name and modinfo.STRINGS[v.name] and languages.zh[v.name] then
		--modinfo.STRINGS[v.name].label.zh = languages.zh[v.name].LABEL
		modinfo_src, count = modinfo_src:gsub(
			--string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].label.zh),
			string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].label.zh):gsub("%[", "%%["):gsub("%]", "%%]"),
			string.format( '["zh"] = "%s"', languages.zh[v.name].LABEL)
		)
		--print(count, string.format( '%%["zh"%%] = "%s"', modinfo.STRINGS[v.name].label.zh))
		modinfo_src, count = modinfo_src:gsub(
			--string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].label.zh),
			string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].hover.zh):gsub("%[", "%%["):gsub("%]", "%%]"),
			string.format( '["zh"] = "%s"', languages.zh[v.name].HOVER)
		)
		--modinfo.STRINGS[v.name].hover.zh = languages.zh[v.name].HOVER

		for j, k in pairs(v.options) do
			local data = tostring(k.data)
			--print(data, languages.zh[v.name].OPTIONS[data])
			if languages.zh[v.name].OPTIONS[tostring(k.data)] then
				--modinfo.STRINGS[v.name].options[k.data].description.zh = languages.zh[v.name].OPTIONS[tostring(k.data)].DESCRIPTION
				modinfo_src, count = modinfo_src:gsub(
					--string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].label.zh),
					string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].options[k.data].description.zh):gsub("%[", "%%["):gsub("%]", "%%]"),
					string.format( '["zh"] = "%s"', languages.zh[v.name].OPTIONS[tostring(k.data)].DESCRIPTION)
				)
				--modinfo.STRINGS[v.name].options[k.data].hover.zh = languages.zh[v.name].OPTIONS[tostring(k.data)].HOVER
				modinfo_src, count = modinfo_src:gsub(
					--string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].label.zh),
					string.format( '["zh"] = "%s"', modinfo.STRINGS[v.name].options[k.data].hover.zh):gsub("%[", "%%["):gsub("%]", "%%]"),
					string.format( '["zh"] = "%s"', languages.zh[v.name].OPTIONS[tostring(k.data)].HOVER)
				)
			else
				print("missing option", v.name, k.data)
			end
		end
	elseif v.name then
		print("missing", v.name)
	end
end

local f = io.open("./new.lua", "w")
f:write(modinfo_src)
f:close()