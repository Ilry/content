local function center_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:SetCanSleep(false)
    inst.persists = false

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

    function inst:UpdatePos(x, y, z)
        self.Transform:SetPosition(x, y, z)
        self.grid.Transform:SetPosition(x, y, z)
    end

    local label = inst.entity:AddLabel()

    label:SetFontSize(18)
    label:SetFont(BODYTEXTFONT)
    label:SetWorldOffset(0, 1.2, 0)

    label:SetText(STRINGS.TURD.LABEL_PLEASE_SELECT)
    label:SetColour(1, 1, 0)
    label:Enable(true)
    inst.label = label

    return inst
end

local function anchor_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst:AddTag("CLASSIFIED")
    inst:AddTag("NOCLICK")
    inst:AddTag("placer")

    inst.grid = SpawnPrefab('gridplacer')
    inst.grid.AnimState:SetSortOrder(5)
    inst:ListenForEvent("onremove", function(_inst)
        _inst.grid:Remove()
    end)

    function inst:UpdatePos(x, y, z)
        self.Transform:SetPosition(x, y, z)
        self.grid.Transform:SetPosition(x, y, z)
    end

    function inst:UpdateAddColour(r, g, b, a)
        self.grid.AnimState:SetAddColour(r, g, b, a)
        self.label:SetColour(r, g, b)
    end

    function inst:UpdateVisible(shown)
        if shown then
            self:Show()
            self.grid:Show()
        else
            self:Hide()
            self.grid:Hide()
        end
    end

    local label = inst.entity:AddLabel()

    label:SetFontSize(18)
    label:SetFont(BODYTEXTFONT)
    label:SetWorldOffset(0, 0.8, 0)

    label:Enable(true)
    inst.label = label

    return inst
end

local function SpawnAnchor(turf, tx, ty)
    local anchor = SpawnPrefab('turf_anchor')
    anchor.label:SetText(TURDGetTurfName(turf))
    anchor.turd_turf = turf
    anchor.turd_tx = tx
    anchor.turd_ty = ty
    return anchor
end

local function record_helper_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:SetCanSleep(false)
    inst.persists = false

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

    local label = inst.entity:AddLabel()

    label:SetFontSize(18)
    label:SetFont(BODYTEXTFONT)
    label:SetWorldOffset(0, 1.2, 0)

    label:SetText(STRINGS.TURD.LABEL_TURF_CENTER)
    label:SetColour(1, 1, 0)
    label:Enable(true)
    inst.label = label

    inst.color = { x = 0, y = 1, z = 0 }
    inst.anchors = {}

    function inst:GetTurfKey(tx, ty)
        return tostring(tx) .. '#' .. tostring(ty)
    end

    function inst:SelectTurf(tx, ty)
        local key = self:GetTurfKey(tx, ty)
        if self.anchors[key] then
            return
        end
        local x, y, z = TurfIndexToPos(tx, ty)
        local turf = TheWorld.Map:GetTileAtPoint(x, y, z)
        local anchor = SpawnAnchor(turf, tx, ty)
        anchor:UpdateAddColour(0, 1, 0, 0)
        anchor:UpdatePos(x, y, z)
        self.anchors[key] = anchor
    end

    function inst:DeselectTurf(tx, ty)
        local key = self:GetTurfKey(tx, ty)
        if self.anchors[key] then
            self.anchors[key]:Remove()
            self.anchors[key] = nil
        end
    end

    function inst:HandleSelection(tx, ty)
        local key = self:GetTurfKey(tx, ty)
        if self.anchors[key] then
            self:DeselectTurf(tx, ty)
        else
            self:SelectTurf(tx, ty)
        end
    end

    function inst:GetTurfData()
        local record = {}
        for _, anchor in pairs(self.anchors) do
            if anchor:IsValid() then
                local x, y, z = TurfIndexToPos(anchor.turd_tx, anchor.turd_ty)
                local turf = TheWorld.Map:GetTileAtPoint(x, y, z)
                table.insert(record, {
                    turf = turf, tx = anchor.turd_tx, ty = anchor.turd_ty
                })
            end
        end
        return record
    end

    inst:ListenForEvent("onremove", function(_inst)
        for _, anchor in pairs(_inst.anchors) do
            _inst:DeselectTurf(anchor.turd_tx, anchor.turd_ty)
        end
    end)

    return inst
end

local function play_helper_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:SetCanSleep(false)
    inst.persists = false

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

    local label = inst.entity:AddLabel()

    label:SetFontSize(18)
    label:SetFont(BODYTEXTFONT)
    label:SetWorldOffset(0, 1.2, 0)

    label:SetText(STRINGS.TURD.LABEL_TURF_CENTER)
    label:SetColour(1, 1, 0)
    label:Enable(true)
    inst.label = label

    inst.anchors = {}
    function inst:SetRecord(record)
        self.record = record
        for anchor in pairs(self.anchors) do
            if anchor:IsValid() then
                anchor:Remove()
            end
        end
        self.anchors = {}
        local bx, by = record.tx, record.ty
        for _, item in ipairs(record.data) do
            local anchor = SpawnAnchor(item.turf, item.tx, item.ty)
            anchor:UpdateAddColour(1, 0, 0, 0)
            self.anchors[anchor] = { dx = item.tx - bx, dy = item.ty - by }
        end

        TURD.LAST.RECORD = json.decode(json.encode(record))
        self:UpdatePos(self:GetPosition():Get())
    end

    function inst:UpdatePos(x, y, z)
        TURD.LAST.POS = { x, y, z }
        TURD.SaveLast()
        self.Transform:SetPosition(x, y, z)
        local tx, ty = GetTurfIndex(x, y, z)
        for anchor, pos in pairs(self.anchors) do
            anchor:UpdatePos(TurfIndexToPos(tx + pos.dx, ty + pos.dy))
        end
    end

    inst:ListenForEvent("onremove", function(_inst)
        for anchor in pairs(_inst.anchors) do
            if anchor:IsValid() then
                anchor:Remove()
            end
        end
    end)

    return inst
end

return Prefab('turf_anchor', anchor_fn), Prefab('turf_center', center_fn), Prefab('turf_record_helper', record_helper_fn), Prefab('turf_play_helper', play_helper_fn)
