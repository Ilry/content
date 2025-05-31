local _G = GLOBAL

Assets = {
}
PrefabFiles = {

}                   

local t0 = GetModConfigData("collect_items_dist0")
local t1 = GetModConfigData("collect_items_dist1")
local collectdist = 10*t0 + t1
local minisigndist = GetModConfigData("minisign_dist")
local iscollectone = GetModConfigData("iscollectone")
local istreasurechest = GetModConfigData("treasurechest")
local isdragonflychest = GetModConfigData("dragonflychest")
local isicebox = GetModConfigData("icebox")
local issaltbox = GetModConfigData("saltbox")
local isallcontainers = GetModConfigData("allcontainers")
local is_collect_drop = GetModConfigData("is_collect_drop")
local is_collect_open = GetModConfigData("is_collect_open")
local is_collect_take = GetModConfigData("is_collect_take")
local is_collect_periodicspawner = GetModConfigData("is_collect_periodicspawner")
local is_collect_lootdropper = GetModConfigData("is_collect_lootdropper")
local is_collect_oceantrawler = GetModConfigData("is_collect_oceantrawler")
local is_collect_all = GetModConfigData("is_collect_all")
local collect_all_prefab = GetModConfigData("collectAll")
local collect_chest_slot_prefab = GetModConfigData("collectChestSlot")
local minisign_no_fire = GetModConfigData("minisignnofire")
local renameSpecialMinisign = GetModConfigData("renameSpecialMinisign")
local prefab2Name = {}

local TheNet = _G.TheNet
local debug  = _G.debug
local tostring = _G.tostring
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()
local IsClient = TheNet:GetIsClient() or (TheNet:GetIsServer() and not TheNet:IsDedicated())
local locale = _G.LanguageTranslator ~= nil and _G.LanguageTranslator.defaultlang or TheNet:GetLanguageCode()
local variable = (locale == "zh" or locale == "zhr" or locale == "zht") and "zh" or "en"

print("[mychest] renameSpecialMinisign=" .. tostring(renameSpecialMinisign))
print("[mychest] collect_all_prefab=" .. tostring(collect_all_prefab))
print("[mychest] collect_chest_slot_prefab=" .. tostring(collect_chest_slot_prefab))
print("[mychest] IsServer=" .. tostring(IsServer))
print("[mychest] IsClient=" .. tostring(IsClient))

----------------------------------公共函数 begin---------------------------------
local function getUpValue(fn, targetName, targetValue)
	local i, _value, _name = 0, "", ""
	while _name ~= nil and (targetName == nil or _name ~= targetName) and
		  (targetValue == nil or _value ~= targetValue) do
		i = i + 1
		_name , _value = debug.getupvalue(fn, i)
	end
	if _name == nil then
		return nil
	end
	return i, _value
end

local function getUpValueRecursion(fn, targetName, targetValue, dep, maxdep)
	if dep > maxdep then
		return nil
	end
	-- print(dep .. " fn=" .. tostring(fn) .. " targetName=" .. tostring(targetName) .. " targetValue=" .. tostring(targetValue))
	local i, _value, _name = 0, "", ""
	while _name ~= nil and (targetName == nil or _name ~= targetName) and
		  (targetValue == nil or _value ~= targetValue) do
		i = i + 1
		_name , _value = debug.getupvalue(fn, i)
		-- print(dep .. " i=" .. i .. " _name=" .. tostring(_name) .. " _value=" .. tostring(_value))
		if _value ~= nil and type(_value) == "function" then
			local retfn, reti, retname, retvalue = getUpValueRecursion(_value, targetName, targetValue, dep+1, maxdep)
			if retfn ~= nil then
				return retfn, reti, retname, retvalue
			end
		end
	end
	if _name == nil then
		return nil
	end
	return fn, i, _name, _value
end

local function setUpValue(fn, i, targetFn)
	debug.setupvalue(fn, i, targetFn)
end
----------------------------------公共函数 end ----------------------------------

---------------------------------------------------------------------------
-- 2023年5月4日 
-- 功能：兼容所有物品
-- 实现：
--   	1.给小木牌minisign添加一个属性 LX_collect_item.用来记录画的时候物品的prefab
--   	2.用这个属性更新箱子收集的物品列表

-- 2023年5月5日
-- 功能：添加收集所有物品的特殊木牌，并为它添加反选功能

-- 2023年5月7日
-- 修复：覆盖式设置LX_collect_item属性，改为不影响mod的改动
-- 功能：添加为所有具有container的箱子的收集物品功能
-- 实现：
-- 	 	1.为container添加初始化函数
-- 	 	2.对于那些可以放入物品栏的箱子添加修改。
--  		放入时清空收集列表。取出时设置收集列表
-- 			collectChest2Item函数中，要求箱子不存在Tag "INLIMBO"
-- 			findAndSetChest函数中，不更新物品栏的
-- 			collectItem2Chest中，不查找物品栏的箱子
--  	3.会动的箱子不添加，切斯特 哈奇。用sg判断

-- 2023年5月8日
-- 功能1：添加收集箱子内部存在物品的特殊木牌
-- 功能2：修改特殊木牌的显示名字
---------------------------------------------------------------------------


if IsServer then

	-- 显示信息
	local function showInfo()
		-- if _G.ThePlayer and _G.ThePlayer.HUD and not _G.ThePlayer.HUD:HasInputFocus() then
		-- end
		local target = _G.TheInput:GetWorldEntityUnderMouse()
		if target ~= nil then
			if target:HasTag("preparedfood") then
				-- print("" .. target.prefab .. " has tag preparedfood")
			end
			if target.prefab == "minisign" or target.prefab == "minisign_drawn" then
				if target._imagename then
					-- print("[showInfo] minisign._imagename:" .. target._imagename:value())
				else
					-- print("[showInfo] minisign.itemname == nil")
				end
			end
			if target.prefab == "treasurechest" or target.prefab == "dragonflychest" or target.prefab == "icebox" or target.prefab == "saltbox" then
				-- print("[showInfo] " .. target.prefab .. ".items : start")
				if target and target.components.lxautocollectitems then
					for key, value in pairs(target.components.lxautocollectitems.items) do
						-- print(value)
					end
				end
				-- print("[showInfo] " .. target.prefab .. ".items : end")
			end
		end

	end
	_G.TheInput:AddKeyUpHandler(118, showInfo)

	-- 功能1. 设置要收集的物品
	-- 箱子主动收集附近的物品
	local function collectChest2Item(chest)
		-- print("[SmartChest]collectChest2Item chest=" .. tostring(chest.prefab))
		if chest and not chest:HasTag("INLIMBO") and chest.components and chest.components.lxautocollectitems then
			-- print("\tnot chest:HasTag(\"INLIMBO\")")
			-- 当前箱子不在物品栏中才尝试收集
			local x, y, z = chest.Transform:GetWorldPosition()
			-- 要求物品一定是 inventoryitem。一定不能是
			local items = _G.TheSim:FindEntities(x, y, z, collectdist, { "_inventoryitem" }, { "INLIMBO", "NOCLICK", "catchable", "fire" })
			for k, v in pairs(items) do
				if v.components.inventoryitem and v.components.inventoryitem.canbepickedup == true then
					local name = v.drawnameoverride or v:GetBasicDisplayName()
					-- print("\tprefab.name="..name)
					chest.components.lxautocollectitems:onCollectItems(v, name)
				end
			end
		end
	end

	-- 改变箱子的部分
	local function changeChest(inst) 
		-- ACI == LXautocollectitems
		-- 给箱子添加 LXautocollectitems 这个component,并且箱子打开时设置要收集的items
		if inst and inst.components and inst.components.container then
			-- print("[SmartChest]changeChest inst=" .. tostring(inst.prefab))
			-- 添加 lxautocollectitems 组件，和tag
			inst:AddComponent("lxautocollectitems")
			inst:AddTag("lxautocollectitems") -- 给对应箱子添加Tag
			inst.components.lxautocollectitems.minisigndist = minisigndist
			inst.components.lxautocollectitems.iscollectone = iscollectone
			inst.components.lxautocollectitems.iscollectall = collect_all_prefab ~= 0
			inst.components.lxautocollectitems.iscollectforchestslot = collect_chest_slot_prefab ~= 0
			inst.components.lxautocollectitems.collectAllPrefab = collect_all_prefab
			inst.components.lxautocollectitems.collectChestSlotPrefab = collect_chest_slot_prefab

			-- 箱子打开时收集物品
			if is_collect_open == 1 then
				local old_open = inst.components.container.onopenfn
				inst.components.container.onopenfn = function(inst2)
					--inst2.components.lxautocollectitems:SetItems()
					if old_open ~= nil then
						old_open(inst2)
					end
					collectChest2Item(inst2)
				end
			end

			-- 箱子内物品被整组取出时收集物品
			if is_collect_take == 1 then
				local old_take = inst.components.container.TakeActiveItemFromAllOfSlot
				function inst.components.container:TakeActiveItemFromAllOfSlot(slot, opener)
					if old_take ~= nil then
						old_take(self,slot, opener)
					end
					collectChest2Item(self.inst)
				end
				local old_move = inst.components.container.MoveItemFromAllOfSlot
				function inst.components.container:MoveItemFromAllOfSlot(slot,container, opener)
					if old_move ~= nil then
						old_move(self,slot,container, opener)
					end
					collectChest2Item(self.inst)
				end
			end

			-- 箱子加载时设置收集物
			local old_onload = inst.OnLoad
			inst.OnLoad = function(inst2, data)
				if old_onload ~= nil then
					old_onload(inst2, data)
				end
				if inst2 and inst2.components and inst2.components.lxautocollectitems then
					inst2:DoTaskInTime(0, function()
						-- print("[SmartChest]OnLoad")
						if inst2:HasTag("INLIMBO") then
							-- print("\tINLIMBO")
							inst2.components.lxautocollectitems:ClearItems()
						else
							-- print("\tLIMBO")
							inst2.components.lxautocollectitems:SetItems()
						end
					end)
				end
			end

			-- 箱子建造时设置收集物
			local function onChestBuild(inst1)
				inst1:DoTaskInTime(0.1, function()
					-- print("[SmartChest]onChestBuild DoTaskInTime")
					if inst1:HasTag("INLIMBO") then
						inst1.components.lxautocollectitems:ClearItems()
					else
						inst1.components.lxautocollectitems:SetItems()
					end
				end)
			end
			inst:ListenForEvent("onbuilt", onChestBuild)

			-- 解决箱子敲毁时 掉落物消失的问题
			if inst.components.workable then
				local old_onfinish = inst.components.workable.onfinish
				inst.components.workable:SetOnFinishCallback(function(inst2, worker)
					inst2.components.lxautocollectitems.items = {}
					if old_onfinish ~= nil then
						old_onfinish(inst2, worker)
					end
				end)
			end
		
			-- 兼容那些可以被放进物品栏的箱子 inventoryitem
			if inst and inst.components and inst.components.inventoryitem then
				local old_ondropfn = inst.components.inventoryitem.ondropfn
				inst.components.inventoryitem:SetOnDroppedFn(function(...)
					if old_ondropfn ~= nil then
						old_ondropfn(...)
					end
					-- print("[SmartChest]ondropfn")
					-- inst:DoTaskInTime(0.1, function()
					-- 	-- print("[SmartChest]ondropfn DoTaskInTime")
						if not inst:HasTag("INLIMBO") then
							inst.components.lxautocollectitems:SetItems()
						end
					-- end)
				end)

				local old_onpickupfn = inst.components.inventoryitem.onpickupfn
				inst.components.inventoryitem:SetOnPickupFn(function(...)
					local ret = nil
					if old_onpickupfn ~= nil then
						ret = old_onpickupfn(...)
					end
					-- print("[SmartChest]onpickupfn")
					if ret ~= true then
						inst.components.lxautocollectitems:ClearItems()
					end
					return ret
				end)

				local old_onputininventoryfn = inst.components.inventoryitem.onputininventoryfn
				inst.components.inventoryitem:SetOnPutInInventoryFn(function(...)
					if old_onputininventoryfn ~= nil then
						old_onputininventoryfn(...)
					end
					-- print("[SmartChest]onputininventoryfn")
					inst.components.lxautocollectitems:ClearItems()
				end)
			end
		end

	end

	local changeContainer_ExcludePrefab = { "treasurechest", "dragonflychest", "icebox", "saltbox"}
	local function changeContainer(inst)
		for k,v in pairs(changeContainer_ExcludePrefab) do
			if inst.prefab == v then
				return
			end
		end
		if inst and inst.components and inst.components.container and inst.sg == nil then
			-- print("[SmartChest]changeContainer inst.prefab=" .. tostring(inst.prefab))
			changeChest(inst)
		end
	end

	if isallcontainers == 1 then
		AddPrefabPostInitAny(changeContainer)
	end
	if istreasurechest == 1 then
		AddPrefabPostInit("treasurechest", changeChest)
	end
	if isicebox == 1 then
		AddPrefabPostInit("icebox", changeChest)
	end
	if issaltbox == 1 then
		AddPrefabPostInit("saltbox", changeChest)
	end
	if isdragonflychest == 1 then
		AddPrefabPostInit("dragonflychest", changeChest)
	end

	-- 改变小木牌的部分（1.小木牌画，挖，加载，烧毁，种的时候，设置箱子。2.在小木牌画的时候，设置LX_collect_item属性。3.修改OnSave OnLoad 来保存这个属性。4.为特殊木牌修改显示名称）
	
	-- 1.小木牌画，挖，加载，烧毁，种的时候，设置箱子
	local function findAndSetChest(inst, x, y, z)
		if inst ~= nil then
			x, y, z = inst.Transform:GetWorldPosition()
		end
		local ents = _G.TheSim:FindEntities(x, y, z, minisigndist, {"lxautocollectitems"}, {"INLIMBO"})
		for k, v in pairs(ents) do
			v.components.lxautocollectitems:SetItems()
		end
	end
	local function changeMinisign1(inst)
		if inst.prefab == "minisign" then
			local old_draw = inst.components.drawable.ondrawnfn
			inst.components.drawable:SetOnDrawnFn(function(inst2, image, src, atlas, bgimage, bgatlas)
				old_draw(inst2, image, src, atlas, bgimage, bgatlas)
				findAndSetChest(inst2)
			end)
			local old_onfinish = inst.components.workable.onfinish
			-- print("[mychest] inst.components.workable.onfinish=" .. tostring(inst.components.workable.onfinish))
			inst.components.workable:SetOnFinishCallback(function(inst2)
				old_onfinish(inst2)
				findAndSetChest(inst2)
			end)
			local old_onload = inst.OnLoad
			inst.OnLoad = function(inst2, data)
				-- print("[master chest] onload")
				old_onload(inst2, data)
				findAndSetChest(inst2)
			end
			local old_onburnt = inst.components.burnable.onburnt
			inst.components.burnable:SetOnBurntFn(function(inst2)
				old_onburnt(inst2)
				findAndSetChest(inst2)
			end)
		end
		if inst.prefab == "minisign_drawn" then
			local old_ondeply = inst.components.deployable.ondeploy
			-- print("[mychest] inst.components.deployable.ondeploy=" .. tostring(inst.components.deployable.ondeploy))
			inst.components.deployable.ondeploy = function(inst2,pt)
				local x, y, z = pt:Get()
				old_ondeply(inst2, pt)
				findAndSetChest(nil, x, y, z)
				-- print("[SmartChest]248 ondeploy")
			end
		end
	end
	AddPrefabPostInit("minisign", changeMinisign1) -- 画 挖 世界加载 烧毁
	AddPrefabPostInit("minisign_drawn", changeMinisign1) -- 种

	-- 2.在小木牌画的时候，设置LX_collect_item属性。
	-- 		由于minisign的drawable组件的ondrawnfn函数中，参数imagesource/src对应被画的物品本身。
	-- 		在小木牌挖和种的时候，会在minisign 与 minisign_drawn之间切换，所以需要在两者之间继承这个LX_collect_item属性
	-- 3.修改OnSave OnLoad 来保存这个属性
	-- ！！！顺序很重要。因为这里是用覆盖的方式修改的dig_up与ondeploy。所以需要调高优先级，来优先加载
	local isRunOnceMinisign = true
	local isRunOnceMinisignDrawn = true
	local function changeMinisign2(inst)
		if inst.prefab == "minisign" then
			-- 2.在小木牌画的时候，设置LX_collect_item属性
			if inst.LX_collect_item == nil then
				inst.LX_collect_item = _G.net_string(inst.GUID, "minisign.LX_collect_item") -- 用于保存收集物品的prefab，需要同步给客户端
			end
			inst.LX_collect_item:set("")
			local old_draw = inst.components.drawable.ondrawnfn -- 在画的时候，设置LX_collect_item
			inst.components.drawable:SetOnDrawnFn(function(inst2, image, src, ...)
				old_draw(inst2, image, src, ...)
				if src ~= nil then
					inst.LX_collect_item:set(src.prefab)
				end
			end)
			-- 在小木牌挖的时候，将LX_collect_item属性保存到minisign_drawn中。
			if isRunOnceMinisign then
				isRunOnceMinisign = false
				-- 读取游戏源代码中的dig_up函数的地址
				local fn = _G.Prefabs["minisign"].fn
				local index, source_dig_up = getUpValue(fn, "dig_up")
				if index == nil then
					-- print("[Smart Chest]315 The initialization failed.")
				end
				-- 不能再Prefab.fn中直接修改dig_up。因为它可能已经被其他mod改动了。
				-- 通过getupvalue的递归调用，根据source_dig_up找到正在调用的函数中的dig_up函数的位置，然后覆盖。
				local old_onfinish = inst.components.workable.onfinish
				local retfn, reti, retname, retvalue = getUpValueRecursion(old_onfinish, nil, source_dig_up, 0, 10000)
				if retfn == nil then
					-- print("[Smart Chest]323 The initialization failed.")
				end
				-- ！！！这里仍旧是对游戏源文件的修改。如果以后游戏源文件中的digup函数修改了，需要跟着更新这个。但是不会影响其他mod对这个函数的正常修改了。
				-- 如果它和我使用同样的方式，则前一个修改会被覆盖
				local function dig_up(inst2)
					local image = inst2.components.drawable:GetImage()
					if image ~= nil then
						local item = inst2.components.lootdropper:SpawnLootPrefab("minisign_drawn", nil, inst2.linked_skinname_drawn, inst2.skin_id )
						item.components.drawable:OnDrawn(image, nil, inst2.components.drawable:GetAtlas(), inst2.components.drawable:GetBGImage(), inst2.components.drawable:GetBGAtlas())
						item._imagename:set(inst2._imagename:value())
						item.LX_collect_item:set(inst2.LX_collect_item:value()) -- 仅添加了这一行
						-- print("[SmartChest]299 dig_upMy")
					else
						inst2.components.lootdropper:SpawnLootPrefab("minisign_item", nil, inst2.linked_skinname, inst2.skin_id )
					end
					inst2:Remove()
				end
				-- 这里是对当前生成的小木牌的设置
				setUpValue(retfn, reti, dig_up)
				-- 这里是为以后生成的小木牌修改的设置
				setUpValue(fn, index, dig_up)
					
			end
		end
		if inst.prefab == "minisign_drawn" then
			if inst.LX_collect_item == nil then
				inst.LX_collect_item = _G.net_string(inst.GUID, "minisign_drawn.LX_collect_item") -- 用于保存收集物品的prefab，需要同步给客户端
			end
			inst.LX_collect_item:set("")
			-- 在小木牌种的时候，将LX_collect_item属性保存到minisign中。
			if isRunOnceMinisignDrawn then
				isRunOnceMinisignDrawn = false
				-- 读取游戏源代码中的dig_up函数的地址
				local fn = _G.Prefabs["minisign_drawn"].fn
				local index, source_ondeploy = getUpValue(fn, "ondeploy")
				if index == nil then
					-- print("[Smart Chest]334 The initialization failed.")
				end
				-- 不能再Prefab.fn中直接修改ondeploy。因为它可能已经被其他mod改动了。
				-- 通过getupvalue的递归调用，根据source_ondeploy找到正在调用的函数中的ondeploy函数的位置，然后覆盖。
				local old_ondeploy = inst.components.deployable.ondeploy
				local retfn, reti, retname, retvalue = getUpValueRecursion(old_ondeploy, nil, source_ondeploy, 0, 10000)
				if retfn == nil then
					-- print("[Smart Chest]341 The initialization failed.")
				end
				-- ！！！这里仍旧是对游戏源文件的修改。如果以后游戏源文件中的ondeploy函数修改了，需要跟着更新这个。但是不会影响其他mod对这个函数的正常修改了。
				-- 但如果它和我使用同样的方式，则前一个修改会被覆盖
				local function ondeploy(inst2, pt)
					local ent = _G.SpawnPrefab("minisign", inst2.linked_skinname, inst2.skin_id )
				
					if inst2.components.stackable ~= nil then
						inst2.components.stackable:Get():Remove()
					else
						ent.components.drawable:OnDrawn(inst2.components.drawable:GetImage(), nil, inst2.components.drawable:GetAtlas(), inst2.components.drawable:GetBGImage(), inst2.components.drawable:GetBGAtlas())
						ent._imagename:set(inst2._imagename:value())
						ent.LX_collect_item:set(inst2.LX_collect_item:value()) -- 仅添加了这一行
						-- print("[SmartChest]335 ondeployMy")
						inst2:Remove()
					end
				
					ent.Transform:SetPosition(pt:Get())
					ent.SoundEmitter:PlaySound("dontstarve/common/sign_craft")
				end
				-- 这里是对当前生成的小木牌的设置
				setUpValue(retfn, reti, ondeploy)
				-- 这里是为以后生成的小木牌修改的设置
				setUpValue(fn, index, ondeploy)
			end
		end
		-- 3.修改OnSave OnLoad 来保存这个属性
		-- minisign 与 minisign_drawn都需要
		local old_onsave = inst.OnSave
		inst.OnSave = function(inst1, data)
			if old_onsave ~= nil then
				old_onsave(inst1, data)
			end
			data.LX_collect_item = #inst1.LX_collect_item:value() > 0 and inst1.LX_collect_item:value() or nil
		end
		local old_onload = inst.OnLoad
		inst.OnLoad = function(inst1, data)
			if old_onload ~= nil then
				old_onload(inst1, data)
			end
			inst1.LX_collect_item:set(data ~= nil and data.LX_collect_item or "")
		end
	end
	AddPrefabPostInit("minisign", changeMinisign2)
	AddPrefabPostInit("minisign_drawn", changeMinisign2)

	-- 4.为特殊木牌修改显示名称
	-- 需要放到客户端
	-- if renameSpecialMinisign then
	-- 	-- local prefab2Name = {}
	-- 	if collect_all_prefab ~= 0 then
	-- 		prefab2Name[collect_all_prefab] = {
	-- 			["zh"] = "收集所有物品",
	-- 			["en"] = "Collect all items",
	-- 		}
	-- 	end
	-- 	if collect_chest_slot_prefab ~= 0 then
	-- 		prefab2Name[collect_chest_slot_prefab] = {
	-- 			["zh"] = "收集内部物品",
	-- 			["en"] = "Collect inner items",
	-- 		}
	-- 	end

	-- 	local function changeMinisign4(inst)
	-- 		local old_displaynamefn = inst.displaynamefn
	-- 		inst.displaynamefn = function(inst1)
	-- 			local name = old_displaynamefn(inst1)
	-- 			if #inst.LX_collect_item:value() > 0 then
	-- 				for k,v in pairs(prefab2Name) do
	-- 					if inst.LX_collect_item:value() == k then
	-- 						name = name .. "\n" .. v[variable]
	-- 						break
	-- 					end
	-- 				end
	-- 			end
	-- 			print("[mychest] minisign displaynamefn server")
	-- 			return name
	-- 		end
	-- 	end
	-- 	AddPrefabPostInit("minisign", changeMinisign4)
	-- 	AddPrefabPostInit("minisign_drawn", changeMinisign4)
	-- end




	-- 功能2. 收集物品
	local function collectItem2Chest(dropped)
		-- print("[SmartChest] collectItem2Chest droppend=" .. tostring(dropped))
		if dropped ~= nil and not dropped:HasTag("INLIMBO") and dropped.components.inventoryitem and dropped.components.inventoryitem.canbepickedup == true then
			-- 搜索周围的箱子
			-- print("\t[collectItem2Chest] prefab = " .. dropped.prefab)
			-- print("[collect] search Tag lxautocollectitems")
			local x, y, z = dropped.Transform:GetWorldPosition()
			local ents = _G.TheSim:FindEntities(x, y, z, collectdist, {"lxautocollectitems"}, {"burnt", "INLIMBO"})
			local name = dropped.drawnameoverride or dropped:GetBasicDisplayName()
			
			for k, v in pairs(ents) do
				if dropped ~= nil and dropped:IsValid() then
					if v and dropped.prefab ~= v.prefab and v.components and v.components.lxautocollectitems then
						-- print("[SmartChest]collectItem2Chest v.prefab=" .. v.prefab .. " name=" .. v.name)
						dropped = v.components.lxautocollectitems:onCollectItems(dropped, name)
					end
				else
					break
				end
			end
		end
		if dropped ~= nil and dropped.lx_collect_task ~= nil then
			dropped.lx_collect_task:Cancel()
			dropped.lx_collect_task = nil
		end
	end

	-- 玩家触发drop动作时，收集。(inventory:DropItem)
	if is_collect_drop == 1 then
		local function onDropCollect(inst)
			local old_DropItem = inst.DropItem
			function inst:DropItem(item, wholestack, randomdir, pos)
				-- print("[DropItem] enter")
				local dropped = old_DropItem(self, item, wholestack, randomdir, pos)

				-- collectItem2Chest(dropped)
				if dropped and dropped:IsValid() then
					-- print("myChest:DropItem")
					if dropped.lx_collect_task ~= nil then
						dropped.lx_collect_task:Cancel()
						dropped.lx_collect_task = nil
					end
					dropped.lx_collect_task = dropped:DoTaskInTime(0.2, function(inst1)
						collectItem2Chest(inst1)
					end)
				end
				-- print("[DropItem] exit")
				return dropped
			end
		end
		AddComponentPostInit("inventory",onDropCollect)
	end

	-- 战利品掉落时，收集。
	if is_collect_lootdropper == 1 then
		-- 在战利品生成时
		-- local function onLootdropCollect(inst)
		-- 	local old_SpawnLootPrefab = inst.SpawnLootPrefab
		-- 	function inst:SpawnLootPrefab(lootprefab, pt, linked_skinname, skin_id, userid)
		-- 		-- print("[SpawnLootPrefab] enter")
		-- 		local dropped = old_SpawnLootPrefab(self, lootprefab, pt, linked_skinname, skin_id, userid)
		-- 		-- collectItem2Chest(dropped)
		-- 		dropped:DoTaskInTime(0.5, function(inst)
		-- 			collectItem2Chest(inst)
		-- 		end)
		-- 		-- print("[SpawnLootPrefab] exit")
		-- 		return dropped
		-- 	end
		-- end
		-- AddComponentPostInit("lootdropper",onLootdropCollect)

		-- 在战利品抛出后
		local function onLootdropCollect2(inst)
			local old_FlingItem = inst.FlingItem
			function inst:FlingItem(loot, ...)
				if old_FlingItem ~= nil then
					old_FlingItem(self, loot, ...)
				end
				if loot and loot:IsValid() then
					if loot.lx_collect_task ~= nil then
						loot.lx_collect_task:Cancel()
						loot.lx_collect_task = nil
					end
					loot.lx_collect_task = loot:DoTaskInTime(0.5, function(inst1)
						collectItem2Chest(inst1)
					end)
				end
			end
		end
		AddComponentPostInit("lootdropper",onLootdropCollect2)

		--[[燃烧的灰 收集
		local function onBurntCollect(inst)
			-- print("[onBurntCollect]")
			local old_onburnt = inst.onburnt
			inst.onburnt = function(inst2)
				if inst2 then
					local x, y, z = inst2.Transform:GetWorldPosition()
					-- print("[onburnt] x y z = " .. x .. " ".. y .. " " .. z)
					old_onburnt(inst2)
					local ents = _G.TheSim:FindEntities(x, y, z, collectdist, {"lxautocollectitems"}, {"burnt"})
					for k, v in pairs(ents) do
						collectChest2Item(v)
					end
				else
					old_onburnt(inst2)
				end
			end
		end
		AddComponentPostInit("burnable",onBurntCollect)]]
	end

	-- 周期性掉落物品，收集。
	if is_collect_periodicspawner == 1 then
		local function onPerioddropCOllect(inst)
			local old_onspawn = inst.onspawn
			function inst:SetOnSpawnFn(fn)
				self.onspawn = function(inst1, inst2)
					if fn ~= nil then
						fn(inst1, inst2)
					end
					if inst2 and inst2:IsValid() then
						if inst2.lx_collect_task ~= nil then
							inst2.lx_collect_task:Cancel()
							inst2.lx_collect_task = nil
						end
						inst2.lx_collect_task = inst2:DoTaskInTime(0.5, function(inst3)
							collectItem2Chest(inst3)
						end)
					end
				end
			end
			inst:SetOnSpawnFn(old_onspawn)

		end
		AddComponentPostInit("periodicspawner",onPerioddropCOllect)

		-- 熊的毛簇，收集。
		local function onbeargerCollect(inst)
			local old_DoSingleShed = inst.components.shedder.DoSingleShed
			function inst.components.shedder:DoSingleShed()
				local item = old_DoSingleShed(self)
				if item ~= nil and item:IsValid() then
					if item.lx_collect_task ~= nil then
						item.lx_collect_task:Cancel()
						item.lx_collect_task = nil
					end
					item.lx_collect_task = item:DoTaskInTime(0.5, function(inst1)
						collectItem2Chest(inst1)
					end)
				end
				return item
			end
		end
		AddPrefabPostInit("bearger",onbeargerCollect)
	end

	-- 海洋拖网捕鱼器溢出的鱼，收集
	-- print("[SmartChest] before onOceanTrawlerOverflow")
	if is_collect_oceantrawler == 1 then
		-- print("[SmartChest] in onOceanTrawlerOverflow")
		local function onOceanTrawlerOverflow(inst)
			-- print("[SmartChest] onOceanTrawlerOverflow inst.prefab=" .. tostring(inst.prefab))
			local old_ReleaseOverflowFish = inst.ReleaseOverflowFish
			function inst:ReleaseOverflowFish(...)
				-- print("[SmartChest] ReleaseOverflowFish new enter")
				local need_collect = false
				if #self.overflowfish > 0 then
					-- print("[SmartChest] ReleaseOverflowFish new need_collect")
					need_collect = true
				end

				if old_ReleaseOverflowFish ~= nil then
					old_ReleaseOverflowFish(self, ...)
				end

				if need_collect then
					-- print("[SmartChest] onOceanTrawlerOverflow need_collect self.prefab1=" .. tostring(self.inst.prefab))
					if self.inst ~= nil then
						-- print("[SmartChest] onOceanTrawlerOverflow need_collect 2")
						if self.inst and self.inst:IsValid() then
							if self.inst.lx_collect_task ~= nil then
								self.inst.lx_collect_task:Cancel()
								self.inst.lx_collect_task = nil
							end
							self.inst.lx_collect_task = self.inst:DoTaskInTime(0.5, function(inst2)
								-- print("[SmartChest] ReleaseOverflowFish new collect")
								local x, y, z = inst2.Transform:GetWorldPosition()
								local ents = _G.TheSim:FindEntities(x, y, z, collectdist, {"lxautocollectitems"}, {"burnt", "INLIMBO"})
								for k, v in pairs(ents) do
									if v and v.components and v.components.lxautocollectitems then
										-- print("[SmartChest] ReleaseOverflowFish new collect chest")
										collectChest2Item(v)
									end
								end
							end)
						end
					end
				end
				-- print("[SmartChest] ReleaseOverflowFish new exit")
				
			end

		end
		AddComponentPostInit("oceantrawler",onOceanTrawlerOverflow)
	end

	-- 几乎所有类型掉落物，收集。
	if is_collect_all == 1 then
		local function LX_collect_all(inst)
			-- print("[SmartChest] LX_collect_all inst.prefab=" .. tostring(inst.prefab))
			if inst.prefab == "inventoryitem_classified" or inst:IsInLimbo() or inst:HasTag('smallcreature') or inst:HasTag("INLIMBO") or inst:HasTag('NOCLICK') or inst:HasTag('heavy') or inst:HasTag('trap') or inst:HasTag('NET_workable') then
				return
			end
			if inst and inst.components and inst.components.inventoryitem and inst.components.inventoryitem.canbepickedup == true then
				-- print("\tLX_collect_all inst.prefab=" .. tostring(inst.prefab))
				if inst.lx_collect_task ~= nil then
					inst.lx_collect_task:Cancel()
					inst.lx_collect_task = nil
				end
				inst.lx_collect_task = inst:DoTaskInTime(0.5, function(inst3)
					collectItem2Chest(inst3)
				end)
			end
		end
		AddPrefabPostInitAny(LX_collect_all)
	end

	-- 功能3. 打补丁
	-- 某些情况下 stackable:Put会调用到inst.replica.inventoryitem.classified，而classified=nil导致崩溃
	-- ！！！这一步直接覆盖了stackable组件的对stacksize修改的回调函数。如果以后游戏源文件中这个函数更新，需要跟着更新
	AddComponentPostInit("stackable",function(inst)
		local meta_table = _G.rawget(inst, "_")
		local old_onstacksize = meta_table["stacksize"][2]
		local i, _value, _name = 0, nil, ""
		while _name ~= "_src_pos" do
			i = i + 1
			_name, _value = debug.getupvalue(old_onstacksize, i)
		end
		local _src_pos = _value
		meta_table["stacksize"][2] = function(self, stacksize)
			self.inst.replica.stackable:SetStackSize(stacksize)
			if self.inst.replica.inventoryitem ~= nil and self.inst.replica.inventoryitem.classified then
				_name, _src_pos = debug.getupvalue(old_onstacksize, i)
				self.inst.replica.inventoryitem:SetPickupPos(_src_pos)
			end
		end
	end)

	-- 已绘制并且插在地上的小木牌防火
	-- 1.部署的时候移除burnable组件，因为部署之后会调用一次ondrawn，所以只实现2就可以了。2.绘制之后移除burnable组件。
	if minisign_no_fire == 1 then
		local function changeMinisign3(inst)
			local old_draw = inst.components.drawable.ondrawnfn -- 在画的时候，设置LX_collect_item
			inst.components.drawable:SetOnDrawnFn(function(inst2, image, src, ...)
				old_draw(inst2, image, src, ...)
				if image ~= nil then
					if inst2.components.burnable then
						inst2:RemoveComponent("burnable")
					end
					if inst2.components.propagator then
						inst2:RemoveComponent("propagator")
					end
				end
			end)
		end
		AddPrefabPostInit("minisign", changeMinisign3)
	end
end

-- { 111
-- 这部分是为了客户端显示小木牌名字做的改动。因为需要传递一部分服务器上mod的设置给客户端

-- 为服务端创建一个rpc 用来传递collect_chest_slot_prefab collect_all_prefab两个值
local function SeneInfoToClient(player)
	-- print("[mychest] SeneInfoToClient")
	SendModRPCToClient(CLIENT_MOD_RPC.SmartChest.SendInfo, player.userid, renameSpecialMinisign, collect_all_prefab, collect_chest_slot_prefab)
end
AddModRPCHandler("SmartChest", "SendInfo", SeneInfoToClient)

local isReceive = false
-- 为客户端创建一个rpc 用来传递collect_chest_slot_prefab collect_all_prefab两个值
local function ReceiveInfoFromServer(a,b,c)
	-- print("[mychest] ReceiveInfoFromServer")
	renameSpecialMinisign = a
	collect_all_prefab = b
	collect_chest_slot_prefab = c
	if collect_all_prefab ~= 0 then
		prefab2Name[collect_all_prefab] = {
			["zh"] = "收集所有物品",
			["en"] = "Collect all items",
		}
	end
	if collect_chest_slot_prefab ~= 0 then
		prefab2Name[collect_chest_slot_prefab] = {
			["zh"] = "收集内部物品",
			["en"] = "Collect inner items",
		}
	end
	isReceive = true
end
AddClientModRPCHandler("SmartChest", "SendInfo", ReceiveInfoFromServer)

-- } 111

if IsClient then
	-- 4.为特殊木牌修改显示名称
	-- 需要放到客户端
	local function changeMinisign4(inst)
		-- print("[mychest] isReceive=" .. tostring(isReceive))
		if isReceive == false then
			SendModRPCToServer(MOD_RPC.SmartChest.SendInfo)
		end
		if inst.prefab == "minisign" then
			if inst.LX_collect_item == nil then
				inst.LX_collect_item = _G.net_string(inst.GUID, "minisign.LX_collect_item") -- 用于保存收集物品的prefab，从服务器端获取数据
			end
		end
		if inst.prefab == "minisign_drawn" then
			if inst.LX_collect_item == nil then
				inst.LX_collect_item = _G.net_string(inst.GUID, "minisign_drawn.LX_collect_item") -- 用于保存收集物品的prefab，从服务器端获取数据
			end
		end
		local old_displaynamefn = inst.displaynamefn
		inst.displaynamefn = function(inst1)
			local name = old_displaynamefn(inst1)
			-- print("[mychest] minisign displaynamefn client")
			-- print("\tname=" .. tostring(name))
			-- print("\tinst.LX_collect_item=" .. tostring(inst.LX_collect_item:value()))
			-- print("\t#inst.LX_collect_item=" .. tostring(#inst.LX_collect_item:value()))
			if #inst.LX_collect_item:value() > 0 then
				for k,v in pairs(prefab2Name) do
					-- print("k=" .. tostring(k))
					if inst.LX_collect_item:value() == k then
						name = name .. "\n" .. v[variable]
						break
					end
				end
			end
			-- print("\tname=" .. tostring(name))
			return name
		end
	end
	AddPrefabPostInit("minisign", changeMinisign4)
	AddPrefabPostInit("minisign_drawn", changeMinisign4)

end


-- SendModRPCToServer(MOD_RPC.SmartChest.SendInfo)