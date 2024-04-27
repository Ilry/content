local _G = GLOBAL
local R_diao = GetModConfigData("rendiao")
local B_diao = GetModConfigData("baodiao")
local amu_diao = GetModConfigData("amudiao")
local zhuang_bei = GetModConfigData("zbdiao")
local modnillots = GetModConfigData("nillots") or 0
local R_d = R_diao - 3
local B_d = B_diao - 5
if R_d < 0 then R_d = 0 end if B_d < 0 then B_d = 0 end

AddComponentPostInit("container", function(Container, inst)
	function Container:DropSuiji(ondeath)
		local amu_x = true
		local rev_x = true
		for k=1, self.numslots do
			local v = self.slots[k]
			if amu_diao and amu_x and v and v.prefab == "amulet" then --掉落护符
				amu_x = false
				self:DropItem(v)
			end
			if amu_diao and rev_x and v and v.prefab == "reviver" then --掉落心脏
				rev_x = false
				self:DropItem(v)
			end
		end
		for k=1, self.numslots do --随机掉落背包里的物品
			local v = self.slots[math.random(1, self.numslots)]
			if k > math.random(B_d, B_diao) then
				return false
			end
			if v then
				self:DropItem(v)
			end
		end
	end
end)

AddComponentPostInit("inventory", function(Inventory, inst)
	Inventory.oldDropEverythingFn = Inventory.DropEverything
	function Inventory:DropSuiji(ondeath)
		local amu_x = true
		local rev_x = true
		local nillots = modnillots
		for k=1, self.maxslots do
			local v = self.itemslots[k]
			if amu_diao and amu_x and v and v.prefab == "amulet" then --掉落护符
				amu_x = false
				self:DropItem(v, true, true)
			end
			if amu_diao and rev_x and v and v.prefab == "reviver" then --掉落心脏
				rev_x = false
				self:DropItem(v, true, true)
			end
		end

		for k=1, self.maxslots do --随机掉落身体上的物品
			if k~=1 and k > math.random(R_d, R_diao) then
				return false
			end
			if v then
				self:DropItem(v, true, true)
			end
		end

		for k=1, self.maxslots do --计算空格数量
			if v == nil then
				nillots = nillots + 1
			end
		end
		if nillots == 0 then --掉落身体上一格的物品，为了能够使用心脏复活
			local v = self.itemslots[1] --math.random(1, self.maxslots)
			if v then
				self:DropItem(v, true, true)
			end
		end
	end

	function Inventory:PlayerSiWang(ondeath)
		for k, v in pairs(self.equipslots) do
			if v:HasTag("backpack") and v.components.container then
				v.components.container:DropSuiji(true)
			end
		end
		if zhuang_bei then
			for k, v in pairs(self.equipslots) do
				if not v:HasTag("backpack") then
					self:DropItem(v, true, true)
				end
			end
		end
		self.inst.components.inventory:DropSuiji(true)
	end

	function Inventory:DropEverything(ondeath, keepequip)
		if not inst:HasTag("player") or inst:HasTag("player") and not inst.components.health  --不是玩家或玩家有血则掉落全部物品
		    or inst:HasTag("player") and inst.components.health and inst.components.health.currenthealth > 0 then --兼容换人
			return Inventory:oldDropEverythingFn(ondeath, keepequip)
		else
			return Inventory:PlayerSiWang(ondeath)
		end
	end
end)