-- 取消任务的工具函数
local function CancelTask(task)
    if task ~= nil then
        task:Cancel()
        task = nil
    end
end

-- 姐妹骨灰罐改动
AddPrefabPostInit("sisturn", function(inst)
    local function SpawnGhostFlower()
        if TheNet:GetIsServer() then
            local x, y, z = inst.Transform:GetWorldPosition()

            local dist = math.random() + 1
            local angle = math.random() * TWOPI

            local flower = SpawnPrefab("ghostflower")

            flower.Transform:SetPosition(x + dist * math.cos(angle), 0, z + dist * math.sin(angle))
        end
    end

    local function LocalIsFullOfFlowers(inst)
        return inst.components.container ~= nil and inst.components.container:IsFull()
    end

    local function IsFullOfMoonFlowers(inst)
        local container =  inst.components.container
        for i = 1, container.numslots do
            local item = container.slots[i]
            if item ~= nil then
                if item.prefab ~= "moon_tree_blossom" then
                    return false
                end
            end
        end
        return true
    end

    local function IsFullOfShadowFlowers(inst)
        local container =  inst.components.container
        for i = 1, container.numslots do
            local item = container.slots[i]
            if item ~= nil then
                if item.prefab ~= "petals_evil" then
                    return false
                end
            end
        end
        return true
    end

    --skilltree
    inst._engineerid = nil
    inst._lighted = net_bool(inst.GUID, "sisturn_hook._lighted", "sistturn_skillsdirty")
    inst._preserver1 = net_bool(inst.GUID, "sisturn_hook._preserver1", "sistturn_skillsdirty")
    inst._preserver2 = net_bool(inst.GUID, "sisturn_hook._preserver2", "sistturn_skillsdirty")
    inst._moon = net_bool(inst.GUID, "sisturn_hook._moon", "sistturn_skillsdirty")
    inst._shadow = net_bool(inst.GUID, "sisturn_hook._shadow", "sistturn_skillsdirty")
    inst.can_drop = false
    inst.entity:AddLight()

    inst.Light:Enable(false)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetRadius(3)
    inst.Light:SetFalloff(1)
    inst.Light:SetColour(200/255, 200/255, 200/255)

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(1)

    --应用加成
    local function ApplySkillBonuses(inst)
        -- 光照
        if inst._lighted:value() then
            if  LocalIsFullOfFlowers(inst) then
                inst.Light:Enable(true)
            end
        else
            inst.Light:Enable(false)
        end

        -- 二级保鲜
        if inst._preserver2:value() then
            CancelTask(inst.ghostflower_task_1)
            inst.components.preserver:SetPerishRateMultiplier(TUNING.SISTURN_PRESERVER_MULT_2)
            inst.ghostflower_task_2 = inst:DoPeriodicTask(
                    TUNING.SISTURN_GHOSTFLOWER_PRODUCE_TIME_2,
                    SpawnGhostFlower
            )

            -- 一级保鲜
        elseif inst._preserver1:value() then
            CancelTask(inst.ghostflower_task_2)
            inst.components.preserver:SetPerishRateMultiplier(TUNING.SISTURN_PRESERVER_MULT_1)
            inst.ghostflower_task_1 = inst:DoPeriodicTask(
                    TUNING.SISTURN_GHOSTFLOWER_PRODUCE_TIME_1,
                    SpawnGhostFlower
            )

        else
            inst.components.preserver:SetPerishRateMultiplier(1)
            CancelTask(inst.ghostflower_task_1)
            CancelTask(inst.ghostflower_task_2)
        end

        if inst._moon:value() then
            inst:AddTag("moon_sisturn")
        else
            inst:RemoveTag("moon_sisturn")
        end

        if inst._shadow:value() then
            inst:AddTag("shadow_sisturn")
        else
            inst:RemoveTag("shadow_sisturn")
        end

        inst.can_drop = true
    end

    -- 确认是否有修改
    local function ConfigureSkillTreeUpgrades(inst, builder)
        local skilltreeupdater = builder and builder.components.skilltreeupdater or nil

        local lighted = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_sisturn_light")
        local preserver1 = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_sisturn_ghostflower_1")
        local preserver2 = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_sisturn_ghostflower_2")
        local moon = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_moon_sisturn")
        local shadow = skilltreeupdater ~= nil and skilltreeupdater:IsActivated("wendy_shadow_sisturn")

        local dirty = inst._lighted:value() ~= lighted or
                inst._preserver1:value() ~= preserver1 or
                inst._preserver2:value() ~= preserver2 or
                inst._moon:value() ~= moon or
                inst._shadow:value() ~= shadow

        inst._lighted:set(lighted)
        inst._preserver1:set(preserver1)
        inst._preserver2:set(preserver2)
        inst._moon:set(moon)
        inst._shadow:set(shadow)
        inst._engineerid = builder and builder:HasTag("elixirbrewer") and builder.userid or nil

        return dirty
    end

    -- 保存
    local function NewOnSave(self, data)
        if self:HasTag("burnt") or (self.components.burnable ~= nil and self.components.burnable:IsBurning()) then
            data.burnt = true
        else
            data.engineerid = inst._engineerid
        end
        inst.can_drop = false
        if inst:HasTag("moon_sisturn") then
            data._moon = true
        end
        if inst:HasTag("shadow_sisturn") then
            data._shadow = true
        end
    end

    -- 加载
    local function NewOnLoad(self, data)
        if data ~= nil then
            if data.burnt and self.components.burnable ~= nil then
                self.components.burnable.onburnt(self)
            elseif data.engineerid ~= nil then
                inst._engineerid = data.engineerid
            end
        end
        inst.can_drop = false
    end

    local function OnPreLoad(self, data)
        if data ~= nil then
            if data._moon ~= nil and data._moon == true then
                inst:AddTag("moon_sisturn")
            end
            if data._shadow ~= nil and data._shadow == true then
                inst:AddTag("shadow_sisturn")
            end
        end
    end

    -- 建造
    local function newonbuilt(inst, data)
        inst.AnimState:PlayAnimation("place")
        inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/sisturn/place")
        inst.AnimState:PushAnimation("idle", false)
        inst.SoundEmitter:PlaySound("dontstarve/characters/wendy/sisturn/hit")

        ConfigureSkillTreeUpgrades(inst, data.builder)
        ApplySkillBonuses(inst)
    end

    inst.OnPreLoad = OnPreLoad
    inst.OnSave = NewOnSave
    inst.OnLoad = NewOnLoad

    inst:DoPeriodicTask(0, function()
        if TheNet:GetIsServer() then
            if inst.can_drop then
                if inst.components.container ~= nil then
                    local self =  inst.components.container
                    for i = 1, self.numslots do
                        local item = self.slots[i]
                        if item ~= nil then
                            if not inst:HasTag("moon_sisturn") then
                                if item.prefab == "moon_tree_blossom" then
                                    self:DropItemBySlot(i)
                                end
                            end

                            if not inst:HasTag("shadow_sisturn") then
                                if item.prefab == "petals_evil" then
                                    self:DropItemBySlot(i)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    inst:ListenForEvent("onbuilt", newonbuilt)

    inst:ListenForEvent("itemget", function(self, data)
        if LocalIsFullOfFlowers(self) then

            if self._lighted:value() then
                inst.Light:Enable(true)
            end

            if self._preserver2:value() and self.ghostflower_task_2 == nil then
                CancelTask(inst.ghostflower_task_1)
                inst.ghostflower_task_2 = inst:DoPeriodicTask(
                        TUNING.SISTURN_GHOSTFLOWER_PRODUCE_TIME_2,
                        SpawnGhostFlower
                )

            elseif self._preserver1:value() and self.ghostflower_task_1 == nil then
                CancelTask(inst.ghostflower_task_2)
                inst.ghostflower_task_1 = inst:DoPeriodicTask(
                        TUNING.SISTURN_GHOSTFLOWER_PRODUCE_TIME_1,
                        SpawnGhostFlower
                )
            end


            TheWorld:PushEvent("abigail_can_get_sisturn_buff", {
                engineerid = inst._engineerid,
                moon = IsFullOfMoonFlowers(inst),
                shadow = IsFullOfShadowFlowers(inst)
            })
        end
    end)

    inst:ListenForEvent("itemlose", function(self, data)
        inst.Light:Enable(false)
        CancelTask(inst.ghostflower_task_1)
        CancelTask(inst.ghostflower_task_2)
        TheWorld:PushEvent("abigail_check_please", { engineerid = inst._engineerid })
    end)

    inst:ListenForEvent("wendy_sisturnskillchanged", function(world, user)
        if user.userid == inst._engineerid and not inst:HasTag("burnt") then
            if ConfigureSkillTreeUpgrades(inst, user) then
                ApplySkillBonuses(inst)
            end
        end
    end, TheWorld)

    inst:ListenForEvent("abigail_check_sisturn_state", function()
        if LocalIsFullOfFlowers(inst) then
            TheWorld:PushEvent("abigail_can_get_sisturn_buff", {
                engineerid = inst._engineerid,
                moon = IsFullOfMoonFlowers(inst),
                shadow = IsFullOfShadowFlowers(inst)
            })
        else
            TheWorld:PushEvent("abigail_cant_get_sisturn_buff", {
                engineerid = inst._engineerid
            })
        end
    end, TheWorld)

    if not TheWorld.ismastersim then
        inst:ListenForEvent("sistturn_skillsdirty", ApplySkillBonuses)
        return inst
    end
end)