---
--- @author zsh in 2023/2/11 15:01
---

-- 皮肤：制作页面不显示图片啊。是 klei 没考虑吗？
--[[local name = "critterlab";
local prefabs = { "critterlab" }
if ((rawget(_G, 'PREFAB_SKINS') or {})[name] and (rawget(_G, 'PREFAB_SKINS_IDS') or {})[name]) then
    for _, reskin_prefab in ipairs(prefabs) do
        PREFAB_SKINS[reskin_prefab] = PREFAB_SKINS[name];
        PREFAB_SKINS_IDS[reskin_prefab] = PREFAB_SKINS_IDS[name];
    end
end]]

env.AddPrefabPostInit("critterlab", function(inst)
    if not TheWorld.ismastersim then
        return inst;
    end
    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
        if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
            inst.components.burnable:Extinguish()
        end
        inst.components.lootdropper:DropLoot();

        local fx = SpawnPrefab("collapse_small")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("wood")
        inst:Remove()
    end);
end)

local Recipes = {};
local Recipes_Locate = {};

Recipes_Locate["critterlab"] = true;
Recipes[#Recipes + 1] = {
    CanMake = env.GetModConfigData("critterlab") ~= false,
    name = "critterlab_copy", -- 这样会导致被摧毁无掉落物
    ingredients = {
        Ingredient("bluemooneye", 1), Ingredient("boards", 4), Ingredient("cutstone", 4)
    },
    tech = TECH.NONE,
    config = {
        product = "critterlab",
        placer = "critterlab_placer",
        min_spacing = nil,
        nounlock = nil,
        numtogive = nil,
        builder_tag = nil,
        atlas = "minimap/minimap_data.xml",
        image = "critterlab.png"
    },
    --filters = TUNING.MORE_ITEMS_ON and {
    --    "MONE_MORE_ITEMS5"
    --} or {
    --    "STRUCTURES"
    --}
    filters = { "STRUCTURES" }
};

for _, v in pairs(Recipes) do
    if v.CanMake ~= false then
        env.AddRecipe2(v.name, v.ingredients, v.tech, v.config, v.filters);
    end
end

