GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k) end})
local containers = require("containers")
local params = containers.params
local Vector3 = GLOBAL.Vector3
------------------------------------------------------------------
params.whyearmor_backpack = {
    widget = {
		slotpos = {},
        slotbg = {
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
        {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},},
        animbank = "ui_lightpackpremium_2x8",
        animbuild = "ui_lightpackpremium_2x8",
        pos = Vector3(-5, -70, 0), },
	--acceptsstacks = false,
    issidewidget = true,
    type = "pack",
    openlimit = 1,}
------------------------------------------------------------------
for y = 0, 6 do
    table.insert(params.whyearmor_backpack.widget.slotpos, Vector3(-153, -70 * y + 230, 0))
    table.insert(params.whyearmor_backpack.widget.slotpos, Vector3(-153 + 75, -70 * y + 230, 0))
end
function params.whyearmor_backpack.itemtestfn(container, item, slot)
    return item:HasTag("fitsforgempack") end
params.whyearmor_backpack.priorityfn = params.whyearmor_backpack.itemtestfn
for k, v in pairs(params) do
containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.whyearmor_backpack.widget.slotpos ~= nil and #params.whyearmor_backpack.widget.slotpos or 0) end

function containers.containers_widgetsetup(container, prefab, data)
    local t = prefab or container.inst.prefab
    if t == "whyearmor_backpack" then
        local t = params[t]
        if t ~= nil then
            for k, v in pairs(t) do
                container[k] = v end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0) end else
        return containers_widgetsetup(container, prefab) end end