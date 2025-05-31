function LunarRiftMutationsManager:GetDebugStringjhxj()
    local defeated = {}

    for _, i in ipairs(self.defeated_mutations) do
        table.insert(defeated, MUTATIONS_NAMES[i])
    end

    return string.format(
        "击杀进度: %d/%d [ %s ]  ||  首杀任务: %s",
        self:GetNumDefeatedMutations(),
        self.num_mutations,
        table.concat(defeated, ", "),
        self.task_completed and "完成" or "未完成"
    )
end

AddComponentPostInit("lunarriftmutationsmanager", LunarRiftMutationsManager:GetDebugStringjhxj)


古代树测试
local function testapp(inst)
    inst:RemoveComponent("workable")
	-- inst:RemoveTag("no_force_grow")
	
	-- inst:AddComponent("simplemagicgrower")
    -- inst.components.simplemagicgrower:SetLastStage(1)
end;
AddPrefabPostInit("ancienttree_gem", testapp)



AddPrefabPostInit("ancienttree_gem", function(inst)inst:RemoveComponent("workable")inst:RemoveTag("no_force_grow"))


local function testccc(inst)
    inst.components.simplemagicgrower:SetLastStage("normal")
end;
AddPrefabPostInit("evergreen", testccc)





全员可用表
if Everyonepocketwatch then
    AddPlayerPostInit(
        function(inst)
            inst:AddTag("pocketwatchcaster")
        end
    )
end








移除耐久函数
local function removefiniteusesfn(inst)
	if GLOBAL.TheWorld.ismastersim then
		inst:RemoveComponent("finiteuses")
	end
end

舔盐器调用移除耐久函数
AddPrefabPostInit("saltlick", removefiniteusesfn)

--奥丁矛可修复
local function OnBroken(inst)
	if inst.components.equippable ~= nil then
		DisableComponents(inst)
		--inst.AnimState:PlayAnimation("broken")
		SetIsBroken(inst, true)
		inst:AddTag("broken")
		inst.components.inspectable.nameoverride = "BROKEN_FORGEDITEM"
	end
end

local function OnRepaired(inst)
	if inst.components.equippable == nil then
		SetupComponents(inst)
		inst.blade1.AnimState:SetFrame(0)
		inst.blade2.AnimState:SetFrame(0)
		--inst.AnimState:PlayAnimation("idle", true)
		SetIsBroken(inst, false)
		inst:RemoveTag("broken")
		inst.components.inspectable.nameoverride = nil
	end
end

local function repairjhxj(inst)
	MakeForgeRepairable(inst, FORGEMATERIALS.LUNARPLANT, OnBroken, OnRepaired)
end
AddPrefabPostInit("spear_wathgrithr_lightning_charged", repairjhxj)


--创建“修补类型为噩梦燃料”的函数
local function AddNightmareFuel(inst)
	local owner = inst.components.inventoryitem.owner

    if owner ~= nil and owner.SoundEmitter ~= nil then
       owner.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
    else
        inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
    end
end	
local function canequipagain(inst)
    if inst:HasTag("broken") and
    inst.components.equippable.restrictedtag ~= nil and
    inst.components.inspectable.nameoverride ~= nil then

    inst:RemoveTag("broken")
    inst.components.equippable.restrictedtag = nil
    inst.components.inspectable.nameoverride = nil
    end
end
local function ontakefuel_skeletonhat(inst, fuelvalue)
    --SERVER_PlayFuelSound(inst)
    AddNightmareFuel(inst)
    canequipagain(inst)

    if fuelvalue >= 360 then
        inst.components.armor:Repair(TUNING.ARMOR_SKELETONHAT * 0.5)
    else
        inst.components.armor:Repair(TUNING.ARMOR_SKELETONHAT * 0.25)
    end
end

local function addtoskeletonhat(inst)
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
    inst.components.fueled.accepting = true
    inst.components.fueled:InitializeFuelLevel(4 * TUNING.LARGE_FUEL)
    inst.components.fueled.ontakefuelfn = ontakefuel_skeletonhat
    inst.components.armor.keeponfinished = true
end
--骨盔调用
AddPrefabPostInit("skeletonhat", addtoskeletonhat)



--空间升级
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
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
local function OnUpgrade(inst, performer, upgraded_from_item)
    local numupgrades = inst.components.upgradeable.numupgrades
    if numupgrades == 1 then
        inst._chestupgrade_stacksize = true
        if inst.components.container ~= nil then -- NOTES(JBK): The container component goes away in the burnt load but we still want to apply builds.
            inst.components.container:Close()
            inst.components.container:EnableInfiniteStackSize(true)
            inst.components.inspectable.getstatus = getstatus
        end
		if inst.components.container_proxy ~= nil then
			inst.components.container_proxy:Close()
			local master = inst.components.container_proxy.master
			if master ~= nil 
			and master.components.container ~= nil
			then
				master.components.container:EnableInfiniteStackSize(true)
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
AddPrefabPostInit("beargerfur_sack",addupgrade)