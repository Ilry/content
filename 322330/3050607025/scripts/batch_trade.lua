local _G = GLOBAL
local TheNet = _G.TheNet
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

-- 目前只支持鱼人王、猪王、鸟笼、蚁狮
-- 猪王、鸟笼相关代码参考自暴力老奶奶/Roger 感谢你们

-- 重写给予动作
local old_give_fn = _G.ACTIONS.GIVE.fn
_G.ACTIONS.GIVE.fn = function(act)
    -- 给予对象是鸟笼、或者猪王
    if act.target and (act.target.prefab == "birdcage" or act.target.prefab == "pigking" 
		or act.target.prefab == "mermking" or act.target.prefab == "antlion") then
        -- 获取能否给予，失败原因
        local able, reason = act.target.components.trader:AbleToAccept(act.invobject, act.doer)
        -- 如果不能给予
        if not able then
            return false, reason
        end
        -- 给予物品
        local count = (act.invobject and act.invobject.components and act.invobject.components.stackable) and act.invobject.components.stackable:StackSize() or 1
        -- 金腰带: 一个一个给,总不能给10个开一次活动
        if act.invobject.prefab == "pig_token" then count = 1 end
        act.target.components.trader:AcceptGift(act.doer, act.invobject,count)
        return true
    end
    return old_give_fn(act)
end

-- 鱼人王、猪王共用此函数
local function launchitem(item, angle)
    local speed = math.random() * 4 + 2
    angle = (angle + math.random() * 60 - 30) * _G.DEGREES
    item.Physics:SetVel(speed * math.cos(angle), math.random() * 2 + 8, speed * math.sin(angle))
end


-- ==================== 鱼人王相关 ====================
-- 鱼人王交易物品
local trading_items =
{
    { prefabs = { "kelp"  },         min_count = 2, max_count = 4, reset = false, add_filler = false, },
    { prefabs = { "kelp"  },         min_count = 2, max_count = 3, reset = false, add_filler = false, },
    { prefabs = { "seeds" },         min_count = 4, max_count = 6, reset = false, add_filler = false, },
    { prefabs = { "tentaclespots" }, min_count = 1, max_count = 1, reset = false, add_filler = true,  },
    { prefabs = { "cutreeds" },      min_count = 1, max_count = 2, reset = false, add_filler = true,  },

    {
        prefabs = { -- These trinkets are generally good for team play, but tend to be poor for solo play.
            -- Theme
            "trinket_12", -- Dessicated Tentacle
            "trinket_25", -- Air Unfreshener
            -- Team
            "trinket_1", -- Melted Marbles
            -- Fishing
            "trinket_17", -- Bent Spork
            "trinket_8", -- Rubber Bung
        },
        min_count = 1, max_count = 1, reset = false, add_filler = true,
    },

    {
        prefabs = { "durian_seeds", "pepper_seeds", "eggplant_seeds", "pumpkin_seeds", "onion_seeds", "garlic_seeds"  },
        min_count = 1, max_count = 2, reset = false, add_filler = true,
    },
}
local trading_filler = { "seeds", "kelp", "seeds", "seeds"}

-- 鱼人王批量交易项
local function TradeItem(inst)

    local item = inst.itemtotrade
    local giver = inst.tradegiver

    local x, y, z = inst.Transform:GetWorldPosition()
    y = 5.5

    local angle
    if giver ~= nil and giver:IsValid() then
        angle = 180 - giver:GetAngleToPoint(x, 0, z)
    else
        local down = TheCamera:GetDownVec()
        angle = math.atan2(down.z, down.x) / DEGREES
        giver = nil
    end

    local selected_index = math.random(1, #inst.trading_items)
    local selected_item = inst.trading_items[selected_index]

    local isabigheavyfish = item.components.weighable and item.components.weighable:GetWeightPercent() >= TUNING.WEIGHABLE_HEAVY_WEIGHT_PERCENT or false
    local bigheavyreward = isabigheavyfish and math.random(1, 2) or 0

    local filler_min = 2 -- Not biasing minimum for filler.
    local filler_max = 4 + bigheavyreward
    local reward_count = math.random(selected_item.min_count, selected_item.max_count) + bigheavyreward


    -- 物品可堆叠,获取堆叠数量,否则数量为1
    local count = (item.components and item.components.stackable) and item.components.stackable:StackSize() or 1
    for i = 1, count do     
		for k = 1, reward_count do
			local reward_item = SpawnPrefab(selected_item.prefabs[math.random(1, #selected_item.prefabs)])
			reward_item.Transform:SetPosition(x, y, z)
			launchitem(reward_item, angle)
		end
		
		if selected_item.add_filler then
			for i=filler_min, filler_max do
				local filler_item = SpawnPrefab(trading_filler[math.random(1, #trading_filler)])
				filler_item.Transform:SetPosition(x, y, z)
				launchitem(filler_item, angle)
			end
		end
		if item:HasTag("oceanfish") then
			local goldmin, goldmax, goldprefab = 1, 2, "goldnugget"
			if item.prefab:find("oceanfish_medium_") == 1 then
				goldmin, goldmax = 2, 4
				if item.prefab == "oceanfish_medium_6_inv" or item.prefab == "oceanfish_medium_7_inv" then -- YoT events.
					goldprefab = "lucky_goldnugget"
				end
			end

			local amt = math.random(goldmin, goldmax) + bigheavyreward
			for i = 1, amt do
				local reward_item = SpawnPrefab(goldprefab)
				reward_item.Transform:SetPosition(x, y, z)
				launchitem(reward_item, angle)
			end
		end
    end
	
	-- Cycle out rewards.
	table.remove(inst.trading_items, selected_index)
	if #inst.trading_items == 0 or selected_item.reset then
		inst.trading_items = deepcopy(trading_items)
	end

    inst.itemtotrade = nil
    inst.tradegiver  = nil

    item:Remove()
end

-- 鱼人王批量喂食
local function OnGetItemFromPlayer(inst, giver, item)
    if item.components.edible ~= nil then
        if inst.components.combat:TargetIs(giver) then
            inst.components.combat:SetTarget(nil)
        end

		-- 检查是否属于鱼人王可吃食物
		if inst.components.eater:CanEat(item) then
			-- 获取食物堆叠数量
			local count = (item.components and item.components.stackable) and item.components.stackable:StackSize() or 1
			-- 循环喂食
			for i = 1, count do   
				local hunger = item.components.edible:GetHunger(inst)
				local chews = 2 -- Most crockpot foods.
				if hunger < TUNING.CALORIES_SMALL then -- 12.5
					chews = 0
				elseif hunger < TUNING.CALORIES_MEDSMALL then -- 18.75
					chews = 1
				end
				inst.sg:GoToState("eat", { chews = chews, })
				inst.components.eater:Eat(item)
			end
		-- 鱼人王不可食用的食物
		-- 归还物品
		else
			inst.sg:GoToState("trade")
			inst.itemtotrade = item
			inst.tradegiver = giver
		end
    end
end
-- 鱼人王初始化时执行
AddPrefabPostInit("mermking",function (inst)
	-- 批量交易
    inst.TradeItem = TradeItem
	-- 批量喂食
	inst.components.trader.onaccept = OnGetItemFromPlayer
end)

-- ==================== 猪王相关 ====================
local function ontradeforgold(inst, item, giver)
    _G.AwardPlayerAchievement("pigking_trader", giver)

    local x, y, z = inst.Transform:GetWorldPosition()
    y = 4.5

    local angle
    if giver ~= nil and giver:IsValid() then
        angle = 180 - giver:GetAngleToPoint(x, 0, z)
    else
        local down = _G.TheCamera:GetDownVec()
        angle = math.atan2(down.z, down.x) / _G.DEGREES
        giver = nil
    end

    for k = 1, item.components.tradable.goldvalue do
        local nug = _G.SpawnPrefab("goldnugget")
        nug.Transform:SetPosition(x, y, z)
        launchitem(nug, angle)
    end

    if item.components.tradable.tradefor ~= nil then
        for _, v in pairs(item.components.tradable.tradefor) do
            local item = _G.SpawnPrefab(v)
            if item ~= nil then
                item.Transform:SetPosition(x, y, z)
                launchitem(item, angle)
            end
        end
    end

    if _G.IsSpecialEventActive(_G.SPECIAL_EVENTS.HALLOWED_NIGHTS) then
        -- pick out up to 3 types of candies to throw out
        local candytypes = { math.random(_G.NUM_HALLOWEENCANDY), math.random(_G.NUM_HALLOWEENCANDY), math.random(_G.NUM_HALLOWEENCANDY) }
        local numcandies = (item.components.tradable.halloweencandyvalue or 1) + math.random(2) + 2

        -- only people in costumes get a good amount of candy!
        if giver ~= nil and giver.components.skinner ~= nil then
            for _, item in pairs(giver.components.skinner:GetClothing()) do
                if _G.DoesItemHaveTag(item, "COSTUME") or _G.DoesItemHaveTag(item, "HALLOWED") then
                    numcandies = numcandies + math.random(4) + 2
                    break
                end
            end
        end

        for k = 1, numcandies do
            local candy = _G.SpawnPrefab("halloweencandy_".._G.GetRandomItem(candytypes))
            candy.Transform:SetPosition(x, y, z)
            launchitem(candy, angle)
        end
    end
end
AddPrefabPostInit("pigking",function (inst)
    local old_onaccept =  inst.components.trader.onaccept
    inst.components.trader.onaccept = function(inst, giver, item)
        local is_event_item = _G.IsSpecialEventActive(_G.SPECIAL_EVENTS.HALLOWED_NIGHTS) and item.components.tradable.halloweencandyvalue and item.components.tradable.halloweencandyvalue > 0

        if item.components.tradable.goldvalue > 0 or is_event_item then
            inst.sg:GoToState("cointoss")
            inst:DoTaskInTime(2 / 3, function (inst, item, giver)
                -- 物品可堆叠,获取堆叠数量,否则数量为1
                local count = (item.components and item.components.stackable) and item.components.stackable:StackSize() or 1
                for i = 1, count do                 
                    ontradeforgold(inst, item, giver)
                end
            end, item, giver)
        else 
            old_onaccept(inst, giver, item)
        end
    end
end)

-- ==================== 鸟笼相关 ====================
local function DigestFood(inst, food)
    if food.components.edible.foodtype == _G.FOODTYPE.MEAT then
        -- 如果食物有肉度,掉落鸡蛋
        if inst.components.occupiable and inst.components.occupiable:GetOccupant() and inst.components.occupiable:GetOccupant():HasTag("bird_mutant") then
            inst.components.lootdropper:SpawnLootPrefab("rottenegg")
        else
            inst.components.lootdropper:SpawnLootPrefab("bird_egg")
        end
    else
        if inst.components.occupiable and inst.components.occupiable:GetOccupant() and inst.components.occupiable:GetOccupant():HasTag("bird_mutant") then
            -- 月鸟掉落腐烂食物
            inst.components.lootdropper:SpawnLootPrefab("spoiled_food")

        else
            local seed_name = string.lower(food.prefab .. "_seeds")
            if _G.Prefabs[seed_name] ~= nil then
                -- 掉落作物
                inst.components.lootdropper:SpawnLootPrefab(seed_name)
            else
                -- 1/3概率掉落鸟粪
                if math.random() < 0.33 then
                    local loot = inst.components.lootdropper:SpawnLootPrefab("guano")
                    loot.Transform:SetScale(.33, .33, .33)
                end
            end
        end
    end

    -- 填充鸟胃
    local bird = (inst.components.occupiable and inst.components.occupiable:GetOccupant()) or nil
    if bird and bird:IsValid() and bird.components.perishable then
        bird.components.perishable:SetPercent(1)
    end
end
AddPrefabPostInit("birdcage",function (inst)
    inst.components.trader.onaccept = function (inst, giver, item)
        -- 睡你个头,起来嗨
        if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end
        -- 可食用/作物/种子
        if item.components.edible ~= nil and
            (   item.components.edible.foodtype == _G.FOODTYPE.MEAT
                or item.prefab == "seeds"
                or string.match(item.prefab, "_seeds")
                or _G.Prefabs[string.lower(item.prefab .. "_seeds")] ~= nil
            ) then
            -- 播放鸟的蹦迪动画
            inst.AnimState:PlayAnimation("peck")
            inst.AnimState:PushAnimation("peck")
            inst.AnimState:PushAnimation("peck")
            inst.AnimState:PushAnimation("hop")
            inst.AnimState:PushAnimation("idle"..inst.CAGE_STATE, true)
            -- 60帧后执行
            inst:DoTaskInTime(60 * _G.FRAMES, function (inst, food)
                -- 物品可堆叠,获取堆叠数量,否则数量为1
                local count = (food.components and food.components.stackable) and food.components.stackable:StackSize() or 1
                for i = 1, count do                 
                    DigestFood(inst, food)
                end
            end, item)
        end
    end
end)
-- 蚁狮
AddPrefabPostInit("antlion",function (inst)
    local old_onaccept = inst.components.trader.onaccept
    inst.components.trader.onaccept = function(inst, giver, item)
        -- 兼容勋章,如果接受的是打包的,使用原来的接收函数
        if item.components.unwrappable then
            old_onaccept(inst, giver, item)
            return
        end
        -- 贡品有温度
        if item.currentTempRange ~= nil then
            -- NOTES(JBK): currentTempRange is only on heatrock and now dumbbell_heat no need to check prefab here.
            local trigger =
                (item.currentTempRange <= 1 and "freeze") or
                (item.currentTempRange >= 4 and "burn") or
                nil
            if trigger ~= nil then
                inst:PushEvent("onacceptfighttribute", { tributer = giver, trigger = trigger })
                return
            end
        end
        -- 贡献者
        inst.tributer = giver
        -- 返还物品
        local count = (item.components and item.components.stackable) and item.components.stackable:StackSize() or 1
        if item.prefab == "antliontrinket" or item.prefab == "cotl_trinket" or item.components.tradable.goldvalue > 0  then
			inst.pendingrewarditem = {}
            for i=1, count do
                if item.prefab == "antliontrinket" then
                    table.insert(inst.pendingrewarditem,"townportal_blueprint")
                    table.insert(inst.pendingrewarditem,"antlionhat_blueprint")
                elseif item.prefab == "cotl_trinket" then
                    table.insert(inst.pendingrewarditem,"turf_cotl_brick_blueprint")
                    table.insert(inst.pendingrewarditem,"turf_cotl_gold_blueprint")
                    table.insert(inst.pendingrewarditem,"cotl_tabernacle_level1_blueprint")
                else
                    table.insert(inst.pendingrewarditem,"townportaltalisman")
                end
            end
        else
            inst.pendingrewarditem = nil
        end

        -- 贡品可以平息的愤怒时间
        local rage_calming = item.components.tradable.rocktribute * _G.TUNING.ANTLION_TRIBUTE_TO_RAGE_TIME * count
		inst.maxragetime = math.min(inst.maxragetime + rage_calming, _G.TUNING.ANTLION_RAGE_TIME_MAX)
        -- 蚁狮剩余愤怒时间计算
		local ANTLION_RAGE_TIMER = "rage"
        local timeleft = inst.components.worldsettingstimer:GetTimeLeft(ANTLION_RAGE_TIMER)
        if timeleft ~= nil then
            timeleft = math.min(timeleft + rage_calming, _G.TUNING.ANTLION_RAGE_TIME_MAX)
            inst.components.worldsettingstimer:SetTimeLeft(ANTLION_RAGE_TIMER, timeleft)
            inst.components.worldsettingstimer:ResumeTimer(ANTLION_RAGE_TIMER)
        else
            inst.components.worldsettingstimer:StartTimer(ANTLION_RAGE_TIMER, inst.maxragetime)
        end
        -- 阻止发病(放地陷/落石)
        inst.components.sinkholespawner:StopSinkholes()
        -- 推送接收贡品事件
        inst:PushEvent("onaccepttribute", { tributepercent = (timeleft or 0) / _G.TUNING.ANTLION_RAGE_TIME_MAX })
        -- 玩家开始拍马屁
        if giver ~= nil and giver.components.talker ~= nil and _G.GetTime() - (inst.timesincelasttalker or -_G.TUNING.ANTLION_TRIBUTER_TALKER_TIME) > _G.TUNING.ANTLION_TRIBUTER_TALKER_TIME then
            inst.timesincelasttalker = _G.GetTime()
            giver.components.talker:Say(_G.GetString(giver, "ANNOUNCE_ANTLION_TRIBUTE"))
        end
    end
end)