# 更智能的雪球机

描述：（这是一个改进版mod，原作者mod链接在下面）

灭火器在关闭状态下，可以检测火情、冒烟、枯萎，自动开启速度可调节，自动关闭时间可调节，且不会扑灭火堆（理论上包括其他大部分mod的火堆），而且可以刷肉（在用于刷肉的灭火器旁边放一个「陷阱」（抓兔子的那种），就可以开启对应灭火器的刷肉模式），其中刷肉模式下的开启时间可调（刷肉模式默认关闭，如需要请先在mod设置界面开启）

注：
1. 如果出现游戏报错，请尽量提供报错信息，否则我也不知道是什么问题导致报错
2. 如有个别mod额外需要兼容，请尽量提供相应mod的完整名称或者链接或者ID

目前已额外兼容mod：[DST]Musha

更新日志：

v 1.6.0

1. 优化了代码，也提高了代码兼容性。现在除去个别mod，理论上该mod能兼容大部分mod的火堆（之前所有已经兼容过的mod也都在目前的代码架构下进行了兼容性验证）
2. 去除了检测枯萎的选项（没必要存在），现在灭火器默认检测枯萎
3. 将“陷阱模式”改名为“刷肉模式”，因为“陷阱模式”会引起误解

v 1.4.8
兼容了以下mod：Deluxe Campfires DST - Beta Release，[DST]Musha

v 1.4.6
兼容了以下mod：大狐狸（Millennium Fox）

v 1.4.5
新增简体中文支持

v 1.4.3

优化了代码

v 1.4.2
添加了对以下mod的兼容：Functional Medal（能力勋章）、Always On Tiki Torch

v 1.3.9
1. 给灭火器增加了一个新模式——陷阱/刷肉模式(默认关闭)，专门用于各种刷肉机。要开启陷阱/刷肉模式，需要将一个“陷阱（抓兔子的）”放在用于刷肉机的灭火器旁边，即可开启其陷阱/刷肉模式。同时如果将“陷阱”拿走，灭火器也将恢复正常工作模式
2. 一共有15s，18s，20s，23s，25s，28s，30s这七种陷阱/刷肉模式的自动开启时间供选择


v 1.3.5
完善了检测"正要枯萎"的机制，使其能正确的检测枯萎

v 1.3.3
1. 修改了灭火器开启时间初始值，中等->快
2. 调整了检测枯萎的机制，现在可以选择检测已经枯萎的植物或正要枯萎的植物（在完全枯萎之前）


v 1.3.1
增加了修改灭火器开启时间的选项

v 1.3.0
1. 修改了灭火器初始建造时的状态，修复了刚建造灭火器时不会灭火的bug
2. 修改了灭火器自动关闭时间的默认时间，30s -> 5s
3. 增加了是否检测枯萎植物的选项，默认是
4. 修复了若干bug，解决了内存溢出问题


v 1.0.1
修改了燃料容积选项的描述

v 1.0.0
现在灭火器也能在关闭状态（即紧急状态）下工作了，同时不会扑灭火堆、冰火堆等。
3秒之内开启灭火，自动关闭时间可调。
这是一个改进版mod，原作者mod不能检测冒烟的东西，还有着火的物品和植物等，此mod修复了这点。同时增加了可修改自动关闭时间的选项。

原作者mod：https://steamcommunity.com/sharedfiles/filedetails/?id=1845106626



# Smarterer Ice Flingomatic

Description: (This is an improved mod. The origin mod link is at the end of description)

Flingo now can detect fire, smolder, withered objects when is off. Flingo will turn on in adjustable speed when finding fire or smolder or withered, and turn off in adjustable sec, also it won't put out campfire(including most other mods' campfires theoretically). And it is suitable for meat-farming(has a delay-mode. Only need to put a "trap"(common ones for rabbits) next to the very flingo for meat-farming), and turning-on time in delay-mode is adjustable. (This mode is deactivated by default, so please activate it in mod setting menu in advance if needed)

Caution:
1. If there's any error, please show me the FULL ERROR INFORMATION if possible. Otherwise, I won't be able to know where the problem is.
2. If there're some particular mods that this mod don't support, please show me the FULL NAME or LINK or MOD ID of the target mod if possible.

Currently EXTRA support lists: [DST]Musha

Update logs：

v 1.6.0

1. Make the code simpler, which also make this mod more powerful. Now apart from some particular mods, this mod can support most other mods.(compatibility of all mods that this mod once supported has already been checked in this new code structure)
2. Remove options for withered/withering-detection(no need to exist), so now flingo will detect withering objects by default
3. Rename "trap-mode" to "delay-mode", as "trap-mode" can cause misunderstanding

v 1.4.8
Make it compatible for following mod: Deluxe Campfires DST - Beta Release, [DST]Musha

v 1.4.6
Make it compatible for following mod: Millennium Fox

v 1.4.5
Simplified Chinese compatible

v 1.4.3 
Make the code simpler

v 1.4.2
Make it compatible for following mods: Functional Medal、Always On Tiki Torch

v 1.3.9
1. Add a new mode for flingo ---- trap/delay-mode(default deactivated), which is specific for various “meat farming system(I don't konw how to say it in English)”. To activate this mode, you only need to put a "trap" (common traps for rabbits) next to the very flingo for "meat-farming". Additionally, you can pick up the "trap" as long as you want, and then the flingo will change to normal mode.
2. There are 15 sec, 18 sec, 20 sec, 23 sec, 25 sec, 28 sec and 30 sec turning-on time options in trap/delay-mode for choosing.

v 1.3.5
Improve the way it detects withering, making it more accurate

v 1.3.3
1. Change the default value of the speed of turning on, normal -> fast
2. Adjust the way it detects wither. Now you can choose to detect WITHERED plants or WITHERING plants (before utter withered)

v 1.3.1
Add the option to adjust how fast it will turn on

v 1.3.0
1. Adjust the state when it is built
2. Change the default duration when is on, 30s -> 5s
3. Add the option that whether it can detect withered plants
4. Fixed a few bugs，fixed the 'out of memory' problem

v 1.0.1
Adjust the description of the option of the maximum fuel volume

v 1.0.0
Ice Flingomatic will detect fire and put it off more accurately even if it's turned off. Now it can also detect smolder objects when is off.

It's based on https://steamcommunity.com/sharedfiles/filedetails/?id=1845106626