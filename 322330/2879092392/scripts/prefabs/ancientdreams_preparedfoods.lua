local assets = {
    Asset("ANIM", "anim/ancientdreams_gegg.zip"),
    Asset("ANIM", "anim/ancientdreams_candy.zip"),
    Asset("ANIM", "anim/ancientdreams_cube.zip"),
    Asset("ANIM", "anim/ancientdreams_geocake.zip"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_preparedfoods.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_preparedfoods.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_preparedfoods.xml",256), }

local function OnDrop_gegg(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_gegg_idle")
end
local function OnDrop_candy(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_candy_idle")
end
local function OnDrop_cube(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_cube_idle")
end
local function OnDrop_geocake(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_geocake_idle")
end

local function getGeggHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 50
        else
            return -15 
        end
    end
end

local function getGeggSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 15
        else
            return -5
        end
    end
end

local function fn_gegg()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_gegg")
    inst.AnimState:SetBuild("ancientdreams_gegg")
    inst.AnimState:PlayAnimation("ancientdreams_gegg_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    --inst:AddTag("catfood")
    --inst:AddTag("honeyed")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_gegg"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_preparedfoods.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_gegg)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    --inst.components.edible.healthvalue = -15
    inst.components.edible.gethealthfn = getGeggHealth
    inst.components.edible.hungervalue = 62.5
    --inst.components.edible.sanityvalue = -5
    inst.components.edible.getsanityfn = getGeggSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(7200)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_gegg(inst)
    return inst
end

local function getCandyHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 20
        else
            return -8
        end
    end
end

local function getCandySanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 30
        else
            return -5
        end
    end
end

--local function SetEatCandyfn(inst, eater)
--    if eater~= nil then
--        if eater.prefab == "wonderwhy" then
--            eater.components.sanity:DoDelta(15)
--        end
--    end
--end

local function fn_candy()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_candy")
    inst.AnimState:SetBuild("ancientdreams_candy")
    inst.AnimState:PlayAnimation("ancientdreams_candy_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    --inst:AddTag("catfood")
    inst:AddTag("honeyed")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_candy"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_preparedfoods.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_candy)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    --inst.components.edible.healthvalue = -8
    inst.components.edible.gethealthfn = getCandyHealth
    inst.components.edible.hungervalue = 25
    inst.components.edible.getsanityfn = getCandySanity
    --inst.components.edible.sanityvalue = -5
    --inst.components.edible:SetOnEatenFn(SetEatCandyfn)
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(7200)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_candy(inst)
    return inst
end

local function getGeocakeHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 30
        else
            return -20 
        end
    end
end

local function getGeocakeSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 80
        else
            return -30
        end
    end
end

local function OnEaten(inst, eater)
  if eater.prefab == "wonderwhy" then
      eater.components.inventory:GiveItem(SpawnPrefab("thulecite"))
        eater.components.inventory:GiveItem(SpawnPrefab("saltrock"))
        eater.components.talker:Say("I feel lighter all of a sudden.") 
        end
end

local function fn_geocake()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_geocake")
    inst.AnimState:SetBuild("ancientdreams_geocake")
    inst.AnimState:PlayAnimation("ancientdreams_geocake_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_geocake"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_preparedfoods.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_geocake)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getGeocakeHealth
    inst.components.edible.hungervalue = 50
    inst.components.edible.getsanityfn = getGeocakeSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"
    inst.components.edible:SetOnEatenFn(OnEaten)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_geocake(inst)
    
    return inst
end

local function getCubeHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 60
        else
            return -15
        end
    end
end

local function getCubeSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 15
        else
            return -5
        end
    end
end



local function fn_cube()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_cube")
    inst.AnimState:SetBuild("ancientdreams_cube")
    inst.AnimState:PlayAnimation("ancientdreams_cube_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    --inst:AddTag("catfood")
    --inst:AddTag("honeyed")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_cube"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_preparedfoods.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_cube)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.gethealthfn = getCubeHealth
    inst.components.edible.hungervalue = 42
    inst.components.edible.getsanityfn = getCubeSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
	inst:AddTag("fitsforgempack")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_cube(inst)
    return inst
end

return Prefab("ancientdreams_gegg", fn_gegg, assets),
Prefab("ancientdreams_candy", fn_candy, assets),
Prefab("ancientdreams_cube", fn_cube, assets),
Prefab("ancientdreams_geocake", fn_geocake, assets)