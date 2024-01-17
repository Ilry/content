
local name = "Smart Chest"
local modname = KnownModIndex:GetModActualName(name)
local minisigndist = GetModConfigData("minisign_dist", modname)
local iscollectone = GetModConfigData("iscollectone", modname)
local showbundle  = TUNING.HUAMINISIGN_BUNDLE

local LXautocollectitems = Class(function(self, inst)
	self.inst = inst
	self.iscollect = false -- 判断是否开始收集
	self.items = {}
	self.x = nil
	self.y = nil
	self.z = nil
	self.iscollectone = false
	self.minisigndist = 1.5
	self.iscollectall = false -- 收集所有物品
	self.iscollectforchestslot = false -- 收集箱子里存在的物品
	inst:ListenForEvent("onclose", function()
		inst:DoTaskInTime(0.1,function (inst2) self:SetItems()	end)
	end)
	inst:DoTaskInTime(0.15, function (inst2) self:SetItems()	end)
end,
nil,
nil)

--[[
local function getMinisign(inst){
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = _G.TheSim:FindEntities(x, y, z, minisigndist, { "sign", "drawable" }, { "INLIMBO"}) --包括所有木牌
	--筛选画好的
	for i, v in ipairs(ents) do
		if v and v.prefab == "minisign" and v.components and v.components.drawable and v.components.drawable.candraw == false then
			return v
		end
	end
	return nil
}
]]--


-- 功能1：设置要收集的物品。

function LXautocollectitems:SetItemsForNoCollect()
	-- 对于收集所有物品的情况，添加反选功能。即附近其他的带图案小木牌表示不收集的物品。
	self.itemsNoCollect = {}
	-- 获取周围的小木牌
	local x, y, z = self.inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, self.minisigndist, { "sign" }, { "INLIMBO"}) --包括所有木牌
	-- print("#minisign = " .. #ents)
	-- 筛选画好的,并填入items
	for i, v in ipairs(ents) do
		if v and v.prefab == "minisign" and v._imagename ~= nil and v._imagename:value() ~= "" then
			-- table.insert(self.items, v._imagename:value())
			if not (#v.LX_collect_item:value() > 0 and v.LX_collect_item:value() == "minisign_drawn") then
				table.insert(self.itemsNoCollect, (v.LX_collect_item and (#v.LX_collect_item:value() > 0)) and v.LX_collect_item:value() or v._imagename:value() )
			end
		end
	end
end

function LXautocollectitems:SetItems()
	-- print("[LXautocollectitems]SetItems enter")
	if self.inst and not self.inst:HasTag("INLIMBO") and self.inst.components and self.inst.components.container then
		-- 兼容smart minisign
		if self.inst.components.smart_minisign and self.inst.components.smart_minisign.sign then
			local sign = self.inst.components.smart_minisign.sign
			local container = self.inst.components.container
			for i = 1, container:GetNumSlots() do
				local item = container:GetItemInSlot(i)
				local tname = item ~= nil and (item.prefab) or ""
				if item ~= nil and item.replica.inventoryitem ~= nil  then
					--for bundle
					if showbundle and item.components.unwrappable ~= nil and item.components.unwrappable.itemdata then
						for i, v in ipairs(item.components.unwrappable.itemdata) do
							if  v  then
								local copy = SpawnPrefab(v.prefab)
								if copy then 
									tname = copy ~= nil and (copy.prefab) or ""
									copy:Remove()
									break
								end
							end
						end
					end
					sign.LX_collect_item:set(tname)
					-- print("[LXautocollectitems]SetItems tname="	.. tname)
					break
				end
				if i == container:GetNumSlots() and item == nil then
					sign.LX_collect_item:set("")
					-- print("[LXautocollectitems]SetItems tname=\"\"")
				end
			end
		end
		self.items = {} -- 清空当前的设置
		-- 获取周围的小木牌
		local x, y, z = self.inst.Transform:GetWorldPosition()
		-- print("[LXautocollectitems]SetItems x=" .. x .. " y=" .. y .. " z=" .. z)
		y = 0 -- 丢弃箱子时，箱子在空中
		local ents = TheSim:FindEntities(x, y, z, self.minisigndist, { "sign" }, { "INLIMBO"}) --包括所有木牌
		-- print("#minisign = " .. #ents)
		-- 筛选画好的,并填入items
		for i, v in ipairs(ents) do
			if v and v.prefab == "minisign" and ((v.LX_collect_item and (#v.LX_collect_item:value() > 0)) or (v._imagename ~= nil and v._imagename:value() ~= "")) then
				-- print("\t" .. ((v.LX_collect_item and (#v.LX_collect_item > 0)) and v.LX_collect_item or v._imagename:value()))
				table.insert(self.items, (v.LX_collect_item and (#v.LX_collect_item:value() > 0)) and v.LX_collect_item:value() or v._imagename:value() )
				-- 对于"minisign_drawn"添加特殊处理。使木牌1上画的是画过东西的木牌时，这个木牌1对应的箱子收集所有物品
				if self.iscollectall and v.LX_collect_item and #v.LX_collect_item:value() > 0 and v.LX_collect_item:value() == self.collectAllPrefab then
					self.items = {self.collectAllPrefab}
					self:SetItemsForNoCollect()
					break
				end
				if self.iscollectforchestslot and v.LX_collect_item and #v.LX_collect_item:value() > 0 and v.LX_collect_item:value() == self.collectChestSlotPrefab then
					self.items = {self.collectChestSlotPrefab}
					self:SetItemsForNoCollect()
					break
				end
				if self.iscollectone == 1 then
					break
				end
			end
		end

		if #self.items > 0 then
			self.iscollect = true
		else
			self.iscollect = false
		end
		
		for k,v in pairs(self.items) do
			-- print("\t"..tostring(k).."="..tostring(v))
		end
	end
	-- print("[LXautocollectitems]SetItems exit")
end

function LXautocollectitems:ClearItems()
	-- print("[LXautocollectitems]ClearItems")
	self.items = {}
	self.iscollect = false
end

-- 功能2：收集物品
-- 对于收集所有物品的情况，添加反选功能。即附近其他的带图案小木牌表示不收集的物品。
function LXautocollectitems:isCanCollectForNoCollect(itemName, itemPrefab)
	-- itemsNoCollest 用于收集全部物品时，排除不收集的物品
	if self.itemsNoCollect == nil then
		return true
	end
	for k, v in pairs(self.itemsNoCollect) do
		-- print("[SmartChest] isCanCollect minisign_drawn nocollect=" .. v)
		if v == itemName or v == itemPrefab then
			return false
		end
	end
	return true
end

function LXautocollectitems:isCanCollectForChestSlot(itemName, itemPrefab)
	-- 遍历箱子中的物品，判断是否相同
	for k,v in pairs(self.inst.components.container.slots) do
		if v ~= nil and v.prefab == itemPrefab then
			return true
		end
	end
	return false
end

-- 判断物品是否在items中
function LXautocollectitems:isCanCollect(itemName, itemPrefab)
	-- print("[isCanCollect]")
	if self.items == nil then
		return false
	end
	for k, v in pairs(self.items) do
		-- print("[isCanCollect] v=" .. v)
		-- 对于"minisign_drawn"添加特殊处理。使木牌1上画的是画过东西的木牌时，这个木牌1对应的箱子收集所有物品
		if self.iscollectall and v == self.collectAllPrefab then
			-- print("[SmartChest] isCanCollect minisign_drawn")
			return self:isCanCollectForNoCollect(itemName, itemPrefab)
		end
		if self.iscollectforchestslot and v == self.collectChestSlotPrefab then
			-- print("[SmartChest] isCanCollect opalpreciousgem")
			return self:isCanCollectForNoCollect(itemName, itemPrefab)
				and self:isCanCollectForChestSlot(itemName, itemPrefab)
		end
        if v == itemName or v == itemPrefab then
            return true
        end
    end
    return false
end

-- 把物品移入箱子中，并返回剩余的
local function moveToContainer(inst, item)
	 -- inst 箱子.components.container
	local slot = nil
	local src_pos = nil
	local drop_on_fail = nil
	if item == nil or not item:IsValid() then
		-- print("[moveToContainer]85")
        return item
    elseif item.components.inventoryitem ~= nil and inst:CanTakeItemInSlot(item, slot) then
        if slot == nil then
            slot = inst:GetSpecificSlotForItem(item)
        end

        --try to burn off stacks if we're just dumping it in there
        if item.components.stackable ~= nil and inst.acceptsstacks then
            --Added this for when we want to dump a stack back into a
            --specific spot (e.g. moving half a stack failed, so we
            --need to dump the leftovers back into the original stack)
            if slot ~= nil and slot <= inst.numslots then
                local other_item = inst.slots[slot]
                if other_item ~= nil and other_item.prefab == item.prefab and other_item.skinname == item.skinname and not other_item.components.stackable:IsFull() then
                    if inst.inst.components.inventoryitem ~= nil and inst.inst.components.inventoryitem.owner ~= nil then
                        inst.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = slot })
                    end

					if other_item and other_item:IsValid() and other_item.replica and other_item.replica.inventoryitem and other_item.replica.inventoryitem.classified then
                    	item = other_item.components.stackable:Put(item, src_pos)
					end
                    if item == nil then
						-- 修改了原始GiveItem的返回值
                        return item
                    end

                    slot = inst:GetSpecificSlotForItem(item)
                end
            end

            if slot == nil then
                for k = 1, inst.numslots do
                    local other_item = inst.slots[k]
                    if other_item and other_item.prefab == item.prefab and other_item.skinname == item.skinname and not other_item.components.stackable:IsFull() then
                        if inst.inst.components.inventoryitem ~= nil and inst.inst.components.inventoryitem.owner ~= nil then
                            inst.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = k })
                        end

						if other_item and other_item:IsValid() and other_item.replica and other_item.replica.inventoryitem and other_item.replica.inventoryitem.classified then
                        	item = other_item.components.stackable:Put(item, src_pos)
						end
                        if item == nil then
							-- 修改了原始GiveItem的返回值
                            return item
                        end
                    end
                end
            end
        end

        local in_slot = nil
        if slot ~= nil and slot <= inst.numslots and not inst.slots[slot] then
            in_slot = slot
        elseif not inst.usespecificslotsforitems and inst.numslots > 0 then
            for i = 1, inst.numslots do
                if not inst.slots[i] then
                    in_slot = i
                    break
                end
            end
        end

        if in_slot then
            --weird case where we are trying to force a stack into a non-stacking container. this should probably have been handled earlier, but this is a failsafe
            if not inst.acceptsstacks and item.components.stackable and item.components.stackable:StackSize() > 1 then
                local t = nil
				if item.components.stackable.stacksize == 1 then
					t = item
					item = nil
				elseif item.components.stackable.stacksize > 1 then
					t = item.components.stackable:Get()
					item.components.stackable:SetStackSize(item.components.stackable.stacksize - 1)
				else
					-- print("[moveToContainer]267")
					return nil
				end
				--item = item.components.stackable:Get()
                inst.slots[in_slot] = t
                t.components.inventoryitem:OnPutInInventory(inst.inst)
                inst.inst:PushEvent("itemget", { slot = in_slot, item = t, src_pos = src_pos, })
				-- print("[moveToContainer]274")
                return item
            end

            inst.slots[in_slot] = item
            item.components.inventoryitem:OnPutInInventory(inst.inst)
            inst.inst:PushEvent("itemget", { slot = in_slot, item = item, src_pos = src_pos })

            if not inst.ignoresound and inst.inst.components.inventoryitem ~= nil and inst.inst.components.inventoryitem.owner ~= nil then
                inst.inst.components.inventoryitem.owner:PushEvent("gotnewitem", { item = item, slot = in_slot })
            end
			-- print("[moveToContainer]285")
            return nil
        end
    end

    --default to true if nil
    --[[if drop_on_fail ~= false then
        item.Transform:SetPosition(inst.inst.Transform:GetWorldPosition())
        if item.components.inventoryitem ~= nil then
            item.components.inventoryitem:OnDropped(true)
        end
    end]]--
	-- print("[moveToContainer]297")
    return item
end

-- 收集物品
function LXautocollectitems:onCollectItems(item, itemname)
	-- print("[onCollectItems] enter")
	if item == nil or (not item:IsValid()) then -- 判断是否有剩余
		-- print("item == nil")
        return nil
    end
	if (self.inst.components and self.inst.components.burnable ~= nil and self.inst.components.burnable:IsBurning()) or self.inst:HasTag("burnt") then -- 正在燃烧和燃烧结束不能收集
		return item
	end
	if self:isCanCollect(itemname, item.prefab) then --判断可以收集
		-- print("isCanCollect OK")
		-- print("item GUID=" .. item.GUID)
		-- 因为这个现成的GiveItem没有返回值，所以要重写
		-- self.inst.components.container:GiveItem(item)
		local snumb
		if item and item.components and item.components.stackable then
			snumb = item.components.stackable.stacksize
		end
		local x, y, z = item.Transform:GetWorldPosition()
		item = moveToContainer(self.inst.components.container, item)
		-- if item and item.components and item.components.stackable then
		-- 	-- print("" .. item.prefab .. " number is " .. item.components.stackable.stacksize)
		-- else
		-- 	-- print("item = 0")
		-- end
		if item == nil then
			local collectanim = SpawnPrefab("sand_puff") --消失的动画
			collectanim.Transform:SetPosition(x, y, z)
			collectanim.Transform:SetScale(1,1,1)
		else
			if item and item.components and item.components.stackable and item.components.stackable.stacksize < snumb then
				local collectanim = SpawnPrefab("sand_puff") --消失的动画
				collectanim.Transform:SetPosition(x, y, z)
				collectanim.Transform:SetScale(1,1,1)
			end
		end
		-- x, y, z  = self.inst.Transform:GetWorldPosition()
		-- print("chest postion x=" .. x .. " y=" .. y .. " z=" .. z)
		-- print("isCanCollect out")
	end
	-- print("[onCollectItems] exit")
	return item
end


-- 保存和加载
function LXautocollectitems:OnSave()
	local data = {
		iscollect = self.iscollect,
		items = self.items
	}
	return data
end

function LXautocollectitems:OnLoad(data)
	self.iscollect = data.iscollect
	self.items = data.items
end


return LXautocollectitems