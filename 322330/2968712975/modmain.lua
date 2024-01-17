PrefabFiles = {
	
}
---对比老版本 主要是增加了names图片 人物检查图标 还有人物的手臂修复（增加了上臂）
--人物动画里面有个SWAP_ICON 里面的图片是在检查时候人物头像那里显示用的
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

----2019.05.08 修复了 人物大图显示错误和检查图标显示错误

Assets = {

--[[---注意事项
1、目前官方自从熔炉之后人物的界面显示用的都是那个椭圆的图
2、官方人物目前的图片跟名字是分开的 
3、names_acerola 和 acerola_none 这两个文件需要特别注意！！！
这两文件每一次重新转换之后！需要到对应的xml里面改对应的名字 否则游戏里面无法显示
具体为：
降names_esctemplatxml 里面的 Element name="acerola.tex" （也就是去掉names——）
将acerola_none.xml 里面的 Element name="acerola_none_oval" 也就是后面要加  _oval
（注意看修改的名字！不是两个都需要修改）
	]]
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local LAN_ = GetModConfigData('Language')
if LAN_ then
STRINGS.RANDCSTRINGS ={
[1] = "修复",
[2] = "合并",
}
else
STRINGS.RANDCSTRINGS ={
[1] = "Repair",
[2] = "Combine",
}
end
TUNING.RANDCREPAIRABLE = GetModConfigData('Repairable')
TUNING.RANDCCOMBINABLE = GetModConfigData('Combinable')
TUNING.RANDCCOMBINABLEFUEL = GetModConfigData('Combinablefuel')
TUNING.RANDCCOMBINABLEFRESH = GetModConfigData('Combinablefresh')
TUNING.RANDCREPAIRABLEFUEL = GetModConfigData('Repairablefuel')
TUNING.RANDCLIMITEDFUEL = GetModConfigData('Fuellimit')
--TUNING.RANDCREPAIRABLEFRESH = GetModConfigData('Repairablefresh')
TUNING.RANDCLIMITED = GetModConfigData('Limited')
TUNING.RANDCNEWLIMIT = GetModConfigData('Newlimit')
TUNING.RANDCSTICK = GetModConfigData('Nightstick')
TUNING.RANDCAMULET = GetModConfigData('Amulet')
TUNING.RANDCEFFICIENCY = GetModConfigData('Efficiency')
TUNING.RANDCPERCENTAGEBASE = GetModConfigData('Percentagebase')
TUNING.RANDCGEMONLY = GetModConfigData('Gemonlymode')
--TUNING.RANDCNOFINITEUSES = GetModConfigData('Nofiniteuses')
TUNING.RANGCCOFINITEUSES = GetModConfigData('Cofiniteuses')
local function tagrepair(self)--这是标记能被维修的便签
	if not self.inst:HasTag("canberepaired") then
		self.inst:AddTag("canberepaired")
	end
end

local function takedamage(self)--这是重写护甲值变化
	local oldsetcondition = self.SetCondition
	self.SetCondition = function(self,amount)
		
		if self.indestructible then
			return
		end
		if amount > self.maxcondition then
			self.condition = amount
		else
			self.condition = math.min(amount, self.maxcondition)
		end
		self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })

		if self.condition <= 0 then
			self.condition = 0
			ProfileStatsSet("armor_broke_"..self.inst.prefab, true)
			ProfileStatsSet("armor", self.inst.prefab)

			if self.onfinished ~= nil then
				self.onfinished(self.inst)
			end

			if not self.keeponfinished then
				self.inst:Remove()
			end
		end
	end
end

local function changefuel(self) -- 这是重写燃料值变化...要重写的好多，还是算了
	local olddodelta = self.DoDelta
	self.DoDelta = function(self, amount, doer)
		local oldsection = self:GetCurrentSection()
		self.currentfuel = math.max(0, self.currentfuel + amount)
		local newsection = self:GetCurrentSection()
		if oldsection ~= newsection then
			if self.sectionfn then
				self.sectionfn(newsection, oldsection, self.inst, doer)
			end
			self.inst:PushEvent("onfueldsectionchanged", { newsection = newsection, oldsection = oldsection, doer = doer })
			if self.currentfuel <= 0 and self.depleted then
				self.depleted(self.inst)
			end
		end
		self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
	end
	--self.DoDelta(self, amount, doer) = function
end

--单独修复舔盐器贴图
local imagerange = 5
local function getimagenum(inst, pct)
    local image = math.ceil(pct * imagerange)
    image = imagerange - image + 1

    return tostring(image)
end

local function PlayIdle(inst, push)
    if inst:HasTag("burnt") then
        return
    end

    if push then
        inst.AnimState:PushAnimation("idle"..getimagenum(inst, math.min(1,inst.components.finiteuses:GetPercent())), true)
    else
        inst.AnimState:PlayAnimation("idle"..getimagenum(inst, math.min(1,inst.components.finiteuses:GetPercent())), true)
    end
end

local function OnUsed(inst, data)
	inst:DoTaskInTime(0,function()
		PlayIdle(inst,false)
	end)
end

if TUNING.RANDCREPAIRABLE == true then
	modimport("scripts/main/action/repairequipment.lua")
	AddComponentPostInit("armor", tagrepair)
	AddComponentPostInit("finiteuses", tagrepair)
	AddComponentPostInit("perishable", tagrepair)
	AddDeconstructRecipe("tentaclespike",{Ingredient("tentaclespots", 1), Ingredient("houndstooth", 3)})
	AddDeconstructRecipe("spear_wathgrithr_lightning_charged",{Ingredient("twigs", 2), Ingredient("beefalowool", 1), Ingredient("lightninggoathorn", 2), Ingredient("moonstorm_static_item", 1)})
end
if TUNING.RANDCREPAIRABLEFUEL then
	AddComponentPostInit("fueled", tagrepair)
end
if TUNING.RANDCCOMBINABLE == true then
	modimport("scripts/main/action/combinearmor.lua")
	modimport("scripts/main/action/combineweapon.lua")
end
if TUNING.RANDCCOMBINABLEFRESH then
	modimport("scripts/main/action/combinefresh.lua")
end
if TUNING.RANDCCOMBINABLEFUEL == true then
	modimport("scripts/main/action/combinecloth.lua")
end
if TUNING.RANDCLIMITEDFUEL == true then
	AddComponentPostInit("fueled", changefuel)
end

if TUNING.RANDCLIMITED == true then
	AddComponentPostInit("armor", takedamage)
	--AddComponentPostInit("fueled", changefuel)
	AddPrefabPostInit("saltlick",function(inst)
		if not GLOBAL.TheWorld.ismastersim then
			return inst
		end
		inst:ListenForEvent("percentusedchange", OnUsed)
	end)
end
if TUNING.RANDCSTICK == true then
	AddPrefabPostInit("nightstick",function(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
		if inst and inst.components.fueled then
			inst.components.fueled.accepting = true
			inst.components.fueled.fueltype = FUELTYPE.CHEMICAL
		end
	end
	)
end

if TUNING.RANDCAMULET == true then
	AddPrefabPostInit("blueamulet",function(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
		if inst and inst.components.fueled then
			inst.components.fueled.accepting = true
			inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
		end
	end
	)
	AddPrefabPostInit("purpleamulet",function(inst)
	if not GLOBAL.TheWorld.ismastersim then
		return inst
	end
		if inst and inst.components.fueled then
			inst.components.fueled.accepting = true
			inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
		end
	end
	)
end

local function notuse(self)
	local olduse = self.Use
	self.Use = function(self,num)
		if self.combinetime >= TUNING.RANGCCOFINITEUSES
		then
			return
		else
			olduse(self,num)
		end
	end
end
			
local function usecombinetime(self)
	self.combinetime = 1
	self.OnSave = function(self)
		if self.current ~= self.total or self.doesnotstartfull then
			return { uses = self.current, 
					combinetime = self.combinetime
					}
		end
	end
	self.OnLoad = function(self,data)
		if data.uses ~= nil then
			self:SetUses(data.uses)
		end
		if data.combinetime ~= nil then
			self.combinetime = data.combinetime
			if self.combinetime >= TUNING.RANGCCOFINITEUSES
			then
				self.inst:AddTag("hide_percentage")
			end
		end
	end
end

local function notarmor(self)
	local oldsetcondition = self.SetCondition
	self.SetCondition = function(self,amount)
		if self.combinetime >= TUNING.RANGCCOFINITEUSES
		then
			return
		else
			oldsetcondition(self,amount)
		end
	end
end
			
local function armorcombinetime(self)
	self.combinetime = 1
	self.OnSave = function(self)
		return self.condition ~= self.maxcondition 
		and { condition = self.condition, combinetime = self.combinetime
		} or {combinetime = self.combinetime}
	end
	self.OnLoad = function(self,data)
		if data.condition ~= nil then
			self:SetCondition(data.condition)
		end
		if data.combinetime ~= nil then
			self.combinetime = data.combinetime
			if self.combinetime >= TUNING.RANGCCOFINITEUSES
			then
				self.inst:AddTag("hide_percentage")
			end
		end
	end
end
local function notfuel(self)
	local olddodelta = self.DoDelta
	self.DoDelta = function(self,amount,doer)
		if self.combinetime >= TUNING.RANGCCOFINITEUSES
		then
			return
		else
			olddodelta(self,amount,doer)
		end
	end
end
			
local function fuelcombinetime(self)
	self.combinetime = 1
	self.OnSave = function(self)
		if self.currentfuel ~= self.maxfuel then
			return {fuel = self.currentfuel,combinetime = self.combinetime}
		else
			return{combinetime = self.combinetime}
		end
	end
	self.OnLoad = function(self,data)
		if data.fuel then
			self:InitializeFuelLevel(math.max(0, data.fuel))
		end
		if data.combinetime ~= nil then
			self.combinetime = data.combinetime
			if self.combinetime >= TUNING.RANGCCOFINITEUSES
			then
				self.inst:AddTag("hide_percentage")
			end
		end
	end
end
			
local function freshcombinetime(self)
	self.combinetime = 1
	self.OnSave = function(self)
		return
		{
			paused = self.updatetask == nil or nil,
			time = self.perishremainingtime,
			combinetime = self.combinetime,
		}
	end
	self.OnLoad = function(self,data)
		if data ~= nil then
			if data.time ~= nil then
				self.perishremainingtime = data.time
			end

			if data.paused then
				self:StopPerishing()
			elseif data.time ~= nil then
				self:StartPerishing()
			end
			if data.combinetime ~= nil then
				self.combinetime = data.combinetime
				if self.combinetime >= TUNING.RANGCCOFINITEUSES
				then
					self.inst:AddTag("hide_percentage")
					self.inst:RemoveTag("show_spoilage")
					self:StopPerishing()
				end
			end
		end
	end
end

if TUNING.RANGCCOFINITEUSES ~= 0 then
	AddComponentPostInit("finiteuses", notuse)
	AddComponentPostInit("finiteuses", usecombinetime)
	AddComponentPostInit("armor", notarmor)
	AddComponentPostInit("armor", armorcombinetime)
	AddComponentPostInit("fueled", notfuel)
	AddComponentPostInit("fueled", fuelcombinetime)
	AddComponentPostInit("perishable", freshcombinetime)
end
--local queueractlist={ "allclick

--}--可兼容排队论的动作

local actionqueuer_status,actionqueuer_data = pcall(require,"components/actionqueuer")
if actionqueuer_status then
	if AddActionQueuerAction then
		if TUNING.RANDCREPAIRABLE == true then
			AddActionQueuerActionList("leftclick","REPAIREQUIPMENT")
		end
		if TUNING.RANDCCOMBINABLE == true then
			AddActionQueuerActionList("leftclick","COMBINEARMOR","COMBINEWEAPON")
		end
		if TUNING.RANDCCOMBINABLEFUEL == true then
			AddActionQueuerActionList("leftclick","COMBINECLOTH")
		end
		if TUNING.RANDCCOMBINABLEFRESH == true then
			AddActionQueuerActionList("leftclick","COMBINEFRESH")
		end
		
    end
end

-- The character select screen lines  --人物选人界面的描述



-- Custom speech strings  ----人物语言文件  可以进去自定义

-- The character's name as appears in-game  --人物在游戏里面的名字


