modimport("common.lua")
modimport("ui.lua")

-- How to drag? 拖拽原理 widget.lua function Widget:FollowMouse()
-- 指定UI当鼠标右键按下时，监听鼠标移动，持续把指定UI放到鼠标位置，直至鼠标右键松开，停止监听鼠标移动
-- How to zoom?
-- 指定UI仅当鼠标上下滚轮键按下时，对指定UI进行一次微弱的尺寸变换
-- How to reset?
-- 指定UI仅当鼠标中键按下时，回到原始尺寸和坐标
-- How to mirrorflip?
-- 指定UI仅当鼠标中键第二次按下时，取消回到原始尺寸和坐标，对该UI进行镜像，镜像是每个UI都手动适配的，目前不能自动

-- 暴露变量，但本模组很晚执行
TUNING.DRAGZOOMUIMOD_IS_OPEN = true

-- 对UI进行初始化的入口API的进一步包裹
local function MakeUIListDynamic(UIList, async)
    for widget, uiList in pairs(UIList) do
        if isModuleAvailable(widget) then
            AddClassPostConstruct(widget, function(self)
                if async then
                    self.inst:DoTaskInTime(0, function() processUIList(self, uiList) end)
                else
                    processUIList(self, uiList)
                end
            end)
        end
    end
end
--------------------------------------------------------------------------------------------------------
-- 暴露UI列表入口给其他模组以便复用，且提供具体如何复用的可复制代码，只需要复制下面的代码就可以使用
TUNING.DRAGZOOMUIMOD = TUNING.DRAGZOOMUIMOD or {}
TUNING.DRAGZOOMUIMOD.UIList = TUNING.DRAGZOOMUIMOD.UIList or {}
-- 暴露UI处理接口给其他模组以便复用，但本模组很晚执行，所以可能要定时器检测到本接口才再使用，比较麻烦
TUNING.DRAGZOOMUIMOD.processUI = processUI
TUNING.DRAGZOOMUIMOD.processUIList = processUIList
--------------------------------------------------------------------------------------------------------
--[[如果你想要把自己的UI插入到本模组的UI列表中，只需要复制这段代码
然后解除内部的注释，修改其中的myModUIList为自己要支持的UI即可，UI规则的写法请看后面部分
如果要支持更复杂的UI，直接定时器轮询到TUNING.DRAGZOOMUIMOD.processUIList函数出现来手写方式处理自己的UI列表
本模组没有加太多校验;有些UI的类型不允许直接执行OnMouseButton，需要先做处理否则功能无效]]
--[[----------------------------------------------------------------------------------------------------可复制代码的开头/Copy code start
-- Copy these code into your mod
TUNING.DRAGZOOMUIMOD = TUNING.DRAGZOOMUIMOD or {}
TUNING.DRAGZOOMUIMOD.UIList = TUNING.DRAGZOOMUIMOD.UIList or {}

local myModUIList = {} -- See the mainUIList at bottom

local function mergeTable(self, from, first)
    if type(self) ~= "table" and type(from) ~= "table" then
        return
    end
    if first then
        from = deepcopy(from)
    end
    for k, v in pairs(from) do
        if not self[k] then
            self[k] = v
        elseif type(self[k]) == "table" and type(v) == "table" then
            mergeTable(self[k], v)
        end
    end
end

mergeTable(TUNING.DRAGZOOMUIMOD.UIList, myModUIList)
--------------------------------------------------------------------------------------------------------截止代码，后面的不需要再复制了/Copy code end]]
MakeUIListDynamic(TUNING.DRAGZOOMUIMOD.UIList)
--------------------------------------------------------------------------------------------------------
-- UI白名单支持
local mainUIList = {
    ["widgets/statusdisplays"] = {
        brain = "brain",
        -- [[规则一：使用table和self来传入更多参数，目前支持的参数有notip,disablezoom,disabledrag,allowpostion,allowscale,acttargetkey,默认值全是false
        -- brain = {self = "brain"},
        -- brain = {self = {key = "brain",notip = true}}]]
        stomach = "stomach",
        heart = "heart",
        moisturemeter = "moisturemeter",
        boatmeter = "boatmeter",
        resurrectbutton = "resurrectbutton",
        pethealthbadge = "pethealthbadge",
        wereness = "wereness", --
        inspirationbadge = "inspirationbadge",
        mightybadge = "mightybadge",
        -- 季节时钟模组
        naughtiness = "naughtiness",
        naughtybadge = "naughtybadge",
        temperature = "temperature",
        tempbadge = "tempbadge",
        worldtemp = "worldtemp",
        worldtempbadge = "worldtempbadge",
        beaverbadge = "beaverbadge", --
        -- 开花仪模组
        bloombadge = "bloombadge",
        -- 度日如年的年龄值
        odoy_age = "odoy_age",
        -- 永不妥协 沃拓姆的能力值
        adrenaline = "adrenaline",
        -- 随机生物大小数据包口渴值
        fili_hud_thirst = "fili_hud_thirst",
        -- 魔女之旅
        elaina_magic = "elaina_magic",
        -- 奇幻降临
        Abigail_Moon_UI = "Abigail_Moon_UI",
        -- 太真
        tz_xx_button = {self = {key = "tz_xx_button", disabledrag = true, allowpostion = true, notip = true}},
        tz_read_button = {self = {key = "tz_read_button", disabledrag = true, allowpostion = true, notip = true}}
        -- 太真的星愿祭是加密内容不予支持
    },
    ["widgets/controls"] = {
        -- [[规则二：非self，则为嵌套读取变量的变量]]
        secondary_status = {
            -- 电表
            upgrademodulesdisplay = {self = {key = "upgrademodulesdisplay", mirrorflip = true}}
        },
        clock = "clock",
        -- 季节时钟模组
        seasonclock = "seasonclock",
        season = "season",
        -- 神话人物模组
        myth_skills = "myth_skills",
        -- 成就与等级系统
        uiachievement = {mainbutton = "uiachievement_mainbutton"},
        -- 简单经济学
        uiseconomy = {
            mainui = {self = {key = "uiseconomy_mainui", acttargetkey = "bg"}},
            mainbutton = "uiseconomy_mainbutton",
            coinamount = "uiseconomy_coinamount"
        },
        -- 艾露迪Eirudy
        erd_menu = "erd_menu"
    },
    ["screens/playerhud"] = {
        -- 地下狂暴指示器
        nightmarephaseindicator = "nightmarephaseindicator"
    }
}
-- 制作栏UI支持
if GetModConfigData("craftmenu") then
    mainUIList["widgets/controls"].craftingmenu = {
        self = {key = "craftingmenu", mirrorflip = true, need_root = true, disablezoom = true, notip = true, allowscale = true, allowpostion = true}
    }
end
MakeUIListDynamic(mainUIList)
--------------------------------------------------------------------------------------------------------
-- Eirudy 艾露迪的单个页面返回多个值因此解构出来处理
if isModuleAvailable("widgets/erd_mainwidgets") then
    local widgets = require("widgets/erd_mainwidgets")
    if widgets.Erd_Sp then
        local constructor = widgets.Erd_Sp._ctor
        widgets.Erd_Sp._ctor = function(self, ...)
            constructor(self, ...)
            processUI(self, "Erd_Sp")
        end
    end
end
--------------------------------------------------------------------------------------------------------
-- 更多UI动态识别支持
if GetModConfigData("ui_more") then
    AddClassPostConstruct("widgets/statusdisplays", function(self)
        self.inst:DoTaskInTime(0, function()
            for key, ui in pairs(self) do if ui and type(ui) == "table" and ui.underNumber then processUI(ui, key) end end
        end)
    end)
end
--------------------------------------------------------------------------------------------------------
-- 容器UI动态识别支持，同时进行勋章兼容，部分代码参考能力勋章
if GetModConfigData("container") and not (TUNING.FUNCTIONAL_MEDAL_IS_OPEN and TUNING.MEDAL_CONTAINERDRAG_SETTING ~= 0) then
    AddClassPostConstruct("widgets/containerwidget", function(self)
        local oldOpen = self.Open or function() end
        self.Open = function(...)
            oldOpen(...)
            if self.container:HasTag("_equippable") and not self.container.isopended then
                self.container:DoTaskInTime(0, function()
                    if self.container then
                        local key = self.container.prefab or ""
                        processUI(self, {key = key, acttargets = {self.bganim, self.bgimage}})
                        self.container.isopended = true
                    end
                end)
            else
                local key = self.container.prefab or ""
                processUI(self, {key = key, acttargets = {self.bganim, self.bgimage}})
            end
        end
    end)
end
