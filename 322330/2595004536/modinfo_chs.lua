name =
[[发明家工具辅助
]]
description =
[[单人收集约束静电总是手忙脚乱？
记不清每个工具的名字？
本mod来帮您！
这是一个客机mod，当发明家需要一件工具时，该工具的图片就会显示在发明家的头上，从此不再交错工具！
（本mod依靠主机上发明家说的话来判断需要的工具，目前只收录了官方英语和中文的台词，如果台词没有收录，请根据服务器的台词，在scripts/Wgtscripts/Wagstaff_tool_strings.lua中添加，或者在创意工坊里留言告诉我）
]]

--[[
configuration_options =
{
    {
        name = "Language",
        label = "语言",
        options =   {
                        {description = "英语", data = false},
                        {description = "中文", data = true},
                    },
        default = false,
    },
}
]]
configuration_options =
{
    {
        name = "ToolInfo",
        label = "工具信息",
        options =   {
                        {description = "开", data = true, hover = "发明家所需的工具的图片将会出现在头顶"},
                        {description = "关", data = false, hover = "发明家所需的工具的图片将 不会 出现在头顶"},
                    },
        default = true,
    },
    {
        name = "ToolMark",
        label = "工具标记",
        options =   {
                        {description = "On", data = true, hover = "工具上会有箭头指着"},
                        {description = "Off", data = false, hover = "工具上不会有箭头指着"},
                    },
        default = true,
    },
    {
        name = "ArrowColour",
        label = "箭头颜色",
        options =   {
                        {description = "白色", data = {255, 255, 255}},
                        {description = "紫色", data = {119, 47, 173}},
                        {description = "橙色", data = {245, 199, 91}},
                        {description = "浅蓝色", data = {118, 245, 161}},
                        {description = "蓝色", data = {115, 154, 245}},
                        {description = "橄榄绿", data = {218, 245, 106}},
                        {description = "灰色", data = {190, 190, 190}},
                        {description = "紫罗兰", data = {238, 130, 238}},
                        {description = "薰衣草", data = {230, 230, 250}},
        },
        default = {255,255,255},
    },
}
