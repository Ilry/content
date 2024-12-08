return Class(function(self, inst)

    assert(TheWorld.ismastersim, "sisturn_aligned_registry should not exist on client")

    --Public
    self.inst = inst

    --Private
    local _sisturns_moon = {}
    local _sisturns_shadow = {}
    local _is_moon_active = false
    local _is_shadow_active = false

    local function UpdateSisturnState()
        if POPULATING then
            if self.init_task == nil then
                self.init_task = self.inst:DoTaskInTime(0, function() UpdateSisturnState() self.init_task = nil end)
            end
            return
        end

        local is_moon_active = false
        local is_shadow_active = false

        for _, v in pairs(_sisturns_moon) do
            if v then
                is_moon_active = true
                break
            end
        end

        for _, v in pairs(_sisturns_shadow) do
            if v then
                is_shadow_active = true
                break
            end
        end

        if is_moon_active ~= _is_moon_active then
            _is_moon_active = is_moon_active
            TheWorld:PushEvent("onsisturnstatechanged", {is_active = is_active}) -- Wendy will be listening for this event
        end
    end

    local function OnRemoveSisturn(sisturn)
        if _sisturns[sisturn] ~= nil then
            _sisturns[sisturn] = nil
            inst:RemoveEventCallback("onremove", OnRemoveSisturn, sisturn)
            inst:RemoveEventCallback("onburnt", OnRemoveSisturn, sisturn)
        end

        UpdateSisturnState()
    end

    local function OnUpdateSisturnState(world, data)
        _sisturns[data.inst] = data.is_active == true
        UpdateSisturnState()
    end

    inst:ListenForEvent("ms_updatesisturnstate", OnUpdateSisturnState)

    function self:Register(sisturn)
        if sisturn ~= nil and _sisturns[sisturn] ~= nil then
            return
        end

        -- _sisturns是一个以对象为索引，boolean为值的表
        _sisturns[sisturn] = false

        inst:ListenForEvent("onremove", OnRemoveSisturn, sisturn)
        inst:ListenForEvent("onburnt", OnRemoveSisturn, sisturn)
    end

    function self:IsActive()
        return _is_active
    end

    function self:GetDebugString()
        return "Num: " .. tostring(GetTableSize(_sisturns)) .. ", is_active:" .. tostring(_is_active)
    end

end)
