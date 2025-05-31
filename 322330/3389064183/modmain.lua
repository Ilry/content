GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

Assets = {
	Asset("ATLAS", "images/wmb_mapicons.xml"),
	Asset("IMAGE", "images/wmb_mapicons.tex"),
	Asset("SOUNDPACKAGE", "sound/wmbmusic.fev"),
	Asset("SOUND", "sound/wmbmusic_1.fsb"),
}

AddMinimapAtlas("images/wmb_mapicons.xml")

local TechTree = require("techtree")
--local modName = "WMB"

--[[说明:
本模组兼容"WX自动化"模组,其机器人的prefab字符串为"wx"
]]


--是否跟随友好玩家
--[[
已驯化的实体跟随任何实体都视为友好玩家,除非开启PVP
开启PVP的情况下,该函数只会返回false
(毕竟饥荒原版没有队伍系统)
]]
local function HasFriendlyLeader(inst)
	if not TheNet:GetPVPEnabled() then
		local inst_leader = (inst.components.follower and inst.components.follower.leader) or nil
		
		if inst_leader then
			if inst_leader.components.inventoryitem then
				inst_leader = inst_leader.components.inventoryitem:GetGrandOwner()
			end

			return (inst_leader and inst_leader:HasTag("player"))
				or (inst.components.domesticatable and inst.components.domesticatable:IsDomesticated())
		end	
	end

    return false
end

--总开关检测
local function MainSwitch(name)
	return GetModConfigData(name.."_main") or false
end

--懒得写replica,将就着用吧
AddComponentPostInit("upgrademoduleowner", function(UpgradeModuleOwner)
	UpgradeModuleOwner.inst:AddTag("upgrademoduleowner")
end)
AddComponentPostInit("upgrademodule", function(UpgradeModule)
	UpgradeModule.inst:AddTag("WMB_upgrademodule")
end)


----↓WX78↓----
if MainSwitch('wx78') then 

local wx78PotatoCharge = GetModConfigData("wx78_potatocharge")
local wx78NitreCharge = GetModConfigData("wx78_nitrecharge")
local wx78Discharge = GetModConfigData("wx78_discharge")
local wx78LightningCharge = GetModConfigData("wx78_lightningcharge")
local wx78Dry = GetModConfigData("wx78_dry")

TUNING.WX78_CHARGE_REGENTIME = GetModConfigData("wx78_chargeperiod")

--土豆充电
if wx78PotatoCharge then
	TUNING.WX78_CHARGING_FOODS["potato"] = 1
end

--硝石充电
if wx78NitreCharge then
	TUNING.WX78_CHARGING_FOODS["nitre"] = 1
end

--WX78初始化
AddPrefabPostInit("wx78", function(wx)
	if not TheWorld.ismastersim then return wx end
	
	--雷击充电优化
	if wx78LightningCharge and wx.components.playerlightningtarget then
		wx.components.playerlightningtarget:SetOnStrikeFn(function(inst)
			if inst.components.health and not inst.components.health:IsDead() then
				local charge = 6
				local empty = inst.components.upgrademoduleowner.max_charge - inst.components.upgrademoduleowner.charge_level

				if inst.components.inventory:IsInsulated() then
					charge = 2
				else
					inst.components.sanity:DoDelta(-TUNING.SANITY_LARGE)
					inst.sg:GoToState("electrocute")
				end

				--溢出的电量用于回血
				inst.components.upgrademoduleowner:AddCharge(charge)
				if charge >= empty then
					charge = charge - empty
					if charge > 0 then
						inst.components.health:DoDelta(15*charge, false, "lightning")
					end
				end
			end
		end)
	end
	
	--更快干燥
	if wx78Dry and wx.components.moisture then
		wx.components.moisture.maxDryingRate = wx.components.moisture.maxDryingRate + 0.15
		wx.components.moisture.baseDryingRate = wx.components.moisture.baseDryingRate + 0.15
	end
end)
AddPrefabPostInit("wx", function(wx) --WX自动化兼容
	if not TheWorld.ismastersim then return wx end
	
	--雷击充电优化
	if wx78LightningCharge and wx.components.playerlightningtarget then
		wx.components.playerlightningtarget:SetOnStrikeFn(function(inst)
			if inst.components.health and not inst.components.health:IsDead() then
				local charge = 6
				local empty = inst.components.upgrademoduleowner.max_charge - inst.components.upgrademoduleowner.charge_level

				if inst.components.inventory:IsInsulated() then
					charge = 2
				end

				--溢出的电量用于回血
				inst.components.upgrademoduleowner:AddCharge(charge)
				if charge > empty then
					charge = charge - empty
				end
				if charge > 0 then
					inst.components.health:DoDelta(15*charge, false, "lightning")
				end
			end
		end)
	end
	
	--更快干燥
	if wx78Dry and wx.components.moisture then
		wx.components.moisture.maxDryingRate = wx.components.moisture.maxDryingRate + 0.05
		wx.components.moisture.baseDryingRate = wx.components.moisture.baseDryingRate + 0.05
	end	
end)

--生物数据工艺
if GetModConfigData("wx78_scandatacrafts") then
	--莎草纸转换
	AddRecipe2("wmb_wx78_papyrus_to_scandata",
		{
			Ingredient("papyrus", 1),
			Ingredient(CHARACTER_INGREDIENT.SANITY, 5),
		},
		TECH.NONE, 
		{builder_tag="upgrademoduleowner", numtogive=10, product="scandata", description="wmb_wx78_papyrus_to_scandata", no_deconstruction=true},
		{"MODS", "CHARACTER"}
	)
	AddRecipe2("wmb_wx78_scandata_to_papyrus",
		{
			Ingredient("scandata", 10),
			Ingredient(CHARACTER_INGREDIENT.SANITY, 10),
		},
		TECH.NONE, 
		{builder_tag="upgrademoduleowner", product="papyrus", description="wmb_wx78_scandata_to_papyrus", no_deconstruction=true},
		{"MODS", "CHARACTER"}
	)
	STRINGS.RECIPE_DESC.WMB_WX78_PAPYRUS_TO_SCANDATA = "生物数据当然可以自己编，就像你大学论文的数据。" 
	STRINGS.RECIPE_DESC.WMB_WX78_SCANDATA_TO_PAPYRUS = "对于看不懂的人来说，是这样的。" 
end


--右键充电动作注册
local WMB_CHARGE = Action({priority = 3, mount_valid = true})
WMB_CHARGE.id = "WMB_CHARGE"
WMB_CHARGE.str = "充电"
WMB_CHARGE.fn = function(act)
	local target = act.target or act.doer
	if act.invobject == nil or target == nil or target.components.upgrademoduleowner == nil then return false end
	local charge = TUNING.WX78_CHARGING_FOODS[act.invobject.prefab]

	if charge ~= nil then
		if target.components.eater and act.invobject.components.edible and target.components.eater:CanEat(act.invobject) then
			if act.invobject.components.edible.healthvalue < 0 then
				act.invobject.components.edible.healthvalue = 0
			end
			if act.invobject.components.edible.hungervalue < 0 then
				act.invobject.components.edible.hungervalue = 0
			end
			if act.invobject.components.edible.sanityvalue < 0 then
				act.invobject.components.edible.sanityvalue = 0
			end
			target.components.eater:Eat(act.invobject)
			return true
		elseif not target.components.upgrademoduleowner:ChargeIsMaxed() then
			if act.invobject.components.stackable then
				act.invobject.components.stackable:Get():Remove()
			else
				act.invobject:Remove()
			end
			target.components.upgrademoduleowner:AddCharge(charge)
			return true
		end
	end

	return false
end

AddAction(WMB_CHARGE)

AddComponentAction("INVENTORY", "edible", function(inst, doer, actions, right)
	if TUNING.WX78_CHARGING_FOODS[inst.prefab] ~= nil and doer:HasTag("upgrademoduleowner") then
        table.insert(actions, ACTIONS.WMB_CHARGE)
    end
end)
AddComponentAction("USEITEM", "edible", function(inst, doer, target, actions, right)
	if right and TUNING.WX78_CHARGING_FOODS[inst.prefab] ~= nil and target:HasTag("upgrademoduleowner") then
        table.insert(actions, ACTIONS.WMB_CHARGE)
    end
end)

local function wmb_charge_action_handler(inst, act)
	if act.target == nil then 
		return "quickeat"
	end
	return "give"
end
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WMB_CHARGE, wmb_charge_action_handler))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.WMB_CHARGE, wmb_charge_action_handler))


--右键输电动作注册
local WMB_DISCHARGE = Action({priority = 3, mount_valid = true})
WMB_DISCHARGE.id = "WMB_DISCHARGE"
WMB_DISCHARGE.str = "输电"
WMB_DISCHARGE.fn = function(act)
	local target = act.target or act.invobject
	if target == nil or act.doer == nil then return false end

	if act.doer.components.upgrademoduleowner and not act.doer.components.upgrademoduleowner:IsChargeEmpty() then
		local percent = target.components.fueled:GetPercent()
		if percent < 1 then
			act.doer.components.upgrademoduleowner:AddCharge(-1)
			target.components.fueled:SetPercent(math.min(1, percent + 0.25))
			return true
		end
	end

	return false
end

AddAction(WMB_DISCHARGE)

AddComponentAction("INVENTORY", "fueled", function(inst, doer, actions, right)
	if right and wx78Discharge and inst.prefab == "nightstick" and doer:HasTag("upgrademoduleowner") then
        table.insert(actions, ACTIONS.WMB_DISCHARGE)
    end
end)
AddComponentAction("SCENE", "fueled", function(inst, doer, actions, right)
	if right and wx78Discharge and inst.prefab == "nightstick" and doer:HasTag("upgrademoduleowner") then
        table.insert(actions, ACTIONS.WMB_DISCHARGE)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WMB_DISCHARGE, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.WMB_DISCHARGE, "give"))

end
----↑WX78↑----




----↓物品制作配方调整↓----
if MainSwitch('recipes') then 

--更改制作配方
local function ChangeRecipe(name, ingredients, hasCharacterIngredients)
	local recipe = AllRecipes[name]
	recipe.ingredients = {}
	if hasCharacterIngredients then recipe.character_ingredients = {} end
	for _,v in pairs(ingredients) do
		table.insert((IsCharacterIngredient(v.type) and recipe.character_ingredients) or recipe.ingredients, v)
	end
end

--扫描仪
if GetModConfigData("recipe_scanner") then
	ChangeRecipe("wx78_scanner_item",
		{
			Ingredient("transistor", 1),
			Ingredient("silk", 1),
			Ingredient("gears", 1),
			Ingredient("wagpunk_bits", 1),
		}
	)
end

--处理器电路
if GetModConfigData("recipe_sanity1") then
	ChangeRecipe("wx78module_maxsanity1",
		{
			Ingredient("scandata", 1),
			Ingredient("goldnugget", 1),
			Ingredient("petals", 6),
		}
	)
end
if GetModConfigData("recipe_sanity") then
	ChangeRecipe("wx78module_maxsanity",
		{
			Ingredient("scandata", 3),
			Ingredient("nightmarefuel", 2),
			Ingredient("transistor", 4),
			Ingredient("wx78module_maxsanity1", 1),
		}
	)
end

--豆增压电路
if GetModConfigData("recipe_bee") then
	ChangeRecipe("wx78module_bee",
		{
			Ingredient("scandata", 20),
			Ingredient("honeycomb", 2),
			Ingredient("royal_jelly", 4),
		}
	)
end

--合唱盒电路
if GetModConfigData("recipe_music") then
	ChangeRecipe("wx78module_music",
		{
			Ingredient("scandata", 20),
			Ingredient("singingshell_octave5", 1, nil, nil, "singingshell_octave5_3.tex"),
			Ingredient("singingshell_octave4", 1, nil, nil, "singingshell_octave4_3.tex"),
			Ingredient("singingshell_octave3", 1, nil, nil, "singingshell_octave3_3.tex"),
			Ingredient("onemanband", 1),
			Ingredient("wateringcan", 1),
		}
	)
end

--胃增益电路
if GetModConfigData("recipe_hunger1") then
	ChangeRecipe("wx78module_maxhunger1",
		{
			Ingredient("scandata", 2),
			Ingredient("houndstooth", 3),
			Ingredient("meat", 2),
			Ingredient("monstermeat", 2),
		}
	)
end
if GetModConfigData("recipe_hunger") then
	ChangeRecipe("wx78module_maxhunger",
		{
			Ingredient("scandata", 3),
			Ingredient("armorslurper", 1),
			Ingredient("wx78module_maxhunger1", 1),
		}
	)
end

--热能电路
if GetModConfigData("recipe_heat") then
	ChangeRecipe("wx78module_heat",
		{
			Ingredient("scandata", 6),
			Ingredient("redgem", 1),
			Ingredient("charcoal", 10),
		}
	)
end

--制冷电路
if GetModConfigData("recipe_cold") then
	ChangeRecipe("wx78module_cold",
		{
			Ingredient("scandata", 6),
			Ingredient("bluegem", 1),
			Ingredient("ice", 10),
		}
	)
end

--电气化电路
if GetModConfigData("recipe_taser") then
	ChangeRecipe("wx78module_taser",
		{
			Ingredient("scandata", 10),
			Ingredient("nightstick", 1),
			Ingredient("goatmilk", 1),
		}
	)
end

--光电电路
if GetModConfigData("recipe_night") then
	ChangeRecipe("wx78module_nightvision",
		{
			Ingredient("scandata", 8),
			Ingredient("purplegem", 1),
			Ingredient("mole", 1),
		}
	)
end

--照明电路
if GetModConfigData("recipe_light") then
	ChangeRecipe("wx78module_light",
		{
			Ingredient("scandata", 6),
			Ingredient("yellowgem", 1),
			Ingredient("lightbulb", 6),
		}
	)
end

end
----↑物品制作配方调整↑----




----↓扫描仪↓----
if MainSwitch("scanner") then

local sannerSpdMult = GetModConfigData("scanner_spd")
local sannerRepair = GetModConfigData("scanner_repair")
local sannerRepairPeriod = GetModConfigData("scanner_repairperiod")

TUNING.WX78_SCANNER_MODULETARGETSCANTIME = GetModConfigData("scanner_scantime")
TUNING.WX78_SCANNER_MODULETARGETSCANTIME_EPIC = GetModConfigData("scanner_scantime2")


--扫描仪初始化
AddPrefabPostInit("wx78_scanner", function(inst)
	--扫描仪移速
	if TheWorld.ismastersim and inst.components.locomotor then
		inst.components.locomotor:SetExternalSpeedMultiplier(inst, "WMB_scannerspeedmult", sannerSpdMult)
	end
end)

--扫描仪容器
if GetModConfigData("scanner_container") then

--注册容器
local containers = require("containers")
local params = containers.params
params.wmb_wx78scanner =
{
widget =
	{
        slotpos = {},
        animbank = "ui_tacklecontainer_3x2",
        animbuild = "ui_tacklecontainer_3x2",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
	},
	type = "chest",
	openlimit = 1,
	itemtestfn = function(inst, item, slot)
		return item:HasTag("WMB_upgrademodule")
			--or (string.sub(item.prefab, 1, 11) == "wx78module_")
			or (item.prefab == "wx78_moduleremover")
			or (item.prefab == "scandata")
			or (item.prefab == "gears")
			or (item.prefab == "transistor")
			or (item.prefab == "wagpunk_bits")
			or (item.prefab == "trinket_6")
	end		
}

for y = 1, 0, -1 do
    for x = 0, 2 do
        table.insert(params.wmb_wx78scanner.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
    end
end

--恢复容器内电路1%耐久
local function RestoreModules(inst)
	if not inst.components.container then return end
	for _,item in pairs(inst.components.container.slots) do
		if item.components.upgrademodule and item.components.finiteuses then
			local percent = item.components.finiteuses:GetPercent()
			if percent < 1 then
				item.components.finiteuses:SetPercent(math.min(1, percent + 0.01))
			end
		end
	end
end

--物品状态扫描仪初始化
AddPrefabPostInit("wx78_scanner_item", function(inst)
	if not TheWorld.ismastersim then
		local oldfn = inst.OnEntityReplicated or function() end
		inst.OnEntityReplicated = function(inst) 
			inst.replica.container:WidgetSetup("wmb_wx78scanner")
			oldfn(inst)
		end
		return inst
	end

	--添加容器
	if inst.components.container == nil then
		inst:AddComponent("container")
		inst.components.container:WidgetSetup("wmb_wx78scanner")
		inst.components.container.skipclosesnd = true
		inst.components.container.skipopensnd = true
	end
	
	--修复内含电路
	if sannerRepair then
		if inst.WMB_RestoreTask == nil then
			inst.WMB_RestoreTask = inst:DoPeriodicTask(sannerRepairPeriod, RestoreModules)
		end
	end	
end)

--放置时丢下扫描仪内容物
local oldondeploy = ACTIONS.DEPLOY.fn or function() end
ACTIONS.DEPLOY.fn = function(act)
	local target = act.invobject or act.target
	if target ~= nil and target.prefab == "wx78_scanner_item" then
		if target.components.container then
			target.components.container:DropEverything()
		end		
	end
	return oldondeploy(act)
end

--打开优先而不是放置(适配牛牛的改动mod)
AddComponentAction("INVENTORY", "deployable", function(inst, doer, actions, right)
	if inst.prefab == "wx78_scanner_item" then
		for k,action in ipairs(actions) do
			if action.id == "BEFFPOT" then
				table.remove(actions, k)
			end
			if action.id == "RUMMAGE" then
				table.remove(actions, k)
				local action = ACTIONS.RUMMAGE
				action.priority = 78
				table.insert(actions, 1, action)
			end
		end
	end
end)

end

end
----↑扫描仪↑----




----↓电气化电路↓----
if MainSwitch("taser") then

local taserReturnDMG = GetModConfigData("taser_dmg1")
local taserReturnRange = GetModConfigData("taser_range1")
local taserExtraDMG = GetModConfigData("taser_dmg2")
local taserExtraRange = GetModConfigData("taser_range2")
local taserType = GetModConfigData("taser_dmgtype")
local taserPvp = GetModConfigData("taser_pvp")
local taserFastCharge = GetModConfigData("taser_fastcharge")
local taserFastChargeCost = GetModConfigData("taser_fastchargecost")


--群伤排除标签
local taserExcludeTags = {"INLIMBO", "electricdamageimmune", "companion", "wall", "abigail", "shadowminion", "balloon"}


--电气化电路伤害倍率计算
--[[
对常规目标1.5倍;对潮湿目标2.5倍;对绝缘目标0倍
]]
local function taser_GetDamageMult(wx, target, data)
	local dmg_mult = 0

	--PVP检查
	if target:HasTag("player") and (taserPvp == 3 or (taserPvp == 2 and not TheNet:GetPVPEnabled())) then
		return 0
	end

	--电免疫检查
	if target:HasTag("electricdamageimmune") or (target.components.inventory ~= nil and target.components.inventory:IsInsulated()) then
		return 0
	end

	--战斗检查
	if target.components.combat
		and (target.components.health and not target.components.health:IsDead())
		and (target.components.inventory == nil or not target.components.inventory:IsInsulated())
		and (data == nil or (data.weapon == nil or 
				(data.weapon.components.projectile == nil
				and (data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil)))
			) then
		dmg_mult = TUNING.ELECTRIC_DAMAGE_MULT

		--潮湿度检查
		local wetness_mult = (target.components.moisture ~= nil and target.components.moisture:GetMoisturePercent())
			or (target:GetIsWet() and 1)
			or 0
		dmg_mult = dmg_mult + wetness_mult
		
		--电路个数检查
		if wx.WMB_tasernum and wx.WMB_tasernum > 0 then
			dmg_mult = dmg_mult * wx.WMB_tasernum
		end	
	end

	return dmg_mult
end

--电气化电路造成伤害
local function taser_DoDamage(dmg, wx, _target)
	if dmg < 0 then return end

	--伤害类型判断
	if taserType == 1 then
		_target.components.combat:GetAttacked(nil, dmg)
		_target:PushEvent("attacked", {attacker = wx, damage = 0, stimuli = "electric"}) --用于施加带电攻击判断
		if dmg == 0 then
			_target:PushEvent("attacked", {attacker = wx, damage = 0}) --用于造成伤害和硬直
		end
	else
		_target.components.health:DoDelta(-dmg, false, wx.prefab, false, wx, taserType == 3)
		_target:PushEvent("attacked", {attacker = wx, damage = 0})
		_target:PushEvent("attacked", {attacker = wx, damage = 0, stimuli = "electric"})
	end
end

--电气化电路尝试造成伤害
local function taser_TryDamage(dmg, wx, target, data)
	if dmg < 0 then return false end
	local mult = taser_GetDamageMult(wx, target, data)

	if mult > 0 then		
		taser_DoDamage(mult*dmg, wx, target)
		return true
	end
	
	return false
end

--电气化电路获取群体目标
--[[
排除自身,目标,友好追随者,追随友好者,和具有排除标签的实体
]]
local function taser_GetTargets(dmg, range, wx, ignoredTarget)
	local x,y,z = wx.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, range, {"_combat"}, taserExcludeTags)
	local result = {}

	for _,ent in pairs(ents) do
		if ent ~= wx and ent ~= ignoredTarget
			and (wx.components.combat == nil or wx.components.combat:IsValidTarget(ent))
			and (wx.components.leader == nil or not wx.components.leader:IsFollower(ent))
			and (taserPvp == 1 or not HasFriendlyLeader(ent)) then
				table.insert(result, ent)
		end
	end
	
	return result
end

--电气化电路反伤重构
--[[
原版是0.3秒冷却,对于反伤来说实在太慢了,还是自身冷却,不知道鸽雷怎么想的
]]
local function taser_onblockedorattacked(wx, data)
    if data and data.attacker and not data.redirected then
		local dmg = taserReturnDMG
		local range = taserReturnRange

		--冷却检查(防止伤害无限循环)
		if data.attacker.WMB_taserreturndmgcd == nil then
			data.attacker.WMB_taserreturndmgcd = data.attacker:DoTaskInTime(0.001, function(inst) inst.WMB_taserreturndmgcd = nil end)
			if taser_TryDamage(dmg, wx, data.attacker, data) then
				--单体电击特效
				if range <= 0 then SpawnPrefab("electrichitsparks"):AlignToTarget(data.attacker, wx, true) end
			end
		end	

		--群体伤害
		if range > 0 and wx.WMB_taseraoecd == nil then
			wx.WMB_taseraoecd = wx:DoTaskInTime(0.001, function(inst) inst.WMB_taseraoecd = nil end)

			for _,ent in pairs(taser_GetTargets(dmg, range, wx, data.attacker)) do
				if ent.WMB_taserreturndmgcd == nil then
					ent.WMB_taserreturndmgcd = ent:DoTaskInTime(0.001, function(inst) inst.WMB_taserreturndmgcd = nil end)
					taser_TryDamage(dmg, wx, ent)
				end
			end
			
			--群体电击特效
			local scale = range * 1.25
			local fx = SpawnPrefab("electrichitsparks")
			fx.Transform:SetScale(scale, scale, scale)
			fx:AlignToTarget(wx, wx, true)
		end
    end
end

--电气化电路增伤
local function taser_onattackother(wx, data)
	if data and data.target and not data.redirected then
		local dmg = taserExtraDMG
		local range = taserExtraRange

		--冷却检查(防止伤害无限循环)
		if data.target.WMB_taserextradmgcd == nil then
			data.target.WMB_taserextradmgcd = data.target:DoTaskInTime(0.001, function(inst) inst.WMB_taserextradmgcd = nil end)
			if taser_TryDamage(dmg, wx, data.target, data) then
				--单体电击特效
				if range <= 0 then SpawnPrefab("electrichitsparks"):AlignToTarget(data.target, wx, true) end
			end			
		end

		--群体伤害
		if range > 0 and wx.WMB_taseraoecd == nil then
			wx.WMB_taseraoecd = wx:DoTaskInTime(0.001, function(inst) inst.WMB_taseraoecd = nil end)

			for _,ent in pairs(taser_GetTargets(dmg, range, wx, data.attacker)) do
				if ent.WMB_taserextradmgcd == nil then
					ent.WMB_taserextradmgcd = ent:DoTaskInTime(0.001, function(inst) inst.WMB_taserextradmgcd = nil end)
					taser_TryDamage(dmg, wx, ent)
				end
			end
			
			--群体电击特效
			local scale = range * 1.25
			local fx = SpawnPrefab("electrichitsparks")
			fx.Transform:SetScale(scale, scale, scale)
			fx:AlignToTarget(wx, wx, true)
		end
	end		
end


--电气化电路激活
local function taser_activate(modu, wx)
	wx.WMB_tasernum = (wx.WMB_tasernum or 0) + 1

	--反伤和增伤
    if modu.WMB_onblocked == nil then
        modu.WMB_onblocked = taser_onblockedorattacked
    end
    if modu.WMB_onattackother == nil then
        modu.WMB_onattackother = taser_onattackother
    end	
	if wx.WMB_tasernum == 1 then
		modu:ListenForEvent("blocked", modu.WMB_onblocked, wx)
		modu:ListenForEvent("attacked", modu.WMB_onblocked, wx)
		modu:ListenForEvent("onattackother", modu.WMB_onattackother, wx)
	end

	--设置绝缘
    if wx.components.inventory then
        wx.components.inventory.isexternallyinsulated:SetModifier(modu, true)
    end
end

--电气化电路关闭
local function taser_deactivate(modu, wx)
	wx.WMB_tasernum = math.max(0, (wx.WMB_tasernum or 0) - 1)

	--取消反伤增伤
    if modu.WMB_onblocked then 
		modu:RemoveEventCallback("blocked", modu.WMB_onblocked, wx)
		modu:RemoveEventCallback("attacked", modu.WMB_onblocked, wx)
	end
	if modu.WMB_onattackother then
		modu:RemoveEventCallback("onattackother", modu.WMB_onattackother, wx)
	end

	--取消设置绝缘
    if wx.components.inventory then
        wx.components.inventory.isexternallyinsulated:RemoveModifier(modu)
    end
end

--电气化电路初始化
AddPrefabPostInit("wx78module_taser", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		modu.components.upgrademodule.onactivatedfn = taser_activate
		modu.components.upgrademodule.ondeactivatedfn = taser_deactivate
    end
end)


--电气化电路快充
if taserFastCharge then

AddComponentPostInit("upgrademoduleowner", function(UpgradeModuleOwner)
	local wx = UpgradeModuleOwner.inst
	if wx.WMB_fastchargetask ~= nil then wx.WMB_fastchargetask:Cancel() wx.WMB_fastchargetask = nil end

	wx.WMB_fastchargetask = wx:DoPeriodicTask(3, function(wx)
		if wx.components.upgrademoduleowner and not wx.components.upgrademoduleowner:ChargeIsMaxed() and wx.components.upgrademoduleowner:GetModuleTypeCount("taser") > 0 then
			if wx.components.hunger and wx.components.hunger:GetPercent() >= 0.78 then
				wx.components.hunger:DoDelta(-taserFastChargeCost, false)
				wx.components.upgrademoduleowner:AddCharge(1)
			end
		end
	end)
end)

end

end
----↑电气化电路↑----




----↓豆增压电路↓----
if MainSwitch("bee") then

local beeHeal = GetModConfigData("bee_heal")
local beeHealPeriod = GetModConfigData("bee_healperiod")
local beeNegSanImmune = GetModConfigData("bee_negsanimmune")
local beeAcidImmune = GetModConfigData("bee_acidimmune")


--豆增压电路恢复效果
local function bee_tick(wx, modu)
	if wx.WMB_beenum and wx.WMB_beenum > 0 and wx.components.health and not wx.components.health:IsDead() then
		wx.components.health:DoDelta(wx.WMB_beenum * beeHeal, false, modu.prefab, true)
	end
end

--豆增压电路激活
local function bee_activate(modu, wx, isloading)
    wx.WMB_beenum = (wx.WMB_beenum or 0) + 1

	--恢复效果
	if wx.WMB_beenum == 1 then
		if wx.WMB_beeregen ~= nil then wx.WMB_beeregen:Cancel() end
		wx.WMB_beeregen = wx:DoPeriodicTask(beeHealPeriod, bee_tick, nil, modu)
	end
	
	--噩梦光环免疫
	if beeNegSanImmune and wx.components.sanity then
		wx.components.sanity.neg_aura_modifiers:SetModifier(modu, 0)
	end
	
	--酸雨免疫
	if beeAcidImmune then
		wx:AddTag("acidrainimmune")
	end	
end

--豆增压电路关闭
local function bee_deactivate(modu, wx)
    wx.WMB_beenum = math.max(0, (wx.WMB_beenum or 0) - 1)

	if wx.WMB_beenum <= 0 then
		--移除恢复效果
		if wx.WMB_beeregen ~= nil then
			wx.WMB_beeregen:Cancel()
			wx.WMB_beeregen = nil
		end

		--移除噩梦光环免疫
		if beeNegSanImmune and wx.components.sanity then
			wx.components.sanity.neg_aura_modifiers:RemoveModifier(modu)
		end

		--移除酸雨免疫
		wx:RemoveTag("acidrainimmune")
	end
end

--豆增压电路初始化
AddPrefabPostInit("wx78module_bee", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		modu.components.upgrademodule.onactivatedfn = bee_activate
		modu.components.upgrademodule.ondeactivatedfn = bee_deactivate
    end
end)

end
----↑豆增压电路↑----




----↓制冷&热能电路↓----
TUNING.WX78_MINTEMPCHANGEPERMODULE = TUNING.WX78_MINTEMPCHANGEPERMODULE + GetModConfigData("coldheat_temperature")
----↑制冷&热能电路↑----




----↓制冷电路↓----
if MainSwitch("cold") then

local coldFireResist = GetModConfigData("cold_fireresist")
local coldExtinguish = GetModConfigData("cold_extinguish")

TUNING.WX78_COLD_ICEMOISTURE = GetModConfigData("cold_ice")
TUNING.WX78_COLD_ICECOUNT = GetModConfigData("cold_icenum")


--制冷电路激活
local function cold_activate(modu, wx)
	wx.WMB_coldnum = (wx.WMB_coldnum or 0) + 1

	--火焰减伤
	if wx.components.health then
		wx.components.health.externalfiredamagemultipliers:SetModifier(modu, 1 - coldFireResist)
	end
	
	--允许扑灭火焰
	wx:AddTag("WMB_cold")
end

--制冷电路关闭
local function cold_deactivate(modu, wx)
	 wx.WMB_coldnum = math.max(0, (wx.WMB_coldnum or 0) - 1)

	--取消火焰减伤
	if wx.components.health then
		wx.components.health.externalfiredamagemultipliers:RemoveModifier(modu)
	end
	
	--取消允许扑灭火焰
	if wx.WMB_coldnum <= 0 then
		wx:RemoveTag("WMB_cold")
	end
end

--制冷电路初始化
AddPrefabPostInit("wx78module_cold", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			cold_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			cold_deactivate(modu, wx)
		end
    end
end)


--左键扑灭动作注册
local WMB_EXTINGUISH = Action({priority = -0.5, mount_valid = true, invalid_hold_action = true})
WMB_EXTINGUISH.id = "WMB_EXTINGUISH"
WMB_EXTINGUISH.str = "扑灭"
WMB_EXTINGUISH.fn = function(act)
	local target = act.target or act.invobject
	if target == nil then return false end
	local SUCCESS = false

    if target.components.burnable and target.components.burnable:IsBurning() then
		if target.components.fueled and not target.components.fueled:IsEmpty() then
			target.components.fueled:ChangeSection(-1)
		end
		target.components.burnable:Extinguish(true, 0)
		SUCCESS = true
    end

	--群体灭火
	local x, y, z = target.Transform:GetWorldPosition()
	local fires = TheSim:FindEntities(x, y, z, 2, nil,  {"INLIMBO", "lighter"}, {"fire", "smolder"})
	if #fires > 0 then
		for _,fire in pairs(fires) do
			if fire.components.fueled and not fire.components.fueled:IsEmpty() then
				fire.components.fueled:ChangeSection(-1)
			end
			fire.components.burnable:Extinguish(true, 0)
		end
		SUCCESS = true
	end

	return SUCCESS
end

AddAction(WMB_EXTINGUISH)

AddComponentAction("SCENE", "burnable", function(inst, doer, actions, right)
	if coldExtinguish and doer:HasTag("WMB_cold") and inst:HasOneOfTags({"fire", "smolder"}) then
        table.insert(actions, ACTIONS.WMB_EXTINGUISH)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WMB_EXTINGUISH, "domediumaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.WMB_EXTINGUISH, "domediumaction"))

--注册动作快捷键
local function TryExtinguish(self, force_target)
	if not (
		((not self.ismastersim and (self.remote_controls[GLOBAL.CONTROL_ACTION] or 0) > 0)
			or not self:IsEnabled()
			or self:IsBusy()
			or (force_target ~= nil and (not force_target.entity:IsVisible() or force_target:HasTag("INLIMBO") or force_target:HasTag("NOCLICK"))))
			or self.inst.replica.inventory:IsHeavyLifting()
	) and not self:IsDoingOrWorking() and not self.inst:HasTag("playerghost") then

		if self.inst:HasTag("WMB_cold") then
			local x, y, z = self.inst.Transform:GetWorldPosition()
			local fires = TheSim:FindEntities(x, y, z, 8, nil,  {"INLIMBO", "lighter"}, {"fire", "smolder"})
			for _,fire in ipairs(fires) do
				return BufferedAction(self.inst, fire, ACTIONS.WMB_EXTINGUISH)
			end
		end
	end
end
AddComponentPostInit("playercontroller", function(PlayerController)
	local oldfn = PlayerController.GetActionButtonAction
	function PlayerController:GetActionButtonAction(force_target)
		local new_action = TryExtinguish(self, force_target)
		return (new_action ~= nil and new_action) or oldfn(self, force_target)
	end
end)

--行为排队论兼容
AddComponentPostInit("actionqueuer", function(ActionQueuer)
	if ActionQueuer.AddAction ~= nil then
		ActionQueuer.AddAction("leftclick", "WMB_EXTINGUISH", true)
	end
end)

end
----↑制冷电路↑----




----↓热能电路↓----
if MainSwitch("heat") then

local heatFreezeImmune = GetModConfigData("heat_freezeimmune")
local heatWaterProof = GetModConfigData("heat_waterproof")
local heatCooker = GetModConfigData("heat_cooker")

--热能电路冰冻不掉电
if heatFreezeImmune then

local function fn(wx)
	if not TheWorld.ismastersim then return wx end
    if wx.components.freezable then
		local oldonfreeze = wx.components.freezable.onfreezefn
		wx.components.freezable.onfreezefn = function(inst)
			if wx.components.freezable and wx.WMB_heatnum and wx.WMB_heatnum > 0 then
				--wx.components.freezable:Unfreeze()
			else
				oldonfreeze(inst)
			end
		end
    end
end
AddPrefabPostInit("wx78", fn)
AddPrefabPostInit("wx", fn) --WX自动化兼容

end

--热能电路自动解冻
local function heat_onfreeze(wx)
    if wx.components.freezable then
		wx.components.freezable:Unfreeze()
	end
end

--热能电路激活
local function heat_activate(modu, wx)
	wx.WMB_heatnum = (wx.WMB_heatnum or 0) + 1

	--冰冻免疫
    if modu.WMB_onfreeze == nil then
        modu.WMB_onfreeze = heat_onfreeze
    end	
	if heatFreezeImmune and wx.WMB_heatnum == 1 then
		modu:ListenForEvent("freeze", modu.WMB_onfreeze, wx)
	end

	--潮湿免疫
	if heatWaterProof and wx.components.moisture then
		wx.components.moisture.waterproofnessmodifiers:SetModifier(modu, 78, "WMB_heatwarterproof")
	end

	--设置可烹饪
	if heatCooker and wx.components.cooker == nil then
		wx:AddComponent("cooker")
		wx:AddTag("cooker")
	end
end

--热能电路关闭
local function heat_deactivate(modu, wx)
	wx.WMB_heatnum = math.max(0, (wx.WMB_heatnum or 0) - 1)

	--取消冰冻免疫
	modu:RemoveEventCallback("freeze", modu.WMB_onfreeze, wx)

	--取消潮湿免疫和可烹饪
	if wx.WMB_heatnum <= 0 then
		if wx.components.moisture then
			wx.components.moisture.waterproofnessmodifiers:SetModifier(modu, 0, "WMB_heatwarterproof")
		end		
		wx:RemoveComponent("cooker")
		wx:RemoveTag("cooker")
	end
end

--热能电路初始化
AddPrefabPostInit("wx78module_heat", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			heat_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			heat_deactivate(modu, wx)
		end
    end
end)

--右键烹饪动作注册
local WMB_COOK = Action({priority = 2, mount_valid = true})
WMB_COOK.id = "WMB_COOK"
WMB_COOK.str = "烹饪"
WMB_COOK.fn = function(act)
	local target = act.target or act.invobject
	if target == nil or act.doer == nil then return false end

	local cook_pos = act.doer:GetPosition()
	local ingredient = act.doer.components.inventory:RemoveItem(target)
	ingredient.Transform:SetPosition(cook_pos:Get())

	if not act.doer.components.cooker:CanCook(ingredient, act.doer) then
		act.doer.components.inventory:GiveItem(ingredient, nil, cook_pos)
		return false
	end

	if ingredient.components.health ~= nil then
		act.doer:PushEvent("murdered", { victim = ingredient, stackmult = 1 }) -- NOTES(JBK): Cooking something alive.
		if ingredient.components.combat ~= nil then
			act.doer:PushEvent("killed", { victim = ingredient })
		end
	end

	local product = act.doer.components.cooker:CookItem(ingredient, act.doer)
	if product ~= nil then
		act.doer.components.inventory:GiveItem(product, nil, cook_pos)
		return true
	elseif ingredient:IsValid() then
		act.doer.components.inventory:GiveItem(ingredient, nil, cook_pos)
	end

	return false
end

AddAction(WMB_COOK)

AddComponentAction("SCENE", "cookable", function(inst, doer, actions, right)
	if heatCooker and right and doer:HasTags({"upgrademoduleowner", "cooker"}) and doer.replica.inventory then
        table.insert(actions, ACTIONS.WMB_COOK)
    end
end)
AddComponentAction("INVENTORY", "cookable", function(inst, doer, actions, right)
	if heatCooker and right and doer:HasTags({"upgrademoduleowner", "cooker"}) and doer.replica.inventory then
        table.insert(actions, ACTIONS.WMB_COOK)
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WMB_COOK, "domediumaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.WMB_COOK, "domediumaction"))

--行为排队论兼容
AddComponentPostInit("actionqueuer", function(ActionQueuer)
	if ActionQueuer.AddAction ~= nil then
		ActionQueuer.AddAction("rightclick", "WMB_COOK", true)
	end
end)

end
----↑热能电路↑----




----↓合唱盒电路↓----
if MainSwitch("music") then

local musicSpdMult = GetModConfigData("music_spd")
local musicBeatCombo = GetModConfigData("music_beatcombo")
local musicWet = GetModConfigData("music_wet")
local musicSanityAuraTable = {0, 100/2700, 100/1350, 100/900, 117/900, 100/600, 100/300}
local musicMusic = GetModConfigData("music_music")
local musicVolume = GetModConfigData("music_volume")

--精神光环修改
local musicSanityAura = musicSanityAuraTable[GetModConfigData("music_sanityaura")] or 100/900
TUNING.WX78_MUSIC_SANITYAURA = musicSanityAura
TUNING.WX78_MUSIC_DAPPERNESS = musicSanityAura


--合唱盒电路潮湿目标
local function music_onhitother(wx, data)
	if data and data.target and not data.redirected and not data.target:HasOneOfTags({"moistureimmunity", "wet"}) and not data.target:GetIsWet() then
		local target = data.target
		local did = false

		if target.components.moisture ~= nil then
			local waterproofness = target.components.moisture:GetWaterproofness()
			target.components.moisture:DoDelta(5 * (1 - waterproofness))
			did = true
		end
		if target.components.inventoryitem ~= nil then
			target.components.inventoryitem:AddMoisture(5)
			did = true
		end
		
		--硬核潮湿
		if not did then
			target:AddTag("wet")
			target:DoTaskInTime(6, function(inst)
				if not (TheWorld.state.iswet and not inst:HasTag("rainimmunity")) or not (inst:HasTag("swimming") and not inst:HasTag("likewateroffducksback")) then
					target:RemoveTag("wet")
				end
			end)
		end
		
		--水花特效
		local fx = SpawnPrefab("waterballoon_splash")
		fx.Transform:SetScale(0.5, 0.5, 0.5)
		fx.Transform:SetPosition(target.Transform:GetWorldPosition())
	end	
end

--自动取消后摇
local function music_onattackother(wx, data)
	if data and data.target and not data.redirected then
		if wx.sg then
			wx.sg:RemoveStateTag("attack")
			wx.sg:RemoveStateTag("abouttoattack")
		end

		--摇摆转向(无意义动作)
		local x1,y1,z1 = wx.Transform:GetWorldPosition()
		local x2,y2,z2 = data.target.Transform:GetWorldPosition()
		wx:ForceFacePoint(2*x1-x2, 2*y1-y2, 2*z1-z2)	
	end		
end

--合唱盒电路激活
local function music_activate(modu, wx)
	wx.WMB_musicnum = (wx.WMB_musicnum or 0) + 1

    if modu.WMB_onhitother == nil then
        modu.WMB_onhitother = music_onhitother
    end

    if modu.WMB_onattackother == nil then
        modu.WMB_onattackother = music_onattackother
    end	

	if musicWet and wx.WMB_musicnum == 1 then
		modu:ListenForEvent("onhitother", modu.WMB_onhitother, wx)

		if musicBeatCombo == 1 then
			modu:ListenForEvent("onattackother", modu.WMB_onattackother, wx)
		end
	end

	--移速加成
    if wx.components.locomotor then
        wx.components.locomotor:SetExternalSpeedMultiplier(wx, "WMB_musicspeedmult", musicSpdMult)
    end
	
	--战斗加成
	if wx.components.combat then
		if musicBeatCombo == 2 then
			wx.components.combat.externaldamagemultipliers:SetModifier("WMB_musicdmgmult", 1.4)
		end
	end
	
	--音乐更换
	if musicMusic == 1 then
		wx.SoundEmitter:SetVolume("music_sound", musicVolume)
	else
		wx.SoundEmitter:KillSound("music_sound")
	end
	if musicMusic == 2 then
		wx.SoundEmitter:PlaySound("wmbmusic/undertale/mttex", "wmb_music")
		wx.SoundEmitter:SetVolume("wmb_music", musicVolume)
	end
end

--合唱盒电路关闭
local function music_deactivate(modu, wx)
	wx.WMB_musicnum = math.max(0, (wx.WMB_musicnum or 0) - 1)

	modu:RemoveEventCallback("onhitother", modu.WMB_onhitother, wx)
	modu:RemoveEventCallback("onattackother", modu.WMB_onattackother, wx)

	--取消移速加成和战斗加成
	if wx.WMB_musicnum <= 0 then
		if wx.components.locomotor then
			wx.components.locomotor:SetExternalSpeedMultiplier(wx, "WMB_musicspeedmult", 1)
		end	
		if wx.components.combat then
			wx.components.combat.externaldamagemultipliers:SetModifier("WMB_musicdmgmult", 1)
		end		
		wx.SoundEmitter:KillSound("wmb_music")
	end
	
	--音乐更换
	if musicMusic ~= 1 then
		wx.SoundEmitter:KillSound("music_sound")
	end	
end


--合唱盒电路初始化
AddPrefabPostInit("wx78module_music", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			music_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			music_deactivate(modu, wx)
		end
    end
end)

end
----↑合唱盒电路↑----




----↓处理器电路↓----
if MainSwitch("sanity") then

local sanitytechup = GetModConfigData("sanity_tech")
local sanitySailMult = GetModConfigData("sanity_sailmult")
local sanity1WorkMult1 = GetModConfigData("sanity_workmult1")
local sanity1WorkMult2 = GetModConfigData("sanity_workmult2")
local sanityWorkMult1 = sanity1WorkMult1 * 2
local sanityWorkMult2 = sanity1WorkMult2


--处理器电路科技
local sanity1Tech = {SCIENCE = 1, MAGIC = 1, CARTOGRAPHY = 2, SEAFARING = 2, FISHING = 1}
local sanityTech = {SCIENCE = 2, MAGIC = 2, CARTOGRAPHY = 2, SEAFARING = 2, FISHING = 1}

--处理器电路快速动作
local sanityAction = {}
if GetModConfigData("sanity_quickpick") then
	table.insert(sanityAction, ACTIONS.PICK)
	table.insert(sanityAction, ACTIONS.PICKUP)
	table.insert(sanityAction, ACTIONS.TAKEITEM)
	table.insert(sanityAction, ACTIONS.HARVEST)
end
if GetModConfigData("sanity_quickcraft") then
	table.insert(sanityAction, ACTIONS.BUILD)
	table.insert(sanityAction, ACTIONS.REPAIR)
end

--兼容性(让"研究"不显示,防止覆盖掉一些动作)
if sanitytechup then

AddComponentAction("SCENE", "prototyper", function(inst, doer, actions, right)
	if inst:HasTag("upgrademoduleowner") then
		for k,action in pairs(actions) do
			if action.id == "OPEN_CRAFTING" then
				table.remove(actions, k)
			end
		end
	end
end)

end

--处理器电路激活
local function sanity1_activate(modu, wx)
	wx.WMB_sanity1num = (wx.WMB_sanity1num or 0) + 1

	--航海效率加成
	if sanitySailMult then
		if wx.components.expertsailor == nil then
			wx:AddComponent("expertsailor")
		end
		wx.components.expertsailor:SetRowForceMultiplier(TUNING.MIGHTY_ROWER_MULT)
		wx.components.expertsailor:SetRowExtraMaxVelocity(TUNING.MIGHTY_ROWER_EXTRA_MAX_VELOCITY)
		wx.components.expertsailor:SetAnchorRaisingSpeed(TUNING.MIGHTY_ANCHOR_SPEED)
		wx.components.expertsailor:SetLowerSailStrength(TUNING.MIGHTY_SAIL_BOOST_STRENGTH)		
	end

	--工作效率加成
	if wx.components.workmultiplier == nil then
		wx:AddComponent("workmultiplier")
	end
	wx.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, sanity1WorkMult1, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.MINE, sanity1WorkMult2, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.DIG, sanity1WorkMult1, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, sanity1WorkMult2, modu)

	--科技加持
	if sanitytechup then
		if wx.components.prototyper == nil then wx:AddComponent("prototyper") end
		if wx.components.prototyper.trees == nil then wx.components.prototyper.trees = TechTree.Create() end
		for tech, level in pairs(sanity1Tech) do
			wx.components.prototyper.trees[tech] = wx.components.prototyper.trees[tech] or 0
			if wx.components.prototyper.trees[tech] < level then
				wx.components.prototyper.trees[tech] = level
			end
		end
		wx:AddTag("giftmachine")
	end
end
local function sanity_activate(modu, wx)
	wx.WMB_sanitynum = (wx.WMB_sanitynum or 0) + 1

	--航海效率加成
	if sanitySailMult then
		if wx.components.expertsailor == nil then
			wx:AddComponent("expertsailor")
		end
		wx.components.expertsailor:SetRowForceMultiplier(TUNING.MIGHTY_ROWER_MULT)
		wx.components.expertsailor:SetRowExtraMaxVelocity(TUNING.MIGHTY_ROWER_EXTRA_MAX_VELOCITY)
		wx.components.expertsailor:SetAnchorRaisingSpeed(TUNING.MIGHTY_ANCHOR_SPEED)
		wx.components.expertsailor:SetLowerSailStrength(TUNING.MIGHTY_SAIL_BOOST_STRENGTH)		
	end

	--工作效率加成
	if wx.components.workmultiplier == nil then
		wx:AddComponent("workmultiplier")
	end
	wx.components.workmultiplier:AddMultiplier(ACTIONS.CHOP, sanityWorkMult1, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.MINE, sanityWorkMult2, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.DIG, sanityWorkMult1, modu)
	wx.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, sanityWorkMult2, modu)

	--科技加持
	if sanitytechup then
		if wx.components.prototyper == nil then wx:AddComponent("prototyper") end
		if wx.components.prototyper.trees == nil then wx.components.prototyper.trees = TechTree.Create() end
		for tech, level in pairs(sanityTech) do
			wx.components.prototyper.trees[tech] = wx.components.prototyper.trees[tech] or 0
			if wx.components.prototyper.trees[tech] < level then
				wx.components.prototyper.trees[tech] = level
			end
		end
		wx:AddTag("giftmachine")
	end
end

--处理器电路关闭
local function sanity1_deactivate(modu, wx)
	wx.WMB_sanity1num = math.max(0, (wx.WMB_sanity1num or 0) - 1)
	wx.WMB_sanitynum = wx.WMB_sanitynum or 0

	--取消工作效率加成
	if wx.components.workmultiplier then
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, modu)
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, modu)
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.DIG, modu)		
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, modu)		
	end

	--取消科技加持和航海效率加成
	if wx.WMB_sanity1num <= 0 and wx.WMB_sanitynum <= 0 then
		wx:RemoveComponent("prototyper")
		wx:RemoveComponent("expertsailor")
		wx:RemoveTag("giftmachine")
	end
end
local function sanity_deactivate(modu, wx)
	wx.WMB_sanitynum = math.max(0, (wx.WMB_sanitynum or 0) - 1)
	wx.WMB_sanity1num = wx.WMB_sanity1num or 0

	--取消工作效率加成
	if wx.components.workmultiplier then
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.CHOP, modu)
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.MINE, modu)
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.DIG, modu)
		wx.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, modu)
	end

	--取消科技加持
	if wx.WMB_sanitynum <= 0 and wx.WMB_sanity1num <= 0 then
		wx:RemoveComponent("prototyper")
		wx:RemoveComponent("expertsailor")
		wx:RemoveTag("giftmachine")
	end
end


--处理器电路初始化
AddPrefabPostInit("wx78module_maxsanity1", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			sanity1_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			sanity1_deactivate(modu, wx)
		end
    end
end)
AddPrefabPostInit("wx78module_maxsanity", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			sanity_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			sanity_deactivate(modu, wx)
		end
    end
end)


--快速动作
if #sanityAction > 0 then

local function sanity_actionhandler(inst, act)
	if act.target then --防止大垃圾堆翻不了
		if act.target.prefab == "junk_pile_big" then
			return
		end
	end
	if (inst.WMB_sanitynum and inst.WMB_sanitynum > 0) then
		return "WMB_doshortaction"
	elseif (inst.WMB_sanity1num and inst.WMB_sanity1num > 0) then
		return "domediumaction"
	end
end
local function sanity_quickfn(sg)
	sg.states["WMB_doshortaction"] = State{
		name = "WMB_doshortaction",
		onenter = function(inst) inst.sg:GoToState("dolongaction", 0.2) end
    }

    if sg.actionhandlers ~= nil then
		for _,action in pairs(sanityAction) do
			local handler = sg.actionhandlers[action] or {}
			local oldfn = handler.deststate or function() end
			handler.deststate = function(inst, act)
				local oldresult = oldfn(inst, act)
				if oldresult == "dolongaction" or oldresult == "domediumaction" then
					return sanity_actionhandler(inst, act) or oldresult
				end
				return oldresult
			end
		end
	end
end
AddStategraphPostInit("wilson", sanity_quickfn)
AddStategraphPostInit("wilson_client", sanity_quickfn)
AddStategraphPostInit("wx", sanity_quickfn) --WX自动化兼容

end

end
----↑处理器电路↑----




----↓胃增益电路↓----
if MainSwitch("hunger") then

local hunger1Absorb = GetModConfigData("hunger_absorb")
local hunger1Planardefense = GetModConfigData("hunger_planardef")
local hungerAbsorb = hunger1Absorb * 2
local hungerPlanardefense = hunger1Planardefense * 2


--胃增益电路激活
local function hunger1_activate(modu, wx)
	wx.WMB_hunger1num = (wx.WMB_hunger1num or 0) + 1

	--减伤
    if wx.components.health then
        wx.components.health.externalabsorbmodifiers:SetModifier("WMB_hunger1absorb", hunger1Absorb)
    end
	
	--位面防御
	if wx.components.planardefense == nil then
		wx:AddComponent("planardefense")
	end
	wx.components.planardefense:AddBonus(wx, hunger1Planardefense, "WMB_hunger1planardef")
end
local function hunger_activate(modu, wx)
	wx.WMB_hungernum = (wx.WMB_hungernum or 0) + 1

	--减伤
    if wx.components.health then
        wx.components.health.externalabsorbmodifiers:SetModifier("WMB_hungerabsorb", hungerAbsorb)
    end
	
	--位面防御
	if wx.components.planardefense == nil then
		wx:AddComponent("planardefense")
	end		
	wx.components.planardefense:AddBonus(wx, hungerPlanardefense, "WMB_hungerplanardef")
end

--胃增益电路关闭
local function hunger1_deactivate(modu, wx)
	wx.WMB_hunger1num = math.max(0, (wx.WMB_hunger1num or 0) - 1)

	--取消减伤和位面防御
	if wx.WMB_hunger1num <= 0 then
		if wx.components.health then
			wx.components.health.externalabsorbmodifiers:SetModifier("WMB_hunger1absorb", 0)
		end
		if wx.components.planardefense then
			wx.components.planardefense:RemoveBonus(wx, "WMB_hunger1planardef")
		end			
	end
end
local function hunger_deactivate(modu, wx)
	wx.WMB_hungernum = math.max(0, (wx.WMB_hungernum or 0) - 1)

	--取消减伤和位面防御
	if wx.WMB_hungernum <= 0 then
		if wx.components.health then
			wx.components.health.externalabsorbmodifiers:SetModifier("WMB_hungerabsorb", 0)
		end
		if wx.components.planardefense then
			wx.components.planardefense:RemoveBonus(wx, "WMB_hungerplanardef")
		end			
	end
end


--胃增益电路初始化
AddPrefabPostInit("wx78module_maxhunger1", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			hunger1_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			hunger1_deactivate(modu, wx)
		end
    end
end)
AddPrefabPostInit("wx78module_maxhunger", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			hunger_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			hunger_deactivate(modu, wx)
		end
    end
end)

end
----↑胃增益电路↑----




----↓照明电路↓----
if MainSwitch("light") then

local lightSpdMult = GetModConfigData("light_spd")

TUNING.WX78_LIGHT_BASERADIUS = GetModConfigData("light_radius")
TUNING.WX78_LIGHT_EXTRARADIUS = TUNING.WX78_LIGHT_BASERADIUS / 2

--照明电路激活
local function light_activate(modu, wx)
	wx.WMB_lightnum = (wx.WMB_lightnum or 0) + 1

	--移速加成
    if wx.components.locomotor then
        wx.components.locomotor:SetExternalSpeedMultiplier(wx, "WMB_lightspdmult", lightSpdMult)
    end
end

--照明电路关闭
local function light_deactivate(modu, wx)
	wx.WMB_lightnum = math.max(0, (wx.WMB_lightnum or 0) - 1)

	--取消移速加成
	if wx.WMB_lightnum <= 0 then
		if wx.components.locomotor then
			wx.components.locomotor:SetExternalSpeedMultiplier(wx, "WMB_lightspdmult", 1)
		end
	end
end

--照明电路初始化
AddPrefabPostInit("wx78module_light", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			light_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			light_deactivate(modu, wx)
		end
    end
end)

end
----↑照明电路↑----





----↓光电电路↓----
if MainSwitch("night") then

local nightReveal = {} --需要揭示的实体

--远古祭坛
if GetModConfigData("night_altar") then
	table.insert(nightReveal, {prefab = "ancient_altar", iconName = "tab_crafting_table.png"})
	table.insert(nightReveal, {prefab = "ancient_altar_broken", iconName = "tab_crafting_table.png"})
end

--远古合奏机
if GetModConfigData("night_archive_orchestrina") then
	table.insert(nightReveal, {prefab = "archive_orchestrina_main", iconName = "archive_orchestrina_main.png"})
end

--远古大门
if GetModConfigData("night_atrium_gate") then
	table.insert(nightReveal, {prefab = "atrium_gate", iconName = "atrium_gate_active.png"})
end

--蚁狮
if GetModConfigData("night_antlion") then
	table.insert(nightReveal, {prefab = "antlion"})
end

--皮弗娄牛
if GetModConfigData("night_beefalo") then
	table.insert(nightReveal, {prefab = "beefalo"})
	table.insert(nightReveal, {prefab = "babybeefalo"})
end

--巨大蜂窝
if GetModConfigData("night_beequeen") then
	table.insert(nightReveal, {prefab = "beequeenhive"})
	table.insert(nightReveal, {prefab = "beequeenhivegrown"})
end

--眼骨和星空
if GetModConfigData("night_chester") then
	table.insert(nightReveal, {prefab = "chester_eyebone"})
	table.insert(nightReveal, {prefab = "hutch_fishbowl"})
end

--帝王蟹
if GetModConfigData("night_crabking") then
	table.insert(nightReveal, {prefab = "crabking"})
end

--梦魇疯猪和拾荒疯猪
if GetModConfigData("night_daywalker") then
	table.insert(nightReveal, {prefab = "daywalker"})
	table.insert(nightReveal, {prefab = "junk_pile_big", iconName = "junk_pile_big.png"})
end

--齿轮生物
if GetModConfigData("night_gears") then
	table.insert(nightReveal, {prefab = "bishop"})
	table.insert(nightReveal, {prefab = "bishop_nightmare"})
	table.insert(nightReveal, {prefab = "knight"})
	table.insert(nightReveal, {prefab = "knight_nightmare"})
	table.insert(nightReveal, {prefab = "rook"})
	table.insert(nightReveal, {prefab = "rook_nightmare"})
end

--隐士之家
if GetModConfigData("night_hermithouse") then
	table.insert(nightReveal, {prefab = "hermithouse_construction1", iconName = "hermitcrab_home.png"})
	table.insert(nightReveal, {prefab = "hermithouse_construction2", iconName = "hermitcrab_home.png"})
	table.insert(nightReveal, {prefab = "hermithouse_construction3", iconName = "hermitcrab_home.png"})
	table.insert(nightReveal, {prefab = "hermithouse", iconName = "hermitcrab_home2.png"})
end

--赃物袋
if GetModConfigData("night_klaus_sack") then
	table.insert(nightReveal, {prefab = "klaus_sack", iconName = "klaus_sack.png"})
end

--伏特羊
if GetModConfigData("night_lightninggoat") then
	table.insert(nightReveal, {prefab = "lightninggoat"})
end

--活木树
if GetModConfigData("night_livingtree") then
	table.insert(nightReveal, {prefab = "livingtree", iconName = "livingtree.png"})
end

--曼德拉草
if GetModConfigData("night_mandrake") then
	table.insert(nightReveal, {prefab = "mandrake"})
	table.insert(nightReveal, {prefab = "mandrake_active"})
	table.insert(nightReveal, {prefab = "mandrake_planted"})
end

--犀牛
if GetModConfigData("night_minotaur") then
	table.insert(nightReveal, {prefab = "minotaur"})
end

--月台
if GetModConfigData("night_moonbase") then
	table.insert(nightReveal, {prefab = "moonbase", iconName = "moonbase.png"})
end

--猴女王
if GetModConfigData("night_monkeyqueen") then
	table.insert(nightReveal, {prefab = "monkeyqueen", iconName = "monkey_queen.png"})
end

--猪王
if GetModConfigData("night_pigking") then
	table.insert(nightReveal, {prefab = "pigking", iconName = "pigking.png"})
end

--盐堆
if GetModConfigData("night_saltstack") then
	table.insert(nightReveal, {prefab = "saltstack", iconName = "saltstack.png"})
end

--可疑大理石
if GetModConfigData("night_sculpture") then
	table.insert(nightReveal, {prefab = "sculpture_bishophead", iconName = "sculpture_bishophead.png"})
	table.insert(nightReveal, {prefab = "sculpture_knighthead", iconName = "sculpture_knighthead.png"})
	table.insert(nightReveal, {prefab = "sculpture_rooknose", iconName = "sculpture_rooknose.png"})
	
	table.insert(nightReveal, {prefab = "sculpture_bishopbody", iconName = "sculpture_bishopbody_fixed.png"})
	table.insert(nightReveal, {prefab = "sculpture_knightbody", iconName = "sculpture_knightbody_fixed.png"})
	table.insert(nightReveal, {prefab = "sculpture_rookbody", iconName = "sculpture_rookbody_fixed.png"})
end

--毒菌蟾蜍
if GetModConfigData("night_toadstool") then
	table.insert(nightReveal, {prefab = "toadstool_cap", iconName = "toadstool_hole.png"})
end

--盒中泰拉
if GetModConfigData("night_terrarium") then
	table.insert(nightReveal, {prefab = "terrarium", iconName = "terrarium.png"})
end

--海象
if GetModConfigData("night_walrus") then
	table.insert(nightReveal, {prefab = "walrus"})
	table.insert(nightReveal, {prefab = "walrus_camp", iconName = "igloo.png"})
end



--需要揭示的实体初始化
if #nightReveal > 0 then
	for _,v in pairs(nightReveal) do
		AddPrefabPostInit(v.prefab, function(inst)
			if TheWorld.ismastersim then
				local iconName = v.iconName or (v.prefab)..".wmb"
				inst:AddComponent("maprevealable")
				inst.components.maprevealable:SetIcon(iconName)
				inst.components.maprevealable:SetIconPriority(10)
				inst.components.maprevealable:AddRevealSource(inst, "WMB_nightreveal")
			end	
		end)
	end
end

--光电电路激活
local function night_activate(modu, wx)
	wx.WMB_nightnum = (wx.WMB_nightnum or 0) + 1
	--揭示实体位置
	wx:AddTag("WMB_nightreveal")
end

--光电电路关闭
local function night_deactivate(modu, wx)
	wx.WMB_nightnum = math.max(0, (wx.WMB_nightnum or 0) - 1)
	--取消揭示实体位置
	if wx.WMB_nightnum <= 0 then
		wx:RemoveTag("WMB_nightreveal")
	end
end

--光电电路初始化
AddPrefabPostInit("wx78module_nightvision", function(modu)
    if TheWorld.ismastersim and modu.components.upgrademodule then
		local oldonactivatedfn = modu.components.upgrademodule.onactivatedfn or function() end
		local oldondeactivatedfn = modu.components.upgrademodule.ondeactivatedfn or function() end

		modu.components.upgrademodule.onactivatedfn = function(modu, wx, isloading)
			oldonactivatedfn(modu, wx, isloading)
			night_activate(modu, wx)
		end

		modu.components.upgrademodule.ondeactivatedfn = function(modu, wx)
			oldondeactivatedfn(modu, wx)
			night_deactivate(modu, wx)
		end
    end
end)

end
----↑光电电路↑----