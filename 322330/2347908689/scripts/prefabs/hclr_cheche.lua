require "prefabutil"
require "modindex"
-- 食物车
local assets =
{
    Asset("ANIM", "anim/cook_pot.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_meatballs.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_meatballs.dyn"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_dragonpie.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_dragonpie.dyn"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_perogies.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_perogies.dyn"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_trailmix.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_trailmix.dyn"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("hit_cooking")
	inst.AnimState:PushAnimation("cooking_loop", true)
end

local maxFoodNum = GetModConfigData("foodNum",KnownModIndex:GetModActualName("怠惰科技"))
local cookingNoise = GetModConfigData("cheNoise",KnownModIndex:GetModActualName("怠惰科技"))

local range = GetModConfigData("range",KnownModIndex:GetModActualName("怠惰科技"))

local function creatfood(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
  local fridges = TheSim:FindEntities(x, 0, z, range * 4.5, {"fridge"})
	if #fridges > 0 then
    local given = 0
		for _,v in ipairs(fridges) do
			if  v.components.container and not v.components.equippable then
        for i = 1 , maxFoodNum do
          local food = SpawnPrefab(inst.food)
            if v.components.container:GiveItem(food) then
                given = given + 1
            else
                food:Remove()
            end
        end
        if given > 0 then
          return
        end
			end
		end
	end
end

local function newday(inst)
    if inst.on then
        inst:DoTaskInTime(math.random(),creatfood)
    end
end

local function TurnOff(inst, instant)
    if  inst.on then
        inst.on = false
        inst.AnimState:PlayAnimation("idle_empty",true)
        if  inst.SoundEmitter:PlayingSound("snd") then
            inst.SoundEmitter:KillSound("snd")
        end
    end
end

local function TurnOn(inst, instant)
    if not inst.on then
        inst.on = true
        inst.AnimState:PlayAnimation("cooking_loop",true)
        if not inst.SoundEmitter:PlayingSound("snd")
            and inst.cookingNoise == 0
        then
            inst.SoundEmitter:PlaySound("dontstarve/common/cookingpot_rattle", "snd")
        end
    end
end


local function CanInteract(inst)
    return true
end


local function MakeCookPot(name, food)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, .5)

        inst.Light:Enable(true)
        inst.Light:SetRadius(.8)
        inst.Light:SetFalloff(1)
        inst.Light:SetIntensity(.5)
        inst.Light:SetColour(235/255,62/255,12/255)

		inst.Transform:SetScale(1.2, 1.2, 1.2)

        inst:AddTag("structure")
        --烹饪锅声音
        inst.cookingNoise = cookingNoise


		inst.AnimState:SetBank("cook_pot")
		inst.AnimState:SetBuild(name)
		inst.MiniMapEntity:SetIcon("cookpot.png")

        MakeSnowCoveredPristine(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

		inst.food = food

        inst:AddComponent("inspectable")

        inst:AddComponent("lootdropper")
		inst.components.lootdropper:SetLoot({"twigs","twigs","twigs","charcoal","charcoal","charcoal","cutstone","cutstone",name.."_item"})


        -------------------------
        inst:AddComponent("machine")
        inst.on = false
        inst.components.machine.turnonfn = TurnOn
        inst.components.machine.turnofffn = TurnOff
        inst.components.machine.caninteractfn = CanInteract
        inst.components.machine.cooldowntime = 0.5
        -- 初始打开
        inst.components.machine.ison = true
        TurnOn(inst)
        -------------------------


        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        MakeSnowCovered(inst)

		inst:WatchWorldState( "startday", newday)
        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeCookPot("hclr_meatballs", "meatballs"),
	MakeCookPot("hclr_dragonpie", "dragonpie"),
	MakeCookPot("hclr_perogies", "perogies"),
	MakeCookPot("hclr_trailmix", "trailmix")
