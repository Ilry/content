AddPrefab("dragonfurnace_projectile")

AddEffect("dragonfurnace_smoke_fx",
{
	bank = "lavaarena_creature_teleport_smoke_fx",
	build = "lavaarena_creature_teleport_smoke_fx",
	anim = function() return "smoke_" .. math.random(2) end,
	sound = "dontstarve_DLC001/creatures/dragonfly/land",
	fn = function(inst)
		local scale = inst.AnimState:IsCurrentAnimation("smoke_1") and 0.75 or 0.65
		inst.AnimState:SetScale(scale, scale)
		inst.SoundEmitter:OverrideVolumeMultiplier(0.5)
	end,
})

local function ButtonValidFn(inst)
	local canburn = nil
	if inst.replica.container ~= nil then
		for slot, item in pairs(inst.replica.container:GetItems()) do
			canburn = canburn or not (item:HasTag("cookable") or item:HasTag("heatrock"))
		end

		if ThePlayer ~= nil then
			local widget = Tykvesh.Browse(ThePlayer, "HUD", "controls", "containers", inst)
			if widget ~= nil then
				widget.bganim:SetScale(1, 0.94)
				widget.bganim:SetPosition(0, -17)
				if canburn then
					widget.button.image:SetTint(1, 0.5, 0.5, 1)
				else
					widget.button.image:SetTint(1, 1, 1, 1)
				end
			elseif not TheWorld.ismastersim or inst.replica.container:IsOpenedBy(ThePlayer) then
				StartThread(ButtonValidFn, inst.GUID, inst)
			end
		end
	end
	return canburn ~= nil
end

AddContainer("dragonflyfurnace",
{
	type = "cooker",

	widget =
	{
		pos = Vector3(200, 0),
		slotpos = { Vector3(0, 72), Vector3(0, 0), Vector3(0, -72) },
		side_align_tip = 100,
		animbank = "ui_lamp_1x4",
		animbuild = "ui_lamp_1x4",
		buttoninfo =
		{
			text = STRINGS.ACTIONS.LIGHT,
			position = Vector3(0, -129),
			validfn = ButtonValidFn,
			fn = function(inst, doer)
				if inst.components.container ~= nil then
					inst.components.container:Close(doer)
					inst.components.container:Close()
				elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
					SendRPCToServer(RPC.DoWidgetButtonAction, nil, inst)
				end
			end,
		}
	},

	itemtestfn = function(container, item, slot)
		return not (item:HasTag("irreplaceable") or item:HasTag("ashes"))
	end,
})

Tykvesh.Sequence(ACTIONS.STORE, "strfn", function(str, act)
	if str == nil
		and (act.target ~= nil and act.target:HasTag("furnace"))
		and (act.invobject ~= nil and act.invobject:HasTag("cookable")) then

		return "COOK"
	end
end)

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
if not TheNet:GetIsServer() then return end --\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

AddPrefab("fireover")

if AnimState.GetBloomEffectHandle == nil then
	local _bloomeffecthandles = setmetatable({}, { __mode = "k" })

	Tykvesh.Parallel(AnimState, "SetBloomEffectHandle", function(self, bloom)
		_bloomeffecthandles[self] = bloom
	end)

	Tykvesh.Parallel(AnimState, "ClearBloomEffectHandle", function(self)
		_bloomeffecthandles[self] = nil
	end)

	function AnimState:GetBloomEffectHandle()
		return _bloomeffecthandles[self]
	end
end

local CHARCOAL_SOURCES = { "log", "livinglog", "driftwood_log" }

local function MakeCharcoalSource(inst)
	inst:AddTag("charcoalsource")
end

for index, prefab in ipairs(CHARCOAL_SOURCES) do
	AddPrefabPostInit(prefab, MakeCharcoalSource)
end

local VOMIT_DELAY = 10 * FRAMES

local function OnOpen(inst)
	inst:RemoveComponent("cooker")

	inst._lightrad = inst.Light:GetRadius()
	inst.Light:SetRadius(0.85)
	inst.AnimState:PlayAnimation("idle", true)
	inst.SoundEmitter:KillSound("loop")
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/vomitrumble", "rumble", 0.75)
end

local function DropLoot(inst, loot, target)
	local hasloot, hasproduct, pt

	for item, fn in pairs(loot) do
		if type(fn) == "function" and item:IsValid() then
			pcall(fn)
		end
	end

	for item in pairs(loot) do
		if item:IsValid() then
			hasloot = true
			if not item:HasTag("ashes") then
				hasproduct = true
				break
			end
		end
	end

	if hasloot then
		if hasproduct and inst ~= target and target:IsValid() then
			pt = target:GetPosition()
		else
			local theta = GetRandomMinMax(0, 2 * math.pi)
			local dist = GetRandomMinMax(2, 3)
			pt = inst:GetPosition() + Point(math.cos(theta) * dist, 0, math.sin(theta) * dist)
		end
		SpawnPrefab("dragonflyfurnace_projectile"):LaunchProjectile(loot, pt, inst, target)
	end
end

local function AddHiddenChild(inst, child, target)
	if target ~= nil then
		child.Network:SetClassifiedTarget(target)
	end
	if inst ~= child.parent then
		inst:AddChild(child)
	end
	if not child:IsInLimbo() then
		child:ForceOutOfLimbo()
		child:RemoveFromScene()
	end
end

local function OnClose(inst, doer)
	doer = doer or inst

	local loot = {}

	for slot, item in pairs(inst.components.container.slots) do
		inst.components.container:RemoveItemBySlot(slot)

		local product, vomitfn
		local pcallqueue = {}

		if item.components.cookable ~= nil then
			product = FunctionOrValue(item.components.cookable.product, item, inst, doer)
			if item.components.cookable.oncooked ~= nil then
				table.insert(pcallqueue, function() item.components.cookable.oncooked(item, inst, doer) end)
			end
		elseif item.components.temperature == nil then
			if item.components.explosive == nil then
				product = item:HasTag("charcoalsource") and "charcoal" or "ash"
			end
			if item.components.burnable ~= nil then
				item.components.burnable.burning = true
				table.insert(pcallqueue, function() item:PushEvent("onignite", { doer = doer }) end)
				if item.components.burnable.onignite ~= nil then
					table.insert(pcallqueue, function() item.components.burnable.onignite(item, inst, doer) end)
				end
				if item.components.burnable.onburnt ~= DefaultBurntFn then
					vomitfn = function() item.components.burnable:LongUpdate(0) end
				end
			end
		end

		if product ~= nil then
			product = SpawnPrefab(product)
			if product ~= nil then
				if product.components.perishable ~= nil and item.components.perishable ~= nil and not item:HasTag("smallcreature") then
					product.components.perishable:SetPercent(1 - (1 - item.components.perishable:GetPercent()) * 0.5)
				end
				if product.components.stackable ~= nil and item.components.stackable ~= nil then
					local stacksize = item.components.stackable:StackSize() * product.components.stackable:StackSize()
					product.components.stackable:SetStackSize(math.min(product.components.stackable.maxsize, stacksize))
				end
			end
		end

		if next(pcallqueue) ~= nil then
			item:DoTaskInTime(0, function()
				for i, fn in ipairs(pcallqueue) do
					if not pcall(fn) or not item:IsValid() then
						break
					end
				end
			end)
			if vomitfn == nil and product ~= nil then
				item:DoTaskInTime(VOMIT_DELAY, item.Remove)
			end
			AddHiddenChild(inst, item, doer)
		elseif vomitfn ~= nil then
			AddHiddenChild(inst, item, doer)
		elseif product ~= nil then
			item:Remove()
		end

		local item = product or item
		if item.components.inventoryitem ~= nil then
			item.components.inventoryitem:InheritMoisture(0, false)
		end
		if item.components.temperature ~= nil then
			item.components.temperature:SetTemperature(item.components.temperature:GetMax())
		end
		AddHiddenChild(inst, item)

		loot[item] = vomitfn or false
	end

	if inst.components.cooker == nil then
		inst:AddComponent("cooker")
	end
	if inst._lightrad ~= nil then
		inst.Light:SetRadius(inst._lightrad)
	end
	inst.AnimState:PlayAnimation("hi_pre")
	inst.AnimState:PushAnimation("hi")
	inst.SoundEmitter:KillSound("rumble")
	inst.SoundEmitter:PlaySound("dontstarve/common/together/dragonfly_furnace/fire_LP", "loop")

	if next(loot) == nil then
		inst.SoundEmitter:PlaySound("dontstarve/common/together/dragonfly_furnace/light")
	else
		inst.SoundEmitter:PlaySound("dontstarve_DLC001/creatures/dragonfly/vomit")

		local fx = inst:SpawnChild("firesplash_fx")
		fx.Transform:SetScale(0.5, 0.5, 0.5)
		fx.Transform:SetPosition(0, 0.1, 0)

		inst:DoTaskInTime(VOMIT_DELAY, DropLoot, loot, doer)
	end
end

local function GetStatus(inst, observer)
	return not inst.components.container:IsOpen() and "HIGH" or nil
end

local function GetHeat(inst, observer)
	local heat = inst.components.heater.heat
	if inst.components.container:IsOpen() then
		heat = heat / 2
	end
	if observer ~= nil and observer:HasTag("player") then
		heat = heat * Clamp(1 - TheWorld.state.temperature / TUNING.OVERHEAT_TEMP, 0.5, 1)
	end
	return heat
end

local function OnHit(inst, data)
	if inst.components.container ~= nil then
		inst.components.container:DropEverything()
		inst.components.container:Close()
	end
end

local function OnLoad(inst, data)
	if not inst.components.container:IsEmpty() then
		OnClose(inst)
	end
end

AddPrefabPostInit("dragonflyfurnace", function(inst)
	inst:AddTag("furnace")

	if inst.components.container == nil then
		inst:AddComponent("container")
		inst.components.container:WidgetSetup("dragonflyfurnace")
	end
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose

	inst.components.inspectable.getstatus = GetStatus
	inst.components.heater.heatfn = GetHeat

	inst:ListenForEvent("worked", OnHit)

	Tykvesh.Parallel(inst, "OnLoad", OnLoad)
end)