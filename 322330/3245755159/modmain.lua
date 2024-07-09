if GLOBAL.TheNet:GetIsClient() then
    return
end

GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })
require("lang/zszljh")
local option1 = GetModConfigData("option1")
XFDBQSZ.FSFW = option1

local function table_concat(t1, t2, t3)
    local new_table = {}
    for i = 1, #t1 do
        for j = 1, #t2 do
            for k = 1, #t3 do
                -- 将三个表中的元素拼接起来，并添加到新表中
                new_table[#new_table + 1] = t1[i] .. t2[j] .. t3[k]
            end
        end
    end
    return new_table
end
-- 特定地皮类型的编号
local specific_tile_type = 6
local special_trees = {
    "evergreen",
    "deciduoustree",
    "moon_tree",
    "palmconetree",
}

local special_trees1 = {
    "winter_palmconetree",
    "winter_tree",
    "winter_deciduoustree",
}

local function OnTreeSpawned(inst)
    if inst and inst:IsValid() then
        -- 检查树是否处于被砍伐、树苗或烧毁阶段
        local isChopped = inst:HasTag("stump") -- 是否是树桩（被砍伐后的状态）
        local isBurnt = inst:HasTag("burnt") -- 是否烧毁
        local isSapling = inst.components.growable and inst.components.growable.stage == 0 -- 是否是幼苗阶段，需要确认树有生长组件并且在第一阶段

        -- 对于 "evergreen"，只有不是幼苗时才处理
        -- 对于其他树种，则不考虑是否为幼苗
        local shouldAddOasis = false
        if tree == "evergreen" then
            if not isSapling then
                shouldAddOasis = true
            end
        else
            shouldAddOasis = true
        end
        -- 确保areaaware组件存在
        if not inst.components.areaaware then
            inst:AddComponent("areaaware")
        end

        -- 确保named组件存在
        if not inst.components.named then
            inst:AddComponent("named")
        end

        -- 监听区域变化事件
-- 创建一个名字和描述的映射表
local nameDescription = {
    ["一颗想长在盛宴盆栽里的树"] = "在这里每年夏天我都感觉树根里有蚂蚁在爬。",
    ["踏沙"] = "曾有一条龙在沙丘逝去，而如今这里绿意盎然。",
    ["13"] = "你也会在此守护吗？",
    ["梦境"] = "梦就是梦，你该醒来了",
    ["迪里-西奥娜"] = "一名树精灵长眠于此。",
    ["爱喝冰红茶的萝卜喵呀"] = "为什么同样是没叶子的树，你就不掉树枝？",
    ["善洲树"] = "只要生命不结束，服务人民不停止。",
    ["泰拉瑞亚"] = "传说有一个世界，没有两棵一模一样的树",
    ["真的是一颗非常普通的树"] = "你最好在天黑前找点吃的。",
    ["心中树"] = "你亲手改变了这片荒漠，也在你的心中种下了一片树林。",
    ["作者想要三连"] = "下次一定（不一定）",
    ["白色夫人的根须"] = "另个世界中智慧巨大植物的根",
    ["连楷树"] = "这不是树，这是香草",
    ["生命树"] = "卧槽nb！",
    ["李"] = "李树再结李之时，李却不在李树下",
    ["天上掉下棵树"] = "你不会想砍了我吧，朋友",
    ["满意的苹果树"] = "哇！好的一颗苹果树，秋天来了我就有苹果吃了！",
    ["不孤独的树"] = "它很享受此刻的安静",
    ["铁树"] = "听说有只树袋熊喜欢",
    ["萌新的树屋"] = "不是吧，还真有人住在里面？！",
    ["不知火舞"] = "我是颗不会自燃的树，不信你点点看。[doge][doge][doge]",
    ["大富大贵"] = "这世上比美国历史和英国食谱更薄的，是你的钱包。",
    ["卡巴拉"] = "十个枝点，二十二条枝干，看上去很健康",
    ["梅贺的日记本"] = "斑斑点点，几行陈迹。[鼓掌][鼓掌][鼓掌]",
    ["桃子"] = "这是一株他为她栽的树，想要用这种方式陪着她",
    ["llllili68249"] = "Up！我想…………  我忘了…………",
    ["树真人"] = "历经饥荒三百天 风沙依旧漫遮天\n身上暗影压天体 拳里嚎弹纵远古\n时来时去十一载 无模何能改天地\n种此千林唤生机 席卷沙漠复绿洲",
    ["树精预备役"] = "它好像在打摩斯电码，“嘿，能不能让我也砍你两斧子……",
    ["枇杷树"] = "庭有枇杷树，吾妻死之年所手植也，今已亭亭如盖矣。",
    ["红松"] = "我好像听到了口笛声",
    -- 要添加更多名字，可以在这里添加
}
inst:ListenForEvent("changearea", function(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition()
    local current_tile = TheWorld.Map:GetTileAtPoint(x, y, z)
    -- 检查是否在指定区域和地皮
    if data and data.tags and table.contains(data.tags, "RoadPoison") and current_tile == specific_tile_type and not isChopped and not isBurnt and shouldAddOasis then
        if not inst.components.named.name or inst.components.named.name == "" then
            inst.components.named.possiblenames = table_concat(MQJZS, XFDBQ, MQJZSHZ)
            inst.components.named:PickNewName()
        end
        if not inst.components.oasis then
            inst:AddComponent("oasis")
        end
        inst.components.oasis.radius = 1
        -- 直接激活防风沙功能
        TheWorld:PushEvent("ms_registeroasis", inst)
        -- 新的部分开始
        if inst.components.inspectable then
            inst:RemoveComponent("inspectable")
        end
        inst:AddComponent("inspectable")
        -- 通过映射表找到对应的描述
        for namePart, description in pairs(nameDescription) do
            if string.find(inst.components.named.name, namePart) ~= nil then
                inst.components.inspectable:SetDescription(description)
                break  -- 找到了就跳出循环
            end
        end
    end
end)
    end
end

-- 遍历所有特殊的树，并为它们注册OnTreeSpawned回调
for _, tree in ipairs(special_trees) do
    AddPrefabPostInit(tree, OnTreeSpawned)
end

local function OnTreeSpawned2(inst)
    if inst and inst:IsValid() then
        -- 确保areaaware组件存在
        if not inst.components.areaaware then
            inst:AddComponent("areaaware")
        end

        -- 确保named组件存在
        if not inst.components.named then
            inst:AddComponent("named")
        end

        -- 监听区域变化事件
-- 创建一个名字和描述的映射表
local nameDescription = {
    ["一颗想长在盛宴盆栽里的树"] = "在这里每年夏天我都感觉树根里有蚂蚁在爬。",
    ["踏沙"] = "曾有一条龙在沙丘逝去，而如今这里绿意盎然。",
    ["13"] = "你也会在此守护吗？",
    ["梦境"] = "梦就是梦，你该醒来了",
    ["迪里-西奥娜"] = "一名树精灵长眠于此。",
    ["爱喝冰红茶的萝卜喵呀"] = "为什么同样是没叶子的树，你就不掉树枝？",
    ["善洲树"] = "只要生命不结束，服务人民不停止。",
    ["泰拉瑞亚"] = "传说有一个世界，没有两棵一模一样的树",
    ["真的是一颗非常普通的树"] = "你最好在天黑前找点吃的。",
    ["心中树"] = "你亲手改变了这片荒漠，也在你的心中种下了一片树林。",
    ["作者想要三连"] = "下次一定（不一定）",
    ["白色夫人的根须"] = "另个世界中智慧巨大植物的根",
    ["连楷树"] = "这不是树，这是香草",
    ["生命树"] = "卧槽nb！",
    ["李"] = "李树再结李之时，李却不在李树下",
    ["天上掉下棵树"] = "你不会想砍了我吧，朋友",
    ["满意的苹果树"] = "哇！好的一颗苹果树，秋天来了我就有苹果吃了！",
    ["不孤独的树"] = "它很享受此刻的安静",
    ["铁树"] = "听说有只树袋熊喜欢",
    ["萌新的树屋"] = "不是吧，还真有人住在里面？！",
    ["不知火舞"] = "我是颗不会自燃的树，不信你点点看。[doge][doge][doge]",
    ["大富大贵"] = "这世上比美国历史和英国食谱更薄的，是你的钱包。",
    ["卡巴拉"] = "十个枝点，二十二条枝干，看上去很健康",
    ["梅贺的日记本"] = "斑斑点点，几行陈迹。[鼓掌][鼓掌][鼓掌]",
    ["桃子"] = "这是一株他为她栽的树，想要用这种方式陪着她",
    ["llllili68249"] = "Up！我想…………  我忘了…………",
    ["树真人"] = "历经饥荒三百天 风沙依旧漫遮天\n身上暗影压天体 拳里嚎弹纵远古\n时来时去十一载 无模何能改天地\n种此千林唤生机 席卷沙漠复绿洲",
    ["树精预备役"] = "它好像在打摩斯电码，“嘿，能不能让我也砍你两斧子……",
    ["枇杷树"] = "庭有枇杷树，吾妻死之年所手植也，今已亭亭如盖矣。",
    ["红松"] = "我好像听到了口笛声",
    -- 要添加更多名字，可以在这里添加
}
inst:ListenForEvent("changearea", function(inst, data)
    local x, y, z = inst.Transform:GetWorldPosition()
    local current_tile = TheWorld.Map:GetTileAtPoint(x, y, z)
    -- 检查是否在指定区域和地皮
    if data and data.tags and table.contains(data.tags, "RoadPoison") then
        if not inst.components.named.name or inst.components.named.name == "" then
            inst.components.named.possiblenames = table_concat(MQJZS, XFDBQ, MQJZSHZ)
            inst.components.named:PickNewName()
        end
        if not inst.components.oasis then
            inst:AddComponent("oasis")
        end
        inst.components.oasis.radius = 1
        -- 直接激活防风沙功能
        TheWorld:PushEvent("ms_registeroasis", inst)
        -- 新的部分开始
        if inst.components.inspectable then
            inst:RemoveComponent("inspectable")
        end
        inst:AddComponent("inspectable")
        -- 通过映射表找到对应的描述
        for namePart, description in pairs(nameDescription) do
            if string.find(inst.components.named.name, namePart) ~= nil then
                inst.components.inspectable:SetDescription(description)
                break  -- 找到了就跳出循环
            end
        end
    end
end)
    end
end

-- 遍历所有特殊的树，并为它们注册OnTreeSpawned回调
for _, tree in ipairs(special_trees1) do
    AddPrefabPostInit(tree, OnTreeSpawned2)
end


-- 检测地皮类型的函数
local function CheckGroundType(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local tile = TheWorld.Map:GetTileAtPoint(x, y, z)
    return tile
end

-- 树变化为marsh_tree的函数
local function TransformToMarshTree(inst)
    if inst and inst:IsValid() then
        local x, y, z = inst.Transform:GetWorldPosition()

        local function CreateAshAtHeight(height, count, interval, skipMiddle)
            for i = -math.floor(count / 2), math.floor(count / 2) do
                if not (skipMiddle and i == 0) then
                    local huij = SpawnPrefab("ash")
                    huij.Transform:SetPosition(x + i * interval, y + height, z) 
                    huij.components.disappears:Disappear()
                end
            end
        end

        -- 各层灰烬生成
        CreateAshAtHeight(3, 5, 1, false)
        CreateAshAtHeight(4, 4, 0.5, true)
        CreateAshAtHeight(5, 3, 1, false)
        CreateAshAtHeight(6, 2, 0.5, true)
        CreateAshAtHeight(7, 1, 0, false)


        local marsh_tree = SpawnPrefab("marsh_tree")
        marsh_tree.Transform:SetPosition(inst.Transform:GetWorldPosition())
        
        -- 设置marsh_tree的初始透明度
        marsh_tree.AnimState:SetMultColour(1, 1, 1, 0)
        marsh_tree:DoTaskInTime(0, function()
            local totalTime = 0.5
            local stepTime = 0.1
            local steps = totalTime / stepTime
            local alphaStep = 1 / steps
            local currentStep = 0
            local task
            task = marsh_tree:DoPeriodicTask(stepTime, function()
                currentStep = currentStep + 1
                local alpha = currentStep * alphaStep
                marsh_tree.AnimState:SetMultColour(1, 1, 1, alpha)
                if currentStep >= steps then
                    task:Cancel()
                end
            end)
        end)

        -- 设置inst的初始透明度为不透明
        inst.AnimState:SetMultColour(1, 1, 1, 1)
        inst:DoTaskInTime(0, function()
            local totalTime = 0.5
            local stepTime = 0.1
            local steps = totalTime / stepTime
            local alphaStep = -1 / steps  -- 注意这里是减少透明度
            local currentStep = 0
            local task
            task = inst:DoPeriodicTask(stepTime, function()
                currentStep = currentStep + 1
                local alpha = 1 + currentStep * alphaStep  -- 从1开始递减
                inst.AnimState:SetMultColour(1, 1, 1, alpha)
                if currentStep >= steps then
                    task:Cancel()
                    inst:Remove()  -- 完全透明后移除原有的树
                end
            end)
        end)
    end
end
local function OnTreeSpawned1(inst)
    if TheWorld.components.sandstorms ~= nil and TheWorld.components.sandstorms:IsSandstormActive() then
                -- 检查树是否处于被砍伐、树苗或烧毁阶段
                local isChopped = inst:HasTag("stump") -- 是否是树桩（被砍伐后的状态）
                local isBurnt = inst:HasTag("burnt") -- 是否烧毁
                local isSapling = inst.components.growable and inst.components.growable.stage == 0 -- 是否是幼苗阶段，需要确认树有生长组件并且在第一阶段
        
                -- 对于 "evergreen"，只有不是幼苗时才处理
                -- 对于其他树种，则不考虑是否为幼苗
                local shouldAddOasis = false
                if tree == "evergreen" then
                    if not isSapling then
                        shouldAddOasis = true
                    end
                else
                    shouldAddOasis = true
                end
        inst:ListenForEvent("changearea", function(inst, data)
            -- 检测是否在沙尘暴中
            if data and data.tags and table.contains(data.tags, "sandstorm") and not isChopped and not isBurnt and shouldAddOasis then
                -- 检测地皮类型是否不是6号地皮
                if CheckGroundType(inst) ~= specific_tile_type then
                    -- 延迟1秒后变化为marsh_tree
                    inst:DoTaskInTime(1, TransformToMarshTree)
                end
            end
        end)
    end
end

-- 遍历所有特殊的树，并为它们注册OnTreeSpawned回调
for _, tree in ipairs(special_trees) do
    AddPrefabPostInit(tree, OnTreeSpawned1)
end