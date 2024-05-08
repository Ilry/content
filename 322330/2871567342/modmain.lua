GLOBAL.setmetatable(env, { __index = function(_, k)
    return GLOBAL.rawget(GLOBAL, k)
end })

TUNING.item_port_finiteuses = GetModConfigData("item_port_finiteuses") or 1
TUNING.item_port_sanity = GetModConfigData("item_port_sanity") or 20

local function orangestaff(inst)
    inst:AddTag("item_portal")
end
AddPrefabPostInit("orangestaff", orangestaff)

--local function IsSoul(item)
--    return item.prefab == "wortox_soul"
--end
--
--local function GetStackSize(item)
--    return item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
--end
--
--local function GetSouls(inst)
--    local souls = inst.components.inventory:FindItems(IsSoul)
--    local count = 0
--    for i, v in ipairs(souls) do
--        count = count + GetStackSize(v)
--    end
--    return souls, count
--end
--
--local function PutSoulOnCooldown(item)
--    if not IsSoul(item) then
--        return
--    end
--
--    if item.components.rechargeable ~= nil then
--        item.components.rechargeable:Discharge(TUNING.WORTOX_FREEHOP_TIMELIMIT)
--    end
--end
--
--local function RemoveSoulCooldown(item)
--    if not IsSoul(item) then
--        return
--    end
--
--    if item.components.rechargeable ~= nil then
--        item.components.rechargeable:SetPercent(1)
--    end
--end
--
--local function SetNetvar(inst)
--    if inst.player_classified ~= nil then
--        assert(inst._freesoulhop_counter >= 0 and inst._freesoulhop_counter <= 7, "Player _freesoulhop_counter out of range: " .. tostring(inst._freesoulhop_counter))
--        inst.player_classified.freesoulhops:set(inst._freesoulhop_counter)
--    end
--end
--
--local function ClearSoulhopCounter(inst)
--    inst._freesoulhop_counter = 0
--    inst._soulhop_cost = 0
--    SetNetvar(inst)
--end
--
--local function OnFreesoulhopsChanged(inst, data)
--    inst._freesoulhop_counter = data and data.current or 0
--end
--
--local function playerPostInit(inst)
--    if inst._freesoulhop_counter == nil then
--        inst._freesoulhop_counter = 0
--
--    end
--    if inst.CanSoulhop == nil then
--        inst.CanSoulhop = function()
--            if inst.replica.inventory:Has("wortox_soul", souls or 1) then
--                local rider = inst.replica.rider
--                if rider == nil or not rider:IsRiding() then
--                    return true
--                end
--            end
--            return false
--        end
--    end
--
--    if not TheWorld.ismastersim then
--        if inst.prefab ~= "wortox" then
--            inst:ListenForEvent("freesoulhopschanged", OnFreesoulhopsChanged)
--        end
--        return inst
--    end
--
--    if inst.prefab ~= "wortox" then
--        ClearSoulhopCounter(inst)
--    end
--    if inst.TryToPortalHop == nil then
--        inst.TryToPortalHop = function(_, souls, consumeall)
--            local invcmp = inst.components.inventory
--            if invcmp == nil then
--                return false
--            end
--
--            souls = souls or 1
--            local _, soulscount = GetSouls(inst)
--            if soulscount < souls then
--                return false
--            end
--
--            inst._freesoulhop_counter = inst._freesoulhop_counter + souls
--            inst._soulhop_cost = inst._soulhop_cost + souls
--
--            if not consumeall and inst._freesoulhop_counter < TUNING.WORTOX_FREEHOP_HOPSPERSOUL then
--                inst._soulhop_cost = inst._soulhop_cost - souls -- Make it free.
--                invcmp:ForEachItem(PutSoulOnCooldown)
--            else
--                invcmp:ForEachItem(RemoveSoulCooldown)
--                inst:FinishPortalHop()
--            end
--            SetNetvar(inst)
--
--            return true
--        end
--    end
--
--    if inst.FinishPortalHop == nil then
--        inst.FinishPortalHop = function()
--            if inst._freesoulhop_counter > 0 then
--                if inst.components.inventory ~= nil then
--                    inst.components.inventory:ConsumeByName("wortox_soul", math.max(math.ceil(inst._soulhop_cost), 1))
--                end
--                ClearSoulhopCounter(inst)
--            end
--        end
--    end
--end
--AddPlayerPostInit(playerPostInit)

local function playercontroller(self)
    local old_GetMapActions = self.GetMapActions
    function self:GetMapActions(position)
        local LMBaction, RMBaction = old_GetMapActions(self, position)
        local inventory = self.inst.components.inventory or self.inst.replica.inventory
        if inventory and inventory:EquipHasTag("item_portal") then
            local act = BufferedAction(self.inst, nil, ACTIONS.ITEM_PORTAL)
            RMBaction = self:RemapMapAction(act, position)
            return LMBaction, RMBaction
        end
        return LMBaction, RMBaction
    end
    local old_OnMapAction = self.OnMapAction
    function self:OnMapAction(actioncode, position)
        old_OnMapAction(self, actioncode, position)
        local act = MOD_ACTIONS_BY_ACTION_CODE[STRINGS.ITEM_MODNAME][actioncode]
        if act == nil or not act.map_action then
            return
        end
        if self.ismastersim then
            local LMBaction, RMBaction = self:GetMapActions(position)
            if act.rmb then
                if RMBaction then
                    self.locomotor:PushAction(RMBaction, true)
                end
            else
                if LMBaction then
                    self.locomotor:PushAction(LMBaction, true)
                end
            end
        elseif self.locomotor == nil and not self.inst.item_portal then
            self.inst.item_portal = true
            if self.inst.item_task_portal == nil then
                self.inst.item_task_portal = self.inst:DoTaskInTime(9, function()
                    self.inst.item_portal = false
                    self.inst.item_task_portal = nil
                end)
            end
            SendRPCToServer(RPC.DoActionOnMap, actioncode, position.x, position.z)
        elseif self:CanLocomote() then
            local _, RMBaction = self:GetMapActions(position)
            RMBaction.preview_cb = function()
                SendRPCToServer(RPC.DoActionOnMap, actioncode, position.x, position.z)
            end
            self.locomotor:PreviewAction(RMBaction, true)
        end
    end
end
AddComponentPostInit("playercontroller", playercontroller)

AddAction("ITEM_PORTAL", "裂缝", function(act)
    if act == nil or act.doer == nil or act.pos == nil then
        return false
    end
    local inst = act.doer
    local targetpos = act.pos:GetPosition()
    local pt = inst:GetPosition()
    local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 3 + math.random(), 16, false, true, noentcheckfn, true, true)
            or FindWalkableOffset(pt, math.random() * 2 * PI, 5 + math.random(), 16, false, true, noentcheckfn, true, true)
            or FindWalkableOffset(pt, math.random() * 2 * PI, 7 + math.random(), 16, false, true, noentcheckfn, true, true)
    if offset ~= nil then
        pt = pt + offset
    end
    local portal = SpawnPrefab("pocketwatch_portal_entrance")
    if portal then
        if portal and portal.components.teleporter then
            portal.components.teleporter.onActivate = function(_, doer)
                if doer.components.talker ~= nil then
                    doer.components.talker:ShutUp()
                end

                if doer.components.sanity ~= nil and not (doer:HasTag("pocketwatchcaster") or doer:HasTag("nowormholesanityloss")) then
                    doer.components.sanity:DoDelta(-(TUNING.item_port_sanity or 20))
                end
            end
        end
        portal.Transform:SetPosition(pt:Get())
        portal:SpawnExit(TheShard:GetShardId(), targetpos.x or pt.x, 0, targetpos.z or pt.z)
        inst.SoundEmitter:PlaySound("wanda1/wanda/portal_entrance_pre")
        local hands = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if hands and hands.components.finiteuses then
            hands.components.finiteuses:Use(TUNING.item_port_finiteuses)
        end
    end
    return true
end).map_action = true
ACTIONS.ITEM_PORTAL.do_not_locomote = true
ACTIONS.ITEM_PORTAL.rmb = true
STRINGS.ITEM_MODNAME = ACTIONS.ITEM_PORTAL.mod_name

AddStategraphActionHandler("wilson", ActionHandler(GLOBAL.ACTIONS.ITEM_PORTAL, nil))
AddStategraphActionHandler("wilson_client", ActionHandler(GLOBAL.ACTIONS.ITEM_PORTAL, nil))

local BLINK_MAP_MUST = { "CLASSIFIED", "globalmapicon", "fogrevealer" }
ACTIONS_MAP_REMAP[ACTIONS.ITEM_PORTAL.code] = function(act, targetpos)
    local doer = act.doer
    if doer == nil then
        return nil
    end
    if doer.item_portal then
        return nil
    end
    if not TheWorld.Map:IsVisualGroundAtPoint(targetpos.x, targetpos.y, targetpos.z) then
        local ents = TheSim:FindEntities(targetpos.x, targetpos.y, targetpos.z, PLAYER_REVEAL_RADIUS * 0.4, BLINK_MAP_MUST)
        local revealer
        local MAX_WALKABLE_PLATFORM_DIAMETERSQ = TUNING.MAX_WALKABLE_PLATFORM_RADIUS * TUNING.MAX_WALKABLE_PLATFORM_RADIUS * 4 -- Diameter.
        for _, v in ipairs(ents) do
            if doer:GetDistanceSqToInst(v) > MAX_WALKABLE_PLATFORM_DIAMETERSQ then
                -- Ignore close boats because the range for aim assist is huge.
                revealer = v
                break
            end
        end
        if revealer == nil then
            return nil
        end
        targetpos.x, targetpos.y, targetpos.z = revealer.Transform:GetWorldPosition()
        if revealer._target ~= nil then
            -- Server only code.
            local boat = revealer._target:GetCurrentPlatform()
            if boat == nil then
                return nil
            end
            targetpos.x, targetpos.y, targetpos.z = boat.Transform:GetWorldPosition()
        end
    end
    local act_remap = BufferedAction(doer, nil, ACTIONS.ITEM_PORTAL, act.invobject, targetpos)
    return act_remap
end