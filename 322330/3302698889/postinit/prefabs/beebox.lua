local animparams = { frame = 3, scale = .05, curframe = 0, }

--- Play a programmed joggle animation
---@param inst table prefab
local function playJoggleAnim(inst)
    if not inst:HasTag("burnt") then
        local function stopJoggle(inst)
            if inst._joggleTask then
                inst._joggleTask:Cancel()
                inst._joggleTask = nil
                animparams.curframe = 0
                inst.AnimState:SetScale(1, 1)
            end
        end
        stopJoggle(inst)
        inst._joggleTask = inst:DoPeriodicTask(0, function(inst)
            inst.AnimState:SetScale(1 - animparams.scale * math.sin(PI / animparams.frame * animparams.curframe),
                1 + animparams.scale * math.sin(PI / animparams.frame * animparams.curframe))
            animparams.curframe = animparams.curframe + 1
            if animparams.curframe > animparams.frame then
                stopJoggle(inst)
            end
        end)
    end
end

--- Is wormwood_bugs or equipped beekeeper hat
---@param inst table prefab
local function shouldProtect(inst)
    if inst then
        if inst.components.skilltreeupdater ~= nil and inst.components.skilltreeupdater:IsActivated("wormwood_bugs") then
            return true
        else
            local inv = inst.components.inventory
            if inv and inv.equipslots then
                local hat = inv.equipslots[EQUIPSLOTS.HEAD]
                if hat and hat.prefab == "beehat" then
                    print("ISKEEPER")
                    return true
                end
            end
        end
        return false
    end
    return true
end

--- Bee Box open function
---@param inst table component container
local function onopenfn(inst)
    playJoggleAnim(inst)
    if not inst:HasTag("burnt") then
        local openers = inst.components.container:GetOpeners()
        for _, opener in pairs(openers) do
            if inst.components.childspawner ~= nil and not TheWorld.state.iswinter and
                not shouldProtect(opener) then
                inst.components.childspawner:ReleaseAllChildren(opener)
                break
            end
        end
    end
end

--- Find an item from container by name
---@param container table component container
---@param itemname string prefab name
local function Find(container, itemname)
    return container:FindItem(function(item)
        return item.prefab == itemname
    end)
end

--- Find first item from container according to orderly name table itemnames
---@param container table component container
---@param itemnames table prefab names
local function FindFirst(container, itemnames)
    local item
    for _, v in ipairs(itemnames) do
        item = Find(container, v)
        if item then
            return item
        end
    end
end

--- Find items from container by table of name
---@param container table component container
---@param itemnames table prefab name
local function Finds(container, itemnames)
    return container:FindItems(function(item)
        for _, itemname in ipairs(itemnames) do
            if item.prefab == itemname then
                return true
            end
        end
        return false
    end)
end

--- Find items from container by table of name
---@param container table component container
---@param itemnames table prefab name
local function Counts(container, itemnames)
    local items = Finds(container, itemnames)
    local counts = 0
    for _, item in pairs(items) do
        counts = counts + (item.components.stackable and item.components.stackable:StackSize() or 1)
    end
    return counts
end

--- DoDelta to single item
---@param item table prefab
---@param count number
local function stackDelta(item, count)
    local stack = item.components.stackable
    if stack:StackSize() + count <= 0 then
        stack.inst:Remove()
    elseif count > stack:RoomLeft() then
        stack:SetStackSize(stack:StackSize() + stack:RoomLeft())
    else
        stack:SetStackSize(stack:StackSize() + count)
    end
end

--- DoDelta to items
---@param items table prefabs
---@param count number
local function stacksDelta(items, count)
    for _, item in ipairs(items) do
        if count == 0 then
            break
        end
        local stack = item.components.stackable
        if stack:StackSize() + count <= 0 then
            stack.inst:Remove()
            count = stack:StackSize() + count
        elseif count > stack:RoomLeft() then
            stack:SetStackSize(stack:StackSize() + stack:RoomLeft())
            count = count - stack:RoomLeft()
        else
            stack:SetStackSize(stack:StackSize() + count)
            break
        end
    end
end

--- stop preserve task and listen callback to item
---@param inst table prefab
---@param owner table component container
local function stopPreserve(inst, owner)
    if owner == nil or owner.prefab ~= "beebox" then
        inst.components.perishable:StartPerishing()
        inst:RemoveEventCallback("onputininventory", stopPreserve)
        inst:RemoveEventCallback("ondropped", stopPreserve)
    end
end

AddPrefabPostInit("beebox", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    if not inst.components.container then -- not compatable with other containable Bee Box MODs
        local container = inst:AddComponent("container")
        container:WidgetSetup("beebox")
        container.onopenfn = onopenfn
        container.onclosefn = playJoggleAnim
        local preserver = inst:AddComponent("preserver")
        inst.components.preserver:SetPerishRateMultiplier(TUNING.PERISH_BEEBOX_MULT)
        local old_onhit = inst.components.workable.onwork
        inst.components.workable:SetOnWorkCallback(function(i, ...)
            if not i:HasTag("burnt") then
                i.components.container:DropEverything()
                i.components.container:Close()
            end
            old_onhit(i, ...)
        end)

        inst:ListenForEvent("itemget", function() -- preserve task
            local sweets = container:FindItems(function(item)
                return item:HasTag("honeyed")
            end)
            for _, sweet in pairs(sweets) do
                if sweet.components.perishable then
                    sweet.components.perishable:StopPerishing()
                    sweet:ListenForEvent("onputininventory", stopPreserve)
                    sweet:ListenForEvent("ondropped", stopPreserve)
                end
            end
        end)

        inst._convertTicks_ak = { honey = 0, jelly = 0, } -- convert tasks pre
        inst._convertTask_ak = inst:DoPeriodicTask(TUNING.APIARY.CONVERT_INTERVAL, function()
            if inst:HasTag("burnt") then
                inst._convertTask_ak:Cancel()
            end

            local countbee = Counts(container, APIARY.WORKER)
            local honeys = Finds(container, { "honey" }) -- convert honey
            if #honeys > 0 and container:Has("royal_jelly", 1) then
                if countbee and countbee > 0 then
                    inst._convertTicks_ak.jelly = inst._convertTicks_ak.jelly + math.min(countbee, TUNING.APIARY.MAX_HONEY_CONVERSION_PERDAY * 4.5) * TUNING.APIARY.CONVERT_INTERVAL
                    countbee = countbee - math.min(countbee, TUNING.APIARY.MAX_HONEY_CONVERSION_PERDAY * 4.5)
                    if inst._convertTicks_ak.jelly >= TUNING.APIARY.HONEY_CONVERSION_COUNTER then
                        inst._convertTicks_ak.jelly = inst._convertTicks_ak.jelly - TUNING.APIARY.HONEY_CONVERSION_COUNTER
                        stacksDelta(honeys, -8)
                        inst.components.container:GiveItem(SpawnPrefab("royal_jelly"))
                    end
                end
            else
                inst._convertTicks_ak.jelly = 0
            end

            local petals = FindFirst(container, APIARY.PETALS) -- convert petals
            inst._convertTicks_ak.honey = petals and (inst._convertTicks_ak.honey + (countbee or 0) * TUNING.APIARY.CONVERT_INTERVAL) or 0
            if inst._convertTicks_ak.honey >= TUNING.APIARY.FETALS_CONVERSION_COUNTER then
                inst._convertTicks_ak.honey = inst._convertTicks_ak.honey - TUNING.APIARY.FETALS_CONVERSION_COUNTER
                stackDelta(petals, -1)
                inst.components.container:GiveItem(SpawnPrefab("honey"))
            end
        end)

        inst._feedTask_ak = inst:DoPeriodicTask(TUNING.APIARY.FEED_INTERVAL, function() -- feed task
            if inst:HasTag("burnt") then
                inst._feedTask_ak:Cancel()
            end
            local bees = Finds(container, APIARY.WORKER)
            for _, bee in pairs(bees) do
                if bee.components.perishable:GetPercent() <= .05 then
                    local feed = FindFirst(container, APIARY.FEED)
                    if feed then
                        stackDelta(feed, -1)
                        bee.components.perishable:SetPercent(1)
                    end
                end
            end
        end)

        if APIARY.SHOULDHARVEST then
            inst._harvestTask_ak = inst:DoPeriodicTask(TUNING.APIARY.HARVEST_INTERVAL, function()
                if inst:HasTag("burnt") then
                    inst._harvestTask_ak:Cancel()
                end
                local harvestable = inst.components.harvestable
                if harvestable and harvestable.produce == harvestable.maxproduce then
                    harvestable.produce = harvestable.produce - 1
                    inst.components.container:GiveItem(SpawnPrefab("honey"))
                end
            end)
        end

        if APIARY.HARVESTPROTECTION then
            local harvest = inst.components.harvestable
            if harvest then
                local old_harvestfn = harvest.onharvestfn
                if old_harvestfn then
                    local _, levels = debug.getupvalue(inst.components.harvestable.onharvestfn, 1)
                    local _, updatelevel = debug.getupvalue(inst.components.harvestable.onharvestfn, 2)
                    harvest.onharvestfn = function(inst, picker, produce)
                        if not inst:HasTag("burnt") then
                            if inst.components.harvestable then
                                inst.components.harvestable:SetGrowTime(nil)
                                inst.components.harvestable.pausetime = nil
                                inst.components.harvestable:StopGrowing()
                            end
                    		if produce == levels[1].amount then
                    			AwardPlayerAchievement("honey_harvester", picker)
                    		end
                            updatelevel(inst)
                            if inst.components.childspawner ~= nil and
                                not TheWorld.state.iswinter and
                                not shouldProtect(picker)
                            then
                                inst.components.childspawner:ReleaseAllChildren(picker)
                            end
                        end
                    end
                end
            end
        end

    end
end)
