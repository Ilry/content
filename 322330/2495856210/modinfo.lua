name = "Starfish / 海星"

description =
	[[
Starfish will not bite the players, and you can change its reset time and trap radius. /
海星不会攻击站在上面的玩家，可以修改海星的重置时间和攻击的目标范围。
]]

author = "asingingbird"

version = "2.1"

dst_compatible = true

all_clients_require_mod = false

api_version = 6

api_version_dst = 10

forumthread = ""

icon_atlas = "modicon.xml"

icon = "modicon.tex"

configuration_options = {
	{
		name = "does_not_bite_players",
		label = "Does Not Bite Players / 不攻击玩家",
		hover = "Starfish Does Not Bite Players / 海星不攻击玩家",
		options = {
			{description = "No / 攻击玩家", data = false},
			{description = "Yes / 不攻击玩家", data = true}
		},
		default = true
	},
	{
		name = "reset_time",
		label = "Trap Reset Time / 重置时间",
		hover = "Time To Activate After Planted / 种下海星后陷阱启动的时间",
		options = {
			{description = "0", data = 0},
			{description = "10", data = 10},
			{description = "30", data = 30},
			{description = "60 (Default / 默认)", data = 60},
			{description = "100", data = 100},
			{description = "120", data = 120}
		},
		default = 60
	},
	{
		name = "trap_radius",
		label = "Trap Radius / 目标范围",
		hover = "Trap Radius To Detect A Target / 海星寻找攻击目标的范围",
		options = {
			{description = "1", data = 1},
			{description = "1.4 (Default / 默认)", data = 1.4},
			{description = "2", data = 2},
			{description = "3", data = 3}
		},
		default = 1.4
	},
	{
		name = "invincible",
		label = "Invincible / 无敌",
		hover = "Cannot Be Destroyed (dug up) By Monsters / 不会被Boss拔起",
		options = {
			{description = "No / 关闭", data = false},
			{description = "Yes / 开启", data = true}
		},
		default = false
	}
}
