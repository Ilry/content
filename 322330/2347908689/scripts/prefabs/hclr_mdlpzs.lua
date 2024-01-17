require "prefabutil"
-- 曼德拉泡脚水
local assets =
{
    Asset("ANIM", "anim/hclr_mdlpzs.zip"),

}

local prefabs =
{
    "collapse_small",
}


local function Oncheckbuff(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 12,{ "player" }, {"INLIMBO","playerghost"})
	for i, v in ipairs(ents) do
		if v  and v.components.health  and v.components.combat  then
			if inst.addbuff[v] == nil then
				if not v.components.health:IsDead() then
					inst.addbuff[v] = v
                    v.components.hunger.burnratemodifiers:SetModifier("hcdedym", 0)
				end
			end
		end
	end
    for k, v in pairs(inst.addbuff) do
		if  v  and v:IsValid() and v.components.health  and v.components.combat  then
			if v.components.health and v.components.health:IsDead() or  v:GetDistanceSqToInst(inst) >  144  then
                v.components.hunger.burnratemodifiers:RemoveModifier("hcdedym")
			else
                v.components.health:DoDelta(1, true)
                if v.components.sanity ~= nil then
                    v.components.sanity:DoDelta(1,true)
                end
                if v.components.hunger.current <= 0 then
                    v.components.hunger:DoDelta(1,true)
                end
                if v.components.temperature ~= nil then
                    v.components.temperature:SetTemperature(34)
                end
				if not v.components.hunger.burnratemodifiers._modifiers["hcdedym"] then
					v.components.hunger.burnratemodifiers:SetModifier("hcdedym", 0)
				end
			end
		end
    end
end

local function onremove(inst)
    for k, v in pairs(inst.addbuff) do
		if  v  and v.components.hunger  then
			inst.addbuff[v] = nil
			v.components.hunger.burnratemodifiers:RemoveModifier("hcdedym")
		end
    end
end

local function onhammered(inst, worker)
    --onremove(inst)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("wood")
    inst:Remove()
end

local function onhit(inst, worker)
    --inst.AnimState:PlayAnimation("hit")
end


local function MakeCookPot(name,assets, prefabs)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

        MakeObstaclePhysics(inst, 1.6)

        inst.Transform:SetScale(1.8, 1.8, 1.8)

        inst:AddTag("structure")

    		inst.AnimState:SetBank(name)
    		inst.AnimState:SetBuild(name)
    		inst.AnimState:PlayAnimation("idle")
        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

        inst.Light:Enable(true)
        inst.Light:SetRadius(1.6)
        inst.Light:SetFalloff(.9)
        inst.Light:SetIntensity(0.5)
        inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst.addbuff = {}
        inst.buffs = inst:DoPeriodicTask(1, Oncheckbuff,1)

        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
        inst.components.lootdropper:SetLoot({"rope","rope","silk","silk","silk","twigs","twigs","hclr_hcds_item","hclr_pzgz"})

        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(4)
        inst.components.workable:SetOnFinishCallback(onhammered)
        inst.components.workable:SetOnWorkCallback(onhit)

        --inst:ListenForEvent("onremove", onremove)
        return inst
    end

    return Prefab(name, fn, assets, prefabs)
end

return MakeCookPot("hclr_mdlpzs", assets, prefabs)
