GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

Assets = {
}

-- 本地化
local lan = (_G.LanguageTranslator.defaultlang == "zh") and "zh" or "en"
if GetModConfigData("LAN_SETTING") == "default" then
    if lan == "zh" then
        modimport("languages/chs")
    else
        modimport("languages/en")
    end
elseif GetModConfigData("LAN_SETTING") == "chinese" then
    modimport("languages/chs")
elseif GetModConfigData("LAN_SETTING") == "english" then
    modimport("languages/en")
end

modimport("scripts/hooks/wendy_hook")
modimport("scripts/hooks/sisturn_hook")
modimport("scripts/hooks/abigail_hook")
modimport("scripts/hooks/ghostlyelixir_hook")
modimport("scripts/hooks/flower_hook")
modimport("scripts/hooks/ghost_hook")

modimport("scripts/tuning")
modimport("scripts/recipes")

PrefabFiles = {
    "sisters_stories",
    "medical_box",
    "herbs",
    "buffs",
    --"abigail",
    --"ghostly_elixirs",
    "moon_eye"
}

-- 骨灰罐调整


local containers = require "containers"
local params = {}

params.sisturn =
{
    widget =
    {
        slotpos =
        {
            Vector3(-37.5, 32 + 4, 0),
            Vector3(37.5, 32 + 4, 0),
            Vector3(-37.5, -(32 + 4), 0),
            Vector3(37.5, -(32 + 4), 0),
        },
        slotbg =
        {
            { image = "sisturn_slot_petals.tex" },
            { image = "sisturn_slot_petals.tex" },
            { image = "sisturn_slot_petals.tex" },
            { image = "sisturn_slot_petals.tex" },
        },
        animbank = "ui_chest_2x2",
        animbuild = "ui_chest_2x2",
        pos = Vector3(200, 0, 0),
        side_align_tip = 120,
    },
    acceptsstacks = false,
    type = "cooker",
}

function params.sisturn.itemtestfn(container, item, slot)
    if container.inst:HasTag("moon_sisturn") then
        return item.prefab == "petals" or item.prefab == "moon_tree_blossom"
    elseif container.inst:HasTag("shadow_sisturn") then
        return item.prefab == "petals" or item.prefab == "petals_evil"
    else
        return item.prefab == "petals"
    end

end

containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.sisturn.widget.slotpos ~= nil and #params.sisturn.widget.slotpos or 0)

local containers_widgetsetup = containers.widgetsetup

function containers.widgetsetup(container, prefab, data)
    local t = prefab or container.inst.prefab
    if t == "sisturn" then
        local t1 = params[t]
        if t1 ~= nil then
            for k, v in pairs(t1) do
                container[k] = v
            end
            container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
        end
    else
        return containers_widgetsetup(container, prefab, data)
    end
end

-- 登记技能树
local BuildSkillsData = require("prefabs/skilltree_wendy") -- 角色的技能树文件
local defs = require("prefabs/skilltree_defs")

local data = BuildSkillsData(defs.FN)
for k, v in pairs(data.SKILLS) do
    if v.icon then
        table.insert(Assets, Asset("ATLAS", "images/skilltree/" .. v.icon .. ".xml"))
        RegisterSkilltreeIconsAtlas("images/skilltree/" .. v.icon .. ".xml", v.icon .. ".tex")
    end
end


defs.CreateSkillTreeFor("wendy", data.SKILLS)
defs.SKILLTREE_ORDERS["wendy"] = data.ORDERS

-- 技能树用到的背景图
table.insert(Assets, Asset("ATLAS", "images/skilltree/wendy_background.xml"))
RegisterSkilltreeBGForCharacter("images/skilltree/wendy_background.xml", "wendy")

local function SpellCost(pct)
    return pct * TUNING.LARGE_FUEL * -4
end

-- 网络处理
AddModRPCHandler("wendy", "read_sisters_stories", function(inst, spell, book)
    if inst and spell then
        local sisters_stories = inst.components.inventory:GetItemsWithTag("sisters_stories")

        local ghost

        if inst.components.ghostlybond ~= nil then -- 保证组件存在
            if spell == "moon_essence" then -- 如果是月之精华，则跳过阿比盖尔的检查
                if inst.components.leader:CountFollowers("pure_ghost") >= 5 then
                    inst.components.talker:Say(STRINGS.WENDY_READ_MOON_ESSENCE_WITH_TOOMANY_GHOST)
                else
                    inst.sg:GoToState("book")
                end
            else -- 否则需要进行对阿比盖尔的检查
                if inst.components.ghostlybond.ghost ~= nil and inst.components.ghostlybond.summoned then
                    ghost = inst.components.ghostlybond.ghost
                    if ghost.components.health ~= nil and not ghost.components.health:IsDead() then
                        inst.sg:GoToState("book")
                    end
                else
                    inst.components.talker:Say(STRINGS.WENDY_READ_SISTERS_STORIES_WITHOUT_ABIGAIL)
                end
            end
        end

        if sisters_stories ~= nil then
            if spell == "sweet_memory" and ghost ~= nil then
                inst:DoTaskInTime(1, function()
                    -- 召回阿比盖尔
                    inst.components.ghostlybond:Recall()

                    book.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.SWEET_MEMORY), inst)
                    inst.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.SWEET_MEMORY)
                end)
            elseif spell == "small_contradiction" and ghost ~= nil then
                inst:DoTaskInTime(1, function()
                    -- 激怒阿比盖尔
                    ghost:BecomeAggressive()
                    -- 造成伤害
                    local TARGET_TAGS = { "_combat"}
                    local radius = 3
                    local x, y, z = ghost.Transform:GetWorldPosition()
                    local ents = TheSim:FindEntities(x, y, z, radius, nil, { "INLIMBO","structure","player","wall","abigail" }, TARGET_TAGS)

                    for i, victim in ipairs(ents) do
                        if victim ~= inst.WIND_CASTER and victim:IsValid() then
                            if victim.components.health ~= nil and
                                    not victim.components.health:IsDead() and
                                    victim.components.combat ~= nil and
                                    victim.components.combat:CanBeAttacked() then

                                victim.components.combat:GetAttacked(ghost, 100)
                            end
                        end
                    end
                    -- 爆炸特效
                    SpawnPrefab("bomb_lunarplant_explode_fx").Transform:SetPosition(x, y, z)

                    book.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.SMALL_CONTRADICTION), inst)
                    inst.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.SMALL_CONTRADICTION)

                    inst.components.talker:Say(STRINGS.WENDY_READ_SMALL_CONTRADICTION)
                end)
            elseif spell == "moon_essence" then
                local x, y, z = inst.Transform:GetWorldPosition()
                local radius = 5
                local ents = TheSim:FindEntities(x, y, z, radius, { "ghostflower" }, nil)

                local sign = false
                local count = 0
                inst:DoTaskInTime(1, function()
                    for _, ent in pairs(ents) do
                        if inst.components.leader:CountFollowers("pure_ghost") >= 5 then
                            break
                        end

                        local stackszie = ent.components.stackable:StackSize()

                        local angel = math.random() * TWOPI

                        for i = 1, stackszie do
                            local ghost_follower = SpawnPrefab("ghost")
                            ghost_follower.Transform:SetPosition(x + radius * math.cos(angel), y, z + radius * math.sin(angel))
                            sign = true
                            count = count + 1
                            ent.components.stackable:Get():Remove()

                            inst.components.leader:AddFollower(ghost_follower)
                            if inst.components.leader:CountFollowers("pure_ghost") >= 5 then
                                break
                            end
                        end
                    end

                    if sign then
                        inst.components.talker:Say(STRINGS.WENDY_READ_MOON_ESSENCE_SUMMON_GHOST)

                        book.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.MOON_ESSENCE * count), inst)
                        inst.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.MOON_ESSENCE)
                    else
                        inst.components.talker:Say(STRINGS.WENDY_READ_MOON_ESSENCE_WITH_TOOMANY_GHOST_2)
                    end
                end)
            elseif spell == "shadow_present" and ghost ~= nil then
                inst:DoTaskInTime(1, function()
                    -- 召回阿比盖尔
                    inst.components.ghostlybond:Recall()

                    inst.components.talker:Say(STRINGS.WENDY_READ_SHADOW_PRESENT)

                    inst:AddDebuff("buff_shadow_present", "buff_shadow_present")

                    book.components.fueled:DoDelta(SpellCost(TUNING.SISTERS_STORIES_SPELL_COST.SHADOW_PRESENT), inst)
                    inst.components.sanity:DoDelta(TUNING.SISTERS_STORIES_SANITY_COST.SHADOW_PRESENT)
                end)
            end
        end
    end
end)