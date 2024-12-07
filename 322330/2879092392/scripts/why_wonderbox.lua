--AddTag's are in modmain.

GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k) end})
local containers = require("containers")
local params = containers.params
local Vector3 = GLOBAL.Vector3
------------------------------------------------------------------
params.why_wonderbox = {
    widget = {
		slotpos = {},
        --Directly drawn from dh's freezer code; uncomment later to use.
        --[[slotbg = {
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
            {image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},
		},]]
        animbank = "ui_chest_3x2", --placeholder.
        animbuild = "ui_chest_3x2", --placeholder.
        pos = Vector3(0, 200, 0), --[[pos = Vector3(107, 40, 0),]]
		side_align_tip = 160,
    },
    --usespecificslotsforitems = true,
	acceptsstacks = true,
    type = "chest",
}
------------------------------------------------------------------
function params.why_wonderbox.itemtestfn(container, item, slot)
    return item:HasTag("whybox_accept")
end

for y = 1, 0, -1 do
    for x = 0, 2 do
        table.insert(params.why_wonderbox.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
    end
end
------------------------------------------------------------------

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
