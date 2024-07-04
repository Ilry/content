do
	local GLOBAL = GLOBAL
	local modEnv = GLOBAL.getfenv(1)
	local rawget, setmetatable = GLOBAL.rawget, GLOBAL.setmetatable
	setmetatable(modEnv, {
		__index = function(self, index)
			return rawget(GLOBAL, index)
		end
      -- lack of __newindex means it defaults to modEnv, so we don't mess up globals.
	})

	_G = GLOBAL
end


local SUFFIXES = { 'K', 'M', 'B', 'T' }

function formatQuantity(quantity)
    if quantity <= 999 then
        return
    end

    local log = math.log10(quantity)

    if log < 3 then
        return
    end

    if quantity < 10000 then
        return tostring(quantity)
    end

    local index = #SUFFIXES

    for i, _ in ipairs(SUFFIXES) do
        if log < i * 3 then
            index = i - 1

            break
        end
    end

    local mult = 10 ^ (index * 3)
    local suffix = SUFFIXES[index]

    return log < index * 3 + 1
        and string.sub(tostring(quantity / mult), 1, 3) .. suffix
        or math.floor(quantity / mult) .. suffix
end







local stackable_replica = require("components/stackable_replica")


local function OnStackSizeDirty(inst)
    local self = inst.replica.stackable
    if not self then
        return --stackable removed?
    end

    self:ClearPreviewStackSize()

    --instead of inventoryitem_classified listening for "stacksizedirty" as well
    --forward a new event to guarantee order
    inst:PushEvent("inventoryitem_stacksizedirty")
end

stackable_replica._ctor = function(self, inst)
    self.inst = inst

    self._stacksize = net_ushortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
    self._stacksizeupper = net_ushortint(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
    self._ignoremaxsize = net_bool(inst.GUID, "stackable._ignoremaxsize")
    self._maxsize = net_tinybyte(inst.GUID, "stackable._maxsize")

    if not TheWorld.ismastersim then
        --self._previewstacksize = nil
        --self._previewtimeouttask = nil
        inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
    end
end

stackable_replica.SetStackSize = function(self, stacksize)
    stacksize = stacksize - 1
    if stacksize <= 65535 then
        self._stacksizeupper:set(0)
        self._stacksize:set(stacksize)
    elseif stacksize >= 4095 then
        if self._stacksizeupper:value() ~= 65535 then
            self._stacksizeupper:set(65535)
        else
            self._stacksize:set_local(65535) --force sync to trigger UI events even when capped
        end
        self._stacksize:set(65535)
    else
        local upper = math.floor(stacksize / 65536)
        self._stacksizeupper:set(upper)
        self._stacksize:set(stacksize - upper * 65536)
    end
end


stackable_replica.StackSize = function(self)
    return self:GetPreviewStackSize() or (self._stacksizeupper:value() * 65536 + self._stacksize:value() + 1)
end




AddClassPostConstruct("widgets/controls", function()
    local ItemTile = require("widgets/itemtile")
    local oldSetQuantity = ItemTile.SetQuantity

    function ItemTile:SetQuantity(quantity, ...)
        oldSetQuantity(self, quantity, ...)

        local quantityString = formatQuantity(quantity)

        if quantityString ~= nil then
            self.quantity:SetString(quantityString)
        end
    end
end)
