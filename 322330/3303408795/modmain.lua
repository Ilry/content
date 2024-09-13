GLOBAL.setmetatable(env, {
    __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end
})

PrefabFiles = {
    "watson_bot",
    "watson_remote",
}

Assets = {
    Asset( "IMAGE", "images/inventoryimages/watson_bot_item.tex" ),
    Asset( "ATLAS", "images/inventoryimages/watson_bot_item.xml" ),
    
    Asset( "IMAGE", "images/inventoryimages/watson_bot_item_on.tex" ),
    Asset( "ATLAS", "images/inventoryimages/watson_bot_item_on.xml" ),
    
    Asset( "IMAGE", "images/inventoryimages/watson_remote.tex" ),
    Asset( "ATLAS", "images/inventoryimages/watson_remote.xml" ),
}

---------------------------------------------------------------

modimport("robot_strings/strings")

---------------------------------------------------------------
--在某些狀況下，會因為這裡有錯誤無法播放動畫而導致"法術"失敗，
--根據https://forums.kleientertainment.com/forums/topic/66353-tried-to-go-to-invalid-state/
--主機端與客戶端的動作(remotecast)命名會不一樣，所以在下面的程式碼中
--上面主機端的是"remotecast_pre"下面客戶端的是"remotecast"
--為了使用mod的遙控器「施法」的角色動畫而改，不然 components.spellbook 的預設動畫會是唸書
AddStategraphPostInit("wilson", function(self)
    local original_CAST_SPELLBOOK_deststate = self.actionhandlers[_G.ACTIONS.CAST_SPELLBOOK].deststate

    self.actionhandlers[_G.ACTIONS.CAST_SPELLBOOK].deststate = function(inst, action)
        if action.invobject.prefab == "watson_remote" then
            return "remotecast_pre"
        end
        return original_CAST_SPELLBOOK_deststate(inst, action)
    end
end)


AddStategraphPostInit("wilson_client", function(self)
    local original_CAST_SPELLBOOK_deststate = self.actionhandlers[_G.ACTIONS.CAST_SPELLBOOK].deststate

    self.actionhandlers[_G.ACTIONS.CAST_SPELLBOOK].deststate = function(inst, action)
        if action.invobject.prefab == "watson_remote" then
            return "remotecast"
        end
        return original_CAST_SPELLBOOK_deststate(inst, action)
    end
end)

---------------------------------------------------------------

--為了將右鍵使用mod遙控器時顯示的詞綴從「Read」改成「Use」

local original_actions_usespellbook_strfn = ACTIONS.USESPELLBOOK.strfn

ACTIONS.USESPELLBOOK.strfn = function(act)
    if act.invobject.prefab == "watson_remote" then
        return "REMOTE"
    end
    return original_actions_usespellbook_strfn(act)
end

---------------------------------------------------------------

RegisterInventoryItemAtlas("images/inventoryimages/watson_remote.xml","watson_remote.tex")
AddRecipe2(
    "watson_remote",
    {Ingredient("transistor", 1), Ingredient("silk", 1), Ingredient("bluegem", 1), Ingredient("redgem", 1)},
    TECH.NONE,
    {atlas = "images/inventoryimages/watson_remote.xml", image = "watson_remote.tex"},
    {"CHARACTER"}
)

---------------------------------------------------------------

local containers = require "containers"
local params = containers.params

params.watson_bot =
{
    widget =
    {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.watson_bot.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

function params.watson_bot.itemtestfn(container, item, slot)
    return not item:HasTag("irreplaceable")
end
