name ="wx78 24"
description =
[[

]]
author = "原作者勿言"
version = "1"

forumthread = ""

api_version = 10

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {}

configuration_options =
{
    {
        name = "BEE_TICKPERIOD",
        label = "豆增压电路触发频率：",
        options = 
        {
            {description = "1秒", data = 1},
            {description = "2秒", data = 2},
            {description = "5秒", data = 5},
            {description = "15秒", data = 15},
            {description = "30秒", data = 30},
            {description = "60秒", data = 60},
        },
        default = 60,
    },
    {
        name = "BEE_HEALTHPERTICK",
        label = "豆增压电路每次回复血量：",
        options = 
        {
            {description = "2", data = 2},
            {description = "4", data = 4},
            {description = "10", data = 10},
            {description = "20", data = 20},
            {description = "30", data = 30},
        },
        default = 10,
    },
    {
        name = "MAXHUNGER_SLOWPERCENT",
        label = "超级胃增益电路饥饿速率变为：",
        options = 
        {
            {description = "0.1", data = 0.1},
            {description = "0.2", data = 0.2},
            {description = "0.5", data = 0.5},
            {description = "0.8", data = 0.8},
        },
        default = 0.8,
    },
}