GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})

--1缝纫✓，不能填线轴台词✓，排序调整✓，可以修女王帽✓，上限3500✓，可给予部分帽子换线轴布羽毛啜食者皮触手皮芦苇线轴✓，可修shoetime部分鞋✓，返还部分材料✓，缝纫速度加快✓,牛年兼容
AddSimPostInit(function() 
STRINGS.NAMES.YOTB_SEWINGMACHINE_ITEM = "缝纫机套件"
STRINGS.RECIPE_DESC.YOTB_SEWINGMACHINE_ITEM = "用线轴和机器去缝衣服，伙计。" 
end)

--排序函数
local CRAFTING_FILTERS = GLOBAL.CRAFTING_FILTERS
local function ChangeSortKey(recipe_name, recipe_reference, filter, after)
    local recipes = CRAFTING_FILTERS[filter].recipes
    local recipe_name_index
    local recipe_reference_index

    for i = #recipes, 1, -1 do
        if recipes[i] == recipe_name then
            recipe_name_index = i
        elseif recipes[i] == recipe_reference then
            recipe_reference_index = i + (after and 1 or 0)
        end
        if recipe_name_index and recipe_reference_index then
            if recipe_name_index >= recipe_reference_index then
                table.remove(recipes, recipe_name_index)
                table.insert(recipes, recipe_reference_index, recipe_name)
            else
                table.insert(recipes, recipe_reference_index, recipe_name)
                table.remove(recipes, recipe_name_index)
            end
            break
        end
    end
end

local TTT = GetModConfigData("onlyplayer")
local Shoetime = GLOBAL.KnownModIndex:IsModEnabled("workshop-2039181790")
AddRecipe2("sewingmachine",{Ingredient("sewing_kit", 1), Ingredient("beefalowool", 6), Ingredient("goldnugget", 6), Ingredient("gears", 2)},TECH.SCIENCE_TWO,{product = "yotb_sewingmachine_item"},{"CLOTHING"})

local function NewOnHammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end

    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
	
	inst.components.lootdropper:SpawnLootPrefab("goldnugget")	
	inst.components.lootdropper:SpawnLootPrefab("silk")
	inst.components.lootdropper:SpawnLootPrefab("silk")
	
    inst.components.lootdropper:DropLoot()

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    local fx2 = SpawnPrefab("junk_break_fx")
    fx2.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()
end

AddPrefabPostInit("yotb_sewingmachine",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:DoTaskInTime(0,function() 
	if not inst.niunian then
	    inst:RemoveComponent("container") --废除原有作用
	end	
	end)

	inst:AddComponent("named")
	inst.xianzhou = 233	--初始233线轴
	--inst:RemoveComponent("container") --废除原有作用
	inst.components.workable:SetOnFinishCallback(NewOnHammered)
	
	inst:DoTaskInTime(math.random(1,4),function()  --随机几秒后才会执行，防止缝纫机过于统一
	inst:DoPeriodicTask(0.3,function() 
	    if inst.niunian then
		    return
		end
	    if inst:HasTag("burnt") then
	        inst.components.named:SetName("烧毁的缝纫机")
		end
		local x,y,z = inst.Transform:GetWorldPosition() 
		local dh = false
		local ents
		
		if TTT then
		    ents = TheSim:FindEntities(x,y,z,4)
		else
		    ents = TheSim:FindEntities(x,y,z,4,{"player"})
		end
		
        for k,v in pairs(ents) do
		    if not inst:HasTag("burnt") and inst.xianzhou and inst.xianzhou > 0 and
    		   not v:HasTag("playerghost") and 
			  (v:HasTag("player") or v.prefab == "bernie_active" or v.prefab == "bernie_big" or v.prefab == "sewing_mannequin" or ((v.prefab == "beehat" or v.prefab == "armor_victoria" or v.prefab == "daidai_armor") and 
			   v.components.inventoryitem and v.components.inventoryitem.owner == nil and
			   v.components.armor and v.components.armor:GetPercent() ~= 1) or 
			  (v.components.inventoryitem and v.components.inventoryitem.owner == nil and 
			   v.components.fueled and v.components.fueled.fueltype and v.components.fueled.fueltype == FUELTYPE.USAGE and
			   v.components.fueled:GetPercent() ~= 1 )) then
				
				if v:HasTag("player") or v.prefab == "sewing_mannequin" or v.prefab == "bernie_active" or v.prefab == "bernie_big" then
				    local x,y,z = v.Transform:GetWorldPosition()
				    local body = v.replica.inventory and v.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
	                local head = v.replica.inventory and v.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
		            local hand = v.replica.inventory and v.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				    local shoe = v.replica.inventory and v.replica.inventory:GetEquippedItem(EQUIPSLOTS.SHOES)
					
					if v.prefab == "sewing_mannequin" then
				        body = v.components.inventory and v.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
	                    head = v.components.inventory and v.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
		                hand = v.components.inventory and v.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)					
					end
					
		        if (v.prefab == "daidai" or v.prefab == "bernie_active" or v.prefab == "bernie_big") and v.components.health and v.components.health:GetPercent() ~= 1 and not v.components.health:IsDead() then
					v.components.health:DoDelta(1)
					if v.prefab == "bernie_active" or v.prefab == "bernie_big" then
					   v.components.health:DoDelta(8)
					end
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					    if v.prefab == "daidai" then
					        v.components.sanity:DoDelta(-1.5)
						end
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					if v.prefab == "daidai" then 
					    fxfire.Transform:SetPosition(x,y+0.5,z)
					    fxfire.Transform:SetScale(0.5, 0.5, 0.5)			
                    else
					    fxfire.Transform:SetPosition(x,y+3,z)	
                    end					
				end 
				
				if head and head.prefab == "beehat" and head.components.armor:GetPercent() ~= 1 then
				    head.components.armor:Repair(10)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y+2,z)
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)	
				end
				
				if body and (body.prefab == "armor_victoria" or body.prefab == "daidai_armor") and body.components.armor:GetPercent() <= 0.995 then
				    body.components.armor:Repair(10)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y+0.5,z)
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)	
				end
				if hand and hand.components.fueled and hand.components.fueled.fueltype and hand.components.fueled.fueltype == FUELTYPE.USAGE and hand.components.fueled:GetPercent() <= 0.99 then
				    hand.components.fueled:DoDelta(40, inst)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y+0.5,z)
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)	
				end
		        if head and head.components.fueled and head.components.fueled.fueltype and head.components.fueled.fueltype == FUELTYPE.USAGE and head.components.fueled:GetPercent() <= 0.99 then
				    head.components.fueled:DoDelta(40, inst)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y+2,z)
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)					
				end
		        if body and body.components.fueled and body.components.fueled.fueltype and body.components.fueled.fueltype == FUELTYPE.USAGE and body.components.fueled:GetPercent() <= 0.99 then
				    body.components.fueled:DoDelta(40, inst)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y+0.5,z)
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)	
				end

		        if shoe and shoe.components.fueled and shoe.components.fueled.fueltype and shoe.components.fueled.fueltype == FUELTYPE.USAGE and shoe.components.fueled:GetPercent() <= 0.99 then
				    shoe.components.fueled:DoDelta(40, inst)
					v.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					if inst.xianzhou > 0 then
					   inst.xianzhou = inst.xianzhou-1
					else
					   v.components.sanity:DoDelta(-1.5)
					end
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(x,y-0.3,z)
					fxfire.Transform:SetScale(0.35, 0.35, 0.35)	
				end
				
				elseif inst.xianzhou > 0 then
				    inst.xianzhou = inst.xianzhou-1
				    if v.components.fueled then
					    v.components.fueled:DoDelta(40, inst)
					end
					if v.components.armor then
					    v.components.armor:Repair(10)
					end
					inst.SoundEmitter:PlaySound("yotr_2023/common/pillow_hit_steelwool")
					dh = true 
					local fxfire = SpawnPrefab("attackfx_handpillow_steelwool")
					fxfire.Transform:SetPosition(v.Transform:GetWorldPosition())
					fxfire.Transform:SetScale(0.5, 0.5, 0.5)	
				end
			end
		end
		if dh then
            if not inst:HasTag("burnt") then
                inst.AnimState:PushAnimation("active_loop", true)
                inst.SoundEmitter:KillSound("snd")
                inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/LP", "snd")
            end		
		else
	        if not inst:HasTag("burnt") then
		        inst.SoundEmitter:KillSound("snd")
		        inst.AnimState:PlayAnimation("idle")
		    end
		end
				
		if not inst:HasTag("burnt") then
			inst.components.named:SetName("缝纫机\n线轴："..inst.xianzhou)
		else
			inst.components.named:SetName("烧毁的缝纫机")
		end
	end)
	end)
local function LFShouldAcceptItem(inst, item)
    local owner = item.components.inventoryitem and item.components.inventoryitem.owner
	local can_accept = false
	if owner then
	
	if inst.xianzhou and inst.xianzhou <= 6000 then
    if item.prefab == "earmuffshat" or 
	   item.prefab == "goose_feather" or 
	   item.prefab == "monkey_smallhat" or 
	   item.prefab == "malbatross_feather" or 
	   item.prefab == "malbatross_feathered_weave" or 
	   item.prefab == "winterhat" or 
	   item.prefab == "walrushat" or 
	   item.prefab == "silk" or 
	   item.prefab == "cutreeds" or   
	   item.prefab == "coontail" or 
	   item.prefab == "slurper_pelt" or 
	   item.prefab == "tentaclespots" or   
	   item.prefab == "voidcloth" or 
	   item.prefab == "fabric" or 
	   item.prefab == "lucky_goldnugget" or 
	   
	   item.prefab == "feather_canary" or 
	   item.prefab == "feather_catbird" or 
	   item.prefab == "feather_chaffinch" or 
	   item.prefab == "feather_crow" or 
	   item.prefab == "feather_robin" or 
	   item.prefab == "feather_robin_winter" or
	   
	   item.prefab == "snakeskin" or
	   item.prefab == "palmleaf" or
	   item.prefab == "trinket_22" or  
	   item.prefab == "beefalowool" or 
	   item.prefab == "furtuft" or  
	   item.prefab == "steelwool" or 
	   item.prefab == "beardhair" or 
	   item.prefab == "tinybobbin" or 
	   item.prefab == "manrabbit_tail" or 
	   item.prefab == "sewing_tape" or 
	   item.prefab == "cattenball" then
        can_accept = true
	else
	    if owner.prefab == "willow" then
	        owner.components.talker:Say("把这个当线材用？还不如让我烧了！")
		elseif owner.prefab == "wolfgang" then
		    owner.components.talker:Say("沃尔夫冈认为这个不能作为线轴来用。")
		elseif owner.prefab == "wendy" then
		    owner.components.talker:Say("那只能让衣物比我的心更加千疮百孔。")
		elseif owner.prefab == "wx78" then
		    owner.components.talker:Say("错误，补丁不兼容。")
		elseif owner.prefab == "wickerbottom" then
		    owner.components.talker:Say("亲爱的，我从来没见过用这个缝衣服的。")
		elseif owner.prefab == "woodie" then
		    owner.components.talker:Say("不行，这个甚至都不能修我的格子衫。")
		elseif owner.prefab == "waxwell" then
		    owner.components.talker:Say("我的西服怎么能容许被这种材料羞辱？")
		elseif owner.prefab == "wathgrithr" then
		    owner.components.talker:Say("这个材料无法为勇士们缝补战衣。")
		elseif owner.prefab == "webber" then
		    owner.components.talker:Say("我们觉得用这个修衣服会出大问题的。")
		elseif owner.prefab == "winona" then
		    owner.components.talker:Say("不行，添加用料这种事，一定要严之又严。")
		elseif owner.prefab == "warly" then
		    owner.components.talker:Say("啊，你会用番茄条蘸土豆酱吗？")
		elseif owner.prefab == "wortox" then
		    owner.components.talker:Say("哼，如果这是一场恶作剧，那么我可能会把这东西扔进去。")
		elseif owner.prefab == "wormwood" then
		    owner.components.talker:Say("这个不能让嗖嗖修穿在身上的东西")
		elseif owner.prefab == "wurt" then
		    owner.components.talker:Say("浮浪噗，我很清醒，不会乱塞东西的。")
		elseif owner.prefab == "walter" then
		    owner.components.talker:Say("沃比的毛都比这东西适合缝纫。")
		elseif owner.prefab == "wanda" then
		    owner.components.talker:Say("我没时间在这里给材料试错，拿对的来！")
		elseif owner.prefab == "wirlywings" then
		    owner.components.talker:Say("唔姆，这个肯定不行，我还是有点缝纫知识的！")
		elseif owner.prefab == "daidai" then
		    owner.components.talker:Say("嗯，这个是绝对修不了玩偶和衣服的")
		elseif owner.prefab == "wathom" then
		    owner.components.talker:Say("材料，不正确。")
		elseif owner.prefab == "winky" then
		    owner.components.talker:Say("……我觉得还没有我们的体毛合适。")
		elseif owner.prefab == "wixie" then
		    owner.components.talker:Say("别浪费时间，这个一看就不行。")
		else
		    owner.components.talker:Say("用这个来缝纫是不科学的。")
		end
		
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/close")
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("idle", false)
    end
	else
	    owner.components.talker:Say("线轴已经足够。")
	end
	end
    return can_accept
end

local function LFOnGetItem(inst, giver, item)
	local Can1 = false
	if inst.xianzhou and giver and giver:HasTag("player") then
    if item.prefab == "silk" then
        Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(7,10)
	elseif item.prefab == "beefalowool" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(12,16)
	elseif item.prefab == "steelwool" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(85,110)
	elseif item.prefab == "beardhair" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(12,16)
	elseif item.prefab == "tinybobbin" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(24,36)
	elseif item.prefab == "manrabbit_tail" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(20,30)
	elseif item.prefab == "sewing_tape" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(40,50)
	elseif item.prefab == "cattenball" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(120,180)
	elseif item.prefab == "furtuft" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(20,30)
	elseif item.prefab == "walrushat" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.floor(800*item.components.fueled:GetPercent())
	elseif item.prefab == "winterhat" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.floor(100*item.components.fueled:GetPercent())
	elseif item.prefab == "earmuffshat" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.floor(80*item.components.fueled:GetPercent())
	elseif item.prefab == "monkey_smallhat" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.floor(100*item.components.fueled:GetPercent())
	elseif item.prefab == "malbatross_feathered_weave" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(200,240)
	elseif item.prefab == "malbatross_feather" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(30,40)
	elseif item.prefab == "goose_feather" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(30,40)
		
	elseif item.prefab == "feather_canary" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(20,30)
	elseif item.prefab == "feather_catbird" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(20,30)
	elseif item.prefab == "feather_chaffinch" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(20,30)
	elseif item.prefab == "feather_crow" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(10,20)
	elseif item.prefab == "feather_robin" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(10,20)
	elseif item.prefab == "feather_robin_winter" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(10,20)
	elseif item.prefab == "cutreeds" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(3,5)
	elseif item.prefab == "tentaclespots" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(70,80)	
	elseif item.prefab == "slurper_pelt" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(30,45)
	elseif item.prefab == "coontail" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(24,36)
	elseif item.prefab == "voidcloth" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(100,120)
	elseif item.prefab == "fabric" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(40,50)
	elseif item.prefab == "trinket_22" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(600,700)
	elseif item.prefab == "palmleaf" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(12,16)
	elseif item.prefab == "snakeskin" then
	    Can1 = true
        inst.xianzhou = inst.xianzhou + math.random(24,36)
	elseif item.prefab == "lucky_goldnugget" then
	    if inst.xianzhou > 230 then
        SpawnPrefab("junk_break_fx").Transform:SetPosition(inst.Transform:GetWorldPosition())
		local newji = SpawnPrefab("yotb_sewingmachine")
		newji.Transform:SetPosition(inst.Transform:GetWorldPosition())
		newji.niunian = true
        newji.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/close")
        newji.AnimState:PlayAnimation("hit")
        newji.AnimState:PushAnimation("idle", false)
        inst:Remove()
		end
    end 
	end 
    if Can1 then
        inst.AnimState:PlayAnimation("close")
        inst.SoundEmitter:KillSound("snd")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/stop")
        inst.SoundEmitter:PlaySound("yotb_2021/common/sewing_machine/done")
	end
end
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(LFShouldAcceptItem)
    inst.components.trader.onaccept = LFOnGetItem
    inst.components.trader.onrefuse = function() end
	inst.components.trader.acceptnontradable = true
    inst.components.trader:Enable()

local function OnSaveL(inst, data) --数据保存
    if inst.xianzhou then 
       data.xianzhou = inst.xianzhou 
	end
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end
local function OnLoadL(inst, data)
if data ~= nil then
	if data.xianzhou and inst.xianzhou then 
        inst.xianzhou = data.xianzhou
	end
    if data.burnt then
        inst.components.burnable.onburnt(inst)
    end
end
end
	inst.OnSave = OnSaveL
	inst.OnLoad = OnLoadL
end)

--毛丛可交易
AddPrefabPostInit("furtuft",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("tradable")
end)
--钢丝棉可交易
AddPrefabPostInit("steelwool",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("tradable")
end)
--胶带可交易
AddPrefabPostInit("sewing_tape",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("tradable")
end)
--小线轴可交易
AddPrefabPostInit("tinybobbin",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("tradable")
end)
--胡须可交易
AddPrefabPostInit("beardhair",function(inst)
	if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("tradable")
end)

ChangeSortKey("sewingmachine", "sewing_kit", "CLOTHING", true)