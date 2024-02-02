-- 名称
name = "大树荫范围 (Big shade range)"
-- 描述
description = [[将“高出平均值的树干”的树荫遮蔽范围扩大
Expand the shade range of "Above-Average Tree Trunk"
可选1.5倍、2倍、3倍
Optional 1.5 times, 2 times, 3 times
-------------------
新增可修改“大树干”范围
Added the ability to modify the "Great Tree Trunk" range
可选1.5倍、2倍、2.5倍
Optional 1.5 times, 2 times, 2.5 times
]]
-- 作者
author = "polariszy"
-- 版本
version = "0.2"
-- klei官方论坛地址，为空则默认是工坊的地址
forumthread = ""
-- modicon 下一篇再介绍怎么创建的
icon_atlas = "images/modicon.xml"
icon = "modicon.tex"
-- dst兼容
dst_compatible = true
-- 是否是客户端mod
client_only_mod = false
-- 是否是所有客户端都需要安装
-- all_clients_require_mod = true
-- 饥荒api版本，固定填10


all_clients_require_mod = false

reign_of_giants_compatible = true
api_version = 10

configuration_options = {
	{
		name = "超出平均值的树干(Above-Average Tree Trunk)",             -- 配置项名换，在modmain.lua里获取配置值时要用到
		hover = "遮蔽范围倍率",        			-- 鼠标移到配置项上时所显示的信息
		options = {
			{                    				-- 配置项目可选项
				description = "默认",        -- 可选项上显示的内容
				--hover = "默认遮蔽范围22格",    -- 鼠标移动到可选项上显示的信息
				data = 22                  	-- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
			}, 
			{
				description = "1.5倍",
				--hover = "遮蔽范围33",
				data = 33
			}, 
			{
				description = "2倍",
				--hover = "遮蔽范围44",
				data = 44
			}, 
			{
				description = "3倍",
				--hover = "遮蔽范围66",
				data = 66
			}, 
		},
			default = 22	-- 默认值，与可选项里的值匹配作为默认值
	}, 	
	
	----------------------------------
	{
		name = "大树干(Great Tree Trunk)",             -- 配置项名换，在modmain.lua里获取配置值时要用到
		hover = "遮蔽范围倍率",        			-- 鼠标移到配置项上时所显示的信息
		options = {
			{                    				-- 配置项目可选项
				description = "默认",        -- 可选项上显示的内容
				--hover = "默认遮蔽范围22格",    -- 鼠标移动到可选项上显示的信息
				data = 28                  	-- 可选项选中时的值，在modmain.lua里获取到的值就是这个数据，类型可以为整形，布尔，浮点，字符串
			}, 
			{
				description = "1.5倍",
				--hover = "遮蔽范围42",
				data = 42
			}, 
			{
				description = "2倍",
				--hover = "遮蔽范围56",
				data = 56
			}, 
			{
				description = "2.5倍",
				--hover = "遮蔽范围70",
				data = 70
			}, 
		},
			default = 28	-- 默认值，与可选项里的值匹配作为默认值
	}
}
