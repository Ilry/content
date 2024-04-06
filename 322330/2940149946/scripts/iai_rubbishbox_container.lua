
local lan = {
	chs = true,
	cht = true,
	zh = true,
	zht = true,
}
local chs = lan[LanguageTranslator.defaultlang]

local onlyadmin = TUNING.IAI_RUBBISHBOX_ADMIN == "admin"

local containers = require("containers")
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

local baits = {
	powcake = true,
	pigskin = true,
	mandrake = true,
	winter_food4 = true,
	spoiled_food = true,
}

local walls = {
	fossil_stalker = true,
	endtable = true,
}

local blacklist = {
	bullkelp_beachedroot = true,
}

local onlysearchlist = {
	fireflies = true,
}

local function NearWall(inst)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 3)
	for _,v in ipairs(ents) do
		if v and v:IsValid() and (v:HasTag("wall") or walls[v.prefab]) then
			return true
		end
	end
	return false
end

local function IsSeed(inst)
	return inst.prefab ~= nil and (inst.prefab == "seeds" or string.find(inst.prefab, "_seeds"))
end

local function NearTrap(inst)
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 0.1)
	for _,v in ipairs(ents) do
		if v and v.prefab == "birdtrap" then
			return true
		end
	end
	return false
end

require("prefabs/winter_ornaments")
local similars = {
	-- 玩具
	toys = {
		antliontrinket = true,
		yotb_beefalo_doll_war = true,
		yotb_beefalo_doll_doll = true,
		yotb_beefalo_doll_festive = true,
		yotb_beefalo_doll_nature = true,
		yotb_beefalo_doll_robot = true,
		yotb_beefalo_doll_ice = true,
		yotb_beefalo_doll_formal = true,
		yotb_beefalo_doll_victorian = true,
		yotb_beefalo_doll_beast = true,
	},
	-- 圣诞节装饰
	toys_xmas = {
		winter_ornament_boss_malbatross = true,
	},
	-- 万圣节装饰
	toys_hw = {},
	-- 圣诞节甜点
	sweet_xmas = {},
	-- 万圣节甜点
	sweet_hw = {},
	-- 鹿角
	deer_antler = {
		deer_antler = true,
		deer_antler1 = true,
		deer_antler2 = true,
		deer_antler3 = true,
	},
	-- 红包
	redpouch = {
		redpouch = true,
		redpouch_yotp = true,
		redpouch_yotc = true,
		redpouch_yotb = true,
		redpouch_yot_catcoon = true,
		redpouch_yotr = true,
	},
}
for i=1,NUM_TRINKETS do
	similars.toys["trinket_"..i] = true
end
for _,v in pairs(GetAllWinterOrnamentPrefabs()) do
	similars.toys_xmas[v] = true
end
for i=1,NUM_HALLOWEEN_ORNAMENTS do
	similars.toys_hw["halloween_ornament_"..i] = true
end
for i=1,NUM_WINTERFOOD do
	similars.sweet_xmas["winter_food"..i] = true
end
for i=1,NUM_HALLOWEENCANDY do
	similars.sweet_hw["halloweencandy_"..i] = true
end

local function HasSimilarPrefab(inst)
	for name,data in pairs(similars) do
		if data[inst.prefab] then
			return true
		end
	end
	return false
end

local function GetSimilarPrefab(inst)
	for name,data in pairs(similars) do
		if data[inst.prefab] then
			return data
		end
	end
	return {[inst.prefab] = true}
end

local function PickType(c)
	if (TUNING.IAI_RUBBISHBOX_PICK == "yes" and c)
	or (TUNING.IAI_RUBBISHBOX_PICK == "no" and not c)
	or (TUNING.IAI_RUBBISHBOX_PICK == "any") then
		return true
	end
	return false
end

local function GetPrefabName(inst)
	return (inst.name ~= nil and inst.name ~= "MISSING NAME" and inst.name) or (inst.nameoverride ~= nil and STRINGS.NAMES[string.upper(inst.nameoverride)] or inst.prefab)
end

local function ContainerIsFull(con)
	local items = 0
	
	for k,v in pairs(con.slots) do
		if k <= 25 then
			items = items + 1
		end
	end
	
	return items >= 25
end

local function ContainerIsEmpty(con)
	for k,v in pairs(con.slots) do
		if k <= 25 then
			return false
		end
	end
	
	return true
end

local function ContainerDestroyContents(con)
	for k=1,25 do
		local item = con:RemoveItemBySlot(k)
		if item then
			item:Remove()
		end
	end
end

local function ContainerIsFullWithStack(con, item)
	if item.components.stackable then
		for k,v in pairs(con.slots) do
			if k <= 25 then
				if v.prefab == item.prefab and not v.components.stackable:IsFull() then
					return false
				end
			end
		end
	end
	
	return ContainerIsFull(con)
end

local function GetOnlyCollectItem(con)
	local item, item_prefab = {}, {}
	
	for i=1,4 do
		item[i] = con.slots[i+25]
		
		if item[i] then
			item_prefab[item[i].prefab] = true
			
			if HasSimilarPrefab(item[i]) then
				local similars = GetSimilarPrefab(item[i])
				
				for k,_ in pairs(similars) do
					item_prefab[k] = true
				end
				
				similars = nil
			end
		end
	end
	
	return item, item_prefab
end

local function GetDontCollectItem(con)
	local item, item_prefab = {}, {}
	
	for i=1,4 do
		item[i] = con.slots[i+25+4]
		
		if item[i] then
			item_prefab[item[i].prefab] = true
			
			if HasSimilarPrefab(item[i]) then
				local similars = GetSimilarPrefab(item[i])
				
				for k,_ in pairs(similars) do
					item_prefab[k] = true
				end
				
				similars = nil
			end
		end
	end
	
	return item, item_prefab
end

local function getstack(inst)
	return inst.components.stackable and inst.components.stackable:StackSize() or 1
end

local function GetDestroySpeech(con)
	local rubbish_list = {}
	
	for k,v in pairs(con.slots) do
		if k <= 25 then
			if not rubbish_list[v.prefab] then
				rubbish_list[v.prefab] = {name = GetPrefabName(v), count = getstack(v)}
			else
				rubbish_list[v.prefab].count = rubbish_list[v.prefab].count + getstack(v)
			end
		end
	end
	
	local speech = ""
	local index = 0
	for prefab,data in pairs(rubbish_list) do
		speech = speech..(index % 3 == 0 and "\n" or "")..string.format("%5d", data.count)..string.format(" %-20s", data.name)
		
		index = index + 1
	end
	
	index = nil
	rubbish_list = nil
	
	return speech
end

local function buttonfn(doer, inst)
	if onlyadmin and not (doer and doer.Network:IsServerAdmin()) then
		doer.components.talker:Say(chs and "我没有权限使用！" or "I have no permission to use it!")
	end
	
	local recycle = nil
	local p = doer
	local con = inst.components.container
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, TUNING.IAI_RUBBISHBOX_DISTANCE, nil, {"INLIMBO", "NOCLICK", "FX", "player", "nonpotatable", "irreplaceable", "catchable", "fire", "flower", "trap", "mine", "cage", "bookshelfed", "doydoy", "light"})
	local yesitem, yesitemprefab = GetOnlyCollectItem(con)
	local noitem, noitemprefab = GetDontCollectItem(con)
	local hasyesitem = next(yesitemprefab) ~= nil
	
	for i=1,4 do
		con.slots[i+25] = nil
		con.slots[i+25+4] = nil
	end
	
	for _,v in ipairs(ents) do
		if v and v:IsValid() and v.prefab and v.components.inventoryitem then
			if not noitemprefab[v.prefab] then
				if hasyesitem and yesitemprefab[v.prefab] or not hasyesitem then
					if not blacklist[v.prefab] and
					(not v.components.inventoryitem.canbepickedupalive and v.components.inventoryitem.canbepickedup or (onlysearchlist[v.prefab] and yesitemprefab[v.prefab])) and
					v.components.inventoryitem.cangoincontainer and not v.components.inventoryitem:IsHeld() then
						if PickType(v.components.stackable) and not ContainerIsFullWithStack(con, v) then
							if baits[v.prefab] then
								if not NearWall(v) then
									con:GiveItem(v)
									recycle = true
								end
							elseif IsSeed(v) then
								if not NearTrap(v) then
									con:GiveItem(v)
									recycle = true
								end
							else
								con:GiveItem(v)
								recycle = true
							end
						end
					end
				end
			end
		end
	end
	
	for i=1,4 do
		con.slots[i+25] = yesitem[i]
		con.slots[i+25+4] = noitem[i]
	end
	
	if recycle then
		inst.SoundEmitter:PlaySound("dontstarve/creatures/teenbird/grow")
		
		if p then
			p.components.talker:Say(chs and "看看我又回收了什么垃圾" or "See what garbage I recycled")
		end
	else
		if p then
			if ContainerIsFull(con) then
				p.components.talker:Say(chs and "垃圾箱装满了" or "The dustbin is full")
			else
				p.components.talker:Say(chs and "桌面清理完成，干干净净" or "Garbage has been cleared")
			end
		end
	end
	
	recycle, p, con = nil,nil,nil
	x,y,z, ents = nil,nil,nil,nil
	yesitem, yesitemprefab = nil,nil
	noitem, noitemprefab = nil,nil
	hasyesitem = nil
end

local function validfn(inst, doer)
	return not ContainerIsFull(inst.components.container)
end

local function buttonfn_iai_rubbishbox(doer, inst)
	if onlyadmin and not (doer and doer.Network:IsServerAdmin()) then
		doer.components.talker:Say(chs and "我没有权限使用！" or "I have no permission to use it!")
	end
	
	local p = doer
	local con = inst.components.container
	
	if not ContainerIsEmpty(con) then
		SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
		inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
		
		local speech = p and GetPrefabName(p) or ""
		speech = speech..(chs and " 已清理：" or " Deleted: ")..GetDestroySpeech(con)
		TheNet:SystemMessage(speech)
		speech = nil
		
		ContainerDestroyContents(con)
	end
	
	p, con = nil,nil
end

local function validfn_iai_rubbishbox(inst, doer)
	return not ContainerIsEmpty(inst.components.container)
end

local function itemtest(inst, item, slot)
	return not item:HasTag("nonpotatable") and not item:HasTag("irreplaceable")
end

local slots = nil

local iai_rubbishbox = {
	widget = {
		slotpos = {},
		slotbg = {},
		animbank = "ui_chest_3x3",
		animbuild = "iai_ui_chest_5x5_2x2x2",
		pos = Vector3(0, 160, 0),
		side_align_tip = 160,
		buttoninfo = {
			text = chs and "回收" or "Recycle",
			position = Vector3(-80, -230+5, 0),
			-- validfn = validfn,
		},
		buttoninfo_iai_rubbishbox = {
			text = chs and "删除" or "Destroy",
			position = Vector3(80, -230+5, 0),
			-- validfn = validfn_iai_rubbishbox,
		}
	},
	type = "chest",
}

for y = 2,-2,-1 do
	for x = -2,2 do
		table.insert(iai_rubbishbox.widget.slotpos, Vector3(80*x, 80*y, 0))
	end
end

slots = #iai_rubbishbox.widget.slotpos + 1

for y = 0.5,-0.5,-1 do
	for x = -0.5,0.5 do
		table.insert(iai_rubbishbox.widget.slotpos, Vector3(340 + 80*x, 120 + 80*y, 0))
	end
end

for i=slots,#iai_rubbishbox.widget.slotpos do
	iai_rubbishbox.widget.slotbg[i] = {image = "iai_rubbishbox_slotyessearch.tex", atlas = "images/iai_rubbishbox_slotyessearch.xml"}
end

slots = #iai_rubbishbox.widget.slotpos + 1

for y = 0.5,-0.5,-1 do
	for x = -0.5,0.5 do
		table.insert(iai_rubbishbox.widget.slotpos, Vector3(340 + 80*x, -120 + 80*y, 0))
	end
end

for i=slots,#iai_rubbishbox.widget.slotpos do
	iai_rubbishbox.widget.slotbg[i] = {image = "iai_rubbishbox_slotnosearch.tex", atlas = "images/iai_rubbishbox_slotnosearch.xml"}
end

slots = nil

params.iai_rubbishbox = iai_rubbishbox

AddModRPCHandler("iai_rubbishbox", "collect", buttonfn)
AddModRPCHandler("iai_rubbishbox", "destroy", buttonfn_iai_rubbishbox)

params.iai_rubbishbox.widget.buttoninfo.fn = function(inst, doer)
	if TheWorld.ismastersim then
		buttonfn(doer, inst)
	else
		SendModRPCToServer(MOD_RPC["iai_rubbishbox"]["collect"], inst)
	end
end

params.iai_rubbishbox.widget.buttoninfo_iai_rubbishbox.fn = function(inst, doer)
	if TheWorld.ismastersim then
		buttonfn_iai_rubbishbox(doer, inst)
	else
		SendModRPCToServer(MOD_RPC["iai_rubbishbox"]["destroy"], inst)
	end
end

params.iai_rubbishbox.itemtestfn = function(inst, item, slot)
	return itemtest(inst, item, slot)
end

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
