GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})--全局变量
PrefabFiles = {
"charm_bee",

}
 Assets = {
 Asset("ANIM", "anim/charms_status_wx.zip"),
 
 Asset("ANIM", "anim/charms_wx_chips.zip"),
 
 }
 
modimport("scripts/charm_bee")

local wx78_moduledefs=require("wx78_moduledefs")
local module_definitions = wx78_moduledefs.module_definitions
local AddCreatureScanDataDefinition=wx78_moduledefs.AddCreatureScanDataDefinition
local GetModuleDefinitionFromNetID=wx78_moduledefs.GetModuleDefinitionFromNetID
local AddNewModuleDefinition=wx78_moduledefs.AddNewModuleDefinition
local GetCreatureScanData = wx78_moduledefs.GetCreatureScanDataDefinition

local function spawn_charm_bee(inst,wx)


    for i=1,3 do

            local pt = wx:GetPosition()
            local x=pt.x
            local y=pt.y
			local z=pt.z
			local pet = SpawnPrefab("charm_bee")
    if pet ~= nil then 
	if not inst.charm_bees then inst.charm_bees={} end
	inst.charm_bees[i]=pet
	
    pet.persists = false
    if wx.components.leader ~= nil then
        wx.components.leader:AddFollower(pet)
    end

        if pet.Physics ~= nil then
            pet.Physics:Teleport(x, y, z)
        elseif pet.Transform ~= nil then
            pet.Transform:SetPosition(x, y, z)
        end

    end

    end
end

local function charm_bee_activate(inst, wx)
	spawn_charm_bee(inst,wx)
end

local function charm_bee_deactivate(inst, wx)
--inst:DoTaskInTime(0.1,function (inst)
for _,pet in pairs(inst.charm_bees)do
pet:Remove()
end
--end)
end


local CHARM_BEE_MODULE_DATA =--模块
{
    name = "charm_bee",--名字
    slots = 3,--插槽数量
    activatefn = charm_bee_activate,--激活
    deactivatefn = charm_bee_deactivate,--未激活
}
table.insert(module_definitions, CHARM_BEE_MODULE_DATA)--插入数据

AddNewModuleDefinition(CHARM_BEE_MODULE_DATA)--插入模块id

AddCreatureScanDataDefinition("bee", "charm_bee", 1)--扫描对应生物解锁配方，以及获取的数据数量


AddRecipe2("wx78module_charm_bee",
{Ingredient("scandata", 3), Ingredient("bee", 3),Ingredient("honeycomb", 1)},
TECH.ROBOTMODULECRAFT_ONE,
{builder_tag="upgrademoduleowner"},
{"CHARACTER"}
)
--新增合成配方

		STRINGS.NAMES.WX78MODULE_CHARM_BEE = "蜂群集结"
        STRINGS.RECIPE_DESC.WX78MODULE_CHARM_BEE = "生成一群跟随穿戴者的小虫子，为他们收集散落各处的物品"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.WX78MODULE_CHARM_BEE = "这个护符可生成一群跟随穿戴者的小虫子，为他们收集散落各处的物品"	

local function OnCooldown(inst)
    inst._cdtask = nil
end

local function charm_thornOnBlocked(owner, data, inst)
    if inst._cdtask == nil and data ~= nil and not data.redirected then
        --V2C: tiny CD to limit chain reactions
        inst._cdtask = inst:DoTaskInTime(.3, OnCooldown)

        SpawnPrefab("bramblefx_armor"):SetFXOwner(owner)

        if owner.SoundEmitter ~= nil then
            owner.SoundEmitter:PlaySound("dontstarve/common/together/armor/cactus")
        end
    end
end
		
local function charm_thorn_activate(inst, wx)
    if inst._onblocked == nil then
        inst._onblocked = function(owner, data)
            charm_thornOnBlocked(owner, data, inst)
        end
    end

    inst:ListenForEvent("blocked", inst._onblocked, wx)
    inst:ListenForEvent("attacked", inst._onblocked, wx)
end

local function charm_thorn_deactivate(inst, wx)
    inst:RemoveEventCallback("blocked", inst._onblocked, wx)
    inst:RemoveEventCallback("attacked", inst._onblocked, wx)

end

local CHARM_THORN_MODULE_DATA =--模块
{
    name = "charm_thorn",--名字
    slots = 3,--插槽数量
    activatefn = charm_thorn_activate,--激活
    deactivatefn = charm_thorn_deactivate,--未激活
}
table.insert(module_definitions, CHARM_THORN_MODULE_DATA)--插入数据

AddNewModuleDefinition(CHARM_THORN_MODULE_DATA)--插入模块id

AddCreatureScanDataDefinition("cactus", "charm_thorn", 1)--扫描对应生物解锁配方，以及获取的数据数量

AddCreatureScanDataDefinition("oasis_cactus", "charm_thorn", 1)--扫描对应生物解锁配方，以及获取的数据数量

    AddPrefabPostInit("cactus", function (inst)
		inst:AddTag("smallcreature")
    end)
	
    AddPrefabPostInit("oasis_cactus", function (inst)
		inst:AddTag("smallcreature")
    end)
	
AddRecipe2("wx78module_charm_thorn",
{Ingredient("scandata", 3), Ingredient("cactus_meat", 1),Ingredient("cactus_flower", 1),Ingredient("livinglog", 2)},
TECH.ROBOTMODULECRAFT_ONE,
{builder_tag="upgrademoduleowner"},
{"CHARACTER"}
)

		STRINGS.NAMES.WX78MODULE_CHARM_THORN = "苦痛荆棘"
        STRINGS.RECIPE_DESC.WX78MODULE_CHARM_THORN = "装备后可在受伤时向周围敌人造成伤害。"
        STRINGS.CHARACTERS.GENERIC.DESCRIBE.WX78MODULE_CHARM_THORN = "装备后可在受伤时向周围敌人造成伤害。"	
		
		
		
		-- local function createsporecloud(inst,wx)
			-- SpawnPrefab("sporecloud").Transform:SetPosition(wx.Transform:GetWorldPosition())
		-- end
		
		
-- local function charm_fungus_activate(inst, wx)
-- if inst.sporecloudtask then inst.sporecloudtask:Cancel() inst.sporecloudtask=nil end
-- inst.sporecloudtask=inst:DoPeriodicTask(5,createsporecloud(inst,wx))
-- end

-- local function charm_fungus_deactivate(inst, wx)
-- if inst.sporecloudtask then inst.sporecloudtask:Cancel() inst.sporecloudtask=nil end
-- end

-- local CHARM_FUNGUS_MODULE_DATA =--模块
-- {
    -- name = "charm_fungus",--名字
    -- slots = 3,--插槽数量
    -- activatefn = charm_fungus_activate,--激活
    -- deactivatefn = charm_fungus_deactivate,--未激活
-- }
-- table.insert(module_definitions, CHARM_FUNGUS_MODULE_DATA)--插入数据

-- AddNewModuleDefinition(CHARM_FUNGUS_MODULE_DATA)--插入模块id

-- AddCreatureScanDataDefinition("toadstool", "charm_fungus", 10)--扫描对应生物解锁配方，以及获取的数据数量

-- AddCreatureScanDataDefinition("toadstool_dark", "charm_fungus", 10)--扫描对应生物解锁配方，以及获取的数据数量

-- AddRecipe2("wx78module_charm_fungus",
-- {Ingredient("scandata", 5), Ingredient("shroom_skin", 1),Ingredient("red_cap", 1),Ingredient("green_cap", 1),Ingredient("blue_cap",1)},
-- TECH.ROBOTMODULECRAFT_ONE,
-- {builder_tag="upgrademoduleowner"},
-- {"CHARACTER"}
-- )

		-- STRINGS.NAMES.WX78MODULE_CHARM_FUNGUS = "蘑菇孢子"
        -- STRINGS.RECIPE_DESC.WX78MODULE_CHARM_FUNGUS = "装备蘑菇孢子后，每隔一段时间释放孢子团。"
        -- STRINGS.CHARACTERS.GENERIC.DESCRIBE.WX78MODULE_CHARM_FUNGUS = "装备蘑菇孢子后，每隔一段时间释放孢子团。"	
		
		
		
local modmodule={"charm_bee","charm_thorn",}--以后可以加新的
--"charm_fungus",
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
			new_chip:GetAnimState():OverrideSymbol("movespeed2_chip", "charms_status_wx", modname.."_chip")--动画覆盖

		end
		end
		
	end
end)


for k, v in pairs( modmodule) do
    AddPrefabPostInit("wx78module_"..v, function(inst)--修改模组模块的动画和贴图
		inst:DoTaskInTime(.1,function()
        inst.AnimState:SetBank("chips")
        inst.AnimState:SetBuild("charms_wx_chips")
        inst.AnimState:PlayAnimation(v)
		inst:AddTag("charms")
		inst:AddTag("wx78module_"..v)
		inst:RemoveComponent("finiteuses")
		end)
    end)
end	


for k,v in pairs (modmodule) do
	table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/wx78module_"..v..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/wx78module_"..v..".xml" ))
    RegisterInventoryItemAtlas("images/inventoryimages/wx78module_"..v..".xml", "wx78module_"..v..".tex")
end

local oldAPPLYMODULE= ACTIONS.APPLYMODULE.fn 
ACTIONS.APPLYMODULE.fn = function(act)
    if (act.invobject ~= nil and act.invobject.components.upgrademodule ~= nil and act.invobject:HasTag("charms") )
            and (act.doer ~= nil and act.doer.components.upgrademoduleowner ~= nil) then
		for _, module in ipairs(act.doer.components.upgrademoduleowner.modules) do
			if module.prefab == act.invobject.prefab then
				return false--不能装备相同的护符
			end
		end
    end
	if oldAPPLYMODULE then
		return oldAPPLYMODULE(act)
	end

end






AddPlayerPostInit(function(inst)

end)
