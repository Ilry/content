GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})


local UIAnim = require "widgets/uianim"

local number_of_upgrademodules = 6
local number_of_mod_multiplier = 4
local total_number_of_upgrademodules = number_of_upgrademodules * number_of_mod_multiplier

TUNING.WX78_MAXELECTRICCHARGE=total_number_of_upgrademodules

local movespeed_chipboosts = {}
for i=1,total_number_of_upgrademodules/2,1 do
    -- movespeed_chipboosts[i] = 0.00 + (i-1) * 0.25
    table.insert(movespeed_chipboosts, 0.00 + (i-1) * 0.5)
end
TUNING.WX78_MOVESPEED_CHIPBOOSTS=movespeed_chipboosts

TUNING.WX78_WX78_LIGHT_BASERADIUS = 7

local OnUpgradeModulesListDirty = function(inst)
    if inst._parent ~= nil then
        local no_module_loaded = true
        local modules = {}
        for i=1,total_number_of_upgrademodules,1 do
            -- local module = inst.upgrademodules[i]:value()
            local module = inst.upgrademodules[i]:value()
            table.insert(modules, module)
            if module ~= 0 then
                no_module_loaded = false
            end
        end
        if no_module_loaded then
            inst._parent:PushEvent("upgrademoduleowner_popallmodules")
        else
            inst._parent:PushEvent("upgrademodulesdirty", modules)
        end
    end
end

AddPrefabPostInit("player_classified",function(inst)
	for i=7,total_number_of_upgrademodules,1 do
		table.insert(inst.upgrademodules,net_smallbyte(inst.GUID, "upgrademodules.mods"..i, "upgrademoduleslistdirty"))
	end

	if not TheWorld.ismastersim then
		inst.event_listeners["upgrademoduleslistdirty"]={}
	    inst.event_listening["upgrademoduleslistdirty"]={}
		inst:ListenForEvent("upgrademoduleslistdirty", OnUpgradeModulesListDirty)
	end
end)

AddClassPostConstruct("widgets/upgrademodulesdisplay",function(self, ...)
    self.chip_objectpool = {}
    for i = 1, total_number_of_upgrademodules do
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

    local scale = 0.4
    if IsGameInstance(Instances.Player2) then
        self.reversed = true
        self:SetScale(-scale, scale, scale)
    else
        self.reversed = false
        self:SetScale(scale, scale, scale)
    end
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
        for i=1,total_number_of_upgrademodules,1 do
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





