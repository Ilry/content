PrefabFiles = {
}
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local LAN_ = GetModConfigData('Language')

TUNING.MICIRONNUM = GetModConfigData('Recipeiron')
TUNING.MICBRAINUM = GetModConfigData('Recipebra')
TUNING.MICSHARNUM = GetModConfigData('Recipeshard')
TUNING.MICCHEST = GetModConfigData('chestskin')
TUNING.MICDCHEST = GetModConfigData('dragonchestskin')
TUNING.MICICEBOX = GetModConfigData('upgradeicebox')
TUNING.MICSALTBOX = GetModConfigData('upgradesaltbox')
TUNING.MICMAGCHEST = GetModConfigData('upgrademagicinechest')
TUNING.MICBACKPACK = GetModConfigData('upgradebackpack')
TUNING.MICBEARPACK = GetModConfigData('upgradeicepack')
TUNING.MICPIGPACK = GetModConfigData('upgradepigpack')
TUNING.MICSEEDPACK = GetModConfigData('upgradeseedpack')
TUNING.MICCHEFPACK = GetModConfigData('upgradechefpack')
TUNING.MICCANDYPACK = GetModConfigData('upgradecandypack')
TUNING.MICKRAMPUSPACK = GetModConfigData('upgradekrampuspack')
TUNING.MICSHELLPACK = GetModConfigData('upgradeshellbox')
TUNING.MICPOLEBIN = GetModConfigData('upgradebearbox')
TUNING.MICGELBLOB = GetModConfigData('upgradegelblob')
TUNING.MICAMMOBAG = GetModConfigData('upgradeammobag')
TUNING.MICPICBOX = GetModConfigData('upgradepicbox')
TUNING.MICHOWLITZER = GetModConfigData('upgradehoundpipe')
TUNING.MICMODITEMON = GetModConfigData('useupgrademoditem')
TUNING.MICMERMSTRCT = GetModConfigData('upgrademermstruct')
local function tagcontainer(self)--这是标记能被维修的便签
	if not self.inst:HasTag("upgradecontainer") then
		self.inst:AddTag("upgradecontainer")
	end
end
if TUNING.MICMODITEMON then
	local ACTIONS = GLOBAL.ACTIONS
	modimport("scripts/main/action/upgradecontainer.lua")
	AddComponentPostInit("container", tagcontainer)
	--ACTIONS.STORE.priority = 1
	ACTIONS.UPGRADE.priority = 2
	
end

--modimport("scripts/main/action/mu_makecake.lua")

local function upgrade_onhammered(inst, worker)
	--sunk, drops more, but will lose the remainder
	inst.components.lootdropper:DropLoot()
	if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
	if inst.components.inventoryitemholder ~= nil then
		if inst.components.inventoryitemholder.item 
		and inst.components.inventoryitemholder.item.components.stackable
		then
			for k = 1,math.ceil(inst.components.inventoryitemholder.item.components.stackable.stacksize/inst.components.inventoryitemholder.item.components.stackable.originalmaxsize) do
				inst.components.inventoryitemholder:TakeItem()
			end
			--print(inst.components.inventoryitemholder.item.components.stackable.stacksize/inst.components.inventoryitemholder.item.components.stackable.originalmaxsize)
		else
			inst.components.inventoryitemholder:TakeItem()
		end
    end
	--inst.components.container:DropEverythingUpToMaxStacks(TUNING.COLLAPSED_CHEST_EXCESS_STACKS_THRESHOLD)
	local fx = SpawnPrefab("collapse_small")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("wood")
	inst:Remove()
	return
end
local function upgrade_onhit(inst, worker)
	if inst.components.container ~= nil then
		inst.components.container:DropEverything(nil, true)
		inst.components.container:Close()
	end
	if not inst:HasTag("burnt") then
		if inst.components.container_proxy ~= nil then
			inst.components.container_proxy:Close()
		end
	end
	inst.AnimState:PlayAnimation("hit")
	inst.AnimState:PushAnimation("closed", false)
end
local function getstatus(inst, viewer)
	return inst._chestupgrade_stacksize and "UPGRADED_STACKSIZE" or nil
end
local function onburnt(inst)
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
        inst.components.container:Close()
    end

    SpawnPrefab("ash").Transform:SetPosition(inst.Transform:GetWorldPosition())
	SpawnPrefab("alterguardianhatshard").Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()
end

local function SamePrefabAndSkin(inst, other)
    return inst.prefab == other.prefab and inst.skinname == other.skinname
end

local function OnUpgrade(inst, performer, upgraded_from_item)
    local numupgrades = inst.components.upgradeable.numupgrades
    if numupgrades == 1 then
        inst._chestupgrade_stacksize = true
		---一般容器
        if inst.components.container ~= nil then -- NOTES(JBK): The container component goes away in the burnt load but we still want to apply builds.
            inst.components.container:Close()
            inst.components.container:EnableInfiniteStackSize(true)
            inst.components.inspectable.getstatus = getstatus
        end
		--麦箱
		if inst.components.container_proxy ~= nil then
			inst.components.container_proxy:Close()
			local master = inst.components.container_proxy.master
			if master ~= nil 
			and master.components.container ~= nil
			then
				master.components.container:EnableInfiniteStackSize(true)
			end
		end
		--恶液箱
		if inst.components.inventoryitemholder~= nil then
		--收到物品移除上限
			if inst.components.inventoryitemholder.item~= nil 
			and inst.components.inventoryitemholder.item.components.stackable~= nil 
			then
				inst.components.inventoryitemholder.item.components.stackable:SetIgnoreMaxSize(true)
				inst:AddTag("inventoryitemholder_give")
			end
			local oldgiven = inst.components.inventoryitemholder.onitemgivenfn
				inst.components.inventoryitemholder.onitemgivenfn = function(inst, item, giver)
					local stacked = item == nil or not item:IsValid()
					if stacked then
						return
					end
					if item.components.stackable~= nil then
						item.components.stackable:SetIgnoreMaxSize(true)
						inst:AddTag("inventoryitemholder_give")
					end
					
					if oldgiven~= nil then
						oldgiven(inst, item, giver)
					end
				end
				--拿走物品恢复上限
			local oldtaken = inst.components.inventoryitemholder.onitemtakenfn
			inst.components.inventoryitemholder.onitemtakenfn = function(inst, item, taker)
				if item == nil or not item:IsValid() then
					return
				end
				if item.components.stackable~= nil then
					item.components.stackable:SetIgnoreMaxSize(false)
				end
				inst.AnimState:PlayAnimation("take")
				inst.AnimState:PushAnimation("idle")

				inst.SoundEmitter:PlaySound("rifts4/gelblob_storage/store")

				if item == nil or not item:IsValid() then
					return
				end

				if item.components.perishable ~= nil then
					item.components.perishable:StartPerishing()
				end

				item:RemoveTag("NOCLICK")
				if item.Follower~= nil then
					item.Follower:StopFollowing()
				end
			end
			--正好满时也要能接受
			--[[
			--local oldcangive = inst.components.inventoryitemholder.CanGive
			inst.components.inventoryitemholder.CanGive = function(self,item,giver)
				if item.components.inventoryitem == nil then
					return false
				end
				--local self = inst.components.inventoryitemholder
				if self.allowed_tags == nil or item:HasOneOfTags(self.allowed_tags)
				then
					if not self:IsHolding() then
						return true
					end

					return self.acceptstacks and
						self.item.components.stackable ~= nil and
						SamePrefabAndSkin(self.item, item)
				end
			end]]
			inst.components.inventoryitemholder.TakeItem = function(self,taker, wholestack)
				--local self = inst.components.inventoryitemholder
				if wholestack == nil then
					wholestack = true
				end
				if not self:CanTake(taker) then
					return false
				end
				if self.item~= nil 
				and self.item.components.stackable~= nil 
				and self.item.components.stackable:IsOverStacked()
				then
					local item = not wholestack and self.item.components.stackable:Get() or self.item.components.stackable:Get(self.item.components.stackable.originalmaxsize)
					item.components.inventoryitem:InheritWorldWetnessAtTarget(self.inst)
					item:RemoveTag("outofreach")
					local pos = self.inst:GetPosition()
					if taker ~= nil and taker:IsValid() and taker.components.inventory ~= nil then
						taker.components.inventory:GiveItem(item, nil, pos)
					else
						item.Transform:SetPosition(pos:Get())
						item.components.inventoryitem:OnDropped(true)
					end

					if self.onitemtakenfn ~= nil then
						-- Be aware that the item might be invalid at this point, in case it gets stacked on taken.
						self.onitemtakenfn(self.inst, item, taker)
					end
				else
					local item = not wholestack and self.item.components.stackable ~= nil and self.item.components.stackable:Get() or self.item

					if item == self.item then
						self.inst:RemoveChild(self.item)

						self.item:RemoveTag("outofreach")

						self.inst:RemoveEventCallback("onremove", self._onitemremoved, self.item)
					end

					item.components.inventoryitem:InheritWorldWetnessAtTarget(self.inst)

					local pos = self.inst:GetPosition()

					if taker ~= nil and taker:IsValid() and taker.components.inventory ~= nil then
						taker.components.inventory:GiveItem(item, nil, pos)
					else
						item.Transform:SetPosition(pos:Get())
						item.components.inventoryitem:OnDropped(true)
					end

					if self.onitemtakenfn ~= nil then
						-- Be aware that the item might be invalid at this point, in case it gets stacked on taken.
						self.onitemtakenfn(self.inst, item, taker, item == self.item)
					end

					if item == self.item then
						self.item = nil
					end
				end
				return true
			end
		end
        if upgraded_from_item then
            -- Spawn FX from an item upgrade not from loads.
            local x, y, z = inst.Transform:GetWorldPosition()
            local fx = SpawnPrefab("chestupgrade_stacksize_taller_fx")
            fx.Transform:SetPosition(x, y, z)
            -- Delay chest visual changes to match fx.
        end
    end
    inst.components.upgradeable.upgradetype = nil

    if inst.components.lootdropper ~= nil then
        inst.components.lootdropper:SetLoot({ "alterguardianhatshard" })
    end
	if inst.components.workable~= nil then
		inst.components.workable:SetOnWorkCallback(upgrade_onhit)
		inst.components.workable:SetOnFinishCallback(upgrade_onhammered)
	end
	if inst.components.burnable~= nil then
		inst.components.burnable:SetOnBurntFn(onburnt)
	end
	inst:ListenForEvent("restoredfromcollapsed", OnRestoredFromCollapsed)
end
local function OnLoad(inst, data, newents)
    if inst.components.upgradeable ~= nil and inst.components.upgradeable.numupgrades > 0 then
        OnUpgrade(inst)
    end
	if data ~= nil and data.burnt and inst.components.burnable ~= nil then
		inst.components.burnable.onburnt(inst)
	end
end
local function addupgrade(inst)
	local upgradeable = inst:AddComponent("upgradeable")
	upgradeable.upgradetype = UPGRADETYPES.CHEST
	upgradeable:SetOnUpgradeFn(OnUpgrade)
	-- This chest cannot burn.
	inst.OnLoad = OnLoad
end
if TUNING.MICCHEST == false then
	AddPrefabPostInit("treasurechest",addupgrade)
end
if TUNING.MICDCHEST == false then
	AddPrefabPostInit("dragonflychest",addupgrade)
end
if TUNING.MICICEBOX then
	AddPrefabPostInit("icebox",addupgrade)
end
if TUNING.MICSALTBOX then
	AddPrefabPostInit("saltbox",addupgrade)
end
if TUNING.MICMAGCHEST then
	AddPrefabPostInit("magician_chest",function(inst)
		addupgrade(inst)
		inst:DoTaskInTime(0,function()
			if inst.components.upgradeable ~= nil and inst.components.upgradeable.numupgrades > 0 then
				OnUpgrade(inst)
			end
		end)
	end)
end

if TUNING.MICBACKPACK then
	AddPrefabPostInit("backpack",addupgrade)
end
if TUNING.MICBEARPACK then
	AddPrefabPostInit("icepack",addupgrade)
end
if TUNING.MICPIGPACK then
	AddPrefabPostInit("piggyback",addupgrade)
end
if TUNING.MICSEEDPACK then
	AddPrefabPostInit("seedpouch",addupgrade)
end
if TUNING.MICCHEFPACK then
	AddPrefabPostInit("spicepack",addupgrade)
end
if TUNING.MICCANDYPACK then
	AddPrefabPostInit("candybag",addupgrade)
end
if TUNING.MICKRAMPUSPACK then
	AddPrefabPostInit("krampus_sack",addupgrade)
end
if TUNING.MICSHELLPACK then
	AddPrefabPostInit("tacklecontainer",addupgrade)
	AddPrefabPostInit("supertacklecontainer",addupgrade)
end
if TUNING.MICPOLEBIN then
	AddPrefabPostInit("beargerfur_sack",addupgrade)
end

if TUNING.MICHOWLITZER then
	AddPrefabPostInit("houndstooth_blowpipe",addupgrade)
end

if TUNING.MICMERMSTRCT then
	AddPrefabPostInit("merm_armory",addupgrade)
	AddPrefabPostInit("merm_armory_upgraded",addupgrade)
	AddPrefabPostInit("merm_toolshed",addupgrade)
	AddPrefabPostInit("merm_toolshed_upgraded",addupgrade)
end
if TUNING.MICGELBLOB then
	AddPrefabPostInit("gelblob_storage",addupgrade)
end
if TUNING.MICAMMOBAG then
	AddPrefabPostInit("slingshotammo_container",addupgrade)
end
if TUNING.MICPICBOX then
	AddPrefabPostInit("elixir_container",addupgrade)
end
AddRecipe2("chestupgrade_stacksize", {
				TUNING.MICBRAINUM~=0 and Ingredient("wagpunk_bits",TUNING.MICIRONNUM) or nil,
				TUNING.MICBRAINUM~=0 and Ingredient("purebrilliance",TUNING.MICBRAINUM) or nil,
				TUNING.MICSHARNUM~=0 and Ingredient("alterguardianhatshard",TUNING.MICSHARNUM) or nil},
TECH.LOST,{"CONTAINERS"})