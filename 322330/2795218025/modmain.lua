local TUNING = GLOBAL.TUNING
local LOW = 2
local MODERATE = 3
local HIGH = 4
local nzw_juxingshu = GetModConfigData("nzw_juxingshu")
local nzw_guocaishu = GetModConfigData("nzw_guocaishu")
local nzw_juxingguo = GetModConfigData("nzw_juxingguo")
local nzw_zhongzishu = GetModConfigData("nzw_zhongzishu")
local nzw_juxing = GetModConfigData("nzw_juxing")
local nzw_juxingzhong = GetModConfigData("nzw_juxingzhong")
local nzw_fulanguocai = GetModConfigData("nzw_fulanguocai")
local nzw_fulanzhongzi = GetModConfigData("nzw_fulanzhongzi")
local nongzuowu8 = GetModConfigData("nongzuowu8")
local nzw_jxfulanwu = GetModConfigData("nzw_jxfulanwu")
local nongzuowu10 = GetModConfigData("nongzuowu10")
local nongzuowu11 = GetModConfigData("nongzuowu11")
local nzw_wufulancw = GetModConfigData("nzw_wufulancw")
local nzw_wufulan = GetModConfigData("nzw_wufulan")
local nongzuowu14 = GetModConfigData("nongzuowu14")
local nzw_suidizhong = GetModConfigData("nzw_suidizhong")
local nzw_kuaizhai = GetModConfigData("nzw_kuaizhai")
local zujian_nongzuowu = GetModConfigData("zujian_nongzuowu")
local zujian_juxinghua = GetModConfigData("zujian_juxinghua")
local zujian_juxingshu = GetModConfigData("zujian_juxingshu")
local zujian_guocaishu = GetModConfigData("zujian_guocaishu")
local zujian_zhongzishu = GetModConfigData("zujian_zhongzishu")
local zujian_kuaizhai = GetModConfigData("zujian_kuaizhai")
local zujian_wufulan = GetModConfigData("zujian_wufulan")
local zujian_juxingfulan = GetModConfigData("zujian_juxingfulan")
local zujian_suidizhong = GetModConfigData("zujian_suidizhong")
local biwangwo = GetModConfigData("biwangwo")
local biwangwo1 = GetModConfigData("biwangwo1")
local yecao_shouhuo = GetModConfigData("yecao_shouhuo")
local yecao_chanwu = GetModConfigData("yecao_chanwu")
local yecao_hua = GetModConfigData("yecao_hua")
local yecao_kuaisu = GetModConfigData("yecao_kuaisu")
local mod_hulu = GetModConfigData("mod_hulu")
local mod_hulu1 = GetModConfigData("mod_hulu1")
local mod_hulu2 = GetModConfigData("mod_hulu2")
local mod_hulu3 = GetModConfigData("mod_hulu3")
local mod_songluo = GetModConfigData("mod_songluo")
local mod_songluo1 = GetModConfigData("mod_songluo1")
local mod_songluo2 = GetModConfigData("mod_songluo2")
local mod_songluo3 = GetModConfigData("mod_songluo3")
local mod_fulan1 = GetModConfigData("mod_fulan1")
local mod_fulan2 = GetModConfigData("mod_fulan2")
local mod_fulan3 = GetModConfigData("mod_fulan3")
local mod_kuaisu = GetModConfigData("mod_kuaisu")
local WEED_DEFS = GLOBAL.require("prefabs/weed_defs").WEED_DEFS--veggies
local farm_plant_ming = {"asparagus","carrot","corn","dragonfruit","durian","eggplant","garlic","onion","pepper","pomegranate","potato","pumpkin","watermelon","tomato"}
if yecao_hua ~= false then 
	AddPrefabPostInit("petals",function(inst)
		local function Seed_GetDisplayName(inst)
			local registry_key = inst.weed_def.product
			local plantregistryinfo = inst.weed_def.plantregistryinfo
			return (GLOBAL.ThePlantRegistry:KnowsSeed(registry_key, plantregistryinfo) and GLOBAL.ThePlantRegistry:KnowsPlantName(registry_key, plantregistryinfo)) and GLOBAL.STRINGS.NAMES["KNOWN_"..string.upper(inst.ming)]
					or nil
		end
		local function can_plant_seed(inst, pt, mouseover, deployer)
			local x, z = pt.x, pt.z
			return GLOBAL.TheWorld.Map:CanTillSoilAtPoint(x, 0, z, true)
		end
		local suiji = math.random()
		local yecaoming = suiji < 0.40 and "weed_forgetmelots" or suiji < 0.60 and "weed_tillweed" or suiji < 0.80 and "weed_firenettle" or suiji < 1 and "weed_ivy" or "weed_forgetmelots"		
		inst.ming = yecaoming
		inst.product = string.sub(inst.ming, 6)
		if inst.product == "firenettle" then inst.product = inst.product .. "s"
		elseif inst.product == "ivy" then inst.product = nil end
		inst:AddTag("deployedplant")
		inst:AddTag("deployedfarmplant")
		inst.overridedeployplacername = "seeds_placer"
		--inst.shuxu = inst.ming == "weed_forgetmelots" and 1 or inst.ming == "weed_tillweed" and 2 or inst.ming == "weed_firenettle" and 3 or inst.ming == "weed_ivy" and 4 or 1
		inst.weed_def = WEED_DEFS[inst.ming]
		--print("name:"..inst.ming.."        yecaoming:"..yecaoming.. "         product:"..inst.product)
		inst._custom_candeploy_fn = can_plant_seed
		inst.displaynamefn = Seed_GetDisplayName
	end)
end
if yecao_chanwu ~= false then 
	local yecao_ming = {"tillweed","firenettles","forgetmelots"}
	for _, v in pairs(yecao_ming) do AddPrefabPostInit(v, function(inst)
		local function Seed_GetDisplayName(inst)
			local registry_key = inst.product
			local plantregistryinfo = inst.yecao_def.plantregistryinfo
			return (GLOBAL.ThePlantRegistry:KnowsSeed(registry_key, plantregistryinfo) and GLOBAL.ThePlantRegistry:KnowsPlantName(registry_key, plantregistryinfo)) and GLOBAL.STRINGS.NAMES["KNOWN_"..string.upper(inst.prefab)]
					or nil
		end
		local function can_plant_seed(inst, pt, mouseover, deployer)
			local x, z = pt.x, pt.z
			return GLOBAL.TheWorld.Map:CanTillSoilAtPoint(x, 0, z, true)
		end
		inst.product = v
		inst.ming = "weed_"..inst.product
		--inst.shuxu = inst.ming == "weed_forgetmelots" and 1 or inst.ming == "weed_tillweed" and 2 or inst.ming == "weed_firenettle" and 3 or inst.ming == "weed_ivy" and 4 or 1
		inst:AddTag("deployedplant")
		inst:AddTag("deployedfarmplant")
		inst.overridedeployplacername = "seeds_placer"
		if inst.ming == "weed_firenettles" then inst.ming = "weed_firenettle" end
		inst.yecao_def = WEED_DEFS[inst.ming]
		inst._custom_candeploy_fn = can_plant_seed
		inst.displaynamefn = Seed_GetDisplayName
	end) end
end
if zujian_nongzuowu == 2 then if zujian_juxinghua then nzw_juxing = false end if zujian_juxingshu then nzw_juxingshu = false end if zujian_guocaishu then nzw_guocaishu = false end if zujian_zhongzishu then nzw_zhongzishu = false end if zujian_wufulan then nzw_wufulan = false end if zujian_kuaizhai then nzw_kuaizhai = false end if zujian_juxingfulan and nzw_wufulancw == 1 then nzw_wufulancw = false end if zujian_suidizhong then nzw_suidizhong = false end
else for _,v in pairs(farm_plant_ming) do AddPrefabPostInit("farm_plant_"..v,function(inst) if zujian_nongzuowu == 1 then if nzw_juxing then inst:AddTag("nzw_juxing") end if nzw_juxingshu ~= false then inst:AddTag("nzw_juxingshu") end if nzw_guocaishu ~= false then inst:AddTag("nzw_guocaishu") end if nzw_zhongzishu ~= false then inst:AddTag("nzw_zhongzishu") end if nzw_wufulan then inst:AddTag("nzw_wufulan") end if nzw_kuaizhai then inst:AddTag("nzw_kuaizhai") end elseif zujian_nongzuowu == 3 then inst:AddTag("nzw_juxing") inst:AddTag("nzw_juxingshu") inst:AddTag("nzw_guocaishu") inst:AddTag("nzw_zhongzishu") inst:AddTag("nzw_wufulan") inst:AddTag("nzw_kuaizhai") end end)
AddPrefabPostInit(v.."_oversized",function(inst) if zujian_nongzuowu == 1 then if nzw_wufulancw ~= false then inst:AddTag("nzw_wufulancw") end elseif zujian_nongzuowu == 3 then inst:AddTag("nzw_wufulancw") end end)
AddPrefabPostInit(v.."_seeds",function(inst) if zujian_nongzuowu == 1 then if nzw_suidizhong ~= false then inst:AddTag("nzw_suidizhong") end elseif zujian_nongzuowu == 3 then inst:AddTag("nzw_suidizhong") end end) end
end
if not (GLOBAL.TheNet:GetIsServer() or GLOBAL.TheNet:IsDedicated()) then return end
local pdzuowu = false
if nzw_jxfulanwu ~= false or nzw_fulanguocai ~= false or nzw_fulanzhongzi ~= false then
	pdzuowu = true
end
if pdzuowu or nzw_zhongzishu ~= false or nzw_guocaishu ~= false then
	pdzuowu = true
else
	pdzuowu = false
end
if nzw_juxingshu ~= false or pdzuowu then 
	local function nzwshouhuo(inst)
		local function pickupfn(inst)
			if inst.components.pickable and inst.components.pickable.onpickedfn then
				local pdtemp = inst.is_oversized
				local tempfn = inst.components.pickable.onpickedfn
				local tempfn2 = function(inst, doer)
					inst.is_oversized = true
					return tempfn(inst, doer)
				end
				inst.components.pickable.onpickedfn = tempfn2
				inst.is_oversized = pdtemp
			end
		end
		local function fulanfn(inst, temp)
			temp = {"spoiled_food"} pdzuowu = false
			if nzw_fulanguocai then pdzuowu = true for i = 1, nzw_fulanguocai do table.insert(temp, inst.plant_def.product) end end
			if nzw_fulanzhongzi then pdzuowu = true for i = 1, nzw_fulanzhongzi do table.insert(temp, inst.plant_def.seed) end end
			return temp, pdzuowu
		end
		local function fulanfn2(inst, temp2)
			temp2 = inst.plant_def.loot_oversized_rot 
			if nzw_jxfulanwu == 1 then temp2 = {"spoiled_food", "spoiled_food", "spoiled_food", inst.plant_def.seed}
			elseif nzw_jxfulanwu == 2 then temp2 = {inst.plant_def.seed, inst.plant_def.product}
			elseif nzw_jxfulanwu == 3 then temp2 = {inst.plant_def.seed, inst.plant_def.product, inst.plant_def.product}
			elseif nzw_jxfulanwu == 4 then temp2 = {inst.plant_def.seed} for i = 1, 4 do table.insert(temp2, inst.plant_def.product) end
			elseif nzw_jxfulanwu == 5 then temp2 = {inst.plant_def.seed} for i = 1, 6 do table.insert(temp2, inst.plant_def.product) end table.insert(temp2, inst.plant_def.seed)
			elseif nzw_jxfulanwu == 0 then if math.random() < 0.51 then temp2 = {"spoiled_food", "spoiled_food", "spoiled_food", inst.plant_def.seed} else temp2 = {"spoiled_food", "spoiled_food", "spoiled_food"} end
			elseif nzw_jxfulanwu == -1 then temp2 = {"spoiled_food", "spoiled_food", "spoiled_food"} end
			return temp2
		end
		local function SetupLoot(lootdropper)
			local inst = lootdropper.inst
			local temp = {}
			local temp2 = {}
			local geshu = 1
			local oversized = inst.is_oversized
			temp, pdzuowu = fulanfn(inst, temp)
			temp2 = fulanfn2(inst, temp2)
			if inst:HasTag("farm_plant_killjoy") then
				if pdzuowu then pickupfn(inst) end
				lootdropper:SetLoot(oversized and temp2 or temp)
			elseif inst.components.pickable ~= nil then
				local plant_stress = inst.components.farmplantstress ~= nil and inst.components.farmplantstress:GetFinalStressState() or HIGH
				temp = {}
				if oversized then
					if nzw_juxingshu then for i = 0,nzw_juxingshu do table.insert(temp, inst.plant_def.product_oversized) end
					else temp = {inst.plant_def.product_oversized}
					end
					lootdropper:SetLoot(temp)
				else
					if nzw_zhongzishu == false then if plant_stress <= LOW then geshu = 2 elseif plant_stress <= MODERATE then geshu = 1 else geshu = 0 end elseif nzw_zhongzishu ~= false and nzw_zhongzishu > 0 then if plant_stress <= LOW then geshu = nzw_zhongzishu + 2 elseif plant_stress <= MODERATE then geshu = nzw_zhongzishu + 1 else geshu = nzw_zhongzishu end elseif nzw_zhongzishu == 0 and math.random() > 0.50 then geshu = 1 else geshu = 0 end
					for i = 1, geshu do table.insert(temp, inst.plant_def.seed) end
					if nzw_guocaishu == false then geshu = 1 elseif nzw_guocaishu ~= false and nzw_guocaishu > 0 then geshu = nzw_guocaishu + 1 elseif nzw_guocaishu == 0 and math.random() < 0.51 then geshu = 1 else geshu = 0 end
					for i = 1, geshu do table.insert(temp, inst.plant_def.product) end
					lootdropper:SetLoot(temp)
				end
			end
		end
		if inst.components.lootdropper then inst.components.lootdropper.lootsetupfn = SetupLoot end
	end
	for _,v in pairs(farm_plant_ming) do AddPrefabPostInit("farm_plant_"..v,nzwshouhuo) end 
end
if zujian_juxinghua then AddComponentPostInit("growable",function(self) if not self.inst:HasTag("nzw_juxing") then self.inst.force_oversized = true end end) end
if zujian_wufulan or zujian_juxingshu or zujian_guocaishu or zujian_zhongzishu or zujian_kuaizhai then
	local function nongzuowufn(lootdropper)
		local inst = lootdropper.inst local temp = {} local geshu = 0
		if inst:HasTag("farm_plant_killjoy") then lootdropper:SetLoot(inst.is_oversized and inst.plant_def.loot_oversized_rot or {"spoiled_food"})
		elseif inst.components.pickable then local plant_stress = inst.components.farmplantstress and inst.components.farmplantstress:GetFinalStressState() or HIGH
			if inst.is_oversized then
				if zujian_juxingshu and not inst:HasTag("nzw_juxingshu") then if zujian_juxingshu == 0.5 and math.random() < 0.5 or zujian_juxingshu == 99 then geshu = 0 elseif zujian_juxingshu == 0.5 then geshu = 1 else geshu = zujian_juxingshu + 1 end for i = 1,geshu do table.insert(temp, inst.plant_def.product_oversized) end else temp = {inst.plant_def.product_oversized} end
			else geshu = plant_stress <= LOW and 2 or plant_stress <= MODERATE and 1 or 0
				if zujian_zhongzishu and not inst:HasTag("nzw_zhongzishu") then if zujian_zhongzishu == 0.5 and math.random() < 0.5 or zujian_zhongzishu == 99 then geshu = 0 elseif zujian_zhongzishu == 0.5 then geshu = 1 else geshu = zujian_zhongzishu + geshu end end for i = 1, geshu do table.insert(temp,inst.plant_def.seed) end
				if zujian_guocaishu and not inst:HasTag("nzw_guocaishu") then if zujian_guocaishu == 0.5 and math.random() < 0.5 or zujian_guocaishu == 99 then geshu = 0 elseif zujian_guocaishu == 0.5 then geshu = 1 else geshu = zujian_guocaishu + 1 end for i = 1,geshu do table.insert(temp, inst.plant_def.product) end else table.insert(temp,inst.plant_def.product) end
			end lootdropper:SetLoot(temp)
	end end
	AddComponentPostInit("pickable",function(self) local self1 = self.inst.components.growable
		if (self.inst:HasTag("farm_plant") or self.inst.plant_def) and self1 then
		if zujian_wufulan then self.inst:DoTaskInTime(0.1, function() if self1.stage == 5 and not self.inst:HasTag("nzw_wufulan") then self1:StopGrowing() end end) end
		if zujian_juxingshu and not self.inst:HasTag("nzw_juxingshu") or zujian_guocaishu and not self.inst:HasTag("nzw_guocaishu") or zujian_zhongzishu and not self.inst:HasTag("nzw_zhongzishu") then self.inst:DoTaskInTime(0.3, function() if self.inst.components.lootdropper and self.inst.plant_def then self.inst.components.lootdropper.lootsetupfn = nongzuowufn end end) end
		if zujian_kuaizhai then self.inst:DoTaskInTime(0.1, function() if not self.inst:HasTag("nzw_kuaizhai") then self.quickpick = true end end) end end
	end)
end
if zujian_juxingfulan then AddComponentPostInit("perishable",function(self) if self.inst:HasTag("waxable") then self.inst:DoTaskInTime(0.1, function() if not self.inst:HasTag("nzw_wufulancw") then self:SetPerishTime(self.perishtime) self:StopPerishing() self.localPerishMultiplyer = 0 end end) end end) end
if zujian_suidizhong then AddPrefabPostInitAny(function(inst) if inst.components.deployable and inst.components.deployable.restrictedtag == "plantkin" then inst.components.deployable.restrictedtag = "player" end inst:DoTaskInTime(0.1, function() if inst:HasTag("nzw_suidizhong") and inst.components.deployable and inst.components.deployable.restrictedtag == "player" then inst.components.deployable.restrictedtag = "plantkin" end end) end) end

if nzw_juxing then for _,v in pairs(farm_plant_ming) do AddPrefabPostInit("farm_plant_"..v,function(inst) inst.force_oversized = true end) end end
if nzw_wufulancw ~= false then 
	local function baoxianfn(inst) if inst.components.perishable then inst.components.perishable.localPerishMultiplyer = 0 end end
	if nzw_wufulancw ~= 2 then for _,v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_oversized",baoxianfn) end 
	elseif nzw_wufulancw ~= 1 then for _,v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_seeds",baoxianfn) end
	elseif nzw_wufulancw == 3 then local fpm = farm_plant_ming table.insert(fpm,"seeds") for _,v in pairs(fpm) do AddPrefabPostInit(v,baoxianfn) end end
end
if nzw_wufulan or nzw_kuaizhai then AddComponentPostInit("pickable",function(self) self.inst:DoTaskInTime(0.3, function() if self.inst:HasTag("nzw_14zuowu") and self.inst.components.growable and self.inst.components.growable.stage == 5 then if nzw_wufulan then self.inst.components.growable:StopGrowing() end if nzw_kuaizhai then self.quickpick = true end end end) end)
	for _,v in pairs(farm_plant_ming) do AddPrefabPostInit("farm_plant_"..v,function(inst) inst:AddTag("nzw_14zuowu") end) end 
end
if nongzuowu14 ~= false then 
	local function growthfn(inst)
		if inst.components.growable and inst.components.growable.stage > 5 and inst.components.growable.stage == #inst.components.growable.stages then inst.components.growable:StartGrowing(0) end
		inst:DoTaskInTime(1, function(inst)
			if inst.components.growable and #inst.components.growable.stages > 5 then 
				inst.components.growable.stages[#inst.components.growable.stages] = nil
				if inst.components.growable.stage > #inst.components.growable.stages then inst.components.growable.stage = #inst.components.growable.stages end
			end
		end)
	end for _,v in pairs(farm_plant_ming) do AddPrefabPostInit("farm_plant_"..v,growthfn) end 
end
if nzw_suidizhong ~= false then 
	local fpm = {} if nzw_suidizhong ~= 1 then for _,v in pairs(farm_plant_ming) do table.insert(fpm, v.."_seeds") end end if nzw_suidizhong == 3 then table.insert(fpm, "seeds") elseif nzw_suidizhong == 1 then fpm = {"seeds"} end
	for _,v in pairs(fpm) do AddPrefabPostInit(v,function(inst) if inst.components.deployable then inst.components.deployable.restrictedtag = "player" inst:ListenForEvent("oneaten",function(inst,data) if data and data.eater then inst:DoTaskInTime(0.01,function(inst) if data.eater.components.talker then data.eater.components.talker:Say("你的献祭，将使我强大！") end end) end end) end end) end 
end
if nongzuowu8 ~= false then 
	local function judafn(inst)
		if inst.components.inventoryitem == nil then inst:AddComponent("inventoryitem") end
		inst.components.inventoryitem.cangoincontainer = true
		inst.components.inventoryitem.canbepickedup = true
		inst.components.inventoryitem.canonlygoinpocket = true
		inst:RemoveComponent("equippable")
		if nongzuowu8 < 3 then inst:RemoveTag("heavy") end
		if (nongzuowu8 == 2 or nongzuowu8 == 4) and inst.components.lootdropper then
			inst:AddComponent("stackable")
			inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
			if inst.components.workable then local workfn = inst.components.workable.onfinish
			local workfn2 = function(inst, chopper)
				local temp = {}
				if #inst.components.lootdropper.loot > 1 then 
					for i = 1, inst.components.stackable:StackSize() do
						for _, v in pairs(inst.components.lootdropper.loot) do table.insert(temp, v) end
					end
				else
					for i = 1, inst.components.stackable:StackSize() do table.insert(temp, inst.components.lootdropper.loot) end
				end
				inst.components.lootdropper:SetLoot(temp)
				return workfn(inst, chopper)
			end
			inst.components.workable:SetOnFinishCallback(workfn2) end
			if inst.components.burnable then local burnfn = inst.components.burnable.onburnt
			local burnfn2 = function(inst)
				local temp = {}
				if #inst.components.lootdropper.loot > 1 then 
					for i = 1, inst.components.stackable:StackSize() do
						for _, v in pairs(inst.components.lootdropper.loot) do table.insert(temp, v) end
					end
				else
					for i = 1, inst.components.stackable:StackSize() do table.insert(temp, inst.components.lootdropper.loot) end
				end
				inst.components.lootdropper:SetLoot(temp)
				return burnfn(inst)
			end
			inst.components.burnable:SetOnBurntFn(burnfn2) end
		end
	end for i,v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_oversized", judafn) AddPrefabPostInit(v.."_oversized_waxed", judafn) end 
end
if nongzuowu10 ~= false or nongzuowu11 ~= false then
	local loots = {}
	local seed = "spoiled_food"
	local product = "spoiled_food"
	for i, v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_oversized_waxed", function(inst) 
			seed = v.."_seeds" product = v
			loots = {}
			if nongzuowu10 then  for i = 1, nongzuowu10 do table.insert(loots, product) end end
			if nongzuowu11 then  for i = 1, nongzuowu11 do table.insert(loots, seed) end end
			table.insert(loots, "spoiled_food")
			if inst.components.lootdropper then inst.components.lootdropper:SetLoot(loots) end
		end) 
	end
end
if nzw_jxfulanwu ~= false then
	local loots = {}
	local seed = "spoiled_food"
	local product = "spoiled_food"
	for i,v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_oversized_rotten",function(inst)
			seed = v.."_seeds" product = v
			if nzw_jxfulanwu == 1 then loots = {"spoiled_food", "spoiled_food", "spoiled_food", seed}
			elseif nzw_jxfulanwu == 2 then loots = {seed, product}
			elseif nzw_jxfulanwu == 3 then loots = {seed, product, product}
			elseif nzw_jxfulanwu == 4 then loots = {seed} for i = 1, 4 do table.insert(temp2, product) end
			elseif nzw_jxfulanwu == 5 then loots = {seed, seed} for i = 1, 6 do table.insert(temp2, product) end
			elseif nzw_jxfulanwu == 0 then if math.random() < 0.51 then loots = {"spoiled_food", "spoiled_food", "spoiled_food", seed} else loots = {"spoiled_food", "spoiled_food", "spoiled_food"} end
			elseif nzw_jxfulanwu == -1 then loots = {"spoiled_food", "spoiled_food", "spoiled_food"} 
			else loots = {"spoiled_food", "spoiled_food", "spoiled_food", seed}
			end
			if inst.components.lootdropper then inst.components.lootdropper:SetLoot(loots) end
		end) 
	end
end
if nzw_juxingguo ~= false or nzw_juxingzhong ~= false then
	local loots = {}
	local geshu = 1
	local suiji = 0
	local seed = "spoiled_food"
	local product = "spoiled_food"
	for i,v in pairs(farm_plant_ming) do AddPrefabPostInit(v.."_oversized",function(inst)
			seed = v.."_seeds" product = v
			loots = {} suiji = math.random()
			if nzw_juxingguo ~= false and nzw_juxingguo > 0 then if suiji < 0.75 then geshu = nzw_juxingguo + 3 else geshu = nzw_juxingguo + 2 end elseif nzw_juxingguo == 0 and suiji < 0.50 then geshu = 1 else geshu = 0 end 
			for i = 1, geshu do table.insert(loots, product) end
			if nzw_juxingzhong ~= false and nzw_juxingzhong > 0 then if suiji > 0.74 then geshu = nzw_juxingzhong + 3 else geshu = nzw_juxingzhong + 2 end elseif nzw_juxingzhong == 0 and suiji > 0.49 then geshu = 1 else geshu = 0 end 
			for i = 1, geshu do table.insert(loots, seed) end
			if inst.components.lootdropper then inst.components.lootdropper:SetLoot(loots) end
		end)
	end
end
if biwangwo ~= false then 
	local function ycshouhuo(inst)
		local function SetupLoot(lootdropper)
			local inst = lootdropper.inst
			if inst.components.pickable ~= nil then
				local temp = {}
				local geshu = 1
				if biwangwo ~= false and biwangwo > 0 then geshu = biwangwo + 1 elseif biwangwo == 0 and math.random() < 0.51 then geshu = 1 else geshu = 0 end 
				for i = 1, geshu do table.insert(temp, inst.weed_def.product) end
				lootdropper:SetLoot(temp)
			end
		end
		if inst.components.lootdropper then inst.components.lootdropper.lootsetupfn = SetupLoot end
	end
	AddPrefabPostInit("weed_forgetmelots",ycshouhuo) 
end
if biwangwo1 or yecao_kuaisu then AddComponentPostInit("pickable",function(self) self.inst:DoTaskInTime(1, function() if self.inst:HasTag("yc_bww") and self.inst.components.growable and self.inst.components.growable.stage + 1 == #self.inst.components.growable.stages then if biwangwo1 then self.inst.components.growable:StopGrowing() end if yecao_kuaisu then self.quickpick = true end end end) end)
	AddPrefabPostInit("weed_forgetmelots",function(inst) inst:AddTag("yc_bww") end)
	if biwangwo1 == 2 then AddPrefabPostInit("forgetmelots",function(inst) if inst.components.perishable then inst.components.perishable.localPerishMultiplyer = 0 end end) end
end
if yecao_shouhuo then
	local yecao_ming = {"weed_tillweed","weed_firenettle"}
	for _, v in pairs(yecao_ming) do AddPrefabPostInit(v, function(inst)
		local function SetupLoot(lootdropper)
			local inst = lootdropper.inst
			if inst.components.pickable ~= nil then
				local temp = {}
				local geshu = 1
				if yecao_shouhuo ~= false and yecao_shouhuo > 0 then geshu = yecao_shouhuo + 1 elseif yecao_shouhuo == 0 and math.random() < 0.51 then geshu = 1 else geshu = 0 end 
				for i = 1, geshu do table.insert(temp, inst.weed_def.product) end
				lootdropper:SetLoot(temp)
			end
		end
		if inst.components.lootdropper then inst.components.lootdropper.lootsetupfn = SetupLoot end
	end) end
end
if yecao_chanwu ~= false then 
	local function OnDeploy(inst, pt, deployer)
		local plant = GLOBAL.SpawnPrefab(inst.components.farmplantable.plant)
		plant.Transform:SetPosition(pt.x, 0, pt.z)
		plant:PushEvent("on_planted", {in_soil = false, doer = deployer, seed = inst})
		GLOBAL.TheWorld.Map:CollapseSoilAtPoint(pt.x, 0, pt.z)
		inst:Remove()
	end
	local function yecaozhongzhi(inst)
		local restrictedtag = nil
		if yecao_chanwu == 1 then restrictedtag = "plantkin" end 
		inst:AddComponent("farmplantable")
		inst.components.farmplantable.plant = inst.ming
		inst:AddComponent("plantable")
		inst.components.plantable.growtime = TUNING.SEEDS_GROW_TIME
		inst.components.plantable.product = inst.product
		inst:AddComponent("deployable")
		inst.components.deployable:SetDeployMode(GLOBAL.DEPLOYMODE.CUSTOM)
		inst.components.deployable.restrictedtag = restrictedtag
		inst.components.deployable.ondeploy = OnDeploy
		inst:ListenForEvent("oneaten",function(inst,data) if data and data.eater then inst:DoTaskInTime(0.01,function(inst) if data.eater.components.talker then data.eater.components.talker:Say("你的献祭，将使我强大！") end end) end end)
	end
	local yecao_ming = {"tillweed","firenettles","forgetmelots"}
	for _, v in pairs(yecao_ming) do AddPrefabPostInit(v, yecaozhongzhi) end
end
if yecao_hua ~= false then 
	local function OnDeploy(inst, pt, deployer)
		local plant = GLOBAL.SpawnPrefab(inst.components.farmplantable.plant)
		plant.Transform:SetPosition(pt.x, 0, pt.z)
		plant:PushEvent("on_planted", {in_soil = false, doer = deployer, seed = inst})
		GLOBAL.TheWorld.Map:CollapseSoilAtPoint(pt.x, 0, pt.z)
		inst:Remove()
	end
	local function yecaozhongzhi(inst)
		local restrictedtag = nil
		if yecao_hua == 1 then restrictedtag = "plantkin" end 
		inst:AddComponent("farmplantable")
		inst.components.farmplantable.plant = inst.ming
		inst:AddComponent("plantable")
		inst.components.plantable.growtime = TUNING.SEEDS_GROW_TIME
		inst.components.plantable.product = inst.product
		inst:AddComponent("deployable")
		inst.components.deployable:SetDeployMode(GLOBAL.DEPLOYMODE.CUSTOM)
		inst.components.deployable.restrictedtag =  restrictedtag
		inst.components.deployable.ondeploy = OnDeploy
		inst:ListenForEvent("oneaten",function(inst,data) if data and data.eater then inst:DoTaskInTime(0.01,function(inst) if data.eater.components.talker then data.eater.components.talker:Say("你的献祭，将使我强大！") end end) end end)
	end
	AddPrefabPostInit("petals",yecaozhongzhi)
end