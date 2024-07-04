--Beta, Final, or leave for no name
versiontype = ""
name = "True Stack Size (Fixed)"

author = "Cliffford W."

version = "2.0.1"

config = false
Language = "en"

contributors = "jimmybaxter, Darque_Flux"
write_contributors = true
credits_only = false

main_icon = "modicon"

priority = 0

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true
client_only_mod = false
server_only_mod = false

local scales = {}

for i = 1, 20 do
	scales[i] = { description = "x" .. i / 10, data = i / 10 }
end

local pos = {
	[1] = { description = "Default", data = 0 },
}

for i = 2, 15 do
	pos[i] = { description = "+" .. i .. "0", data = i * 10 }
end

local opt_Empty = { { description = "", data = 0 } }
local function Title(title, hover)
	return {
		name = title,
		hover = hover,
		options = opt_Empty,
		default = 0,
	}
end

local SEPARATOR = Title("")

modinfo_ver = "2.0"
if config == true then
	--Config
	configuration_options = {



		Title("󰀔 Mod Version" .. ":" .. " " .. version),
		Title("󰀩 Modinfo Version:" .. " " .. modinfo_ver),
	}
end

icon_atlas = main_icon .. ".xml"
icon = main_icon .. ".tex"

versiontypes = {
	final = "[Final]",
	beta = "[Beta]",
	disc = "[Discontinued]",
	redux = "[Redux]",
}
versiontype = versiontypes[versiontype] or ""

modinfo_ver = modinfo_ver

if versiontype == "" then
	name = name
else
	name = name .. " \n" .. versiontype .. ""
end

folder_name = folder_name or "workshop-"
if not folder_name:find("workshop-") then
	name = name .. " - GitHub Ver."
end

old_author = author
if contributors == "" or contributors == nil then
	author = author
elseif write_contributors == true then
	author = author .. " and " .. " " .. contributors
end

if Language == "en" or Language == nil or Language == "" then
	--Description Components
	desc = [[
Shows real big boy stack sizes instead of measly 999+. Fixed version. Original creator is jimmybaxter. Code help from Darque_Flux]]

	changelog = [[󰀏 What's New:

󰀈 Fixed Release

]]

	--copyright = "Copyright © 2020 "..old_author
	credits = "󰀭 Credits:" .. " " .. contributors
	mark2 = "󰀩 Modinfo Version:" .. " " .. modinfo_ver
end

if write_contributors == true or credits_only == true and contributors ~= "" then
	descfill = desc .. "\n\n󰀝 Mod Version: " .. version .. "\n" .. changelog .. "\n\n" .. credits .. "\n\n" .. mark2
elseif
	write_contributors == false
	or write_contributors == nil
	or credits_only == false
	or credits_only == nil and contributors == nil
	or contributors == ""
then
	descfill = desc .. "\n\n" .. changelog .. "\n 󰀝  Version:" .. " " .. version .. "\n\n" .. mark2
end

description = descfill
description = description
