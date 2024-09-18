GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})--全局变量

 Assets = {
 Asset("ANIM", "anim/jshcb_status_wx.zip"),--每个mod,build都要不一样，如果是我写的代码的话
 
 Asset("ANIM", "anim/jshcb_wx_chips.zip"),--每个mod,build都要不一样，如果是我写的代码的话
 
 }
local wx78_moduledefs=require("wx78_moduledefs")--引入
local module_definitions = wx78_moduledefs.module_definitions
local AddCreatureScanDataDefinition=wx78_moduledefs.AddCreatureScanDataDefinition
local GetModuleDefinitionFromNetID=wx78_moduledefs.GetModuleDefinitionFromNetID
local AddNewModuleDefinition=wx78_moduledefs.AddNewModuleDefinition


AddComponentPostInit("combat", function(self)
local oldGetAttacked=self.GetAttacked
function self:GetAttacked(attacker,damage,...)

if self.inst._shield_chips and self.inst._shield_chips ~=0 and attacker~=nil  then--有防御电路的计数，且不为0
	local shield_chips=math.min(3, self.inst._shield_chips)--不超过3，这样即便是更多电路槽也不会增加，也不容易出bug
	damage=damage*(0.05-(shield_chips-1)*0)
end
return oldGetAttacked(self,attacker,damage,...)
end
end)


local function shield_activate(inst, wx)
	wx._shield_chips = (wx._shield_chips or 0)+1

end

local function shield_deactivate(inst, wx)
	wx._shield_chips = math.max(0, wx._shield_chips - 1)
	

end


local SHIELD_MODULE_DATA =--模块
{
    name = "shield",--名字
    slots = 2,--插槽数量
    activatefn = shield_activate,--激活
    deactivatefn = shield_deactivate,--未激活
}
table.insert(module_definitions, SHIELD_MODULE_DATA)--插入数据

AddNewModuleDefinition(SHIELD_MODULE_DATA)--插入模块id

AddCreatureScanDataDefinition("rocky", "shield", 5)--扫描对应生物解锁配方，以及获取的数据数量


AddRecipe2("wx78module_shield",
{Ingredient("scandata", 5), Ingredient("armormarble", 1)},
TECH.ROBOTMODULECRAFT_ONE,
{builder_tag="upgrademoduleowner"},
{"CHARACTER"}
)
---新增合成配方
local function electric_attach(inst, target)
    if target.components.electricattacks == nil then
        target:AddComponent("electricattacks")
    end
    target.components.electricattacks:AddSource(inst)
    if inst._onattackother == nil then
        inst._onattackother = function(attacker, data)
            if data.weapon ~= nil then
                if data.projectile == nil then
                    --in combat, this is when we're just launching a projectile, so don't do FX yet
                    if data.weapon.components.projectile ~= nil then
                        return
                    elseif data.weapon.components.complexprojectile ~= nil then
                        return
                    elseif data.weapon.components.weapon:CanRangedAttack() then
                        return
                    end
                end
                if data.weapon.components.weapon ~= nil and data.weapon.components.weapon.stimuli == "electric" then
                    --weapon already has electric stimuli, so probably does its own FX
                    return
                end
            end
            if data.target ~= nil and data.target:IsValid() and attacker:IsValid() then
                SpawnPrefab("electrichitsparks"):AlignToTarget(data.target, data.projectile ~= nil and data.projectile:IsValid() and data.projectile or attacker, true)
            end
        end
        inst:ListenForEvent("onattackother", inst._onattackother, target)
    end
    SpawnPrefab("electricchargedfx"):SetTarget(target)
end

local function electric_extend(inst, target)
    SpawnPrefab("electricchargedfx"):SetTarget(target)
end

local function electric_detach(inst, target)
    if target.components.electricattacks ~= nil then
        target.components.electricattacks:RemoveSource(inst)
    end
    if inst._onattackother ~= nil then
        inst:RemoveEventCallback("onattackother", inst._onattackother, target)
        inst._onattackother = nil
    end
end

local function magic_electric_activate(inst, wx)
	wx._magic_electric_chips = (wx._magic_electric_chips or 0)+1
	if wx._magic_electric_chips==1 then
		electric_attach(inst, wx)
	else
		electric_extend(inst, wx)
	end
end

local function magic_electric_deactivate(inst, wx)
	wx._magic_electric_chips = math.max(0, wx._magic_electric_chips - 1)
	if wx._magic_electric_chips==0 then
		electric_detach(inst, wx)
	end

end


local MAGIC_ELECTRIC_MODULE_DATA =--模块
{
    name = "magic_electric",--名字
    slots = 2,--插槽数量
    activatefn = magic_electric_activate,--激活
    deactivatefn = magic_electric_deactivate,--未激活
}
table.insert(module_definitions, MAGIC_ELECTRIC_MODULE_DATA)--插入数据

AddNewModuleDefinition(MAGIC_ELECTRIC_MODULE_DATA)--插入模块id

AddCreatureScanDataDefinition("bishop_nightmare", "magic_electric", 5)
AddCreatureScanDataDefinition("bishop", "magic_electric", 5)--扫描对应生物解锁配方，以及获取的数据数量


AddRecipe2("wx78module_magic_electric",
{Ingredient("scandata", 5), Ingredient("purplegem", 1), Ingredient("transistor", 2)},
TECH.ROBOTMODULECRAFT_ONE,
{builder_tag="upgrademoduleowner"},
{"CHARACTER"}
)
---新增合成配方



local modmodule={"shield","magic_electric",}--以后可以加新的

AddClassPostConstruct( "widgets/upgrademodulesdisplay", function(self)--右边显示模块的动画
	local oldOnModuleAdded =self.OnModuleAdded
	function self:OnModuleAdded(moduledefinition_index,...)
	
		oldOnModuleAdded(self,moduledefinition_index,...)--执行旧函数
		local module_def = GetModuleDefinitionFromNetID(moduledefinition_index)--根据id获取模块
		if module_def == nil then
			return
		end
		local modname = module_def.name--获取模块名称
		for k, v in pairs( modmodule) do
		if modname==v then--是本模组的模块
			local new_chip = self.chip_objectpool[self.chip_poolindex-1]--旧函数执行self.chip_poolindex+1了，这里要-1
			new_chip:GetAnimState():OverrideSymbol("movespeed2_chip", "jshcb_status_wx", modname.."_chip")--动画覆盖
		end
		end
		
	end
end)


for k, v in pairs( modmodule) do
    AddPrefabPostInit("wx78module_"..v, function(inst)--修改模组模块的动画和贴图
		inst:DoTaskInTime(.1,function()
        inst.AnimState:SetBank("chips")
        inst.AnimState:SetBuild("jshcb_wx_chips")
        inst.AnimState:PlayAnimation(v)
		end)
    end)
end	


for k,v in pairs (modmodule) do
	table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/wx78module_"..v..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/wx78module_"..v..".xml" ))
    RegisterInventoryItemAtlas("images/inventoryimages/wx78module_"..v..".xml", "wx78module_"..v..".tex")
end

local oldAPPLYMODULE= ACTIONS.APPLYMODULE.fn --插电路的fn
ACTIONS.APPLYMODULE.fn = function(act)
    if (act.invobject ~= nil and act.invobject.components.upgrademodule ~= nil and act.invobject.prefab=="wx78module_magic_electric" )--要插的是感电电路
            and (act.doer ~= nil and act.doer.components.upgrademoduleowner ~= nil) then
		for _, module in ipairs(act.doer.components.upgrademoduleowner.modules) do
			if module.prefab == act.invobject.prefab then--已经有了感电电路
				if act.doer and act.doer.components.talker and not act.doer:HasTag("mine") then
					act.doer.components.talker:Say("只能插入一个感电电路")
				end
				return true
			end
		end
    end
	if oldAPPLYMODULE then
		return oldAPPLYMODULE(act)
	end
end


		STRINGS.NAMES.WX78MODULE_SHIELD = "防御电路"
        STRINGS.RECIPE_DESC.WX78MODULE_SHIELD = "模仿石头的能力"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.WX78MODULE_SHIELD = "你依仗护甲，而我就是护甲"	
		
		
		
		STRINGS.NAMES.WX78MODULE_MAGIC_ELECTRIC = "感电电路"
        STRINGS.RECIPE_DESC.WX78MODULE_MAGIC_ELECTRIC = "魔法闪电"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.WX78MODULE_MAGIC_ELECTRIC = "闪电之力"	