---
--- @author zsh in 2023/2/23 8:46
---

local API = require("pets_enhancement.API");

local config_data = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA;
local BALANCE = config_data.balance;

local fns = {};

function fns.containerOnEntityReplicated(inst, widgetsetup_prefab)
    local old_OnEntityReplicated = inst.OnEntityReplicated
    inst.OnEntityReplicated = function(inst)
        if old_OnEntityReplicated then
            old_OnEntityReplicated(inst)
        end
        if inst and inst.replica and inst.replica.container then
            inst.replica.container:WidgetSetup(widgetsetup_prefab);
        end
    end
end

function fns._onopenfn(inst, data)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open");
end

function fns._onclosefn(inst, data)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close");
end

-- 小浣猫
local kitten = config_data.critter_kitten;
if kitten then
    if config_data.critter_kitten2 then
        local widgetsetup_prefab = "pets_critter_kitten2";
        local containers = require("containers");
        local params = containers.params;
        params.pets_critter_kitten2 = {
            widget = {
                slotpos = {},
                animbank = "my_chest_ui_4x4",
                animbuild = "my_chest_ui_4x4",
                pos = Vector3(0 + 220 + 5, 200, 0),
                buttoninfo = {
                    text = "一键整理",
                    position = Vector3(0, -190, 0),
                    fn = function(inst, doer)
                        if inst.components.container ~= nil then
                            API.arrangeContainer(inst);
                        elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
                            SendRPCToServer(RPC.DoWidgetButtonAction, nil, inst, nil); -- !!! SendRPCToServer + RPC + AddXXXRPCHandler
                        end
                    end,
                    validfn = function(inst)
                        return inst.replica.container ~= nil and not inst.replica.container:IsEmpty();
                    end
                }
            },
            type = "pets_critter_kitten2",
            itemtestfn = function(container, item, slot)
                return true;
            end
        }

        for y = 2, -1, -1 do
            for x = -1, 2 do
                table.insert(params.pets_critter_kitten2.widget.slotpos, Vector3(80 * x - 40, 80 * y - 40, 0))
            end
        end

        env.AddPrefabPostInit("critter_kitten", function(inst)
            if not TheWorld.ismastersim then
                fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
                return inst;
            end
            inst:AddComponent("container");
            inst.components.container:WidgetSetup(widgetsetup_prefab);
            inst.components.container.onopenfn = fns._onopenfn;
            inst.components.container.onclosefn = fns._onclosefn;
            inst.components.container.skipclosesnd = true;
            inst.components.container.skipopensnd = true;
            inst.components.container.canbeopened = true;
        end)

    else
        local MAX_SLOTS_NUMBER = 12;
        local widgetsetup_prefab = "pets_critter_kitten";
        local TAGS = {
            FISH_TAG = {
                "pets_critter_kitten_tag_1",
                "pets_critter_kitten_tag_2",
                "pets_critter_kitten_tag_3"
            },
            OWNER_TAG = {
                "pets_critter_kitten_special_effects_tag_1",
                "pets_critter_kitten_special_effects_tag_2",
                "pets_critter_kitten_special_effects_tag_3",
            }
        }
        local SPECIAL_ONE = 1.06;
        local SPECIAL_TWO = 1.12;
        local SPECIAL_THREE = 1.18;

        -- 容器的 itemtestfn
        for _, p in ipairs({
            "pondfish", "pondeel",
            "oceanfish_medium_1_inv", "oceanfish_medium_2_inv", "oceanfish_medium_3_inv", "oceanfish_medium_4_inv", "oceanfish_medium_5_inv", "oceanfish_medium_6_inv", "oceanfish_medium_7_inv", "oceanfish_medium_8_inv", "oceanfish_medium_9_inv",
            "oceanfish_small_1_inv", "oceanfish_small_2_inv", "oceanfish_small_3_inv", "oceanfish_small_4_inv", "oceanfish_small_5_inv", "oceanfish_small_6_inv", "oceanfish_small_7_inv", "oceanfish_small_8_inv", "oceanfish_small_9_inv",
        }) do
            env.AddPrefabPostInit(p, function(inst)
                inst:AddTag("pets_critter_kitten_itemtestfn_tag");
            end)
        end

        -- 给限制放入的预制物设置特殊标签
        env.AddPrefabPostInit("pondfish", function(inst)
            inst:AddTag(TAGS.FISH_TAG[1]);
        end);
        env.AddPrefabPostInit("pondeel", function(inst)
            inst:AddTag(TAGS.FISH_TAG[2]);
        end);
        for _, p in ipairs({
            "oceanfish_medium_1_inv", "oceanfish_medium_2_inv", "oceanfish_medium_3_inv", "oceanfish_medium_4_inv", "oceanfish_medium_5_inv", "oceanfish_medium_6_inv", "oceanfish_medium_7_inv", "oceanfish_medium_8_inv", "oceanfish_medium_9_inv",
            "oceanfish_small_1_inv", "oceanfish_small_2_inv", "oceanfish_small_3_inv", "oceanfish_small_4_inv", "oceanfish_small_5_inv", "oceanfish_small_6_inv", "oceanfish_small_7_inv", "oceanfish_small_8_inv", "oceanfish_small_9_inv",
        }) do
            env.AddPrefabPostInit(p, function(inst)
                inst:AddTag(TAGS.FISH_TAG[3]);
            end);
        end

        local function ClearAllSpecialEffects(owner)
            if owner:HasTag(TAGS.OWNER_TAG[1]) then
                owner:RemoveTag(TAGS.OWNER_TAG[1]);
                owner.components.locomotor:RemoveExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[1]);
                owner.components.combat.externaldamagemultipliers:RemoveModifier(TAGS.OWNER_TAG[1]);
                owner.components.talker:Say("我失去了小浣猫给我提供的力量！");
            end

            if owner:HasTag(TAGS.OWNER_TAG[2]) then
                owner:RemoveTag(TAGS.OWNER_TAG[2]);
                owner.components.locomotor:RemoveExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[2]);
                owner.components.combat.externaldamagemultipliers:RemoveModifier(TAGS.OWNER_TAG[2]);
                owner.components.talker:Say("我失去了小浣猫给我提供的力量！");
            end

            if owner:HasTag(TAGS.OWNER_TAG[3]) then
                owner:RemoveTag(TAGS.OWNER_TAG[3]);
                owner.components.locomotor:RemoveExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[3]); -- 速度
                --owner.components.health.absorb = owner.components.health.absorb / SPECIAL_THREE; -- 防御（罢了）
                owner.components.combat.externaldamagemultipliers:RemoveModifier(TAGS.OWNER_TAG[3]); -- 攻击
                owner.components.talker:Say("我失去了小浣猫给我提供的力量！");
            end
        end

        local function GetSpecialEffects(inst, data)
            local owner = inst.components.follower and inst.components.follower.leader;
            if not inst.components.container or not owner then
                return ;
            end
            if not inst.components.container:IsFull() then
                --print("第1个清除位置");
                ClearAllSpecialEffects(owner);
                return ;
            end

            inst.pets_critter_kitten_owner = owner;

            local items;

            items = inst.components.container:FindItems(function(item)
                return item:HasTag(TAGS.FISH_TAG[1]);
            end);
            if #items == MAX_SLOTS_NUMBER then
                --print("第1种效果！");
                owner.components.talker:Say("我的速度和攻击力在小浣猫的加持下提升了" .. tostring((SPECIAL_ONE - 1) * 100) .. "%！");
                owner:AddTag(TAGS.OWNER_TAG[1]);
                owner.components.locomotor:SetExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[1], SPECIAL_ONE);
                owner.components.combat.externaldamagemultipliers:SetModifier(TAGS.OWNER_TAG[1], SPECIAL_ONE);
                return ;
            end

            items = inst.components.container:FindItems(function(item)
                return item:HasTag(TAGS.FISH_TAG[2]);
            end);
            if #items == MAX_SLOTS_NUMBER then
                --print("第2种效果！");
                owner.components.talker:Say("我的速度和攻击力在小浣猫的加持下提升了" .. tostring((SPECIAL_TWO - 1) * 100) .. "%！");
                owner:AddTag(TAGS.OWNER_TAG[2]);
                owner.components.locomotor:SetExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[2], SPECIAL_TWO);
                owner.components.combat.externaldamagemultipliers:SetModifier(TAGS.OWNER_TAG[2], SPECIAL_TWO);
                return ;
            end
            -- 12种不同的鱼将提供特殊效果
            -- 2023-02-06-12:28 改为任意海鱼均可
            -- 2023-02-06-16:23 改为 6 种海鱼即可
            -- 2023-02-06-16:36 有人吵架，我觉得增加个内容平衡的选项
            items = inst.components.container:FindItems(function(item)
                return item:HasTag(TAGS.FISH_TAG[3]);
            end);
            if #items == MAX_SLOTS_NUMBER then
                local len = 0;

                -- 不同的海鱼将提供特殊效果
                local diff = {};
                for _, v in ipairs(items) do
                    diff[v.prefab] = true;
                end
                for _, _ in pairs(diff) do
                    len = len + 1;
                end

                if not BALANCE then
                    len = MAX_SLOTS_NUMBER;
                end

                if len == MAX_SLOTS_NUMBER then
                    --print("第3种效果！");
                    owner.components.talker:Say("我的速度和攻击力在小浣猫的加持下提升了" .. tostring((SPECIAL_THREE - 1) * 100) .. "%！");
                    owner:AddTag(TAGS.OWNER_TAG[3]);

                    owner.components.locomotor:SetExternalSpeedMultiplier(owner, TAGS.OWNER_TAG[3], SPECIAL_THREE); -- 速度
                    --owner.components.health.absorb = owner.components.health.absorb * SPECIAL_THREE; -- 防御（罢了）
                    owner.components.combat.externaldamagemultipliers:SetModifier(TAGS.OWNER_TAG[3], SPECIAL_THREE); -- 攻击
                end
                return ;
            end

            --print("第2个清除位置");
            -- 如果三种情况都不满足，清除所有效果
            ClearAllSpecialEffects(owner);
        end

        env.AddPrefabPostInit("critter_kitten", function(inst)
            if not TheWorld.ismastersim then
                fns.containerOnEntityReplicated(inst, widgetsetup_prefab)
                return inst;
            end
            inst:AddComponent("container");
            inst.components.container:WidgetSetup(widgetsetup_prefab);
            inst.components.container.onopenfn = fns._onopenfn;
            inst.components.container.onclosefn = fns._onclosefn;
            inst.components.container.skipclosesnd = true;
            inst.components.container.skipopensnd = true;

            -- TODO: 在玩家钓鱼时增加鱼饵吸引力，钓上来的鱼自动上去捡起来收入囊中（爪刨动作）


            inst:AddComponent("preserver")
            inst.components.preserver:SetPerishRateMultiplier(-0.33);

            inst:ListenForEvent("dropitem", GetSpecialEffects);
            inst:ListenForEvent("gotnewitem", GetSpecialEffects);
            inst:ListenForEvent("itemget", GetSpecialEffects);
            inst:ListenForEvent("itemlose", GetSpecialEffects);

            -- 重启游戏之后，上面这四个监听并不会执行。那我整理一下这里面的东西
            inst:DoTaskInTime(0.1, function(inst)
                if inst.components.container then
                    API.arrangeContainer(inst);
                end
            end);

            -- 因为这个小浣猫不是通过 buff 效果，而是直接修改玩家属性的。因此必须保证清除一切效果的函数能够被执行！
            -- 所以说，我本应该用 buff 的形式起作用的！
            --inst.PetsOnDespawn = function(inst)
            --    if inst.pets_critter_kitten_owner then
            --        ClearAllSpecialEffects(inst.pets_critter_kitten_owner);
            --    end
            --end
            local old_Remove = inst.Remove;
            inst.Remove = function(inst)
                if inst.pets_critter_kitten_owner then
                    ClearAllSpecialEffects(inst.pets_critter_kitten_owner);
                end
                if old_Remove then
                    old_Remove(inst);
                end
            end
        end)
    end
end

-- 小座狼
local puppy = config_data.critter_puppy;
if puppy then
    local widgetsetup_prefab = "pets_critter_puppy";

    env.AddPrefabPostInit("critter_puppy", function(inst)

        --inst:AddTag("foodpreserver");
        --inst:AddTag("fridge");
        --inst:AddTag("nocool");

        if not TheWorld.ismastersim then
            fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
            return inst;
        end

        inst:AddComponent("container");
        inst.components.container:WidgetSetup(widgetsetup_prefab);
        inst.components.container.onopenfn = fns._onopenfn;
        inst.components.container.onclosefn = fns._onclosefn;
        inst.components.container.skipclosesnd = true;
        inst.components.container.skipopensnd = true;

        if inst.components.eater then
            inst.components.eater:SetDiet({ FOODTYPE.MONSTER, FOODTYPE.ELEMENTAL }, { FOODTYPE.MONSTER, FOODTYPE.ELEMENTAL });
        end

        inst:AddComponent("pets_critter_puppy");

        inst:AddComponent("preserver")
        inst.components.preserver:SetPerishRateMultiplier(0.5);

        -- 缓慢返鲜 1/16 = 0.0625
        local RATE = 0.0625;
        inst:DoPeriodicTask(30, function(inst)
            local container = inst.components.container;
            if container then
                local items = container:FindItems(function(item)
                    return item and (item.prefab == "monsterlasagna"
                            or item.prefab == "monstertartare"
                            or item.prefab == "durian"
                            or item.prefab == "durian_cooked");
                end)
                for _, v in ipairs(items) do
                    if v.components.perishable then
                        local percent = v.components.perishable:GetPercent() + RATE;
                        v.components.perishable:SetPercent(percent);
                    end
                end
            end
        end)

        inst:ListenForEvent("oneat", function(inst, data)
            local food = data and data.food;
            local feeder = data and data.feeder;

            if not (food and feeder) then
                return ;
            end

            local foodname = food.prefab;
            local owner = inst.components.follower and inst.components.follower.leader;
            if feeder == owner then
                inst.components.pets_critter_puppy:TryAddBuff(foodname, owner);
                inst.components.pets_critter_puppy:TrySpawnHounds(inst, foodname, owner, food);
            end
        end);

        --inst.PetsOnDespawn = function(inst)
        --
        --end

    end)
end

-- 小钢羊
local lamb = config_data.critter_lamb;
if lamb then
    local widgetsetup_prefab = "pets_critter_lamb";

    -- CanAcceptCount
    local function CanAcceptCount(container, item, maxcount)
        if not (item and item:IsValid()) then
            return 0;
        end

        local stacksize = math.max(maxcount or 0, item.components.stackable ~= nil and item.components.stackable.stacksize or 1)
        if stacksize <= 0 then
            return 0
        end

        local acceptcount = 0

        --check for empty space in the container
        for k = 1, container.numslots do
            local v = container.slots[k]
            if v ~= nil then
                if v.prefab == item.prefab and v.skinname == item.skinname and v.components.stackable ~= nil then
                    acceptcount = acceptcount + v.components.stackable:RoomLeft()
                    if acceptcount >= stacksize then
                        return stacksize
                    end
                end
            elseif container:CanTakeItemInSlot(item, k) then
                if container.acceptsstacks or stacksize <= 1 then
                    return stacksize
                end
                acceptcount = acceptcount + 1
                if acceptcount >= stacksize then
                    return stacksize
                end
            end
        end

        return acceptcount
    end

    -- 以下部分为：simutil.lua 内容
    local PICKUP_MUST_ONEOF_TAGS = { "_inventoryitem", "pickable" }
    local PICKUP_CANT_TAGS = {
        -- Items
        "INLIMBO", "NOCLICK", "irreplaceable", "knockbackdelayinteraction", "event_trigger",
        "minesprung", "mineactive", "catchable",
        "fire", "light", "spider", "cursed", "paired", "bundle",
        "heatrock", "deploykititem", "boatbuilder", "singingshell",
        "archive_lockbox", "simplebook",
        -- Pickables
        "flower", "gemsocket", "structure",
        -- Either
        "donotautopick",
        -- chang
        "trap"
    }

    local function FindPickupableItem_filter(v, ba, owner, radius, furthestfirst, positionoverride, ignorethese, onlytheseprefabs, allowpickables, ispickable, worker)
        if AllBuilderTaggedRecipes[v.prefab] then
            return false
        end
        -- NOTES(JBK): "donotautopick" for general class components here.
        if v.components.armor or v.components.weapon or v.components.tool or v.components.equippable or v.components.sewing or v.components.erasablepaper then
            return false
        end
        if v.components.burnable ~= nil and (v.components.burnable:IsBurning() or v.components.burnable:IsSmoldering()) then
            return false
        end
        if ispickable then
            if not allowpickables then
                return false
            end
        else
            if not (v.components.inventoryitem ~= nil and
                    v.components.inventoryitem.canbepickedup and
                    v.components.inventoryitem.cangoincontainer and
                    not v.components.inventoryitem:IsHeld()) then
                return false
            end
        end
        if ignorethese ~= nil and ignorethese[v] ~= nil and ignorethese[v].worker ~= worker then
            return false
        end
        if onlytheseprefabs ~= nil and onlytheseprefabs[ispickable and v.components.pickable.product or v.prefab] == nil then
            return false
        end
        if v.components.container ~= nil then
            -- Containers are most likely sorted and placed by the player do not pick them up.
            return false
        end
        if v.components.bundlemaker ~= nil then
            -- Bundle creators are aesthetically placed do not pick them up.
            return false
        end
        if v.components.bait ~= nil and v.components.bait.trap ~= nil then
            -- Do not steal baits.
            return false
        end
        if v.components.trap ~= nil and not (v.components.trap:IsSprung() and v.components.trap:HasLoot()) then
            -- Only interact with traps that have something in it to take.
            return false
        end

        -- chang
        --if not ispickable and owner.components.inventory:CanAcceptCount(v, 1) <= 0 then -- TODO(JBK): This is not correct for traps nor pickables but they do not have real prefabs made yet to check against.
        --    return false
        --end

        if ba ~= nil and ba.target == v and (ba.action == ACTIONS.PICKUP or ba.action == ACTIONS.CHECKTRAP or ba.action == ACTIONS.PICK) then
            return false
        end
        return v, ispickable
    end

    -- This function looks for an item on the ground that could be ACTIONS.PICKUP (or ACTIONS.CHECKTRAP if a trap) by the owner and subsequently put into the owner's inventory.
    function fns.FindPickupableItem(owner, radius, furthestfirst, positionoverride, ignorethese, onlytheseprefabs, allowpickables, worker)
        if owner == nil or owner.components.inventory == nil then
            return nil
        end
        local ba = owner:GetBufferedAction()
        local x, y, z
        if positionoverride then
            x, y, z = positionoverride:Get()
        else
            x, y, z = owner.Transform:GetWorldPosition()
        end
        local ents = TheSim:FindEntities(x, y, z, radius, nil, PICKUP_CANT_TAGS, PICKUP_MUST_ONEOF_TAGS)
        local istart, iend, idiff = 1, #ents, 1
        if furthestfirst then
            istart, iend, idiff = iend, istart, -1
        end
        for i = istart, iend, idiff do
            local v = ents[i]
            local ispickable = v:HasTag("pickable")
            if FindPickupableItem_filter(v, ba, owner, radius, furthestfirst, positionoverride, ignorethese, onlytheseprefabs, allowpickables, ispickable, worker) then
                return v, ispickable
            end
        end
        return nil, nil
    end

    env.AddPrefabPostInit("critter_lamb", function(inst)
        if not TheWorld.ismastersim then
            fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
            return inst;
        end

        inst:AddComponent("container");
        inst.components.container:WidgetSetup(widgetsetup_prefab);
        inst.components.container.onopenfn = fns._onopenfn;
        inst.components.container.onclosefn = fns._onclosefn;
        inst.components.container.skipclosesnd = true;
        inst.components.container.skipopensnd = true;

        inst:WatchWorldState("isfullmoon", function(inst, isfullmoon)
            if not isfullmoon then
                return ;
            end
            local scale = 0.25;
            local fx = SpawnPrefab("collapse_big");
            local x, y, z = inst.Transform:GetWorldPosition();
            fx.Transform:SetNoFaced()
            fx.Transform:SetPosition(x, y, z)
            fx.Transform:SetScale(scale, scale, scale)
            SpawnPrefab("steelwool").Transform:SetPosition(x, y, z);
        end)

        inst:DoTaskInTime(0.1, function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if not owner then
                print("owner == nil, No Effect");
                return ;
            end

            local success_give = true;
            inst:DoPeriodicTask(TUNING.ORANGEAMULET_ICD --[[* 1.5]]--[[0.33]], function(inst, owner)
                local container = inst.components.container;

                -- 判断里面满没满太麻烦了吧？
                if not container --[[or container:IsFull()]] then
                    return ;
                end
                -- 由于success_give只会初始化一次，不像读书，读一次触发一次。所以这种保证能够塞满的方式功能无法实现
                -- 先这样吧！满了就不捡了！不想接着优化了！
                --if not container then
                --    return ;
                --end
                --if not success_give then
                --    return ;
                --end
                local first_item = container:GetItemInSlot(1);
                if first_item == nil or first_item.prefab ~= "sewing_kit" then
                    return ;
                end

                local radius = TUNING.ORANGEAMULET_RANGE * 1; -- 4*1

                -- 功能扩充
                local last_item = container:GetItemInSlot(16);
                if last_item and last_item.prefab == "sewing_kit" then
                    local x, y, z = owner.Transform:GetWorldPosition();
                    local MUST_TAGS = { "_inventoryitem" };
                    local CANT_TAGS = { "INLIMBO", "NOCLICK", "knockbackdelayinteraction", "catchable", "mineactive", "FX" };
                    local MUST_ONEOF_TAGS = nil;
                    local ents = TheSim:FindEntities(x, y, z, radius, MUST_TAGS, CANT_TAGS, MUST_ONEOF_TAGS);

                    local cnt = 0;
                    if #ents > 0 then
                        for _, v in ipairs(ents) do
                            if cnt > 0 then
                                -- 一次就捡一个
                                break ;
                            end
                            --print("CanAcceptCount(container, v, 1): "..tostring(CanAcceptCount(container, v, 1)))
                            if v.prefab ~= "sewing_kit" and container:Has(v.prefab, 1) and CanAcceptCount(container, v, 1) > 0 then
                                cnt = cnt + 1;
                                SpawnPrefab("sand_puff").Transform:SetPosition(v.Transform:GetWorldPosition());
                                SpawnPrefab("sand_puff").Transform:SetPosition(inst.Transform:GetWorldPosition());
                                success_give = container:GiveItem(v);
                            end
                        end
                    end

                    return ;
                end

                -- 成组捡起
                local item = fns.FindPickupableItem(owner, radius, false);

                if item == nil or item.prefab == "sewing_kit" or CanAcceptCount(container, item, 1) <= 0 then
                    return ;
                end

                SpawnPrefab("sand_puff").Transform:SetPosition(item.Transform:GetWorldPosition());
                SpawnPrefab("sand_puff").Transform:SetPosition(inst.Transform:GetWorldPosition());

                local item_pos = item:GetPosition();
                item_pos = nil; -- 算了，这只是你看到的而已。而且还挺别扭呢。

                success_give = container:GiveItem(item, nil, item_pos);
            end, nil, owner)
        end)
    end)
end

-- 小火鸡
local perdling = config_data.critter_perdling;
if perdling then
    local function SpawnPerds(inst, number)
        number = number or 1;
        local x, y, z = inst.Transform:GetWorldPosition();
        local RADIUS = 8;
        if x and y and z then
            local spawn_position = {};
            local seg = 360 / number;
            local angles = {};
            for i = 1, number do
                table.insert(angles, i * seg);
            end
            for _, angle in ipairs(angles) do
                table.insert(spawn_position, { x = x + math.cos(angle * PI / 180) * RADIUS, z = z + math.sin(angle * PI / 180) * RADIUS, y = y });
            end

            for _, v in ipairs(spawn_position) do
                SpawnPrefab("perd").Transform:SetPosition(v.x, v.y, v.z);
                SpawnPrefab("collapse_big").Transform:SetPosition(v.x, v.y, v.z);
            end
        end
    end

    env.AddPrefabPostInit("critter_perdling", function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        inst:ListenForEvent("oneat", function(inst, data)
            local food = data and data.food;
            local feeder = data and data.feeder;

            if not (food and feeder) then
                return ;
            end

            if food.prefab == "drumstick" then
                SpawnPerds(inst, 1);
            elseif food.prefab == "turkeydinner" then
                if math.random() < 0.2 then
                    SpawnPerds(inst, 6);
                else
                    SpawnPerds(inst, 3);
                end
            end
        end);

        inst:DoTaskInTime(0, function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner then
                --print("", "AddTag: perdling_animal_friend");
                owner:AddTag("perdling_animal_friend");
                owner:AddTag("beefalo");
            end
        end)

        --inst.PetsOnDespawn = function(inst)
        --    local owner = inst.components.follower and inst.components.follower.leader;
        --    if owner then
        --        owner:RemoveTag("perdling_animal_friend");
        --        owner:RemoveTag("beefalo");
        --    end
        --end

        local old_Remove = inst.Remove;
        inst.Remove = function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner then
                owner:RemoveTag("perdling_animal_friend");
                owner:RemoveTag("beefalo");
            end
            if old_Remove then
                old_Remove(inst);
            end
        end
    end)

    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        --print(tostring(ThePlayer:HasTag("perdling_animal_friend")));
        --print(tostring(ThePlayer:HasTag("critter_dragonling_lavae_notarget")));
        --print(tostring(ThePlayer:HasTag("monster")));
        -- 主人不会惊动小生物（换种写法）
        --if inst.components.petleash then
        --    local old_onspawnfn = inst.components.petleash.onspawnfn;
        --    inst.components.petleash.onspawnfn = function(inst, pet)
        --        if pet and pet.prefab == "critter_perdling" then
        --            print("------critter_perdling")
        --            inst:AddTag("perdling_animal_friend");
        --            -- ? 为什么不执行这个监听？
        --            pet:ListenForEvent("onremove", function(inst, data)
        --                print("------remove critter_perdling");
        --                inst:RemoveTag("perdling_animal_friend");
        --            end, inst);
        --        end
        --        if old_onspawnfn then
        --            old_onspawnfn(inst, pet);
        --        end
        --    end
        --end
    end);

    -- 处理一下全体预制物，加个标签，因为 smallcreature 标签不够用
    env.AddPrefabPostInitAny(function(inst)
        if inst:HasTag("smallcreature") then
            inst:AddTag("perdling_smallcreature");
        end
        if API.LocalFn.containsValue({
            "perd"
        }, inst.prefab) then
            inst:AddTag("perdling_smallcreature");
        end
    end)

    --require("behaviours.runaway"); -- 我去，这样导入就是错的。。。为什么？虽然知道有区别，但是还是不知道为什么。
    require("behaviours/runaway");

    --print("", "RunAway: " .. tostring(RunAway));
    if RunAway then
        local old_RunAway_ctor = RunAway._ctor;
        --print("", "old_RunAway_ctor: " .. tostring(old_RunAway_ctor));
        RunAway._ctor = function(self, inst, ...)
            old_RunAway_ctor(self, inst, ...);
            if self.hunternotags and type(self.hunternotags) == "table" then
                if self.inst and self.inst.HasTag and self.inst:HasTag("perdling_smallcreature") then
                    --print("", "insert perdling_animal_friend!");
                    table.insert(self.hunternotags, "perdling_animal_friend");
                end
            end
        end
    end
end

-- 小龙蝇
local dragonling = config_data.critter_dragonling;
if dragonling then

    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        -- 主人不会被 lavae 岩浆虫仇恨（换个写法）
        --if inst.components.petleash then
        --    local old_onspawnfn = inst.components.petleash.onspawnfn;
        --    inst.components.petleash.onspawnfn = function(inst, pet)
        --        if pet and pet.prefab == "critter_dragonling" then
        --            print("------critter_dragonling")
        --            inst:AddTag("critter_dragonling_lavae_notarget");
        --            pet:ListenForEvent("onremove", function(inst, data)
        --                print("------remove critter_dragonling");
        --                inst:RemoveTag("critter_dragonling_lavae_notarget");
        --            end, inst);
        --        end
        --        if old_onspawnfn then
        --            old_onspawnfn(inst, pet);
        --        end
        --    end
        --end
    end);

    env.AddPrefabPostInit("lavae", function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end

        if not inst.components.combat then
            return inst;
        end

        if inst.components.combat.targetfn then
            --print("[" .. tostring(inst.prefab) .. "]: targetfn √");

            local old_TryRetarget = inst.components.combat.TryRetarget;
            inst.components.combat.TryRetarget = function(self)
                if old_TryRetarget then
                    old_TryRetarget(self);
                end

                if self.targetfn ~= nil
                        and not (self.inst.components.health ~= nil and
                        self.inst.components.health:IsDead())
                        and not (self.inst.components.sleeper ~= nil and
                        self.inst.components.sleeper:IsInDeepSleep()) then

                    if self.target and self.target:HasTag("critter_dragonling_lavae_notarget") then
                        --print("1:HasTag:critter_dragonling_lavae_notarget");
                        self:SetTarget(nil);
                    end
                end
            end
        end

        if inst.components.combat.keeptargetfn then
            --print("[" .. tostring(inst.prefab) .. "]: keeptargetfn √");
            local old_keeptargetfn = inst.components.combat.keeptargetfn;
            inst.components.combat.keeptargetfn = function(inst, target)
                if target:HasTag("critter_dragonling_lavae_notarget") then
                    --print("2:HasTag:critter_dragonling_lavae_notarget");
                    return false;
                end
                return old_keeptargetfn(inst, target);
            end
        end

    end);

    env.AddPrefabPostInit("critter_dragonling", function(inst)
        -- 发光
        inst.entity:AddLight()
        inst.Light:Enable(true)
        inst.Light:SetRadius(2.0)
        inst.Light:SetFalloff(.9)
        inst.Light:SetIntensity(0.5)
        inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

        inst:AddTag("cooker")

        if not TheWorld.ismastersim then
            return inst;
        end

        inst:AddComponent("cooker");

        -- 有30%的概率一次烹饪得到两个
        local old_CookItem = inst.components.cooker.CookItem;
        inst.components.cooker.CookItem = function(self, item, chef)
            local newitem = old_CookItem(self, item, chef);
            if newitem and newitem.components.stackable then
                if math.random() < 0.3 then
                    local surprise;
                    local surprise_save_record;
                    if newitem:IsValid() and newitem.persists then
                        surprise_save_record = newitem:GetSaveRecord()
                    end
                    if surprise_save_record then
                        surprise = SpawnSaveRecord(surprise_save_record);
                    end
                    if surprise then
                        newitem.components.stackable:Put(surprise);

                        -- 说：我真是烹饪小能手
                        local owner = self.inst.components.follower and self.inst.components.follower.leader;
                        if owner then
                            owner.components.talker:Say("我可真是个烹饪小能手！");
                        end
                    end
                end
            end
            return newitem;
        end

        -- 冬天才散热
        inst:WatchWorldState("season", function(inst, season)
            --print("season: " .. tostring(season));
            if not season then
                return ;
            end
            if season == "winter" then
                if inst.components.heater == nil then
                    inst:AddComponent("heater")
                end
                inst.components.heater.heat = 70; -- 火坑四个阶段 70, 85, 100, 115
                --inst.components.heater:SetThermics(false, true)
            else
                if inst.components.heater then
                    inst:RemoveComponent("heater")
                end
            end
        end);

        -- 还需要添加个 DoTaskInTime ...
        inst:DoTaskInTime(0, function(inst)
            if TheWorld.state.iswinter then
                if inst.components.heater == nil then
                    inst:AddComponent("heater")
                end
                inst.components.heater.heat = 70; -- 火坑四个阶段 70, 85, 100, 115
                --inst.components.heater:SetThermics(false, true)
            else
                if inst.components.heater then
                    inst:RemoveComponent("heater")
                end
            end
        end)

        inst:DoTaskInTime(0, function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner then
                --print("","AddTag: critter_dragonling_lavae_notarget");
                owner:AddTag("critter_dragonling_lavae_notarget");
            end
        end)

        --inst.PetsOnDespawn = function(inst)
        --    local owner = inst.components.follower and inst.components.follower.leader;
        --    if owner then
        --        owner:RemoveTag("critter_dragonling_lavae_notarget");
        --    end
        --end

        local old_Remove = inst.Remove;
        inst.Remove = function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner then
                owner:RemoveTag("critter_dragonling_lavae_notarget");
            end
            if old_Remove then
                old_Remove(inst);
            end
        end
    end)
end

-- 小格罗姆
local glomling = config_data.critter_glomling;
if glomling then
    local widgetsetup_prefab = "pets_critter_glomling";

    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        if inst.components.sanity then
            --local old_Recalc = inst.components.sanity.Recalc;
            --inst.components.sanity.Recalc = function(self, dt)
            --    old_Recalc(self, dt);
            --    if self.inst:HasTag("pets_buff_critter_glomling_sanity_against") then
            --        if self.rate < 0 then
            --            self:DoDelta(-1 * self.rate * dt, true);
            --        end
            --    end
            --end
            local old_DoDelta = inst.components.sanity.DoDelta;
            inst.components.sanity.DoDelta = function(self, delta, overtime, ...)
                if self.inst:HasTag("pets_buff_critter_glomling_sanity_against") then
                    if delta < 0 then
                        delta = 0;
                    end
                end
                if old_DoDelta then
                    return old_DoDelta(self, delta, overtime, ...);
                end
            end
        end
    end)

    env.AddPrefabPostInit("critter_glomling", function(inst)

        --inst:AddTag("foodpreserver");
        --inst:AddTag("fridge");
        --inst:AddTag("nocool");

        if not TheWorld.ismastersim then
            fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
            return inst;
        end

        inst:AddComponent("container");
        inst.components.container:WidgetSetup(widgetsetup_prefab);
        inst.components.container.onopenfn = fns._onopenfn;
        inst.components.container.onclosefn = fns._onclosefn;
        inst.components.container.skipclosesnd = true;
        inst.components.container.skipopensnd = true;

        if inst.components.eater then
            inst.components.eater:SetDiet({ FOODTYPE.GENERIC, FOODTYPE.GOODIES, FOODTYPE.MEAT }, { FOODTYPE.GENERIC, FOODTYPE.GOODIES, FOODTYPE.MEAT });
        end

        inst:AddComponent("sanityaura")
        inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY / 2; -- 格罗姆 100/(seg_time*32) == 6

        inst:AddComponent("preserver")
        inst.components.preserver:SetPerishRateMultiplier(0.5);

        inst:ListenForEvent("oneat", function(inst, data)
            local food = data and data.food;
            local feeder = data and data.feeder;

            local foodname = food and food.prefab;
            local owner = inst.components.follower and inst.components.follower.leader;

            if not (foodname and feeder and owner) then
                return ;
            end

            if foodname == "jellybean" then
                owner:AddDebuff("pets_buff_sanityregenbuff", "pets_buff_sanityregenbuff");
            elseif foodname == "leafymeatsouffle" then
                local buffname = "pets_buff_critter_glomling_sanity_against";
                if owner.components.debuffable and owner.components.debuffable:IsEnabled() and
                        not (owner.components.health and owner.components.health:IsDead()) and
                        not owner:HasTag("playerghost") then
                    if owner.components.sanity then
                        owner[buffname] = { totaltime = TUNING.SEG_TIME * 8 / 2 * 2 } -- 半天、4分钟：TUNING.SEG_TIME * 8
                        owner.components.debuffable:AddDebuff(buffname, buffname); -- 可以 owner:AddDebuff
                    end
                end
            end
        end);

        -- isfullmoon
        inst:WatchWorldState("isfullmoon", function(inst, isfullmoon)
            if not isfullmoon then
                return ;
            end
            local container = inst.components.container;
            if not container then
                return ;
            end

            local function recoverAllItems(container)
                local items = container:GetAllItems();
                for _, item in ipairs(items) do
                    if item and item.components.perishable then
                        item.components.perishable:SetPercent(1);
                    end
                end
            end

            if math.random() < 0.1 then
                -- 全部食物恢复新鲜度
                recoverAllItems(container);
            else
                -- 随机三个格子
                local items = container:GetAllItems();
                if #items > 0 then
                    local seq = {};
                    for i = 1, #items do
                        table.insert(seq, i);
                    end
                    local cnt = 3;
                    local len = #seq;

                    if len <= cnt then
                        recoverAllItems(container);
                    else
                        for i = 1, cnt do
                            -- i>len 会报错！
                            local get = math.random(i, len);
                            local tmp = seq[i];
                            seq[i] = seq[get];
                            seq[get] = tmp;
                        end
                        for i = 1, cnt do
                            local item = items[seq[i]];
                            if item and item.components.perishable then
                                item.components.perishable:SetPercent(1);
                            end
                        end
                    end
                end
            end

            -- 特效
            inst._pets_light = SpawnPrefab("chesterlight")
            inst._pets_light.Transform:SetPosition(inst:GetPosition():Get())
            inst._pets_light:TurnOn();

            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")

            inst.sg:GoToState("sleep")
            --inst.sg:GoToState("sleeping")

            inst:DoTaskInTime(2.5, function(inst)
                if inst._pets_light then
                    inst._pets_light:TurnOff();
                end
                --inst.sg:GoToState("wake")
            end);
        end);
        return inst;
    end)
end

-- 小蛾子
local lunarmothling = config_data.critter_lunarmothling;
if lunarmothling then
    local widgetsetup_prefab = "pets_critter_lunarmothling";

    -- 小蛾子的主人对梦魇生物有额外25%的伤害加成 nightmarecreature
    env.AddPrefabPostInitAny(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        if inst:HasTag("nightmarecreature") or inst:HasTag("shadowcreature") then
            if inst.components.combat then
                local old_GetAttacked = inst.components.combat.GetAttacked;
                function inst.components.combat:GetAttacked(attacker, damage, weapon, stimuli, ...)
                    if attacker and attacker:HasTag("critter_lunarmothling_tag1") then
                        if damage >= 0 then
                            --print("old_damage: " .. tostring(damage));
                            damage = damage * 1.25;
                            --print("new_damage: " .. tostring(damage));
                        end
                    end
                    return old_GetAttacked(self, attacker, damage, weapon, stimuli, ...);
                end
            end
        end
    end)

    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end

        inst:AddComponent("pets_critter_lunarmothling");


        -- NOTE: 下次不要中途修改函数了。。。应该像这样提前修改好！！！
        if inst.components.sanity then
            local old_DoDelta = inst.components.sanity.DoDelta;
            function inst.components.sanity:DoDelta(delta, overtime)
                local pets_critter_lunarmothling = self.inst.components.pets_critter_lunarmothling;
                if pets_critter_lunarmothling == nil then
                    print("不可能进入的逻辑块！");
                    return old_DoDelta(self, delta, overtime);
                end
                if pets_critter_lunarmothling.state then
                    delta = 0;
                end
                return old_DoDelta(self, delta, overtime);
            end
        end

        inst:ListenForEvent("changearea", function(inst, data)
            if inst:HasTag("critter_lunarmothling_tag1") then
                local moonisland = data
                        and data.tags
                        and table.contains(data.tags, "RoadPoison")
                        and table.contains(data.tags, "lunacyarea");
                if moonisland then
                    if inst.components.pets_critter_lunarmothling then
                        inst.components.pets_critter_lunarmothling:TakeEffect();
                    end
                else
                    if inst.components.pets_critter_lunarmothling then
                        inst.components.pets_critter_lunarmothling:RemoveEffect();
                    end
                end
            end
        end)
    end)

    local DurabilityTag = "pets_critter_lunarmothling_durability_tag";

    local function AddDurabilityMult(equip)
        if equip ~= nil and equip.components.weapon ~= nil and equip.components.finiteuses ~= nil then
            equip.components.weapon.attackwearmultipliers:SetModifier(DurabilityTag, 1 / 4)
        end
    end

    local function RemoveDurabilityMult(equip)
        if equip ~= nil and equip.components.weapon ~= nil and equip.components.finiteuses ~= nil then
            equip.components.weapon.attackwearmultipliers:RemoveModifier(DurabilityTag)
        end
    end

    -- 直接修改人物即可
    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end

        -- 可以通过以 fn 为键移除监听
        inst:ListenForEvent("equip", function(inst, data)
            if inst:HasTag(DurabilityTag) then
                if data.eslot == EQUIPSLOTS.HANDS then
                    AddDurabilityMult(data.item)
                end
            end
        end)

        inst:ListenForEvent("unequip", function(inst, data)
            if data.eslot == EQUIPSLOTS.HANDS then
                RemoveDurabilityMult(data.item)
            end
        end)
    end)

    local function getSpecialEffect(inst, data)
        local container = inst.components.container;
        if container == nil then
            return ;
        end

        local owner = inst.components.follower and inst.components.follower.leader;
        if owner == nil then
            -- DoNothing
            return ;
        end

        -- 降低武器消耗 moonglass_charged:40
        if container:Has("alterguardianhatshard", 1) then
            --owner.components.talker:Say("我手中的武器将更加耐用！");
            if not owner:HasTag(DurabilityTag) then
                owner:AddTag(DurabilityTag);
                AddDurabilityMult(owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS));
            end
        else
            --owner.components.talker:Say("我手中的武器恢复正常，不再更加耐用了...");
            if owner:HasTag(DurabilityTag) then
                owner:RemoveTag(DurabilityTag);
                RemoveDurabilityMult(owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS));
            end
        end

        do
            return ;
        end
        -- 生成雷电攻击？
        if container:Has("moonstorm_spark", 20) then

        else

        end
    end

    -- 容器内有某物品时，主人添加标签
    -- 武器耐久消耗减半？燃料? 使用次数? 护甲? 新鲜度?
    local function SetItemListenForEvent(inst)
        inst:ListenForEvent("dropitem", getSpecialEffect);
        inst:ListenForEvent("itemlose", getSpecialEffect);
        inst:ListenForEvent("gotnewitem", getSpecialEffect);
        inst:ListenForEvent("itemget", getSpecialEffect);

        -- 重启游戏后整理一下容器，让监听器得以触发
        inst:DoTaskInTime(0, function(inst)
            API.arrangeContainer(inst);
        end)
    end

    env.AddPrefabPostInit("critter_lunarmothling", function(inst)
        if not TheWorld.ismastersim then
            fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
            return inst;
        end

        inst:AddComponent("container");
        inst.components.container:WidgetSetup(widgetsetup_prefab);
        inst.components.container.onopenfn = fns._onopenfn;
        inst.components.container.onclosefn = fns._onclosefn;
        inst.components.container.skipclosesnd = true;
        inst.components.container.skipopensnd = true;

        inst:AddComponent("preserver")
        inst.components.preserver:SetPerishRateMultiplier(0);

        --print(tostring(ThePlayer.components.areaaware:GetCurrentArea().id));
        --print(tostring(ThePlayer.components.areaaware:GetCurrentArea().type));
        --print(tostring(ThePlayer.components.areaaware:GetCurrentArea().center));
        --print(tostring(ThePlayer.components.areaaware:GetCurrentArea().poly));
        --for _, v in ipairs(ThePlayer.components.areaaware:GetCurrentArea().tags) do print("",v); end

        inst:DoTaskInTime(0, function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner == nil then
                print("Chang Error: critter_lunarmothling owner == nil");
                return ;
            end
            owner:AddTag("critter_lunarmothling_tag1");
            local data = owner.components.areaaware and owner.components.areaaware.current_area_data;
            local moonisland = data
                    and data.tags
                    and table.contains(data.tags, "RoadPoison")
                    and table.contains(data.tags, "lunacyarea");
            if moonisland then
                -- 重载游戏，执行此处逻辑时，不必更新 self.ori_sanity 的值，因为已经存储过了！
                if owner.components.pets_critter_lunarmothling then
                    owner.components.pets_critter_lunarmothling:TakeEffectReset();
                end
            else
                if owner.components.pets_critter_lunarmothling then
                    owner.components.pets_critter_lunarmothling:RemoveEffect();
                end
            end
        end)

        --inst.PetsOnDespawn=function(inst)
        --    local owner = inst.components.follower and inst.components.follower.leader;
        --    if owner then
        --        -- 效果清除
        --        owner:RemoveTag("critter_lunarmothling_tag1");
        --        if owner.components.pets_critter_lunarmothling then
        --            owner.components.pets_critter_lunarmothling:RemoveEffect();
        --        end
        --
        --        owner:RemoveTag(DurabilityTag);
        --        RemoveDurabilityMult(owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS));
        --    end
        --end

        local old_Remove = inst.Remove;
        inst.Remove = function(inst)
            local owner = inst.components.follower and inst.components.follower.leader;
            if owner then
                -- 效果清除
                owner:RemoveTag("critter_lunarmothling_tag1");
                if owner.components.pets_critter_lunarmothling then
                    owner.components.pets_critter_lunarmothling:RemoveEffect();
                end

                owner:RemoveTag(DurabilityTag);
                RemoveDurabilityMult(owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS));
            end
            if old_Remove then
                old_Remove(inst);
            end
        end

        SetItemListenForEvent(inst);
    end)
end

-- 友好窥视者
local eyeofterror = config_data.critter_eyeofterror;
if eyeofterror then
    -- world，所以地上地下是两个world吗？如果是两个world的话，如何才能数据互通呢？   双进程、通过 shard
    env.AddPrefabPostInit("world", function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        inst:AddComponent("pets_world_container");
    end)

    local widgetsetup_prefab = "pets_critter_eyeofterror";

    local function _onopenfn(inst, data)
        fns._onopenfn(inst, data);

        inst.components.pets_critter_eyeofterror:Lock();
    end

    local function _onclosefn(inst, data)
        fns._onclosefn(inst, data);

        inst.components.pets_critter_eyeofterror:Unlock();
    end

    local GHOSTVISION_COLOURCUBES = {
        day = "images/colour_cubes/ghost_cc.tex",
        dusk = "images/colour_cubes/ghost_cc.tex",
        night = "images/colour_cubes/ghost_cc.tex",
        full_moon = "images/colour_cubes/ghost_cc.tex",
    }

    local NIGHTVISION_COLOURCUBES = {
        day = "images/colour_cubes/mole_vision_off_cc.tex",
        dusk = "images/colour_cubes/mole_vision_on_cc.tex",
        night = "images/colour_cubes/mole_vision_on_cc.tex",
        full_moon = "images/colour_cubes/mole_vision_off_cc.tex",
    }

    local NIGHTMARE_COLORCUBES = {
        calm = "images/colour_cubes/ruins_dark_cc.tex",
        warn = "images/colour_cubes/ruins_dim_cc.tex",
        wild = "images/colour_cubes/ruins_light_cc.tex",
        dawn = "images/colour_cubes/ruins_dim_cc.tex",
    }

    local function CustomCCTable(self)
        local cctable = (self.ghostvision and GHOSTVISION_COLOURCUBES)
                or self.overridecctable
                or ((self.nightvision or self.forcenightvision) and NIGHTVISION_COLOURCUBES)
                or (self.nightmarevision and NIGHTMARE_COLORCUBES)
                or nil;

        -- 这个是主要的！
        cctable = {
            day = "images/colour_cubes/spring_day_cc.tex",
            dusk = "images/colour_cubes/spring_dusk_cc.tex",
            night = "images/colour_cubes/purple_moon_cc.tex",
            full_moon = "images/colour_cubes/purple_moon_cc.tex",
        }
        return cctable;
    end

    -- 夜视
    env.AddPlayerPostInit(function(inst)
        inst.critter_eyeofterror_nightvision = net_bool(inst.GUID, "critter_eyeofterror_nightvision", "critter_eyeofterror_nightvisionnightvisiondirty");

        inst:ListenForEvent("critter_eyeofterror_nightvisionnightvisiondirty", function(inst)
            local hasbuff = inst.critter_eyeofterror_nightvision:value();
            if hasbuff then
                if inst.components.playervision then
                    inst.components.playervision:ForceNightVision(true)
                    inst.components.playervision:ForceGoggleVision(true)
                    inst.components.playervision:SetCustomCCTable(CustomCCTable(inst.components.playervision));
                end
            else
                if inst.components.playervision then
                    inst.components.playervision:ForceNightVision(inst._forced_nightvision and inst._forced_nightvision:value()); -- 机器人
                    inst.components.playervision:ForceGoggleVision(false)
                    inst.components.playervision:SetCustomCCTable(nil)
                end
            end
        end)
    end);

    env.AddPrefabPostInit("critter_eyeofterror", function(inst)

        --inst:AddComponent("container_proxy"); -- 主客机都添加该组件

        if not TheWorld.ismastersim then
            fns.containerOnEntityReplicated(inst, widgetsetup_prefab);
            return inst;
        end

        if inst.components.eater then
            inst.components.eater:SetDiet({ FOODTYPE.GENERIC, FOODTYPE.GOODIES }, { FOODTYPE.GENERIC, FOODTYPE.GOODIES });
        end

        inst:AddComponent("pets_critter_eyeofterror");

        if inst.components.inspectable == nil then
            inst:AddComponent("inspectable")
        end

        inst:AddComponent("container");
        inst.components.container:WidgetSetup(widgetsetup_prefab);
        inst.components.container.onopenfn = _onopenfn;
        inst.components.container.onclosefn = _onclosefn;
        inst.components.container.skipclosesnd = true;
        inst.components.container.skipopensnd = true;
        inst.components.container.canbeopened = true;

        if inst.components.timer == nil then
            inst:AddComponent("timer");
        end

        -- 真麻烦啊。是我代码结构有问题 还是 依据条件 暂停/触发计时 的东西就是这么麻烦？
        inst:DoTaskInTime(0, function(inst)
            local TIME = 0;
            local TIMER_NAME = "pets_critter_eyeofterror_timer";
            local OWNER = inst.components.follower and inst.components.follower.leader;

            -- 重载游戏后的判定
            inst:DoTaskInTime(0, function(inst)
                local owner = OWNER;
                if not owner then
                    print("Chang WARNING: DoTaskInTime, owner == nil!");
                    return ;
                end
                if not TheWorld.state.isnight then
                    if inst.components.timer:TimerExists(TIMER_NAME) then
                        owner.critter_eyeofterror_nightvision:set(false);
                        inst.components.timer:PauseTimer(TIMER_NAME);
                    end
                elseif TheWorld.state.isnight then
                    if inst.components.timer:TimerExists(TIMER_NAME) then
                        owner.critter_eyeofterror_nightvision:set(true);
                        inst.components.timer:ResumeTimer(TIMER_NAME);
                        local left_time = inst.components.timer:GetTimeLeft(TIMER_NAME) or 0;
                        owner.components.talker:Say("我重新得到了友好窥视者明目之力，还剩 " .. string.format("%.0f", left_time) .. " 秒！");
                    end
                end
            end);

            -- 监听世界阶段变换，功能生效/不生效
            inst:WatchWorldState("phase", function(inst, phase)
                local owner = OWNER;

                if not phase then
                    print("Chang WARNING: phase == nil!");
                    return ;
                end
                if not owner then
                    print("Chang WARNING: owner == nil!");
                    return ;
                end

                local hasbuff = owner.critter_eyeofterror_nightvision:value();
                local left_time = inst.components.timer:GetTimeLeft(TIMER_NAME) or 0;

                if phase == "night" then
                    if not hasbuff and left_time > 0 then
                        owner.critter_eyeofterror_nightvision:set(true);
                        inst.components.timer:ResumeTimer(TIMER_NAME);
                        owner.components.talker:Say("我重新得到了友好窥视者明目之力，还剩 " .. string.format("%.0f", left_time) .. " 秒！");
                    end
                else
                    if hasbuff then
                        owner.critter_eyeofterror_nightvision:set(false);
                        inst.components.timer:PauseTimer(TIMER_NAME);
                        owner:DoTaskInTime(1, function(owner, phase, left_time)
                            if phase == "day" then
                                owner.components.talker:Say("我暂时失去了友好窥视者明目之力，还剩 " .. string.format("%.0f", left_time) .. " 秒！");
                            end
                        end, phase, left_time)
                    end
                end
            end);

            -- 功能触发函数
            inst:ListenForEvent("oneat", function(inst, data)
                local food = data and data.food;
                local feeder = data and data.feeder;

                if not (food and feeder) then
                    return ;
                end

                local foodname = food.prefab;
                local owner = OWNER;

                local totaltime;
                local multiple = 1.5;
                if foodname == "honey" then
                    totaltime = TUNING.SEG_TIME * 4 * 2 / 10 * multiple;
                elseif foodname == "taffy" then
                    totaltime = TUNING.SEG_TIME * 4 * 2 / 4 * multiple;
                elseif foodname == "jellybean" then
                    totaltime = TUNING.SEG_TIME * 4 * 2 * multiple; -- 120 * 2
                elseif foodname == "deerclops_eyeball" then
                    totaltime = TUNING.SEG_TIME * 4 * 10 * multiple;
                end

                if totaltime then
                    if owner then
                        TIME = totaltime;
                        if not inst.components.timer:TimerExists(TIMER_NAME) then
                            inst.components.timer:StartTimer(TIMER_NAME, TIME);

                            local time_left = inst.components.timer:GetTimeLeft(TIMER_NAME) or 0;
                            owner.components.talker:Say("我得到了 " .. string.format("%.0f", time_left) .. " 秒的友好窥视者明目之力！");

                            if TheWorld.state.isnight then
                                owner.critter_eyeofterror_nightvision:set(true);
                            else
                                owner.critter_eyeofterror_nightvision:set(false);
                                inst.components.timer:PauseTimer(TIMER_NAME);
                            end
                        else
                            local time_left = (inst.components.timer:GetTimeLeft(TIMER_NAME) or 0) + TIME;
                            --print("GetTimeLeft: "..tostring(inst.components.timer:GetTimeLeft(TIMER_NAME)))
                            --print("time_left: "..tostring(time_left));
                            inst.components.timer:StopTimer(TIMER_NAME);
                            inst.components.timer:StartTimer(TIMER_NAME, time_left);
                            owner.components.talker:Say("我又得到了 " .. string.format("%.0f", time_left) .. " 秒的友好窥视者明目之力！");

                            if TheWorld.state.isnight then
                                owner.critter_eyeofterror_nightvision:set(true);
                            else
                                owner.critter_eyeofterror_nightvision:set(false);
                                inst.components.timer:PauseTimer(TIMER_NAME);
                            end
                        end
                    end
                end

                ---@deprecated
                --if totaltime then
                --    if owner and owner.components.debuffable and owner.components.debuffable:IsEnabled() and
                --            not (owner.components.health and owner.components.health:IsDead()) and
                --            not owner:HasTag("playerghost") then
                --        local buffname = "pets_buff_critter_eyeofterror_molehat";
                --        owner[buffname] = { totaltime = totaltime }; -- TUNING.SEG_TIME: 30s
                --        owner.components.debuffable:AddDebuff(buffname, buffname);
                --    end
                --end
            end);

            -- 计时器结束后的处理
            inst:ListenForEvent("timerdone", function(inst, data)
                if data.name == TIMER_NAME then
                    local owner = OWNER;
                    if owner == nil then
                        print("Chang WARNING: timerdone event, owner == nil ???");
                        return ;
                    end
                    owner.critter_eyeofterror_nightvision:set(false);
                    owner.components.talker:Say("我彻底失去了友好窥视者明目之力！");
                end
            end)

            -- 宠物被删除后的处理
            -- 2023-02-27-09:21：？这个 onremove 我记得会调用的。但是我昨天在别的地方发现不调用。所以这样到底是不是正确的？
            -- 没问题啊。。。Remove 调用过程中会 PushEvent 的。
            inst:ListenForEvent("onremove", function(inst, data)
                local owner = OWNER;
                if owner == nil then
                    print("Chang WARNING: onremove event, owner == nil ???");
                    return ;
                end
                inst.components.timer:StopTimer(TIMER_NAME);
                owner.critter_eyeofterror_nightvision:set(false);
                owner.components.talker:Say("我彻底失去了友好窥视者明目之力！");
            end);
        end)

    end)
end