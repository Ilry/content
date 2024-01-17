name = "填海叉（Sea2land Fork）"
description = [[
2022年6月2日更新（Update on 2022/06/02）
- 修改填海叉的贴图和动画为金色叉子
- Change the images of the sea2land fork.

- 增加地皮选项，可以根据需要填出虚空、浅海、中海、深海等。注意！更换海洋地皮需要应用填海造陆重新载入后才能看得出来！
- Add a spinner for users to change the turf.

============================================================

2021年11月10日通知（Note on 2021/11/4）
- 使用时请关闭延迟补偿，否则可能无法生效
- Please turn off the "Lag Compensation" when using the sea2land fork, or it may not take effect.

============================================================

2021年11月4日更新（Update on 2021/11/4）
- 修复洞穴中无法使用填海叉的问题
- Fix a crash when using the sea2land fork in caves.

============================================================

对随机生成的地图不满意？一起来改造世界吧！
Unsatisfactory with the map generated randomly? Let's customize!

- 你现在可以使用科学机器在工具栏制作一把填海叉（贴图与干草叉相同，不要混了！）
- Now you can make a sea2land fork in the tool tab using the science machine. Note that its image is the same with the Pitchfork. Don't mistake!

- 当你装备填海叉时，对地面使用可以挖海，对海面使用可以造陆
- Equipped with the sea2land fork, you can change land to sea or sea to land.

- 当你装备填海叉时，你可以无视陆地边界，甚至在海洋行走
- Equipped with the sea2land fork, you can walk to the sea regardless the coastline.

- 填海挖海后需要保存和重新载入才能使地块正常，可以通过右键拿在手上的填海叉快捷应用
- After customization, the world must be saved and reset to apply the changes. You can right click the sea2land fork on your hand to do so easily.

- 为了防止误操作导致频繁重置，第一次应用后，需要在3秒后5秒内再次应用，才会保存重载
- To prevent misoperation, after the first application, you should reapply after 3 seconds and in 5 seconds.

- 默认情况下填海叉只有管理员能用，可以在设置中关闭该选项
- By default, the sea2land fork can only be used by administrators. You can turn off this limitation in the mod settings.
]]
author = "NoMu"
version = "0.2.2"

api_version = 10

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"sea", "land", "NoMu"}

configuration_options = {
    {
        name = "admin_only",
        label = "仅管理可用",
        options = {
            { description = "开启", data = true, hover = "" },
            { description = "关闭", data = false, hover = "" }
        },
        default = true
    },
}
