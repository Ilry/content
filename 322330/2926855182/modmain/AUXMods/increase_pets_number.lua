---
--- @author zsh in 2023/2/26 2:35
---

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

local MAX_NUMBER = TUNING.PETS_ENHANCEMENT.MOD_CONFIG_DATA.control_pets_number;

env.AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return inst;
    end

    if inst.components.petleash then
        -- 兼容麦斯威尔
        if inst.components.petleash.maxpets == 1 then
            inst.components.petleash:SetMaxPets(MAX_NUMBER);
        end
    end
end)

local MODULUS = 1; -- 限制玩家不能制作两个一样的宠物
if MODULUS and MODULUS == 1 then
    STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.BUILD.PETS_ENHANCEMENT_FAIL = "我不能领养一模一样的宠物！";

    local function hasExactSamePet(self, prefabname)
        local petleash = self.inst.components.petleash;
        if petleash then
            for k, v in pairs(petleash.pets) do
                if v and v.prefab == prefabname then
                    return true;
                end
            end
        end
    end

    -- 修改 Builder 里面的 DoBuild 函数
    env.AddPlayerPostInit(function(inst)
        if not TheWorld.ismastersim then
            return inst;
        end
        if inst.components.builder then
            local old_DoBuild = inst.components.builder.DoBuild;
            -- NOTE: 正常情况下科雷的函数更新只会在后面添加，所以我觉得我hook函数的时候如果使用 select 的方式，那将会不必非常担心兼容性问题。
            function inst.components.builder:DoBuild(recname, ...)
                if not recname:find("critter_") then
                    return old_DoBuild(self, recname, ...);
                end
                local start = string.find(recname, "_builder$");
                if start == nil then
                    return old_DoBuild(self, recname, ...);
                end
                if not (type(start) == "number") then
                    return old_DoBuild(self, recname, ...);
                end
                --? start 居然会报: attempt to perform arithmetic on local 'start' (a nil value) ?????(2023-04-14)
                ---- not (type(start) == "number") 和 not type(start) == "number" 是不一样的。。。阿哲，这为什么没报错过？
                ---- 因为有 if not recname:find("critter_") then end 的判定。。
                local old_recname = recname;
                local prefabname = string.sub(old_recname, 1, start - 1);
                if table.contains(require("definitions.pets.pets"), tostring(prefabname)) then
                    local recipe = GetValidRecipe(recname)
                    if recipe ~= nil and (self:IsBuildBuffered(recname) or self:HasIngredients(recipe)) then
                        if recipe.level.ORPHANAGE > 0 and (
                                self.inst.components.petleash == nil or
                                        self.inst.components.petleash:IsFull() or
                                        self.inst.components.petleash:HasPetWithTag("critter")
                        ) then
                            if hasExactSamePet(self, prefabname) then
                                return false, "PETS_ENHANCEMENT_FAIL";
                            end
                        end
                    end
                end
                return old_DoBuild(self, recname, ...);
            end
        end
    end)
end

env.AddComponentPostInit("petleash", function(self)
    local old_HasPetWithTag = self.HasPetWithTag;
    function self:HasPetWithTag(tag)
        if tag ~= "critter" then
            return old_HasPetWithTag(self, tag);
        end
        local cnt = 0;
        -- 注意，第一次制作的时候，pets里面没有这个宠物...
        for k, v in pairs(self.pets) do
            if v:HasTag(tag) then
                cnt = cnt + 1;
            end
        end
        if cnt >= MAX_NUMBER then
            --self.inst:DoTaskInTime(3,function(inst)
            --    inst.components.talker:Say("我只能控制三只野兽！"); -- 为什么没有执行？
            --end)
            return true;
        end
        return false
    end
end)