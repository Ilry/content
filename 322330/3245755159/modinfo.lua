name = "荒漠治理计划"
description = "当玩家在蚁狮荒漠铺上青草地皮并且在上面种上树时  将会提供一格地皮的防沙效果"
author = "不打架的咕咕"
version = "1.2"
forumthread = ""

-- This specifies that the mod does not require tuning.
api_version = 10
priority = 0

-- Compatibility
dont_starve_compatible = false
reign_of_giants_compatible = false
dst_compatible = true
shipwrecked_compatible = false
hamlet_compatible = false
client_only_mod = false
all_clients_require_mod = true

-- 配置表
configuration_options =
{
    {
        name = "option1",
        label = "沙漠范围",
        hover = "遮蔽沙尘暴范围",
        options = {
            {description = "0.5", data = 0.5},
            {description = "0.6", data = 0.6},
            {description = "0.7", data = 0.7},
            {description = "0.8", data = 0.8},
            {description = "0.9", data = 0.9},
            {description = "1", data = 1},
        },
        default = 1,
    }
}