name="T键物品增加"--mod的名字
author="北甍"--mod作者
version="1.0.9"--版本号
description=[[
    T键物品增加
    T键模组的附属模组，必须要开启T键，才起效
    增加了水中木的一些生物和大树
    以及天体boss和泰拉boss的相关物品
    韦伯，旺达和沃尔夫冈的新增物品
    浣猫，泰拉，鸦年华的相关物品

    2022-5-10机器人相关物品
    2022-6-6鸦年华新增物品
    2022-7-1月亮码头新增物品
    2022-8-6老奶奶新增物品
        --书籍调整至魔法栏
    2022-10-31新增舞台相关物品
    2022-11-2新增鸦年华和浣猫活动,以及修复部分物品贴图不显示的问题
    2023-5-7新增生根和之前人物重做的物品

    2024-01-25添加最近更新的物品，修复部分图片不显示的问题
]]
--[[
[h1]T键模组的附属模组！必须要订阅并开启T键，才起效！[/h1]
[h1]在此模组基础上做出增加：[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1365141672&searchtext=too]Too Many Items Plus[/url][/h1]
其他版本的T键，没测试过是否兼容

增加了水中木的一些生物和大树
以及天体boss和泰拉boss的相关物品
韦伯，旺达和沃尔夫冈的新增物品
浣猫，泰拉，鸦年华的相关物品
以及部分丢失贴图的显示修复

等待原作者将这些物品添加进T键就会下架此模组
[img]https://steamuserimages-a.akamaihd.net/ugc/1830154632429643379/85E1FC3BACA9697B4F4440C818011EA0C45C85B0/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false[/img]
]]
forumthread=""--steam模组下载的地址
api_version=10 --这里让其他玩家知道你的mod是否过时了，更新它以匹配游戏中的当前版本。

dst_compatible=true --用于判断是否和饥荒联机版兼容
dont_starve_compatible=false--
reign_of_giants_compatible=false --10,11判定是否和饥荒单机兼容
shipwrecked_compatible=false--海滩不可兼容

priority = 0--在t键模组之前加载
all_clients_require_mod=false --打开这个mod开服后进入服务器的人必须有本mod(大部分服务器mod都为true)
client_only_mod=true--客机mod

icon_atlas="modicon.xml" --剪裁mod图标图片的文件
icon="modicon.tex" --mod的图标

local numlist={"1","2","3","4","5","6","7","8","9","10","11","12","13"}
for i=1,13 do
    numlist[i]={description=numlist[i],data=i}
end
local keys = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12"}
local keylist = {}
local string = ""
for i = 1, #keys do
    keylist[i] = {description = keys[i], data = "KEY_"..string.upper(keys[i])}
end
local function AddTitle(title)
	return {
		name = "null",
		label = title,
		options = {
				{ description = "", data = 0 }
		},
		default = 0,
	}
end
configuration_options = {--昵称展示

} --mod设置
