GLOBAL.setmetatable(env, {
    __index = function(_, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

local function IsDefaultScreen()
    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()
    local screen = active_screen and active_screen.name or ""
    return screen:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil and not GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() and not GLOBAL.ThePlayer.HUD.writeablescreen and not
    (ThePlayer.HUD.controls and ThePlayer.HUD.controls.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox.editing)
end

if GetModConfigData('language') == 'zh' then
    modimport('languages/Chinese.lua')
else
    modimport('languages/English.lua')
end

Assets = {}
PrefabFiles = { 'turf_recorder' }

local turfs = require("worldtiledefs").turf
local turf_name_dict
GLOBAL.TURDGetTurfName = function(turf)
    if turf_name_dict == nil then
        turf_name_dict = {}
        for name, id in pairs(GetWorldTileMap()) do
            turf_name_dict[id] = name
        end
    end
    return turfs[turf] and STRINGS.NAMES['TURF_' .. string.upper(turfs[turf].name)] or turf_name_dict[turf] or tostring(turf)
end

GLOBAL.TURF_RECORD_HELPER = nil
GLOBAL.IsTURDRecordHelperReady = function()
    return GLOBAL.TURF_RECORD_HELPER and GLOBAL.TURF_RECORD_HELPER:IsValid()
end

GLOBAL.TURF_PLAY_HELPER = nil
GLOBAL.IsTURDPlayHelperReady = function()
    return GLOBAL.TURF_PLAY_HELPER and GLOBAL.TURF_PLAY_HELPER:IsValid()
end

local TURDPanel = require "widgets/TURDPanel"
local TURDRecordPanel = TURDPanel[1]
local TURDPlayPanel = TURDPanel[2]

local controls
AddClassPostConstruct("widgets/controls", function(self)
    controls = self
    if controls and controls.top_root then
        controls.TURDRecordPanel = controls.top_root:AddChild(TURDRecordPanel())
        controls.TURDRecordPanel:Close()
        controls.TURDPlayPanel = controls.top_root:AddChild(TURDPlayPanel())
        controls.TURDPlayPanel:Close()
    end
end)

local key_toggle_record = GetModConfigData("key_toggle_record") and GLOBAL[GetModConfigData("key_toggle_record")] or GLOBAL.KEY_F1
TheInput:AddKeyUpHandler(key_toggle_record, function()
    if IsDefaultScreen() then
        if controls and controls.TURDRecordPanel then
            if controls.TURDRecordPanel.IsShow then
                controls.TURDRecordPanel:Close()
            else
                controls.TURDRecordPanel:Open()
            end
        end
    end
end)

local key_toggle_play = GetModConfigData("key_toggle_play") and GLOBAL[GetModConfigData("key_toggle_play")] or GLOBAL.KEY_F2
TheInput:AddKeyUpHandler(key_toggle_play, function()
    if IsDefaultScreen() then
        if controls and controls.TURDPlayPanel then
            if controls.TURDPlayPanel.IsShow then
                controls.TURDPlayPanel:Close()
            else
                controls.TURDPlayPanel:Open()
            end
        end
    end
end)

GLOBAL.TURD = {
    DATA = {
        HIDE_VALID = false,
        RECORDS = {},
    },
    NAME = STRINGS.TURD.TITLE_TEXT_CUSTOMIZE,
    SEARCH_WORD = '',
    PATH = '',
    LAST = {
        RECORD = nil,
        POS = nil
    }
}
local DATA_FILE = "mod_config_data/nomu_turd_save_v2"
local LAST_FILE = "mod_config_data/nomu_turd_save_v2_" .. TheNet:GetSessionIdentifier()

GLOBAL.TURD.LoadData = function()
    TheSim:GetPersistentString(DATA_FILE, function(load_success, str)
        if load_success and #str > 0 then
            local run_success, data = RunInSandboxSafe(str)
            if run_success then
                for k, v in pairs(data) do
                    if v ~= nil then
                        GLOBAL.TURD.DATA[k] = v
                    end
                end
            end
        end
    end)

    TheSim:GetPersistentString(LAST_FILE, function(load_success, str)
        if load_success and #str > 0 then
            local run_success, data = RunInSandboxSafe(str)
            if run_success then
                for k, v in pairs(data) do
                    if v ~= nil then
                        GLOBAL.TURD.LAST[k] = v
                    end
                end
            end
        end
    end)
end

GLOBAL.TURD.SaveData = function()
    SavePersistentString(DATA_FILE, DataDumper(GLOBAL.TURD.DATA, nil, true), false, nil)
end

GLOBAL.TURD.SaveLast = function()
    SavePersistentString(LAST_FILE, DataDumper(GLOBAL.TURD.LAST, nil, true), false, nil)
end

AddSimPostInit(function()
    GLOBAL.TURD.LoadData()
end)

------------------------------------------------------------------------------------

local function IsTURDRecordEnable()
    return IsDefaultScreen() and controls and controls.TURDRecordPanel and controls.TURDRecordPanel.IsShow
end

local function IsTURDPlayEnable()
    return IsDefaultScreen() and controls and controls.TURDPlayPanel and controls.TURDPlayPanel.IsShow
end

GLOBAL.TURDSendCommand = function(cmd)
    local x, _, z = TheSim:ProjectScreenPos(TheSim:GetPosition())
    if TheNet:GetIsClient() and TheNet:GetIsServerAdmin() then
        TheNet:SendRemoteExecute(cmd, x, z)
    else
        ExecuteConsoleCommand(cmd)
    end
end

GLOBAL.GetTurfIndex = function(px, py, pz)
    local x, y = TheWorld.Map:GetTileCoordsAtPoint(px, py, pz)
    return x, y
end

GLOBAL.TurfIndexToPos = function(x, y)
    local width, height = TheWorld.Map:GetSize()
    local spawn_x, spawn_z = (x - width / 2.0) * TILE_SCALE, (y - height / 2.0) * TILE_SCALE
    return spawn_x, 0, spawn_z
end

GLOBAL.TURDGetTurfCenter = function(px, py, pz)
    local x, y = GLOBAL.GetTurfIndex(px, py, pz)
    return GLOBAL.TurfIndexToPos(x, y)
end

local function GetMouseTurfPos()
    local x, _, z = TheInput:GetWorldPosition():Get()
    x, _, z = GLOBAL.TURDGetTurfCenter(x, 0, z)
    return x, 0, z
end

local _cc
local function GetOrCreateCenter()
    if _cc and _cc:IsValid() then
        return _cc
    end
    _cc = SpawnPrefab('turf_center')
    return _cc
end

------------------------------------------------------------------------------------

local _queued_movement = false
local _screen_x, _screen_y
TheInput:AddMoveHandler(function(x, y)
    _screen_x, _screen_y = x, y
    _queued_movement = true
end)

local selection_thread
local selection_thread_id = "turd_selection_thread"
local function ClearSelectionThread()
    if selection_thread then
        KillThreadsWithID(selection_thread.id)
        selection_thread:SetList(nil)
        selection_thread = nil
    end
end

local function BoxSelect()
    local previous_indexes = {}
    local started_selection = false
    local start_tx, start_ty = GLOBAL.GetTurfIndex(TheSim:ProjectScreenPos(_screen_x, _screen_y))

    local function update_selection()
        local _cur_tx, _cur_ty = GLOBAL.GetTurfIndex(TheSim:ProjectScreenPos(_screen_x, _screen_y))

        if not started_selection then
            if start_tx == _cur_tx and start_ty == _cur_ty then
                return
            end
            started_selection = true
        end

        local current_indexes = {}
        local sx, sy, ex, ey = start_tx, start_ty, _cur_tx, _cur_ty
        if sx > ex then
            sx, ex = ex, sx
        end
        if sy > ey then
            sy, ey = ey, sy
        end
        for tx = sx, ex do
            for ty = sy, ey do
                local key = GLOBAL.TURF_RECORD_HELPER:GetTurfKey(tx, ty)
                if not GLOBAL.TURF_RECORD_HELPER.anchors[key] ~= nil and previous_indexes[key] == nil then
                    GLOBAL.TURF_RECORD_HELPER:SelectTurf(tx, ty)
                end
                current_indexes[key] = { tx = tx, ty = ty }
            end
        end

        for key, index in pairs(previous_indexes) do
            if current_indexes[key] == nil then
                GLOBAL.TURF_RECORD_HELPER:DeselectTurf(index.tx, index.ty)
            end
        end
        previous_indexes = current_indexes
    end

    selection_thread = StartThread(function()
        while IsTURDRecordEnable() and GLOBAL.IsTURDRecordHelperReady() do
            if _queued_movement then
                update_selection()
                _queued_movement = false
            end
            Sleep(FRAMES)
        end
        ClearSelectionThread()
    end, selection_thread_id)
end

------------------------------------------------------------------------------------

TheInput:AddMouseButtonHandler(function(button, down)
    if TheInput:GetHUDEntityUnderMouse() ~= nil then
        return
    end
    if IsTURDRecordEnable() then
        if not down and button == MOUSEBUTTON_LEFT then
            ClearSelectionThread()
        end
        if not down then
            return
        end
        if button == MOUSEBUTTON_LEFT then
            if not GLOBAL.IsTURDRecordHelperReady() then
                GLOBAL.TURF_RECORD_HELPER = SpawnPrefab('turf_record_helper')
                GLOBAL.TURF_RECORD_HELPER.Transform:SetPosition(GetMouseTurfPos())
                return
            end
            BoxSelect()

            local x, y, z = TheInput:GetWorldPosition():Get()
            local tx, ty = GLOBAL.GetTurfIndex(x, y, z)
            GLOBAL.TURF_RECORD_HELPER:HandleSelection(tx, ty)
        elseif button == MOUSEBUTTON_RIGHT then
            if GLOBAL.IsTURDRecordHelperReady() then
                GLOBAL.TURF_RECORD_HELPER:Remove()
                GLOBAL.TURF_RECORD_HELPER = nil
            end
        end
    elseif IsTURDPlayEnable() then
        if not down then
            return
        end
        if button == MOUSEBUTTON_LEFT then
            if not GLOBAL.IsTURDPlayHelperReady() then
                GLOBAL.TURF_PLAY_HELPER = SpawnPrefab('turf_play_helper')
                GLOBAL.TURF_PLAY_HELPER:UpdatePos(GetMouseTurfPos())
            end
        end
    end
end)

local function OnCenterUpdate()
    local cc = GetOrCreateCenter()
    if (GLOBAL.IsTURDRecordHelperReady() or not IsTURDRecordEnable()) and (GLOBAL.IsTURDPlayHelperReady() or not IsTURDPlayEnable()) then
        cc:Hide()
        cc.grid:Hide()
        return
    end
    cc:Show()
    cc.grid:Show()
    local x, y, z = GetMouseTurfPos()
    cc:UpdatePos(x, y, z)
end

local function OnUpdateAnchorPos()
    if not IsTURDPlayEnable() or not GLOBAL.IsTURDPlayHelperReady() then
        return
    end
    for anchor in pairs(GLOBAL.TURF_PLAY_HELPER.anchors) do
        local turf = TheWorld.Map:GetTileAtPoint(anchor:GetPosition():Get())
        if anchor.turd_turf == turf then
            if GLOBAL.TURD.DATA.HIDE_VALID then
                anchor:UpdateVisible(false)
            else
                anchor:UpdateVisible(true)
                anchor:UpdateAddColour(0, 1, 0, 0)
            end
        else
            anchor:UpdateAddColour(1, 0, 0, 0)
        end
    end
end

AddComponentPostInit('playercontroller', function(PlayerController, inst)
    if inst ~= ThePlayer then
        return
    end

    local oldOnControl = PlayerController.OnControl
    PlayerController.OnControl = function(self, control, down)
        if IsTURDRecordEnable() or (IsTURDPlayEnable() and (not GLOBAL.IsTURDPlayHelperReady())) then
            if control == CONTROL_PRIMARY or control == CONTROL_SECONDARY then
                return
            end
        end
        return oldOnControl(self, control, down)
    end

    local oldOnUpdate = PlayerController.OnUpdate
    PlayerController.OnUpdate = function(self, ...)
        OnCenterUpdate()
        OnUpdateAnchorPos()
        return oldOnUpdate(self, ...)
    end
end)
