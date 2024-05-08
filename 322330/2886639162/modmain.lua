GLOBAL.setmetatable(
    env,
    {
        __index = function(t, k)
            return GLOBAL.rawget(GLOBAL, k)
        end
    }
)

local regrow_dogrowth = GetModConfigData("regrow_dogrowth")
local need_tile = GetModConfigData("need_tile")
local need_tag = GetModConfigData("need_tag")
local need_seed = GetModConfigData("need_seed")
local magicgrowable = GetModConfigData("magicgrowable")
local oversized = GetModConfigData("oversized")
local noseeds = GetModConfigData("noseeds")

-- 采集农作物后生成全新的农作物；不需要移除原来的农作物
local function RegeneratePlant(inst)
    local plant = SpawnPrefab(inst.prefab)
    plant.Transform:SetPosition(inst.Transform:GetWorldPosition())

    if plant.plant_def ~= nil then
        -- 允许最终长成巨大
        plant.no_oversized = not oversized
        plant.long_life = inst.long_life
        plant.components.farmsoildrinker:CopyFrom(inst.components.farmsoildrinker)
        -- 不继承植物的压力
        -- plant.components.farmplantstress:CopyFrom(inst.components.farmplantstress)
        if regrow_dogrowth then
            plant.components.growable:DoGrowth()
        end
        plant.AnimState:OverrideSymbol("veggie_seed", "farm_soil", "seed")
    end
    if not magicgrowable then
        plant.components.growable.magicgrowable = false
    end
    inst.grew_into = plant -- so the caller can get the new plant that replaced this object
end

-- 判断采集者是否有特定农作物的种子，有则消耗掉一颗特定种子
local function consumePlantSeed(inst, picker)
    local seed = inst.plant_def and inst.plant_def.seed
    if not seed or seed == "" or type(seed) ~= "string" then
        return false
    end
    if
        picker.components.inventory and
            picker.components.inventory:FindItem(
                function(item)
                    return item.prefab == seed
                end
            ) ~= nil
     then
        picker.components.inventory:ConsumeByName(seed, 1)
        return true
    end
    return false
end

-- 采集农作物时判断再生
AddComponentPostInit(
    "pickable",
    function(self)
        local oldPick = self.Pick
        self.Pick = function(self, picker)
            -- 采收需要标签或种子
            if
                self.inst and self.inst:HasTag("farm_plant") and self.remove_when_picked and
                    (not need_tile or
                        TheWorld.Map:GetTileAtPoint(self.inst.Transform:GetWorldPosition()) == WORLD_TILES.FARMING_SOIL) and
                    (not need_tag or picker:HasTag(need_tag)) and
                    (not need_seed or consumePlantSeed(self.inst, picker))
             then
                RegeneratePlant(self.inst)
            end
            oldPick(self, picker)
        end
    end
)

-- 采收产物无种子
if noseeds then
    local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
    local spoiled_food_loot = {"spoiled_food"}
    local function SetupLoot(lootdropper)
        local inst = lootdropper.inst
        if inst:HasTag("farm_plant_killjoy") then -- if rotten
            lootdropper:SetLoot(inst.is_oversized and inst.plant_def.loot_oversized_rot or spoiled_food_loot)
        elseif inst.components.pickable ~= nil then
            local plant_stress =
                inst.components.farmplantstress ~= nil and inst.components.farmplantstress:GetFinalStressState() or
                FARM_PLANT_STRESS.HIGH

            if inst.is_oversized then
                lootdropper:SetLoot({inst.plant_def.product_oversized})
            elseif plant_stress == FARM_PLANT_STRESS.LOW or plant_stress == FARM_PLANT_STRESS.NONE then
                lootdropper:SetLoot(
                    noseeds == true and {inst.plant_def.product, inst.plant_def.product, inst.plant_def.product} or
                        {inst.plant_def.product}
                )
            elseif plant_stress == FARM_PLANT_STRESS.MODERATE then
                lootdropper:SetLoot(
                    noseeds == true and {inst.plant_def.product, inst.plant_def.product} or {inst.plant_def.product}
                )
            else -- plant_stress == FARM_PLANT_STRESS.HIGH
                lootdropper:SetLoot({inst.plant_def.product})
            end
        end
    end
    local function oversized_makeloots(inst, product)
        local seeds = product .. "_seeds"
        return noseeds == true and {product, product, product, product, product} or
            (math.random() < 0.75 and {product, product, product} or {product, product})
    end
    for veggie, data in pairs(PLANT_DEFS) do
        if not data.data_only then --allow mods to skip our prefab constructor.
            AddPrefabPostInit(
                data.prefab,
                function(inst)
                    if not TheWorld.ismastersim then
                        return inst
                    end
                    if inst.components.lootdropper then
                        inst.components.lootdropper.lootsetupfn = SetupLoot
                    end
                end
            )
        end
        data.loot_oversized_rot =
            noseeds == true and {"spoiled_food", "spoiled_food", "spoiled_food", data.product, "fruitfly", "fruitfly"} or
            {"spoiled_food", "spoiled_food", "spoiled_food", "fruitfly", "fruitfly"}
        if data.product_oversized then
            AddPrefabPostInit(
                data.product_oversized,
                function(inst)
                    if not TheWorld.ismastersim then
                        return inst
                    end
                    if inst.components.lootdropper then
                        inst.components.lootdropper:SetLoot(oversized_makeloots(inst, data.product))
                    end
                end
            )
        end
    end
end
