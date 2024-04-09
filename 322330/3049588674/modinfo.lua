name = "WX-78: Mechanical Ascent"
author = "莫赋断肠诗"
description = "more powerful, more growth potential"
version = "1.0.8"
forumthread = ""
api_version = 10

icon = "modicon.tex"
icon_atlas = "modicon.xml"

dst_compatible = true
all_clients_require_mod = true
client_only_mod = false

local function AddOpt(desc,data,hover)
	if hover then
		return {description = desc, data = data, hover = hover}
	else
		return {description = desc, data = data}
	end
 end
 
local theKeys = {
	AddOpt("小键盘0",256,"小键盘0"),
	AddOpt("小键盘1",257,"小键盘1"),
	AddOpt("小键盘2",258,"小键盘2"),
	AddOpt("小键盘3",259,"小键盘3"),
	AddOpt("小键盘4",260,"小键盘4"),
	AddOpt("小键盘5",261,"小键盘5"),
	AddOpt("小键盘6",262,"小键盘6"),
	AddOpt("小键盘7",263,"小键盘7"),
	AddOpt("小键盘8",264,"小键盘8"),
	AddOpt("小键盘9",265,"小键盘9"),
	AddOpt("小键盘 .",266,"小键盘 ."),
	AddOpt("小键盘 /",267,"小键盘 /"),
	AddOpt("小键盘 *",268,"小键盘 *"),
	AddOpt("小键盘 -",269,"小键盘 -"),
	AddOpt("小键盘 +",270,"小键盘 +"),
	AddOpt("B",98),
	AddOpt("C",99),
	AddOpt("F",102,"该项会替代系统默认的攻击键,推荐走A可以设置成这个"),
	AddOpt("G",103),
	AddOpt("H",104),
	AddOpt("I",105,"该项是饥荒检查自身皮肤的默认按键, 不怕冲突可以选"),
	AddOpt("J",106),
	AddOpt("K",107),
	AddOpt("L",108),
	AddOpt("N",110),
	AddOpt("O",111),
	AddOpt("P",112),
	AddOpt("R",114),
	AddOpt("T",116),
	AddOpt("V",118),
	AddOpt("X",120),
	AddOpt("Z",122),
	AddOpt("减号-",45,"该项是OB视角的默认键位, 使用此快捷键请关闭OB视角"),
	AddOpt("加号+",61,"该项是OB视角的默认键位, 使用此快捷键请关闭OB视角"),
	AddOpt("关闭",false," ↑↑↑ 上面不是有关闭按钮嘛 ↑↑↑ ,干嘛要在这里关"),
	AddOpt("<",44,"小于号或者逗号"),
	AddOpt(">",46,"大于号或者小数点"),
	AddOpt(":",59,"冒号或者分号"),
	AddOpt("'",39,"单引号或者双引号"),
	AddOpt("[",91,"左括号"),
	AddOpt("]",93,"右括号"),
	AddOpt("\\",92,"右斜杠"),
	AddOpt("F1",282),
	AddOpt("F2",283),
	AddOpt("F3",284),
	AddOpt("F4",285),
	AddOpt("F5",286),
	AddOpt("F6",287),
	AddOpt("F7",288),
	AddOpt("F8",289),
	AddOpt("F9",290),
	AddOpt("F10",291),
	AddOpt("F11",292),
	AddOpt("方向键(↑)",273,"该键是走A的默认键位, 使用此键请关闭走A"),
	AddOpt("方向键(↓)",274,"该键是走A的默认键位, 使用此键请关闭走A"),
	AddOpt("方向键(←)",275,"该键是走A的默认键位, 使用此键请关闭走A"),
	AddOpt("方向键(→)",276,"该键是走A的默认键位, 使用此键请关闭走A"),
	AddOpt("关闭",false," ↑↑↑ 上面不是有关闭按钮嘛 ↑↑↑ ,干嘛要在这里关"),
	AddOpt("PageUp",280,"PageUp"),
	AddOpt("PageDown",281,"PageDown"),
	AddOpt("Home",278,"Home"),
	AddOpt("Insert",277,"Insert"),
	AddOpt("Delete",127,"Delete"),
	AddOpt("End",279,"End"),
	AddOpt("Pause",19,"Pause"),
	AddOpt("Scroll Lock",145,"Scroll Lock"),
	AddOpt("右Shift",303,"右Shift"),
	AddOpt("关闭",false," ↑↑↑ 上面不是有关闭按钮嘛 ↑↑↑ ,干嘛要在这里关"),
} 


configuration_options = {
    {
        name = "强大动力",
        hover = "不会受到重物减速影响，但饿得更快",
        options = {
            {
                description = "开启",
                data = true  
            },
            {
                description = "关闭",
                data = false
            }
        },
        default = true
    },
    {
        name = "重做照明电路",
        hover = "照明电路提供科学二本科技与读书相关能力",
        options = {
            {
                description = "开启",
                data = true  
            },
            {
                description = "关闭",
                data = false
            }
        },
        default = true
    },
    {
        name = "加强电气化电路",
        hover = "电器电路可以对周围同种攻击者造成aoe伤害",
        options = {
            {
                description = "开启",
                data = true  
            },
            {
                description = "关闭",
                data = false
            }
        },
        default = true
    },
    {
        name = "自身为锅能力",
        hover = "右键自身可以打开一口普通烹饪锅",
        options = {
            {
                description = "开启",
                data = true  
            },
            {
                description = "关闭",
                data = false
            }
        },
        default = true
    },
    {
        name = "吃齿轮强化自身能力",
        hover = "吃掉的齿轮超过10个和20个时，战斗能力得到强化",
        options = {
            {
                description = "开启",
                data = true  
            },
            {
                description = "关闭",
                data = false
            }
        },
        default = true
    },
    {
        name = "工作模式直接完成工作的几率",
        options = {
            {
                description = "0%",
                data = 1
            },
            {
                description = "5%",
                data = 0.95
            },
            {
                description = "10%",
                data = 0.9
            },
            {
                description = "15%",
                data = 0.85
            },
            {
                description = "20%",
                data = 0.8
            },
            {
                description = "100%",
                data = 0
            },
        },
        default = 0.85
    },
    {
        name = "能够进入战斗模式",
        hover = "进入战斗模式后能够根据当前移速获得伤害加成，但饿的更快",
        options = {
            {
                description = "是",
                data = true
            },
            {
                description = "否",
                data = false
            }
        },
        default = true
    },
    {
        name = "切换普通模式按键",
        options = theKeys,
        default = 256
    },
    {
        name = "切换工作模式按键",
        options = theKeys,
        default = 257
    },
    {
        name = "切换战斗模式按键",
        options = theKeys,
        default = 258
    },
    {
        name = "能够用暗影心脏改造自身",
        hover = "使用暗影武器时增加30%的伤害",
        options = {
            {
                description = "是",
                data = true
            },
            {
                description = "否",
                data = false
            }
        },
        default = true
    },
    {
        name = "钓具箱可以装人物专属物品",
        hover = "功能完全来自为爽而虐",
        options = {
            {
                description = "是",
                data = true
            },
            {
                description = "否",
                data = false
            }
        },
        default = true
    },
    {
        name = "是否开启加快采集速度",
        hover = "若使用快采模组请关闭加快采集速度，有冲突",
        options = {
            {
                description = "是",
                data = true
            },
            {
                description = "否",
                data = false
            }
        },
        default = true
    }
}

