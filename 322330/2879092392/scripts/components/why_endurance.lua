local function OnEquipArmor(inst, data)
    if data and data.item and (data.eslot == EQUIPSLOTS.BODY or data.eslot == EQUIPSLOTS.HEAD) then
        print("item.endurance_bonus when equip = " .. (data.item.endurance_bonus or 0))
        inst.components.why_endurance.extra_endurance = math.min((inst.components.why_endurance.extra_endurance or 0) + (data.item.endurance_bonus or 0), 6)
        inst.components.why_endurance.current_extra_endurance = math.min((inst.components.why_endurance.current_extra_endurance or 0) + (data.item.current_endurance_bonus or 0), 6)
        inst._net_endurance_bonus:set(inst.components.why_endurance.extra_endurance or 0)
        inst._net_current_endurance_bonus:set(inst.components.why_endurance.current_extra_endurance or 0)
        --inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 6
    end
end

local function OnUnequipArmor(inst, data)
    if data and data.item and (data.eslot == EQUIPSLOTS.BODY or data.eslot == EQUIPSLOTS.HEAD) then
        inst.components.why_endurance.extra_endurance = math.max((inst.components.why_endurance.extra_endurance or 0) - (data.item.endurance_bonus or 0), 0)
        inst.components.why_endurance.current_extra_endurance = math.max((inst.components.why_endurance.current_extra_endurance or 0) - (data.item.current_endurance_bonus or 0), 0)
        if not data.item.stored_endurance then
            data.item.current_endurance_bonus = 0
        end
        inst._net_endurance_bonus:set(inst.components.why_endurance.extra_endurance or 0)
        inst._net_current_endurance_bonus:set(inst.components.why_endurance.current_extra_endurance or 0)
        --inst.components.why_endurance.headgear_equippable = inst:HasTag("wonder_have_ribs") or inst.components.health.currenthealth >= 6
    end
end

local function onheadgear_equippable(self, equippable)
    local item = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    if not equippable and item then
        self.inst.components.inventory:DropItem(item, true, true)
        if not item:HasTag("whyehat") then
            self.inst.components.inventory:GiveItem(item)
        end
        if self.inst.components.talker then
            if TUNING.WHY_LANGUAGE == "spanish" then
                self.inst.components.talker:Say("No puedo usar sombreros sin cabeza ni costillas.")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                self.inst.components.talker:Say("没有头或肋骨，我戴不住帽子.")
            else
                self.inst.components.talker:Say("I can't wear hats with no head and ribs.")
            end
        end
        if self.inst.components.sanity then
            self.inst.components.sanity:DoDelta(-10)
        end
        self.inst.components.grogginess:AddGrogginess(1, 9)
    end
    if self.inst.replica.why_endurance then
        self.inst.replica.why_endurance._headgear_equippable:set(equippable)
    end
end

local EnduranceBody = Class(function(self, inst)
    self.inst = inst
    self.headgear_equippable = true
    self.inst:ListenForEvent("equip", OnEquipArmor)
    self.inst:ListenForEvent("unequip", OnUnequipArmor)
end, nil, {
    headgear_equippable = onheadgear_equippable,
})


local continuousDamageTable = {}
-- For other modders: Add your mod's continuousDamage use this function
-- hurtBody = true will directly hurt base endurance rather than hurt extra endurance
-- set it as true when you don't want to count armor
function EnduranceBody:AddCtnDmg(cause, immuneTime, hurtBody)
    local continuousDamage = {cause = cause, immuneTime = immuneTime or 20, hurtBody = hurtBody}
    table.insert(continuousDamageTable, continuousDamage)
end

function EnduranceBody:CalculateEnduranceHealing(amount, calculate_mode)
    local endurance_delta = 0
    if TUNING.WHY_ENDURANCE_HEAL == "1" then
        if calculate_mode then
            if calculate_mode == 0 then
                -- without red eye
                endurance_delta = math.max(math.floor(amount / 20) - 1, 0) -- don't do dmg when amount less than 20
            elseif calculate_mode == 1 then
                -- red eye in ancient mask
                endurance_delta = math.floor(amount / 20)
            else
                -- red eye in moonrock mask
                endurance_delta = math.max(math.floor(amount / 10) - 1, 0) -- don't do dmg when amount less than 10
            end
        end
    elseif TUNING.WHY_ENDURANCE_HEAL == "0" then
        if calculate_mode then
            if calculate_mode == 0 then
                -- without red eye
                endurance_delta = math.max(amount / 20 - 1, 0) -- don't do dmg when amount less than 20
            elseif calculate_mode == 1 then
                -- red eye in ancient mask
                endurance_delta = amount / 20
            else
                -- red eye in moonrock mask
                endurance_delta = math.max(amount / 10 - 1, 0) -- don't do dmg when amount less than 10
            end
        end
    end
    return endurance_delta
end

--function EnduranceBody:AddValidHealingCause(cause_name)
--    self.valid_healing_causes[cause_name] = true
--end

function EnduranceBody:EquipmentEnduranceChangeByOtherWay(amount, equipment, cause)
    -- for now the only way is give gemshard to equipment
    self.current_extra_endurance = math.min((self.current_extra_endurance or 0) + amount, self.extra_endurance)
    self.inst._net_endurance_bonus:set(self.extra_endurance or 0)
    self.inst._net_current_endurance_bonus:set(self.current_extra_endurance or 0)
end

function EnduranceBody:ChangeEquipmentEndurance(endurance_delta)
    local bodyitem = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    local headitem = self.inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local endurance_delta_left = endurance_delta -- preserve for if no headitem
    if endurance_delta > 0 then
        -- on heal
        -- head item heals first
        if headitem and headitem.endurance_bonus and headitem.current_endurance_bonus then
            endurance_delta_left = math.max(endurance_delta + headitem.current_endurance_bonus - headitem.endurance_bonus, 0)
            headitem.current_endurance_bonus = math.min(endurance_delta + headitem.current_endurance_bonus, headitem.endurance_bonus)
        end

        -- then body item heals
        if endurance_delta_left > 0 then
            if bodyitem and bodyitem.endurance_bonus then
                -- no need for endurance_delta_left, because Wonder themselves heal before enter this function
                bodyitem.current_endurance_bonus = math.min(endurance_delta_left + (bodyitem.current_endurance_bonus or 0), bodyitem.endurance_bonus)
            end
        end
        self.current_extra_endurance = math.min((self.current_extra_endurance or 0) + endurance_delta, (self.extra_endurance or 0))
    else
        -- on damage
        -- head item damages first
        if headitem and headitem.endurance_bonus and headitem.current_endurance_bonus then
            endurance_delta_left = math.min(headitem.current_endurance_bonus + endurance_delta, 0)
            headitem.current_endurance_bonus = math.max(headitem.current_endurance_bonus + endurance_delta, 0)
        end

        -- then body item damages
        if endurance_delta_left < 0 then
            if bodyitem and bodyitem.endurance_bonus and bodyitem.current_endurance_bonus then
                -- no need for endurance_delta_left, because Wonder themselves damage after this function ends
                bodyitem.current_endurance_bonus = math.max(bodyitem.current_endurance_bonus + endurance_delta_left, 0)
            end
        end
        self.current_extra_endurance = math.max((self.current_extra_endurance or 0) + endurance_delta, 0)
    end

    self.inst._net_endurance_bonus:set(self.extra_endurance or 0)
    self.inst._net_current_endurance_bonus:set(self.current_extra_endurance or 0)
end

local currentCtnDmgTbl = {}

function EnduranceBody:RemoveCurrentCtnDmgCause(cause)
    print("removing "..(cause or "nil"))
    for k,v in pairs(currentCtnDmgTbl) do
        if v == cause then
            table.remove(currentCtnDmgTbl, k)
            break
        end
    end
    print("currentCtnDmgTbl = ")
    printTable(currentCtnDmgTbl)
end

function EnduranceBody:OnTakeDamage(amount, overtime, cause, ignore_invincible, afflicter, ignore_absorb, calculate_mode)
    print("get in OnTakeDamage")
    print("amount = " .. amount)
    if cause then
        print("cause = " .. cause)
    end
    -------------------------Valid Healing-------------------------------------------------------
    --------------------------
    if not cause then
        local oldpercent = self.inst.components.health:GetPercent()
        local endurance_delta = math.floor((amount or 0) / 20)
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        return true
    end
    -- on eating

    -- on eat jellybean
    if cause == "jellybean" then
        if TUNING.WHY_ENDURANCE_HEAL == "1" then
            return true -- return
        elseif TUNING.WHY_ENDURANCE_HEAL == "0" then
            local endurance_delta = amount / 20
            local remain_endurance_heal = endurance_delta - (self.inst.components.health.maxhealth - self.inst.components.health.currenthealth)
            local oldpercent = self.inst.components.health:GetPercent()
            if endurance_delta > 0 then
                if remain_endurance_heal <= 0 then
                    print("currenthealth = " .. (self.inst.components.health.currenthealth + endurance_delta))
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
                else
                    self.inst.components.health.currenthealth = self.inst.components.health.maxhealth
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth, cause, afflicter)
                    if self.extra_endurance then
                        self.ChangeEquipmentEndurance(self, remain_endurance_heal)
                    end
                end
            end
            self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                 overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
            return true
        end
    end

    local isfood = false
    if cause ~= "deerclops" then
        local foodPrefab = SpawnPrefab(cause) or nil
        if (foodPrefab and foodPrefab.components and foodPrefab.components.edible and foodPrefab.components.edible.foodtype ~= FOODTYPE.ELEMENTAL)
                or cause == "ancientdreams_gemshard" then
            isfood = true
        end
        if foodPrefab then
            foodPrefab:Remove()
        end
    end

    if isfood then
        if cause == "ancientdreams_gemshard" then
            local current_endurance = self.inst.components.health.currenthealth
            if current_endurance == self.inst.components.health.maxhealth then
                self.inst.components.why_endurance:ChangeEquipmentEndurance(1)
            else
                local oldpercent = self.inst.components.health:GetPercent()
                self.inst.components.health:SetVal(self.inst.components.health.currenthealth + 1, "gemshard")
                --self.inst.components.health:SetVal(6, "gemshard")
                self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                     overtime = nil, cause = "gemshard", afflicter = nil, amount = 1 })
            end
            return true
        end

        if amount < 0 then
            -- immune to dmg foods such as monster meat or red cap
            return true
        else
            local endurance_delta = self.CalculateEnduranceHealing(self, amount, calculate_mode)
            print("endurance_delta = " .. endurance_delta)
            local remain_endurance_heal = endurance_delta - (self.inst.components.health.maxhealth - self.inst.components.health.currenthealth)
            local oldpercent = self.inst.components.health:GetPercent()
            if endurance_delta > 0 then
                if remain_endurance_heal <= 0 then
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
                else
                    self.inst.components.health.currenthealth = self.inst.components.health.maxhealth
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth, cause, afflicter)
                    self.ChangeEquipmentEndurance(self, remain_endurance_heal)
                end
            end
            self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                 overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
            return true
        end
    end

    -- on red amulet heal
    if cause == "redamulet" then
        local endurance_delta = 1
        if self.inst.components.health.currenthealth ~= self.inst.components.health.maxhealth then
            local oldpercent = self.inst.components.health:GetPercent()
            self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
            self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                 overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        else
            self.ChangeEquipmentEndurance(self, endurance_delta)
        end
        return true
    end

    -- on wortox soul
    if cause == "wortox_soul_spawn" or cause == "wortox_soul" then
        local endurance_delta = 1
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        return true
    end

    -------------------------Valid Healing------------------------------------------------------------------------------
    if amount > 0 then
        -- if not valid healing
        if TUNING.WHY_ENDURANCE_HEAL == "1" then
            return true -- return
        elseif TUNING.WHY_ENDURANCE_HEAL == "0" then
            local endurance_delta = amount / 20
            local remain_endurance_heal = endurance_delta - (self.inst.components.health.maxhealth - self.inst.components.health.currenthealth)
            local oldpercent = self.inst.components.health:GetPercent()
            if endurance_delta > 0 then
                if remain_endurance_heal <= 0 then
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
                else
                    self.inst.components.health.currenthealth = self.inst.components.health.maxhealth
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth, cause, afflicter)
                    self.ChangeEquipmentEndurance(self, remain_endurance_heal)
                end
            end
            self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
            self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                 overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
            return true
        end
    end

    -------------------------Damage Process-----------------------------------------------------------------------------

    local endurance_delta = -1

    -- immune to acid rain since Wonder is crystal made
    if cause == "acidrain" then
        return true
    end

    -- on build
    if cause == "builder" then
        endurance_delta = math.floor(amount / 20) -- -40 health == -2 endurance, -50 health == -3 endurance, -60 health == -3 endurance
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter)
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })

        return true
    end

    -- on hunger
    if cause == "hunger" then
        if self.inst.components.hunger ~= nil then
            self.inst.components.hunger:DoDelta(9.6)
        end
        if self.inst.sg and not self.inst.components.health:IsDead() then
            self.inst.sg:GoToState "hit"
        end
        if self.inst.components.talker then
            if TUNING.WHY_LANGUAGE == "spanish" then
                self.inst.components.talker:Say("¿Me acabo de morder el dedo?")
            elseif TUNING.WHY_LANGUAGE == "chinese" then
                self.inst.components.talker:Say("我刚刚是不是把自己的手指咬掉了?")
            else
                self.inst.components.talker:Say("Did I just bite off my finger?")
            end
        end
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter) -- only damage Wonder themselves, don't count endurance from armor
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        return true
    end

    -- on cold and hot
    if cause == "hot" or cause == "cold" then
        if self.inst.components.temperature ~= nil then
            self.inst.components.temperature.inherentinsulation = 240
            self.inst.components.temperature.mintemp = math.max(1, self.inst.components.temperature.mintemp)
            self.inst.components.temperature.maxtemp = math.min(69, self.inst.components.temperature.maxtemp)
            self.inst:DoTaskInTime(20, function(inst)
                -- immune time is little more than then time normal character loses 20 health, but more dangerous fighting Klaus.
                if inst.components.temperature ~= nil then
                    if not inst:HasTag("hasblueeye") and not inst:HasTag("hasperfectioneye") then
                        inst.components.temperature.inherentinsulation = 0
                        inst.components.temperature.mintemp = (-20)
                    end
                    if not inst:HasTag("hasperfectioneye") then
                        inst.components.temperature.maxtemp = (90)
                    end
                end
            end)
        end
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter) -- only damage Wonder themselves, don't count endurance from armor
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        return true
    end

    -- on fire
    if cause == "fire" then
        if self.inst.components.health then
            self.inst.components.health.externalfiredamagemultipliers:SetModifier(self.inst, 1 - TUNING.ARMORDRAGONFLY_FIRE_RESIST)
            self.inst:DoTaskInTime(20, function(inst)
                if inst.components.health ~= nil then
                    inst.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
                end
            end)
        end
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter) -- only damage Wonder themselves, don't count endurance from armor
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
        return true
    end

    if amount <= -30 then
        -- huge attack make more lose of endurance, it counts % of damage reduction.
        -- And damage of 50 origin is 20 amount with 60% damage reduction(grass suit). With any better armor it is less than 20.
        endurance_delta = -2
    end
    print(endurance_delta)

    -- on other continuous damage
    for k,v in pairs(continuousDamageTable) do
        if v.cause == cause then
            print("ctnDamage is "..cause)
            local alreadyHas  = false
            for k1,v1 in pairs(currentCtnDmgTbl) do
                -- if already in currentCtnDmgTbl then don't do damage
                if v1 == cause then
                    alreadyHas = true
                    return true
                end
            end
            --else add the cause into the table
            if not alreadyHas then
                table.insert(currentCtnDmgTbl, cause)
                -- and remove it after immuneTime
                self.inst:DoTaskInTime(v.immuneTime, function(inst)
                    inst.components.why_endurance:RemoveCurrentCtnDmgCause(cause)
                end)
                if v.hurtBody then
                    local oldpercent = self.inst.components.health:GetPercent()
                    self.inst.components.health:SetVal(self.inst.components.health.currenthealth + endurance_delta, cause, afflicter) -- only damage Wonder themselves, don't count endurance from armor
                    self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                         overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
                else
                    local remain_extra_endurance = (self.current_extra_endurance or 0) + endurance_delta
                    if remain_extra_endurance >= 0 then
                        self.ChangeEquipmentEndurance(self, endurance_delta)
                    else
                        self.ChangeEquipmentEndurance(self, -(self.current_extra_endurance or 0))
                        local oldpercent = self.inst.components.health:GetPercent()
                        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + remain_extra_endurance, cause, afflicter)
                        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
                    end
                    return true
                end
            end
        end
    end

    -- on combat
    local remain_extra_endurance = (self.current_extra_endurance or 0) + endurance_delta
    if remain_extra_endurance >= 0 then
        self.ChangeEquipmentEndurance(self, endurance_delta)
    else
        self.ChangeEquipmentEndurance(self, -(self.current_extra_endurance or 0))
        local oldpercent = self.inst.components.health:GetPercent()
        self.inst.components.health:SetVal(self.inst.components.health.currenthealth + remain_extra_endurance, cause, afflicter)
        self.inst:PushEvent("healthdelta", { oldpercent = oldpercent, newpercent = self.inst.components.health:GetPercent(),
                                             overtime = overtime, cause = cause, afflicter = afflicter, amount = amount })
    end
    return true

    -------------------------Damage Process-----------------------------------------------------------------------------
end

return EnduranceBody