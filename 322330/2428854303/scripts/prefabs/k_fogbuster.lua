local assets =
{
    Asset("ANIM", "anim/fog_buster.zip"),
	Asset("ANIM", "anim/kyno_flarebuster2.zip"),
	
	Asset("IMAGE", "images/inventoryimages/tap_buildingimages.tex"),
	Asset("ATLAS", "images/inventoryimages/tap_buildingimages.xml"),
}

local prefabs =
{
    "miniflare_minimap",
}

local minimap_assets =
{
	Asset("ANIM", "anim/fog_buster.zip"),
	Asset("ANIM", "anim/kyno_flarebuster2.zip"),
	
    Asset("MINIMAP_IMAGE", "flare"),
    Asset("MINIMAP_IMAGE", "flare2"),
    Asset("MINIMAP_IMAGE", "flare3"),
}

local minimap_prefabs =
{
    "globalmapicon",
}

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_straw")
	inst:Remove()
end

local function RemoveHudIndicator(inst)
	if ThePlayer ~= nil and ThePlayer.HUD ~= nil then
		ThePlayer.HUD:RemoveTargetIndicator(inst)
	end
end

local function SetupHudIndicator(inst)
	ThePlayer.HUD:AddTargetIndicator(inst, {image = "miniflare.tex"})
	inst:DoTaskInTime(TUNING.MINIFLARE.HUD_INDICATOR_TIME, RemoveHudIndicator)
	inst:ListenForEvent("onremove", RemoveHudIndicator)
end

local function show_flare_hud3(inst)
    if ThePlayer ~= nil then
        local fx, fy, fz = inst.Transform:GetWorldPosition()
        local px, py, pz = ThePlayer.Transform:GetWorldPosition()
        local sq_dist_to_flare = distsq(fx, fz, px, pz)

        if ThePlayer.HUD ~= nil then
            if sq_dist_to_flare < TUNING.MINIFLARE.HUD_MAX_DISTANCE_SQ then
                ThePlayer:PushEvent("startflareoverlay")
		    else
			    SetupHudIndicator(inst)
            end
        end

        local near_audio_gate_distsq = TUNING.MINIFLARE.HUD_MAX_DISTANCE_SQ
        local far_audio_gate_distsq = TUNING.MINIFLARE.FAR_AUDIO_GATE_DISTANCE_SQ
        local volume = (sq_dist_to_flare > far_audio_gate_distsq and TUNING.MINIFLARE.BASE_VOLUME)
                or (sq_dist_to_flare > near_audio_gate_distsq and
                        TUNING.MINIFLARE.BASE_VOLUME + (1 - Remap(sq_dist_to_flare, near_audio_gate_distsq, far_audio_gate_distsq, 0, 1)) * (1-TUNING.MINIFLARE.BASE_VOLUME)
                    )
                or 1.0
        inst.SoundEmitter:PlaySound("turnoftides/common/together/miniflare/explode", nil, volume)
    end
end

local function do_flare_minimap_swap(inst)
    local flare_index = math.random(1, 2)
    if flare_index == inst._small_minimap then
        flare_index = 3
    end
    inst._small_minimap = flare_index

    local flare_image = (flare_index == 1 and "flare.png") or ("flare"..flare_index..".png")

    inst.MiniMapEntity:SetIcon(flare_image)
    inst.icon.MiniMapEntity:SetIcon(flare_image)
end

local function show_flare_minimap(inst)
    inst.icon = SpawnPrefab("globalmapicon")
    inst.icon:TrackEntity(inst)
    inst.icon.MiniMapEntity:SetPriority(21)

    inst:DoPeriodicTask(TUNING.MINIFLARE.ANIM_SWAP_TIME, do_flare_minimap_swap)
end

local function flare_minimap()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.MiniMapEntity:SetCanUseCache(false)
    inst.MiniMapEntity:SetDrawOverFogOfWar(true)
    inst.MiniMapEntity:SetIcon("flare.png")
    inst.MiniMapEntity:SetPriority(21)

	inst:SetPrefabNameOverride("MINIFLARE")

    inst.entity:SetCanSleep(false)

    inst:DoTaskInTime(0, show_flare_hud)

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst:DoTaskInTime(0, show_flare_minimap)
    inst.persists = false
    inst._small_minimap = 1

    return inst
end

local function on_ignite_over(inst)
    local fx, fy, fz = inst.Transform:GetWorldPosition()

    local random_angle = math.pi * 2 * math.random()
    local random_radius = -(TUNING.MINIFLARE.OFFSHOOT_RADIUS) + (math.random() * 2 * TUNING.MINIFLARE.OFFSHOOT_RADIUS)

    fx = fx + (random_radius * math.cos(random_angle))
    fz = fz + (random_radius * math.sin(random_angle))

    for _, player in ipairs(AllPlayers) do
        if player._miniflareannouncedelay == nil and math.random() > TUNING.MINIFLARE.CHANCE_TO_NOTICE then
            local px, py, pz = player.Transform:GetWorldPosition()
            local sq_dist_to_flare = distsq(fx, fz, px, pz)
            if sq_dist_to_flare > TUNING.MINIFLARE.SPEECH_MIN_DISTANCE_SQ then
				player._miniflareannouncedelay = player:DoTaskInTime(TUNING.MINIFLARE.NEXT_NOTICE_DELAY, function(i) i._miniflareannouncedelay = nil end)
                player.components.talker:Say(GetString(player, "ANNOUNCE_FLARE_SEEN"))
            end
        end
    end

    local minimap = SpawnPrefab("miniflare_minimap")
    minimap.Transform:SetPosition(fx, fy, fz)
    minimap:DoTaskInTime(TUNING.MINIFLARE.TIME, function()
        minimap:Remove()
    end)

    inst:Remove()
end

local function on_ignite(inst)
    inst.persists = false
    inst.entity:SetCanSleep(false)
	
	local lx, ly, lz = inst.Transform:GetWorldPosition()
	
	local launcher = SpawnPrefab("kyno_fogbuster_launcher")
	launcher.Transform:SetPosition(lx, ly, lz)
    launcher.AnimState:PlayAnimation("launch")
    launcher:ListenForEvent("animover", on_ignite_over)

    launcher.SoundEmitter:PlaySound("turnoftides/common/together/miniflare/launch")
	
	inst:DoTaskInTime(0.3, function() inst:Remove() end)
end

local s = 1.2

local function flare_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetScale(s, s, s)

    inst.AnimState:SetBank("kyno_flarebuster2")
    inst.AnimState:SetBuild("kyno_flarebuster2")
    inst.AnimState:PlayAnimation("idle", true)
	
	inst:AddTag("thefogbuster")

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("lootdropper")
	
    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "MINIFLARE"
	
	inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	
	inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("burnable")
    inst.components.burnable:SetOnIgniteFn(on_ignite)

    MakeSmallPropagator(inst)
    inst.components.propagator.heatoutput = 0
    inst.components.propagator.damages = false
    MakeHauntableLaunch(inst)

    return inst
end

-- OKAY. For some reason the animations of the original "fog_buster" don't show.
-- So I made a fake idle animation just for showcase on ground. This below is for the
-- "launch" animation and when the flare-thing does the work. When the Fog Buster is lit
-- We replace the original prefab with the launcher prefab to play a cool effect.

local function launcher_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("fog_buster")
    inst.AnimState:SetBuild("fog_buster")

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	inst.components.inspectable.nameoverride = "MINIFLARE"

    return inst
end

local function fogbusterplacerfn(inst)
	inst.AnimState:SetScale(s, s, s)
end

return Prefab("kyno_fogbuster", flare_fn, assets, prefabs),
Prefab("kyno_fogbuster_launcher", launcher_fn, assets, prefabs),
MakePlacer("kyno_fogbuster_placer", "kyno_flarebuster2", "kyno_flarebuster2", "idle", false, nil, nil, nil, nil, nil, fogbusterplacerfn)