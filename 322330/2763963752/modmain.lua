GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})--GLOBAL 相关照抄
_G=GLOBAL
Assets={
    Asset("IMAGE", "images/customicobyysh.tex"),
	Asset("ATLAS", "images/customicobyysh.xml"),
}
require "widgets/TMIP_Itemtile"
local Listload = {
    "food","seeds","equip","tool","magic","material","gift","base","cooking","props","clothes","farming",
    "puppet","plant","ore","den","building","sculpture","natural","animal","boss","follower","ruins",
}
for _, v in pairs(Listload) do
    require("TMIP/list/itemlist_" .. v)
end

local controls = nil 
local function AddTMIMenu(self)
    controls= self
end
AddClassPostConstruct("widgets/controls", AddTMIMenu)

AddPrefabPostInit("world", function (inst)
    inst:DoTaskInTime(0,function ()
        if not controls or not controls.TMI then
            return
        end
        --增加鸦年华，浣猫年
        local tmp=require "TMIP/debug"
        for k,v in ipairs(tmp)do
            if v.tittle and v.tittle== STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TEXT then
                table.insert(v.list,{
                    beta = false,
                    pos = 'all',
                    name = _G.TOOMANYITEMS.UI_LANGUAGE == 'cn' and STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.CARNIVAL or 'CARNIVAL',
                    tip = STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT .. STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.CARNIVAL,
                    fn = {
                        'confirm',
                        'ApplySpecialEvent("crow_carnival") TheWorld.topology.overrides.specialevent = "crow_carnival" c_save() c_announce("' ..
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_SERVER_RESETTIP ..
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT ..
                        STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.CARNIVAL ..
                        '") TheWorld:DoTaskInTime(5, function() if TheWorld ~= nil and TheWorld.ismastersim then TheNet:SendWorldRollbackRequestToServer(0) end end)',
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT .. STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.CARNIVAL,
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TEXTCHANGESTIP
                    }
                })
                table.insert(v.list,{
                    beta = false,
                    pos = 'all',
                    name = _G.TOOMANYITEMS.UI_LANGUAGE == 'cn' and STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.YOT_CATCOON or 'YOT_CATCOON',
                    tip = STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT .. STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.YOT_CATCOON,
                    fn = {
                        'confirm',
                        'ApplySpecialEvent("year_of_the_catcoon") TheWorld.topology.overrides.specialevent = "year_of_the_catcoon" c_save() c_announce("' ..
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_SERVER_RESETTIP ..
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT ..
                        STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.YOT_CATCOON ..
                        '") TheWorld:DoTaskInTime(5, function() if TheWorld ~= nil and TheWorld.ismastersim then TheNet:SendWorldRollbackRequestToServer(0) end end)',
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TIPTEXT .. STRINGS.UI.SANDBOXMENU.SPECIAL_EVENTS.YOT_CATCOON,
                        STRINGS.TOO_MANY_ITEMS_UI.DEBUG_EVENT_TEXTCHANGESTIP
                    }
                })
                break
            end
        end
        package.loaded["TMIP/debug"] = tmp
        if controls.TMI.debugshield then
            controls.TMI.debugshield:Kill()
        end
        controls.TMI:DebugMenu()
    end)
end)

