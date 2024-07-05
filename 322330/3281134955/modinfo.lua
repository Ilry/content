local isCh = locale == "zh" or locale == "zhr"
name = isCh and "聚光灯优化" or "Better Spotlight"
version = "0.1"
description = isCh and "如果你点了热光灯技能，薇诺娜的聚光灯将在环境温度低于零度（包括处在激活的冰眼结晶器范围内）时自动开启，而不是仅在冬季或夜晚。" or "If you upgrade the HotLight skill, Winona's spotlight will automatically turn on when the ambient temperature is below zero(including within range of an active deerclopseyeball sentryward), instead of only in winter or at night."
author = "SOL_STO"
forumthread = ""
dst_compatible = true
client_only_mod = false
all_clients_require_mod = true
api_version = 10

configuration_options = {}