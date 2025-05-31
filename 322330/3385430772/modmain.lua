GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

modimport("scripts/wap_patches/groceries.lua") --杂项
modimport("scripts/wap_patches/rod.lua") --操纵杆

----↓WX机器人↓----
local wx_equipbar = GetModConfigData("wx_equipbar")
local wx_map_reveal = GetModConfigData("wx_map_reveal")
local wx_no_give = GetModConfigData("wx_no_give")
local wx_no_structure_collision = GetModConfigData("wx_no_structure_collision")
local wx_no_freeze_charge_down = GetModConfigData("wx_no_freeze_charge_down")
local wx_repair_special = GetModConfigData("wx_repair_special")
local wx_no_hammer = GetModConfigData("wx_no_hammer")
local wx_no_drown_loss = GetModConfigData("wx_no_drown_loss")
local wx_no_steal = GetModConfigData("wx_no_steal")
local wx_moisture_immune = GetModConfigData("wx_moisture_immune")
local wx_lift_heavy = GetModConfigData("wx_lift_heavy")
local wx_return_gears = GetModConfigData("wx_return_gears")
local wx_vetcurse = GetModConfigData("wx_vetcurse")

if wx_no_give then
	AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions)
		if target.prefab == "wx" then
			for k,action in pairs(actions) do
				if action.id == "GIVE" then
					table.remove(actions, k)
				end
			end
		end
	end)
end

--原机器人装备栏相关,现仅用于右键给予装备
AddPrefabPostInit("player_classified", function(inst)
	inst.WAP_EquipSlotTarget = net_entity(inst.GUID, "WAP_EquipSlotTarget", "WAP_EquipSlotTarget.Dirty")
end)
local function ShowEquipBar(doer, target)
	if wx_equipbar and doer.player_classified then
		doer.player_classified.WAP_EquipSlotTarget:set(target)
	end
end
local function HideEquipBar(doer, target)
	if wx_equipbar and doer.player_classified then
		doer.player_classified.WAP_EquipSlotTarget:set(nil)
	end
end

--更新电路信息
local function UpdateModulesInfo(wx)
	local info = ""

	if wx.components.upgrademoduleowner and wx.components.upgrademoduleowner.modules then
		for _,modu in ipairs(wx.components.upgrademoduleowner.modules) do
			local name = string.gsub(modu:GetBasicDisplayName(), "电路", "", 1)
			info = info..name.." "
		end	
	end

	if wx.WAP_moduleInfo ~= nil then
		wx.WAP_moduleInfo:set(info)
	end
end


--WX机器人初始化
AddPrefabPostInit("wx", function(wx)
	--免疫潮湿
	if wx_moisture_immune then
		wx:AddTag("moistureimmunity")
	end
	
	--可装备永不妥协诅咒物品
	if wx_vetcurse then
		wx:AddTag("vetcurse")
	end

	--[[电量和电路显示
	if wx_display then
		wx.WAP_charge = net_smallbyte(wx.GUID, "WAP_charge", "WAP_charge.Dirty")
		wx.WAP_moduleInfo = net_string(wx.GUID, "WAP_moduleInfo", "WAP_moduleInfo.Dirty")
	
		local oldDis = wx.GetDisplayName
		function wx:GetDisplayName()
			local name = oldDis(self)

			--电量
			if self.WAP_charge ~= nil then
				name = name.." (电量："..(self.WAP_charge:value())..")"
			end
			
			--电路
			if self.WAP_moduleInfo ~= nil then
				local info = self.WAP_moduleInfo:value()
				if info ~= "" then
					name = name.."\n".."电路："..info
				end
			end
			
			return name
		end	
	end
	]]

    if not TheWorld.ismastersim then return wx end

	if wx.components.container then
		local oldonopen = wx.components.container.onopenfn
		local oldonclose = wx.components.container.onclosefn
		
		wx.components.container.onopenfn = function(inst, data)
			oldonopen(inst, data)
			if wx_equipbar then
				local doer = data.doer
				if doer and doer:HasTag("player") then
					ShowEquipBar(doer, wx)
				end
			end
		end
		wx.components.container.onclosefn = function(inst, doer)
			oldonclose(inst, doer)
			if wx_equipbar then
				if doer and doer:HasTag("player") then
					HideEquipBar(doer, wx)
				end
			end
		end
	end

	--装备操纵杆时,更清楚地显示位置
	if wx_map_reveal and wx.components.maprevealable then
		wx.components.maprevealable:SetIconPrefab("globalmapicon")
	end

	--建筑不挡机器人
	if wx_no_structure_collision then
		wx.Physics:ClearCollidesWith(COLLISION.OBSTACLES)
		wx.Physics:ClearCollidesWith(COLLISION.SMALLOBSTACLES)
	end

	--冰冻不掉电
	if wx_no_freeze_charge_down and wx.components.freezable then
		wx.components.freezable.onfreezefn = function() end
	end

	--不能被锤
	if wx_no_hammer then
		wx:RemoveComponent("workable")
	end

	--落水不丢失物品
	if wx_no_drown_loss and wx.components.drownable then
		wx.components.drownable.shoulddropitemsfn = function() return false end
	end
	
	--齿轮全返还
	if wx_return_gears then
		if wx.components.workable then
			local oldonfinish = wx.components.workable.onfinish or function() end
			wx.components.workable.onfinish = function(inst, worker)
				for i = 1,3 do
					inst.components.lootdropper:SpawnLootPrefab("gears")
				end			
				oldonfinish(inst, worker)
			end
		end
		wx:ListenForEvent("death", function(inst)
			for i = 1,3 do
				inst.components.lootdropper:SpawnLootPrefab("gears")
			end
		end)
	end
end)


--允许自动修理的特殊物品
local ItemsToRepair = {}

-- --骨甲
if GetModConfigData("wx_repair_special_skeleton") then
	ItemsToRepair["armorskeleton"] = {
		type = "fueled",
		repairers = {["nightmarefuel"] = 0.25},
	}
end

-- --警钟
if GetModConfigData("wx_repair_special_watch") then
	ItemsToRepair["pocketwatch_weapon"] = {
		type = "fueled",
		repairers = {["nightmarefuel"] = 0.25, ["horrorfuel"] = 0.5},
	}
end

--眼面具/盾
if GetModConfigData("wx_repair_special_eye") then
	ItemsToRepair["eyemaskhat"] = {
		type = "eater",
		repairers = {
			["spoiled_food"] = (22.5 / TUNING.ARMOR_FOOTBALLHAT),
			["monstermeat"] = (112.8 / TUNING.ARMOR_FOOTBALLHAT),
		}
	}
	ItemsToRepair["shieldofterror"] = {
		type = "eater",
		repairers = {
			["spoiled_food"] = (22.5 / TUNING.SHIELDOFTERROR_ARMOR),
			["monstermeat"] = (112.8 / TUNING.SHIELDOFTERROR_ARMOR),
		}
	}
end



--获取耐久百分比
local function GetPercent(item, type)
	local percent = nil
	
	if type == "fueled" and item.components.fueled then
		percent = item.components.fueled:GetPercent()
	elseif type == "eater" and item.components.armor then
		percent = item.components.armor:GetPercent()
	end

	return percent
end

--尝试在机器人身上找东西修理
local function TryRepairFromWX(wx, item, type, repairers, curPercent)
	if wx == nil or wx.prefab ~= "wx" or wx.components.container == nil then return end
	if item == nil then return end
	curPercent = curPercent or GetPercent(item, type)
	if curPercent == nil then return end

	--优先找修复量小的
	for k,v in ipairs(repairers) do
		if curPercent <= (1-v) then
			local repairer = wx.components.container:FindItem(function(inst) return inst.prefab == k end)
			if repairer then
				repairer = (repairer.components.stackable and repairer.components.stackable:Get()) or repairer
		
				if type == "fueled" and item.components.fueled then
					item.components.fueled:TakeFuelItem(repairer, wx)
					break
				elseif type == "eater" and item.components.eater and item.components.eater:CanEat(repairer) then
					item.components.eater:Eat(repairer, wx)
					break
				end

			end
		end
	end
end

--获取表中最小值
local function GetMinInTable(tbl)
	local resuilt = nil
	local mini = 999

	for _,v in pairs(tbl) do
		if v < mini then 
			mini = v
			resuilt = v
		end
	end

	return resuilt
end

--自动修理特殊物品
if wx_repair_special then

for k,v in pairs(ItemsToRepair) do
	AddPrefabPostInit(k, function(inst)
		if not TheWorld.ismastersim then return inst end
		local threshold = 1 - (GetMinInTable(v.repairers) or 0.25)

		inst:DoTaskInTime(0, function()
			--在消耗时修理
			inst:ListenForEvent("percentusedchange", function(inst, data)
				if data.percent ~= nil and data.percent <= threshold then
					local owner = (inst.components.inventoryitem and inst.components.inventoryitem.owner) or nil
					if owner and owner.prefab == "wx" then
						TryRepairFromWX(owner, inst, v.type, v.repairers, data.percent)
					end
				end
			end)

			--在装备或卸下时修理
			inst:ListenForEvent("equipped", function(inst, data)
				if data.owner and data.owner.prefab == "wx" then
					local percent = GetPercent(inst, v.type)
					if percent <= threshold then
						TryRepairFromWX(data.owner, inst, v.type, v.repairers, percent)
					end
				end
			end)
			inst:ListenForEvent("unequipped", function(inst, data)
				if data.owner and data.owner.prefab == "wx" then
					local percent = GetPercent(inst, v.type)
					if percent <= threshold then
						TryRepairFromWX(data.owner, inst, v.type, v.repairers, percent)
					end
				end
			end)
		end)
	end)
end

end

--免疫偷窃
if wx_no_steal then

AddComponentPostInit("thief", function(Thief)
	local oldfn = Thief.StealItem
	function Thief:StealItem(victim, itemtosteal, attack)
		if victim == nil or victim.prefab ~= "wx" then
			oldfn(self, victim, itemtosteal, attack)
		end
	end
end)

end

--右键给予重物动作注册
local WAP_GIVEHEAVY = Action({priority = 5, encumbered_valid = true, invalid_hold_action = true})
WAP_GIVEHEAVY.id = "WAP_GIVEHEAVY"
WAP_GIVEHEAVY.str = "给予重物"
WAP_GIVEHEAVY.stroverridefn = function(act)
	if act.doer ~= nil and act.doer.components.inventory then
		local item = act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
		if item ~= nil and item:HasTag("heavy") then		
			return "给予 "..(item:GetBasicDisplayName())
		end		
	end
end
WAP_GIVEHEAVY.fn = function(act)
	if act.target == nil or act.doer == nil then return false end

	if act.doer.components.inventory and act.target.components.inventory then
		local item = act.doer.components.inventory:Unequip(EQUIPSLOTS.BODY)
		if item ~= nil and item:HasTag("heavy") then
			act.target.components.inventory:Equip(item)
			return true
		end	
	end

	return false
end

AddAction(WAP_GIVEHEAVY)

if wx_lift_heavy then

AddComponentAction("SCENE", "upgrademoduleowner", function(inst, doer, actions, right)
	if right and inst.prefab == "wx" and inst.replica.inventory and doer.replica.inventory then
		local item = doer.replica.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
		if item ~= nil and item:HasTag("heavy") then		
			table.insert(actions, ACTIONS.WAP_GIVEHEAVY)
		end
    end
end)

end
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.WAP_GIVEHEAVY, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.WAP_GIVEHEAVY, "give"))


--右键给予装备动作注册
local WAP_GIVEEQUIP = Action({priority = 0.5, instant = true, mount_valid = true, encumbered_valid = true, paused_valid = true})
WAP_GIVEEQUIP.id = "WAP_GIVEEQUIP"
WAP_GIVEEQUIP.str = "给予装备"
WAP_GIVEEQUIP.fn = function(act)
	local item = act.invobject
	if (item == nil or item.components.equippable == nil) or (act.doer == nil or act.doer.player_classified == nil or act.doer.components.inventory == nil) then return false end
	local target = (act.doer.player_classified.WAP_EquipSlotTarget and act.doer.player_classified.WAP_EquipSlotTarget:value()) or nil

	if target and target.components.inventory then
		if not item.components.equippable:IsRestricted(target) then

			local olditem = target.components.inventory:Unequip(item.components.equippable.equipslot or "")
			if olditem then
				if target.components.container then
					target.components.container:GiveItem(olditem)
				else
					target.components.inventory:DropItem(olditem)
				end
			end
		
			target.components.inventory:Equip(item)
			return true
		end
	end

	return false
end

AddAction(WAP_GIVEEQUIP)

if wx_equipbar then

AddComponentAction("INVENTORY", "equippable", function(inst, doer, actions, right)
	local target = (doer and doer.player_classified and doer.player_classified.WAP_EquipSlotTarget and doer.player_classified.WAP_EquipSlotTarget:value()) or nil

	if target ~= nil
		and (inst.replica.container ~= nil or (target.replica.container ~= nil and target.replica.container:IsHolding(inst, true))) 
		and (inst.replica.equippable == nil or not inst.replica.equippable:IsRestricted(target)) then
			table.insert(actions, ACTIONS.WAP_GIVEEQUIP)
	end	
end)

end
----↑WX机器人↑----




