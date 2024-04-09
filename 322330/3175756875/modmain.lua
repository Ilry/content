local SUFFIXES = { 'K', 'M', 'B', 'T'}

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
        and string.sub(tostring(quantity / mult), 1, 3)..suffix
        or math.floor(quantity / mult)..suffix
end

AddClassPostConstruct("widgets/controls", function ()
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
