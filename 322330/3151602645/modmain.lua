GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})


PrefabFiles = {
   -- "yongdongji",
    "pmfiresuppressor",
    "firesuppressor_item", 
}


local require = GLOBAL.require
local Vector3 = GLOBAL.Vector3
local FOODTYPE = GLOBAL.FOODTYPE
local STRINGS = GLOBAL.STRINGS
local Ingredient = GLOBAL.Ingredient
local ACTIONS = GLOBAL.ACTIONS
local RECIPETABS = GLOBAL.RECIPETABS
local ActionHandler = GLOBAL.ActionHandler


Assets = {
    Asset("ANIM", "anim/firefighter.zip"),
    Asset("ANIM", "anim/firesuppressor_item.zip"),
    Asset("IMAGE", "images/pmfiresuppressor.tex"), 
	Asset("ATLAS", "images/pmfiresuppressor.xml"),
    Asset("IMAGE", "images/firesuppressor_item.tex"), 
	Asset("ATLAS", "images/firesuppressor_item.xml"),
}

env.RECIPETABS = GLOBAL.RECIPETABS 
env.TECH = GLOBAL.TECH
env.STRINGS = GLOBAL.STRINGS

STRINGS.NAMES.FIRESUPPRESSOR_ITEM = "雪球机升级套件"
STRINGS.NAMES.PMFIRESUPPRESSOR = "永动雪球机"
STRINGS.RECIPE_DESC.FIRESUPPRESSOR_ITEM = "可以升级雪球机，不需要再添加燃料并且不会打灭人工火堆。"
-- STRINGS.CHARACTERS.GENERIC.DESCRIBE.PMFIRESUPPRESSOR = "它似乎对火……不感兴趣？"
-- STRINGS.CHARACTERS.WX78.DESCRIBE.PMFIRESUPPRESSOR = "我能感受到它无尽的力量，正如它感受我一样。"
-- STRINGS.CHARACTERS.WANDA.DESCRIBE.PMFIRESUPPRESSOR = "真羡慕它能够看到千百年后的光景。"
-- STRINGS.CHARACTERS.WURT.DESCRIBE.PMFIRESUPPRESSOR = "她就像海洋之心一样，生生不息。"
-- STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PMFIRESUPPRESSOR = "你们就只拿它来干这个？"
-- 角色台词
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PMFIRESUPPRESSOR = "科学的甜美气息~"
STRINGS.CHARACTERS.WILLOW.DESCRIBE.PMFIRESUPPRESSOR = "可恶啊，这下我不能玩火了。"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PMFIRESUPPRESSOR = "强大且猥琐。"
STRINGS.CHARACTERS.WENDY.DESCRIBE.PMFIRESUPPRESSOR = "永远...是一种悲哀。"
STRINGS.CHARACTERS.WX78.DESCRIBE.PMFIRESUPPRESSOR = "检测到朋友的能量已趋向于无穷大。"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PMFIRESUPPRESSOR = "我想这个惊世骇俗的发明应该记录到图书馆里。"
STRINGS.CHARACTERS.WOODIE.DESCRIBE.PMFIRESUPPRESSOR = "力等于质量乘以速度。"
-- STRINGS.CHARACTERS.WES.DESCRIBE.PMFIRESUPPRESSOR = "……"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PMFIRESUPPRESSOR = "还算有点用处。"
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PMFIRESUPPRESSOR = "不知道这装置能不能拿来冷冻肉干。"
STRINGS.CHARACTERS.WEBBER.DESCRIBE.PMFIRESUPPRESSOR = "哦！下雪了！"
STRINGS.CHARACTERS.WINONA.DESCRIBE.PMFIRESUPPRESSOR = "嗯,它比设计图还小。"
STRINGS.CHARACTERS.WARLY.DESCRIBE.PMFIRESUPPRESSOR = "我和你意见相同。"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.PMFIRESUPPRESSOR = "太好了，我最讨厌夏天了！"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PMFIRESUPPRESSOR = "你好，朋友！哦不对，是另一个机器人朋友！"
STRINGS.CHARACTERS.WURT.DESCRIBE.PMFIRESUPPRESSOR = "我要给我的榴莲田里也造一台！"
STRINGS.CHARACTERS.WALTER.DESCRIBE.PMFIRESUPPRESSOR = "训练营里可不会教你做这个。"
STRINGS.CHARACTERS.WANDA.DESCRIBE.PMFIRESUPPRESSOR = "是的是的,赶快,我回头还有更重要的事情要做。"


AddPrefabPostInit("firesuppressor", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddComponent("pmupdate")
end)

AddPrefabPostInitAny(function(inst)
    if(inst:HasTag("player")) then
        inst:AddComponent("pmupdate")
    end
end)

local act = {
    id = "UPDATE_PM",
    name = "升级",
    fn = function(act)
        act.doer.components.inventory:RemoveItem(act.invobject):Remove()
        act.doer.components.pmupdate:Work(act.doer,act.target)  
        print("升级雪球机")       
    end,
    state = "dojostleaction" 
}
local act_pmupdate = AddAction(act.id, act.name, act.fn)


AddStategraphActionHandler("wilson", ActionHandler(act_pmupdate, act.state))
AddStategraphActionHandler("wilson_client", ActionHandler(act_pmupdate, act.state))

local cmp_act = {
    type = "USEITEM",
    component = "inventoryitem",
    testfn = function(inst, doer, target, actions, right)
        if right then
            if target.replica.pmupdate and doer:HasTag("player") and inst:HasTag("pm_updatable") then
                table.insert(actions, act_pmupdate)
                print("触发动作")
            end 
        end
    end
}

AddComponentAction(cmp_act.type, cmp_act.component, cmp_act.testfn)



AddReplicableComponent("pmupdate")
AddReplicableComponent("pm_updatable")



local whitelist_for_pmfiresuppressor = {
	"campfire",
	"firepit",
	"coldfire",
	"coldfirepit",
	"nightlight",
	"pigtorch",
    "cotl_tabernacle_level1",
    "cotl_tabernacle_level2",
    "cotl_tabernacle_level3",
}

for k, v in pairs(whitelist_for_pmfiresuppressor) do
	AddPrefabPostInit(v, function(inst)
		inst:AddTag("white_list")
	end)
end


--Recipe2("yongdongji",{Ingredient("gears", 10)},TECH.LOST)
-- == 自定义过滤器 == 
-- local filter_pmfire_def = {                      
--     name = "PMFIRE",
--     atlas = "images/PMFIRE.xml",
--     image = "images/PMFIRE.tex",
--     image_size = 64,
-- }

-- AddRecipeFilter(filter_pmfire_def, 1)
-- STRINGS.UI.CRAFTING_FILTERS.PMFIRE ="永动雪球机"

local config = {
    atlas = "images/firesuppressor_item.xml",
}

AddRecipe2(
        "firesuppressor_item",
        { Ingredient("gears", 10)},
        TECH.LOST,
        config,
        {"MOD"}
)

-- Recipe2("pmfiresuppressor",{Ingredient("gears", 10)},TECH.LOST,{placer="firesuppressor_placer", image="pmfirefighter.tex", })
STRINGS.UI.CRAFTING_FILTERS["永动机"] = "永动雪球机"