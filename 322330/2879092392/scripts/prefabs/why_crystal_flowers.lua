local assets =
{
    Asset("IMAGE", "images/inventoryimages/why_crystal_flowers.tex"),
    Asset("ATLAS", "images/inventoryimages/why_crystal_flowers.xml" ),
    Asset("ANIM", "anim/why_crystal_flowers.zip"),
}

local prefabs = 
{
    "ancientdreams_gemshard",
    "why_crystal_flowers",
}

local names = {"cryflo1","cryflo2","cryflo3","cryflo4","cryflo5","cryflo6","cryflo7","cryflo8","cryflo9","cryflo10","cryflo11","cryflo12","cryflo13","cryflo14","cryflo15","cryflo16","cryflo17","cryflo18","cryflo19","cryflo20","cryflo21","cryflo22","cryflo64"}
local FAILSAFE_NAME = "cryflo1"
local FAILSAFE_CHANCE = 0.01

local function setcrystalflowertype(inst, name)
if inst.animname == nil or (name ~= nil and inst.animname ~= name) then
inst.animname = name or (math.random() < FAILSAFE_CHANCE and FAILSAFE_NAME or names[math.random(#names)])
inst.AnimState:PlayAnimation(inst.animname)
  end
 end


local function onsave(inst, data)
    data.anim = inst.animname
    data.planted = inst.planted
end

local function onload(inst, data)
    setcrystalflowertype(inst, data ~= nil and data.anim or nil)
    inst.planted = data ~= nil and data.planted or nil
end

local function onpickedfn(inst, picker)
    local pos = inst:GetPosition()
	  if picker ~= nil then
        if picker.components.sanity ~= nil and not picker:HasTag("plantkin") then
            picker.components.sanity:DoDelta(TUNING.SANITY_TINY)
        end
   end

    TheWorld:PushEvent("plantkilled", { doer = picker, pos = pos }) --this event is pushed in other places too
end

--local function onhammered(inst) -- what should loot when it is hammered
  --  local fx = SpawnPrefab("ancientdreams_gemshard") 
    --fx.Transform:SetPosition(inst.Transform:GetWorldPosition()) 
    --inst.components.lootdropper:DropLoot()
    --inst:Remove()
--end

--local function onbuilt(inst) -- what anim should be played and the sound effect when built

 --   inst.SoundEmitter:PlaySound("dontstarve/common/together/succulent_craft")
--end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
   -- inst.entity:AddSoundEmitter()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    -- basic anim
    inst.AnimState:SetBank("why_crystal_flowers")
    inst.AnimState:SetBuild("why_crystal_flowers")
    inst.AnimState:SetRayTestOnBB(true)

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")

    inst:AddComponent("pickable")
    inst.components.pickable.picksound = "dontstarve/wilson/pickup_plants"
    inst.components.pickable:SetUp("ancientdreams_gemshard", 10)
    inst.components.pickable.onpickedfn = onpickedfn
	inst.components.pickable.remove_when_picked = true
    inst.components.pickable.quickpick = true

   -- inst:AddComponent("workable")
   -- inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
   -- inst.components.workable:SetWorkLeft(1) -- the number is how many times it can be hammered before destroyed
   -- inst.components.workable:SetOnFinishCallback(onhammered)

   -- inst:AddComponent("lootdropper")


 if not POPULATING then
        setcrystalflowertype(inst)
    end
    --------SaveLoad
    inst.OnSave = onsave
    inst.OnLoad = onload

    return inst
end

function plantedcrystalflowerfn()
    local inst = commonfn(true)

    inst:SetPrefabName("why_crystal_flowers")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.planted = true

    return inst
end

return Prefab("why_crystal_flowers", fn, assets, prefabs),
    MakePlacer("why_crystal_flowers_placer", "why_crystal_flowers", "why_crystal_flowers", "placer")
