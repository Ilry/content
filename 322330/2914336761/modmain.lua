GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

--local function IsDefaultScreen()
--    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()
--    local screen = active_screen and active_screen.name or ""
--    return screen:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil and GLOBAL.ThePlayer.HUD ~= nil and not GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() and not GLOBAL.ThePlayer.HUD.writeablescreen
--end

local function IsDefaultScreen()
    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()
    local screen = active_screen and active_screen.name or ""
    return screen:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil and GLOBAL.ThePlayer.HUD ~= nil and not GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() and not GLOBAL.ThePlayer.HUD.writeablescreen and not
    (ThePlayer.HUD.controls and ThePlayer.HUD.controls.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox and ThePlayer.HUD.controls.craftingmenu.craftingmenu.search_box.textbox.editing)
end

if GetModConfigData('language') == 'zh' then
    modimport('languages/Chinese.lua')
else
    modimport('languages/English.lua')
end

PrefabFiles = { 'circular_placement' }

local controls
AddClassPostConstruct("widgets/controls", function(self)
    controls = self
    local CPMAPanel = require "widgets/CPMAPanel"
    if controls and controls.top_root then
        controls.CPMAPanel = controls.top_root:AddChild(CPMAPanel())
        controls.CPMAPanel.IsShow = false
        controls.CPMAPanel:Hide()
    end
end)

local toggle_key = GLOBAL.KEY_H
local key_toggle = GetModConfigData("key_toggle")
if key_toggle ~= nil then
    toggle_key = GLOBAL[key_toggle]
end

TheInput:AddKeyUpHandler(toggle_key, function()
    if IsDefaultScreen() then
        if controls and controls.CPMAPanel then
            if controls.CPMAPanel.IsShow then
                controls.CPMAPanel:Hide()
                controls.CPMAPanel.IsShow = false
            else
                controls.CPMAPanel:MoveToFront()
                controls.CPMAPanel:Show()
                controls.CPMAPanel.IsShow = true
            end
        end
    end
end)

local default_settings = {
    { name = '五锅三冰箱-锅', range = 2.73, angle = 0, anchor = 5, type = 'circle', arc = 360 },
    { name = '五锅三冰箱-冰箱', range = 0.87, angle = 0, anchor = 3, type = 'circle', arc = 360 },
    { name = '六锅', range = 3.5, angle = 0, anchor = 6, type = 'circle', arc = 360 },
    { name = '四锅四冰箱-锅', range = 2.5, angle = 0, anchor = 4, type = 'circle', arc = 360 },
    { name = '四锅四冰箱-冰箱', range = 1.1, angle = 45, anchor = 4, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈1-16浆果', range = 5.7, angle = 0, anchor = 16, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈2-24浆果', range = 7.8, angle = 0, anchor = 24, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈3-60草', range = 9.6, angle = 0, anchor = 60, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈4-60草', range = 10.7, angle = 0, anchor = 60, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈5-60树枝', range = 11.8, angle = 0, anchor = 60, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈6-60树枝', range = 12.9, angle = 0, anchor = 60, type = 'circle', arc = 360 },
    { name = '灭火器农场-圈7-40石果', range = 15, angle = 15, anchor = 40, type = 'circle', arc = 360 },
    { name = '40草树枝-圈1', range = 1, angle = 0, anchor = 4, type = 'circle', arc = 360 },
    { name = '40草树枝-圈2', range = 2, angle = 0, anchor = 8, type = 'circle', arc = 360 },
    { name = '40草树枝-圈3', range = 3, angle = 0, anchor = 12, type = 'circle', arc = 360 },
    { name = '40草树枝-圈4', range = 4, angle = 0, anchor = 16, type = 'circle', arc = 360 },
    { name = '20箱子-圈1', range = 2, angle = 0, anchor = 8, type = 'circle', arc = 360 },
    { name = '20箱子-圈2', range = 4, angle = 0, anchor = 12, type = 'circle', arc = 360 },
}
local default_setting = {
    circle = { range = 4, angle = 0, anchor = 12, arc = 360 },
    line = { range = 8, angle = 0, anchor = 9 },
    triangle = { range = 4, angle = 0, anchor = 4 },
    square = { range = 1, angle = 0, anchor = 4 },
    rectangle = { range = 1, angle = 0, anchor = 4, anchor2 = 8 },
    heart = { range = 8, angle = 0, anchor = 5 }
}
GLOBAL.CPMA = {
    DATA = {
        PREFAB_CAPTURE = true,
        GRID_CAPTURE = true,
        LESS_PREVIEW = false,
        CENTER_CASCADE = false,
        CENTER_ANCHOR = false,
        RECT_ANCHOR_CENTER = false,
        FULL_PLACEMENT=false,
        SETTING = default_setting,
        TYPE = 'circle',
        CP_POS_BUTTON = 'LALT',
        CP_POS2_BUTTON = 'RALT',
        CP_PLACE_BUTTON = 'LCTRL',
        CP_AUTO_BUTTON = 'LSHIFT',
        CP_PRECISION = { '1/8', 0.125 },
        SETTINGS = default_settings,
    },
    SEARCH_WORD = '',
    NAME = STRINGS.CPMA.TITLE_TEXT_CUSTOMIZE
}
local DATA_FILE = "mod_config_data/nomu_cpma_save_v2"

GLOBAL.CPMA.ResetSettings = function()
    GLOBAL.CPMA.DATA.SETTINGS = default_settings
    GLOBAL.CPMA.DATA.SETTING = default_setting
    GLOBAL.CPMA.SaveData()
end

GLOBAL.CPMA.ImportOldSettings = function()
    TheSim:GetPersistentString("mod_config_data/nomu_cpma_save", function(load_success, str)
        if load_success and #str > 0 then
            local run_success, data = RunInSandboxSafe(str)
            if run_success then
                for _, v in ipairs(data.SETTINGS) do
                    if v ~= nil then
                        v.type = 'circle'
                        v.arc = 360
                        table.insert(GLOBAL.CPMA.DATA.SETTINGS, v)
                    end
                end
                GLOBAL.CPMA.SaveData()
            end
        end
    end)
end

GLOBAL.CPMA.LoadData = function()
    TheSim:GetPersistentString(DATA_FILE, function(load_success, str)
        if load_success and #str > 0 then
            local run_success, data = RunInSandboxSafe(str)
            if run_success then
                for k, v in pairs(data) do
                    if v ~= nil then
                        GLOBAL.CPMA.DATA[k] = v
                    end
                end
            end
        end
    end)
end

GLOBAL.CPMA.SaveData = function()
    SavePersistentString(DATA_FILE, DataDumper(GLOBAL.CPMA.DATA, nil, true), false, nil)
end

AddSimPostInit(function()
    GLOBAL.CPMA.LoadData()
end)

GLOBAL.CIRCLE_HELPER = nil

local auto_thread
local action_delay = FRAMES * 3
local work_delay = FRAMES * 6
local anchor_pos

local oldIsKeyDown = TheInput.IsKeyDown
local gp_mod = ModManager:GetMod("workshop-351325790")
local gpCanBuildAtPoint
local function ShouldPressCtrl()
    if gp_mod and gpCanBuildAtPoint then
        local name, value = debug.getupvalue(gpCanBuildAtPoint, 1)
        if name == 'CTRL' then
            return not value
        end
    end
    return true
end

GLOBAL.nomu_fn = nil
AddClassPostConstruct("components/builder_replica", function(Builder)
    local OldCanBuildAtPoint = Builder.CanBuildAtPoint
    if gp_mod then
        gpCanBuildAtPoint = OldCanBuildAtPoint
    end
end)

TheInput.IsKeyDown = function(self, key, ...)
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return oldIsKeyDown(self, key, ...)
    end
    if IsDefaultScreen() and key == GLOBAL.KEY_CTRL and gp_mod and (oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_PLACE_BUTTON]) or oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) or auto_thread ~= nil) and GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
        return ShouldPressCtrl()
    end
    return oldIsKeyDown(self, key, ...)
end

local oldGetWorldPosition = TheInput.GetWorldPosition
TheInput.GetWorldPosition = function(self)
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return oldGetWorldPosition(self)
    end
    if anchor_pos and (oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_PLACE_BUTTON]) or oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) or auto_thread ~= nil) then
        return anchor_pos
    end
    return oldGetWorldPosition(self)
end

local oldIsControlPressed = TheInput.IsControlPressed
TheInput.IsControlPressed = function(self, control)
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return oldIsControlPressed(self, control)
    end
    if IsDefaultScreen() and control == CONTROL_FORCE_STACK and anchor_pos and (TheSim:IsKeyDown(GLOBAL['KEY_' .. CPMA.DATA.CP_PLACE_BUTTON]) or oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) or auto_thread ~= nil) then
        return true
    end
    return oldIsControlPressed(self, control)
end

local _cc
local function GetOrCreateCenter()
    if _cc and _cc:IsValid() then
        return _cc
    end
    _cc = SpawnPrefab('circle_center')
    return _cc
end

GLOBAL.CPMAGetTurfCenter = function(px, py, pz)
    local x, y = TheWorld.Map:GetTileCoordsAtPoint(px, py, pz)
    local width, height = TheWorld.Map:GetSize()
    local spawn_x, spawn_z = (x - width / 2.0) * TILE_SCALE, (y - height / 2.0) * TILE_SCALE
    return spawn_x, 0, spawn_z
end

local function GetOrCapturePos()
    local entity = ConsoleWorldEntityUnderMouse()
    local x, z
    if CPMA.DATA.PREFAB_CAPTURE and (entity and entity:IsValid() and entity.prefab and entity.Transform) then
        x, _, z = entity:GetPosition():Get()
    else
        x, _, z = TheInput:GetWorldPosition():Get()
        if CPMA.DATA.GRID_CAPTURE then
            local sx, _, sz = CPMAGetTurfCenter(x, 0, z)
            local d = TILE_SCALE * CPMA.DATA.CP_PRECISION[2]
            x = math.floor((x - sx) / d + 0.5) * d + sx
            z = math.floor((z - sz) / d + 0.5) * d + sz
        end
    end
    return x, 0, z
end

local _prefab, _act_type
local preview_prefabs = {}
GLOBAL.CPMAClearPreviews = function()
    for _, inst in ipairs(preview_prefabs) do
        inst:Remove()
    end
    preview_prefabs = {}
    _prefab = nil
    _act_type = nil
    if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
        for _, anchor in ipairs(GLOBAL.CIRCLE_HELPER.anchors) do
            anchor.AnimState:SetAddColour(0, 1, 0, 0)
        end
    end
end

TheInput:AddKeyHandler(function(key, down)
    if key == GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON] and not down then
        if auto_thread == nil then
            GLOBAL.CPMAClearPreviews()
        end
    end
end)

local function SpawnPreviews(prefab, act_type, prefab_inst)
    if #preview_prefabs > 0 then
        GLOBAL.CPMAClearPreviews()
    end
    if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
        local start_i
        local best_d
        local mouse_pos = TheInput:GetWorldPosition()
        for i, anchor in ipairs(GLOBAL.CIRCLE_HELPER.anchors) do
            local d = mouse_pos:Dist(anchor:GetPosition())
            if not best_d or d < best_d then
                start_i = i
                best_d = d
            end
        end

        if start_i then
            local controller = ThePlayer.components.playercontroller
            local selected_pos
            if act_type == 'BUILD' then
                if controller.placer_recipe ~= nil and controller.placer ~= nil then
                    selected_pos = controller.placer.components.placer.selected_pos
                end
            end
            local n = 0
            while n < #GLOBAL.CIRCLE_HELPER.anchors do
                local anchor = GLOBAL.CIRCLE_HELPER.anchors[start_i]
                if anchor == nil then
                    break
                end
                local can_spawn = true
                local pos = anchor:GetPosition()
                local preview_prefab = prefab
                if act_type == 'DEPLOY' then
                    local act = ThePlayer.components.playeractionpicker:GetRightClickActions(pos)[1]
                    if not act or act.action ~= ACTIONS.DEPLOY then
                        can_spawn = false
                    elseif controller.deployplacer then
                        preview_prefab = SpawnSaveRecord(controller.deployplacer:GetSaveRecord())
                    else
                        preview_prefab = prefab .. '_placer'
                    end
                elseif act_type == 'DROP' then
                    local act = ThePlayer.components.playeractionpicker:GetLeftClickActions(pos)[1]
                    if not act or act.action ~= ACTIONS.DROP then
                        can_spawn = false
                    elseif prefab_inst then
                        preview_prefab = SpawnSaveRecord(prefab_inst:GetSaveRecord())
                    end
                elseif act_type == 'BUILD' then
                    if controller.placer_recipe ~= nil and controller.placer ~= nil then
                        controller.placer.components.placer.selected_pos = pos
                        controller.placer.components.placer:OnUpdate()
                        can_spawn = controller.placer.components.placer.can_build
                        if can_spawn then
                            preview_prefab = SpawnSaveRecord(controller.placer:GetSaveRecord())
                        end
                    end
                end
                if can_spawn and preview_prefab then
                    local placer
                    if type(preview_prefab) == 'string' then
                        placer = SpawnPrefab(preview_prefab)
                    else
                        placer = preview_prefab
                    end
                    if placer then
                        placer:RemoveComponent('placer')
                        placer:RemoveTag('CLASSIFIED')
                        placer.Transform:SetPosition(pos:Get())
                        placer.AnimState:SetAddColour(0, 0.5, 0, 0)
                        table.insert(preview_prefabs, placer)
                    end
                else
                    anchor.AnimState:SetAddColour(1, 0, 0, 1)
                end
                start_i = start_i + 1
                if start_i > #GLOBAL.CIRCLE_HELPER.anchors then
                    start_i = 1
                end
                n = n + 1
            end

            if act_type == 'BUILD' then
                if controller.placer_recipe ~= nil and controller.placer ~= nil then
                    controller.placer.components.placer.selected_pos = selected_pos
                    controller.placer.components.placer:OnUpdate()
                end
            end
        end

        if #preview_prefabs > 0 then
            for _, placer in ipairs(preview_prefabs) do
                placer:AddTag('CLASSIFIED')
                placer:AddTag('NOCLICK')
            end
            _prefab = prefab
            _act_type = act_type
        end
    end
end

local function MoveActiveItem(prefab)
    if not prefab or ThePlayer.replica.inventory:GetActiveItem() then
        return
    end
    local inventory = ThePlayer.replica.inventory
    local body_item = inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    local backpack = body_item and body_item.replica.container
    for _, inv in pairs(backpack and { inventory, backpack } or { inventory }) do
        for slot, item in pairs(inv:GetItems()) do
            if item and item.prefab == prefab then
                inv:TakeActiveItemFromAllOfSlot(slot)
                return
            end
        end
    end
end

local function DoAction(act, right_click, target)
    local controller = ThePlayer.components.playercontroller
    if controller.ismastersim then
        ThePlayer.components.combat:SetTarget(nil)
        controller:DoAction(act)
        return
    end
    local pos = act:GetActionPoint() or ThePlayer:GetPosition()
    local control_mods = 10
    if controller.locomotor then
        act.preview_cb = function()
            if right_click then
                SendRPCToServer(RPC.RightClick, act.action.code, pos.x, pos.z, target, act.rotation, true, nil, nil, act.action.mod_name)
            else
                SendRPCToServer(RPC.LeftClick, act.action.code, pos.x, pos.z, target, true, control_mods, nil, act.action.mod_name)
            end
        end
        controller:DoAction(act)
    else
        if right_click then
            SendRPCToServer(RPC.RightClick, act.action.code, pos.x, pos.z, target, act.rotation, true, nil, act.action.canforce, act.action.mod_name)
        else
            SendRPCToServer(RPC.LeftClick, act.action.code, pos.x, pos.z, target, true, control_mods, act.action.canforce, act.action.mod_name)
        end
    end
end

local function kill_auto_thread()
    if auto_thread then
        KillThreadsWithID(auto_thread.id)
        auto_thread:SetList(nil)
        auto_thread = nil
        if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
            for _, anchor in ipairs(GLOBAL.CIRCLE_HELPER.anchors) do
                anchor.AnimState:SetAddColour(0, 1, 0, 0)
            end
        end
        GLOBAL.CPMAClearPreviews()
    end
end

local function SpawnPreviewsOrAutoWork(prefab, act_type, prefab_inst)
    kill_auto_thread()
    if #preview_prefabs > 0 and _prefab == prefab and _act_type == act_type then
        auto_thread = StartThread(function()
            local idx = 1
            local recipe, skin
            while idx <= #preview_prefabs do
                local pos = preview_prefabs[idx] and preview_prefabs[idx]:GetPosition()
                if not pos then
                    break
                end
                if act_type == 'DEPLOY' then
                    MoveActiveItem(prefab)
                    local active_item = ThePlayer.replica.inventory:GetActiveItem()
                    if active_item then
                        local act = BufferedAction(ThePlayer, nil, ACTIONS.DEPLOY, active_item, pos)
                        DoAction(act, true)
                    else
                        break
                    end
                elseif act_type == 'DROP' then
                    MoveActiveItem(prefab)
                    local active_item = ThePlayer.replica.inventory:GetActiveItem()
                    if active_item then
                        local act = BufferedAction(ThePlayer, nil, ACTIONS.DROP, active_item, pos)
                        act.options.wholestack = false
                        DoAction(act, false)
                    else
                        break
                    end
                elseif act_type == 'BUILD' then
                    local controller = ThePlayer.components.playercontroller
                    local builder = ThePlayer.replica.builder

                    if (controller.placer_recipe == nil or controller.placer == nil) and recipe then
                        if not builder:CanBuild(recipe.name) and not builder:IsBuildBuffered(recipe.name) then
                            break
                        end
                        if not builder:IsBuildBuffered(recipe.name) then
                            builder:BufferBuild(recipe.name)
                        end
                        ThePlayer.components.playercontroller:StartBuildPlacementMode(recipe, skin)
                    end
                    if controller.placer_recipe ~= nil and controller.placer ~= nil then
                        recipe = controller.placer_recipe
                        local rotation = controller.placer:GetRotation()
                        skin = controller.placer_recipe_skin
                        if builder:CanBuildAtPoint(pos, recipe, rotation) then
                            builder:MakeRecipeAtPoint(recipe, pos, rotation, skin)
                        else
                            break
                        end
                    else
                        break
                    end
                end
                preview_prefabs[idx].AnimState:SetAddColour(0.5, 0.5, 0.5, 0)
                Sleep(work_delay)
                repeat
                    Sleep(action_delay)
                until not (ThePlayer.sg and ThePlayer.sg:HasStateTag("moving")) and not ThePlayer:HasTag("moving")
                        and ThePlayer:HasTag("idle") and not ThePlayer.components.playercontroller:IsDoingOrWorking()
                if preview_prefabs[idx] then
                    preview_prefabs[idx]:Hide()
                end
                idx = idx + 1
            end
            kill_auto_thread()
        end, 'cpma_auto_thread')
    else
        SpawnPreviews(prefab, act_type, prefab_inst)
    end
end

local function Distance(PointX, PointZ)
    local xx, _, zz = ThePlayer.Transform:GetWorldPosition()
    local DelX = PointX - xx
    local DelZ = PointZ - zz
    return math.sqrt(DelX * DelX + DelZ * DelZ)
end

local function LongWalk(pos)
    local PlayerController = ThePlayer.components.playercontroller
    local act = BufferedAction(ThePlayer, nil, ACTIONS.WALKTO, ThePlayer.replica.inventory:GetActiveItem(), pos)
    if PlayerController:CanLocomote() then
        act.preview_cb = function()
            SendRPCToServer(RPC.LeftClick, act.action.code, pos.x, pos.z, nil, true)
        end
        PlayerController:DoAction(act)
    else
        SendRPCToServer(RPC.LeftClick, act.action.code, pos.x, pos.z, nil, nil, nil, act.action.canforce)
    end
end

local function ShortStep(pos)
    if pos then
        local Distate = Distance(pos.x, pos.z)
        if Distate > 0 then
            local xx, _, zz = ThePlayer.Transform:GetWorldPosition()
            local Direct = (Vector3(pos.x - xx, 0, pos.z - zz) / Distate) * 0.165
            local Destination = Vector3(xx + Direct.x, 0, zz + Direct.z)
            LongWalk(Destination)
        end
    end
end

local function GetRoutePos(Radius0, x1, z1, Radius1)
    local x0, _, z0 = ThePlayer.Transform:GetWorldPosition()
    local d = math.sqrt((x1 - x0) * (x1 - x0) + (z1 - z0) * (z1 - z0))
    if d == 0 then
        return nil
    end
    local a = (Radius0 * Radius0 - Radius1 * Radius1 + d * d) / (2 * d)
    if Radius0 < a then
        return nil
    end
    local h = math.sqrt(Radius0 * Radius0 - a * a)
    local x2 = x0 + a * (x1 - x0) / d
    local z2 = z0 + a * (z1 - z0) / d

    local x3 = x2 + h * (z1 - z0) / d
    local z3 = z2 - h * (x1 - x0) / d

    return Vector3(x3, 0, z3)
end

local AngleStep = true
local AngPos
local Task
local Timer = 0.8
local PreviousPlayerPost
local function SayFinalDistance(_, PointX, PointZ)
    ThePlayer.components.talker:Say(GLOBAL.STRINGS.CPMA.MESSAGE_DISTANCE_TO_ANCHOR .. tostring(Distance(PointX, PointZ)))
end

local function WalkTo(_, PointX, PointZ, StepDistance)
    local Distate = 0
    if ThePlayer.components.playercontroller:IsAnyOfControlsPressed(CONTROL_MOVE_UP, CONTROL_MOVE_DOWN, CONTROL_MOVE_LEFT, CONTROL_MOVE_RIGHT) then
        return
    end
    if ThePlayer:HasTag("idle") and not ThePlayer.components.playercontroller:IsDoingOrWorking() then
        if StepDistance > 0 then
            if Distance(PointX, PointZ) > 0.3 then
                LongWalk(Vector3(PointX, 0, PointZ))
            else
                if AngleStep then
                    local RelativeDistance = math.floor(Distance(PointX, PointZ) / StepDistance)
                    if RelativeDistance < 2 then
                        AngPos = GetRoutePos(StepDistance, PointX, PointZ, StepDistance)
                        if AngPos then
                            ShortStep(AngPos)
                            AngleStep = false
                        else
                            AngleStep = true
                            Task = nil
                            ThePlayer:DoTaskInTime(Timer, SayFinalDistance, PointX, PointZ)
                            return
                        end
                    else
                        AngPos = GetRoutePos(RelativeDistance * StepDistance, PointX, PointZ, StepDistance)
                        if AngPos then
                            ShortStep(AngPos)
                        else
                            AngleStep = true
                            Task = nil
                            ThePlayer:DoTaskInTime(Timer, SayFinalDistance, PointX, PointZ)
                            return
                        end
                    end
                else
                    ShortStep(Vector3(PointX, 0, PointZ))
                    AngleStep = true
                    Task = nil
                    ThePlayer:DoTaskInTime(Timer, SayFinalDistance, PointX, PointZ)
                    return
                end
            end
        else
            if PreviousPlayerPost == nil then
                local xx, yy, zz = ThePlayer.Transform:GetWorldPosition()
                PreviousPlayerPost = Vector3(xx, yy, zz)
                ShortStep(Vector3(PointX, 0, PointZ))
            else
                local xx, yy, zz = ThePlayer.Transform:GetWorldPosition()
                local xD = PreviousPlayerPost.x - xx
                local zD = PreviousPlayerPost.z - zz
                local Dist = math.sqrt(xD * xD + zD * zD)
                if Dist > 0.01 then
                    Distate = Dist
                end
                PreviousPlayerPost = nil
            end
        end
    end
    if Distate > 0 then
        Task = ThePlayer:DoTaskInTime(Timer, WalkTo, PointX, PointZ, Distate)
    else
        Task = ThePlayer:DoTaskInTime(Timer, WalkTo, PointX, PointZ, StepDistance)
    end
end

TheInput:AddMouseButtonHandler(function(button, down)
    if not (IsDefaultScreen() and down) or TheInput:GetHUDEntityUnderMouse() ~= nil then
        return
    end
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return
    end
    if oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) then
        local LMBAction, RMBAction = ThePlayer.components.playeractionpicker:DoGetMouseActions()
        if button == MOUSEBUTTON_RIGHT then
            if RMBAction and RMBAction.action == ACTIONS.DEPLOY and RMBAction.invobject and RMBAction.invobject.prefab then
                SpawnPreviewsOrAutoWork(RMBAction.invobject.prefab, 'DEPLOY')
                return
            end
        elseif button == MOUSEBUTTON_LEFT then
            if LMBAction and LMBAction.action == ACTIONS.DROP and LMBAction.invobject and LMBAction.invobject.prefab then
                SpawnPreviewsOrAutoWork(LMBAction.invobject.prefab, 'DROP', LMBAction.invobject)
                return
            end
            local controller = ThePlayer.components.playercontroller
            if controller.placer_recipe ~= nil and controller.placer ~= nil and controller.placer_recipe.name then
                SpawnPreviewsOrAutoWork(controller.placer_recipe.name, 'BUILD')
                return
            end
        end
    end
    if oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS_BUTTON]) and oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_PLACE_BUTTON]) then
        if button == MOUSEBUTTON_LEFT and anchor_pos then
            if Task ~= nil then
                Task:Cancel()
                Task = nil
            end
            ThePlayer.components.talker:Say(GLOBAL.STRINGS.CPMA.MESSAGE_WALK_TO_ANCHOR)
            Task = ThePlayer:DoTaskInTime(Timer, WalkTo, anchor_pos.x, anchor_pos.z, 0)
            return
        end
    end
    if button == MOUSEBUTTON_MIDDLE then
        if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() and GLOBAL.CPMA.DATA.TYPE == 'line' and oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS2_BUTTON]) then
            GLOBAL.CIRCLE_HELPER:UpdateLineData(GetOrCapturePos())
        elseif oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS_BUTTON]) then
            if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
                if CPMA.DATA.CENTER_CASCADE and anchor_pos ~= nil then
                    GLOBAL.CIRCLE_HELPER.Transform:SetPosition(anchor_pos:Get())
                    GLOBAL.CIRCLE_HELPER:SetData()
                else
                    GLOBAL.CIRCLE_HELPER:Remove()
                    GLOBAL.CIRCLE_HELPER = nil
                end
                return
            end
            GLOBAL.CIRCLE_HELPER = SpawnPrefab('circle_helper')
            if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
                GLOBAL.CIRCLE_HELPER.Transform:SetPosition(GetOrCapturePos())
            end
        end
    end
end)

local last_best_anchor
local function OnUpdateAnchorPos()
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return
    end
    local best_anchor
    if oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_PLACE_BUTTON]) or oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) or (CPMA.DATA.CENTER_CASCADE and oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS_BUTTON])) then
        if GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
            local best_d = 1
            local mouse_pos = oldGetWorldPosition(TheInput)
            for _, anchor in ipairs(GLOBAL.CIRCLE_HELPER.anchors) do
                local d = mouse_pos:Dist(anchor:GetPosition())
                if d < best_d then
                    best_anchor = anchor
                    best_d = d
                end
            end
        end
    end
    if last_best_anchor ~= best_anchor and last_best_anchor and last_best_anchor:IsValid() then
        last_best_anchor.Transform:SetScale(0.35, 0.35, 0.35)
    end
    if best_anchor ~= nil and best_anchor:IsValid() then
        anchor_pos = best_anchor:GetPosition()
        if best_anchor ~= last_best_anchor then
            best_anchor.Transform:SetScale(0.40, 0.40, 0.40)
        end
    else
        anchor_pos = nil
    end
    last_best_anchor = best_anchor
end

local function OnCenterUpdate()
    if not IsDefaultScreen() or not controls then
        return
    end
    if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        return
    end
    local cc = GetOrCreateCenter()
    if not (oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS_BUTTON]) and (GLOBAL.CIRCLE_HELPER == nil or not GLOBAL.CIRCLE_HELPER:IsValid())) and
            not (GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() and GLOBAL.CPMA.DATA.TYPE == 'line' and oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_POS2_BUTTON])) then
        cc:Hide()
        cc.grid:Hide()
        return
    end
    cc:Show()
    cc.grid:Show()
    local x, y, z = GetOrCapturePos()
    cc.Transform:SetPosition(x, y, z)
    cc.grid.Transform:SetPosition(GLOBAL.CPMAGetTurfCenter(x, y, z))
end

local interrupt_controls = {}
for control = CONTROL_ATTACK, CONTROL_MOVE_RIGHT do
    interrupt_controls[control] = true
end
local mouse_controls = { [CONTROL_PRIMARY] = false, [CONTROL_SECONDARY] = true }
AddComponentPostInit('playercontroller', function(PlayerController, inst)
    if inst ~= ThePlayer then
        return
    end

    local oldOnControl = PlayerController.OnControl
    PlayerController.OnControl = function(self, control, down)
        if CPMA.DATA.LESS_PREVIEW and not (controls and controls.CPMAPanel and controls.CPMAPanel.IsShow) then
        else
            if IsDefaultScreen() and down and oldIsKeyDown(TheInput, GLOBAL['KEY_' .. CPMA.DATA.CP_AUTO_BUTTON]) and GLOBAL.CIRCLE_HELPER and GLOBAL.CIRCLE_HELPER:IsValid() then
                if control == CONTROL_PRIMARY or control == CONTROL_SECONDARY and (not CPMA.DATA.LESS_PREVIEW or (controls.CPMAPanel and controls.CPMAPanel.IsShow)) then
                    return
                end
            end
        end
        local mouse_control = mouse_controls[control]
        if down and auto_thread and IsDefaultScreen() and (interrupt_controls[control] or mouse_control ~= nil and not TheInput:GetHUDEntityUnderMouse()) then
            kill_auto_thread()
        end
        return oldOnControl(self, control, down)
    end

    local oldOnUpdate = PlayerController.OnUpdate
    PlayerController.OnUpdate = function(self, ...)
        if IsDefaultScreen() then
            OnUpdateAnchorPos()
            OnCenterUpdate()
        end
        return oldOnUpdate(self, ...)
    end
end)
