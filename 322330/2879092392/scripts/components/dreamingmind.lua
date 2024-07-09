local function IsValidOwner(inst, owner)
end
local function OwnerAlreadyHasDreamingMind(inst, owner)
    local equip = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    return equip ~= inst
            and equip ~= nil
            and equip.components.dreamingmind ~= nil
            and equip
            or owner.components.inventory:FindItem(function(item)
        return item.components.dreamingmind ~= nil and item ~= inst
    end)
end
local function OnCheckOwner(inst, self)
    self.checkownertask = nil
    local owner = inst.components.inventoryitem:GetGrandOwner()
    if owner == nil or owner.components.inventory == nil then
        return
    else
        local other = OwnerAlreadyHasDreamingMind(inst, owner)
        if other ~= nil then
            self:Drop()
            other:PushEvent("rejectedowner", inst)
        end
    end
end
local function OnChangeOwner(inst, owner)
    local self = inst.components.dreamingmind
    if self.currentowner == owner then
        return
    elseif self.currentowner ~= nil and self.oncontainerpickedup ~= nil then
        inst:RemoveEventCallback("onputininventory", self.oncontainerpickedup, self.currentowner)
        self.oncontainerpickedup = nil
    end
    if self.checkownertask ~= nil then
        self.checkownertask:Cancel()
        self.checkownertask = nil
    end
    self.currentowner = owner
    if owner == nil then
        return
    elseif owner.components.inventoryitem ~= nil then
        self.oncontainerpickedup = function()
            if self.checkownertask ~= nil then
                self.checkownertask:Cancel()
            end
            self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
        end
        inst:ListenForEvent("onputininventory", self.oncontainerpickedup, owner)
    end
    self.checkownertask = inst:DoTaskInTime(0, OnCheckOwner, self)
end
local DreamingMind = Class(function(self, inst)
    self.inst = inst
    self.player = nil
    self.userid = nil
    self.currentowner = nil
    self.oncontainerpickedup = nil
    self.checkownertask = nil
    self.onplayerdied = function()
        self:WaitForPlayer(nil, 3)
    end
    self.onplayerremoved = function()
        self:WaitForPlayer(self.userid)
    end
    self.onplayerjoined = function(world, player)
    end
    inst:ListenForEvent("onputininventory", OnChangeOwner)
    inst:ListenForEvent("ondropped", OnChangeOwner)
end)
function DreamingMind:WaitForPlayer(userid, delay)
    self:LinkToPlayer(nil)
    self.userid = userid
    if userid ~= nil then
        self.inst:ListenForEvent("ms_playerjoined", self.onplayerjoined, TheWorld)
    end
end
function DreamingMind:StopWaitingForPlayer()
    if self.userid ~= nil then
        self.userid = nil
        self.inst:RemoveEventCallback("ms_playerjoined", self.onplayerjoined, TheWorld)
    end
end
function DreamingMind:LinkToPlayer(player)
    if self.player == player then
        return
    elseif self.player ~= nil then
        self.inst:RemoveEventCallback("onremove", self.onplayerremoved, self.player)
    end
    self.player = player
    if player == nil then
        self.userid = nil
        self.inst:PushEvent("hatpossessedbyplayer", nil)
        return
    end
    self.userid = player.userid
    player:PushEvent("dreamingmind", self.inst)
    self.inst:ListenForEvent("onremove", self.onplayerremoved, player)
    self.inst:PushEvent("possessedbyplayer", player)
end
function DreamingMind:Drop()
    local owner = self.inst.components.inventoryitem:GetGrandOwner()
    if owner ~= nil and owner.components.inventory ~= nil then
        owner.components.inventory:DropItem(self.inst, true, true)
    end
end
function DreamingMind:OnSave()
    local data = { userid = self.userid,
                   waittimeremaining = nil, }
    return next(data) ~= nil and data or nil
end
function DreamingMind:OnLoad(data)
    if data ~= nil then
        if self.player == nil
                and (data.userid ~= nil and data.userid ~= self.userid) then
            self:LinkToPlayer(nil)
            self:WaitForPlayer(data.userid, nil)
        end
    end
end
function DreamingMind:GetDebugString()
    return "held: " .. tostring(self.currentowner)
            .. " player: " .. tostring(self.player)
            .. string.format(" timeout: %2.2f", 0)
end
return DreamingMind