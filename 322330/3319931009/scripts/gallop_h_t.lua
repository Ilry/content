----------------------------------------------------------------
table.insert(Assets, Asset("IMAGE", "images/gallop_inventoryimages_h_t.tex"))
table.insert(Assets, Asset("ATLAS", "images/gallop_inventoryimages_h_t.xml"))
table.insert(Assets, Asset("ATLAS_BUILD", "images/gallop_inventoryimages_h_t.xml", 256))

RegisterInventoryItemAtlas("images/gallop_inventoryimages_h_t.xml", "gallop_hydra.tex")
RegisterInventoryItemAtlas("images/gallop_inventoryimages_h_t.xml", "gallop_tiamat.tex")

table.insert(PrefabFiles, "gallop_hydra")
table.insert(PrefabFiles, "gallop_tiamat")
----------------------------------------------------------------
AddPrefabPostInit("dragonfly", function(inst)
    if not TheWorld.ismastersim then
        return
    end
    if inst.components.lootdropper ~= nil then
    	inst.components.lootdropper:AddChanceLoot("gallop_hydra_blueprint", .75)
    end
end)
----------------------------------------------------------------
local function GALLOP_SETSTRING(chs, eng)
	return currentlang == "zh" and chs or eng
end

STRINGS.NAMES.GALLOP_HYDRA = GALLOP_SETSTRING("巨型九头蛇", "Giant Hydra")
STRINGS.RECIPE_DESC.GALLOP_HYDRA = GALLOP_SETSTRING("来自熔岩火海的巨型九头蛇。", "A giant Hydra from the lava sea.")
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GALLOP_HYDRA = GALLOP_SETSTRING("打出巨兽般猛烈的攻击。", "Strike fiercely like a giant beast.")
STRINGS.CHARACTERS.GALLOP.DESCRIBE.GALLOP_HYDRA = GALLOP_SETSTRING("最好配合心之钢使用。", "It is best to use it in conjunction with Heart Steel.")

STRINGS.NAMES.GALLOP_TIAMAT = GALLOP_SETSTRING("提亚马特", "Tiamat")
STRINGS.RECIPE_DESC.GALLOP_TIAMAT = GALLOP_SETSTRING("左右手并用，撕碎敌人！", "Use both hands to tear apart the enemy!")
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GALLOP_TIAMAT = GALLOP_SETSTRING("手快的话可以打出二连击。", "If you're quick, you can hit a combo.")
STRINGS.CHARACTERS.GALLOP.DESCRIBE.GALLOP_TIAMAT = GALLOP_SETSTRING("非常好的黄金战斧。", "A very good golden battle axe.")
----------------------------------------------------------------
AddRecipe2(
        "gallop_hydra",
        {Ingredient("gallop_tiamat", 1), Ingredient("ruins_bat", 1), Ingredient("dragon_scales", 2), Ingredient("redgem", 10), Ingredient("townportaltalisman", 4),},
        TECH.LOST,
        {},
        {"WEAPONS"}
    )

AddRecipe2(
        "gallop_tiamat",
        {Ingredient("goldenaxe", 1), Ingredient("goldenpickaxe", 1), Ingredient("goldnugget", 10), Ingredient("marble", 4),},
        TECH.SCIENCE_TWO,
        {},
        {"WEAPONS"}
    )
----------------------------------------------------------------
AddStategraphState("wilson", State{
        name = "gallop_triple_atk",
        tags = { "attack", "notalking", "abouttoattack", "autopredict", "gallop_triple_atk" },

        onenter = function(inst)
            inst.AnimState:SetDeltaTimeMultiplier(2)

            if inst.components.combat:InCooldown() then
                inst.sg:RemoveStateTag("abouttoattack")
                inst:ClearBufferedAction()
                inst.sg:GoToState("idle", true)
                return
            end

            inst:AddTag("gallop_nocahrge")

            if inst.sg.laststate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
            end
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
            local cooldown = inst.components.combat.min_attack_period + .5 * FRAMES

            --inst.AnimState:PlayAnimation("spearjab")
            --inst.AnimState:PushAnimation("spearjab", false)
            --inst.AnimState:PushAnimation("spearjab", false)
            inst.AnimState:PlayAnimation("multithrust")

            cooldown = math.max(cooldown, 15 * FRAMES)

            inst.sg:SetTimeout(cooldown)

            if target ~= nil then
                inst.components.combat:BattleCry()
                if target:IsValid() then
                    inst:FacePoint(target:GetPosition())
                    inst.sg.statemem.attacktarget = target
                    inst.sg.statemem.retarget = target
                end
            end
        end,

        timeline =
        {
        	TimeEvent(3 * FRAMES, function(inst)
                inst.components.combat:DoAttack()
            end),
			TimeEvent(6 * FRAMES, function(inst)
                inst.components.combat:DoAttack()
            end),	
            TimeEvent(9 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
            TimeEvent(13 * FRAMES, function(inst)
            	inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
            inst.AnimState:SetDeltaTimeMultiplier(1)

            local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equip then
            	equip:RemoveTag("gallop_triple_atk")
            end
            inst:RemoveTag("gallop_nocahrge")
        end,
})

AddStategraphState("wilson_client", State{
        name = "gallop_triple_atk",
        tags = { "attack", "notalking", "abouttoattack"},

        onenter = function(inst)
            inst.AnimState:SetDeltaTimeMultiplier(2)

            local buffaction = inst:GetBufferedAction()
            local cooldown = 0

            if inst.replica.combat ~= nil then
                local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if inst.replica.combat:InCooldown() then
                    inst.sg:RemoveStateTag("abouttoattack")
                    inst:ClearBufferedAction()
                    inst.sg:GoToState("idle", true)
                    return
                end
                inst.replica.combat:StartAttack()
                cooldown = inst.replica.combat:MinAttackPeriod() + .5 * FRAMES
            end
            if inst.sg.laststate == inst.sg.currentstate then
                inst.sg.statemem.chained = true
            end
            inst.components.locomotor:Stop()

            --inst.AnimState:PlayAnimation("spearjab")
            --inst.AnimState:PushAnimation("spearjab", false)
            --inst.AnimState:PushAnimation("spearjab", false)
            inst.AnimState:PlayAnimation("multithrust")
            
            if cooldown > 0 then
                cooldown = math.max(cooldown, 15 * FRAMES)
            end

            if buffaction ~= nil then
                inst:PerformPreviewBufferedAction()

                if buffaction.target ~= nil and buffaction.target:IsValid() then
                    inst:FacePoint(buffaction.target:GetPosition())
                    inst.sg.statemem.attacktarget = buffaction.target
                    inst.sg.statemem.retarget = buffaction.target
                end
            end

            if cooldown > 0 then
                inst.sg:SetTimeout(cooldown)
            end
        end,

        timeline =
        {
            TimeEvent(9 * FRAMES, function(inst)
                inst:ClearBufferedAction()
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
                inst.replica.combat:CancelAttack()
            end
            inst.AnimState:SetDeltaTimeMultiplier(1)
        end,
})
----------------------------------------------------------------
local function Gallop_Action(sg)
    local old_attack = sg.states["attack"]
    if old_attack ~= nil then
        local old_onenter = old_attack.onenter
        old_attack.onenter = function(inst)
            local equip, isriding = nil, nil
            if TheWorld.ismastersim then
                equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                isriding = inst.components.rider:IsRiding()
            else
                equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                isriding = inst.replica.rider ~= nil and inst.replica.rider:IsRiding()
            end
            if equip ~= nil and equip:HasTag("gallop_triple_atk") then
                if not isriding then 
                    inst.sg:GoToState("gallop_triple_atk")
                    return
                end
            end
            if old_onenter then
                return old_onenter(inst)
            end
        end
    end

    for k,v in pairs({"doswipeaction", "attack_pillow"}) do
        local old_action = sg.states[v]
        if old_action ~= nil then
            local old_onenter = old_action.onenter
            old_action.onenter = function(inst)
                if old_onenter then
                    old_onenter(inst)
                end
                local weapon = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if weapon and weapon:HasTag("gallop_chop") and weapon.gallop_chop_cd and weapon.gallop_chop_cd > 0 then
                    if inst.components.playercontroller then
                        inst.components.playercontroller:ClearActionHold()
                    end
                end
            end
        end
    end
end

AddStategraphPostInit("wilson", Gallop_Action)
AddStategraphPostInit("wilson_client", Gallop_Action)
----------------------------------------------------------------
AddAction("GALLOP_CHOP", GALLOP_SETSTRING("钢斩", "Chop"), function(act)
	local doer = act.doer
    local pt = doer:GetPosition()
	if pt then
		local dmg = 10
		local weapon = doer.components.inventory and doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if not weapon or weapon:HasTag("gallop_chop_discharge") then
			return false
		end
        weapon:PushEvent("gallop_refreshdmg")
        if weapon:HasTag("gallop_chop") then
        	dmg = weapon.components.weapon and weapon.components.weapon.damage or dmg
        	if weapon.components.rechargeable then
        		weapon.components.rechargeable:Discharge(weapon.gallop_chop_cd or 1)
        	end
        end
        local hit = false
        local heading_angle = -(doer.Transform:GetRotation())
    	local dir = Vector3(math.cos(heading_angle*DEGREES), 0, math.sin(heading_angle*DEGREES))
		local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, weapon:HasTag("gallop_hydra") and 4.5 or 3.5, nil, {"FX", "NOCLICK", "DECOR", "INLIMBO"})
    	for k,v in pairs(ents) do
        	if v ~= doer then
            	local hp = v:GetPosition()
            	local offset = (hp - pt):GetNormalized()
            	local dot = offset:Dot(dir)
            	if dot > .5 then --cos60=.5
                    if v.components.combat ~= nil and doer.components.combat ~= nil 
                        and doer.components.combat:CanTarget(v) and v.components.combat:CanBeAttacked(doer)
                            and not doer.components.combat:IsAlly(v) then
            		    dmg = doer.components.combat:CalcDamage(v, weapon)
                	    v.components.combat:GetAttacked(doer, dmg)
                	    --doer.components.combat:DoAttack(v, nil, nil, nil, nil, 10)
                	    if weapon.hit_fx then
        				    weapon.hit_fx(v:GetPosition())
        			    end
                        hit = true
                    end
                    if v.components.inventoryitem and v.components.inventoryitem.canbepickedup and v.Physics then
                        local angle = math.atan2(offset.z, offset.x)
                        local sina, cosa = math.sin(angle), math.cos(angle)
                        local spd = (math.random() * 2 + 1) * 1.5
                        v.Physics:SetVel(spd * cosa, math.random() * 2 + 4 + 2 * 1.5, spd * sina)
                    end
            	end
            end
        end
        if hit and weapon.components.finiteuses then
        	weapon.components.finiteuses:Use(5)
        end

		return true
	end
    return false
end)

ACTIONS.GALLOP_CHOP.priority = 10
ACTIONS.GALLOP_CHOP.distance = 30
ACTIONS.GALLOP_CHOP.mount_valid = false
ACTIONS.GALLOP_CHOP.silent_fail = true

AddComponentAction("POINT", "gallop_chop", function(inst, doer, pos, actions, right, target)
	if right and not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) then
        if inst:HasTag("gallop_chop") and not inst:HasTag("gallop_chop_discharge") then
            table.insert(actions, ACTIONS.GALLOP_CHOP)
        end
    end
end)

AddComponentAction("EQUIPPED", "gallop_chop", function(inst, doer, target, actions, right)
	if right and not (doer.replica.rider ~= nil and doer.replica.rider:IsRiding()) 
		and target.replica.combat ~= nil and doer.replica.combat:CanTarget(target) and target.replica.combat:CanBeAttacked(doer) then
		if inst:HasTag("gallop_chop") and not inst:HasTag("gallop_chop_discharge") then
            table.insert(actions, ACTIONS.GALLOP_CHOP)
        end
	end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.GALLOP_CHOP, function(inst, action)
	return action.invobject ~= nil and action.invobject:HasTag("gallop_hydra") and "doswipeaction" or "attack_pillow_pre"
end))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.GALLOP_CHOP, function(inst, action)
	return action.invobject ~= nil and action.invobject:HasTag("gallop_hydra") and "doswipeaction" or "attack_pillow_pre"
end))
----------------------------------------------------------------
local bufferaction_constructor = BufferedAction._ctor
BufferedAction._ctor = function(self, doer, target, action, invobject, ...)
    bufferaction_constructor(self, doer, target, action, invobject, ...)
    if action == ACTIONS.GALLOP_CHOP then
        if target then
            local range = 3
            if invobject and invobject:HasTag("gallop_hydra") then
                range = 4
            end
            self.distance = range
        end
    end
end