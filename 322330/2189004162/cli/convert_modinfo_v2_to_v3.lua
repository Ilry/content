local fn = loadfile("old_clunky_modinfo.lua")
local modinfo = {}
setfenv(fn, modinfo)
fn()


local languages = modinfo.translations
languages.ch = nil
languages.mex = nil
local configuration_options = modinfo.configuration_options

local outdata = "local STRINGS = {\n"

function langpairs(tbl)
	return function(tbl2, key)
		--print("@@@@@@@@@", tbl, tbl2, key)
		if key == nil then
			return "en", languages.en

		elseif key == "en" then
			return "zh", languages.zh

		elseif key == "zh" then
			return "es", languages.es

		elseif key == "es" then
			return "br", languages.br

		elseif key == "br" then
			return nil

		end
	end, tbl, nil
end

function MakeLanguageItem(lang, _str)
	local str = tostring(_str)
	str = str:gsub("\n", "\\n")

	local value = (_str == nil and "nil") or string.format("%q", str)

	local res
	if lang == "en" then
		res = value
	else
		res = string.format("[%q] = %s", lang, value)
	end

	res = res:gsub("\\\\n", "\\n")
	
	return res
end

function FixData(data)
	if data == "true" then
		return true
	elseif data == "false" then
		return false
	elseif tonumber(data) then
		return tonumber(data)
	else
		return data
	end
end




depth = 1


outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"
outdata = outdata .. string.rep("\t", depth) .. string.format("--[[ %s ]]\n", "Misc Strings")
outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"

local misc_things = {"ds_not_enabled", "update_info", "update_info_ds", "crashreporter_info", "mod_explanation", "config_paths", "config_disclaimer", "version", "latest_update", "undefined", "undefined_description"}

for i,v in pairs(misc_things) do
	outdata = outdata .. string.rep("\t", 1) .. string.format("%s = {\n", v)
	for langid, strs in langpairs(languages) do
		outdata = outdata .. string.rep("\t", 2) .. string.format("%s,\n", MakeLanguageItem(langid, strs[v]))
	end
	outdata = outdata .. string.rep("\t", 1) .. string.format("},\n", v)
end




outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"
outdata = outdata .. string.rep("\t", depth) .. string.format("--[[ %s ]]\n", "Section Titles")
outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"

-- Write Section Titles
for i,v in ipairs(configuration_options) do
	-- Write the config name key
	
	
	if v._ then
		outdata = outdata .. string.rep("\t", depth) .. string.format("%s = {\n", v._.label)
		for langid, strs in langpairs(languages) do
			--print("ITER", langid, strs)
			local this = strs[v._.label]
			outdata = outdata .. string.rep("\t", depth + 1) .. string.format("%s,\n", MakeLanguageItem(langid, this))
		end
		outdata = outdata .. string.rep("\t", depth) .. "},\n"
	end
end


outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"
outdata = outdata .. string.rep("\t", depth) .. string.format("--[[ %s ]]\n", "Configuration Options")
outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("=", 90) .. "\n"


for i,v in ipairs(configuration_options) do
	-- Write the config name key
	if v._ then
		outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("~", 90) .. "\n"
		outdata = outdata .. string.rep("\t", depth) .. string.format("--[[ %s ]]\n", languages["en"][v._.label])
		outdata = outdata .. string.rep("\t", depth) .. "--" .. string.rep("~", 90) .. "\n"
		--[[
		outdata = outdata .. string.rep("\t", depth) .. string.format("%s = {\n", v._.label)
		for langid, strs in langpairs(languages) do
			--print("ITER", langid, strs)
			local this = strs[v._.label]
			outdata = outdata .. string.rep("\t", depth + 1) .. string.format("%s,\n", MakeLanguageItem(langid, this))
		end
		outdata = outdata .. string.rep("\t", depth) .. "},\n"
		--]]
	else
		-- Open the config section
		outdata = outdata .. string.rep("\t", depth) .. string.format("%s = {\n", v.name)
		
		-- Write each field in the config data
		local labels, hovers = {}, {}
		for langid, strs in langpairs(languages) do
			local this = strs[v.name]
			table.insert(labels, string.rep("\t", depth + 2) .. MakeLanguageItem(langid, this.LABEL))
			table.insert(hovers, string.rep("\t", depth + 2) .. MakeLanguageItem(langid, this.HOVER))
		end

		
		local options = {}
		for _, op in ipairs(v.options) do
			-- Option entry
			local optstr = "" .. string.rep("\t", depth + 2) .. string.format("[" .. (type(op.data)=="string" and "%q" or "%s") .."] = {\n", tostring(op.data))

			-- Write Description section
			optstr = optstr .. string.rep("\t", depth + 3) .. string.format("description = {\n")
			for langid, strs in langpairs(languages) do
				local this = strs[v.name]
				local r = this.OPTIONS[tostring(op.data)]
				if not r then
					print(v.name, langid, op.data)
				end
				optstr = optstr .. string.rep("\t", depth + 4) .. string.format("%s,\n", MakeLanguageItem(langid, r.DESCRIPTION))
			end
			optstr = optstr .. string.rep("\t", depth + 3) .. string.format("},\n")

			-- Write Hover section
			optstr = optstr .. string.rep("\t", depth + 3) .. string.format("hover = {\n")
			for langid, strs in langpairs(languages) do
				local this = strs[v.name]
				local r = this.OPTIONS[tostring(op.data)]
				if not r then
					print(v.name, langid, op.data)
				end
				optstr = optstr .. string.rep("\t", depth + 4) .. string.format("%s,\n", MakeLanguageItem(langid, r.HOVER ))
			end
			optstr = optstr .. string.rep("\t", depth + 3) .. string.format("},\n")

			optstr = optstr .. string.rep("\t", depth + 2) .. string.format("},\n")

			--table.foreach(this.OPTIONS[tostring(op.data)], print)
			--optstr = optstr .. string.rep("\t", depth + 3) .. string.format("%s,\n", MakeLanguageItem(langid, this.OPTIONS[tostring(op.data)].DESCRIPTION))
			
			table.insert(options, optstr)
		end
		

		--print'----------------------------------------------------------------------'

		-- Write the label section
		outdata = outdata .. string.rep("\t", depth + 1) .. string.format("label = {\n%s\n", table.concat(labels, ", \n"))
		outdata = outdata .. string.rep("\t", depth + 1) .. "},\n"
		-- Write the hover section
		outdata = outdata .. string.rep("\t", depth + 1) .. string.format("hover = {\n%s\n", table.concat(hovers, ", \n"))
		outdata = outdata .. string.rep("\t", depth + 1) .. "},\n"
		-- Write the options section
		--outdata = outdata .. string.rep("\t", depth + 1) .. string.format("options = {\n%s\n", table.concat(options, ", \n"))
		outdata = outdata .. string.rep("\t", depth + 1) .. string.format("options = {\n%s", table.concat(options, ""))
		outdata = outdata .. string.rep("\t", depth + 1) .. "},\n"
		-- Close the config section
		outdata = outdata .. string.rep("\t", depth) .. "},\n"
	end
end

outdata = outdata .. "}\n"


local file = io.open("modinfo2.lua", "w")
file:write(outdata)
file:close()
