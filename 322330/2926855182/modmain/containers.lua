---
--- @author zsh in 2023/2/23 8:49
---

local API = require("pets_enhancement.API");

local fns = {};

function fns.fn_tidy(inst, doer)
    if inst.components.container ~= nil then
        API.arrangeContainer(inst);
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendRPCToServer(RPC.DoWidgetButtonAction, nil, inst, nil); -- !!! SendRPCToServer + RPC + AddXXXRPCHandler
    end
end

function fns.validfn_tidy(inst)
    return inst.replica.container ~= nil and not inst.replica.container:IsEmpty();
end

local containers = require("containers");
local params = containers.params;

params.pets_critter_kitten = {
    widget = {
        slotpos = {},
        animbank = "ui_chester_shadow_3x4",
        animbuild = "ui_chester_shadow_3x4",
        pos = Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
    itemtestfn = function(container, item, slot)
        return item:HasTag("pets_critter_kitten_itemtestfn_tag");
    end
}

for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(params.pets_critter_kitten.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

params.pets_critter_puppy = {
    widget = {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
        buttoninfo = {
            text = "一键整理",
            position = Vector3(0, -140, 0),
            fn = fns.fn_tidy,
            validfn = fns.validfn_tidy
        }
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.pets_critter_puppy.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

function params.pets_critter_puppy.itemtestfn(container, item, slot)
    if item.prefab == "heatrock" then
        return false;
    end

    if item:HasTag("icebox_valid") then
        return true
    end

    --Perishable
    if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
        return false
    end

    if item:HasTag("smallcreature") then
        return false
    end

    --Edible
    for k, v in pairs(FOODTYPE) do
        if item:HasTag("edible_" .. v) then
            return true
        end
    end

    return false
end

params.pets_critter_lamb = {
    widget = {
        slotpos = {},
        animbank = "my_chest_ui_4x4",
        animbuild = "my_chest_ui_4x4",
        pos = Vector3(0 + 220 + 5, 200, 0),
    },
    type = "pets_critter_lamb",
    itemtestfn = function(container, item, slot)
        return not (item:HasTag("irreplaceable") or item:HasTag("_container"));
    end
}

for y = 2, -1, -1 do
    for x = -1, 2 do
        table.insert(params.pets_critter_lamb.widget.slotpos, Vector3(80 * x - 40, 80 * y - 40, 0))
    end
end

params.pets_critter_glomling = {
    widget = {
        slotpos = {},
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(0, 200, 0),
        side_align_tip = 160,
        buttoninfo = {
            text = "一键整理",
            position = Vector3(0, -140, 0),
            fn = fns.fn_tidy,
            validfn = fns.validfn_tidy
        }
    },
    type = "chest",
}

for y = 2, 0, -1 do
    for x = 0, 2 do
        table.insert(params.pets_critter_glomling.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
    end
end

function params.pets_critter_glomling.itemtestfn(container, item, slot)
    if item.prefab == "heatrock" then
        return false;
    end

    if item:HasTag("icebox_valid") then
        return true
    end

    --Perishable
    if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
        return false
    end

    if item:HasTag("smallcreature") then
        return false
    end

    --Edible
    for k, v in pairs(FOODTYPE) do
        if item:HasTag("edible_" .. v) then
            return true
        end
    end

    return false
end

-- 无法理解为什么会报错。。。
params.pets_critter_lunarmothling = {
    widget = {
        slotpos = {
            Vector3(0, 64 + 32 + 8 + 4, 0),
            Vector3(0, 32 + 4, 0),
            Vector3(0, -(32 + 4), 0),
            Vector3(0, -(64 + 32 + 8 + 4), 0),
        },
        animbank = "ui_lamp_1x4",
        animbuild = "ui_lamp_1x4",
        pos = Vector3(200 - 40, 0, 0),
        side_align_tip = 100,
    },
    type = "cooker",
}
--[[params.pets_critter_lunarmothling = {
    widget = {
        slotpos = {
            Vector3(-37.5, 32 + 4, 0),
            Vector3(37.5, 32 + 4, 0),
            Vector3(-37.5, -(32 + 4), 0),
            Vector3(37.5, -(32 + 4), 0)
        },
        animbank = "ui_chest_2x2",
        animbuild = "ui_chest_2x2",
        pos = Vector3(200, 0, 0),
        side_align_tip = 120
    },
    type = "pets_critter_lunarmothling"
}]]

function params.pets_critter_lunarmothling.itemtestfn(container, item, slot)
    if item.prefab == "moonglass_charged"
            or item.prefab == "moonstorm_spark"
            or item.prefab == "moon_tree_blossom"
            or item.prefab == "moonbutterfly"
            or item.prefab == "moonbutterflywings"
            or item.prefab == "moon_cap"
            or item.prefab == "moon_cap_cooked"
            or item.prefab == "wobster_moonglass_land"
            or item.prefab == "alterguardianhatshard"
    then
        return true;
    end
    return false;
end

params.pets_critter_eyeofterror = {
    widget = {
        slotpos = {},
        animbank = "my_chest_ui_4x4",
        animbuild = "my_chest_ui_4x4",
        pos = Vector3(0, 200, 0),
        buttoninfo = {
            text = "一键整理",
            position = Vector3(0, -190, 0),
            fn = fns.fn_tidy,
            validfn = fns.validfn_tidy
        }
    },
    type = "chest",
    itemtestfn = function(container, item, slot)
        return not (item:HasTag("irreplaceable") or item:HasTag("_container") or item:HasTag("bundle") or item:HasTag("nobundling"));
    end
}

for y = 2, -1, -1 do
    for x = -1, 2 do
        table.insert(params.pets_critter_eyeofterror.widget.slotpos, Vector3(80 * x - 40, 80 * y - 40, 0))
    end
end

for _, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end