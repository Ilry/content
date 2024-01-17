local TheNet = GLOBAL.TheNet
local TheSim = GLOBAL.TheSim
local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local stack_size = GetModConfigData("STACK_SIZE")
local stack_size1 = GetModConfigData("STACK_SIZE1")
local Stack_other_objects = GetModConfigData("STACK_OTHER_OBJECTS")

--旧版
-- GLOBAL.TUNING.STACK_SIZE_LARGEITEM = stack_size
-- GLOBAL.TUNING.STACK_SIZE_MEDITEM = stack_size
-- GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stack_size
-- GLOBAL.TUNING.STACK_SIZE_TINYITEM = stack_size
-- GLOBAL.TUNING.WORTOX_MAX_SOULS = stack_size1

-- local mod_stackable_replica = GLOBAL.require("components/stackable_replica")
-- mod_stackable_replica._ctor = function(self, inst)
	-- self.inst = inst
	-- self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
	-- self._maxsize = GLOBAL.net_shortint(inst.GUID, "stackable._maxsize")
-- end


--增加了原始数据选项
if stack_size ~= 20 then
	GLOBAL.TUNING.STACK_SIZE_LARGEITEM = stack_size
	GLOBAL.TUNING.STACK_SIZE_MEDITEM = stack_size
	GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stack_size
	GLOBAL.TUNING.STACK_SIZE_TINYITEM = stack_size
end

if stack_size1 ~= 20 then
	GLOBAL.TUNING.WORTOX_MAX_SOULS = stack_size1
end

if stack_size ~= 20 or stack_size1 ~= 20 then
	local mod_stackable_replica = GLOBAL.require("components/stackable_replica")
	mod_stackable_replica._ctor = function(self, inst)
		self.inst = inst
		self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
		self._maxsize = GLOBAL.net_shortint(inst.GUID, "stackable._maxsize")
	end
end


--遍历需要叠加的动物
local function AddAnimalStackables(value)
	if IsServer == false then
		return
	end
	for k,v in ipairs(value) do
		AddPrefabPostInit(v,function(inst)
			if(inst.components.stackable == nil) then
				inst:AddComponent("stackable")
			end
			inst.components.inventoryitem:SetOnDroppedFn(function(inst)
				-- if(inst.components.perishable ~= nil) then
					-- inst.components.perishable:StopPerishing()
				-- end
				if(inst.sg ~= nil) then
					inst.sg:GoToState("stunned")
				end
				if inst.components.stackable then
					while inst.components.stackable:StackSize() > 1 do
						local item = inst.components.stackable:Get()
						if item then
							if item.components.inventoryitem then
								item.components.inventoryitem:OnDropped()
							end
							item.Physics:Teleport(inst.Transform:GetWorldPosition())
						end
					end
				 end
			end)
		end)
	end
end


--遍历需要叠加的物品
local function AddItemStackables(value)
	if IsServer == false then
		return
	end
	for k,v in ipairs(value) do
		AddPrefabPostInit(v,function(inst)
			if  inst.components.sanity ~= nil  then
				return
			end
			if  inst.components.inventoryitem == nil  then
				return
			end
			if(inst.components.stackable == nil) then
				inst:AddComponent("stackable")
			end
		end)
	end
end

if Stack_other_objects then 
	if GetModConfigData("rabbit") then
		--小兔子
		AddAnimalStackables({"rabbit",})
	end
	if GetModConfigData("mole") then
		--鼹鼠
		AddAnimalStackables({"mole",})
	end
	if GetModConfigData("bird") then
		--鸟类
		AddAnimalStackables({"robin","robin_winter","crow","puffin","canary","canary_poisoned","bird_mutant","bird_mutant_spitter",})
	end
	if GetModConfigData("fish") then
		--鱼类
		local STACKABLE_OBJECTS_BASE = {"pondfish","pondeel","oceanfish_medium_1_inv","oceanfish_medium_2_inv","oceanfish_medium_3_inv","oceanfish_medium_4_inv","oceanfish_medium_5_inv","oceanfish_medium_6_inv","oceanfish_medium_7_inv","oceanfish_medium_8_inv","oceanfish_small_1_inv","oceanfish_small_2_inv","oceanfish_small_3_inv","oceanfish_small_4_inv","oceanfish_small_5_inv","oceanfish_small_6_inv","oceanfish_small_7_inv","oceanfish_small_8_inv","oceanfish_small_9_inv","wobster_sheller_land","wobster_moonglass_land","oceanfish_medium_9_inv"}
		AddAnimalStackables(STACKABLE_OBJECTS_BASE)
	end
	if GetModConfigData("eyeturret") then
		--眼球炮塔
		AddItemStackables({"eyeturret_item"})
	end
	if GetModConfigData("tallbirdegg") then
		--高脚鸟蛋相关
		AddAnimalStackables({"tallbirdegg_cracked","tallbirdegg"})
	end
	if GetModConfigData("lavae_egg") then
		--岩浆虫卵相关
		AddAnimalStackables({"lavae_egg","lavae_egg_cracked","lavae_tooth","lavae_cocoon"})
	end
	if GetModConfigData("shadowheart") then
		--暗影心房
		AddItemStackables({"shadowheart"})
	end
	if GetModConfigData("minotaurhorn") then
		--犀牛角
		AddItemStackables({"minotaurhorn"})
	end
	
	-------- Thanks For 小花朵 ---------
	if GetModConfigData("aip_leaf_note") then
		--树叶笔记【额外物品包】
		AddItemStackables({"aip_leaf_note"})
	end
	if GetModConfigData("miao_packbox") then
		--超级打包盒
		AddItemStackables({"miao_packbox"})
	end
	if GetModConfigData("glommerwings") then
		--格罗姆翅膀
		AddItemStackables({"glommerwings"})
	end
	if GetModConfigData("moonrockidol") then
		--月岩雕像
		AddItemStackables({"moonrockidol"})
	end
	if GetModConfigData("horn") then
		--牛角
		AddItemStackables({"horn"})
	end
	-- 2023-12-01 记
	if GetModConfigData("myth_lotusleaf") then
		--荷叶【神话书说】
		AddItemStackables({"myth_lotusleaf"})
	end
	-- 2023、12、20（各种蜘蛛）
	-- if GetModConfigData("spider") then
		--普通蜘蛛
		-- AddItemStackables({"spider"})
	-- end
	-- if GetModConfigData("spider_healer") then
		--护士蜘蛛
		-- AddItemStackables({"spider_healer"})
	-- end
	-- if GetModConfigData("spider_hider") then
		--洞穴蜘蛛
		-- AddItemStackables({"spider_hider"})
	-- end
	-- if GetModConfigData("spider_moon") then
		--破碎蜘蛛
		-- AddItemStackables({"spider_moon"})
	-- end
	-- if GetModConfigData("spider_spitter") then
		--喷射蜘蛛
		-- AddItemStackables({"spider_spitter"})
	-- end
	-- if GetModConfigData("spider_warrior") then
		--蜘蛛战士
		-- AddItemStackables({"spider_warrior"})
	-- end
	if GetModConfigData("spider") then
		--蜘蛛类
		AddAnimalStackables({"spider","spider_healer","spider_hider","spider_moon","spider_spitter","spider_warrior",})
	end
	if GetModConfigData("blank_certificate") then
		--空白勋章【能力勋章】
		AddItemStackables({"blank_certificate","copy_blank_certificate"})
	end
	
end