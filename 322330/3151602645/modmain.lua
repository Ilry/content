GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local TOOLS_L = require("prefabs/critters")

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
    -- 小座狼动画
    Asset("ANIM", "anim/pupington_iron_build.zip"),
	Asset("ANIM", "anim/pupington_iron_basic.zip"),
	Asset("ANIM", "anim/pupington_iron_emotes.zip"),
	Asset("ANIM", "anim/pupington_iron_traits.zip"),
    -- 小羊动画
    Asset("ANIM", "anim/sheepington_iron_build.zip"),
	Asset("ANIM", "anim/sheepington_iron_basic.zip"),
	Asset("ANIM", "anim/sheepington_iron_emotes.zip"),
	Asset("ANIM", "anim/sheepington_iron_traits.zip"),
    Asset("ANIM", "anim/sheepington_iron_jump.zip"),
    -- 小鸡
    Asset("ANIM", "anim/perdling_iron_build.zip"),
	Asset("ANIM", "anim/perdling_iron_basic.zip"),
	Asset("ANIM", "anim/perdling_iron_emotes.zip"),
	Asset("ANIM", "anim/perdling_iron_traits.zip"),
    Asset("ANIM", "anim/perdling_iron_jump.zip"),
    -- 小龙蝇
    Asset("ANIM", "anim/dragonling_iron_build.zip"),
	Asset("ANIM", "anim/dragonling_iron_basic.zip"),
	Asset("ANIM", "anim/dragonling_iron_emotes.zip"),
	Asset("ANIM", "anim/dragonling_iron_traits.zip"),
    -- 小蛾子
    Asset("ANIM", "anim/lunarmoth_iron_build.zip"),
	Asset("ANIM", "anim/lunarmoth_iron_basic.zip"),
	Asset("ANIM", "anim/lunarmoth_iron_emotes.zip"),
	Asset("ANIM", "anim/lunarmoth_iron_traits.zip"),
    -- 小浣猫
    Asset("ANIM", "anim/kittington_iron_build.zip"),
	Asset("ANIM", "anim/kittington_iron_basic.zip"),
	Asset("ANIM", "anim/kittington_iron_emotes.zip"),
	Asset("ANIM", "anim/kittington_iron_traits.zip"),
    Asset("ANIM", "anim/kittington_iron_jump.zip"),
    -- 小格罗姆
    Asset("ANIM", "anim/glomling_iron_build.zip"),
	Asset("ANIM", "anim/glomling_iron_basic.zip"),
	Asset("ANIM", "anim/glomling_iron_emotes.zip"),
	Asset("ANIM", "anim/glomling_iron_traits.zip"),
    -- 小眼珠子
    Asset("ANIM", "anim/eyeofterror_mini_iron_actions.zip"),
	Asset("ANIM", "anim/eyeofterror_mini_iron_basic.zip"),
    Asset("ANIM", "anim/eyeofterror_mini_iron_mob_build.zip"),
	Asset("ANIM", "anim/eyeofterror_mini_iron_emotes.zip"),
	Asset("ANIM", "anim/eyeofterror_mini_iron_traits.zip"),
}

env.RECIPETABS = GLOBAL.RECIPETABS 
env.TECH = GLOBAL.TECH
env.STRINGS = GLOBAL.STRINGS

STRINGS.NAMES.FIRESUPPRESSOR_ITEM = "永动组件"
STRINGS.NAMES.PMFIRESUPPRESSOR = "永动雪球机"
STRINGS.NAMES.CRITTER_PUPPY_IRON = "钢铁小座狼"
STRINGS.NAMES.CRITTER_LAMB_IRON = "钢铁小羊"
STRINGS.NAMES.CRITTER_KITTEN_IRON = "钢铁小浣猫"
STRINGS.NAMES.CRITTER_PERDLING_IRON = "钢铁小火鸡"
STRINGS.NAMES.CRITTER_DRAGONLING_IRON = "钢铁小龙蝇"
STRINGS.NAMES.CRITTER_LUNARMOTHLING_IRON = "钢铁小月蛾"
STRINGS.NAMES.CRITTER_GLOMLING_IRON = "钢铁小格罗姆"
STRINGS.NAMES.CRITTER_EYEOFTERROR_IRON = "钢铁小克眼"
STRINGS.RECIPE_DESC.FIRESUPPRESSOR_ITEM = "充满科学的甜美气息，有许多意想不到的作用，可以为一些装置升级。"
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
-- 给宠物添加tag以帮助判断
-- 小座狼
AddPrefabPostInit("critter_puppy", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_puppy")
end)

AddPrefabPostInit("critter_puppy_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_puppy_iron")
    inst:AddTag("iron_pet")
end)
-- 小钢羊
AddPrefabPostInit("critter_lamb", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_lamb")
end)

AddPrefabPostInit("critter_lamb_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_lamb_iron")
    inst:AddTag("iron_pet")
end)
-- 小浣猫
AddPrefabPostInit("critter_kitten", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_kitten")
end)

AddPrefabPostInit("critter_kitten_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_kitten_iron")
    inst:AddTag("iron_pet")
end)
-- 小火鸡
AddPrefabPostInit("critter_perdling", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_perdling")
end)

AddPrefabPostInit("critter_perdling_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_perdling_iron")
    inst:AddTag("iron_pet")
end)
-- 小龙蝇
AddPrefabPostInit("critter_dragonling", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_dragonling")
end)

AddPrefabPostInit("critter_dragonling_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_dragonling_iron")
    inst:AddTag("iron_pet")
end)
-- 小格罗姆
AddPrefabPostInit("critter_glomling", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_glomling")
end)

AddPrefabPostInit("critter_glomling_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_glomling_iron")
    inst:AddTag("iron_pet")
end)
--小月蛾
AddPrefabPostInit("critter_lunarmothling", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_lunarmothling")
end)

AddPrefabPostInit("critter_lunarmothling_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_lunarmothling_iron")
    inst:AddTag("iron_pet")
end)
-- 小克眼
AddPrefabPostInit("critter_eyeofterror", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_eyeofterror")
end)

AddPrefabPostInit("critter_eyeofterror_iron", function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end
    inst:AddTag("critter_eyeofterror_iron")
    inst:AddTag("iron_pet")
end)
--==========================================================================

AddPrefabPostInitAny(function(inst)
    if(inst:HasTag("player")) then
        inst:AddComponent("pmupdate")
        -- inst:AddComponent("pettest")
    end
    if(inst:HasTag("critter")) then
        if inst.prefab ~= "woby" and inst.prefab ~= "woby_big" and inst.prefab ~= "wobysmall" then
            inst:AddComponent("pettest")
        end
    end
    if(inst:HasTag("iron_pet")) then
        inst:RemoveComponent("eater")
        inst.components.perishable:SetPerishTime(9999999999999)
    end
end)

local act = {
    id = "UPDATE_PM",
    name = "升级",
    fn = function(act)
        act.doer.components.inventory:RemoveItem(act.invobject):Remove()
        act.doer.components.pmupdate:Work(act.doer,act.target)  
        print("升级雪球机")
        return true       
    end,
    state = "dojostleaction" 
}
local act_pmupdate = AddAction(act.id, act.name, act.fn)

local act_pet = {
    id = "UPUP",
    name = "进化",
    fn = function(act)
        
        print("进化宠物")     
        act.doer.components.inventory:RemoveItem(act.invobject):Remove()
        act.target.components.pettest:Work(act.doer,act.target)
        return true
        
    end,
    state = "dojostleaction" 
}
local act_petupdate = AddAction(act_pet.id, act_pet.name, act_pet.fn)


AddStategraphActionHandler("wilson", ActionHandler(act_pmupdate, act.state))
AddStategraphActionHandler("wilson_client", ActionHandler(act_pmupdate, act.state))
AddStategraphActionHandler("wilson", ActionHandler(act_petupdate, act.state))
AddStategraphActionHandler("wilson_client", ActionHandler(act_petupdate, act.state))

local cmp_act = {
    type = "USEITEM",
    component = "inventoryitem",
    testfn = function(inst, doer, target, actions, right)
        if right then
            if target.replica.pmupdate and doer:HasTag("player") and inst:HasTag("pm_updatable") then
                table.insert(actions, act_pmupdate)
                -- print("触发动作")
                return true
            end 

            if target:HasTag("critter") then
                local pet_name = inst.GetDisplayName(target)
                if pet_name ~= "沃比" then
                    

                    print(pet_name)
                    if target.replica.pettest and doer:HasTag("player") and inst:HasTag("pm_updatable") then
                        if target:HasTag("iron_pet")then
                            return false
                        -- elseif target:HasTag("critter_kitten")  then
                        --     return false
                        else
                            table.insert(actions, act_petupdate)
                            print("触发动作")
                            return true
                        end
                    end
                end
            end 
        end
    end
}

AddComponentAction(cmp_act.type, cmp_act.component, cmp_act.testfn)



AddReplicableComponent("pmupdate")
AddReplicableComponent("pm_updatable")
AddReplicableComponent("pettest")


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
        { Ingredient("gears", 5 ),Ingredient("wagpunk_bits", 5 )},
        TECH.LOST,
        config,
        {"MOD"}
)

-- Recipe2("pmfiresuppressor",{Ingredient("gears", 10)},TECH.LOST,{placer="firesuppressor_placer", image="pmfirefighter.tex", })
STRINGS.UI.CRAFTING_FILTERS["永动机"] = "永动雪球机"