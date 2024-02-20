---
--- @author zsh in 2023/1/8 14:13
---

local API = {};

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

---判断某元素是否是表中的键
local function containsKey(t, e)
    for k, _ in pairs(t) do
        if k == e then
            return true;
        end
    end
    return false;
end

---判断某元素是否是表中的值
local function containsValue(t, e)
    for _, v in pairs(t) do
        if v == e then
            return true;
        end
    end
    return false;
end

API.LocalFn = {
    containsKey = containsKey,
    containsValue = containsValue
}
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

---@param env env
---@return boolean
local SET_POS_ACCORDING_SCREEN_RESOLUTION = false; -- TEST
function API.isDebug(env)
    if SET_POS_ACCORDING_SCREEN_RESOLUTION then
        return true;
    end
    if env.GetModConfigData("debug") ~= false and not string.find(env.modname, "workshop") then
        return true;
    end
    return false;
end

---@param env env
---@return boolean
function API.hasBeenReleased(env)
    if string.find(env.modname, "workshop") then
        return true;
    end
    return false;
end

-- FIXME: __API.xpcall 有问题，好像是里面的 pack unpack 的问题，1,2,3,nil,4 这样的话，nil 后面都忽略了？
-- FIXME: 问题是只有第一个文件的物品导入成功了，后面的文件都注册失败。
-- 2023-02-13-08:54：刚刚看了一下代码，发现是自己写错了。。。现在应该是对的了，但是好像没必要了。
---@param files table[]
function API.loadPrefabs(files)
    local prefabsList = {};
    local file_cnt, prefab_cnt = 0, 0;
    for _, filepath in ipairs(files) do
        file_cnt = file_cnt + 1;
        if not string.find(filepath, ".lua$") then
            filepath = filepath .. ".lua";
        end
        local f, msg = loadfile(filepath); -- 加载文件，返回该文件代码构成的匿名函数
        if not f then
            print("ChangError: ", msg);
        else
            local res = { xpcall(f) };
            table.remove(res, 1);
            for _, prefab in pairs(res) do
                if type(prefab) == "table" and prefab.is_a and prefab:is_a(Prefab) then
                    table.insert(prefabsList, prefab);
                end
            end
        end
    end
    print(string.format("%s%s%s%s%s", "成功导入了：", file_cnt, " 个文件，共 ", prefab_cnt, " 个预制物。"));
    return prefabsList;
end

---按预制物名字字典序整理容器
---@type fun(inst:table):void
---@param inst table
function API.arrangeContainer(inst)
    if not (inst and inst.components.container) then
        return ;
    end

    ---@type Container
    local container = inst.components.container;
    local slots = container.slots;
    local keys = {};

    -- pairs 是随机的
    for k, _ in pairs(slots) do
        keys[#keys + 1] = k;
    end
    table.sort(keys);

    -- ipairs 是顺序的
    for k, v in ipairs(keys) do
        if (k ~= v) then
            -- 存在空洞
            local item = container:RemoveItemBySlot(v);
            container:GiveItem(item, k); -- TODO:如果超过堆叠上限会发生什么？ Answer: 会掉落
        end
    end
    -- 此时，slot 不存在空洞
    slots = container.slots;

    -- 空洞处理完毕，根据预制物的名字进行字典序
    table.sort(slots, function(entity1, entity2)
        local a, b = tostring(entity1.prefab), tostring(entity2.prefab);

        --[[        -- 如果预制物名字末尾存在数字，且除末尾数字外，相等，按序号大小排列
                -- NOTE: 没必要，因为字符串可以判断大小
                local prefix_name1,num1 = string.match(a, '(.-)(%d+)$');
                local prefix_name2,num2 = string.match(b, '(.-)(%d+)$');
                if (prefix_name1 == prefix_name2 and num1 and num2) then
                    return tonumber(num1) < tonumber(num2);
                end]]

        return a < b and true or false; -- 便于自己理解
    end)

    -- 此时，slots 已经排序好了，开始整理
    for i, v in ipairs(slots) do
        local item = container:RemoveItemBySlot(i);
        container:GiveItem(item); -- slot == nil，会遍历每一个格子把 item 塞进去，item == nil，返回 true
    end

end

---转移容器内的预制物
---@param src table
---@param dest table
function API.transferContainerAllItems(src, dest)
    local src_container = src and src.components.container;

    local dest_container = dest and dest.components.container;

    if src_container and dest_container then
        for i = 1, src_container.numslots do
            local item = src_container:RemoveItemBySlot(i);
            dest_container:GiveItem(item);
        end
    end

end

-- TODO: 非固定伤害的 AOE
function API.onattackAOE()

end

-- TODO: 无视护甲的伤害
function API.onattackTrueDamage()

end

---注意：传入的 inst，owner 代表这是在 OnEquip 函数中调用的
function API.runningOnWater(inst, owner)
    if inst.running_on_water_task then
        inst.running_on_water_task:Cancel()
        inst.running_on_water_task = nil
    end
    inst.delay_count = 0

    inst.running_on_water_task = inst:DoPeriodicTask(0.1, function(inst, owner)
        local is_moving = owner.sg:HasStateTag("moving") --玩家正在移动
        local is_running = owner.sg:HasStateTag("running") --玩家正在奔跑
        local x, y, z = owner.Transform:GetWorldPosition()

        -- 如果不是在换人物
        if x and y and z then
            if owner.components.drownable and owner.components.drownable:IsOverWater() then
                -- 增加潮湿度
                inst.components.equippable.equippedmoisture = 1
                inst.components.equippable.maxequippedmoisture = 80

                if is_running or is_moving then
                    inst.delay_count = inst.delay_count + 1
                    if inst.delay_count >= 5 then
                        SpawnPrefab("weregoose_splash_less" .. tostring(math.random(2))).entity:SetParent(owner.entity)
                        inst.delay_count = 0
                    end
                end
                -- 下地瞬间居然没有 drownable 组件
            elseif owner.components.drownable and not owner.components.drownable:IsOverWater() then
                -- 取消增加潮湿度
                inst.components.equippable.equippedmoisture = 0
                inst.components.equippable.maxequippedmoisture = 0
            end
        end
    end, nil, owner)

    -- !!!
    if owner.components.drownable then
        if owner.components.drownable.enabled ~= false then
            owner.components.drownable.enabled = false
            owner.Physics:ClearCollisionMask()
            owner.Physics:CollidesWith(COLLISION.GROUND)
            owner.Physics:CollidesWith(COLLISION.OBSTACLES)
            owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
            owner.Physics:CollidesWith(COLLISION.CHARACTERS)
            owner.Physics:CollidesWith(COLLISION.GIANTS)

            local x, y, z = owner.Transform:GetWorldPosition()
            if x and y and z then
                --换人物时，x,y,z为nil，所以需要判断一下。
                owner.Physics:Teleport(owner.Transform:GetWorldPosition())
            end
        end
    end
end

-- 这是在 onunequipfn 函数中调用的
function API.runningOnWaterCancel(inst, owner)
    -- 取消增加潮湿度
    inst.components.equippable.equippedmoisture = 0
    inst.components.equippable.maxequippedmoisture = 0

    if inst.running_on_water_task then
        inst.running_on_water_task:Cancel()
        inst.running_on_water_task = nil
    end
    if owner.components.drownable then
        if owner.components.drownable.enabled == false then
            owner.components.drownable.enabled = true
            if not owner:HasTag("playerghost") then
                --非死亡状态
                owner.Physics:ClearCollisionMask()
                owner.Physics:CollidesWith(COLLISION.WORLD)
                owner.Physics:CollidesWith(COLLISION.OBSTACLES)
                owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                owner.Physics:CollidesWith(COLLISION.CHARACTERS)
                owner.Physics:CollidesWith(COLLISION.GIANTS)
                local x, y, z = owner.Transform:GetWorldPosition()
                if x and y and z then
                    owner.Physics:Teleport(owner.Transform:GetWorldPosition())
                end
            end
        end
    end
end

-- 虽然还是有可能出现如下情况：
-- A模组添加a标签，然后执行我的添加标签部分代码，我能够识别出来此标签是否是我添加的。删除的时候也能判断出来。
-- 但是加入我添加标签后，A模组也添加了标签。然后我移除标签的时候等于把A模组的相关功能也移除了。那肯定就出问题了。
-- 反正怎么说呢，这个方法有用但不完全有用。。。但是没有可不行！

local tags = {};

function API.AddTag(inst, tag)
    if not inst:HasTag(tag) then
        inst:AddTag(tag);
        if tags[inst] == nil then
            tags[inst] = {};
        end
        tags[inst][tag] = true;
    end
end

function API.RemoveTag(inst, tag)
    if inst:HasTag(tag) then
        if tags[inst] and tags[inst][tag] then
            inst:RemoveTag(tag);
            tags[inst][tag] = nil;
        end
    end
end

-- 注意饥荒好像是左手系，三维
-- 二维屏幕的话，应该就是正常的 第一象限 的坐标轴。
function API.SetPosAccordingToScreenResolution(x, y, z, env)
    local width, height = TheSim:GetScreenSize(); -- 1280, 720; -- 获得当前的屏幕分辨率？怎么获得？
    -- 算了，暂时不知道怎么实现实时变化，我debug的时候再执行吧！
    if env and not API.isDebug(env) then
        width, height = 1980, 1080;
    end

    local RESOLUTION_X, RESOLUTION_Y = 1980, 1080; -- 我的屏幕分辨率
    local ratio_x, ratio_y = width / RESOLUTION_X, height / RESOLUTION_Y;
    return Vector3(ratio_x * x, ratio_y * y, z);
end

-- 这是清洁扫把的那个函数罢了，必须保证 build、bank 一致
-- 未来 TODO： 同类型物品都可以换皮肤，比如灯类，皮肤互换。背包类，皮肤互换。
-- NOTE: 感觉换皮肤的函数，有些不能这样统一换。因为函数各异！！！！！！有空重写一下！
---@param name string 游戏内对应的那个预制物的代码名
---@param build string 那个对应的预制物的 build
---@param prefabs table[] 有哪些预制物要被修改呢？
function API.reskin(prefabname, build, prefabs)
    local name = prefabname;
    local fn_name = name .. '_clear_fn';
    local fn = rawget(_G, fn_name);
    if not fn then
        print('`' .. fn_name .. '` global function does not exist!');
        return ;
    else
        rawset(_G, fn_name, function(inst, def_build)
            if not containsValue(prefabs, inst.prefab) then
                return fn(inst, def_build);
            else
                inst.AnimState:SetBuild(build);
            end
        end);

        if ((rawget(_G, 'PREFAB_SKINS') or {})[name] and (rawget(_G, 'PREFAB_SKINS_IDS') or {})[name]) then
            for _, reskin_prefab in ipairs(prefabs) do
                PREFAB_SKINS[reskin_prefab] = PREFAB_SKINS[name];
                PREFAB_SKINS_IDS[reskin_prefab] = PREFAB_SKINS_IDS[name];
            end
        end
    end
end

---新版本，目前的内容是：如果始终保持静态的话，那应该是可以换皮的！
---@param env env
function API.reskin2(env, prefabname, bank, build, prefabs)
    local name = prefabname;

    -- 补丁
    if prefabname == "cane" and #prefabs > 1 then
        return ;
    end

    local init_fn_name = name .. '_init_fn';
    local init_fn = rawget(_G, init_fn_name);
    if not init_fn then
        print('`' .. init_fn_name .. '` global function does not exist!');
        return ;
    end

    rawset(_G, init_fn_name, function(inst, build_name, def_build)
        if not containsValue(prefabs, inst.prefab) then
            return init_fn(inst, build_name, def_build);
        else
            if bank then
                inst.AnimState:SetBank(bank);
            end
            basic_init_fn(inst, build_name, build);

            -- 补丁
            if prefabname == "cane" then
                if inst.components.inventoryitem then
                    inst.components.inventoryitem:ChangeImageName("walkingstick");
                end
            end
        end
    end);

    local clear_fn_name = name .. '_clear_fn';
    local clear_fn = rawget(_G, clear_fn_name);
    if not clear_fn then
        print('`' .. clear_fn_name .. '` global function does not exist!');
        return ;
    end

    rawset(_G, clear_fn_name, function(inst, def_build)
        if not containsValue(prefabs, inst.prefab) then
            return clear_fn(inst, def_build);
        else
            if bank then
                inst.AnimState:SetBank(bank);
            end
            basic_clear_fn(inst, build);

            -- 补丁
            if prefabname == "cane" then
                if inst.components.inventoryitem then
                    inst.components.inventoryitem:ChangeImageName("walkingstick");
                end
            end
        end
    end);

    -- 补丁
    if prefabname == "cane" then
        for _, v in ipairs(prefabs) do
            env.AddPrefabPostInit(v, function(inst)
                if not TheWorld.ismastersim then
                    return inst;
                end
                if inst.components.equippable then
                    local old_onequipfn = inst.components.equippable.onequipfn;
                    inst.components.equippable.onequipfn = function(inst, owner, ...)
                        if old_onequipfn then
                            old_onequipfn(inst, owner, ...);
                        end

                        -- 这样是换不了的！至于原因？未知。2023-02-08-16:00
                        -- 如果我用的官方的 inventoryitem.image 和 atlas，换皮的时候是完全正常的。
                        -- 可以去看看 event:imagechange，以及 itemtile 小部件
                        --local skin_name = inst:GetSkinName();
                        --if skin_name then
                        --    if inst.components.inventoryitem then
                        --        inst.components.inventoryitem:ChangeImageName(skin_name);
                        --    end
                        --end

                        local skin_build = inst:GetSkinBuild();
                        if skin_build then
                            owner:PushEvent("equipskinneditem", skin_build);
                            owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_cane", inst.GUID, "swap_cane");
                        end
                    end

                    local old_onunequipfn = inst.components.equippable.onunequipfn;
                    inst.components.equippable.onunequipfn = function(inst, owner, ...)
                        if old_onunequipfn then
                            old_onunequipfn(inst, owner, ...);
                        end

                        local skin_build = inst:GetSkinBuild()
                        if skin_build then
                            owner:PushEvent("unequipskinneditem", inst:GetSkinName())
                        end
                    end
                end
            end)
        end
    end

    -- 修改全局表，应该可以让制作物品页面可以选皮肤
    if ((rawget(_G, 'PREFAB_SKINS') or {})[name] and (rawget(_G, 'PREFAB_SKINS_IDS') or {})[name]) then
        for _, reskin_prefab in ipairs(prefabs) do
            PREFAB_SKINS[reskin_prefab] = PREFAB_SKINS[name];
            PREFAB_SKINS_IDS[reskin_prefab] = PREFAB_SKINS_IDS[name];
        end
    end

end

---- TEST: 2023-02-08-15:57
--API.reskin2 = nil;

---添加自定义的动作
function API.addCustomActions(env, custom_actions, component_actions)
    --[[
    execute = nil|false|其他 true,,
    id = '', -- 动作 id，需要全大写字母
    str = '', -- 游戏内显示的动作名称

    ---动作触发时执行的函数，注意这是 server 端
    fn = function(act) ... return ture|false|nil; end, ---@param act BufferedAction,

    actiondata = {}, -- 需要添加的一些动作相关参数，比如：优先级、施放距离等
    state = '', -- 要绑定的 SG 的 state
]]
    custom_actions = custom_actions or {};

    --[[    actiontype = '', -- 场景，'SCENE'|'USEITEM'|'POINT'|'EQUIPPED'|'INVENTORY'|'ISVALID'
        component = '', -- 指的是 inst 的 component，不同场景下的 inst 指代的目标不同，注意一下
        tests = {
            -- 允许绑定多个动作，如果满足条件都会插入动作序列中，具体会执行哪一个动作则由动作优先级来判定。
            {
                execute = nil|false|其他 true,
                id = '', -- 动作 id，同上

                ---注意这是 client 端
                testfn = function() ... return ture|false|nil; end; -- 参数根据 actiontype 而不同！
            },
        }]]

    component_actions = component_actions or {};

    for _, data in pairs(custom_actions) do
        if (data.execute ~= false and data.id and data.str and data.fn and data.state) then
            data.id = string.upper(data.id);

            -- 添加自定义动作
            env.AddAction(data.id, data.str, data.fn);

            if (type(data.actiondata) == 'table') then
                for k, v in pairs(data.actiondata) do
                    ACTIONS[data.id][k] = v;
                end
            end

            -- 添加动作驱动行为图
            env.AddStategraphActionHandler("wilson", ActionHandler(ACTIONS[data.id], data.state));
            env.AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS[data.id], data.state));
        end
    end

    for _, data in pairs(component_actions) do
        if (data.actiontype and data.component and data.tests) then
            -- 添加动作触发器（动作和组件绑定）
            env.AddComponentAction(data.actiontype, data.component, function(...)
                data.tests = data.tests or {};
                for _, v in pairs(data.tests) do
                    if (v.execute ~= false and v.id and v.testfn and v.testfn(...)) then
                        table.insert((select(-2, ...)), ACTIONS[v.id]);
                    end
                end
            end)
        end
    end
end

function API.modifyOldActions(env, old_actions)
    old_actions = old_actions or {};

    for _, data in pairs(old_actions) do
        if (data.execute ~= false and data.id) then
            local action = ACTIONS[data.id];

            if (type(data.actiondata) == 'table') then
                for k, v in pairs(data.actiondata) do
                    action[k] = v;
                end
            end

            if (type(data.state) == 'table' and action) then
                local testfn = function(sg)
                    local old_handler = sg.actionhandlers[action].deststate;
                    sg.actionhandlers[action].deststate = function(doer, action)
                        if data.state.testfn and data.state.testfn(doer, action) and data.state.deststate then
                            return data.state.deststate(doer, action);
                        end
                        return old_handler(doer, action);
                    end
                end

                if data.state.client_testfn then
                    testfn = data.state.client_testfn;
                end

                env.AddStategraphPostInit("wilson", testfn);
                env.AddStategraphPostInit("wilson_client", testfn);
            end
        end
    end
end

return API;