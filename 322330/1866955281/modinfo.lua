name = "垃圾桶"
author = "白茶"
version = "1.0.0"
description = "版本：" .. version .. [[，默认配置：
炼金引擎 摧毁物品
暗影操纵器 摧毁物品并打扫地面（全图）同种物品
蕨类盆栽 摧毁物品并打扫地面4格地皮内同种物品

鼠标右键（或左键）打开对应建筑，将需要清理的物品放入上述建筑点击按钮即可
特殊物品无法放入格子，例如远古钥匙，天体宝球、泰拉瑞亚等
注意：打扫是指任何地面上直接可见的物品，堆叠物品也会清理

需要自定义绑定建筑和修改范围直接修改modoverrides.lua
销毁物品建筑["researchlab2"]
全图打扫建筑["researchlab3"]	全图清理多世界运行["researchlab3multi"]
范围打扫建筑["pottedfern"]		范围清理范围["pottedfernrange"]  

例如全图清理建筑改为避雷针["researchlab3"]="lightning_rod"
警告：手动配置modoverrides.lua请慎重操作，否则可能会当场去世！！！
]]
forumthread = ""
api_version_dst = 10

icon_atlas = "modicon.xml"
icon = "modicon.tex"

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true


configuration_options =
{
	{
		name = "researchlab2",
		label = "销毁物品",
		hover = "需要自定义请修改[\"researchlab2\"]=\"researchlab2\"",
		options = {
			{ description = "researchlab2", data = "researchlab2", hover = "[默认]炼金引擎(建造二本)" },
			{ description = "nil", data = "nil", hover = "关闭" },
		},
		default = "researchlab2",
	},
	{
		name = "researchlab3",
		label = "全图清理",
		hover = "需要自定义请修改[\"researchlab3\"]=\"researchlab3\"",
		options = {
			{ description = "researchlab3", data = "researchlab3", hover = "[默认]暗影操纵器(魔法二本)" },
			{ description = "nil", data = "nil", hover = "关闭" },
		},
		default = "researchlab3",
	},
	{
		name = "researchlab3multi",
		label = "全图清理 多世界运行",
		hover = "对所有的连接的世界运行全图清理",
		options = {
			{ description = "true", data = "true", hover = "开启" },
			{ description = "nil", data = "nil", hover = "[默认]关闭" },
		},
		default = "nil",
	},
	{
		name = "pottedfern",
		label = "范围清理",
		hover = "需要自定义请修改[\"pottedfern\"]=\"pottedfern\"",
		options = {
			{ description = "pottedfern", data = "pottedfern", hover = "[默认]蕨类盆栽" },
			{ description = "nil", data = "nil", hover = "关闭" },
		},
		default = "pottedfern",
	},
	{
		name = "pottedfernrange",
		label = "范围清理",
		hover = "需要自定义请修改[\"pottedfernrange\"]=\"16\"",
		options = {
			{ description = "16", data = "16", hover = "[默认]16(4个地皮)" },
		},
		default = "16",
	}
}
