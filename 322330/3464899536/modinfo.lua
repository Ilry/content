
name = "[DST]Cookpot Fire"
author = "你要帮帮威吊"
version = "0.0.2"
local info_version = "[ Version "..version.." ]\n"
description = info_version..[[
Let your cookpot produce flames at the bottom while cooking!
]]

if locale  == "zh" or locale == "zht" or locale == "zhr" then
    name = "[DST]灶火"
    description = info_version..[[
让你的锅在烹饪料理时，底部产生火焰！
]]
end

forumthread = ""
api_version = 10

all_clients_require_mod = true
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
client_only_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"
