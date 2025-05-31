--------------------------------------------------------------------------
--[[ Dependencies ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ WXNavigation class definition ]]
--------------------------------------------------------------------------
local WXNavigation = Class(function(self, inst)

--------------------------------------------------------------------------
--[[ Public Member Variables ]]
--------------------------------------------------------------------------
    self.inst = inst
    self.engaged = false
    self.navtarget = nil
    self.previousAP = nil
    self.pointqueue = {}
    self.teleporting = false
    self.isshardtraveler = false
    self.noreceiver = false

--------------------------------------------------------------------------
--[[ Private Member Variables ]]
--------------------------------------------------------------------------

end)

--------------------------------------------------------------------------
--[[ Private constants ]]
--------------------------------------------------------------------------
local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local KEEP_WORKING_DIST = SEE_WORK_DIST + 6

local WX_TAG = { "wx" }
local TOFILL_MUST_TAGS = { "watersource" }
local FIND_CONTAINER_MUST_TAGS = { "_container" }
local FIND_SIGN_MUST_TAGS = { "sign" }
local SALTBOX_TAG = { "_container", "saltbox" }
local ICEBOX_TAG = { "_container", "fridge" }

local APChestList =
{
    "treasurechest",
    "treasurechest_upgraded",
    "statuerobobee",
}

local WChestList =
{
    "treasurechest",
    "treasurechest_upgraded",
}

--------------------------------------------------------------------------
--[[ Private member functions ]]
--------------------------------------------------------------------------
local function GetEquippedBackpack(inst)
    local backpack = EQUIPSLOTS.BACK ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BACK) or
        inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack == nil then
        for k, v in pairs(inst.components.inventory.equipslots) do
            if v:HasTag("backpack") and v.prefab ~= "seedpouch" and v.prefab ~= "candybag" then
                backpack = v
            end
        end
    end
    return backpack
end

local function IsTool(item)
    return item.components.tool ~= nil or
        item.components.farmtiller ~= nil or
        item.components.fishingrod ~= nil or
        item.components.finiteuses ~= nil or
        (item:HasTag("wateringcan") and
        item.components.finiteuses ~= nil and
        item.components.finiteuses:GetPercent() > 0) or
        item.prefab == "nightmare_timepiece"
end

local function IsFertilizer(item)
    return item.components.fertilizer ~= nil
end

local function IsAPChest(inst)
    for _, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            return
        end
        for k, _ in pairs(TheWorld.sentryward) do
            if k:IsValid() and not k:IsInLimbo() and inst:IsNear(k, SEE_WORK_DIST) and
                v:IsValid() and not v:IsInLimbo() and k:IsNear(v, SEE_WORK_DIST) then
                return
            end
        end
    end
    return table.contains(APChestList, inst.prefab) and inst.components.container ~= nil and
        inst.components.container:FindItem(function(item) return not IsTool(item) and not IsFertilizer(item) end) ~= nil
end

local function IsAPPreserverContainer(inst)
    for k, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            return
        end
        for k, _ in pairs(TheWorld.sentryward) do
            if k:IsValid() and not k:IsInLimbo() and inst:IsNear(k, SEE_WORK_DIST) and
                v:IsValid() and not v:IsInLimbo() and k:IsNear(v, SEE_WORK_DIST) then
                return
            end
        end
    end
    return (inst.prefab == "icebox" or inst.prefab == "saltbox" or inst.prefab == "fish_box") and
        inst.components.container ~= nil and inst.components.container:FindItem(function(item) return not IsFertilizer(item) end) ~= nil
end

local function IsAPFertilizerChest(inst)
    for _, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            return
        end
        for k, _ in pairs(TheWorld.sentryward) do
            if k:IsValid() and not k:IsInLimbo() and inst:IsNear(k, SEE_WORK_DIST) and
                v:IsValid() and not v:IsInLimbo() and k:IsNear(v, SEE_WORK_DIST) then
                return
            end
        end
    end
    return inst.prefab == "treasurechest" and inst.components.container ~= nil and
        inst.components.container:FindItem(function(item) return not IsTool(item) and IsFertilizer(item) end) ~= nil
end

local function IsAPFertilizerPreserverContainer(inst)
    for k, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            return
        end
        for k, _ in pairs(TheWorld.sentryward) do
            if k:IsValid() and not k:IsInLimbo() and inst:IsNear(k, SEE_WORK_DIST) and
                v:IsValid() and not v:IsInLimbo() and k:IsNear(v, SEE_WORK_DIST) then
                return
            end
        end
    end
    return (inst.prefab == "icebox" or inst.prefab == "saltbox" or inst.prefab == "fish_box") and
        inst.components.container ~= nil and inst.components.container:FindItem(function(item) return IsFertilizer(item) end) ~= nil
end

local function IsWWaterChest(inst)
    return inst.prefab == "waterchest" and
        inst.components.container ~= nil and
        not inst.components.container:IsFull()
end

local function IsAPWaterChest(inst)
    for k, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            return
        end
    end
    return inst.prefab == "waterchest" and
        inst.components.container ~= nil and
        not inst.components.container:IsEmpty()
end

local function GetClosest(target, entities)
    local max_dist = nil
    local min_dist = nil

    local closest = nil

    local tpos = Vector3(target.Transform:GetWorldPosition())

    for k,v in pairs(entities) do
        local epos = Vector3(v.Transform:GetWorldPosition())
        local dist = distsq(tpos, epos)

        if not max_dist or dist > max_dist then
            max_dist = dist
        end

        if not min_dist or dist < min_dist then
            min_dist = dist
            closest = v
        end
    end

    return closest
end

local function GetScheduled(inst, sentrywardList)
    local wxdiviningrodbase_active = {}
    for k, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and v.components.shelf.itemonshelf ~= nil then
            table.insert(wxdiviningrodbase_active, v)
        end
    end

    local ent = nil
    local maxweight = 0
    local nowtime = TheWorld.components.worldstate.data.cycles
    for k, v in pairs(sentrywardList) do
        repeat
            if k:IsValid() then
                -- Release invalid engagement
                if v.server ~= nil and (not v.server:IsValid() or
                    (not v.server.components.wxtype:IsConv() and
                    not v.server.components.wxtype:IsSeaConv()) or
                    inst.components.follower.leader ~= nil) then
                    v.server = nil
                end
                -- Special case
                -- Ignore watersource.available and TOFILL_MUST_TAGS to include frozen ponds.
                local pond = FindEntity(k, SEE_WORK_DIST, function(ent)
                    return ent.components.watersource ~= nil
                end)
                if pond ~= nil and inst.components.wxtype:NeedsFill() then
                    -- Lock the choice
                    if sentrywardList[k] ~= nil then
                        sentrywardList[k].server = inst
                    end
                    return k
                elseif pond ~= nil then
                    break -- Used as "continue"
                end
                -- Find best choice
                local newweight = (nowtime - v.lasttime) * v.load
                if not inst:IsNear(k, SEE_WORK_DIST) and v.server == nil and newweight >= maxweight and
                    not k:IsNear(GetClosest(k, wxdiviningrodbase_active), SEE_WORK_DIST) then
                    ent = k
                    maxweight = newweight
                end
            else
                table.remove(sentrywardList, k)
            end
        until true
    end

    -- Lock the choice
    if ent ~= nil and sentrywardList[ent] ~= nil then
        sentrywardList[ent].server = inst
    end
    return ent
end

--------------------------------------------------------------------------
--[[ Private event handlers ]]
--------------------------------------------------------------------------

--------------------------------------------------------------------------
--[[ Public member functions ]]
--------------------------------------------------------------------------
function WXNavigation:UnloadCargo()
    local wxdiviningrodbase = FindEntity(self.inst, SEE_WORK_DIST, function(ent)
        return ent.prefab == "wxdiviningrodbase" and ent.components.shelf.itemonshelf ~= nil
    end)
    if wxdiviningrodbase == nil then
        return nil
    end

    if self.previousAP ~= nil and TheWorld.sentryward[self.previousAP] ~= nil then
        TheWorld.sentryward[self.previousAP].lasttime = TheWorld.components.worldstate.data.cycles
        TheWorld.sentryward[self.previousAP].load = 1
    end

    local backpack = GetEquippedBackpack(self.inst)
    local item = nil
    if backpack ~= nil and backpack.components.container ~= nil and not backpack.components.container:IsEmpty() then
        for _, item in pairs(backpack.components.container.slots) do
            if item.components.edible ~= nil and (item.components.edible.foodtype == FOODTYPE.VEGGIE or
                item.components.edible.foodtype == FOODTYPE.MEAT) and
                item.components.cookable ~= nil and item:HasTag("cookable") then
                -- Smart Signed Saltbox
                local smartsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, SALTBOX_TAG)
                if smartsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smartsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed SaltBox
                local emptysmartsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, SALTBOX_TAG)
                if smartsaltbox == nil and emptysmartsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmartsaltbox, ACTIONS.STORE, item)
                end
                -- Signed Saltbox
                local signedsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, SALTBOX_TAG)
                if signedsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedsaltbox, ACTIONS.STORE, item)
                end
                -- Unsigned Saltbox
                local unsignedsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if unsignedsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Saltbox
                local emptysaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if emptysaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysaltbox, ACTIONS.STORE, item)
                end
                -- Any Saltbox
                local anysaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, SALTBOX_TAG)
                if anysaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, anysaltbox, ACTIONS.STORE, item)
                end
            end
            if item.components.edible ~= nil and item.components.perishable ~= nil and
                not item:HasTag("smallcreature") and not item:HasTag("smalloceancreature") then
                -- Smart Signed Icebox
                local smarticebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, ICEBOX_TAG)
                if smarticebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smarticebox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed Icebox
                local emptysmarticebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, ICEBOX_TAG)
                if smarticebox == nil and emptysmarticebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmarticebox, ACTIONS.STORE, item)
                end
                -- Signed Icebox
                local signedicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, ICEBOX_TAG)
                if signedicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedicebox, ACTIONS.STORE, item)
                end
                -- Unsigned Icebox
                local unsignedicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if unsignedicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedicebox, ACTIONS.STORE, item)
                end
                -- Empty Icebox
                local emptyicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if emptyicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptyicebox, ACTIONS.STORE, item)
                end
                -- Any Icebox
                local anyicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, ICEBOX_TAG)
                if anyicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, anyicebox, ACTIONS.STORE, item)
                end
            else
                -- Smart Signed Chest
                local smartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                if smartchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smartchest, ACTIONS.STORE, item)
                end
                -- Allocated Smart Signed Chest
                local allocatedsmartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                -- Empty Smart Signed Chest
                local emptysmartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and next(ent.components.container.slots) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if allocatedsmartchest == nil and emptysmartchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, item)
                end
                -- Signed Chest
                local signedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                                (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                        end, FIND_SIGN_MUST_TAGS)
                end, FIND_CONTAINER_MUST_TAGS)
                if signedchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedchest, ACTIONS.STORE, item)
                end
                -- Unsigned Chest
                local unsignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
                end
                -- Any Signed Chest
                local anysignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                                (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                        end, FIND_SIGN_MUST_TAGS)
                end, FIND_CONTAINER_MUST_TAGS)
                -- Empty Chest
                local emptychest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
                elseif unsignedchest == nil and anysignedchest == nil and emptychest == nil then
                    if self.inst.container_task == nil then
                        self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                            self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_CONTAINER"))
                        end, 0)
                        self.inst:DoTaskInTime(60, function()
                            if self.inst.container_task ~= nil then
                                self.inst.container_task:Cancel()
                                self.inst.container_task = nil
                            end
                        end)
                    end
                end
            end
        end
    elseif next(self.inst.components.inventory.itemslots) ~= nil then
        for _, item in pairs(self.inst.components.inventory.itemslots) do
            if item.components.edible ~= nil and (item.components.edible.foodtype == FOODTYPE.VEGGIE or
                item.components.edible.foodtype == FOODTYPE.MEAT) and
                item.components.cookable ~= nil and item:HasTag("cookable") then
                -- Smart Signed Saltbox
                local smartsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, SALTBOX_TAG)
                if smartsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smartsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed SaltBox
                local emptysmartsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, SALTBOX_TAG)
                if smartsaltbox == nil and emptysmartsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmartsaltbox, ACTIONS.STORE, item)
                end
                -- Signed Saltbox
                local signedsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, SALTBOX_TAG)
                if signedsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedsaltbox, ACTIONS.STORE, item)
                end
                -- Unsigned Saltbox
                local unsignedsaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if unsignedsaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedsaltbox, ACTIONS.STORE, item)
                end
                -- Empty Saltbox
                local emptysaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, SALTBOX_TAG)
                if emptysaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysaltbox, ACTIONS.STORE, item)
                end
                -- Any Saltbox
                local anysaltbox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "saltbox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, SALTBOX_TAG)
                if anysaltbox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, anysaltbox, ACTIONS.STORE, item)
                end
            end
            if item.components.edible ~= nil and item.components.perishable ~= nil and
                not item:HasTag("smallcreature") and not item:HasTag("smalloceancreature") then
                -- Smart Signed Icebox
                local smarticebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, ICEBOX_TAG)
                if smarticebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smarticebox, ACTIONS.STORE, item)
                end
                -- Empty Smart Signed Icebox
                local emptysmarticebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        next(ent.components.container.slots) == nil
                end, ICEBOX_TAG)
                if smarticebox == nil and emptysmarticebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmarticebox, ACTIONS.STORE, item)
                end
                -- Signed Icebox
                local signedicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and sign.components.drawable:GetImage() == item.prefab
                        end, FIND_SIGN_MUST_TAGS)
                end, ICEBOX_TAG)
                if signedicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedicebox, ACTIONS.STORE, item)
                end
                -- Unsigned Icebox
                local unsignedicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and
                        not ent.components.container:IsFull() and ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if unsignedicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedicebox, ACTIONS.STORE, item)
                end
                -- Empty Icebox
                local emptyicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, ICEBOX_TAG)
                if emptyicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptyicebox, ACTIONS.STORE, item)
                end
                -- Any Icebox
                local anyicebox = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return ent.prefab == "icebox" and ent.components.container ~= nil and not ent.components.container:IsFull()
                end, ICEBOX_TAG)
                if anyicebox ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, anyicebox, ACTIONS.STORE, item)
                end
            elseif (#self.inst.components.inventory:FindItems(function(secondaryitem)
                    return secondaryitem:HasTag("wateringcan") and
                        secondaryitem.components.finiteuses ~= nil and
                        secondaryitem.components.finiteuses:GetPercent() == 1
                end) > 1 and item:HasTag("wateringcan") and
                item.components.finiteuses ~= nil and
                item.components.finiteuses:GetPercent() == 1) or
                (not IsTool(item) and not item:HasTag("wateringcan")) then
                -- Smart Signed Chest
                local smartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                if smartchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, smartchest, ACTIONS.STORE, item)
                end
                -- Allocated Smart Signed Chest
                local allocatedsmartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    local _, firstitem = next(ent.components.container.slots)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        firstitem ~= nil and firstitem.prefab == item.prefab
                end, FIND_CONTAINER_MUST_TAGS)
                -- Empty Smart Signed Chest
                local emptysmartchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.smart_minisign ~= nil and ent.components.smart_minisign.sign ~= nil and
                        ent.components.container ~= nil and next(ent.components.container.slots) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if allocatedsmartchest == nil and emptysmartchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptysmartchest, ACTIONS.STORE, item)
                end
                -- Signed Chest
                local signedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and not ent.components.container:IsFull() and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                                (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                        end, FIND_SIGN_MUST_TAGS)
                end, FIND_CONTAINER_MUST_TAGS)
                if signedchest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, signedchest, ACTIONS.STORE, item)
                end
                -- Unsigned Chest
                local unsignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and
                        ent.components.container:Has(item.prefab, 1) and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
                end
                -- Any Signed Chest
                local anysignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and
                        FindEntity(ent, .5, function(sign)
                            return sign.components.drawable ~= nil and (sign.components.drawable:GetImage() == item.prefab or
                                (sign.components.drawable:GetImage() == "rock_avocado_fruit_rockhard" and item.prefab == "rock_avocado_fruit"))
                        end, FIND_SIGN_MUST_TAGS)
                end, FIND_CONTAINER_MUST_TAGS)
                -- Empty Chest
                local emptychest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                    return table.contains(WChestList, ent.prefab) and
                        ent.components.container ~= nil and ent.components.container:IsEmpty() and
                        FindEntity(ent, .5, function(sign) return sign.components.drawable ~= nil end, FIND_SIGN_MUST_TAGS) == nil
                end, FIND_CONTAINER_MUST_TAGS)
                if unsignedchest == nil and anysignedchest == nil and emptychest ~= nil then
                    --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                    return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
                elseif unsignedchest == nil and anysignedchest == nil and emptychest == nil then
                    if self.inst.container_task == nil then
                        self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                            self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_CONTAINER"))
                        end, 0)
                        self.inst:DoTaskInTime(60, function()
                            if self.inst.container_task ~= nil then
                                self.inst.container_task:Cancel()
                                self.inst.container_task = nil
                            end
                        end)
                    end
                end
            end
        end
    end
end

function WXNavigation:UnloadShip()
    local wxdiviningrodbase = FindEntity(self.inst, SEE_WORK_DIST, function(ent)
        return ent.prefab == "wxdiviningrodbase" and ent.components.shelf.itemonshelf ~= nil
    end)
    if wxdiviningrodbase == nil then
        return nil
    end

    if self.previousAP ~= nil and TheWorld.shipyard[self.previousAP] ~= nil then
        TheWorld.shipyard[self.previousAP].lasttime = TheWorld.components.worldstate.data.cycles
        TheWorld.shipyard[self.previousAP].load = 1
    end

    local backpack = GetEquippedBackpack(self.inst)
    if backpack ~= nil and backpack.components.container ~= nil and not backpack.components.container:IsEmpty() then
        for k, item in pairs(backpack.components.container.slots) do
            -- Unsigned Chest
            local unsignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                return ent.prefab == "waterchest" and ent.components.container ~= nil and
                    ent.components.container:Has(item.prefab, 1)
            end)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
            end
            -- Empty Chest
            local emptychest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                return ent.prefab == "waterchest" and ent.components.container ~= nil and ent.components.container:IsEmpty()
            end)
            if unsignedchest == nil and emptychest ~= nil then
                --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
            elseif unsignedchest == nil and emptychest == nil then
                if self.inst.container_task == nil then
                    self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                        self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_CONTAINER"))
                    end, 0)
                    self.inst:DoTaskInTime(60, function()
                        if self.inst.container_task ~= nil then
                            self.inst.container_task:Cancel()
                            self.inst.container_task = nil
                        end
                    end)
                end
            end
        end
    elseif next(self.inst.components.inventory.itemslots) ~= nil then
        for k, item in pairs(self.inst.components.inventory.itemslots) do
            -- Unsigned Chest
            local unsignedchest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                return ent.prefab == "waterchest" and ent.components.container ~= nil and
                    ent.components.container:Has(item.prefab, 1)
            end)
            if unsignedchest ~= nil and not unsignedchest.components.container:IsFull() then
                --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                return BufferedAction(self.inst, unsignedchest, ACTIONS.STORE, item)
            end
            -- Empty Chest
            local emptychest = FindEntity(wxdiviningrodbase, SEE_WORK_DIST, function(ent)
                return ent.prefab == "waterchest" and ent.components.container ~= nil and ent.components.container:IsEmpty()
            end)
            if unsignedchest == nil and emptychest ~= nil then
                --if next(self.pointqueue) ~= nil then self.pointqueue = {} end
                return BufferedAction(self.inst, emptychest, ACTIONS.STORE, item)
            elseif unsignedchest == nil and emptychest == nil then
                if self.inst.container_task == nil then
                    self.inst.container_task = self.inst:DoPeriodicTask(60, function()
                        self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_NO_CONTAINER"))
                    end, 0)
                    self.inst:DoTaskInTime(60, function()
                        if self.inst.container_task ~= nil then
                            self.inst.container_task:Cancel()
                            self.inst.container_task = nil
                        end
                    end)
                end
            end
        end
    end
end

function WXNavigation:LoadCargo()
    local sentryward = FindEntity(self.inst, SEE_WORK_DIST, function(ent) return ent.prefab == "sentryward" end)
    if sentryward == nil then
        return
    end

    -- Do not take tools or fertilizer.
    local container = FindEntity(sentryward, SEE_WORK_DIST, IsAPPreserverContainer, FIND_CONTAINER_MUST_TAGS)
    if container == nil then
        container = FindEntity(sentryward, SEE_WORK_DIST, IsAPChest, FIND_CONTAINER_MUST_TAGS)
    end
    -- Can take fertilizer if is not near anyone that requires fertilizer.
    local isnearagriAP = FindEntity(sentryward, SEE_WORK_DIST, function(ent)
        return ent.components.wxtype ~= nil and ent.components.wxtype:IsAgri() or ent.components.wxtype:IsHorti()
    end, WX_TAG) ~= nil
    if not isnearagriAP then
        if container == nil then
            container = FindEntity(sentryward, SEE_WORK_DIST, IsAPFertilizerPreserverContainer, FIND_CONTAINER_MUST_TAGS)
        end
        if container == nil then
            container = FindEntity(sentryward, SEE_WORK_DIST, IsAPFertilizerChest, FIND_CONTAINER_MUST_TAGS)
        end
    end
    if container == nil or container:GetCurrentPlatform() ~= self.inst:GetCurrentPlatform() then
        return
    end

    local item = container.components.container:FindItem(function(item) return not IsTool(item) and not IsFertilizer(item) end)
    if item == nil and not isnearagriAP then
        item = container.components.container:FindItem(function(item) return not IsTool(item) and IsFertilizer(item) end)
    end
    if item ~= nil then
        local backpack = GetEquippedBackpack(self.inst)
        if TheWorld.sentryward[sentryward] ~= nil then
            TheWorld.sentryward[sentryward].load = #self.inst.components.inventory.itemslots + 1
            if backpack ~= nil and backpack.components.container ~= nil then
                TheWorld.sentryward[sentryward].load = TheWorld.sentryward[sentryward].load +
                    #backpack.components.container.slots
            end
        end

        return BufferedAction(self.inst, container, ACTIONS.LOAD, item)
    end
end

function WXNavigation:LoadShip()
    local shipyard = FindEntity(self.inst, SEE_WORK_DIST, function(ent) return ent.prefab == "sea_yard" end)
    if shipyard == nil then
        return
    end

    local waterchest = FindEntity(shipyard, SEE_WORK_DIST, IsAPWaterChest, FIND_CONTAINER_MUST_TAGS)
    if waterchest == nil then
        return
    end

    local item = waterchest.components.container:FindItem(function(item) return true end)
    if item ~= nil then
        local backpack = GetEquippedBackpack(self.inst)
        if TheWorld.shipyard[shipyard] ~= nil then
            TheWorld.shipyard[shipyard].load = #self.inst.components.inventory.itemslots + 1
            if backpack ~= nil and backpack.components.container ~= nil then
                TheWorld.shipyard[shipyard].load = TheWorld.shipyard[shipyard].load +
                    #backpack.components.container.slots
            end
        end

        return BufferedAction(self.inst, waterchest, ACTIONS.LOAD, item)
    end
end

function WXNavigation:HasBundle()
    local backpack = GetEquippedBackpack(self.inst)
    return backpack ~= nil and backpack.components.container ~= nil and
        backpack.components.container:Has("bundle", 1) or
        self.inst.components.inventory:Has("bundle", 1)
end

function WXNavigation:HasSingleTicket()
    return self.inst.components.inventory:Has("nightmare_timepiece", 1)
end

local FindNavTargetFn = {}
FindNavTargetFn["wxdiviningrodbase"] = function(self)
    local wxdiviningrodbase_active = {}
    for k, v in pairs(TheWorld.wxdiviningrodbase) do
        if v:IsValid() and not v:IsInLimbo() and not self.inst:IsNear(v, SEE_WORK_DIST) and
            v.components.shelf.itemonshelf ~= nil then
            table.insert(wxdiviningrodbase_active, v)
        end
    end
    local wxdiviningrodbase = GetClosest(self.inst, wxdiviningrodbase_active)
    if wxdiviningrodbase ~= nil then
        self.inst.components.entitytracker:ForgetEntity("sentryward")
        self.inst.components.entitytracker:ForgetEntity("shipyard")
        self.inst.components.entitytracker:TrackEntity("wxdiviningrodbase", wxdiviningrodbase)
    end
    return wxdiviningrodbase
end
FindNavTargetFn["sentryward"] = function(self)
    local currentAP = GetScheduled(self.inst, TheWorld.sentryward)
    -- Release previous AP
    if self.previousAP ~= currentAP and self.previousAP ~= nil and
        TheWorld.sentryward[self.previousAP] ~= nil and
        TheWorld.sentryward[self.previousAP].server == self.inst then
        TheWorld.sentryward[self.previousAP].server = nil
    end

    if currentAP ~= nil then
        self.previousAP = currentAP
        self.inst.components.entitytracker:ForgetEntity("wxdiviningrodbase")
        self.inst.components.entitytracker:TrackEntity("sentryward", currentAP)
    end
    return currentAP
end
FindNavTargetFn["shipyard"] = function(self)
    local currentAP = GetScheduled(self.inst, TheWorld.shipyard)
    -- Release previous AP
    if self.previousAP ~= currentAP and self.previousAP ~= nil and
        TheWorld.shipyard[self.previousAP] ~= nil and
        TheWorld.shipyard[self.previousAP].server == self.inst then
        TheWorld.shipyard[self.previousAP].server = nil
    end

    if currentAP ~= nil then
        self.previousAP = currentAP
        self.inst.components.entitytracker:ForgetEntity("wxdiviningrodbase")
        self.inst.components.entitytracker:TrackEntity("shipyard", currentAP)
    end
    return currentAP
end
FindNavTargetFn["shardportal"] = function(self)
    local ShardPortals_active = {}
    for i, v in ipairs(ShardPortals) do
        local worldmigrator = v.components.worldmigrator
        if v:IsValid() and not v:IsInLimbo() and worldmigrator ~= nil and
            worldmigrator:IsLinked() and worldmigrator:IsActive() then
            table.insert(ShardPortals_active, v)
        end
    end
    return GetClosest(self.inst, ShardPortals_active)
end

function WXNavigation:FindNavTarget(prefab)
    local fn = FindNavTargetFn[prefab]
    return fn ~= nil and fn(self) or nil
end

function WXNavigation:FindNavPosition(navtarget)
    if navtarget == nil or not navtarget:IsValid() then
        return nil
    end

    local pt = navtarget:GetPosition()
    local result_offset = nil
    for radius = 2, SEE_WORK_DIST, 2 do
        result_offset = FindValidPositionByFan(0, radius, radius * 3, function(offset)
            local pos = pt + offset
            local ents = TheSim:FindEntities(pos.x, 0, pos.z, 1)
            if self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing() then
                return not next(ents) and TheWorld.Map:IsLandTileAtPoint(pos:Get())
            else
                return not next(ents) and TheWorld.Map:IsActualOceanTileAtPoint(pos:Get())
            end
        end)
        if result_offset ~= nil then
            return pt + result_offset
        end
    end
end

function WXNavigation:NavigateTo(prefab)
    if self.engaged then
        -- WX with a compass does not need way points.
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if tool ~= nil and tool.prefab == "compass" then
            if next(self.pointqueue) ~= nil then
                self.pointqueue = {}
            end
        end
        -- Go to the next way point.
        if next(self.pointqueue) ~= nil then
            local succeedingpoint = self.pointqueue[#self.pointqueue]
            local wxtile_x, wxtile_y = TheWorld.Map:GetTileCoordsAtPoint(self.inst.Transform:GetWorldPosition())
            if math.abs(succeedingpoint.x - wxtile_x) <= 1 and math.abs(succeedingpoint.y - wxtile_y) <= 1 then
                table.remove(self.pointqueue)
                return
            end
            succeedingpoint = self.pointqueue[#self.pointqueue]
            local pt = Vector3(TheWorld.Map:GetTileCenterPoint(succeedingpoint.x, succeedingpoint.y))
            self.inst.components.locomotor:GoToPoint(pt, nil, true)
            return
        -- Still calculating, stand by.
        elseif self.inst.components.astarpathfinding.iscalculating or self.teleporting then
            return
        -- No way point found or no remaining way points, release now.
        else
            -- Release sentryward after arriving wxdiviningrodbase
            if self.navtarget ~= nil and self.navtarget.prefab == "wxdiviningrodbase" and
                self.previousAP ~= nil and TheWorld.sentryward[self.previousAP].server == self.inst then
                TheWorld.sentryward[self.previousAP].server = nil
            end
            -- Release engagement
            self.engaged = false
        end
    end

    if self.navtarget == nil or not self.navtarget:IsValid() or self.navtarget.prefab ~= prefab or
        (self.navtarget.components.worldmigrator == nil and prefab == "shardportal") or
        self.inst.components.wxtype:NeedsFill() then
        self.navtarget = self:FindNavTarget(prefab)
    end
    local navpos = self:FindNavPosition(self.navtarget)

    if navpos ~= nil then
        self.engaged = true
        self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_START"))
        if self.inst.destination_task ~= nil then
            self.inst.destination_task:Cancel()
            self.inst.destination_task = nil
        end

        -- Hyper space jump
        local tool = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if tool ~= nil and tool.prefab == "compass" then
            self.teleporting = true
            -- Depart
            self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_JUMP_START"))
            self.inst:DoTaskInTime(3, function(inst)
                local fx = SpawnPrefab("spawn_fx_medium")
                fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                inst:DoTaskInTime(6*FRAMES, function(inst)
                    inst:Hide()
                    inst.Physics:SetActive(false)
                    inst.DynamicShadow:Enable(false)
                    inst.components.talker:IgnoreAll()
                    inst.components.talker:ShutUp()
                    -- Hyper space jump kills all living beings, especially fish
                    local backpack = GetEquippedBackpack(self.inst)
                    if backpack ~= nil and backpack.components.container ~= nil and not backpack.components.container:IsEmpty() then
                        for k, item in pairs(backpack.components.container.slots) do
                            if item:HasTag("murderable") and item.components.perishable ~= nil then
                                item.components.perishable:Perish()
                            end
                        end
                    end
                    for k, item in pairs(inst.components.inventory.itemslots) do
                        if item:HasTag("murderable") and item.components.perishable ~= nil then
                            item.components.perishable:Perish()
                        end
                    end
                end)
            end)
            -- Arrive
            self.inst:DoTaskInTime(math.random(6, 8), function(inst)
                local fx = SpawnPrefab("spawn_fx_medium")
                fx.Transform:SetPosition(navpos:Get())
                inst:DoTaskInTime(6*FRAMES, function(inst)
                    inst.Transform:SetPosition(navpos:Get())
                    inst:Show()
                    inst.Physics:SetActive(true)
                    inst.DynamicShadow:Enable(true)
                    inst.components.talker:StopIgnoringAll()
                    inst:DoTaskInTime(0, function(inst)
                        inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_JUMP_FINISH"))
                    end)
                    inst.components.wxnavigation.engaged = false
                    inst.components.wxnavigation.teleporting = false
                end)
            end)
        -- Hike
        else
            local start_x, start_y = TheWorld.Map:GetTileCoordsAtPoint(self.inst.Transform:GetWorldPosition())
            local dest_x, dest_y = TheWorld.Map:GetTileCoordsAtPoint(navpos:Get())
            self.inst.components.astarpathfinding:GetPath(start_x, start_y, dest_x, dest_y)
        end
    else
        if self.inst.destination_task == nil then
            self.inst.destination_task = self.inst:DoPeriodicTask(60, function()
                if self.inst.components.talker.task == nil then
                    self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_NODESTINATION"))
                end
            end, 0)
        end
    end
end

function WXNavigation:SailTo(prefab)
    if self.engaged then
        -- Go to the next way point.
        if next(self.pointqueue) ~= nil then
            local succeedingpoint = self.pointqueue[#self.pointqueue]
            local wxtile_x, wxtile_y = TheWorld.Map:GetTileCoordsAtPoint(self.inst.Transform:GetWorldPosition())
            if math.abs(succeedingpoint.x - wxtile_x) <= 1 and math.abs(succeedingpoint.y - wxtile_y) <= 1 then
                table.remove(self.pointqueue)
                return
            end
            succeedingpoint = self.pointqueue[#self.pointqueue]
            local pt = Vector3(TheWorld.Map:GetTileCenterPoint(succeedingpoint.x, succeedingpoint.y))
            self.inst.components.locomotor:GoToPoint(pt, nil, true)
            return
        -- Still calculating, stand by.
        elseif self.inst.components.astarpathfinding.iscalculating then
            return
        -- No way point found or no remaining way points, release now.
        else
            -- Release shipyard after arriving wxdiviningrodbase
            if self.navtarget ~= nil and self.navtarget.prefab == "wxdiviningrodbase" and
                self.previousAP ~= nil and TheWorld.shipyard[self.previousAP].server == self.inst then
                TheWorld.shipyard[self.previousAP].server = nil
            end
            -- Release engagement
            self.engaged = false
        end
    end

    self.navtarget = self:FindNavTarget(prefab)
    local navpos = self:FindNavPosition(self.navtarget)

    if navpos ~= nil then
        self.engaged = true
        self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_START"))
        if self.inst.destination_task ~= nil then
            self.inst.destination_task:Cancel()
            self.inst.destination_task = nil
        end

        local start_x, start_y = TheWorld.Map:GetTileCoordsAtPoint(self.inst.Transform:GetWorldPosition())
        local dest_x, dest_y = TheWorld.Map:GetTileCoordsAtPoint(navpos:Get())
        self.inst.components.astarpathfinding:GetSeaPath(start_x, start_y, dest_x, dest_y)
    else
        if self.inst.destination_task == nil then
            self.inst.destination_task = self.inst:DoPeriodicTask(60, function()
                if self.inst.components.talker.task == nil then
                    self.inst.components.talker:Say(GetString(self.inst, "ANNOUNCE_TRANSPORTATION_NODESTINATION"))
                end
            end, 0)
        end
    end
end

function WXNavigation:Fill()
    local wateringcan = self.inst.components.inventory:FindItem(function(item)
        return item:HasTag("wateringcan") and
            item.components.finiteuses ~= nil and
            item.components.finiteuses:GetPercent() < 1
    end)
    if wateringcan == nil then
        return
    end

    local pond_reference = nil
    for k, v in pairs(TheWorld.sentryward) do
        if k:IsValid() and not k:IsInLimbo() and self.inst:IsNear(k, SEE_WORK_DIST) then
            pond_reference = k
            break
        end
    end
    if pond_reference == nil then
        pond_reference = self.inst
    end
    local pond = FindEntity(pond_reference, SEE_WORK_DIST, function(ent)
        return ent.components.watersource ~= nil and ent.components.watersource.available
    end, TOFILL_MUST_TAGS)
    if pond == nil then
        return
    end

    if self.inst:IsNear(self.previousAP, SEE_WORK_DIST) and next(self.pointqueue) ~= nil then
        self.pointqueue = {}
    end
    return BufferedAction(self.inst, pond, ACTIONS.FILL, wateringcan)
end

local function FindItemToTakeAction(inst)
    local wxdiviningrodbase = FindEntity(inst, SEE_WORK_DIST, function(ent) return ent.prefab == "wxdiviningrodbase" end)
    if wxdiviningrodbase == nil then
        return
    end

    local item = nil
    local x, y, z = wxdiviningrodbase.Transform:GetWorldPosition()
    local container_list = TheSim:FindEntities(x, y, z, SEE_WORK_DIST, FIND_CONTAINER_MUST_TAGS)
    for _, container in pairs(container_list) do
        item = ((container.prefab == "wx" and container.components.wxtype ~= nil and
            container.components.wxtype:IsMachineInd()) or container.prefab == "treasurechest") and
            container.components.container ~= nil and
            container.components.container:FindItem(function(item)
            -- Gardenhoe
            return (item.components.farmtiller ~= nil and
                not inst.components.wxtype:CanDoAction(ACTIONS.TILL, true)) or
                -- Axe
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.CHOP) and
                not inst.components.wxtype:CanDoAction(ACTIONS.CHOP, true)) or
                -- Pickaxe
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.MINE) and
                not inst.components.wxtype:CanDoAction(ACTIONS.MINE, true)) or
                -- Shovel
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.DIG) and
                not inst.components.wxtype:CanDoAction(ACTIONS.DIG, true)) or
                -- Fishingrod
                (item.components.fishingrod ~= nil and
                not inst.components.wxtype:CanDoAction(ACTIONS.FISH, true)) or
                -- Bugnet
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.NET) and
                not inst.components.wxtype:CanDoAction(ACTIONS.NET, true)) or
                -- Hammer
                (item.components.tool ~= nil and item.components.tool:CanDoAction(ACTIONS.HAMMER) and
                not inst.components.wxtype:CanDoAction(ACTIONS.HAMMER, true)) or
                -- Wateringcan
                (item:HasTag("wateringcan") and
                not inst.components.wxtype:CanDoAction(ACTIONS.POUR_WATER_GROUNDTILE, true))
        end) or nil
        if item ~= nil then
            return BufferedAction(inst, container, ACTIONS.LOAD, item)
        end
    end
end

local TOPICKUP_CANT_TAGS = { "fire", "smolder", "INLIMBO", "NOCLICK", "event_trigger", "catchable", "irreplaceable", "heavy", "outofreach" }
function WXNavigation:FindEntityToPickUpAction()
    --local backpack = GetEquippedBackpack(self.inst)
    local target = FindEntity(self.inst, SEE_WORK_DIST, function(item)
        return item ~= nil and
        item:IsValid() and
        not item:IsInLimbo() and
        item.entity:IsVisible() and
        ((self.inst.components.sailor ~= nil and self.inst.components.sailor:IsSailing()) and IsOnWater(item) or
        ((item:IsOnValidGround() and self.inst:IsOnValidGround()) or
        (item:GetCurrentPlatform() ~= nil and self.inst:GetCurrentPlatform() ~= nil))) and
        item.components.inventoryitem ~= nil and
        item.components.inventoryitem.canbepickedup and
        --[[not (item.components.burnable ~= nil and
            (item.components.burnable:IsBurning() or
            item.components.burnable:IsSmoldering())) and]]
        -- Target item is backpack
        (not self.inst.components.wxtype.augmentlock and --backpack == nil and
        not self.inst.components.inventory:EquipHasTag("backpack") and
        item.components.equippable ~= nil and
        (EQUIPSLOTS.BACK ~= nil and item.components.equippable.equipslot == EQUIPSLOTS.BACK or
        item.components.equippable.equipslot == EQUIPSLOTS.BODY) and
        item.components.container ~= nil and item.prefab ~= "seedpouch" and item.prefab ~= "candybag")
    end, nil, TOPICKUP_CANT_TAGS)

    return target ~= nil and BufferedAction(self.inst, target, ACTIONS.AUGMENT) or
        ((self.inst.components.sailor == nil or not self.inst.components.sailor:IsSailing()) and
        FindItemToTakeAction(self.inst) or nil)
end

--------------------------------------------------------------------------
--[[ Save/Load ]]
--------------------------------------------------------------------------
function WXNavigation:OnSave()
    local data = {}

    data.engaged = self.engaged
    data.isshardtraveler = self.isshardtraveler
    data.noreceiver = self.noreceiver
    if self.navtarget ~= nil and self.navtarget:IsValid() then
        data.navtarget_GUID = self.navtarget.GUID
    end
    if self.previousAP ~= nil and self.previousAP:IsValid() then
        data.previousAP_GUID = self.previousAP.GUID
    end

    return data
end

function WXNavigation:OnLoad(savedata)
    self.engaged = savedata and savedata.engaged or false
    self.isshardtraveler = savedata and savedata.isshardtraveler or false
    self.noreceiver = savedata and savedata.noreceiver or false
end

function WXNavigation:LoadPostPass(newents, savedata)
    if savedata and savedata.navtarget_GUID ~= nil then
        local navtarget = newents[savedata.navtarget_GUID]
        if navtarget ~= nil then
            self.navtarget = navtarget.entity
        end
    end
    if savedata and savedata.previousAP_GUID ~= nil then
        local previousAP = newents[savedata.previousAP_GUID]
        if previousAP ~= nil then
            self.previousAP = previousAP.entity
        end
    end

    if self.previousAP ~= nil and TheWorld.sentryward[self.previousAP] ~= nil then
        TheWorld.sentryward[self.previousAP].server = self.inst
    end
    if self.previousAP ~= nil and TheWorld.shipyard[self.previousAP] ~= nil then
        TheWorld.shipyard[self.previousAP].server = self.inst
    end
end

--------------------------------------------------------------------------
--[[ Initialization ]]
--------------------------------------------------------------------------

return WXNavigation