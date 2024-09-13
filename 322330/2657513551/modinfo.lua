local L = locale ~= "zh" and locale ~= "zhr"
name = L and "Don't Starve Alone" or "独行长路 - Don't Starve Alone"
forumthread = ""
version = "1.2.19"
description = L and 
[[
This mod can completely eliminate the lag of a server with cave.
It only works in single player world.

* Fix the bug that the mushroom farm in the cave stops growing.

]] or [[
辅助mod，完全消除单人联机洞穴档的延迟。

* 修复洞穴蘑菇农场生长停滞的bug。

]]
-- * 修复了洞穴重置倒计时异常的bug。
-- ]]

author = "老王天天写bug"
api_version = 6
api_version_dst = 10
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
dst_compatible = true

all_clients_require_mod = true
server_filter_tags = { }

priority = 1
icon_atlas = "modicon.xml"
icon = "modicon.tex"


configuration_options = {
	{
		name = "OPT",
		label = L and "Special optimization" or "特殊优化",
		hover = L and "Forced fixes for some issues, but may affect compatibility with other mods.\n(See mod introduction page for details)" or "强制修复一些问题，但可能会影响和其他mod的兼容性。\n（详见【独行长路】介绍页）",
		options = {
			{description = L and "On" or "开", data = true},
			{description = L and "Off" or "关", data = false},
		},
		default = true,
	},
	{
		name = "BAN_CLOUDSAVE",
		label = L and "Disable cloudsave limit (DANGEROUS)" or "云存档解限 (危险)",
		hover = L and "Allow to run this mod in the cloudsave. DANGEROUS, do not modify unless you know what you are doing." or "允许在云存档中运行本mod。\n危险项目，请勿随意修改。\n危险项目，请勿随意修改。\n危险项目，请勿随意修改。\n",
		options = {
			{description = L and "Default" or "默认", data = 0},
			{description = L and "Click again to confirm" or "再点击一次以确认", data = 1},
			{description = L and "On" or "开", data = 2},
		},
		default = 0,
	}
}