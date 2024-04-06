GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})


local UIAnim = require "widgets/uianim"

TUNING.WX78_MAXELECTRICCHARGE=24

TUNING.WX78_MOVESPEED_CHIPBOOSTS={0.00, 0.25, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1, 1.10, 1.20, 1.30, 1.40}

local OnUpgradeModulesListDirty = function(inst)
    if inst._parent ~= nil then
        local module1 = inst.upgrademodules[1]:value()
        local module2 = inst.upgrademodules[2]:value()
        local module3 = inst.upgrademodules[3]:value()
        local module4 = inst.upgrademodules[4]:value()
        local module5 = inst.upgrademodules[5]:value()
        local module6 = inst.upgrademodules[6]:value()
        local module7 = inst.upgrademodules[7]:value()
        local module8 = inst.upgrademodules[8]:value()
        local module9 = inst.upgrademodules[9]:value()
        local module10 = inst.upgrademodules[10]:value()
        local module11 = inst.upgrademodules[11]:value()
        local module12 = inst.upgrademodules[12]:value()
        local module13 = inst.upgrademodules[13]:value()
        local module14 = inst.upgrademodules[14]:value()
        local module15 = inst.upgrademodules[15]:value()
        local module16 = inst.upgrademodules[16]:value()
        local module17 = inst.upgrademodules[17]:value()
        local module18 = inst.upgrademodules[18]:value()
        local module19 = inst.upgrademodules[19]:value()
        local module20 = inst.upgrademodules[21]:value()
        local module21 = inst.upgrademodules[22]:value()
        local module23 = inst.upgrademodules[23]:value()
        local module24 = inst.upgrademodules[24]:value()
       
        if module1 == 0 and module2 == 0 and module3 == 0 and module4 == 0 and module5 == 0 and module6 == 0 and module7 == 0 and module8 == 0 and module9 == 0 and module10 == 0 and module11 == 0 and module12 == 0 and module13 == 0 and module14 == 0 and module15 == 0 and module16 == 0 and module17 == 0 and module18 == 0 and module19 == 0 and module20 == 0 and module21 == 0 and module22 == 0 and module23 == 0 and module24 == 0 then
            inst._parent:PushEvent("upgrademoduleowner_popallmodules")
        else
            inst._parent:PushEvent("upgrademodulesdirty", {module1, module2, module3, module4, module5, module6, module7, module8, module9, module10, module11, module12, module13, module14, module15, module16, module17, module18, module19, module20, module21, module22, module23, module24})
        end
    end
end

AddPrefabPostInit("player_classified",function(inst)
	for i=7,24,1 do
		table.insert(inst.upgrademodules,net_smallbyte(inst.GUID, "upgrademodules.mods"..i, "upgrademoduleslistdirty"))
	end

	if not TheWorld.ismastersim then
		inst.event_listeners["upgrademoduleslistdirty"]={}
	    inst.event_listening["upgrademoduleslistdirty"]={}
		inst:ListenForEvent("upgrademoduleslistdirty", OnUpgradeModulesListDirty)
	end
end)

AddClassPostConstruct("widgets/upgrademodulesdisplay",function(self, ...)
    for i = 1, 6 do
	    local chip_object = self:AddChild(UIAnim())
	    chip_object:GetAnimState():SetBank("status_wx")
	    chip_object:GetAnimState():SetBuild("status_wx")
	    chip_object:GetAnimState():AnimateWhilePaused(false)

	    chip_object:GetAnimState():Hide("plug_on")
	    chip_object._power_hidden = true

	    chip_object:MoveToBack()
	    chip_object:Hide()

	    table.insert(self.chip_objectpool, chip_object)
    end

    for i,v in ipairs(self.chip_objectpool) do
    	v:SetPosition(0,-60)
    end

    self.battery_frame:SetPosition(0,165)


end)

 AddClassPostConstruct("widgets/secondarystatusdisplays",function(self, ...)     
 	if self.upgrademodulesdisplay then
 		self.upgrademodulesdisplay:SetPosition(self.column1,-200)
 	end

 end)

 local function OnAllUpgradeModulesRemoved(inst)
    SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)

    inst:PushEvent("upgrademoduleowner_popallmodules")

    if inst.player_classified ~= nil then
        for i=1,24,1 do
        	inst.player_classified.upgrademodules[i]:set(0)
        end
    end
end

 AddPrefabPostInit("wx78",function(inst)
 	if TheWorld.ismastersim then
	 	inst:DoTaskInTime(.1,function()
	 		inst.components.upgrademoduleowner.onallmodulespopped = OnAllUpgradeModulesRemoved
	 	end)
 	end
 end)









 

 local T = GLOBAL.TUNING

 T.WX78_HEALTH = 150
 T.WX78_HUNGER = 150
 T.WX78_SANITY = 200
      
 T.WX78_CHARGE_REGENTIME = 5
         
 T.WX78_MAXHEALTH_BOOST = 50--一级健康电路
 T.WX78_MAXHEALTH2_MULT = 4.0  --二级倍率


 T.WX78_BEE_TICKPERIOD = 2.0
 T.WX78_BEE_HEALTHPERTICK = 4.0

--  T.WX78_MAXSANITY1_BOOST = 75 --一级理智电路
--  T.WX78_MAXSANITY_BOOST = 150--二级理智电路
 T.WX78_MAXSANITY_DAPPERNESS = 300/(30*10)--理智效果
         
 T.WX78_MAXHUNGER1_BOOST = 100--一级饱食电路
 T.WX78_MAXHUNGER_BOOST = 200--二级饱食电路
 T.WX78_MAXHUNGER_SLOWPERCENT = 0.5--饱食减缓效果
 
--  T.WX78_MOVESPEED_CHIPBOOSTS = {0.00, 0.50, 0.70, 0.85, 0.95} -- 速度电路
 
--  T.WX78_MUSIC_DAPPERNESS = 100/(30*10)--理智效果	
          
--  T.WX78_LIGHT_BASERADIUS = 8.5--初始光照电路效果
--  T.WX78_LIGHT_EXTRARADIUS = 2.5--光照叠加效果
 
 if GLOBAL.TheNet:GetIsServer() ~= true then
   return
 end
 
 local hatList = {
   ["eyebrella"] = true,
   ["beefalo"] = true,
   ["winter"] = true,
   ["walrus"] = true,
   ["straw"] = true,
 }
 
 for key,value in pairs(hatList) do
   AddPrefabPostInit(key.."hat", function(inst)
       if inst.components.fueled ~= nil then
         inst:RemoveComponent("fueled")
       end
     end
   )
 end
 
 AddPrefabPostInit("raincoat", function(inst)
   inst.components.equippable:SetOnEquip(function(inst,owner)
     owner.AnimState:OverrideSymbol("swap_body", "torso_rain", "swap_body")
   end)
   inst.components.equippable:SetOnUnequip(function(inst,owner)
     owner.AnimState:ClearOverrideSymbol("swap_body")
   end)
   if inst.components.fueled ~= nil then
     inst:RemoveComponent("fueled")
   end
 end
 )
 
 AddPrefabPostInit("deerclops_eyeball", function(inst)
   if inst.components.edible ~= nil then
     inst:RemoveComponent("edible")
   end
 end
 )
 
 AddPrefabPostInit("sisturn", function(inst)
     inst:AddComponent("preserver")
     inst.components.preserver:SetPerishRateMultiplier(0)
 end
 )
 
 AddPrefabPostInit("orangestaff", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
     inst.components.blinkstaff.onblinkfn = function(staff, pos, caster)
       if caster then
           if caster.components.staffsanity then
               caster.components.staffsanity:DoCastingDelta(-TUNING.SANITY_MED)
           elseif caster.components.sanity ~= nil then
               caster.components.sanity:DoDelta(-TUNING.SANITY_MED)
           end
       end
     end
 end
 )
 
 AddPrefabPostInit("firesuppressor", function(inst)
   if inst and inst.components and inst.components.fueled and inst.components.fueled.rate then
     inst.components.fueled.rate = 0
   end
 end
 )
 
 TUNING.PERISH_CAGE_MULT = 0
 
 AddPrefabPostInit("wx78module_maxhealth", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_maxhealth2", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_maxsanity1", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_maxsanity", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_bee", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_music", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_maxhunger1", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_maxhunger", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_movespeed", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_movespeed2", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_heat", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_cold", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_taser", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_nightvision", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_light", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_shield", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)
 AddPrefabPostInit("wx78module_magic_electric", function(inst)
     if inst.components.finiteuses then
         inst:RemoveComponent("finiteuses")
     end
 end)