GLOBAL.setmetatable(
	env,
	{
		__index = function(t, k)
			return GLOBAL.rawget(GLOBAL, k)
		end
	}
)
local dropmoon = GetModConfigData("孢子掉落")
local shufu = GetModConfigData("冬暖夏凉")
local jiesulv = GetModConfigData("饥饿速率")
local sanzhi = GetModConfigData("发光阈值")
local aoe = GetModConfigData("AOE伤害")
local dustproof = GetModConfigData("防尘")
local nophysics = GetModConfigData("是否开启碰撞体积和水上行走")
local fangyu = GetModConfigData("防御值")
local milk = GetModConfigData("牛奶帽功能")
local bird = GetModConfigData("羽毛帽功能")
local band = GetModConfigData("独奏乐器功能")
local baoxian = GetModConfigData("保鲜功能")
local speed = GetModConfigData("移速")
local notarget = GetModConfigData("无法选中")
local fangshui = GetModConfigData("防水")
local freezed = GetModConfigData("受攻击冰冻敌人")
local diukuang = GetModConfigData("铥矿护盾")
local yingwu = GetModConfigData("鹦鹉帽")
local chuanzhang = GetModConfigData("船长帽")
local haidao = GetModConfigData("海盗")
local jitui = GetModConfigData("防击退")
local weimianfy = GetModConfigData("位面防御")
local lizhihuifu = GetModConfigData("理智")
local weimianbuff = GetModConfigData("位面加成")
local aoefanwei = GetModConfigData("AOE范围")
local tuzi = GetModConfigData("兔子伪装")
local huluobo = GetModConfigData("胡萝卜外套")
local ice = GetModConfigData("攻击附带冰冻")
TUNING.SANITY_BECOME_ENLIGHTENED_THRESH = sanzhi
--[[local function ShouldNotDrown(owner)
    if owner.components.drownable ~= nil then
        if      owner.components.drownable.enabled ~= false then
                owner.components.drownable.enabled = false
                owner.Physics:ClearCollisionMask()
                owner.Physics:CollidesWith(COLLISION.GROUND)
                owner.Physics:CollidesWith(COLLISION.OBSTACLES)
                owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                owner.Physics:CollidesWith(COLLISION.CHARACTERS)
                owner.Physics:CollidesWith(COLLISION.GIANTS)
                owner.Physics:Teleport(owner.Transform:GetWorldPosition())
        end
    end
end

local function ShouldDrown(owner)
    if owner.components.drownable ~= nil then
        if owner.components.drownable.enabled == false then
            owner.components.drownable.enabled = true
            if not owner:HasTag("playerghost") then
                owner.Physics:ClearCollisionMask()
                owner.Physics:CollidesWith(COLLISION.WORLD)
                owner.Physics:CollidesWith(COLLISION.OBSTACLES)
                owner.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
                owner.Physics:CollidesWith(COLLISION.CHARACTERS)
                owner.Physics:CollidesWith(COLLISION.GIANTS)
                owner.Physics:Teleport(owner.Transform:GetWorldPosition())
            end
        end
    end
end
--]]
local function  ruinshat_fxanim(inst)
    inst._fx.AnimState:PlayAnimation("hit")
    inst._fx.AnimState:PushAnimation("idle_loop")
end

local function ruinshat_oncooldown(inst)
    inst._task = nil
end

local function ruinshat_unproc(inst)
    if inst:HasTag("forcefield") then
        inst:RemoveTag("forcefield")
        if inst._fx ~= nil then
            inst._fx:kill_fx()
            inst._fx = nil
        end
        inst:RemoveEventCallback("armordamaged", ruinshat_fxanim)

        inst.components.armor:SetAbsorption(fangyu)
        inst.components.armor.ontakedamage = nil

        if inst._task ~= nil then
            inst._task:Cancel()
        end
        inst._task = inst:DoTaskInTime(TUNING.ARMOR_RUINSHAT_COOLDOWN, ruinshat_oncooldown)
    end
end

local function ruinshat_proc(inst, owner)--铥矿保护
    inst:AddTag("forcefield")
    if inst._fx ~= nil then
        inst._fx:kill_fx()
    end
    inst._fx = SpawnPrefab("forcefieldfx")
    inst._fx.entity:SetParent(owner.entity)
    inst._fx.Transform:SetPosition(0, 0.2, 0)
    inst:ListenForEvent("armordamaged", ruinshat_fxanim)

    inst.components.armor:SetAbsorption(TUNING.FULL_ABSORPTION)
    inst.components.armor.ontakedamage = function(inst, damage_amount)
        if owner ~= nil and owner.components.sanity ~= nil then
            owner.components.sanity:DoDelta(-damage_amount * TUNING.ARMOR_RUINSHAT_DMG_AS_SANITY, false)
        end
    end

    if inst._task ~= nil then
        inst._task:Cancel()
    end
    inst._task = inst:DoTaskInTime(TUNING.ARMOR_RUINSHAT_DURATION, ruinshat_unproc)
end

local function tryproc(inst, owner, data)
    if inst._task == nil and
        not data.redirected and
        math.random() < TUNING.ARMOR_RUINSHAT_PROC_CHANCE then
        ruinshat_proc(inst, owner)
    end
end

local function ruins_onremove(inst)
    if inst._fx ~= nil then
        inst._fx:kill_fx()
        inst._fx = nil
    end
end

local validfn = function(ent,owner)--aoe攻击不攻击阿比盖尔、墙等
    if ent:HasTag("INLIMBO") or ent:HasTag ("companion") or ent:HasTag ("wall") or ent:HasTag("abigail") or ent:HasTag ("shadowminion")
      or (ent.components.follower ~= nil and ent.components.follower.leader == owner)  then
        return false
    else
        return true
    end
end

local function aoeattack(owner)--aoe攻击
    --local weapon = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    --if weapon ~= nil and  weapon.prefab ~= "staff_lunarplant" then
	if owner.components.combat ~= nil then
        owner.components.combat:EnableAreaDamage(true)
        if owner.components.combat.areahitrange==nil then
            owner.components.combat:SetAreaDamage(aoefanwei,1,validfn )
        end
    end
end

local function aoecheck(owner,data)
    local weapon = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if weapon ~= nil and weapon.prefab ~= "staff_lunarplant" then
        aoeattack(owner)
    else
        owner.components.combat:EnableAreaDamage(false)
    end
end

local function sporedrop(inst)--释放孢子
        local a = math.random(4)
        local b ={"spore_tall","spore_small","spore_medium","spore_moon"}
        --[[if a == 1 then
            inst.components.periodicspawner:SetPrefab("spore_tall")
            inst.components.floater:SetSize("med")
            inst.components.floater:SetScale(0.7)
            print("2")
        elseif a == 2 then
            inst.components.periodicspawner:SetPrefab("spore_small")
            inst.components.floater:SetSize("med")
            print("3")
        elseif a == 3 then
            inst.components.periodicspawner:SetPrefab("spore_medium")
            inst.components.floater:SetSize("med")
            inst.components.floater:SetScale(0.95)
            print("4")
        elseif a == 4 then
            inst.components.periodicspawner:SetPrefab("spore_moon")
            inst.components.floater:SetSize("med")
            print("5")
        end--]]
        return b[a]
    end
local function band_disable(inst)
    if inst.updatetask then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end
    --local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    --owner.components.leader:RemoveFollowersByTag("pig")
end

local banddt = 1
local FOLLOWER_ONEOF_TAGS = {"pig", "merm", "farm_plant"}
local FOLLOWER_CANT_TAGS = {"werepig", "player"}

local function band_update( inst )--独奏乐器
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner
    if owner and owner.components.leader then
        local x,y,z = owner.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, nil, FOLLOWER_CANT_TAGS, FOLLOWER_ONEOF_TAGS)
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 30 then
                if v:HasTag("merm") then
                    if v:HasTag("mermguard") then
                        if owner:HasTag("merm") and not owner:HasTag("mermdisguise") then
                            owner.components.leader:AddFollower(v)
                        end
                    else
                        if owner:HasTag("merm") or (TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKing()) then
                            owner.components.leader:AddFollower(v)
                        end
                    end
                else
                    owner.components.leader:AddFollower(v)
                end
			elseif v.components.farmplanttendable ~= nil then
				v.components.farmplanttendable:TendTo(owner)
			end
        end

        for k,v in pairs(owner.components.leader.followers) do
            if k.components.follower then
                if k:HasTag("pig") then
                    k.components.follower:AddLoyaltyTime(3)

                elseif k:HasTag("merm") then
                    if k:HasTag("mermguard") then
                        if owner:HasTag("merm") and not owner:HasTag("mermdisguise") then
                            k.components.follower:AddLoyaltyTime(3)
                        end
                    else
                        if owner:HasTag("merm") or (TheWorld.components.mermkingmanager and TheWorld.components.mermkingmanager:HasKing()) then
                            k.components.follower:AddLoyaltyTime(3)
                        end
                    end
                end
            end
        end
   --[[else -- This is for haunted one man band
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, HAUNTEDFOLLOWER_MUST_TAGS, FOLLOWER_CANT_TAGS)
        for k,v in pairs(ents) do
            if v.components.follower and not v.components.follower.leader  and not inst.components.leader:IsFollower(v) and inst.components.leader.numfollowers < 10 then
                inst.components.leader:AddFollower(v)
                --owner.components.sanity:DoDelta(-TUNING.SANITY_MED)
            end
        end

        for k,v in pairs(inst.components.leader.followers) do
            if k:HasTag("pig") and k.components.follower then
                k.components.follower:AddLoyaltyTime(3)
            end
        end--]]
    end
end

local function band_enable(inst)
    inst.updatetask = inst:DoPeriodicTask(banddt, band_update, 1)
end

local function  kybaoxian(inst,owner)--可以保鲜
    if inst.components.inventory ~= nil then
        for k,v in pairs(inst.components.inventory.itemslots) do
            if v.components.perishable ~= nil then
                v.components.perishable:StopPerishing()
            end
        end
    elseif owner.components.inventory ~= nil then
    for k,v in pairs(owner.components.inventory.itemslots) do
        if v.components.perishable ~= nil then
            v.components.perishable:StopPerishing()
        end
    end
    end
end

local function bkybaoxian(inst,owner)--不可以保鲜
    if inst.components.inventory ~= nil then
        for k,v in pairs(inst.components.inventory.itemslots) do
            if v.components.perishable ~= nil then
                v.components.perishable:StartPerishing()
            end
        end
    elseif owner.components.inventory ~= nil then
    for k,v in pairs(owner.components.inventory.itemslots) do
        if v.components.perishable ~= nil then
            v.components.perishable:StartPerishing()
        end
    end
    end
end

local function bingdong(owner,data) --受到攻击时冰冻
    if data and data.attacker and data.attacker.components.burnable ~= nil then
        if data.attacker.components.burnable:IsBurning() then
            data.attacker.components.burnable:Extinguish()
        elseif data.attacker.components.burnable:IsSmoldering() then
            data.attacker.components.burnable:SmotherSmolder()
        end
    end

    if data and data.attacker and data.attacker.components.freezable ~= nil then
        data.attacker.components.freezable:AddColdness(10)
        data.attacker.components.freezable:SpawnShatterFX()
    end
end

local function test_polly_spawn(inst)
    if not inst.polly and not inst.components.spawner:IsSpawnPending() then
        inst.components.spawner:ReleaseChild()
    end
end

local function pollyremoved(inst)
    inst:RemoveEventCallback("onremoved", pollyremoved ,inst.polly)
    inst.polly = nil
end

local function polly_rogers_go_away(inst)
    if inst.pollytask then
        inst.pollytask:Cancel()
        inst.pollytask = nil
    end

    if inst.polly then
        inst.polly.flyaway = true
        inst.polly:PushEvent("flyaway")
    end
end

local function getpollyspawnlocation(inst)
    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner or inst
    local pos = Vector3(owner.Transform:GetWorldPosition())
    local offset = nil
    local count = 0
    while offset == nil and count < 12 do
        offset = FindWalkableOffset(pos, math.random()*2*PI, math.random() * 5, 12, false, false, nil, false, true)
        count = count + 1
    end

    if offset then
        pos.x = pos.x + offset.x
        pos.z = pos.z + offset.z
    end
    return pos.x, 15, pos.z
end

local function polly_rogers_onoccupied(inst,child)
    inst.polly = nil
    child.components.follower:StopFollowing()
end

local function polly_rogers_onvacate(inst, child)

    if not inst.worn then
        inst.components.spawner:GoHome(child)
        return
    end

    local owner = inst.components.inventoryitem and inst.components.inventoryitem.owner or nil
    if owner then
        child.sg:GoToState("glide")
        child.Transform:SetRotation(math.random() * 180)
        child.components.locomotor:StopMoving()
        child.hat = inst
        inst:ListenForEvent("onremoved", pollyremoved ,inst.polly)
    end
end


local function mushroom_onspawn_moonspore(inst, spore)
    spore._alwaysinstantpops = true
end

local function mushroom_spawnpoint_moonspore(inst)
    local pos = inst:GetPosition()
    local dist = GetRandomMinMax(0.1, 2.0)

    local offset = FindWalkableOffset(pos, math.random() * TWOPI, dist, 8)

    if offset ~= nil then
        return pos + offset
    end

    return pos
end

local function mushroom_onattacked_moonspore_tryspawn(inst)
    local periodicspawner = inst.components.periodicspawner
        if periodicspawner == nil then
            inst._moonspore_tryspawn_count = nil
            return
        end

        periodicspawner:TrySpawn()

        inst._moonspore_tryspawn_count = inst._moonspore_tryspawn_count - 1
        if inst._moonspore_tryspawn_count <= 0 then
            inst._moonspore_tryspawn_count = nil
            return
        end

        inst:DoTaskInTime(TUNING.MUSHROOMHAT_MOONSPORE_RETALIATION_SPORE_DELAY, mushroom_onattacked_moonspore_tryspawn)
end

local function mushroom_onattacked_moonspore(inst, data)
    local hat = inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
        if hat ~= nil then
            if hat._moonspore_tryspawn_count == nil then
                hat:DoTaskInTime(TUNING.MUSHROOMHAT_MOONSPORE_RETALIATION_SPORE_DELAY, mushroom_onattacked_moonspore_tryspawn)
            end
            hat._moonspore_tryspawn_count = TUNING.MUSHROOMHAT_MOONSPORE_RETALIATION_SPORE_COUNT
        end
end

local function voidcloth_applyitembuff(inst, item, stacks)
    if item.components.planardamage ~= nil then
        if stacks > 0 then
            local bonus = Remap(stacks, 0, 10, 0, 100)
            item.components.planardamage:AddBonus(inst, bonus, "voidclothhat_rampingbuff")
        else
            item.components.planardamage:RemoveBonus(inst, "voidclothhat_rampingbuff")
        end
    end
end

local function voidcloth_setbuffitem(inst, item)
    if inst.buff_item ~= item then
        if inst.buff_item ~= nil then
            voidcloth_applyitembuff(inst, inst.buff_item, 0)
        end
        inst.buff_item = item
        if item ~= nil then
            voidcloth_applyitembuff(inst, item, inst.buff_stacks)
        end
    end
end

local function voidcloth_resetbuff(inst)
    if inst.decaystacktask ~= nil then
        inst.decaystacktask:Cancel()
        inst.decaystacktask = nil
    end

    inst.buff_stacks = 0
    if inst.buff_item ~= nil then
        voidcloth_applyitembuff(inst, inst.buff_item, 0)
    end

    if inst.fx ~= nil then
        inst.fx.buffed:set(false)
    end
end

local function voidcloth_onattackother(inst)
    if inst.buff_item == nil then
        return
    end

    if inst.decaystacktask ~= nil then
        inst.decaystacktask:Cancel()
    end
    inst.decaystacktask = inst:DoTaskInTime(TUNING.ARMOR_VOIDCLOTH_SETBONUS_PLANARDAMAGE_DECAY_TIME, voidcloth_resetbuff)

    if inst.buff_stacks < 10 then
        inst.buff_stacks = inst.buff_stacks + 1
        if inst.buff_item ~= nil then
            voidcloth_applyitembuff(inst, inst.buff_item, inst.buff_stacks)
        end
    end

    if inst.fx ~= nil then
        inst.fx.buffed:set(true)
    end
end

local function voidcloth_setbuffowner(inst, owner)--虚空风帽位面武器伤害加成
    if inst._owner ~= owner then
        if inst._owner ~= nil then
            inst:RemoveEventCallback("equip", inst._onownerequip, inst._owner)
            inst:RemoveEventCallback("unequip", inst._onownerunequip, inst._owner)
            inst:RemoveEventCallback("attacked", inst._onattacked, inst._owner)
            inst:RemoveEventCallback("onattackother", inst._onattackother, inst._owner)
            inst._onownerunequip = nil
            inst._onattacked = nil
            inst._onattackother = nil

            voidcloth_setbuffitem(inst, nil)
            voidcloth_resetbuff(inst)
            inst.buff_stacks = nil
        end
        inst._owner = owner
        if owner ~= nil then
            inst._onownerequip = function(owner, data)
                if data ~= nil and data.eslot == EQUIPSLOTS.HANDS then
                    if data.item ~= nil and data.item.components.planardamage ~= nil and data.item:HasTag("weapon") then
                        voidcloth_setbuffitem(inst, data.item)
                    else
                        voidcloth_setbuffitem(inst, nil)
                    end
                end
            end
            inst._onownerunequip = function(owner, data)
                if data ~= nil and data.eslot == EQUIPSLOTS.HANDS then
                    voidcloth_setbuffitem(inst, nil)
                end
            end
            inst._onattacked = function(owner)
                voidcloth_resetbuff(inst)
            end
            inst._onattackother = function(owner)
                voidcloth_onattackother(inst)
            end
            inst:ListenForEvent("equip", inst._onownerequip, owner)
            inst:ListenForEvent("unequip", inst._onownerunequip, owner)
            inst:ListenForEvent("attacked", inst._onattacked, owner)
            inst:ListenForEvent("onattackother", inst._onattackother, owner)

            inst.buff_stacks = 0
            local weapon = owner.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if weapon ~= nil and weapon.components.planardamage ~= nil and weapon:HasTag("weapon") then
                voidcloth_setbuffitem(inst, weapon)
            end
        end
    end
end

local function bingfumo(owner,data)--------攻击附带冰冻
    --[[if data and data.target then
        local target = data.target
        if target.components and target.components.freezable then
            local coldness = 10 --(冰冻强度)
            local freezetime = 10--(冰冻时间)
            target.components.freezable:AddColdness(coldness, freezetime)
        end
    end--]]
    if data and data.target and data.target.components.burnable ~= nil then
        if data.target.components.burnable:IsBurning() then
            data.target.components.burnable:Extinguish()
        elseif data.target.components.burnable:IsSmoldering() then
            data.target.components.burnable:SmotherSmolder()
        end
    end

    if data and data.target and data.target.components.freezable ~= nil then
        data.target.components.freezable:AddColdness(50,999999)
        data.target.components.freezable:SpawnShatterFX()
    end
end

local function new_on_equip(inst,owner)--------------------------------------------------------戴帽子-------------------------------------------------------------------------------------------------
    owner:AddTag("sanfenredu")

    --[[TheInput:AddKeyDownHandler(KEY_R,function()
        owner:ListenForEvent("onhitother",bingfumo)--按下R，攻击冰冻敌人。
    end)--]]

    if ice == true then--攻击附带冰冻
        owner:ListenForEvent("onhitother",bingfumo)
    end

    if huluobo == true then--假装我没带肉
        inst:AddTag("hidesmeats")
    end

    if tuzi == true then--小兔子乖乖把门儿开开
        owner:AddTag("rabbitdisguise")
    end

    if weimianbuff == true then
        voidcloth_setbuffowner(inst, owner)--虚空风帽
    end

    owner:AddTag("wagstaff_detector")--大发明家定位

    if owner.components.sanity ~= nil then--消除理智值影响
		owner.components.sanity.neg_aura_modifiers:SetModifier(inst, 0)
	end

    owner:AddTag("beefalo")--不被牛牛攻击

    if jitui == true then
        inst:AddTag("heavyarmor")
    end

    if yingwu == true then--波莉·罗杰的帽子
        inst.pollytask = inst:DoTaskInTime(0,function()
            inst.worn = true
            test_polly_spawn(inst)

            inst.polly = inst.components.spawner.child
            if inst.polly then
                inst.polly.components.follower:SetLeader(owner)
                inst.polly.flyaway = nil
            end
            inst.polly:AddTag("NOTARGET")
        end)
    end

    if haidao == true then
        owner:AddTag("master_crewman")
    end

    if chuanzhang == true then
        owner:AddTag("boat_health_buffer")
    end

    if notarget == true then 
        owner:AddTag("NOTARGET")
    end
    if baoxian == true then
       owner:ListenForEvent("itemget",kybaoxian)
    end
    if band == true then
        band_enable(inst)
    end
    if bird == true then
        local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_MAXDELTA_FEATHERHAT, "maxbirds")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MIN, "mindelay")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MAX, "maxdelay")

            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
        end
    end
    if milk == true then
        owner:PushEvent("learncookbookstats", inst.prefab)
        owner:AddDebuff("hungerregenbuff", "hungerregenbuff")
    end

    if diukuang == true then
        inst.onattach(owner)
    end

    --owner:AddTag("moonsporeprevent")
    if dropmoon == true then--开始孢子释放
        owner:AddTag("moon_spore_protection")
        inst.components.periodicspawner:Start()
        inst:ListenForEvent("attacked", mushroom_onattacked_moonspore, owner)
    end
   if nophysics == true then--水上行走
    if owner.Physics then
        RemovePhysicsColliders(owner)
    end
   end
    if owner.components.drownable then
        owner.components.drownable.enabled = false
    end
    if owner.components.hunger ~= nil then
        owner.components.hunger.burnratemodifiers:SetModifier(inst, jiesulv)
    end
    --ShouldNotDrown(owner)
    if aoe == true then
        --aoeattack(inst,owner)
        inst:ListenForEvent("onattackother", aoecheck, owner)
    end

    if freezed == true then --受攻击冰冻
        inst:ListenForEvent("blocked", bingdong, owner)
        inst:ListenForEvent("attacked", bingdong, owner)
    end
end

local function new_on_unequip(inst,owner)-----------------------------------------------------脱下帽子-------------------------------------------------------------------------------------
    owner:RemoveTag("sanfenredu")

    if ice == true then
        owner:RemoveEventCallback("onhitother",bingfumo)
    end

    if huluobo == true and inst:HasTag("hidesmeats") then
        inst:RemoveTag("hidesmeats")
    end

    if tuzi == true and owner:HasTag("rabbitdisguise") then
        owner:RemoveTag("rabbitdisguise")
    end

    if weimianbuff == true then
        voidcloth_setbuffowner(inst, nil)
    end

    owner:RemoveTag("wagstaff_detector")

    if owner.components.sanity ~= nil then
		owner.components.sanity.neg_aura_modifiers:RemoveModifier(inst)
	end

    owner:RemoveTag("beefalo")

    if jitui == true and inst:HasTag("heavyarmor") then
        inst:RemoveTag("heavyarmor")
    end

    if yingwu == true then
        inst.worn = nil
        polly_rogers_go_away(inst)
    end

    if haidao == true and owner:HasTag("master_crewman") then
        owner:RemoveTag("master_crewman")
    end

    if chuanzhang == true and owner:HasTag("boat_health_buffer") then
        owner:RemoveTag("boat_health_buffer")
    end

    if owner:HasTag("NOTARGET") then
        owner:RemoveTag("NOTARGET")
    end
    if baoxian == true then
        owner:RemoveEventCallback("itemget",kybaoxian)
        bkybaoxian(inst,owner)
    end
    if band == true then
        band_disable(inst)
    end
    if bird == true then
        local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:RemoveModifier(inst)

            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
        end
    end
    if milk == true then
        owner:RemoveDebuff("hungerregenbuff")
        if owner.components.foodmemory ~= nil then
            owner.components.foodmemory:RememberFood("hungerregenbuff")
        end
    end
    if diukuang == true then
        inst.ondetach()
    end

    --owner:RemoveTag("moonsporeprevent")
    if dropmoon == true then--停止孢子释放
        owner:RemoveTag("moon_spore_protection")
        inst:RemoveEventCallback("attacked", mushroom_onattacked_moonspore, owner)
        inst.components.periodicspawner:Stop()
    end
  if nophysics == true then
    if owner.Physics then
        ChangeToCharacterPhysics(owner)
    end
  end
    if owner.components.drownable ~=nil then
        owner.components.drownable.enabled = true
    end
     if owner.components.hunger ~= nil then
        owner.components.hunger.burnratemodifiers:RemoveModifier(inst)
    end
    --ShouldDrown(owner)
    if aoe == true then
        inst:RemoveEventCallback("onattackother", aoecheck, owner)
        if owner.components.combat ~= nil then
           owner.components.combat:EnableAreaDamage(false)
        end
    end

    if freezed == true then 
        inst:RemoveEventCallback("blocked", bingdong, owner)
        inst:RemoveEventCallback("attacked", bingdong, owner)
    end
end

local function insulatorstate(inst)--冬暖夏凉
    if inst.components.insulator ~= nil then
        inst:RemoveComponent("insulator")
    end
    if TheWorld.state.iswinter then
        inst:AddComponent("insulator")
        inst.components.insulator:SetWinter()
        inst.components.insulator:SetInsulation(240)
    elseif TheWorld.state.issummer then
        inst:AddComponent("insulator")
        inst.components.insulator:SetSummer()
        inst.components.insulator:SetInsulation(240)
    end
end

local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab ~= "opalpreciousgem" then
        return false
    end
    return true
end

local function OnGivenItem(inst, giver, item)
    c_give("alterguardianhatshard",1)
end

AddPrefabPostInit("alterguardianhat",
function(inst)--------------------------------------------------------------------------------------定义函数--------------------------------------------------------------------
		if inst and inst.components and inst.components.equippable then
            inst.components.equippable.walkspeedmult = speed
            inst.components.equippable.insulated = true
            inst.components.equippable.dapperness = lizhihuifu
            local old_on_equip = inst.components.equippable.onequipfn
            inst.components.equippable:SetOnEquip(
				function(_inst, _owner)
					new_on_equip(_inst, _owner)
					old_on_equip(_inst, _owner)
                end
            )
            local old_on_unequip = inst.components.equippable.onunequipfn
			inst.components.equippable:SetOnUnequip(
				function(_inst, _owner)
					old_on_unequip(_inst, _owner)
					new_on_unequip(_inst, _owner)
				end
            )
        end
    insulatorstate(inst)
    --[[if dropmoon == true then
        sporedrop(inst)
    end--]]

    if dustproof == true then
        inst:AddTag("goggles")--护目镜  
    end
    inst:AddTag("junk")--可以防止被拾荒疯猪扔出的垃圾堆击中时受到伤害。
    inst:AddTag("miasmaimmune")--瘴气免疫
    inst:AddTag("dustresistance")
    inst:AddComponent("armor")
    inst:AddTag("hide_percentage")
    inst.components.armor:InitIndestructible(fangyu)

    if fangshui == false then 
        if inst.components.waterproofer ~= nil then
            inst:RemoveComponent("waterproofer")
        end
    end
    if fangshui == true then
        if inst.components.waterproofer == nil then 
            inst:AddComponent("waterproofer")
            inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_ABSOLUTE)
        end
    end

    if yingwu == true then--波莉·罗杰的帽子
        inst:AddComponent("spawner")
        inst.components.spawner:Configure("polly_rogers", TUNING.POLLY_ROGERS_SPAWN_TIME)
        inst.components.spawner.onvacate = polly_rogers_onvacate
        inst.components.spawner.onoccupied = polly_rogers_onoccupied
        inst.components.spawner.overridespawnlocation = getpollyspawnlocation
        inst.components.spawner:CancelSpawning()
    end

    if dropmoon == true then--孢子
        inst:AddComponent("periodicspawner")
        --inst.components.periodicspawner:SetRandomTimes(10, 1, true)
        inst.components.periodicspawner:SetPrefab(sporedrop)
        inst.components.periodicspawner:SetIgnoreFlotsamGenerator(true)
        inst.components.periodicspawner:SetRandomTimes(TUNING.MUSHROOMHAT_MOONSPORE_TIME, TUNING.MUSHROOMHAT_MOONSPORE_TIME_VARIANCE, true)
        inst.components.periodicspawner:SetOnSpawnFn(mushroom_onspawn_moonspore)
        inst.components.periodicspawner:SetGetSpawnPointFn(mushroom_spawnpoint_moonspore)
    end

    inst:AddComponent("trader")
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.onaccept = OnGivenItem

    if weimianfy ~= 0 then--位面防御
        inst:AddComponent("planardefense")
        inst.components.planardefense:SetBaseDefense(weimianfy)
    end

    if diukuang == true then
    inst.OnRemoveEntity = ruins_onremove
    inst._fx = nil
        inst._task = nil
        inst._owner = nil
        inst.procfn = function(owner, data) tryproc(inst, owner, data) end
        inst.onattach = function(owner)
            if inst._owner ~= nil then
                inst:RemoveEventCallback("attacked", inst.procfn, inst._owner)
                inst:RemoveEventCallback("onremove", inst.ondetach, inst._owner)
            end
            inst:ListenForEvent("attacked", inst.procfn, owner)
            inst:ListenForEvent("onremove", inst.ondetach, owner)
            inst._owner = owner
            inst._fx = nil
        end
        inst.ondetach = function()
            ruinshat_unproc(inst)
            if inst._owner ~= nil then
                inst:RemoveEventCallback("attacked", inst.procfn, inst._owner)
                inst:RemoveEventCallback("onremove", inst.ondetach, inst._owner)
                inst._owner = nil
                inst._fx = nil
            end
        end
    end

    if shufu == true then
        inst:WatchWorldState("isday", insulatorstate)
    elseif shufu == false then
        inst:StopWatchingWorldState("isday", insulatorstate)
        if inst.components.insulator ~= nil then
           inst:RemoveComponent("insulator")
        end
    end

end
)
if nophysics == true then
 AddComponentPostInit("drownable", function(drownable,inst)--水上漂
	local oldShouldDrownFn=drownable.ShouldDrown
	drownable.ShouldDrown=function (self)
	if self.inst:HasTag("sanfenredu") and self.inst:HasTag("player")  then--有标签不会落水
    return false
	end
	if oldShouldDrownFn then
	return oldShouldDrownFn(self)
	end
	    return self.enabled
        and self:IsOverWater()
        and (self.inst.components.health == nil or not self.inst.components.health:IsInvincible())
	end
 end)
end
---------------------------------------------------以下实现沃姆伍德""平易近蜂"功能---------------------------------------------------
--[[AddBrainPostInit("butterflybrain", function(self)--不是哥们，这api要怎么用啊
    local RUN_AWAY_PARAMS =
{
    tags = {"scarytoprey"},
    fn = function(guy)
        return not (guy.components.skilltreeupdater
                and guy.components.skilltreeupdater:IsActivated("wormwood_bugs"))
    end,
}
end)--]]

--[[if dustproof == true then--防尘
    AddPlayerPostInit(
        function(player)
            player.last_tag = nil
            player:ListenForEvent("changearea",
            function(inst,data)
                if TheWorld.ismastersim then
                    local hat = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
                    if hat and hat:HasTag("dustresistance") then
                        local indust =
                        (TheWorld.components.sandstorms and TheWorld.components.sandstorms:IsInSandstorm(player))or
                        (TheWorld.net.components.moonstorms and TheWorld.net.components.moonstorms:IsInMoonstorm(player))
                        local tag = false
                        if indust then
                            hat:AddTag("goggles")
                            tag = true
                        else
                            hat:RemoveTag("goggles")
                        end
                        if player.last_tag == nil or tag ~= player.last_tag then
                            player:PushEvent("unequip", {item = hat, eslot = EQUIPSLOTS.HEAD})
							player:PushEvent("equip", {item = hat, eslot = EQUIPSLOTS.HEAD})
							player.last_tag = tag
                        end
                    end
                end
            end)
        end
    )
end--]]