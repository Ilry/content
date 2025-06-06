GLOBAL.setmetatable(env,{__index = function(t, k)return GLOBAL.rawget(GLOBAL,k)end,})

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local stack_size = GetModConfigData("STACK_SIZE")
local stack_size1 = GetModConfigData("STACK_SIZE1")
local Stack_other_objects = GetModConfigData("STACK_OTHER_OBJECTS")


--增加了原始数据选项
if stack_size ~= 20 then
	TUNING.STACK_SIZE_LARGEITEM = stack_size
	TUNING.STACK_SIZE_MEDITEM = stack_size
	TUNING.STACK_SIZE_SMALLITEM = stack_size
	TUNING.STACK_SIZE_TINYITEM = stack_size
	TUNING.STACK_SIZE_PELLET = stack_size > 120 and stack_size or 120  --弹弓子弹
end

if stack_size1 ~= 20 then
	TUNING.WORTOX_MAX_SOULS = stack_size1
end


if stack_size ~= 20 or stack_size1 ~= 20 then
	local function OnStackSizeDirty(inst)
		local self = inst.replica.stackable
		if not self then
			return --stackable removed?
		end

		self:ClearPreviewStackSize()
		inst:PushEvent("inventoryitem_stacksizedirty")
	end

	local mod_stackable_replica = require("components/stackable_replica")
	mod_stackable_replica._ctor = function(self, inst)
		self.inst = inst
		self._stacksize = net_int(inst.GUID, "stackable._stacksize", "stacksizedirty")
		self._stacksizeupper = net_int(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
		self._ignoremaxsize = net_bool(inst.GUID, "stackable._ignoremaxsize")
		self._maxsize = net_int(inst.GUID, "stackable._maxsize")
		if not TheWorld.ismastersim then
			inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
		end
	end
	
end


-- 定义堆叠大小单位常量（2的16次方）
local MAX_STACK_SIZE_UNIT = 65536
-- 引入 stackable_replica 组件
local stackable_replica = require("components/stackable_replica")

-- 获取堆叠物品当前大小
stackable_replica.StackSize = function(self)
    return self:GetPreviewStackSize() or (self._stacksizeupper:value() * MAX_STACK_SIZE_UNIT + 1 + self._stacksize:value())
end

-- 设置堆叠大小网络变量值
local function setStackSizeValues(self, upper, lower)
    self._stacksizeupper:set(upper)
    self._stacksize:set_local(lower)
    self._stacksize:set(lower)
end

-- 设置堆叠物品的大小
stackable_replica.SetStackSize = function(self, stacksize)
    stacksize = stacksize - 1
    if stacksize < MAX_STACK_SIZE_UNIT then
        setStackSizeValues(self, 0, stacksize)
    else
        local upper = math.floor(stacksize / MAX_STACK_SIZE_UNIT)
        local lower = stacksize - upper * MAX_STACK_SIZE_UNIT
        setStackSizeValues(self, upper, lower)
    end
end


-- 获取全局 tostring 函数
local tostring = GLOBAL.tostring
-- 引入 widgets/text 模块
local Text = GLOBAL.require("widgets/text")

-- 根据物品数量获取合适字体大小
local function getFontSize(quantity)
    if quantity <= 999 then return 42 end
    if quantity <= 9999 then return 36 end
    if quantity <= 99999 then return 34 end
    if quantity <= 999999 then return 32 end
    return 30
end

-- 重写 ItemTile 类的 SetQuantity 方法
AddClassPostConstruct("widgets/controls", function ()
    local ItemTile = require("widgets/itemtile")
    function ItemTile:SetQuantity(quantity)
        if self.onquantitychangedfn and self:onquantitychangedfn(quantity) then
            if self.quantity then
                self.quantity = self.quantity:Kill()
            end
            return
        elseif not self.quantity then
            self.quantity = self:AddChild(Text(GLOBAL.NUMBERFONT, 42))
        end
        local size = getFontSize(quantity)
        local quantityStr = tostring(quantity)
        self.quantity:SetSize(size)
        self.quantity:SetPosition(2, 16, 0)
        self.quantity:SetString(quantityStr)
    end
end)


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
			if inst.components.follower then
				local old_stack_get = inst.components.stackable.Get
				function inst.components.stackable:Get(num)
					local stack_get = old_stack_get(self, num)
					if inst.components.follower then
						stack_get.components.follower:SetLeader(inst.components.follower.leader)
					end
					return stack_get
				end
			end
			if inst.components.inventoryitem then
				inst.components.inventoryitem:SetOnDroppedFn(function(inst)
					-- if(inst.components.perishable ~= nil) then
						-- inst.components.perishable:StopPerishing()
					-- end
					if(inst.sg ~= nil) then
						inst.sg:GoToState("stunned")
					end
					local leader = nil
					if inst.components.follower then
						leader = inst.components.follower.leader
					end
					if inst.components.stackable then
						while inst.components.stackable:StackSize() > 1 do
							local item = inst.components.stackable:Get()
							if item then
								if item.components.inventoryitem then
									if item.components.follower and leader then
										item.components.follower:SetLeader(leader)
									end
									item.components.inventoryitem:OnDropped()
								end
								item.Physics:Teleport(inst.Transform:GetWorldPosition())
							end
						end
					 end
				end)
			end
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
		AddAnimalStackables({"mole","carrat"})
	end
	if GetModConfigData("bird") then
		--鸟类
		AddAnimalStackables({"robin","robin_winter","crow","puffin","canary","canary_poisoned","bird_mutant_spitter",})
	end
	if GetModConfigData("crow") then
		--月盲乌鸦
		AddAnimalStackables({"bird_mutant"})
	end
	
	if GetModConfigData("fish") then
		--鱼类
		local STACKABLE_OBJECTS_BASE = {"pondfish","pondeel","oceanfish_medium_1_inv","oceanfish_medium_2_inv","oceanfish_medium_3_inv","oceanfish_medium_4_inv","oceanfish_medium_5_inv","oceanfish_medium_6_inv","oceanfish_medium_7_inv","oceanfish_medium_8_inv","oceanfish_small_1_inv","oceanfish_small_2_inv","oceanfish_small_3_inv","oceanfish_small_4_inv","oceanfish_small_5_inv","oceanfish_small_6_inv","oceanfish_small_7_inv","oceanfish_small_8_inv","oceanfish_small_9_inv","wobster_sheller_land","wobster_moonglass_land","oceanfish_medium_9_inv","lightcrab"}
		AddAnimalStackables(STACKABLE_OBJECTS_BASE)
	end
	if GetModConfigData("eyeturret") then
		--眼球炮塔和冰眼结晶器套装
		AddItemStackables({"eyeturret_item","deerclopseyeball_sentryward_kit"})
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
		AddItemStackables({"shadowheart","shadowheart_infused"})
	end
	
	if GetModConfigData("glommerwings") then
		--格罗姆翅膀
		AddItemStackables({"glommerwings"})
	end
	if GetModConfigData("moonrockidol") then
		--月岩雕像破碎的心
		AddItemStackables({"moonrockidol","reviver"})
	end
	if GetModConfigData("horn") then
		--牛角
		AddItemStackables({"horn","gnarwail_horn"})
	end
	
	if GetModConfigData("spider") then
		--蜘蛛类
		AddAnimalStackables({"spider","spider_healer","spider_hider","spider_moon","spider_spitter","spider_warrior","spider_dropper","spider_water"})
	end
	
	if GetModConfigData("security_pulse_cage") then
		--火花柜和约束静电
		AddItemStackables({"security_pulse_cage","security_pulse_cage_full","moonstorm_static_item"})
	end
	if GetModConfigData("deer_antler") then
		--鹿角和麋鹿茸
		AddItemStackables({"deer_antler","deer_antler1","deer_antler2","deer_antler3","klaussackkey"})
	end
	-- if GetModConfigData("alterguardianhatshard") then
		--启迪碎片
		-- AddItemStackables({"alterguardianhatshard"})
	-- end
	if GetModConfigData("chestupgrade_stacksize") then
		--箱子升级组件
		AddItemStackables({"chestupgrade_stacksize"})
	end
	if GetModConfigData("shell") then
		--贝壳钟
		AddItemStackables({"singingshell_octave3","singingshell_octave4","singingshell_octave5"})
	end
	
	if GetModConfigData("wally") then
		--厨师炊具
		AddItemStackables({"portablecookpot_item","portableblender_item","portablespicer_item"})
	end
	
	if GetModConfigData("winona") then
		--女工得投石机和聚光灯
	AddItemStackables({"winona_catapult_item","winona_spotlight_item"})
	end
	
	if GetModConfigData("mooneye") then
	--月眼
	AddItemStackables({
	--"moonrockcrater", 升级时候会整组变一个， 暂时先不加
	"redmooneye","orangemooneye","yellowmooneye","greenmooneye","purplemooneye","bluemooneye"})
	end
	
	if GetModConfigData("boat_stuff") then
	--船上用品
	AddItemStackables({
	--常规船上用品
	"boat_grass_item", "boat_item", "anchor_item","steeringwheel_item","boat_rotator_kit","mast_item", "ocean_trawler_kit","boat_cannon_kit","mastupgrade_lightningrod_item","mast_malbatross_item","boat_ancient_item",
	--龙年限定
	"dragonboat_pack", "boatrace_seatack_throwable_deploykit","dragonboat_kit","yotd_anchor_item","mast_yotd_item","yotd_steeringwheel_item","mastupgrade_lamp_item_yotd"
		})
	end
	if GetModConfigData("ancienttree_stuff") then
	--惊喜种子
	AddItemStackables({"ancienttree_seed","ancienttree_nightvision_sapling_item","ancienttree_gem_sapling_item"})
	end
	if GetModConfigData("pumpkintools") then
	--万圣节南瓜雕刻工具
	AddItemStackables({"pumpkincarver1","pumpkincarver2","pumpkincarver3"})
	end
	
	
	-- 这里草图和蓝图都需要
    if GetModConfigData("blueprint") or GetModConfigData("sketch") then 
		-- 蓝图、草图擦除修复
		AddComponentPostInit("stackable", function(self)
		--	if not IsServer then return inst end 
			-- local oldOnSave = self.OnSave
			
			-- function self:OnSave(sz)
				-- local data = oldOnSave(self) or {}
				-- data.stack = self.stacksize
				-- return data
			-- end
			
			function self:SetStackSize(sz)
				sz = sz or 1
				local old_size = self.stacksize
				self.stacksize = math.min(sz, MAXUINT)
				self.inst:PushEvent("stacksizechange", {stacksize = sz, oldstacksize=old_size})
			end
		end)
		

	end
	
	-- 蓝图部分
	 if GetModConfigData("blueprint") then
		-- 学习蓝图全组消耗修复
		AddComponentPostInit("teacher", function(self)
		--	if not IsServer then return inst end 
			function self:Teach(target)
				if self.recipe == nil then
					self.inst:Remove()
					return false
				elseif target.components.builder == nil then
					return false
				elseif target.components.builder:KnowsRecipe(self.recipe) then
					return false, "KNOWN"
				elseif not target.components.builder:CanLearn(self.recipe) then
					return false, "CANTLEARN"
				else target.components.builder:UnlockRecipe(self.recipe)
					if self.onteach then
						self.onteach(self.inst, target)
					end
					--学习蓝图时不会一次全消耗
					--self.inst:Remove()
					if self.inst.components.stackable then
						self.inst.components.stackable:Get():Remove()
					else
						self.inst:Remove()
					end
					return true
				end
			end
		end)
		
		AddPrefabPostInit("blueprint", function(inst)
			if not IsServer then return inst end 
			inst:DoTaskInTime(0, function(inst)
				inst.skinname=inst.components.teacher.recipe
			end)
			if inst.components.stackable == nil then
				inst:AddComponent("stackable")
			end
			if inst.components.teacher and inst.components.teacher.recipe then
				local old_stack_get = inst.components.stackable.Get
				function inst.components.stackable:Get(num)
					old_stack_get(self, num):Remove()
					local inst = SpawnPrefab(self.inst.components.teacher.recipe .. "_blueprint")
					inst.components.stackable:SetStackSize(num)
					return inst
				end
			end
		end)
		
		--广告部分
		AddPrefabPostInit("tacklesketch", function(inst)
			if not IsServer then return inst end 
			inst:DoTaskInTime(0, function(inst)
				inst.skinname=inst.components.teacher.recipe
			end)
			if inst.components.stackable == nil then
				inst:AddComponent("stackable")
			end
			if inst.components.teacher and inst.components.teacher.recipe then
				local old_stack_get = inst.components.stackable.Get
				function inst.components.stackable:Get(num)
					old_stack_get(self, num):Remove()
					local inst = SpawnPrefab(self.inst.components.teacher.recipe .. "_tacklesketch")
					inst.components.stackable:SetStackSize(num)
					return inst
				end
			end
		end)
	 end
	
	-- 草图部分
	if GetModConfigData("sketch") then
		AddPrefabPostInit("sketch", function(inst)
			if not IsServer then return inst end 
			inst:DoTaskInTime(0, function(inst)
				inst.skinname=inst:GetSpecificSketchPrefab()
			end)
			if inst.components.stackable == nil then
				inst:AddComponent("stackable")
			end
			local old_stack_get = inst.components.stackable.Get
			function inst.components.stackable:Get(num)
				old_stack_get(self, num):Remove()
				local inst = SpawnPrefab(inst:GetSpecificSketchPrefab())
				inst.components.stackable:SetStackSize(num)
				return inst
			end
		end)
	end
	
	
	--模组物品
	if GetModConfigData("dengxian") then
		--【登仙】暗影玫瑰， 上品灵石， 仙品灵石
		AddItemStackables({"xd_aymg","xd_lingshi3","xd_lingshi4"})
	end
	
	if GetModConfigData("myth_lotusleaf") then
		--荷叶,月饼【神话书说】
		AddItemStackables({"myth_lotusleaf",
		"myth_mooncake_ice",
		"myth_mooncake_lotus",
		"myth_mooncake_nuts",
		"myth_rhino_blueheart",
		"myth_rhino_yellowheart",
		"myth_rhino_redheart",
		"mk_huoyuan",
		"myth_redlantern"})
	end
	if GetModConfigData("blank_certificate") then
		--空白勋章【能力勋章】
		AddItemStackables({"blank_certificate","lavaeel","medal_withered_heart"})
	end
	if GetModConfigData("lg_choufish_inv") then
		--小丑鱼【海洋传说】
		AddItemStackables({"lg_choufish_inv"})
	end
	if GetModConfigData("aip_leaf_note") then
		--树叶笔记【额外物品包】
		AddItemStackables({"aip_leaf_note","aip_prosperity_seed"})
	end
	
	if GetModConfigData("foliageath") then
		--青枝绿叶【棱镜】
		AddItemStackables({"foliageath","raindonate"})
	end
	
	if GetModConfigData("miao_packbox") then
		--【超级打包盒】
		AddItemStackables({"miao_packbox"})
	end
	
	if GetModConfigData("heap_of_foods") then
		--HOF【更多料理】
		AddItemStackables({
		--松鼠
		"kyno_piko_orange", "kyno_piko",
		--罐头
		"kyno_beancan", "kyno_tomatocan", "kyno_tunacan", "kyno_meatcan", "kyno_beancan_open", "kyno_tomatocan_open","kyno_tunacan_open", "kyno_meatcan_open", "kyno_cokecan","kyno_sodacan", "kyno_energycan",
		--鸡
		"kyno_chicken2",
		--鱼
		"kyno_grouper", "kyno_salmonfish", "kyno_tropicalfish", "kyno_koi", "kyno_neonfish", "kyno_pierrotfish",
		--鸟
		"toucan","toucan_hamlet","kingfisher",})
	end
	
	if GetModConfigData("tropical") then
		--【热带冒险】
		AddItemStackables({
		--鸟
		"parrot", "parrot_blue", "parrot_pirate", "toucan","toucan_hamlet","seagull","quagmire_pigeon", "cormorant","kingfisher", "doydoy",
	    --蜘蛛类
		"spiderb", "spiderb1", "spiderb2","spider_tropical",
		--海鲜
		"crab", "jellyfish", "rainbowjellyfish",
		--fish
		"oceanfish_small_1_inv", "oceanfish_small_2_inv", "oceanfish_small_3_inv","oceanfish_small_4_inv","oceanfish_small_5_inv","oceanfish_small_6_inv","oceanfish_small_7_inv","oceanfish_small_8_inv","oceanfish_small_9_inv","oceanfish_small_10_inv","oceanfish_small_11_inv","oceanfish_small_12_inv","oceanfish_small_13_inv","oceanfish_small_14_inv","oceanfish_small_15_inv","oceanfish_small_16_inv","oceanfish_small_17_inv","oceanfish_small_18_inv","oceanfish_small_19_inv","oceanfish_small_20_inv","oceanfish_small_21_inv","oceanfish_small_61_inv","oceanfish_small_71_inv","oceanfish_small_81_inv","oceanfish_small_91_inv",
		"oceanfish_medium_1_inv","oceanfish_medium_2_inv","oceanfish_medium_3_inv","oceanfish_medium_4_inv","oceanfish_medium_5_inv","oceanfish_medium_6_inv","oceanfish_medium_7_inv","oceanfish_medium_8_inv",
		--其他生物
		"glowfly","coral_brain", "magic_seal",
		--船上用品
		"porto_lograft_old","porto_raft_old","porto_rowboat","porto_cargoboat","porto_armouredboat","porto_encrustedboat","porto_tar_extractor","porto_sea_yard","trawlnet","armor_lifejacket","porto_buoy",
		
		})
	end
	
	
	if GetModConfigData("reskin_tool") then
		--【娜娜自用】
		AddItemStackables({
		--原版工具
		"reskin_tool",
		"lantern",
		"trap_teeth",
		"trap_bramble",
		"boat_magnet_beacon",
		"boat_magnet_kit",
		"miniflare",
		"megaflare",--小猫项圈
		"redpouch",--红包
		--原版装饰
		"kitcoon_nametag",
		"decor_portraitframe",
		"decor_lamp",
		"decor_flowervase",
		"decor_centerpiece",
		"record",
		"phonograph",
		--原版鸭年华
		"carnivalgame_puckdrop_kit",
		"carnivalgame_wheelspin_kit",
		"carnivalgame_shooting_kit",
		"carnivalgame_herding_kit",
		"carnivalgame_feedchicks_kit",
		"carnivalgame_memory_kit",
		"carnival_prizebooth_kit",
		"carnival_plaza_kit",
		"carnivaldecor_figure_kit",
		"carnivaldecor_figure_kit_season2",
		--mod
		"shanhai_goumang",--山河
		"gentleness_cook_pot_item",--悠
		})
	end
end

--蓝图、草图、广告bug修复事件
modimport("main/lantu")