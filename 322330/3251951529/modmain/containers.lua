local Containers = require("containers")
local params = Containers.params

params.mym_mate_container =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_woby_3x3",
        animbuild = "ui_woby_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            text = STRINGS.UI.HUD.TAKE,
            position = Vector3(0, -180, 0),
        }
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.mym_mate_container.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

function params.mym_mate_container.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.MYM_GIVE_ALL):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.MYM_GIVE_ALL.code, inst, ACTIONS.MYM_GIVE_ALL.mod_name)
    end
end
