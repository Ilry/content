local Constructor = require("mym_utils/constructor")
Constructor.SetEnv(env)
local GetPrefab = require("mym_utils/getprefab")
local Utils = require("mym_utils/utils")
local SkillUtils = require("mym_skillutils")
local ModUtils = require("mym_modutils")

Utils.FnDecorator(ACTIONS.PICKUP, "fn", function(act)
    if act.doer and act.doer:HasTag("mym_mate") and act.doer.components.mym_mate then
        act.doer.components.mym_mate.checkContainer = true
    end
end, function(retTab, act)
    if act.doer.components.mym_mate then
        act.doer.components.mym_mate.checkContainer = false
    end
    return retTab
end)

-- 背包可以装备
-- Utils.FnDecorator(ACTIONS.PICKUP, "fn", function(retTab, act)
--     local state, _ = unpack(retTab)
--     if not state or not act.doer:HasTag("mym_mate") then return retTab end

--     local inventory = act.doer.components.inventory
--     local inventoryitem = act.target.components.inventoryitem
--     local equippable = act.target.components.equippable

--     if inventory ~= nil
--         and act.target ~= nil
--         and inventoryitem ~= nil and inventoryitem.canbepickedup
--         and not inventoryitem.cangoincontainer
--         and equippable and not equippable:IsRestricted(act.doer)
--         and not inventory:GetEquippedItem(equippable.equipslot)
--     then
--         inventory:Equip(act.target)
--         return { true }
--     end

--     return retTab
-- end)

-- 打开队友箱子
Constructor.AddAction({ priority = -1, mount_valid = true },
    "MYM_RUMMAGE",
    STRINGS.ACTIONS.MYM_RUMMAGE,
    function(act)
        act.target = act.target.components.mym_mate:GetContainer().inst --换成队友自己的容器对象
        return ACTIONS.RUMMAGE.fn(act)
    end,
    "doshortaction", "doshortaction"
)

-- 给予玩家所有物品，先获取容器里的东西，如果没有东西就获取已装备的东西
Constructor.AddAction(nil,
    "MYM_GIVE_ALL",
    "",
    function(act)
        local mate = act.target.mate and act.target.mate:value()
        if not mate or not mate:IsValid() then return false end

        --取消棱镜、枝江往事吉他弹奏
        if mate.sg:HasStateTag("playguitar") then
            mate:PushEvent("playenough")
        end

        local self = mate.components.inventory
        local items = {}

        for k = 1, self.maxslots do
            local v = self.itemslots[k]
            if v then
                table.insert(items, v)
            end
        end

        if self.activeitem then
            table.insert(items, self.activeitem)
            self:SetActiveItem(nil)
        end

        if #items <= 0 then
            for k, v in pairs(self.equipslots) do
                if k ~= EQUIPSLOTS.BEARD then --胡须槽的装备不应该取下
                    table.insert(items, v)
                end
            end
        end

        for _, v in ipairs(items) do
            act.doer.components.inventory:GiveItem(v)
        end

        return true
    end
)

local recipes = require("cooking").recipes
local SPICES = { "spice_garlic", "spice_sugar", "spice_chili", "spice_salt" }
local medal_spice_defs = nil --能力勋章调味粉


-- 排除的mod料理
local EXCLUDE_PRODUCTS = {
    -- 樱花林
    wirlycandy_cherrift = true,
    cherrift_torch = true,
    dumbbell_cherrift = true,
    ghostlyelixir_cherrift = true,
    wx78module_cherrift = true,
    book_cherrift = true,
    cherrift_maskhat = true,
    balloons_cherrift = true,
    cherrift_tophat = true,
    battlesong_instant_cherrift = true,
    mutator_cherrift = true,
    cherrift_catapulthat = true,
    cherrift_husk = true,
    cherrift_fork = true,
    cherrift_soulhat = true,
    cherrift_fishbox = true,
    slingshotammo_cherrift = true,
    pocketwatch_cherrift = true,
}

--- 初级料理
local PRIMARY_RECIPES = {
    meatballs = 1,        --肉丸
    jammypreserves = 1,   --果酱
    ratatouille = 1,      --蔬菜杂烩
    trailmix = 1,         --什锦干果
    fruitmedley = 0.2,    --水果圣代
    kabobs = 0.2,         --肉串
    perogies = 0.2,       --波兰水饺
    pumpkincookie = 0.2,  --南瓜饼干
    monsterlasagna = 0.2, --怪物千层饼
    sweettea = 0.2,       --舒缓茶
}

local function GetCookProduct(doer, cook)
    local day = doer.components.age:GetAgeInDays()
    day = doer.prefab == "warly" and day * 2 or day --沃利双倍
    local product = (TUNING.MYM_COOK_UNLOCK_RECIPES or math.random(0, 100) < day)
        and GetRandomItem(recipes[cook.prefab]).name
        or weighted_random_choice(PRIMARY_RECIPES)

    if EXCLUDE_PRODUCTS[product] then
        product = "jammypreserves" --果酱替代
    end

    return product
end

-- 烹饪
Constructor.AddAction(nil,
    "MYM_MATE_COOK",
    "",
    function(act)
        local comp = act.target.components
        if comp.cooker ~= nil then
            return false
        elseif comp.stewer ~= nil then
            -- 做饭
            if comp.stewer:IsCooking() then
                --Already cooking
                return true
            end
            local container = comp.container
            if container ~= nil and container:IsOpenedByOthers(act.doer) then
                return false, "INUSE"
            end

            container:DropEverything() --做之前把里面的东西都扔出来
            if act.target.prefab == "portablespicer" then
                -- 便携香料站

                -- 适配能力勋章调味粉
                if not medal_spice_defs and ModUtils.IsModEnableById(ModUtils.MODNAMES.FunctionalMedal) then
                    medal_spice_defs = {}
                    for k, _ in pairs(require("medal_defs/medal_spice_defs")) do
                        table.insert(medal_spice_defs, k)
                    end
                end

                container:DropEverything()
                local spice = act.invobject
                local owner = spice.components.inventoryitem.owner
                if owner then
                    if owner.components.container then
                        spice = owner.components.container:RemoveItem(spice)
                    elseif owner.components.inventory then
                        spice = owner.components.inventory:RemoveItem(spice)
                    end
                end

                container:GiveItem(spice, 1)
                local s = medal_spice_defs and math.random() < 0.1 --控制一下概率
                    and medal_spice_defs[math.random(1, #medal_spice_defs)]
                    or SPICES[math.random(1, #SPICES)]
                container:GiveItem(SpawnPrefab(s), 2)
                comp.stewer:StartCooking(act.doer)
            else
                -- 随机料理
                while not comp.container:IsFull() do
                    comp.container:GiveItem(SpawnPrefab("dragonfruit"))
                end
                comp.stewer.cooktimemult = math.max(math.random(), 0.2)
                comp.stewer:StartCooking(act.doer)
                comp.stewer.product = GetCookProduct(act.doer, act.target)
            end

            return true
        elseif comp.cookable ~= nil
            and act.invobject ~= nil
            and act.invobject.components.cooker ~= nil then
            return false
        end
    end,
    "dolongaction", "dolongaction"
)

-- 复活
Constructor.AddAction({ mount_valid = true, canforce = true },
    "MYM_RESPAWN_MATE",
    "",
    function(act)
        if not act.target:HasTag("playerghost") then
            return true
        end

        local item = act.invobject
        if item and item.prefab ~= "reviver" then --不校验条件
            GetPrefab.GetOne(item):Remove()
            item = nil
        end

        item = item or SpawnPrefab("reviver")

        -- 复活吧我的爱人

        if item.skin_sound then
            item.SoundEmitter:PlaySound(item.skin_sound)
        end
        item:PushEvent("usereviver", { user = act.doer })
        act.doer.hasRevivedPlayer = true
        AwardPlayerAchievement("hasrevivedplayer", act.doer)
        item:Remove()
        act.target:PushEvent("respawnfromghost", { source = item, user = act.doer })

        act.target.mym_respawnMate = nil
        act.doer.mym_respawnTarget = nil

        return true
    end,
    "give", "give"
)

-- 薇洛打火机灭火，这里创建一个会走到目标位置的action
Constructor.AddAction({ priority = -1, rmb = true, distance = 2 },
    "MYM_START_CHANNELCAST",
    "",
    function(act)
        -- 如果打火机已经打开了，走到这个位置就行了
        if act.doer and act.doer.components.channelcaster then
            if act.invobject and act.invobject.components.channelcastable
                and act.invobject.components.channelcastable:IsAnyUserChanneling() then
                return true
            end
        end

        return ACTIONS.START_CHANNELCAST.fn(act)
    end,
    "start_channelcast", "start_channelcast"
)


local SKILLTREE_SPELL_DEFS, TryBurstFire, TryBallFire, TryShadowFire, TryLunarFire

local CASTAOE = {
    -- 自燃术
    willow_fire_burst = function(act)
        if not TryBurstFire then return true end --如果没有，可能是官方改了代码，或者其他mod覆盖了，找不到应该视为成功，不然老是尝试施放一个找不到的技能不太好
        return TryBurstFire(act.invobject, act.doer, act:GetActionPoint())
    end,
    -- 火球术
    willow_fire_ball = function(act)
        if not TryBallFire then return true end
        return TryBallFire(act.invobject, act.doer, act:GetActionPoint())
    end,
    -- 暗焰
    willow_allegiance_shadow_fire = function(act)
        if not TryShadowFire then return true end
        return TryShadowFire(act.invobject, act.doer, act:GetActionPoint())
    end,
    -- 月焰
    willow_allegiance_lunar_fire = function(act)
        if not TryLunarFire then return true end
        return TryLunarFire(act.invobject, act.doer, act:GetActionPoint())
    end,
}

-- 施法
Utils.FnDecorator(ACTIONS.CASTAOE, "fn", function(act)
    local doer = act.doer
    if not doer or not doer:HasTag("mym_mate")
    then
        return
    end

    if not SKILLTREE_SPELL_DEFS then
        SKILLTREE_SPELL_DEFS = Utils.ChainFindUpvalue(GLOBAL.Prefabs["willow_ember"].fn, "updatespells",
            "SKILLTREE_SPELL_DEFS")
        if SKILLTREE_SPELL_DEFS then
            TryBurstFire = Utils.ChainFindUpvalue(SKILLTREE_SPELL_DEFS.willow_fire_burst.onselect,
                "FireBurstSpellFn", "TryBurstFire")
            TryBallFire = Utils.ChainFindUpvalue(SKILLTREE_SPELL_DEFS.willow_fire_ball.onselect,
                "FireBallSpellFn", "TryBallFire")
            TryShadowFire = Utils.ChainFindUpvalue(SKILLTREE_SPELL_DEFS.willow_allegiance_shadow_fire.onselect,
                "ShadowFireSpellFn", "TryShadowFire")
            TryLunarFire = Utils.ChainFindUpvalue(SKILLTREE_SPELL_DEFS.willow_allegiance_lunar_fire.onselect,
                "LunarFireSpellFn", "TryLunarFire")
        end
    end

    local skill = act.recipe --技能名，虽然不正规，但是应该不会有什么问题
    if skill and CASTAOE[skill] then
        return { CASTAOE[skill](act) }, true
    else
        if act.invobject ~= nil and act.invobject.components.aoespell ~= nil then --去掉指示器动画是否启用的判断
            return { act.invobject.components.aoespell:CastSpell(doer, act:GetActionPoint()) }, true
        end
    end
end)


-- 使用通用技能
Constructor.AddAction(
    { priority = 10, mount_valid = true, distance = 8, invalid_hold_action = true },
    "MYM_USE_SKILL",
    "",
    function(act)
        local doer = act.doer

        if not doer.components.mym_mate or not doer.components.mym_mate.skillData then
            return false --不应该
        end

        doer.components.mym_mate.skillData.fn(act) --就算不成功也按成功计算
        SkillUtils.OnUseSuccessd(act.doer)
        return true                                --不成功就会一直执行，我不希望原地卡在那里一直施法
    end,
    "mym_use_skill", "mym_use_skill"
)


local function MateCanPushBuf(player)
    return not GetPrefab.IsEntityDeadOrGhost(player) and (not player.sg or not player.sg:HasStateTag("busy"))
end

-- 让机器人拔下电路，电路提取器不需要在机器人背包里
Constructor.AddAction({ priority = 10 },
    "MYM_REMOVEMODULES",
    STRINGS.ACTIONS.REMOVEMODULES,
    function(act)
        if MateCanPushBuf(act.target) then
            act.target:PushBufferedAction(BufferedAction(act.target, act.target, ACTIONS.REMOVEMODULES, act.invobject))
            return true
        end
        return false
    end,
    "give", "give"
)
Constructor.AddAction({ priority = 10 },
    "MYM_REMOVEMODULES_FAIL",
    STRINGS.ACTIONS.REMOVEMODULES,
    function(act)
        if MateCanPushBuf(act.target) then
            act.target:PushBufferedAction(BufferedAction(act.target, act.target, ACTIONS.REMOVEMODULES_FAIL,
                act.invobject))
            return true
        end
        return false
    end,
    "give", "give"
)

-- 禁止收回
Utils.FnDecorator(ACTIONS.DISMANTLE, "fn", function(act)
    return { false }, act.target and act.target and act.target:HasTag("mym_temp")
end)
