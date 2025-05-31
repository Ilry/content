local assets = {
    Asset("ANIM", "anim/ancientdreams_gegg.zip"),
    Asset("ANIM", "anim/ancientdreams_candy.zip"),
    Asset("ANIM", "anim/ancientdreams_cube.zip"),
    Asset("ANIM", "anim/ancientdreams_geocake.zip"),
    Asset("ANIM", "anim/ancientdreams_hyubsip.zip"),
    Asset("ANIM", "anim/ancientdreams_kozisip.zip"),
    Asset("ANIM", "anim/ancientdreams_tart.zip"),
    Asset("ANIM", "anim/ancientdreams_evilbred.zip"),
    Asset("ANIM", "anim/ancientdreams_gell.zip"),
    Asset("ANIM", "anim/ancientdreams_quaso.zip"),
    Asset("ANIM", "anim/ancientdreams_fhish.zip"),
    Asset("ANIM", "anim/ancientdreams_lombter.zip"),
    Asset("ANIM", "anim/ancientdreams_pizza.zip"),
    Asset("ANIM", "anim/ancientdreams_ser.zip"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_preparedfoods.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_preparedfoods.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_hyubsip.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_hyubsip.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_kozisip.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_kozisip.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_tart.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_tart.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_evilbred.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_evilbred.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_gell.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_gell.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_quaso.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_quaso.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_fhish.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_fhish.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_lombter.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_lombter.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_pizza.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_pizza.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_ser.xml"),
    Asset("IMAGE", "images/inventoryimages/ancientdreams_ser.tex"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_preparedfoods.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_hyubsip.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_kozisip.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_tart.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_evilbred.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_gell.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_quaso.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_fhish.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_lombter.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_pizza.xml",256),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_ser.xml",256),}

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
local function OnDrop_hyubsip(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_hyubsip_idle")
end
local function OnDrop_kozisip(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_kozisip_idle")
end
local function OnDrop_tart(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_tart_idle")
end
local function OnDrop_evilbred(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_evilbred_idle")
end
local function OnDrop_gell(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_gell_idle")
end
local function OnDrop_quaso(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_quaso_idle")
end
local function OnDrop_fhish(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_fhish_idle")
end
local function OnDrop_lombter(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_lombter_idle")
end
local function OnDrop_pizza(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_pizza_idle")
end
local function OnDrop_ser(inst, owner)
    inst.AnimState:PlayAnimation("ancientdreams_ser_idle")
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
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
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
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
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
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
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
            return 7.5
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

local function getHyuSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 100
        else
            return 100
        end
    end
end

local function fn_hyubsip()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_hyubsip")
    inst.AnimState:SetBuild("ancientdreams_hyubsip")
    inst.AnimState:PlayAnimation("ancientdreams_hyubsip_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_hyubsip"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_hyubsip.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_hyubsip)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.healthvalue = 20
    inst.components.edible.hungervalue = 13
    inst.components.edible.getsanityfn = getHyuSanity
    inst.components.edible.temperaturedelta = -40
    inst.components.edible.temperatureduration = 1200
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_hyubsip(inst)
    return inst
end

local function getkoziSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 80
        else
            return 80
        end
    end
end

local function fn_kozisip()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_kozisip")
    inst.AnimState:SetBuild("ancientdreams_kozisip")
    inst.AnimState:PlayAnimation("ancientdreams_kozisip_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_kozisip"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_kozisip.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_kozisip)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.healthvalue = 21
    inst.components.edible.hungervalue = 16
    inst.components.edible.getsanityfn = getkoziSanity
    inst.components.edible.temperaturedelta = -20
    inst.components.edible.temperatureduration = 1200
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_kozisip(inst)
    return inst
end

local function gettartSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 10
        else
            return -10
        end
    end
end

local function OnEatenTart(inst, eater)
    eater.components.talker:Say("Yummers!")
      if eater.wormlight ~= nil then
          if eater.wormlight.prefab == "wormlight_light_greater" then
              eater.wormlight.components.spell.lifetime = 0
              eater.wormlight.components.spell:ResumeSpell()
              return
          else
              eater.wormlight.components.spell:OnFinish()
          end
      end

      local light = SpawnPrefab("wormlight_light_greater")
      light.components.spell:SetTarget(eater)
      if light:IsValid() then
          if light.components.spell.target == nil then
              light:Remove()
          else
              light.components.spell:StartSpell()
          end
      end
    end

local function fn_tart()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_tart")
    inst.AnimState:SetBuild("ancientdreams_tart")
    inst.AnimState:PlayAnimation("ancientdreams_tart_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_tart"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_tart.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_tart)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.healthvalue = 40
    inst.components.edible.hungervalue = 37.5
    inst.components.edible.getsanityfn = gettartSanity
    inst.components.edible.temperaturedelta = -5
    inst.components.edible.temperatureduration = 100
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
	inst:AddTag("fitsforgempack")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst.components.edible:SetOnEatenFn(OnEatenTart)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_tart(inst)
    return inst
end

local function getevilbredHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 20
        else
            return -10 
        end
    end
end

local function getevilbredSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 5
        else
            return -5
        end
    end
end

local function OnEatBread(inst, eater)
    if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_redgem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_evilbred()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_evilbred")
    inst.AnimState:SetBuild("ancientdreams_evilbred")
    inst.AnimState:PlayAnimation("ancientdreams_evilbred_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_evilbred"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_evilbred.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_evilbred)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getevilbredHealth
    inst.components.edible.hungervalue = 75
    inst.components.edible.getsanityfn = getevilbredSanity
    inst.components.edible.temperaturedelta = 50
    inst.components.edible.temperatureduration = 1200
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatBread)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_evilbred(inst)
    
    return inst
end

local function getgellHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 20
        else
            return 3
        end
    end
end

local function getgellSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 33
        else
            return 33
        end
    end
end

local function OnEatGell(inst, eater)
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_bluegem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_gell()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_gell")
    inst.AnimState:SetBuild("ancientdreams_gell")
    inst.AnimState:PlayAnimation("ancientdreams_gell_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_gell"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_gell.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_gell)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.gethealthfn = getgellHealth
    inst.components.edible.hungervalue = 25
    inst.components.edible.getsanityfn = getgellSanity
    inst.components.edible.temperaturedelta = -50
    inst.components.edible.temperatureduration = 1200
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatGell)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_gell(inst)
    
    return inst
end


local function getquasoHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 20
        else
            return 10 
        end
    end
end

local function getquasoSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 33
        else
            return 33
        end
    end
end

local function OnEatQuaso(inst, eater)
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_purplegem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_quaso()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_quaso")
    inst.AnimState:SetBuild("ancientdreams_quaso")
    inst.AnimState:PlayAnimation("ancientdreams_quaso_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_quaso"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_quaso.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_quaso)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.gethealthfn = getquasoHealth
    inst.components.edible.hungervalue = 62.5
    inst.components.edible.getsanityfn = getquasoSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatQuaso)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_quaso(inst)
    
    return inst
end

local function getfhishHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 20
        else
            return -10 
        end
    end
end

local function getfhishSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 30
        else
            return 30
        end
    end
end

local function OnEatFhish(inst, eater)
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_greengem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_fhish()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_fhish")
    inst.AnimState:SetBuild("ancientdreams_fhish")
    inst.AnimState:PlayAnimation("ancientdreams_fhish_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_fhish"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_fhish.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_fhish)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getfhishHealth
    inst.components.edible.hungervalue = 75
    inst.components.edible.getsanityfn = getfhishSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatFhish)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_fhish(inst)
    
    return inst
end 

local function getlombterHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 60
        else
            return 60 
        end
    end
end

local function getlombterSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 15
        else
            return 15
        end
    end
end

local function OnEatLobst(inst, eater)
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_orangegem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_lombter()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_lombter")
    inst.AnimState:SetBuild("ancientdreams_lombter")
    inst.AnimState:PlayAnimation("ancientdreams_lombter_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_lombter"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_lombter.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_lombter)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getlombterHealth
    inst.components.edible.hungervalue = 112.5
    inst.components.edible.getsanityfn = getlombterSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatLobst)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_lombter(inst)
    
    return inst
end 

local function getpizzaHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 80
        else
            return 80
        end
    end
end

local function getpizzaSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 20
        else
            return -20
        end
    end
end

local function OnEatZaza(inst, eater)
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_yellowgem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_pizza()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_pizza")
    inst.AnimState:SetBuild("ancientdreams_pizza")
    inst.AnimState:PlayAnimation("ancientdreams_pizza_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_pizza"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_pizza.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_pizza)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.gethealthfn = getpizzaHealth
    inst.components.edible.hungervalue = 37.5
    inst.components.edible.getsanityfn = getpizzaSanity
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatZaza)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_pizza(inst)
    
    return inst
end 


local function getserHealth(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            --eater.components.eater:SetAbsorptionModifiers(0.25, 1, 1)
            --eater:DoTaskInTime(0, function(eater)
            --    eater.components.eater:SetAbsorptionModifiers(healthabsorption, 1, 0)
            --end)
            return 200
        else
            return 1
        end
    end
end

local function getserSanity(inst, eater)
    if eater ~= nil then
        if eater.prefab == "wonderwhy" then
            --local healthabsorption = eater.components.eater.healthabsorption
            eater.components.eater:SetAbsorptionModifiers(1, 1, 1)
            eater:DoTaskInTime(0, function(eater)
                eater.components.eater:SetAbsorptionModifiers(1, 1, 0)
            end)
            return 100
        else
            return 100
        end
    end
end

local function OnEatSer(inst, eater)
eater:AddDebuff("healthregenbuff", "healthregenbuff")
eater:AddDebuff("sweettea_buff", "sweettea_buff")
        if math.random() <= 0.25 then
      eater.components.inventory:GiveItem(SpawnPrefab("why_opalgem_seed"))
        eater.components.talker:Say("There is something hard inside!") 
        end
    end

local function fn_ser()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    inst.AnimState:SetBank("ancientdreams_ser")
    inst.AnimState:SetBuild("ancientdreams_ser")
    inst.AnimState:PlayAnimation("ancientdreams_ser_cookpot")
    inst.entity:SetPristine()
    inst:AddTag("preparedfood")
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "ancientdreams_ser"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_ser.xml"
    inst.components.inventoryitem:SetOnDroppedFn(OnDrop_ser)
    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible.gethealthfn = getserHealth
    inst.components.edible.hungervalue = 37.5
    inst.components.edible.getsanityfn = getserSanity
    inst.components.edible.temperaturedelta = -20
    inst.components.edible.temperatureduration = 2000
    inst:AddComponent("tradable")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(5600)
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "ancientdreams_gemshard"
    inst.components.edible:SetOnEatenFn(OnEatSer)
    MakeHauntableLaunchAndPerish(inst)
    OnDrop_ser(inst)
    
    return inst
end 


return Prefab("ancientdreams_gegg", fn_gegg, assets),
Prefab("ancientdreams_candy", fn_candy, assets),
Prefab("ancientdreams_cube", fn_cube, assets),
Prefab("ancientdreams_geocake", fn_geocake, assets),
Prefab("ancientdreams_hyubsip", fn_hyubsip, assets),
Prefab("ancientdreams_kozisip", fn_kozisip, assets),
Prefab("ancientdreams_tart", fn_tart, assets),
Prefab("ancientdreams_evilbred", fn_evilbred, assets),
Prefab("ancientdreams_gell", fn_gell, assets),
Prefab("ancientdreams_quaso", fn_quaso, assets),
Prefab("ancientdreams_fhish", fn_fhish, assets),
Prefab("ancientdreams_lombter", fn_lombter, assets),
Prefab("ancientdreams_pizza", fn_pizza, assets),
Prefab("ancientdreams_ser", fn_ser, assets)
