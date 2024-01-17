require "prefabutil"
require "modindex"
-- 火堆
local assets =
{
    Asset("ANIM", "anim/firepit.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_xdhd.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_xdhd.dyn"),
}

local prefabs =
{
    "campfirefire",
    "collapse_small",
    "ash",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("ash").Transform:SetPosition(x, y, z)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(x, y, z)
    fx:SetMaterial("stone")
    inst:Remove()
end

local function onhit(inst, worker)
    inst.AnimState:PlayAnimation("hit")
    inst.AnimState:PushAnimation("idle")
end

local function onextinguish(inst)
    if inst.components.fueled ~= nil then
        inst.components.fueled:InitializeFuelLevel(0)
    end
end

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
    if not inst.on  then
        inst.components.machine:TurnOn()
    end
end

local function updatefuelrate(inst)
    inst.components.fueled.rate = TheWorld.state.israining and 1 + TUNING.FIREPIT_RAIN_RATE * TheWorld.state.precipitationrate or 1
end

local function onupdatefueled(inst)
    if inst.components.burnable ~= nil and inst.components.fueled ~= nil then
        updatefuelrate(inst)
        inst.components.burnable:SetFXLevel(inst.components.fueled:GetCurrentSection(), inst.components.fueled:GetSectionPercent())
    end
end

local fuels = {"log","twigs","cutgrass"}
local function addfuleforme(inst,chester,fuel)
    chester.components.container:ConsumeByName(fuel, 1)
    inst.components.fueled:TakeFuelItem(SpawnPrefab(fuel))
end

local range = GetModConfigData("range",KnownModIndex:GetModActualName("怠惰科技"))


local function lookforfuel(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local chd = TheSim:FindEntities(x, 0, z, range * 4.5,{"chest"})
    local has = false
	for _ , v in ipairs(chd) do
        if v and v.components.container then
            for __,f in ipairs(fuels) do
                if v.components.container:Has(f, 1) then
                    addfuleforme(inst,v,f)
                    has = true
                    break
                end
            end
            if(has) then
                break
            end
		end
	end
end
local function Oncheck(inst)
	if inst.components.fueled:GetPercent() < 0.5 then
		lookforfuel(inst)
	end
end

local function onfuelchange(newsection, oldsection, inst, doer)
    if newsection <= 0 then
        inst.components.burnable:Extinguish()
        if inst.on then
            inst.components.machine:TurnOff()
        end
    else
        if not inst.components.burnable:IsBurning() then
            updatefuelrate(inst)
            inst.components.burnable:Ignite(nil, nil, doer)
        end
        inst.components.burnable:SetFXLevel(newsection, inst.components.fueled:GetSectionPercent())
    end
end


local SECTION_STATUS =
{
    [0] = "OUT",
    [1] = "EMBERS",
    [2] = "LOW",
    [3] = "NORMAL",
    [4] = "HIGH",
}
local function getstatus(inst)
    return SECTION_STATUS[inst.components.fueled:GetCurrentSection()]
end

local function onbuilt(inst)
    inst.AnimState:PlayAnimation("place")
    inst.AnimState:PushAnimation("idle", false)
    inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
end

local function OnHaunt(inst, haunter)
    if math.random() <=  TUNING.HAUNT_CHANCE_RARE and
        inst.components.fueled ~= nil and
        not inst.components.fueled:IsEmpty() then
        inst.components.fueled:DoDelta(TUNING.MED_FUEL)
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function OnInit(inst)
    if inst.components.burnable ~= nil then
        inst.components.burnable:FixFX()
    end
end

--------------------------------------------------------------------------
--quagmire

local function OnPrefabOverrideDirty(inst)
    if inst.prefaboverride:value() ~= nil then
        inst:SetPrefabNameOverride(inst.prefaboverride:value().prefab)
        if not TheWorld.ismastersim and inst.replica.container:CanBeOpened() then
            inst.replica.container:WidgetSetup(inst.prefaboverride:value().prefab)
        end
    end
end

local function OnRadiusDirty(inst)
    inst:SetPhysicsRadiusOverride(inst.radius:value() > 0 and inst.radius:value() / 100 or nil)
end

local function OnSave(inst, data)
	data._has_debuffable = inst.components.debuffable ~= nil
end

local function OnPreLoad(inst, data)
	if data ~= nil and data._has_debuffable then
		inst:AddComponent("debuffable")
	end
end
local function oncanlight(self)
    if not self.burning and self.canlight then
        self.inst:AddTag("canlight")
        self.inst:RemoveTag("nolight")
    else
        self.inst:RemoveTag("canlight")
        self.inst:AddTag("nolight")
    end
end

local function TurnOff(inst, instant)
    if  inst.on then
        inst.on = false
        if inst.checkfuel ~= nil then
            inst.checkfuel:Cancel()
        end
    end
end

local function TurnOn(inst, instant)
    if not inst.on then
        inst.on = true
        inst.checkfuel = inst:DoPeriodicTask(1, Oncheck,1)
    end

end

local function onburning(self, burning)
    if burning then
    end
    oncanlight(self)
end

local function CanInteract(inst)
    return not inst.components.fueled:IsEmpty()
end


--==========================
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetIcon("firepit.png")
    inst.MiniMapEntity:SetPriority(1)

    inst.AnimState:SetBank("firepit")
    inst.AnimState:SetBuild("hclr_xdhd")
    inst.AnimState:PlayAnimation("idle", false)

    inst:AddTag("campfire")
    inst:AddTag("structure")
    inst:AddTag("wildfireprotected")
	inst:AddTag("hclr_xdhd")

    inst:AddTag("cooker")

	inst:AddTag("storytellingprop")

	inst:AddTag("prototyper")

    MakeObstaclePhysics(inst, .3)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -----------------------
    inst:AddComponent("burnable")
    inst.components.burnable:AddBurnFX("campfirefire", Vector3(0, 0, 0), "firefx", true)
    inst:ListenForEvent("onextinguish", onextinguish)
	addsetter(inst.components.burnable, "burning", onburning)
	inst:RemoveTag("fire")

    -------------------------
    inst:AddComponent("lootdropper")
	inst.components.lootdropper:SetLoot({"log","ash","rocks","rocks","rocks","rocks","rocks","rocks","hclr_xdhd_item"})
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)

    -------------------------
    inst:AddComponent("cooker")
    -------------------------
    inst:AddComponent("machine")
    inst.on = false
    inst.components.machine.turnonfn = TurnOn
    inst.components.machine.turnofffn = TurnOff
    inst.components.machine.caninteractfn = CanInteract
    inst.components.machine.cooldowntime = 0.5
    -------------------------

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = TUNING.FIREPIT_FUEL_MAX
    inst.components.fueled.accepting = true

    inst.components.fueled:SetSections(4)
    inst.components.fueled.bonusmult = TUNING.FIREPIT_BONUS_MULT
    inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:SetUpdateFn(onupdatefueled)
    inst.components.fueled:SetSectionCallback(onfuelchange)
    inst.components.fueled:InitializeFuelLevel(TUNING.FIREPIT_FUEL_START)

    inst:AddComponent("storytellingprop")

    inst:AddComponent("hauntable")
    inst.components.hauntable.cooldown = TUNING.HAUNT_COOLDOWN_HUGE
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -----------------------------
    inst:AddComponent("prototyper")
    inst.components.prototyper.onturnon = function(...) end
    inst.components.prototyper.onturnoff = function(...) end
    inst.components.prototyper.onactivate = function(...) end
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.HCLR_TECHTREE_TWO

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = getstatus

    inst:ListenForEvent("onbuilt", onbuilt)

    inst:DoTaskInTime(0, OnInit)
    -- 开启自动加燃料
    inst.components.machine.ison = true
    TurnOn(inst)

	inst.OnSave = OnSave
	inst.OnPreLoad = OnPreLoad

    inst.restart_firepit = function( inst )
        local fuel_percent = inst.components.fueled:GetPercent()
        inst.components.fueled:MakeEmpty()
        inst.components.fueled:SetPercent( fuel_percent )
    end
    return inst
end

return Prefab("hclr_xdhd", fn, assets, prefabs)
