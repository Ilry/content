name = "Auto Refuel"
description = [[
为你的魔光护符自动添加噩梦燃料
Automatically add nightmare fuel to your Magiluminescence

现在支持更多物品,例如提灯,警告表,骨甲...
Now supports more items, such as Lanterns, Alarming Clock,Bone Armor ...
]]
author = "raccoon"
version = "23-12-31"
api_version_dst = 10

dst_compatible = true
all_clients_require_mod = false
client_only_mod = true
server_filter_tags = {"raccoon"}

icon_atlas = "modicon.xml"
icon = "modicon.tex"

local function setTitle(str)
    return {
        label = str,
        name = "",
        hover = "",
        options = {{description = "", data = false}},
        default = false
    }
end

local function setConfig(name, title, options, default, desc)
    local _options = {}
    for i = 1, #options do
        _options[i] = {
            description = options[i][1],
            data = options[i][2],
            hover = options[i][3]
        }
    end
    options = _options

    return {
        name = name,
        label = title,
        hover = desc,
        options = options,
        default = default
    }
end

local percent_list = {
    {"99%", 99}, {"90%", 90}, {"80%", 80},
    {"75%", 75}, {"70%", 70}, {"60%", 60}, {"50%", 50}, {"40%", 40}, {"30%", 30},
    {"20%", 20}, {"10%", 10},{"禁用/disable", false}
}
local enable_list =  {{"启用/enable", true}, {"禁用/disable", false}}

configuration_options = {
    setTitle("物品/Items"),
    setConfig("yellowamule_switch", "魔光护符/Yellowamulet", percent_list,60), --37 
    setConfig("orangeamulet_switch", "懒人护符/Orangeamulet", percent_list,70), --22
    setConfig("minerhat_switch", "矿灯帽/Minerhat", percent_list, 80),--19
    setConfig("lantern_switch", "提灯/Lantern", percent_list, 80),--19
    setConfig("alarmingclock_switch", "警告表/AlarmingClock", percent_list,75),--25
    setConfig("bonearmor_switch", "骨甲/BoneArmor", percent_list, 75),--25
    setConfig("thurible_switch", "暗影香炉/Thurible", percent_list, 50),--6,33
    setConfig("molehat_switch", "鼹鼠帽/Molehat", percent_list, 60),--6,33
    setConfig("maxwellbook_switch", "暗影法典/CodexUmbra", percent_list, 75),--6,33
	setConfig("lighter_switch", "打火机/Willow's Lighter", percent_list, 55),
    setTitle("调整/Tweaks"),
    setConfig("holdonly_switch", "仅装备/Equipped Only", enable_list, true, "只在该装备时才自动添加燃料,否则放身上的物品也会自动添加燃料"),
    setConfig("busymode_switch", "忙碌模式/Busy Mode",  enable_list, true, "玩家处于攻击或移动状态或附近有敌对生物时,\n将暂时忽略自动添加,防止打断当前动作"),
    setConfig("busyskip_switch", "强制添加/Force Refuel",  enable_list, true, "剩下10%燃料时将跳过忙碌模式强制添加燃料")
}
