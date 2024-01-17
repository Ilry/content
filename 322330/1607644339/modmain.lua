GLOBAL.setmetatable(
    env,
    {
        __index = function(t, k)
            return GLOBAL.rawget(GLOBAL, k)
        end
    }
)
local Morecooking = GetModConfigData("Morecooking")
local Morefeeding = GetModConfigData("Morefeeding")
if Morecooking == true then
    -------------------------------------------------------整组烹饪
    local Times = GetModConfigData("Times")
    local cooking = require("cooking")
    local containers = require "containers"
    local params = containers.params
    params.cookpot.acceptsstacks = true     --锅
    params.portablespicer.acceptsstacks = true     --调料站容器

    local Stewer = require "components/stewer"

    local function dospoil(inst, self)
        self.task = nil
        self.targettime = nil
        self.spoiltime = nil

        if self.onspoil ~= nil then
            self.onspoil(inst)
        end
    end

    local function dostew(inst, self)
        self.task = nil
        self.targettime = nil
        self.spoiltime = nil

        if self.ondonecooking ~= nil then
            self.ondonecooking(inst)
        end

        if self.product == self.spoiledproduct then
            if self.onspoil ~= nil then
                self.onspoil(inst)
            end
        elseif self.product ~= nil then
            local prep_perishtime = cooking.GetRecipe(inst.prefab, self.product).perishtime or 0
            if prep_perishtime > 0 then
                local prod_spoil = self.product_spoilage or 1
                self.spoiltime = prep_perishtime * prod_spoil
                self.targettime = GetTime() + self.spoiltime
                self.task = self.inst:DoTaskInTime(self.spoiltime, dospoil, self)
            end
        end

        self.done = true
    end

    function Stewer:StartCooking()
        if self.targettime == nil and self.inst.components.container ~= nil then
            self.done = nil
            self.spoiltime = nil

            if self.onstartcooking ~= nil then
                self.onstartcooking(self.inst)
            end

            local ings = {}

            local num = {}
            for k, v in pairs(self.inst.components.container.slots) do
                table.insert(ings, v.prefab)
                table.insert(num, v.components.stackable and v.components.stackable:StackSize() or 1)
            end
            self.stack = math.min(unpack(num)) or 1

            local cooktime = 1
            self.product, cooktime = cooking.CalculateRecipe(self.inst.prefab, ings)
            local productperishtime = cooking.GetRecipe(self.inst.prefab, self.product).perishtime or 0

            if productperishtime > 0 then
                local spoilage_total = 0
                local spoilage_n = 0
                for k, v in pairs(self.inst.components.container.slots) do
                    if v.components.perishable ~= nil then
                        spoilage_n = spoilage_n + 1
                        spoilage_total = spoilage_total + v.components.perishable:GetPercent()
                    end
                end
                self.product_spoilage = 1
                if spoilage_total > 0 then
                    self.product_spoilage = spoilage_total / spoilage_n
                    self.product_spoilage = 1 - (1 - self.product_spoilage) * .5
                end
            else
                self.product_spoilage = nil
            end

            cooktime = math.floor(TUNING.BASE_COOK_TIME * cooktime * Times * math.sqrt(self.stack) + 0.5)
            self.targettime = GetTime() + cooktime
            if self.task ~= nil then
                self.task:Cancel()
            end
            self.task = self.inst:DoTaskInTime(cooktime, dostew, self)

            self.inst.components.container:Close()
            for k, v in pairs(self.inst.components.container.slots) do
                if v.components.stackable ~= nil then
                    v.components.stackable:Get(self.stack or 1):Remove()
                else
                    v:Remove()
                end
            end
            self.inst.components.container.canbeopened = false
        end
    end

    function Stewer:OnSave()
        local remainingtime = self.targettime ~= nil and self.targettime - GetTime() or 0
        return {
            done = self.done,
            product = self.product,
            product_spoilage = self.product_spoilage,
            spoiltime = self.spoiltime,
            remainingtime = remainingtime > 0 and remainingtime or nil,
            stack = self.stack or nil
        }
    end

    function Stewer:OnLoad(data)
        if data.product ~= nil then
            self.done = data.done or nil
            self.product = data.product
            self.product_spoilage = data.product_spoilage
            self.spoiltime = data.spoiltime
            self.stack = data.stack or nil

            if self.task ~= nil then
                self.task:Cancel()
                self.task = nil
            end
            self.targettime = nil

            if data.remainingtime ~= nil then
                self.targettime = GetTime() + math.max(0, data.remainingtime)
                if self.done then
                    self.task = self.inst:DoTaskInTime(data.remainingtime, dospoil, self)
                    if self.oncontinuedone ~= nil then
                        self.oncontinuedone(self.inst)
                    end
                else
                    self.task = self.inst:DoTaskInTime(data.remainingtime, dostew, self)
                    if self.oncontinuecooking ~= nil then
                        self.oncontinuecooking(self.inst)
                    end
                end
            elseif self.product ~= self.spoiledproduct and data.product_spoilage ~= nil then
                self.targettime = GetTime()
                self.task = self.inst:DoTaskInTime(0, dostew, self)
                if self.oncontinuecooking ~= nil then
                    self.oncontinuecooking(self.inst)
                end
            elseif self.oncontinuedone ~= nil then
                self.oncontinuedone(self.inst)
            end

            if self.inst.components.container ~= nil then
                self.inst.components.container.canbeopened = false
            end
        end
    end

    function Stewer:Harvest(harvester)
        if self.done then
            if self.onharvest ~= nil then
                self.onharvest(self.inst)
            end

            if self.product ~= nil then
                local recipe = cooking.GetRecipe(self.inst.prefab, self.product)
                for i = 1, recipe and recipe.stacksize or 1 do
                    local loot = SpawnPrefab(self.product)
                    if loot ~= nil then
                        local stacksize = self.stack or 1
                        if stacksize > 1 then
                            loot.components.stackable:SetStackSize(stacksize)
                        end
                        if self.spoiltime ~= nil and loot.components.perishable ~= nil then
                            local spoilpercent = self:GetTimeToSpoil() / self.spoiltime
                            loot.components.perishable:SetPercent(self.product_spoilage * spoilpercent)
                            loot.components.perishable:StartPerishing()
                        end
                        if harvester ~= nil and harvester.components.inventory ~= nil then
                            harvester.components.inventory:GiveItem(loot, nil, self.inst:GetPosition())
                        else
                            LaunchAt(loot, self.inst, nil, 1, 1)
                        end
                    end
                end
                self.product = nil
            end

            if self.task ~= nil then
                self.task:Cancel()
                self.task = nil
            end
            self.targettime = nil
            self.done = nil
            self.spoiltime = nil
            self.product_spoilage = nil

            if self.inst.components.container ~= nil then
                self.inst.components.container.canbeopened = true
            end

            return true
        end
    end
end

if Morefeeding == true then
    ----------------------------------------------------------------整组喂鸟
    local Trader = require "components/trader"
    function Trader:AcceptGift(giver, item, count)
        if self:AbleToAccept(item, giver) ~= true then
            return false
        end

        if self:WantsToAccept(item, giver) then
            if self.inst.prefab == "birdcage" or self.inst.prefab == "cane" then
                count = item.components.stackable and item.components.stackable.stacksize or 1
            else
                count = count or 1
            end
            if item.components.stackable ~= nil and item.components.stackable.stacksize > count then
                item = item.components.stackable:Get(count)
            else
                item.components.inventoryitem:RemoveFromOwner(true)
            end

            if self.deleteitemonaccept then
                item:Remove()
            elseif self.inst.components.inventory ~= nil then
                item.prevslot = nil
                item.prevcontainer = nil
                self.inst.components.inventory:GiveItem(item, nil, giver ~= nil and giver:GetPosition() or nil)
            end

            if self.onaccept ~= nil then
                self.onaccept(self.inst, giver, item)
            end

            self.inst:PushEvent("trade", {giver = giver, item = item})

            return true
        end

        if self.onrefuse ~= nil then
            self.onrefuse(self.inst, giver, item)
        end
        return false
    end

    local function PushStateAnim(inst, anim, loop)
        inst.AnimState:PushAnimation(anim .. inst.CAGE_STATE, loop)
    end
    local function GetBird(inst)
        return (inst.components.occupiable and inst.components.occupiable:GetOccupant()) or nil
    end
    local function Em_DigestFood(inst, food)
        local size = food.components.stackable and food.components.stackable.stacksize or 1
        if food.components.edible.foodtype == FOODTYPE.MEAT then
            --If the food is meat:
            --Spawn an egg.
            local egg = inst.components.lootdropper:SpawnLootPrefab("bird_egg")
            egg.components.stackable:SetStackSize(size)
        else
            local seed_name = string.lower(food.prefab .. "_seeds")
            if GLOBAL.Prefabs[seed_name] ~= nil then
                --If the food has a relavent seed type:
                --Spawn 1 or 2 of those seeds.
                local num_seed = 0
                local seed = 0
                for i = 1, size do
                    local num_seeds = math.random(2)
                    for k = 1, num_seeds do
                        num_seed = num_seed + 1
                    end
                    --Spawn regular seeds on a 50% chance.
                    if math.random() < 0.5 then
                        seed = seed + 1
                    end
                end
                if num_seed > 0 then
                    local seed_name = inst.components.lootdropper:SpawnLootPrefab(seed_name)
                    seed_name.components.stackable:SetStackSize(num_seed)
                end
                if seed > 0 then
                    local seeds = inst.components.lootdropper:SpawnLootPrefab("seeds")
                    seeds.components.stackable:SetStackSize(seed)
                end
            else
                --Otherwise...
                --Spawn a poop 1/3 times.
                local num_loot = 0
                for i = 1, size do
                    if math.random() < 0.33 then
                        num_loot = num_loot + 1
                    end
                end
                if num_loot > 0 then
                    local loot = inst.components.lootdropper:SpawnLootPrefab("guano")
                    loot.Transform:SetScale(.33, .33, .33)
                    loot.components.stackable:SetStackSize(num_loot)
                end
            end
        end

        --Refill bird stomach.
        local bird = GetBird(inst)
        if bird and bird:IsValid() and bird.components.perishable then
            bird.components.perishable:SetPercent(1)
        end
    end

    local function Em_OnGetItem(inst, giver, item)
        --If you're sleeping, wake up.
        if inst.components.sleeper and inst.components.sleeper:IsAsleep() then
            inst.components.sleeper:WakeUp()
        end
        if item.components.edible ~= nil and (item.components.edible.foodtype == FOODTYPE.MEAT or item.prefab == "seeds" or GLOBAL.Prefabs[string.lower(item.prefab .. "_seeds")] ~= nil) then
            --If the item is edible...
            --Play some animations (peck, peck, peck, hop, idle)
            inst.AnimState:PlayAnimation("peck")
            inst.AnimState:PushAnimation("peck")
            inst.AnimState:PushAnimation("peck")
            inst.AnimState:PushAnimation("hop")
            PushStateAnim(inst, "idle", true)
            --Digest Food in 60 frames.
            inst:DoTaskInTime(60 * FRAMES, Em_DigestFood, item)
        end
    end

    AddPrefabPostInit(
        "birdcage",
        function(inst)
            if inst.components ~= nil and inst.components.trader ~= nil then
                inst.components.trader.onaccept = Em_OnGetItem
            end
        end
    )
end
