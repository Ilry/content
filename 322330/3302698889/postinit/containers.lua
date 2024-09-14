local containers = require("containers")
local params = containers.params

local pos = { x = 0, y = 0, r = 87 }
local function simpVec3(i)
    return Vector3(pos.x + pos.r * math.cos(i / 3 * PI), pos.y + pos.r * math.sin(i / 3 * PI), 0)
end
params.beebox = 
{    
    widget =
    {
        slotpos = {
            simpVec3(2), simpVec3(1), simpVec3(3),
            Vector3(pos.x, pos.y , 0),
            simpVec3(0), simpVec3(4), simpVec3(5),
        },
        slotbg = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        bgimage = "bg.tex",
        bgatlas = "images/ui/beebox.xml",
        pos = Vector3(pos.x, pos.y + 200, 0),
        side_align_tip = 300 - pos.r,
    },
    -- usespecificslotsforitems = true,
    type = "chest",
    openlimit = 1,
}
for i = 1, #params.beebox.widget.slotpos do
    table.insert(params.beebox.widget.slotbg, { image = "slotbg.tex", atlas = resolvefilepath("images/ui/beebox.xml") })
end
function params.beebox.itemtestfn(container, item, slot)
    return APIARY.PRESERVABLE[item.prefab]
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end