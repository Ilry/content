---@diagnostic disable: lowercase-global, undefined-global, trailing-space

local modid = 'lol_wp'

---@type data_containerUI
local params = {}



-- params.new_ui = {
--     widget =
--     {
--         animbank = 'ui_chest_3x3',
--         animbuild = 'ui_chest_3x3', 
--         slotpos = {},
--         slotbg = {},
--         pos = Vector3(-340, -120, 0),
--         side_align_tip = 160,
--         buttoninfo = {
--             text = 'hit',
--             position = Vector3(0, 80*-2+10, 0),
--         },
--         dragtype_drag = 'new_ui',
--         unique = 'new_ui',
--     },
--     type = 'new_ui',
--     itemtestfn = function(container, item, slot)
--         -- if slot == nil then -- 这样设置就能让shift左键失效,还能保证giveitem能用,我也不知道原因,群佬没告诉我
--         --     return false 
--         -- end
--         -- if item:HasTag('gem') then return true end
--         -- return false
--     end
-- }

-- for y = 2, 0, -1 do
--     for x = 0, 1 do
--         table.insert(params.new_ui.widget.slotpos, Vector3(80 * (x - 2) + 130, 80 * (y - 2) + 75, 0))
--         -- table.insert(params.new_ui.widget.slotbg, { atlas="images/slotbg/.xml",image = ".tex" })
--     end
-- end

params.lol_wp_s9_guider = {
    widget =
    {
        animbank = 'ui_krampusbag_2x8',
        animbuild = 'ui_krampusbag_2x8', 
        slotpos = {},
        slotbg = {},
        pos = Vector3(-340, -120, 0),
        side_align_tip = 160,
        dragtype_drag = 'lol_wp_s9_guider',
    },
    type = 'pack',
}

for y = 0, 6 do
    table.insert(params.lol_wp_s9_guider.widget.slotpos, Vector3(-162, -75 * y + 240, 0))
    table.insert(params.lol_wp_s9_guider.widget.slotpos, Vector3(-162 + 75, -75 * y + 240, 0))
end

params.lol_wp_s9_eyestone_low = {
    widget = {
        animbank = 'ui_chest_3x1',
        animbuild = 'ui_chest_3x1',
        slotbg = {},
        slotpos = {},
        pos = Vector3(390, -300, 0),
        dragtype_drag = 'lol_wp_s9_eyestone_low',
    },
    type = 'eyestone',
    itemtestfn = function (container, item, slot)
        if item == nil then
            return false
        end
        local tagprefix = 'lol_wp_s9_eyestone_'
        local itm_prefab = item and item.prefab
        if itm_prefab and container.inst:HasTag(tagprefix..itm_prefab) then
            return false -- 检查唯一性
        end
        -- 容器不能放进来
        if item.components.container then
            return false
        end
        -- 临时让所有项链都能放入(若有问题,后续再移除)
        -- 不用移除了,加了mod设置了
        if not TUNING[string.upper('CONFIG_'..modid..'eyestone_allow_lolamulet_only')] then
            local item_slot = item.components.equippable and item.components.equippable.equipslot
            if item_slot then
                if EQUIPSLOTS.NECK then -- 如果开启了额外装备栏
                    if item_slot == EQUIPSLOTS.NECK then
                        return true
                    end
                end
                if EQUIPSLOTS.BODY and (item:HasTag('amulet') or string.find(itm_prefab or '', 'amulet') ) then -- 如果没开额外装备栏,并且是身体位置的装备,需要判断它是不是项链,使用amulet这个tag,或者名字里有amulet,应该不会有孬子,名字里写了amulet结果不是项链吧
                    return true
                end
            end
        end
        -- 有这个标签的物品才能放入
        if item:HasTag('lol_wp_s9_eyestone_confirm_amulet') then return true end
        return false
    end
}

for x = 0, 2 do
    table.insert(params.lol_wp_s9_eyestone_low.widget.slotpos, Vector3(-162+ 13 + (x+1)*75, 0, 0))
end



params.lol_wp_s9_eyestone_high = {
    widget = {
        animbank = 'ui_chest_3x2',
        animbuild = 'ui_chest_3x2',
        slotbg = {},
        slotpos = {},
        pos = Vector3(390, -300, 0),
        dragtype_drag = 'lol_wp_s9_eyestone_high',
    },
    type = 'eyestone',
    itemtestfn = function (container, item, slot)
        if item == nil then
            return false
        end
        local tagprefix = 'lol_wp_s9_eyestone_'
        local itm_prefab = item and item.prefab
        if itm_prefab and container.inst:HasTag(tagprefix..itm_prefab) then
            return false -- 检查唯一性
        end
        -- 容器不能放进来
        if item.components.container then
            return false
        end
        -- 临时让所有项链都能放入(若有问题,后续再移除)
        -- 不用移除了,加了mod设置了
        if not TUNING[string.upper('CONFIG_'..modid..'eyestone_allow_lolamulet_only')] then
            local item_slot = item.components.equippable and item.components.equippable.equipslot
            if item_slot then
                if EQUIPSLOTS.NECK then -- 如果开启了额外装备栏
                    if item_slot == EQUIPSLOTS.NECK then
                        return true
                    end
                end
                if EQUIPSLOTS.BODY and (item:HasTag('amulet') or string.find(itm_prefab or '', 'amulet') ) then -- 如果没开额外装备栏,并且是身体位置的装备,需要判断它是不是项链,使用amulet这个tag,或者名字里有amulet,应该不会有孬子,名字里写了amulet结果不是项链吧
                    return true
                end
            end
        end
        -- 有这个标签的物品才能放入
        if item:HasTag('lol_wp_s9_eyestone_confirm_amulet') then return true end
        return false
    end
}

for x = 0, 2 do
    table.insert(params.lol_wp_s9_eyestone_high.widget.slotpos, Vector3(-162+ 13 + (x+1)*75, 75, 0))
    table.insert(params.lol_wp_s9_eyestone_high.widget.slotpos, Vector3(-162+ 13 + (x+1)*75, 0, 0))
end


return params