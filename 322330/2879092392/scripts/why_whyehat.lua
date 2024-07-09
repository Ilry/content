GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k) end})
local containers = require("containers")
local params = containers.params
local Vector3 = GLOBAL.Vector3
------------------------------------------------------------------
params.whyhat = {
    widget = {
		slotpos = {},
        slotbg = {{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},},
        animbank = "ui_whyehat_1x1",
        animbuild = "ui_whyehat_1x1",
        pos = Vector3(107, 40, 0), },
    --usespecificslotsforitems = true,
	acceptsstacks = false,
    type = "hand_inv",}

params.whyhat_prothesis = {
    widget = {
        slotpos = {},
        slotbg = {{image = "whyeball_slot.tex", atlas = "images/hud/whyeball_slot.xml"},},
        animbank = "ui_whyehat_1x1",
        animbuild = "ui_whyehat_1x1",
        pos = Vector3(107, 40, 0), },
    --usespecificslotsforitems = true,
    acceptsstacks = false,
    type = "hand_inv",}
------------------------------------------------------------------
function params.whyhat.itemtestfn(container, item, slot)
    return item:HasTag("whyeball")
end
table.insert(params.whyhat.widget.slotpos, Vector3(0, 17, 0))

function params.whyhat_prothesis.itemtestfn(container, item, slot)
    return (item.prefab == "why_perfectiongem" or item.prefab == "why_nothingnessgem" or item:HasTag("eyeshard"))
end
table.insert(params.whyhat_prothesis.widget.slotpos, Vector3(0, 17, 0))

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0) end
