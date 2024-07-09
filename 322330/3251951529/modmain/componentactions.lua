local ModUtils = require("mym_modutils")

AddComponentAction("SCENE", "mym_mate", function(inst, doer, actions, right)
    if inst:HasTag("mym_mate") then
        table.insert(actions, ACTIONS.MYM_RUMMAGE)
    end
end)

-- 对机器人队友拔下电路
AddComponentAction("USEITEM", "upgrademoduleremover", function(inst, doer, target, actions)
    if target:HasTag("upgrademoduleowner") and target:HasTag("mym_mate") and not target:HasTag("playerghost") then
        local success = target.CanRemoveModules == nil or target:CanRemoveModules()
        if success then
            table.insert(actions, ACTIONS.MYM_REMOVEMODULES)
        else
            table.insert(actions, ACTIONS.MYM_REMOVEMODULES_FAIL)
        end
        table.insert(actions, ACTIONS.MYM_REMOVEMODULES)
    end
end)




-- 给队友选择职业，先放一放，等修复了选择职业的bug再说
-- if ModUtils.IsModEnableById(ModUtils.MODNAMES.LegendOfSea) then
--     AddComponentAction("USEITEM", "lg_consumable", function(inst, doer, target, actions, right)
--         if ACTIONS.LG_USE_ITEM
--             and inst.prefab == "lg_career_enter"
--             and target:HasTag("mym_mate")
--         then
--             table.insert(actions, ACTIONS.LG_USE_ITEM)
--         end
--     end)
-- end
