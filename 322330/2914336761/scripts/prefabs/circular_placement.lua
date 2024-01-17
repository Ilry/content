local pi = 3.141592653

local function anchor_fn()
    local inst = CreateEntity()

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("boat_01")
    inst.AnimState:SetBuild("boat_test")
    inst.AnimState:PlayAnimation("idle_full")

    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(5)
    inst.AnimState:SetAddColour(0, 1, 0, 0)
    local scale = 0.35
    inst.Transform:SetScale(scale, scale, scale)
    return inst
end

local function create_outline(circle)
    local inst = CreateEntity()

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst:AddTag("placer")

    inst.AnimState:SetBank("firefighter_placement")
    inst.AnimState:SetBuild("firefighter_placement")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(5)
    inst.AnimState:SetAddColour(0, 1, 0, 0)

    inst.entity:SetParent(circle.entity)
    return inst
end

local function center_fn()
    local inst = CreateEntity()

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst:AddTag("placer")

    inst.AnimState:SetBank("boat_01")
    inst.AnimState:SetBuild("boat_test")
    inst.AnimState:PlayAnimation("idle_full")

    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(5)
    inst.AnimState:SetAddColour(1, 1, 0, 0)
    local outer_scale = 0.35
    inst.Transform:SetScale(outer_scale, outer_scale, outer_scale)

    inst.grid = SpawnPrefab('gridplacer')
    inst.grid.AnimState:SetAddColour(1, 1, 0, 0)
    inst.grid.AnimState:SetSortOrder(5)
    inst:ListenForEvent("onremove", function(_inst)
        _inst.grid:Remove()
    end)
    return inst
end

local function _rotate(x, z, angle)
    local rau = math.sqrt(x * x + z * z)
    if rau == 0 then
        return x, z
    end
    local theta = math.acos(x / rau) / pi * 180
    if z < 0 then
        theta = 360 - theta
    end
    theta = (theta + angle) / 180 * pi
    x = rau * math.cos(theta)
    z = rau * math.sin(theta)
    return x, z
end

local _center_anchor_types = { circle = true, triangle = true, heart = true }

local function fn()
    local inst = CreateEntity()

    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst:AddTag("placer")

    inst.AnimState:SetBank("boat_01")
    inst.AnimState:SetBuild("boat_test")
    inst.AnimState:PlayAnimation("idle_full")

    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND)
    inst.AnimState:SetSortOrder(6)
    inst.AnimState:SetAddColour(1, 1, 0, 0)
    local outer_scale = 0.30
    inst.Transform:SetScale(outer_scale, outer_scale, outer_scale)

    inst.outline = create_outline(inst)
    inst.outline:Hide()

    inst.anchors = {}
    function inst:SetData(type)
        type = type or CPMA.DATA.TYPE or 'circle'
        local data = CPMA.DATA.SETTING[type]
        if not data then
            return
        end
        CPMAClearPreviews()
        if data.anchor < 1 then
            data.anchor = 1
        end

        local pos_list = {}
        if type == 'circle' then
            if CPMA.DATA.FULL_PLACEMENT then
                local angle_delta = data.arc == 360 and data.arc / data.anchor or data.anchor == 1 and data.arc or data.arc / (data.anchor - 1)
                local r_delta = data.range * math.sin(angle_delta / 360 * pi) * 2
                local anchor = data.anchor
                local range = data.range
                local start_angle = 0
                while true do
                    for i = 1, anchor do
                        local angle = data.angle + start_angle + (i - 1) * angle_delta
                        local x = range * math.sin(angle / 180 * pi)
                        local z = range * math.cos(angle / 180 * pi)
                        table.insert(pos_list, { x, z })
                    end
                    if r_delta <= 1e-6 then
                        break
                    end
                    range = range - r_delta
                    if range < 0 or r_delta > range * 2 then
                        if range >= 0 then
                            table.insert(pos_list, { 0, 0 })
                        end
                        break
                    end
                    anchor = math.floor(data.arc / (math.asin(r_delta / 2 / range) * 360 / pi))
                    if anchor <= 0 then
                        break
                    end
                    angle_delta = data.arc / anchor
                    if data.arc ~= 360 then
                        anchor = anchor + 1
                    end
                end
            else
                local angle_delta = data.arc == 360 and data.arc / data.anchor or data.anchor == 1 and data.arc or data.arc / (data.anchor - 1)
                for i = 1, data.anchor do
                    local angle = data.angle + (i - 1) * angle_delta
                    local x = data.range * math.sin(angle / 180 * pi)
                    local z = data.range * math.cos(angle / 180 * pi)
                    table.insert(pos_list, { x, z })
                end
            end
        elseif type == 'line' then
            local range_delta = data.anchor == 1 and data.range or data.range / (data.anchor - 1)
            for i = 1, data.anchor do
                local x = range_delta * (i - 1) * math.cos(data.angle / 180 * pi)
                local z = range_delta * (i - 1) * math.sin(data.angle / 180 * pi)
                table.insert(pos_list, { x, z })
            end
        elseif type == 'triangle' then
            local px1 = data.range * math.cos((data.angle + 90) / 180 * pi)
            local pz1 = data.range * math.sin((data.angle + 90) / 180 * pi)
            local px2 = data.range * math.cos((data.angle + 210) / 180 * pi)
            local pz2 = data.range * math.sin((data.angle + 210) / 180 * pi)
            local px3 = data.range * math.cos((data.angle + 330) / 180 * pi)
            local pz3 = data.range * math.sin((data.angle + 330) / 180 * pi)
            if CPMA.DATA.FULL_PLACEMENT then
                table.insert(pos_list, { px1, pz1 })
                for row = 2, data.anchor do
                    local x1 = (px2 - px1) / (data.anchor - 1) * (row - 1) + px1
                    local z1 = (pz2 - pz1) / (data.anchor - 1) * (row - 1) + pz1
                    local x2 = (px3 - px1) / (data.anchor - 1) * (row - 1) + px1
                    local z2 = (pz3 - pz1) / (data.anchor - 1) * (row - 1) + pz1
                    if math.fmod(row, 2) == 0 then
                        x1, z1, x2, z2 = x2, z2, x1, z1
                    end
                    for col = 1, row do
                        local x = (x2 - x1) / (row - 1) * (col - 1) + x1
                        local z = (z2 - z1) / (row - 1) * (col - 1) + z1
                        table.insert(pos_list, { x, z })
                    end
                end
            else
                for i = 1, data.anchor - 1 do
                    local x = (px2 - px1) / (data.anchor - 1) * i + px1
                    local z = (pz2 - pz1) / (data.anchor - 1) * i + pz1
                    table.insert(pos_list, { x, z })
                end
                for i = 1, data.anchor - 1 do
                    local x = (px3 - px2) / (data.anchor - 1) * i + px2
                    local z = (pz3 - pz2) / (data.anchor - 1) * i + pz2
                    table.insert(pos_list, { x, z })
                end
                for i = 1, data.anchor - 1 do
                    local x = (px1 - px3) / (data.anchor - 1) * i + px3
                    local z = (pz1 - pz3) / (data.anchor - 1) * i + pz3
                    table.insert(pos_list, { x, z })
                end
            end
        elseif type == 'square' or type == 'rectangle' then
            local nx = data.anchor
            local ny = type == 'rectangle' and data.anchor2 or nx
            local ly = 0
            local lx = 0
            if CPMA.DATA.RECT_ANCHOR_CENTER then
                ly = data.range * (ny - 1) / 2
                lx = data.range * (nx - 1) / 2
            end
            for i = 1, ny do
                local sx = (data.range * (i - 1) - ly) * math.cos((90 + data.angle) / 180 * pi)
                local sz = (data.range * (i - 1) - ly) * math.sin((90 + data.angle) / 180 * pi)
                for j = 1, nx do
                    local idx = j - 1
                    if math.fmod(i, 2) == 0 then
                        idx = nx - 1 - idx
                    end
                    local x = sx + (data.range * idx - lx) * math.cos(data.angle / 180 * pi)
                    local z = sz + (data.range * idx - lx) * math.sin(data.angle / 180 * pi)
                    table.insert(pos_list, { x, z })
                end
            end
        elseif type == 'heart' then
            if CPMA.DATA.FULL_PLACEMENT then
                local range = data.range / 4
                if data.anchor < 4 then
                    data.anchor = 4
                end
                --local n = math.floor((data.anchor - 1) * 2 / pi + 0.5)
                local n = math.floor(1 / math.sin(0.5 * pi / (data.anchor - 1)))
                if n > 1 then
                    local dr = range * 2 / n
                    local px1, pz1 = _rotate(-range * 2 + dr, -dr, data.angle)
                    local px2, pz2 = _rotate(0, -range * 2, data.angle)
                    local px3, pz3 = _rotate(range * 2 - dr, -dr, data.angle)
                    local px4, pz4 = _rotate(0, range * 2 - dr * 2, data.angle)
                    for i = 1, n do
                        local x1 = (px4 - px1) / (n - 1) * (i - 1) + px1
                        local z1 = (pz4 - pz1) / (n - 1) * (i - 1) + pz1
                        local x2 = (px3 - px2) / (n - 1) * (i - 1) + px2
                        local z2 = (pz3 - pz2) / (n - 1) * (i - 1) + pz2
                        if math.fmod(i, 2) == 0 then
                            x1, z1, x2, z2 = x2, z2, x1, z1
                        end
                        for j = 1, n do
                            local x = (x2 - x1) / (n - 1) * (j - 1) + x1
                            local z = (z2 - z1) / (n - 1) * (j - 1) + z1
                            table.insert(pos_list, { x, z })
                        end
                    end

                    local angle_delta = 180 / (data.anchor - 1)
                    local r_delta = range * math.sqrt(2) * math.sin(angle_delta / 360 * pi) * 2
                    local n_circle = math.ceil(n / 2)
                    local outer_circle = true
                    local anchor = data.anchor
                    local circle_r = range * math.sqrt(2)
                    for l = 1, n_circle do
                        for i = 1, anchor do
                            local angle = -45 + (i - 1) * angle_delta
                            local x = circle_r * math.cos(angle / 180 * pi) + range
                            local z = circle_r * math.sin(angle / 180 * pi) + range
                            x, z = _rotate(x, z, data.angle)
                            table.insert(pos_list, { x, z })
                        end
                        local start_idx = outer_circle and 2 or 1
                        for i = start_idx, anchor do
                            local angle = 45 + (i - 1) * angle_delta
                            local x = circle_r * math.cos(angle / 180 * pi) - range
                            local z = circle_r * math.sin(angle / 180 * pi) + range
                            x, z = _rotate(x, z, data.angle)
                            table.insert(pos_list, { x, z })
                        end
                        outer_circle = false

                        circle_r = (range - dr * l) * math.sqrt(2)
                        if circle_r <= 0 then
                            if circle_r >= 0 then
                                table.insert(pos_list, {_rotate(range, range, data.angle)})
                                table.insert(pos_list, {_rotate(-range, range, data.angle)})
                            end
                            break
                        end
                        anchor = math.floor(180 / (math.asin(r_delta / 2 / circle_r) * 360 / pi))
                        if anchor <= 0 then
                            break
                        end
                        angle_delta = 180 / anchor
                        anchor = anchor + 1
                    end
                end
            else
                local range = data.range / 4
                local circle_r = range * math.sqrt(2)
                local angle_delta = data.anchor == 1 and 180 or 180 / (data.anchor - 1)
                for i = 1, data.anchor do
                    local angle = -45 + (i - 1) * angle_delta
                    local x = circle_r * math.cos(angle / 180 * pi) + range
                    local z = circle_r * math.sin(angle / 180 * pi) + range
                    x, z = _rotate(x, z, data.angle)
                    table.insert(pos_list, { x, z })
                end

                for i = 2, data.anchor do
                    local angle = 45 + (i - 1) * angle_delta
                    local x = circle_r * math.cos(angle / 180 * pi) - range
                    local z = circle_r * math.sin(angle / 180 * pi) + range
                    x, z = _rotate(x, z, data.angle)
                    table.insert(pos_list, { x, z })
                end

                local px1, pz1 = _rotate(-range * 2, 0, data.angle)
                local px2, pz2 = _rotate(0, -range * 2, data.angle)
                local px3, pz3 = _rotate(range * 2, 0, data.angle)
                local n = math.floor((data.anchor - 1) * 2 / pi + 0.5)
                --local n = 2 * math.floor(0.5 / math.sin(0.5 * pi / (data.anchor - 1)) + 0.5)
                for i = 1, n do
                    local x = (px2 - px1) / n * i + px1
                    local z = (pz2 - pz1) / n * i + pz1
                    table.insert(pos_list, { x, z })
                end
                for i = 1, n - 1 do
                    local x = (px3 - px2) / n * i + px2
                    local z = (pz3 - pz2) / n * i + pz2
                    table.insert(pos_list, { x, z })
                end
            end
        end

        if type == 'circle' and data.arc == 360 then
            local scale = math.sqrt(1.385 * 1.385 / 12 * data.range) / outer_scale
            self.outline.Transform:SetScale(scale, scale, scale)
            self.outline:Show()
        else
            self.outline:Hide()
        end

        if CPMA.DATA.CENTER_ANCHOR and _center_anchor_types[type] then
            table.insert(pos_list, { 0, 0 })
        end

        if #pos_list ~= #self.anchors then
            for _, anchor in ipairs(self.anchors) do
                if anchor and anchor:IsValid() then
                    anchor:Remove()
                end
            end
            self.anchors = {}
            for _ = 1, #pos_list do
                local anchor = SpawnPrefab('circle_anchor')
                table.insert(self.anchors, anchor)
            end
        end

        --local start_scale = 0.25
        --local scale_delta = #pos_list == 1 and 0.1 or 0.1 / (#pos_list - 1)
        local px, _, pz = self:GetPosition():Get()
        for i, pos in ipairs(pos_list) do
            if self.anchors[i] and self.anchors[i]:IsValid() then
                self.anchors[i].Transform:SetPosition(pos[1] + px, 0, pos[2] + pz)
                --local scale = start_scale + scale_delta * (i - 1)
                --self.anchors[i].Transform:SetScale(scale, scale, scale)
            end
        end
    end

    function inst:UpdateLineData(px2, _, pz2)
        local px1, _, pz1 = self:GetPosition():Get()
        local range = math.sqrt((px1 - px2) * (px1 - px2) + (pz1 - pz2) * (pz1 - pz2))
        CPMA.DATA.SETTING.line.range = range
        if range > 0 then
            local cos = (px2 - px1) / range
            local angle = math.acos(cos) / pi * 180
            if pz2 < pz1 then
                angle = 360 - angle
            end
            CPMA.DATA.SETTING.line.angle = angle
        end
        if ThePlayer.HUD and ThePlayer.HUD.controls and ThePlayer.HUD.controls.CPMAPanel then
            ThePlayer.HUD.controls.CPMAPanel:RefreshSettings()
        end
        self:SetData()
    end

    inst:ListenForEvent("onremove", function(_inst)
        if _inst.anchors then
            for _, anchor in pairs(_inst.anchors) do
                if anchor and anchor:IsValid() then
                    anchor:Remove()
                end
            end
        end
    end)

    inst:DoTaskInTime(0, function(_inst)
        _inst:SetData()
    end)

    return inst
end

return Prefab("circle_anchor", anchor_fn), Prefab("circle_helper", fn), Prefab('circle_center', center_fn)
