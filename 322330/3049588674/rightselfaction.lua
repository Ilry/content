local needctrl = GetModConfigData("right self need ctrl")
-- 该文件定义了角色右键自身的动作
local action = Action({rmb = true, distance = 1})
action.id = "RIGHTSELFACTION2HM"
action.strfn = function(act)
    return act.doer ~= nil and ((act.doer.rightselfstrfn2hm and act.doer.rightselfstrfn2hm(act)) or string.upper(act.doer.prefab)) or nil
end
action.fn = function(act) if act.doer and act.doer.rightselfaction2hm_fn then return act.doer.rightselfaction2hm_fn(act) end end
-- 添加动作
AddAction(action)
-- 动作触发器
AddComponentAction("SCENE", "rightselfaction2hm", function(inst, doer, actions)
    if inst == doer and (not needctrl or (inst.components.playercontroller and inst.components.playercontroller:IsControlPressed(CONTROL_FORCE_STACK))) and
        inst:HasTag("player") and inst.rightselfaction2hm and inst.rightselfaction2hm:value() == true and
        (inst.rightselfaction2hm_condition == nil or inst.rightselfaction2hm_condition(inst)) then table.insert(actions, ACTIONS.RIGHTSELFACTION2HM) end
end)
-- 角色状态图里加入动作执行函数和响应动画
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.RIGHTSELFACTION2HM, function(inst, action)
    if inst.rightselfaction2hm_handlerfn then inst.rightselfaction2hm_handlerfn(inst, action) end
    return inst.rightselfaction2hm_handler
end))
-- 角色状态图里加入动作响应动画
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.RIGHTSELFACTION2HM, function(inst, action)
    if inst.rightselfaction2hm_handlerfn then inst.rightselfaction2hm_handlerfn(inst, action) end
    return inst.rightselfaction2hm_handler
end))
local function endcooldown(inst)
    inst.rightselfaction2hm:set(true)
    inst.rightactioncdtask2hm = nil
end
local function successcd(action)
    if not action.doer.rightactioncdtask2hm then
        action.doer:DoTaskInTime(action.doer.rightselfaction2hm_oncecd or action.doer.rightselfaction2hm_cooldown, endcooldown)
    end
    if action.doer.rightselfaction2hm_oncecd then action.doer.rightselfaction2hm_oncecd = nil end
    action.doer.rightselfaction2hm:set(false)
    if action.doer.rightselfaction2hm_str and action.doer.components.talker then action.doer.components.talker:Say(action.doer.rightselfaction2hm_str) end
end

-- 重设CD
function Overriderightactioncd(inst, cd)
    if inst.rightselfaction2hm then
        inst.rightselfaction2hm:set(false)
        if inst.rightactioncdtask2hm then inst.rightactioncdtask2hm:Cancel() end
        inst.rightactioncdtask2hm = inst:DoTaskInTime(cd or inst.rightselfaction2hm_cooldown, endcooldown)
    end
end

-- 低理智读魔法书会被影怪袭击
local SHADOWCREATURE_MUST_TAGS = {"shadowcreature", "_combat", "locomotor"}
local SHADOWCREATURE_CANT_TAGS = {"INLIMBO", "notaunt"}
local function OnReadMagicBookFn(inst, book)
    if inst.components.sanity:IsInsane() then
        local x, y, z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 16, SHADOWCREATURE_MUST_TAGS, SHADOWCREATURE_CANT_TAGS)
        if #ents < TUNING.BOOK_MAX_SHADOWCREATURES then TheWorld.components.shadowcreaturespawner:SpawnShadowCreature(inst) end
    end
end
local function prebook(inst, action)
    if action.doer and action.doer.rightselfaction2hm_book then
        local book = SpawnPrefab(action.doer.rightselfaction2hm_book)
        if book ~= nil then
            book.persists = false
            book:RemoveFromScene()
            book:DoTaskInTime(3, book.Remove)
            if action.doer and action.doer.components.reader and (action.doer.components.reader.sanity_mult or 1) > 1 and book.components.book and
                book.components.book.read_sanity then
                book.components.book:SetReadSanity(book.components.book.read_sanity / (action.doer.components.reader.sanity_mult or 1))
            end
            action.target = book
        end
    end
end
local function rightbookaction(action)
    if action.target and action.target.components.book and action.doer and not action.doer.rightactioncdtask2hm and action.doer.rightselfaction2hm then
        local hasReaderComponent = action.doer.components.reader ~= nil
        if not hasReaderComponent then
            action.doer:AddComponent("reader")
            action.doer.components.reader:SetOnReadFn(OnReadMagicBookFn)
        end
        local success, reason = action.doer.components.reader:Read(action.target)
        if not hasReaderComponent then action.doer:RemoveComponent("reader") end
        if success then successcd(action) end
        if not hasReaderComponent then action.doer:RemoveComponent("reader") end
        return success, reason
    end
end

-- 快速添加右键自身阅读魔法书动作
function AddReadBookRightSelfAction(roleprefab, bookprefab, cd, successstr)
    AddPrefabPostInit(roleprefab, function(inst)
        if inst.rightselfaction2hm then return end
        inst.rightselfaction2hm = net_bool(inst.GUID, "player.rightselfaction2hm", "rightselfaction2hmdirty")
        inst.rightselfaction2hm:set(true)
        inst.rightselfaction2hm_cooldown = cd
        inst.rightselfaction2hm_handler = "book"
        if not TheWorld.ismastersim then return end
        inst.rightselfaction2hm_handlerfn = prebook
        inst.rightselfaction2hm_str = successstr
        inst.rightselfaction2hm_book = bookprefab
        inst:AddComponent("rightselfaction2hm")
        inst.rightselfaction2hm_fn = rightbookaction
    end)
    local upperroleprefab = string.upper(roleprefab)
    local upperbookprefab = string.upper(bookprefab)
    STRINGS.ACTIONS.RIGHTSELFACTION2HM = STRINGS.ACTIONS.RIGHTSELFACTION2HM or STRINGS.ACTIONS.ACTIVATE
    STRINGS.ACTIONS.RIGHTSELFACTION2HM[upperroleprefab] = STRINGS.NAMES[upperbookprefab]
    if roleprefab == "wilson" then
        roleprefab = "generic"
        upperroleprefab = string.upper(roleprefab)
    end
    STRINGS.CHARACTERS[upperroleprefab].ACTIONFAIL.RIGHTSELFACTION2HM = {GENERIC = STRINGS.CHARACTERS[upperroleprefab].DESCRIBE[upperbookprefab]}
end

-- 快速添加右键自身动作
local function rightaction(action)
    if action.doer and not action.doer.rightactioncdtask2hm and action.doer.rightselfaction2hm and action.doer.rightselfaction2hm_fnInternal then
        local success, reason = action.doer.rightselfaction2hm_fnInternal(action)
        if success then successcd(action) end
        return success, reason
    end
end
function AddRightSelfAction(roleprefab, cd, handler, handlerfn, fn, rightstr, successstr, failstr, conditionfn)
    AddPrefabPostInit(roleprefab, function(inst)
        if inst.rightselfaction2hm then return end
        inst.rightselfaction2hm = net_bool(inst.GUID, "player.rightselfaction2hm", "rightselfaction2hmdirty")
        inst.rightselfaction2hm:set(true)
        inst.rightselfaction2hm_cooldown = cd
        inst.rightselfaction2hm_handler = handler
        inst.rightselfaction2hm_condition = conditionfn
        inst.rightselfaction2hm_handlerfn = handlerfn
        if not TheWorld.ismastersim then return end
        inst:AddComponent("rightselfaction2hm")
        inst.rightselfaction2hm_str = successstr
        inst.rightselfaction2hm_fnInternal = fn or truefn
        inst.rightselfaction2hm_fn = rightaction
    end)
    local upperroleprefab = string.upper(roleprefab)
    STRINGS.ACTIONS.RIGHTSELFACTION2HM = STRINGS.ACTIONS.RIGHTSELFACTION2HM or STRINGS.ACTIONS.ACTIVATE
    STRINGS.ACTIONS.RIGHTSELFACTION2HM[upperroleprefab] = rightstr
    if failstr then
        if roleprefab == "wilson" then
            roleprefab = "generic"
            upperroleprefab = string.upper(roleprefab)
        end
        STRINGS.CHARACTERS[upperroleprefab].ACTIONFAIL.RIGHTSELFACTION2HM = {GENERIC = failstr}
    end
end
