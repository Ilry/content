GLOBAL.setmetatable(
	env,
	{
		__index = function(t, k)
			return GLOBAL.rawget(GLOBAL, k)
		end
	}
)

local DISABLE_AUTO_OPEN = GetModConfigData("disable_auto_open")
local SANITY_DELTA_WHEN_ATTACK = GetModConfigData("sanity_loss_when_attack")
local SANITY_BECOME_ENLIGHTENED_THRESH = GetModConfigData("activate_threshold")
local NUM_OF_GESTALT = GetModConfigData("gestalt_spawn_num")
local ARMR_ABSORB_PERCENT = GetModConfigData("armor_absorb_percent")
local DAMAGE_MULTIPLIER = GetModConfigData("damage_multiplier")
local WATERPROOFNESS = GetModConfigData("waterproofness")
local WALKPEEDMULT = GetModConfigData("walkspeedmult")
local MILD_TEMPERATURE = GetModConfigData("mild_temperature")
local FIRE_IMMUNE = GetModConfigData("fire_immune")
local GOGGLES_VISION = GetModConfigData("goggles_vision")
local CRAFTABLE = GetModConfigData("craftable")
local BEEFALO_FRIENDLY = GetModConfigData("beefalo_friendly")

TUNING.SANITY_BECOME_ENLIGHTENED_THRESH = SANITY_BECOME_ENLIGHTENED_THRESH

local function alterguardian_spawn_more_gestalt_fn(inst, owner, data)
	if not inst._is_active then
		return
	end

	if owner ~= nil and (owner.components.health == nil or not owner.components.health:IsDead()) then
		local target = data.target
		if
			target and target ~= owner and target:IsValid() and
				(target.components.health == nil or
					not target.components.health:IsDead() and not target:HasTag("structure") and not target:HasTag("wall"))
		 then
			-- In combat, this is when we're just launching a projectile, so don't spawn a gestalt yet
			if
				data.weapon ~= nil and data.projectile == nil and
					(data.weapon.components.projectile ~= nil or data.weapon.components.complexprojectile ~= nil or
						data.weapon.components.weapon:CanRangedAttack())
			 then
				return
			end

			local x, y, z = target.Transform:GetWorldPosition()

			--spawn more projectiles
			for i = 2, NUM_OF_GESTALT do
				local gestalt = SpawnPrefab("alterguardianhat_projectile")
				local r = GetRandomMinMax(3, 5)
				local delta_angle = GetRandomMinMax(-90, 90)
				local angle = (owner:GetAngleToPoint(x, y, z) + delta_angle) * DEGREES
				gestalt.Transform:SetPosition(x + r * math.cos(angle), y, z + r * -math.sin(angle))
				gestalt:ForceFacePoint(x, y, z)
				gestalt:SetTargetPosition(Vector3(x, y, z))
				gestalt.components.follower:SetLeader(owner)
			end

			local delta = 0
			if NUM_OF_GESTALT == 0 then
				delta = SANITY_DELTA_WHEN_ATTACK
			else
				delta = SANITY_DELTA_WHEN_ATTACK + 1
			end
			if owner.components.sanity ~= nil then
				owner.components.sanity:DoDelta(delta, true) -- using overtime so it doesnt make the sanity sfx every time you attack
			end
		end
	end
end

local function new_on_equip(inst, owner)
	if DISABLE_AUTO_OPEN and owner then
		inst.keep_closed = owner.userid
	end

	inst.alterguardian_spawn_more_gestalt_fn = function(_owner, _data)
		alterguardian_spawn_more_gestalt_fn(inst, _owner, _data)
	end
	inst:ListenForEvent("onattackother", inst.alterguardian_spawn_more_gestalt_fn, owner)

	if MILD_TEMPERATURE then
		inst.set_player_temperature_fn = function(_owner, _data)
			if
				_owner and _owner.components and _owner.components.temperature and _data and _data.new and
					(_data.new <= 10 or _data.new >= 60)
			 then
				_owner.components.temperature:SetTemperature(35)
			end
		end
		inst:ListenForEvent("temperaturedelta", inst.set_player_temperature_fn, owner)
	end

	if
		FIRE_IMMUNE and owner and owner.components and owner.components.health and
			owner.components.health.externalfiredamagemultipliers
	 then
		owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 0, "alterguardianhat_fire_damage_multiplier")
	end

	if
		DAMAGE_MULTIPLIER > 1 and owner and owner.components and owner.components.combat and
			owner.components.combat.externaldamagemultipliers
	 then
		owner.components.combat.externaldamagemultipliers:SetModifier(
			inst,
			DAMAGE_MULTIPLIER,
			"alterguardianhat_damage_multiplier"
		)
	end

	if BEEFALO_FRIENDLY then
		owner:AddTag("beefalo")
	end
end

local function new_on_unequip(inst, owner)
	inst:RemoveEventCallback("onattackother", inst.alterguardian_spawn_more_gestalt_fn, owner)

	if MILD_TEMPERATURE then
		inst:RemoveEventCallback("temperaturedelta", inst.set_player_temperature_fn, owner)
	end

	if
		FIRE_IMMUNE and owner and owner.components and owner.components.health and
			owner.components.health.externalfiredamagemultipliers
	 then
		owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst, "alterguardianhat_fire_damage_multiplier")
	end

	if
		DAMAGE_MULTIPLIER > 1 and owner and owner.components and owner.components.combat and
			owner.components.combat.externaldamagemultipliers
	 then
		owner.components.combat.externaldamagemultipliers:RemoveModifier(inst, "alterguardianhat_damage_multiplier")
	end

	if BEEFALO_FRIENDLY then
		owner:RemoveTag("beefalo")
	end
end

AddPrefabPostInit(
	"alterguardianhat",
	function(inst)
		inst:AddTag("mod_alterguardianhat")
		if inst and inst.components and inst.components.equippable then
			local old_on_equip = inst.components.equippable.onequipfn
			inst.components.equippable:SetOnEquip(
				function(_inst, _owner)
					new_on_equip(_inst, _owner)
					old_on_equip(_inst, _owner)
					if NUM_OF_GESTALT <= 0 then
						--do not spawn gestalt
						_inst:RemoveEventCallback("onattackother", _inst.alterguardian_spawngestalt_fn, _owner)
					end
				end
			)
			local old_on_unequip = inst.components.equippable.onunequipfn
			inst.components.equippable:SetOnUnequip(
				function(_inst, _owner)
					old_on_unequip(_inst, _owner)
					new_on_unequip(_inst, _owner)
				end
			)
			if WALKPEEDMULT > 1 then
				inst.components.equippable.walkspeedmult = WALKPEEDMULT
			end
		end

		if ARMR_ABSORB_PERCENT > 0 then
			inst:AddComponent("armor")
			inst.components.armor:InitIndestructible(ARMR_ABSORB_PERCENT)
		end

		if WATERPROOFNESS > 0 then
			inst:AddComponent("waterproofer")
			inst.components.waterproofer:SetEffectiveness(WATERPROOFNESS)
		end
	end
)
if GOGGLES_VISION then
	AddPlayerPostInit(
		function(player)
			player.last_tag = nil
			player:ListenForEvent(
				"changearea",
				function(inst, data)
					if TheWorld.ismastersim then
						local hat = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
						if hat and hat:HasTag("mod_alterguardianhat") then
							local isInStorm =
								(TheWorld.components.sandstorms and TheWorld.components.sandstorms:IsInSandstorm(player)) or
								(TheWorld.net.components.moonstorms and TheWorld.net.components.moonstorms:IsInMoonstorm(player))
							local tag = false
							if isInStorm then
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
				end
			)
		end
	)
end

hat_filter = {"CLOTHING", "LIGHT", "MODS"}
if ARMR_ABSORB_PERCENT > 0 then
	table.insert(hat_filter, "ARMOUR")
end
if WATERPROOFNESS > 0 then
	table.insert(hat_filter, "RAIN")
end

if CRAFTABLE then
	AddRecipe2(
		"alterguardianhatshard",
		{Ingredient("moonglass", 6)},
		TECH.CELESTIAL_THREE,
		{nounlock = true},
		{"REFINE", "MODS"}
	)
	AddRecipe2(
		"alterguardianhat",
		{Ingredient("alterguardianhatshard", 5)},
		TECH.CELESTIAL_THREE,
		{nounlock = true},
		hat_filter
	)
end
