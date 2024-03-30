GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

local animalStack = GetModConfigData("ANIMALSTACK")
local itemsStack  = GetModConfigData("ITEMSSTACK")
local IsServer = GLOBAL.TheNet:GetIsServer()

GLOBAL.TUNING.STACK_SIZE_LARGEITEM = GetModConfigData("stack_size")
GLOBAL.TUNING.STACK_SIZE_MEDITEM = GetModConfigData("stack_size")
GLOBAL.TUNING.STACK_SIZE_SMALLITEM = GetModConfigData("stack_size")
GLOBAL.TUNING.WORTOX_MAX_SOULS = GetModConfigData("soul_stack")
GLOBAL.TUNING.STACK_SIZE_TINYITEM = GetModConfigData("walter_shoter_stack")

-- self._stacksize = net_smallbyte(inst.GUID, "stackable._stacksize", "stacksizedirty")
-- self._stacksizeupper = net_smallbyte(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
-- self._ignoremaxsize = net_bool(inst.GUID, "stackable._ignoremaxsize")
-- self._maxsize = net_tinybyte(inst.GUID, "stackable._maxsize")

-- if not TheWorld.ismastersim then
--     --self._previewstacksize = nil
--     --self._previewtimeouttask = nil
--     inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
-- end
local function OnStackSizeDirty(inst)
	local self = inst.replica.stackable
	if not self then
		return --stackable removed?
	end

	self:ClearPreviewStackSize()

	--instead of inventoryitem_classified listening for "stacksizedirty" as well
	--forward a new event to guarantee order
	inst:PushEvent("inventoryitem_stacksizedirty")
end

local r_s = GLOBAL.require("components/stackable_replica")
r_s._ctor = function(self, inst)
	self.inst = inst
	self._stacksize = GLOBAL.net_smallbyte(inst.GUID, "stackable._stacksize", "stacksizedirty")
    self._stacksizeupper = GLOBAL.net_smallbyte(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
    self._ignoremaxsize = GLOBAL.net_bool(inst.GUID, "stackable._ignoremaxsize")
	self._maxsize = GLOBAL.net_tinybyte(inst.GUID, "stackable._maxsize")

    if not TheWorld.ismastersim then
        --self._previewstacksize = nil
        --self._previewtimeouttask = nil
        inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
    end
end

local function newStackable(self)
    local _Put = self.Put
    self.Put = function(self, item, source_pos)
        if item.prefab == self.inst.prefab then
            local newtotal = item.components.stackable:StackSize() + self.inst.components.stackable:StackSize()
        end
        return _Put(self, item, source_pos)
    end
end

local function OnPickup(inst)
    if inst.sg then
        inst.sg:GoToState("idle")
    end
end

local function OnDropped(inst)
    if inst.buzzing and not (inst:IsAsleep() or inst.SoundEmitter:PlayingSound("buzz")) then
        inst.SoundEmitter:PlaySound(inst.sounds.buzz, "buzz")
    end
    if inst.brain ~= nil then
        inst.brain:Start()
    end
    if inst.components.stackable ~= nil and inst.components.stackable:IsStack() then
        local x, y, z = inst.Transform:GetWorldPosition()
        while inst.components.stackable:IsStack() do
            local item = inst.components.stackable:Get()
            if item ~= nil then
                if item.components.inventoryitem ~= nil then
                    item.components.inventoryitem:OnDropped()
                end
                item.Physics:Teleport(x, y, z)
            end
        end
    end
end
local function addAnimal()
    AddPrefabPostInitAny(function(inst)

        local specialPreb = {
            "tallbirdegg",          --高鸟蛋
            "tallbirdegg_cracked",  --孵化中的高鸟蛋
            "lavae_egg",            --岩浆虫卵
            "lavae_egg_cracked",    --岩浆虫卵
        }

        if inst and (inst:HasTag("smallcreature") or inst:HasTag("bird")
            or table.contains(specialPreb, inst.prefab)) then
            if inst.components.sanity ~= nil then
                return
            end

            if inst.components.inventoryitem == nil then
                return
            end

            if inst.components.stackable == nil then
                inst:AddComponent("stackable")
                -- MakeFeedableSmallLivestock(inst, perish_time, OnPutInInventory, OnDropped)
                inst:ListenForEvent("onpickup", OnPickup)
                inst:ListenForEvent("ondropped", OnDropped)
            end
        end
    end)
end

local function addItems(name)
	AddPrefabPostInit(name,function(inst)
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

if IsServer then
	if animalStack then
        addAnimal()
	-- 	addAnimal("spider")--蜘蛛
	-- 	addAnimal("spider_hider")--洞穴蜘蛛
	-- 	addAnimal("spider_spitter")--喷射蜘蛛
	-- 	addAnimal("spider_warrior")--蜘蛛战士
	-- 	addAnimal("spider_moon")--破碎蜘蛛
	-- 	addAnimal("spider_healer")--护士蜘蛛
	-- 	addAnimal("spider_dropper")--穴居悬蛛
	-- 	addAnimal("spider_water")--水蜘蛛

	-- 	addAnimal("rabbit")--兔子
	-- 	addAnimal("mole")--鼹鼠
	-- 	addAnimal("crow")--乌鸦
	-- 	addAnimal("canary")--金丝雀
    --     addAnimal("canary_poisoned")--中毒的金丝雀
    --     addAnimal("bird_mutant_spitter")--奇形鸟
    --     addAnimal("bird_mutant")--月盲乌鸦
	-- 	addAnimal("robin")--红雀
	-- 	addAnimal("robin_winter")--雪雀
	-- 	addAnimal("carrat")--胡萝卜鼠
	-- 	addAnimal("puffin")--海雀
		
	-- 	addAnimal("pondfish")--淡水鱼
	-- 	addAnimal("pondeel")--鳗鱼
	-- 	addAnimal("oceanfish_medium_1_inv")--泥鱼
	-- 	addAnimal("oceanfish_medium_2_inv")--深海鲈鱼
	-- 	addAnimal("oceanfish_medium_3_inv")--华丽狮子鱼
	-- 	addAnimal("oceanfish_medium_4_inv")--黑鲇鱼
	-- 	addAnimal("oceanfish_medium_5_inv")--玉米鱼
	-- 	addAnimal("oceanfish_medium_6_inv")--花锦鱼
	-- 	addAnimal("oceanfish_medium_7_inv")--金锦鱼
	-- 	addAnimal("oceanfish_medium_8_inv")--冰鲷鱼
	-- 	addAnimal("oceanfish_medium_9_inv")--甜味儿鱼
	-- 	addAnimal("oceanfish_small_1_inv")--小孔雀鱼
	-- 	addAnimal("oceanfish_small_2_inv")--针鼻喷墨鱼
	-- 	addAnimal("oceanfish_small_3_inv")--小饵鱼
	-- 	addAnimal("oceanfish_small_4_inv")--三文鱼苗
	-- 	addAnimal("oceanfish_small_5_inv")--爆米花鱼
	-- 	addAnimal("oceanfish_small_6_inv")--落叶比目鱼
	-- 	addAnimal("oceanfish_small_7_inv")--花朵金枪鱼
	-- 	addAnimal("oceanfish_small_8_inv")--炽热太阳鱼
	-- 	addAnimal("oceanfish_small_9_inv")--口水鱼
	-- 	addAnimal("wobster_sheller_land")--龙虾
	-- 	addAnimal("wobster_moonglass_land")--月光龙虾

    --     --特殊处理
	-- 	addAnimal("tallbirdegg")--高鸟蛋
    --     addAnimal("tallbirdegg_cracked")--孵化中的高鸟蛋
    --     addAnimal("lavae_egg")--岩浆虫卵
    --     addAnimal("lavae_egg_cracked")--岩浆虫卵
	end

    if itemsStack then
		addItems("minotaurhorn")--犀牛角
        addItems("deerclops_eyeball")--鹿角怪眼球
        addItems("shadowheart")--暗影心房
        addItems("eyeturret_item")--眼球塔
        addItems("glommerwings")--格罗姆翅膀
    end
	AddComponentPostInit("stackable", newStackable)
end