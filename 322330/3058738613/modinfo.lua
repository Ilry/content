name = "server mod assistant"
description = [[
	功能：
	1、记录已启用的服务器模组和其设置为模组预设。
	2、显示模组预设中使用的模组，会检查其设置数据合理性。
	3、导出模组预设为modoverrides.lua

	【更新当前预设】：【更新】后，会把当前启用的服务器mod和其当前设置数据记录下来。故改名字前，先应用该预设。
	【导出模组预设】：将导出到..\Steam\steamapps\common\Don't Starve Together\data文件夹下。

	模组预设存储在..\DoNotStarveTogether\xxxx\client_save\world_presets文件夹下，
	模组预设名字前缀是“ModsPresets_CUSTOM_”，其他前缀是世界设置预设。

	..\DoNotStarveTogether\xxxx\client_save\PRESETS_DATA_FILE是模组预设列表文件，记录模组预设文件。
]]

author = "月"

version = "1.0.5"

api_version = 10

dst_compatible = true
all_clients_require_mod = false
client_only_mod = true

icon_atlas = "servermoduleassistant.xml"
icon = "servermoduleassistant.tex"

forumthread = ""

configuration_options =
{
}