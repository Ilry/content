name = "智能鹰眼"
description = [[
默认 F7 智能夜视, F8 看全图或切换大视野
Default F7 smart night vision, F8 to see the whole picture or switch the large field of view.

现在提示语句只会在本地出现, 其他玩家将不会发现房主使用了该模组 
Now the prompt sentence will only appear locally, and other players will not find that the host has used the mod.
]]

author = "呼吸"
version = "0.0.1"
forumthread = "/"
api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
all_clients_require_mod = false
client_only_mod = true
dst_compatible = true


local keys2 = {
	"F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11",
}

local keysF = {}
local keyslist_F = {}

for i=1, #keys2 do
	keyslist_F[i] = {description = keys2[i], data = i + 281}
	keysF[i] = i+281
end

configuration_options =
{
	{
		name = "cheat_nightversion",
        label = "NightVersion - 智能夜视",
        hover = "夜晚会自动开启, 白天会自动关闭",
        options = keyslist_F,
        default = keysF[7],
	},
    {
        name = "cheat_fullmap",
        label = "FullMap - 鹰眼全图",
        hover = "俯视全图地形,点击地图会自动走向目的地 的快捷键",
        options = keyslist_F,
        default = keysF[8],
    },
    {
        name = "cheat_tip",
        label = "ShowPrompt - 提示语句",
        hover = "是否显示提示语句",
        options = {
            {description = "OFF - 关闭", data = false},
            {description = "ON - 开启", data = true},
        },
        default = true,
    },
}