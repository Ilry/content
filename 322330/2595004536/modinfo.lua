name =
[[WagstaffToolInfo
]]
description =
[[Have trouble collecting Restrained Statics?
Be tired of figure out every tool' name?
This mod will help you.
This is a client mod.When Wagstaff need a tool, its' picture will appear above him.
(This mod show tools' picture depending on what Wagstaff says in server.I only write down words which are in English or in Simplified-Chinese.If your server has different translation, you can add content into 
scripts/Wgtscripts/Wagstaff_tool_strings.lua. Or you can feedback to me in workshop)
]]
author = "WinderBear"
version = "1.1.3"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = false
client_only_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

--[[
local KEY_A = 65
local keyslist = {}
local string = "" --modified from gesture wheel
for i = 1, 26 do
	local ch = string.char(KEY_A + i - 1)
	keyslist[i] = {description = ch, data = ch}
end
]]
configuration_options =
{
    {
        name = "ToolInfo",
        label = "ToolInfo",
        options =   {
                        {description = "On", data = true, hover = "the image of the tool Wagstaff wants will appear above him"},
                        {description = "Off", data = false, hover = "the image of the tool Wagstaff wants will NOT appear above him"},
                    },
        default = true,
    },
    {
        name = "ToolMark",
        label = "ToolMark",
        options =   {
                        {description = "On", data = true, hover = "a arrow will point to tools lying on the ground"},
                        {description = "Off", data = false, hover = "NO arrow will point to tools lying on the ground"},
                    },
        default = true,
    },
    {
        name = "ArrowColour",
        label = "ArrowColour",
        options =   {
                        {description = "White", data = {255, 255, 255}},
                        {description = "purple", data = {119, 47, 173}},
                        {description = "Orange", data = {245, 199, 91}},
                        {description = "Aquamarine", data = {118, 245, 161}},
                        {description = "Blue", data = {115, 154, 245}},
                        {description = "OliveGreen", data = {218, 245, 106}},
                        {description = "grey", data = {190, 190, 190}},
                        {description = "violet", data = {238, 130, 238}},
                        {description = "lavender", data = {230, 230, 250}},
        },
        default = {255,255,255},
    },
}
