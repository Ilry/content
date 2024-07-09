GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k) end})
local containers = require("containers")
local params = containers.params
local Vector3 = GLOBAL.Vector3
------------------------------------------------------------------
params.whyfreezerbox = {
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
		},
        animbank = "ui_why_freezer",
        animbuild = "ui_why_freezer",
        pos = Vector3(0, 200, 0), --[[pos = Vector3(107, 40, 0),]]
		side_align_tip = 160,
    },
    --usespecificslotsforitems = true,
	acceptsstacks = true,
    type = "chest",
}
------------------------------------------------------------------
function params.whyfreezerbox.itemtestfn(container, item, slot)
    return (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled"))
end

for y = 1.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(params.whyfreezerbox.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
    end
end
------------------------------------------------------------------

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
