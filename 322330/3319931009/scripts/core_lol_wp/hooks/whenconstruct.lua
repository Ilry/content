-- AddComponentPostInit('constructionsite',
-- ---comment
-- ---@param self component_constructionsite
-- function (self)
--     function self:DropAllMaterials(drop_pos,...)
--         print('-----------------------')
--         -- local prods = {}

--         -- local x, y, z
--         -- if drop_pos ~= nil then
--         --     x, y, z = drop_pos:Get()
--         -- else
--         --     x, y, z = self.inst.Transform:GetWorldPosition()
--         -- end
--         -- for k, v in pairs(self.materials) do
--         --     local num = self:RemoveMaterial(k, v.amount)
--         --     while num > 0 do
--         --         local loot = SpawnPrefab(k)
--         --         if loot.components.stackable ~= nil then
--         --             ---@diagnostic disable-next-line: param-type-mismatch
--         --             loot.components.stackable:SetStackSize(math.min(num, loot.components.stackable.maxsize))
--         --             num = num - loot.components.stackable:StackSize()
--         --         else
--         --             num = num - 1
--         --         end
--         --         if loot.components.inventoryitem ~= nil then
--         --             loot.components.inventoryitem:DoDropPhysics(x, y, z, true)
--         --         else
--         --             loot.Transform:SetPosition(x, y, z)
--         --         end
--         --         table.insert(prods,loot)
--         --     end
--         -- end
--         -- for k,v in pairs(prods) do
--         --     print(v)
--         -- end
--         -- return prods
--     end
-- end)
local DESTSOUNDS =
{
    {   --magic
        soundpath = "dontstarve/common/destroy_magic",
        ing = { "nightmarefuel", "livinglog" },
    },
    {   --cloth
        soundpath = "dontstarve/common/destroy_clothing",
        ing = { "silk", "beefalowool" },
    },
    {   --tool
        soundpath = "dontstarve/common/destroy_tool",
        ing = { "twigs" },
    },
    {   --gem
        soundpath = "dontstarve/common/gem_shatter",
        ing = { "redgem", "bluegem", "greengem", "purplegem", "yellowgem", "orangegem" },
    },
    {   --wood
        soundpath = "dontstarve/common/destroy_wood",
        ing = { "log", "boards" },
    },
    {   --stone
        soundpath = "dontstarve/common/destroy_stone",
        ing = { "rocks", "cutstone" },
    },
    {   --straw
        soundpath = "dontstarve/common/destroy_straw",
        ing = { "cutgrass", "cutreeds" },
    },
}
local DESTSOUNDSMAP = {}
for i, v in ipairs(DESTSOUNDS) do
    for i2, v2 in ipairs(v.ing) do
        DESTSOUNDSMAP[v2] = v.soundpath
    end
end
DESTSOUNDS = nil

local function CheckSpawnedLoot(loot)
    if loot.components.inventoryitem ~= nil then
        loot.components.inventoryitem:TryToSink()
    else
        local lootx, looty, lootz = loot.Transform:GetWorldPosition()
        if ShouldEntitySink(loot, true) or TheWorld.Map:IsPointNearHole(Vector3(lootx, 0, lootz)) then
            SinkEntity(loot)
        end
    end
end

---comment
---@param inst ent
---@param lootprefab any
local function SpawnLootPrefab(inst, lootprefab)
    if lootprefab == nil then
        return
    end

    local loot = SpawnPrefab(lootprefab)

    if lootprefab == 'lol_wp_s7_tearsofgoddess' then
        local val = 0
        if inst.components.count_from_tearsofgoddness then
            val = inst.components.count_from_tearsofgoddness.val
        end
        if val > 0 then
            if loot.components.lol_wp_s7_tearsofgoddess then
                loot.components.lol_wp_s7_tearsofgoddess:DoDelta(val,nil)
            end
        end
    end

    if loot == nil then
        return
    end

    local x, y, z = inst.Transform:GetWorldPosition()

    if loot.Physics ~= nil then
        local angle = math.random() * TWOPI
        loot.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))

        if inst.Physics ~= nil then
            local len = loot:GetPhysicsRadius(0) + inst:GetPhysicsRadius(0)
            x = x + math.cos(angle) * len
            z = z + math.sin(angle) * len
        end

        loot:DoTaskInTime(1, CheckSpawnedLoot)
    end

    loot.Transform:SetPosition(x, y, z)

	loot:PushEvent("on_loot_dropped", {dropper = inst})

    return loot
end

local function destroystructure(staff, target)
    local recipe = AllRecipes[target.prefab]
    if recipe == nil or FunctionOrValue(recipe.no_deconstruction, target) then
        --Action filters should prevent us from reaching here normally
        return
    end

    local ingredient_percent =
        (   (target.components.finiteuses ~= nil and not FunctionOrValue(recipe.decon_ignores_finiteuses, target) and target.components.finiteuses:GetPercent()) or
            (target.components.fueled ~= nil and target.components.inventoryitem ~= nil and target.components.fueled:GetPercent()) or
            (target.components.armor ~= nil and target.components.inventoryitem ~= nil and target.components.armor:GetPercent()) or
            1
        ) / recipe.numtogive

    --V2C: Can't play sounds on the staff, or nobody
    --     but the user and the host will hear them!
    local caster = staff.components.inventoryitem.owner

    -- If the target is a mimic, drop nightmarefuel instead of any of the recipe loot.
    if target.components.itemmimic then
        if caster then
		    caster.SoundEmitter:PlaySound("dontstarve/creatures/monkey/poopsplat")
        end
        target.components.itemmimic:TurnEvil(caster)
    else
        for i, v in ipairs(recipe.ingredients) do
            if caster ~= nil and DESTSOUNDSMAP[v.type] ~= nil then
                caster.SoundEmitter:PlaySound(DESTSOUNDSMAP[v.type])
            end
            if string.sub(v.type, -3) ~= "gem" or string.sub(v.type, -11, -4) == "precious" then
                --V2C: always at least one in case ingredient_percent is 0%
                local amt = v.amount == 0 and 0 or math.max(1, math.ceil(v.amount * ingredient_percent))
                for _ = 1, amt do
                    SpawnLootPrefab(target, v.type)
                end
            end
        end

        if target.components.inventory ~= nil then
            target.components.inventory:DropEverything()
        end

        if target.components.container ~= nil then
            target.components.container:DropEverything(nil, true)
        end

        if target.components.spawner ~= nil and target.components.spawner:IsOccupied() then
            target.components.spawner:ReleaseChild()
        end

        if target.components.occupiable ~= nil and target.components.occupiable:IsOccupied() then
            local item = target.components.occupiable:Harvest()
            if item ~= nil then
                item.Transform:SetPosition(target.Transform:GetWorldPosition())
                item.components.inventoryitem:OnDropped()
            end
        end

        if target.components.trap ~= nil then
            target.components.trap:Harvest()
        end

        if target.components.dryer ~= nil then
            target.components.dryer:DropItem()
        end

        if target.components.harvestable ~= nil then
            target.components.harvestable:Harvest()
        end

        if target.components.stewer ~= nil then
            target.components.stewer:Harvest()
        end

        if target.components.constructionsite ~= nil then
            target.components.constructionsite:DropAllMaterials()
        end

        if target.components.inventoryitemholder ~= nil then
            target.components.inventoryitemholder:TakeItem()
        end

        target:PushEvent("ondeconstructstructure", caster)

        if not target.no_delete_on_deconstruct then
            if target.components.stackable ~= nil then
                --if it's stackable we only want to destroy one of them.
                target.components.stackable:Get():Remove()
            else
                target:Remove()
            end
        end
    end

    if caster ~= nil then
        caster.SoundEmitter:PlaySound("dontstarve/common/staff_dissassemble")

        if caster.components.staffsanity then
            caster.components.staffsanity:DoCastingDelta(-TUNING.SANITY_MEDLARGE)
        elseif caster.components.sanity ~= nil then
            caster.components.sanity:DoDelta(-TUNING.SANITY_MEDLARGE)
        end
    end

    staff.components.finiteuses:Use(1)
end

AddPrefabPostInit('greenstaff',function (inst)
    if not TheWorld.ismastersim then
        return inst
    end

    if inst.components.spellcaster then
        inst.components.spellcaster:SetSpellFn(destroystructure)
    end

end)