local assets =
{
	Asset("ANIM", "anim/watson_remote.zip"),
	Asset("ANIM", "anim/spell_icons_winona.zip"),
    
    Asset("ATLAS", "images/inventoryimages/watson_remote.xml"),
    Asset("IMAGE", "images/inventoryimages/watson_remote.tex"),
    
    Asset("ATLAS", "images/spell_icons/change_heater_cold.xml"),
	Asset("IMAGE", "images/spell_icons/change_heater_cold.tex"),
    
    Asset("ATLAS", "images/spell_icons/change_heater_hot.xml"),
	Asset("IMAGE", "images/spell_icons/change_heater_hot.tex"),
    
    Asset("ATLAS", "images/spell_icons/change_heater_neutral.xml"),
	Asset("IMAGE", "images/spell_icons/change_heater_neutral.tex"),
    
    Asset("ATLAS", "images/spell_icons/toggle_light_off.xml"),
    Asset("IMAGE", "images/spell_icons/toggle_light_off.tex"),
    
	Asset("ATLAS", "images/spell_icons/toggle_light_on.xml"),
	Asset("IMAGE", "images/spell_icons/toggle_light_on.tex"),
    
  	Asset("ATLAS", "images/spell_icons/toggle_snowball_off.xml"),
	Asset("IMAGE", "images/spell_icons/toggle_snowball_off.tex"),
    
	Asset("ATLAS", "images/spell_icons/toggle_snowball_on.xml"),
	Asset("IMAGE", "images/spell_icons/toggle_snowball_on.tex"),
}

local prefabs = {}

--------------------------------------------------------------------------

local function CastControlRobotSpell(inst)
    local inventory = ThePlayer.replica.inventory
    if inventory ~= nil then
        inventory:CastSpellBookFromInv(inst)
    end
end

local function SetLight_SpellFn(inst, doer)
    return inst.robot:ToggleLight(inst, false) -- return 是為了像官方的一樣、回傳有沒有成功施放「法術」
end

local function SetHeater_SpellFn(inst, doer)
    return inst.robot:ChangeHeaterMode(inst, false)
end

local function SetSnowball_SpellFn(inst, doer)
    return inst.robot:ToggleSnowball(inst, false)
end

--------------------------------------------------------------------------

local ICON_SCALE = .6
local ICON_RADIUS = 50
local SPELLBOOK_RADIUS = 100
local SPELLBOOK_FOCUS_RADIUS = SPELLBOOK_RADIUS + 2

local SPELLS =
{
	["toggle_light_on"] =
    {
		label = STRINGS.WATSON_REMOTE_CONTROL.LIGHT.TURN_ON,
        
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.LIGHT.TURN_ON)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetLight_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/toggle_light_on.xml",
		normal = "toggle_light_on.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
    ["toggle_light_off"] =
	{
		label = STRINGS.WATSON_REMOTE_CONTROL.LIGHT.TURN_OFF,
        
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.LIGHT.TURN_OFF)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetLight_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/toggle_light_off.xml",
		normal = "toggle_light_off.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
    --------------------------------------------------------------------------
    
    ["change_heater_hot"] =
    {
		label = STRINGS.WATSON_REMOTE_CONTROL.HEATER.HOT,
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.HEATER.HOT)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetHeater_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/change_heater_hot.xml",
		normal = "change_heater_hot.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
    ["change_heater_cold"] =
    {
		label = STRINGS.WATSON_REMOTE_CONTROL.HEATER.COLD,
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.HEATER.COLD)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetHeater_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/change_heater_cold.xml",
		normal = "change_heater_cold.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
	["change_heater_neutral"] =
    {
		label = STRINGS.WATSON_REMOTE_CONTROL.HEATER.NEUTRAL,
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.HEATER.NEUTRAL)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetHeater_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/change_heater_neutral.xml",
		normal = "change_heater_neutral.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
    --------------------------------------------------------------------------
    
    ["toggle_snowball_on"] =
	{
		label = STRINGS.WATSON_REMOTE_CONTROL.SNOWBALL.TURN_ON,
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.SNOWBALL.TURN_ON)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetSnowball_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/toggle_snowball_on.xml",
		normal = "toggle_snowball_on.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
    
    ["toggle_snowball_off"] =
	{
		label = STRINGS.WATSON_REMOTE_CONTROL.SNOWBALL.TURN_OFF,
        onselect = function(inst)
			inst.components.spellbook:SetSpellName(STRINGS.WATSON_REMOTE_CONTROL.SNOWBALL.TURN_OFF)
			if TheWorld.ismastersim then
				--inst.components.aoespell:SetSpellFn(nil)
				inst.components.spellbook:SetSpellFn(SetSnowball_SpellFn)
			end
		end,
		execute = CastControlRobotSpell,
        atlas = "images/spell_icons/toggle_snowball_off.xml",
		normal = "toggle_snowball_off.tex",
		clicksound = "meta4/winona_UI/select",
		widget_scale = ICON_SCALE,
	},
}

--[[
local SPELLBOOK_BG =
{
	bank = "spell_icons_winona",
	build = "spell_icons_winona",
	anim = "dpad",
	widget_scale = ICON_SCALE,
}
]]

local function UpdateActiveSpells(inst)
    local active_spells = {}
    
    table.insert(active_spells, SPELLS[inst._robot_active_light_spell:value()])
    table.insert(active_spells, SPELLS[inst._robot_active_heater_spell:value()])
    table.insert(active_spells, SPELLS[inst._robot_active_snowball_spell:value()])
    
    --table.insert(active_spells, SPELLS[inst.robot_active_light_spell])
    --table.insert(active_spells, SPELLS[inst.robot_active_heater_spell])
    --table.insert(active_spells, SPELLS[inst.robot_active_snowball_spell])
    
    inst.components.spellbook:SetItems(active_spells)
end

--------------------------------------------------------------------------
--[[
local function SetLedEnabled(inst, enabled)
	if enabled then
		inst.AnimState:OverrideSymbol("led_off", "winona_remote", "led_on")
		inst.AnimState:SetSymbolBloom("led_off")
		inst.AnimState:SetSymbolLightOverride("led_off", 0.5)
		inst.AnimState:SetSymbolLightOverride("winona_remote_parts", 0.14)
	else
		inst.AnimState:ClearOverrideSymbol("led_off")
		inst.AnimState:ClearSymbolBloom("led_off")
		inst.AnimState:SetSymbolLightOverride("led_off", 0)
		inst.AnimState:SetSymbolLightOverride("winona_remote_parts", 0)
	end
end
]]
--------------------------------------------------------------------------

local function OnDespawn(inst, pet)
    local fx = SpawnPrefab("spawn_fx_small")
    local x, y, z = pet.Transform:GetWorldPosition()
    fx.Transform:SetPosition(x, y+3, z)
    pet:Remove()
end

--------------------------------------------------------------------------

local function OnSave(inst, data)
    data.robot_active_light_spell = inst._robot_active_light_spell:value()
    data.robot_active_heater_spell = inst._robot_active_heater_spell:value()
    data.robot_active_snowball_spell = inst._robot_active_snowball_spell:value()
end

local function OnLoad(inst, data)
    if data.robot_active_light_spell then
        inst._robot_active_light_spell:set(data.robot_active_light_spell)
    end
    if data.robot_active_heater_spell then
        inst._robot_active_heater_spell:set(data.robot_active_heater_spell)
    end
    if data.robot_active_snowball_spell then
        inst._robot_active_snowball_spell:set(data.robot_active_snowball_spell)
    end
end

local function OnInit(inst)
    if not inst.components.petleash:IsFull() then
        local x, y, z = inst.Transform:GetWorldPosition()
        local radius = 40
        local angle = TWOPI * math.random()
        inst.components.petleash:SpawnPetAt( x + radius*math.cos(angle), 0, z + radius*math.cos(angle) )
    end
    
    for robot,_ in pairs(inst.components.petleash:GetPets()) do
        inst.robot = robot --為了便於之後在程式需要呼叫跟隨機器人的時候，不用每次都寫這一串迴圈
        break
    end
    
    inst.robot:ToggleLight(inst, true) --初始化：讓機器人會保持上次關閉世界時的模式（還有上下地洞）
    inst.robot:ChangeHeaterMode(inst, true)
    inst.robot:ToggleSnowball(inst, true)
end

local function OnUpdateSpellsDirty(inst) --學官方的：多使用一個函數。其實不知道官方這麼寫的原因是什麼
	inst:DoTaskInTime(0, UpdateActiveSpells)
end

local function OnInitClient(inst)
    inst:ListenForEvent("update_active_spell_dirty", OnUpdateSpellsDirty)
    UpdateActiveSpells(inst)
    
    --若伺服器端的 ToggleLight(機器人的函數) -> UpdateActiveSpells(遙控器的函數) 先執行，因為這一行 ── 為了客戶端寫的 ListenForEvent ── 還未執行到，因此無法透過 net_variable push 的事件觸發 UpdateActiveSpells，所以需要直接再執行一次。
    --而且如果先執行了這行的 UpdateActiveSpells，才跑了伺服器的 UpdateActiveSpells，也無傷大雅，畢竟只是多執行一次而已。
end

--------------------------------------------------------------------------

local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("watson_remote")
	inst.AnimState:SetBuild("watson_remote")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:OverrideSymbol("wire", "watson_remote", "dummy")

	inst:AddTag("remotecontrol")

	MakeInventoryFloatable(inst, "small", 0.14, { 1.1, 1.15, 1 })

	inst:AddComponent("spellbook")
	--inst.components.spellbook:SetRequiredTag("portableengineer")
	inst.components.spellbook:SetRadius(SPELLBOOK_RADIUS)
	inst.components.spellbook:SetFocusRadius(SPELLBOOK_FOCUS_RADIUS)
	inst.components.spellbook:SetItems(SPELLS)
	--inst.components.spellbook:SetBgData(SPELLBOOK_BG)
	--inst.components.spellbook:SetOnOpenFn(OnOpenSpellBook)
	--inst.components.spellbook:SetOnCloseFn(OnCloseSpellBook)
	inst.components.spellbook.opensound = "meta4/winona_UI/open"
	inst.components.spellbook.closesound = "meta4/winona_UI/close"
	--inst.components.spellbook.executesound = "meta4/winona_UI/select"	--use .clicksound for item buttons instead
	inst.components.spellbook.focussound = "meta4/winona_UI/hover"		--item UIAnimButton don't have hover sound

	--[[
    inst:AddComponent("aoetargeting")
	inst.components.aoetargeting:SetAllowWater(true)
	inst.components.aoetargeting:SetRange(TUNING.WINONA_REMOTE_RANGE)
	inst.components.aoetargeting.reticule.targetfn = ReticuleTargetAllowWaterFn
	inst.components.aoetargeting.reticule.validcolour = { 0x33/255, 0x66/255, 0xFF/255, 1 }
	inst.components.aoetargeting.reticule.invalidcolour = { 0.5, 0, 0, 1 }
	inst.components.aoetargeting.reticule.ease = true
	inst.components.aoetargeting.reticule.mouseenabled = true
	inst.components.aoetargeting.reticule.twinstickmode = 1 -- For Controller 手把相關
	inst.components.aoetargeting.reticule.twinstickrange = TUNING.WINONA_REMOTE_RANGE -- For Controller 手把相關
    ]]

	inst._robot_active_light_spell = net_string(inst.GUID, "watson_remote._robot_active_light_spell", "update_active_spell_dirty") --為了讓客戶端也會更新法術輪盤
    inst._robot_active_heater_spell = net_string(inst.GUID, "watson_remote._robot_active_heater_spell", "update_active_spell_dirty")
    inst._robot_active_snowball_spell = net_string(inst.GUID, "watson_remote._robot_active_snowball_spell", "update_active_spell_dirty")
    
    inst.entity:SetPristine()

	if not TheWorld.ismastersim then
        inst:DoTaskInTime(0, OnInitClient)
		return inst
	end

	inst.swap_build = "watson_remote"

	inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "watson_remote"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/watson_remote.xml"
    
    inst:AddComponent("leader")
    
    inst:AddComponent("petleash")
    inst.components.petleash:SetPetPrefab("watson_bot")
    --inst.components.petleash:SetOnSpawnFn(OnSpawn)
    inst.components.petleash:SetOnDespawnFn(OnDespawn)
    
    --法術輪盤上正在顯示的法術
    --inst.robot_active_light_spell = "toggle_light_off" -- "toggle_light_off", "toggle_light_on"
    --inst.robot_active_heater_spell = "change_heater_hot" -- "change_heater_hot", "change_heater_cold", "change_heater_neutral"
    --inst.robot_active_snowball_spell = "toggle_snowball_off" -- "toggle_snowball_off", "toggle_snowball_on"
    
    inst._robot_active_light_spell:set("toggle_light_off") -- "toggle_light_off", "toggle_light_on"
    inst._robot_active_heater_spell:set("change_heater_hot") -- "change_heater_hot", "change_heater_cold", "change_heater_neutral"
    inst._robot_active_snowball_spell:set("toggle_snowball_off") -- "toggle_snowball_off", "toggle_snowball_on"
    
    inst.UpdateActiveSpells = UpdateActiveSpells

	--inst:AddComponent("aoespell")

	MakeHauntableLaunch(inst)

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
    
    inst:DoTaskInTime(0, OnInit)

	return inst
end

return Prefab("watson_remote", fn, assets, prefabs)
