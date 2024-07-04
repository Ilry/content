
GLOBAL.setmetatable(env,{__index=function(t,k)return GLOBAL.rawget(GLOBAL,k)end})

local containers = require("containers")
local MAX_STACK_SIZE = TUNING.STACK_SIZE_MEDITEM -- 兼容修改堆叠的mod

local params = {}
local containers_widgetsetup_base = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
	local t = params[prefab or container.inst.prefab]
	if t ~= nil then
		for k, v in pairs(t) do
			container[k] = v
		end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
	else
		containers_widgetsetup_base(container, prefab, data, ...)
	end
end

local iaipk = {
	widget =
	{
		slotpos = {},
		animbank = "ui_chester_shadow_3x4",
		animbuild = "ui_chester_shadow_3x4",
		pos = Vector3(0, -120, 0),
		side_align_tip = 0,
		buttoninfo =
		{
			text = "交易",
			position = Vector3(0, -170, 0),
		}
	},
	type = "iaipk",
}
for y = 2.5, -0.5, -1 do
	for x = 0, 2 do
		table.insert(iaipk.widget.slotpos, Vector3(75*x-75*2+75, 75*y-75*2+75,0))
	end
end

params.iaipk = iaipk

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

local function MakeGiftTable(fullslotnum, restnum, maxstack)
	local prefab = "goldnugget"
	local t = {}
	if fullslotnum > 0 then
		for i=1, fullslotnum do
			table.insert(t, {prefab = prefab, count = maxstack})
		end
	end
	if fullslotnum < 4 then
		if restnum > 0 then
			table.insert(t, {prefab = prefab, count = restnum})
		end
	end
	return t
end

local function MakeGift(t)
	local items = {}
	for i=1, #t do
		local myitem = SpawnPrefab(t[i].prefab)
		if t[i].count > 1 then
			myitem.components.stackable:SetStackSize(t[i].count)
		end
		table.insert(items, myitem)
	end

	local gift = SpawnPrefab("gift")
	gift.components.unwrappable:WrapItems(items)
	for i, v in ipairs(items) do
		v:Remove()
	end
	return gift
end

local function bfn(player, inst)
	if TheWorld.state.isnight then player.components.talker:Say("现在是睡觉时间！") return end
	local item
	local extra_item = {}
	local num = 0
	for i=1,12 do
		item = inst.components.container:GetItemInSlot(i)
		local stack = 1
		if item ~= nil then
			local gold = 0
			if item.components.edible and item.components.edible.foodtype == FOODTYPE.MEAT then
				gold = 1
			end
			if item.components.tradable and item.components.tradable.goldvalue > 0 then
				gold = item.components.tradable.goldvalue
			end
			if gold > 0 then
				if item.components.stackable then
					stack = item.components.stackable:StackSize()
				end
				num = num + stack * gold
				inst.components.container:ConsumeByName(item.prefab, stack)
			end
			-- 兼容棋子交换给图纸
			if item.components.tradable and item.components.tradable.tradefor ~= nil then
				local chess_stack = 1
				if item.components.stackable then
					chess_stack = item.components.stackable:StackSize()
				end
				for _,v in pairs(item.components.tradable.tradefor) do
					for j=1,chess_stack do
						table.insert(extra_item, v)
					end
				end
			end
		end
	end
	local item
	
	local maxstack = MAX_STACK_SIZE or 20 --20
	local maxpack = maxstack * 4 --80
	local fullpacknum = math.floor(num / maxpack) -- 满包数
	local restpackitemnum = num % maxpack -- 剩余非满包内容物总数
	local restpackfullslotnum = math.floor(restpackitemnum / maxstack) -- 剩余非满包满堆叠格子数
	local restpackrestnum = restpackitemnum % maxstack -- 剩余非满包剩余物品数
	-- 生成满包
	if fullpacknum > 0 then
		for i=1, fullpacknum do
			item = MakeGift(MakeGiftTable(4, 0, maxstack))
			if item then inst.components.container:GiveItem(item) end
		end
	end
	-- 生成剩余包
	if restpackitemnum > 0 then
		item = MakeGift(MakeGiftTable(restpackfullslotnum, restpackrestnum, maxstack))
		if item then inst.components.container:GiveItem(item) end
	end
	-- 生成棋子图纸
	for _,v in pairs(extra_item) do
		local chess = SpawnPrefab(v)
		inst.components.container:GiveItem(chess)
	end
	--[[
		local str = 
			"\n"..
			"总金子数："..num.."\n"..
			"最大堆叠："..maxstack.."\n"..
			"满包数  ："..fullpacknum.."\n"..
			"剩余总数："..restpackitemnum.."\n"..
			"剩余满格："..restpackfullslotnum.."\n"..
			"剩余剩余："..restpackrestnum.."\n"
		print(str)
	]]
	if item or #extra_item > 0 then
		player.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	end
end

function params.iaipk.widget.buttoninfo.fn(inst, doer)
	if TheWorld.ismastersim then
		bfn(doer, inst)
	else
		SendModRPCToServer(MOD_RPC["iaipk"]["iaipk"], inst)
	end
end

local function pk(inst)
	if not TheWorld.ismastersim then
		-- inst:DoTaskInTime(0, function()
			-- if inst.replica then
				-- if inst.replica.container then
					-- inst.replica.container:WidgetSetup("iaipk")
				-- end
			-- end
		-- end)
		inst.OnEntityReplicated = function(inst)
			inst.replica.container:WidgetSetup("iaipk")
		end
		return inst
	end
	if TheWorld.ismastersim then
		local temp = SpawnPrefab("goldnugget")
		if temp then
			if temp.components.stackable then
				MAX_STACK_SIZE = temp.components.stackable.maxsize
			end
			temp:Remove()
		end
		if not inst.components.container then
			inst:AddComponent("container")
			inst.components.container:WidgetSetup("iaipk")
		end
	end
end

AddModRPCHandler("iaipk", "iaipk", bfn)
AddPrefabPostInit("pigking", pk)
