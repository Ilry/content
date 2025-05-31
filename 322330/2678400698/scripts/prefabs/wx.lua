require "prefabutil"

local assets =
{
    Asset("SOUND", "sound/wx78.fsb"),

    Asset("ANIM", "anim/player_idles_wx.zip"),
    Asset("ANIM", "anim/wx_upgrade.zip"),
    Asset("ANIM", "anim/player_mount_wx78_upgrade.zip"),
    Asset("ANIM", "anim/wx_fx.zip"),
    Asset("ANIM", "anim/ui_chest_3x3.zip"),

    Asset("ANIM", "anim/player_basic.zip"),
    Asset("ANIM", "anim/player_idles_shiver.zip"),
    Asset("ANIM", "anim/player_idles_lunacy.zip"),
    Asset("ANIM", "anim/player_actions.zip"),
    Asset("ANIM", "anim/player_actions_axe.zip"),
    Asset("ANIM", "anim/player_actions_pickaxe.zip"),
    Asset("ANIM", "anim/player_actions_pickaxe_recoil.zip"),
    Asset("ANIM", "anim/player_actions_shovel.zip"),
    Asset("ANIM", "anim/player_actions_blowdart.zip"),
    Asset("ANIM", "anim/player_actions_slingshot.zip"),
    Asset("ANIM", "anim/player_actions_eat.zip"),

    Asset("ANIM", "anim/player_actions_item.zip"),
    Asset("ANIM", "anim/player_cave_enter.zip"),
    Asset("ANIM", "anim/player_actions_uniqueitem.zip"),
    Asset("ANIM", "anim/player_actions_useitem.zip"),
    Asset("ANIM", "anim/player_actions_bugnet.zip"),
    Asset("ANIM", "anim/player_actions_unsaddle.zip"),
    Asset("ANIM", "anim/player_actions_fishing.zip"),
    Asset("ANIM", "anim/player_actions_fishing_ocean.zip"),
    Asset("ANIM", "anim/player_actions_fishing_ocean_new.zip"),
    Asset("ANIM", "anim/player_actions_pocket_scale.zip"),
    Asset("ANIM", "anim/player_actions_boomerang.zip"),
    Asset("ANIM", "anim/player_actions_whip.zip"),
    Asset("ANIM", "anim/player_actions_till.zip"),
    Asset("ANIM", "anim/player_actions_feast_eat.zip"),
    Asset("ANIM", "anim/player_actions_farming.zip"),
    Asset("ANIM", "anim/player_actions_cowbell.zip"),
    Asset("ANIM", "anim/player_actions_reversedeath.zip"),
    Asset("ANIM", "anim/player_actions_cannon.zip"),
    Asset("ANIM", "anim/player_actions_scythe.zip"),
    Asset("ANIM", "anim/player_actions_deploytoss.zip"),
    Asset("ANIM", "anim/player_actions_spray.zip"),

    Asset("ANIM", "anim/player_boat.zip"),
    Asset("ANIM", "anim/player_boat_plank.zip"),
    Asset("ANIM", "anim/player_oar.zip"),
    --Asset("ANIM", "anim/player_boat_hook.zip"), --Unfinished, bad file. For unused "fishingnet". Overwrites other anim states due to poor naming.
    Asset("ANIM", "anim/player_boat_net.zip"),
    Asset("ANIM", "anim/player_boat_sink.zip"),
    Asset("ANIM", "anim/player_boat_jump.zip"),

    Asset("ANIM", "anim/player_boat_jumpheavy.zip"),
    Asset("ANIM", "anim/player_boat_channel.zip"),
    Asset("ANIM", "anim/player_bush_hat.zip"),
    Asset("ANIM", "anim/player_attacks.zip"),
    --Asset("ANIM", "anim/player_idles.zip"),--Moved to global.lua for use in Item Collection
    Asset("ANIM", "anim/player_rebirth.zip"),
    Asset("ANIM", "anim/player_jump.zip"),
    Asset("ANIM", "anim/player_amulet_resurrect.zip"),
    Asset("ANIM", "anim/player_teleport.zip"),
    Asset("ANIM", "anim/player_abyss_fall.zip"),
    Asset("ANIM", "anim/wilson_fx.zip"),
    Asset("ANIM", "anim/player_one_man_band.zip"),
    Asset("ANIM", "anim/player_sit.zip"),
    Asset("ANIM", "anim/player_sit_nofaced.zip"),
    Asset("ANIM", "anim/player_sit_transition.zip"),
    --sitting emotes
    Asset("ANIM", "anim/player_sit_angry.zip"),
    Asset("ANIM", "anim/player_sit_facepalm.zip"),
    Asset("ANIM", "anim/player_sit_fistshake.zip"),
    Asset("ANIM", "anim/player_sit_flex.zip"),
    Asset("ANIM", "anim/player_sit_happy.zip"),
    Asset("ANIM", "anim/player_sit_kiss.zip"),
    Asset("ANIM", "anim/player_sit_laugh.zip"),
    Asset("ANIM", "anim/player_sit_no.zip"),
    Asset("ANIM", "anim/player_sit_rude.zip"),
    Asset("ANIM", "anim/player_sit_sad.zip"),
    Asset("ANIM", "anim/player_sit_sleepy.zip"),
    Asset("ANIM", "anim/player_sit_toast.zip"),
    Asset("ANIM", "anim/player_sit_wave.zip"),
    --

    Asset("ANIM", "anim/player_slurtle_armor.zip"),
    Asset("ANIM", "anim/player_staff.zip"),
    Asset("ANIM", "anim/player_cointoss.zip"),
    Asset("ANIM", "anim/player_spooked.zip"),
    Asset("ANIM", "anim/player_hit_darkness.zip"),
    Asset("ANIM", "anim/player_hit_spike.zip"),
    Asset("ANIM", "anim/player_lunge.zip"),
    Asset("ANIM", "anim/player_multithrust.zip"),
    Asset("ANIM", "anim/player_superjump.zip"),
    Asset("ANIM", "anim/player_attack_leap.zip"),
    Asset("ANIM", "anim/player_book_attack.zip"),
    Asset("ANIM", "anim/player_pocketwatch_portal.zip"),

    Asset("ANIM", "anim/player_parryblock.zip"),
    Asset("ANIM", "anim/player_attack_prop.zip"),
    Asset("ANIM", "anim/player_actions_reading.zip"),
    Asset("ANIM", "anim/player_strum.zip"),
    Asset("ANIM", "anim/player_frozen.zip"),
    Asset("ANIM", "anim/player_shock.zip"),
    Asset("ANIM", "anim/player_tornado.zip"),
    Asset("ANIM", "anim/goo.zip"),
    Asset("ANIM", "anim/shadow_hands.zip"),
    Asset("ANIM", "anim/player_wrap_bundle.zip"),
    Asset("ANIM", "anim/player_hideseek.zip"),
    Asset("ANIM", "anim/player_slip.zip"),
    Asset("ANIM", "anim/player_suspended.zip"),

    Asset("ANIM", "anim/player_wardrobe.zip"),
    Asset("ANIM", "anim/player_skin_change.zip"),
    Asset("ANIM", "anim/player_receive_gift.zip"),
    Asset("ANIM", "anim/shadow_skinchangefx.zip"),
    Asset("ANIM", "anim/player_townportal.zip"),
    Asset("ANIM", "anim/player_channel.zip"), --channeling scene entity
    Asset("ANIM", "anim/player_construct.zip"),
    Asset("SOUND", "sound/sfx.fsb"),
    --Asset("ANIM", "anim/player_ghost_withhat.zip"),--Moved to global.lua for use in Item Collection
    Asset("ANIM", "anim/player_revive_ghosthat.zip"),

    Asset("ANIM", "anim/player_revive_to_character.zip"),
    Asset("ANIM", "anim/player_revive_from_corpse.zip"),
    Asset("ANIM", "anim/player_knockedout.zip"),
    Asset("ANIM", "anim/player_emotesxl.zip"),
    Asset("ANIM", "anim/player_emotes_dance0.zip"),
    Asset("ANIM", "anim/player_emotes_sit.zip"),
    Asset("ANIM", "anim/player_emotes.zip"), -- item emotes
    Asset("ANIM", "anim/player_emote_extra.zip"), -- item emotes
    Asset("ANIM", "anim/player_emotes_dance2.zip"), -- item emotes
    Asset("ANIM", "anim/player_mount_emotes_extra.zip"), -- item emotes

    Asset("ANIM", "anim/player_mount_emotes_dance2.zip"), -- item emotes
    Asset("ANIM", "anim/player_mount_pet.zip"),
    Asset("ANIM", "anim/player_hatdance.zip"),
    Asset("ANIM", "anim/player_bow.zip"),
    Asset("ANIM", "anim/tears.zip"),
    Asset("ANIM", "anim/puff_spawning.zip"),
    Asset("ANIM", "anim/attune_fx.zip"),
    Asset("ANIM", "anim/player_idles_groggy.zip"),
    Asset("ANIM", "anim/player_groggy.zip"),
    Asset("ANIM", "anim/player_encumbered.zip"),
    Asset("ANIM", "anim/player_encumbered_fast.zip"),
    Asset("ANIM", "anim/player_encumbered_jump.zip"),
    Asset("ANIM", "anim/player_channelcast_basic.zip"), --channelcast using held item (can walk)
    Asset("ANIM", "anim/player_channelcast_hit.zip"),
    Asset("ANIM", "anim/player_channelcast_oh_basic.zip"), --channelcast using off-hand (can walk)
    Asset("ANIM", "anim/player_channelcast_oh_hit.zip"),
    Asset("ANIM", "anim/player_pushing.zip"),

    Asset("ANIM", "anim/player_sandstorm.zip"),
    Asset("ANIM", "anim/player_tiptoe.zip"),
    Asset("IMAGE", "images/colour_cubes/ghost_cc.tex"),
    Asset("IMAGE", "images/colour_cubes/mole_vision_on_cc.tex"),
    Asset("IMAGE", "images/colour_cubes/mole_vision_off_cc.tex"),
    Asset("ANIM", "anim/player_mount.zip"),
    Asset("ANIM", "anim/player_mount_travel.zip"),
    Asset("ANIM", "anim/player_mount_actions.zip"),
    Asset("ANIM", "anim/player_mount_actions_item.zip"),
    Asset("ANIM", "anim/player_mount_actions_boomerang.zip"),
    Asset("ANIM", "anim/player_mount_actions_reading.zip"),
    Asset("ANIM", "anim/player_mount_unique_actions.zip"),
    Asset("ANIM", "anim/player_mount_actions_useitem.zip"),
    Asset("ANIM", "anim/player_mount_one_man_band.zip"),
    Asset("ANIM", "anim/player_mount_boat_jump.zip"),
    Asset("ANIM", "anim/player_mount_boat_sink.zip"),
    Asset("ANIM", "anim/player_mount_blowdart.zip"),
    Asset("ANIM", "anim/player_mount_slingshot.zip"),
    Asset("ANIM", "anim/player_mount_shock.zip"),
    Asset("ANIM", "anim/player_mount_frozen.zip"),
    Asset("ANIM", "anim/player_mount_groggy.zip"),
    Asset("ANIM", "anim/player_mount_encumbered.zip"),

    Asset("ANIM", "anim/player_mount_sandstorm.zip"),
    Asset("ANIM", "anim/player_mount_hit_darkness.zip"),
    Asset("ANIM", "anim/player_mount_emotes.zip"),
    Asset("ANIM", "anim/player_mount_emotes_dance0.zip"),
    Asset("ANIM", "anim/player_mount_emotesxl.zip"),
    Asset("ANIM", "anim/player_mount_emotes_sit.zip"),
    Asset("ANIM", "anim/player_mount_bow.zip"),
    Asset("ANIM", "anim/player_mount_cointoss.zip"),
    Asset("ANIM", "anim/player_mount_hornblow.zip"),
    Asset("ANIM", "anim/player_mount_strum.zip"),
    Asset("ANIM", "anim/player_mount_deploytoss.zip"),

    Asset("ANIM", "anim/player_mighty_gym.zip"),
    Asset("ANIM", "anim/mighty_gym.zip"),

    Asset("ANIM", "anim/player_monkey_change.zip"),
    Asset("ANIM", "anim/player_monkey_run.zip"),

    Asset("ANIM", "anim/player_acting.zip"),
    Asset("ANIM", "anim/player_closeinspect.zip"),

    Asset("ANIM", "anim/player_attack_pillows.zip"),

    Asset("ANIM", "anim/player_shadow_thrall_parasite.zip"),
}

local prefabs =
{
    "brokentool",
    "frostbreath",
    "mining_fx",
    "mining_ice_fx",
    "mining_moonglass_fx",
    "die_fx",
    "ghost_transform_overlay_fx",
    "attune_out_fx",
    "attune_in_fx",
    "attune_ghost_in_fx",
    "staff_castinglight",
    "staff_castinglight_small",
    "staffcastfx",
    "staffcastfx_mount",
    "emote_fx",
    "tears",
    "shock_fx",
    "splash",
    "globalmapicon",
    "lavaarena_player_revive_from_corpse_fx",
    "superjump_fx",
    "washashore_puddle_fx",
    "spawnprotectionbuff",
    "battreefx",
    "impact",

    "cracklehitfx",
    "gears",
    "transistor",
    "trinket_6",
    "ice",
    "sparks",
    "wx78_big_spark",
    "wx78_heat_steam",
    "wx78_musicbox_fx",
    "collapse_small",
}

local WX78ModuleDefinitionFile = require("wx78_moduledefs")
local GetWX78ModuleByNetID = WX78ModuleDefinitionFile.GetModuleDefinitionFromNetID

local brain = require "brains/wxbrain"

local CHARGEREGEN_TIMERNAME = "chargeregenupdate"
local MOISTURETRACK_TIMERNAME = "moisturetrackingupdate"
local HEATSTEAM_TIMERNAME = "heatsteam_tick"
local CLEAR_COLLISION_TIMERNAME = "CLEARCOLLISION"
local COLLISION_DEAMON_TIMERNAM = "COLLISIONDEAMON"
local RESTORE_COLLISION_TIMERNAME = "RESTORECOLLISION"

local FIND_BLOCKER_ONE_OF_TAGS = { "structure", "wall", "fence" }
local function oncollide(inst, other)
    if not (other ~= nil and other:IsValid() and inst:IsValid()) then
        return
    end

    if other:HasOneOfTags(FIND_BLOCKER_ONE_OF_TAGS) and inst.components.locomotor:WantsToMoveForward() then
        if not inst.components.timer:TimerExists(CLEAR_COLLISION_TIMERNAME) then
            inst.components.timer:StartTimer(CLEAR_COLLISION_TIMERNAME, 1)
        end

        if inst.components.timer:TimerExists(COLLISION_DEAMON_TIMERNAM) then
            inst.components.timer:SetTimeLeft(COLLISION_DEAMON_TIMERNAM, 0.5)
        else
            inst.components.timer:StartTimer(COLLISION_DEAMON_TIMERNAM, 0.5)
        end
    end
end

----------------------
-- Trade Management --
----------------------
local function ShouldAcceptItem(inst, item)
    return item.components.equippable ~= nil
end

local function DropOutdatedItem(inst, new_item, old_item)
    local inventory = inst.components.inventory
    if old_item == nil or old_item.prefab ~= new_item.prefab then
        inst.components.talker:Say(GetString(inst, "ANNOUNCE_EQUIP", "ACCEPT"))
        if new_item.components.equippable.equipslot == EQUIPSLOTS.HEAD then
            local tool = inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local coat = inventory:GetEquippedItem(EQUIPSLOTS.BODY)
            if new_item.prefab == "deserthat" or new_item.prefab == "captainhat" then
                if tool ~= nil and tool.prefab ~= "compass" then
                    inventory:DropItem(tool, true, true)
                end
                if coat ~= nil and coat.components.container == nil then
                    inventory:DropItem(coat, true, true)
                end
            else
                inventory:DropItem(tool, true, true)
                inventory:DropItem(coat, true, true)
                inventory:DropEverything(false, true)
            end
        end
    end
end

local function OnEquipmentChanged(inst)
    -- Cancel outdated buffered actions and behaviors
    if inst.brain ~= nil and inst.brain.bt ~= nil then
        inst.brain.bt:Reset()
    end
    inst.components.locomotor:Stop()

    inst.components.wxnavigation.engaged = false
    if inst.components.wxtype:IsConv() then
        inst.components.entitytracker:ForgetEntity("sentryward")
    elseif inst.components.wxtype:IsSeaConv() then
        inst.components.entitytracker:ForgetEntity("shipyard")
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    if giver ~= nil and giver.components.inventory ~= nil and item ~= nil and item.components.equippable ~= nil then
        local wx_inventory = inst.components.inventory
        local giver_inventory = giver.components.inventory
        for k, v in pairs(wx_inventory.opencontainers) do
            k.components.container:Close(inst)
        end
        inst.components.container:Close()

        local eslot = item.components.equippable.equipslot
        local equipped_item = wx_inventory:GetEquippedItem(eslot)
        DropOutdatedItem(inst, item, equipped_item)

        if equipped_item ~= nil and equipped_item.prefab == item.prefab and equipped_item.skinname == item.skinname and
            equipped_item.components.stackable ~= nil and wx_inventory:AcceptsStacks() then
            wx_inventory:Equip(item, false, eslot)
        else
            if equipped_item ~= nil then
                equipped_item = wx_inventory:Unequip(eslot)
                giver_inventory:GiveActiveItem(equipped_item)
            end
            wx_inventory:Equip(item, false, eslot)
        end

        OnEquipmentChanged(inst)
    end
end

local function OnRefuseItem(inst, item)
    inst.components.talker:Say(GetString(inst, "ANNOUNCE_EQUIP", "REFUSE"))
end

------------------------
-- Storage Management --
------------------------
local containers = require("containers")
local params = containers.params
params.wx = {
    widget = {
        slotpos = {},
        animbank = "ui_tacklecontainer_3x5",
        animbuild = "ui_tacklecontainer_3x5",
        pos = Vector3(-240, 80, 0),
        buttoninfo = {
            text = "Backpack",
            position = Vector3(0, -350, 0),
        }
    },
    type = "wx",
    openlimit = 1,
}

for y = 1, -3, -1 do
    for x = 0, 2 do
        table.insert(params.wx.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 45, 0))
    end
end

function params.wx.widget.buttoninfo.fn(inst, doer)
    if inst.components.inventory ~= nil then
        BufferedAction(doer, inst, ACTIONS.TOGGLEAUGMENT):Do()
    elseif inst.replica.inventory ~= nil then
        SendRPCToServer(RPC.DoWidgetButtonAction, ACTIONS.TOGGLEAUGMENT.code, inst, ACTIONS.TOGGLEAUGMENT.mod_name)
    end
end

-- Original code is from "WX Automation Patch" by wiefean.
-- https://steamcommunity.com/sharedfiles/filedetails/?id=3385430772

local function OnWXEquipedFn(doer, target, data)
    if doer.player_classified ~= nil and doer.player_classified.wxequipwidget ~= nil and doer.player_classified.wxequipwidget[data.eslot] and
        data.item and data.item.components.equippable and not data.item.components.equippable:IsRestricted(target) then
        if data.item.Network ~= nil then
            data.item.Network:SetClassifiedTarget(doer)
        end
        doer.player_classified.wxequipwidget[data.eslot]:set(data.item)
    end
end

local function OnWXUnequipedFn(doer, target, data)
    if doer.player_classified.wxequipwidget ~= nil and doer.player_classified.wxequipwidget[data.eslot] ~= nil and
        data.item ~= nil and data.item.components.equippable ~= nil then
        if data.item.Network ~= nil then
            data.item.Network:SetClassifiedTarget(nil)
        end
        doer.player_classified.wxequipwidget[data.eslot]:set(nil)
    end
end

local function ShowEquipBar(doer, target)
    if doer.player_classified ~= nil and doer.player_classified.wxequipwidget ~= nil then
        doer.player_classified.wxequipwidget["isvisible"]:set(true)
        doer.player_classified.wxequipwidget["target"]:set(target)

        if target.components.inventory ~= nil then
            for _, eslot in pairs(EQUIPSLOTS) do
                if doer.player_classified.wxequipwidget[eslot] ~= nil then
                    if target.replica.inventory ~= nil and target.replica.inventory.classified ~= nil then
                        target.replica.inventory.classified.Network:SetClassifiedTarget(doer)
                    end
                    local item = target.components.inventory:GetEquippedItem(eslot)
                    if item ~= nil and item.components.inventoryitem ~= nil then
                        item.components.inventoryitem:SetOwner(doer)
                    end
                    doer.player_classified.wxequipwidget[eslot]:set(item)

                    if item ~= nil then
                        if item.components.armor ~= nil then
                            item:PushEvent("percentusedchange", { percent = item.components.armor:GetPercent() })
                        end
                        if item.components.finiteuses ~= nil then
                            item:PushEvent("percentusedchange", { percent = item.components.finiteuses:GetPercent() })
                        end
                        if item.components.fueled ~= nil then
                            item:PushEvent("percentusedchange", { percent = item.components.fueled:GetPercent() })
                        end
                        if item.components.perishable ~= nil then
                            item:PushEvent("perishchange", { percent = item.components.perishable:GetPercent() })
                        end
                        --if item.components.rechargeable ~= nil then
                            --item:PushEvent("rechargechange", { percent = item.components.rechargeable:GetPercent() })
                        --end
                    end
                end
            end
        end
    end

    if doer.OnWXEquiped == nil then
        doer.OnWXEquiped = function(target, data) OnWXEquipedFn(doer, target, data) end
    end
    if doer.OnWXUnequiped == nil then
        doer.OnWXUnequiped = function(target, data) OnWXUnequipedFn(doer, target, data) end
    end

    doer:ListenForEvent("equip", doer.OnWXEquiped, target)
    doer:ListenForEvent("unequip", doer.OnWXUnequiped, target)
end

local function HideEquipBar(doer, target)
    if doer.player_classified ~= nil and doer.player_classified.wxequipwidget ~= nil then
        doer.player_classified.wxequipwidget["isvisible"]:set(false)
        doer.player_classified.wxequipwidget["target"]:set(nil)

        for _, eslot in pairs(EQUIPSLOTS) do
            if doer.player_classified.wxequipwidget[eslot] ~= nil then
                if target.replica.inventory ~= nil and target.replica.inventory.classified ~= nil then
                    target.replica.inventory.classified.Network:SetClassifiedTarget(target.replica.inventory.classified)
                end
                local item = target.components.inventory:GetEquippedItem(eslot)
                if item ~= nil and item.components.inventoryitem ~= nil then
                    item.components.inventoryitem:SetOwner(target)
                end
                doer.player_classified.wxequipwidget[eslot]:set(nil)
            end
        end
    end

    if doer.OnWXEquiped ~= nil then
        doer:RemoveEventCallback("equip", doer.OnWXEquiped, target)
    end
    if doer.OnWXUnequiped ~= nil then
        doer:RemoveEventCallback("unequip", doer.OnWXUnequiped, target)
    end
end

local function OnOpen(inst, data)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
    if data == nil or data.doer == nil or not (data.doer:HasTag("player") or data.doer:HasTag("wx")) then
        return
    end

    inst.components.wxnavigation.noreceiver = false
    inst.brain:Pause()
    inst.components.locomotor:Stop()

    local backpack = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack ~= nil and backpack.components.container ~= nil then
        local playerbackpack = data.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        if playerbackpack ~= nil and playerbackpack.components.container ~= nil and
            playerbackpack.components.container:IsOpenedBy(data.doer) then
            playerbackpack.components.container:Close(data.doer)
            data.doer:PushEvent("closecontainer", { container = playerbackpack })
        end
        if backpack.components.container:IsOpenedByOthers(data.doer) then
            for _, opener in pairs(backpack.components.container:GetOpeners()) do
                if opener ~= data.doer then
                    backpack.components.container:Close(opener)
                    opener:PushEvent("closecontainer", { container = backpack })
                end
            end
        end
        backpack.Network:SetClassifiedTarget(data.doer)
        if backpack.components.container:IsOpenedBy(inst) then
            backpack.components.container:Close(inst)
            inst:PushEvent("closecontainer", { container = backpack })
        end
        if not backpack.components.container:IsOpenedBy(data.doer) then
            backpack.components.container:Open(data.doer)
            data.doer:PushEvent("opencontainer", { container = backpack })
        end
    end

    if data.doer and data.doer:HasTag("player") then
        ShowEquipBar(data.doer, inst)
    end
end

local function OnClose(inst, doer)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
    if doer == nil or not (doer:HasTag("player") or doer:HasTag("wx")) then
        return
    end

    inst.components.wxnavigation.noreceiver = false
    inst.brain.bt:Reset()
    inst.brain:Resume()

    local backpack = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if backpack ~= nil and backpack.components.container ~= nil then
        if backpack.components.container:IsOpenedBy(doer) then
            backpack.components.container:Close(doer)
            doer:PushEvent("closecontainer", { container = backpack })
        end
        if not backpack.components.container:IsOpenedBy(inst) then
            backpack.components.container:Open(inst)
            inst:PushEvent("opencontainer", { container = backpack })
        end
        backpack.Network:SetClassifiedTarget(nil)
        local playerbackpack = doer.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
        if playerbackpack ~= nil and playerbackpack.components.container ~= nil and
            not playerbackpack.components.container:IsOpenedBy(doer) then
            playerbackpack.components.container:Open(doer)
            doer:PushEvent("opencontainer", { container = playerbackpack })
        end
    end

    if doer and doer:HasTag("player") then
        HideEquipBar(doer, inst)
    end
end

--------------------------
-- Equipment Management --
--------------------------
local function OnWeaponBroke(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if (weapon == nil or weapon:IsInLimbo()) and (inst.brain ~= nil and inst.brain.bt ~= nil) then
        inst.brain.bt:Reset()
    end
end

local function OnArmorBroke(inst)
    local helmet = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
    local armor = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BODY)
    if (helmet == nil or helmet:IsInLimbo()) and (armor == nil or armor:IsInLimbo()) and
        (inst.brain ~= nil and inst.brain.bt ~= nil) then
        inst.brain.bt:Reset()
    end
end

local function OnWeaponFired(inst)
    local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
    if (weapon.prefab == "spear_launcher" or weapon.prefab == "blunderbuss") and
        (inst.brain ~= nil and inst.brain.bt ~= nil) then
        inst.brain.bt:Reset()
    end
end

-----------------------
-- Riding Management --
-----------------------
local function OnDismount(inst)
    inst.components.combat:GiveUp()
    inst.components.locomotor:Stop()
end

local function OnBucked(inst)
    inst.components.combat:GiveUp()
end

-----------------------
-- Combat Management --
-----------------------
local NO_AGGRO_TAGS = { "player", "wx", "companion", "ghost", "shadowcreature", "nightmarecreature", "wall", "fence" }

local function IsFriendlyAutomaton(inst)
    return inst:HasTag("wx") or inst:HasTag("wxfriend") or
        (inst:HasTag("chess") and (inst:HasTag("guarding") or
        (inst.components.follower ~= nil and
        inst.components.follower:GetLeader() ~= nil)))
end

local function _ShareTargetFn(dude)
    return IsFriendlyAutomaton(dude)
end

local MAX_TARGET_SHARES = 5
local SHARE_TARGET_DIST = 30
local function OnAttacked(inst, data)
    local inventory = inst.components.inventory
    if inventory ~= nil then
        for k, v in pairs(inventory.opencontainers) do
            k.components.container:Close(inst)
        end
    end

    local attacker = data ~= nil and data.attacker or nil
    if attacker ~= nil and IsFriendlyAutomaton(attacker) then
        return
    end
    inst.components.combat:SuggestTarget(attacker)
    inst.components.combat:ShareTarget(attacker, SHARE_TARGET_DIST, _ShareTargetFn, MAX_TARGET_SHARES)

    if inst.components.wxtype:IsMili() and inst.brain ~= nil and inst.brain.bt ~= nil then
        inst.brain.bt:Reset()
    end

    inst.components.talker:Say(GetString(inst, "ANNOUNCE_DAMAGED"))
end

local RETARGET_MUST_TAGS = { "_combat", "_health" }
local RETARGET_CANT_TAGS = { "player", "abigail", "playerghost", "ghost", "shadowcreature", "nightmarecreature", "wx", "INLIMBO" }
local SEE_WORK_DIST = TUNING.WXAUTOMATION.SEE_WORK_DIST
local function retargetfn(inst)
    local leader = inst.components.follower:GetLeader()
    if leader ~= nil then
        return FindEntity(leader, TUNING.SHADOWWAXWELL_TARGET_DIST, function(guy)
            local guycombat = guy.components.combat
            return guy ~= inst and inst.components.combat:CanTarget(guy) and not IsFriendlyAutomaton(guy) and
                ((leader.components.combat ~= nil and leader.components.combat:TargetIs(guy)) or
                (guycombat ~= nil and guycombat.target ~= nil and
                (guycombat:TargetIs(leader) or IsFriendlyAutomaton(guycombat.target)) and
                (guy.components.follower == nil or guy.components.follower:GetLeader() == nil or
                not guy.components.follower:GetLeader():HasTag("player"))))
        end, RETARGET_MUST_TAGS, RETARGET_CANT_TAGS) or nil
    else
        return FindEntity(inst, SEE_WORK_DIST, function(guy)
            local guycombat = guy.components.combat
            return inst.components.combat:CanTarget(guy) and not IsFriendlyAutomaton(guy) and
                guycombat ~= nil and guycombat.target ~= nil and
                (guycombat.target:HasTag("player") or IsFriendlyAutomaton(guycombat.target)) and
                (guy.components.follower == nil or guy.components.follower:GetLeader() == nil or
                not guy.components.follower:GetLeader():HasTag("player"))
        end, RETARGET_MUST_TAGS, RETARGET_CANT_TAGS) or nil
    end
end

local KEEP_WORKING_DIST = SEE_WORK_DIST + 6
local function keeptargetfn(inst, target)
    return inst.components.follower.leader == nil or
        (inst.components.follower.leader ~= nil and inst.components.follower:IsNearLeader(KEEP_WORKING_DIST)) and
        inst.components.combat:CanTarget(target) and
        target.components.minigame_participator == nil
end

---------------------------
-- Hull Point Management --
---------------------------
local function OnRepaired(inst)
    inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
    inst.components.talker:Say(GetString(inst, "ANNOUNCE_REPAIRED"))
end

local function OnLightningStrike(inst)
    if inst.components.health ~= nil and not (inst.components.health:IsDead() or inst.components.health:IsInvincible()) then
        if inst.components.inventory:IsInsulated() then
            inst:PushEvent("lightningdamageavoided")
        else
            inst.components.health:DoDelta(TUNING.HEALING_SUPERHUGE, false, "lightning")
            --inst.components.talker:Say(GetString(inst, "ANNOUNCE_CHARGE"))

            inst.components.upgrademoduleowner:AddCharge(1)
        end
    end
end

-- Wetness/Moisture/Rain ---------------------------------------------------------------
local function inSine(t, b, c, d)
  return -c * math.cos(t / d * (math.pi / 2)) + c + b
end

local function initiate_moisture_update(inst)
    if not inst.components.timer:TimerExists(MOISTURETRACK_TIMERNAME) then
        inst.components.timer:StartTimer(MOISTURETRACK_TIMERNAME, TUNING.WX78_MOISTUREUPDATERATE*FRAMES)
    end
end

local function stop_moisturetracking(inst)
    inst.components.timer:StopTimer(MOISTURETRACK_TIMERNAME)

    inst._moisture_steps = 0
end

local function moisturetrack_update(inst)
    local current_moisture = inst.components.moisture:GetMoisture()
    if current_moisture > TUNING.WX78_MINACCEPTABLEMOISTURE then
        -- The update will loop until it is stopped by going under the acceptable moisture level.
        initiate_moisture_update(inst)
    end

    if inst:HasTag("moistureimmunity") or (inst.components.inventory.isexternallyinsulated ~= nil and
        inst.components.inventory.isexternallyinsulated:Get()) then
        return
    end

    inst._moisture_steps = inst._moisture_steps + 1

    local x, y, z = inst.Transform:GetWorldPosition()
    SpawnPrefab("sparks").Transform:SetPosition(x, y + 1 + math.random() * 1.5, z)

    if inst._moisture_steps >= TUNING.WX78_MOISTURESTEPTRIGGER then
        local damage_per_second = inSine(
                current_moisture - TUNING.WX78_MINACCEPTABLEMOISTURE,
                TUNING.WX78_MIN_MOISTURE_DAMAGE,
                TUNING.WX78_PERCENT_MOISTURE_DAMAGE,
                inst.components.moisture:GetMaxMoisture() - TUNING.WX78_MINACCEPTABLEMOISTURE
        )
        local seconds_per_update = TUNING.WX78_MOISTUREUPDATERATE / 30

        local damage_total = math.max(inst._moisture_steps * seconds_per_update * damage_per_second,
            math.min(.8 * inst.components.health.maxhealth - inst.components.health.currenthealth, 0))

        inst.components.health:DoDelta(damage_total, false, "water")
        inst.components.upgrademoduleowner:AddCharge(-1)
        inst._moisture_steps = 0

        SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)

        --inst.sg:GoToState("hit")
    end
end

local function OnWetnessChanged(inst, data)
    if not (inst.components.health ~= nil and inst.components.health:IsDead()) then
        if data.new >= TUNING.WX78_COLD_ICEMOISTURE and inst.components.upgrademoduleowner:GetModuleTypeCount("cold") > 0 then
            inst.components.moisture:SetMoistureLevel(0)

            local x, y, z = inst.Transform:GetWorldPosition()
            for i = 1, TUNING.WX78_COLD_ICECOUNT do
                local ice = SpawnPrefab("ice")
                ice.Transform:SetPosition(x, y, z)
                Launch(ice, inst)
            end

            stop_moisturetracking(inst)
        elseif data.new > TUNING.WX78_MINACCEPTABLEMOISTURE and data.old <= TUNING.WX78_MINACCEPTABLEMOISTURE then
            initiate_moisture_update(inst)
        elseif data.new <= TUNING.WX78_MINACCEPTABLEMOISTURE and data.old > TUNING.WX78_MINACCEPTABLEMOISTURE then
            stop_moisturetracking(inst)
        end
    end
end

-------------------------------
-- Upgrade Module Management --
-------------------------------
local function do_chargeregen_update(inst)
    if not inst.components.upgrademoduleowner:ChargeIsMaxed() then
        inst.components.upgrademoduleowner:AddCharge(1)
    end
end

local function OnUpgradeModuleChargeChanged(inst, data)
    -- The regen timer gets reset every time the energy level changes, whether it was by the regen timer or not.
    inst.components.timer:StopTimer(CHARGEREGEN_TIMERNAME)

    if not inst.components.upgrademoduleowner:ChargeIsMaxed() then
        inst.components.timer:StartTimer(CHARGEREGEN_TIMERNAME, TUNING.WX78_CHARGE_REGENTIME)

        -- If we just got put to 0 from a non-0 value, tell the player.
        if data.old_level ~= 0 and data.new_level == 0 then
            inst.components.talker:Say(GetString(inst, "ANNOUNCE_DISCHARGE"))
        end
    else
        -- If our charge is maxed (this is a post-assignment callback), and our previous charge was not,
        -- we just hit the max, so tell the player.
        if data.old_level ~= inst.components.upgrademoduleowner.max_charge then
            inst.components.talker:Say(GetString(inst, "ANNOUNCE_CHARGE"))
        end
    end
end

local function on_charge_level_changed(self, new_charge, old_charge)
    if self.inst.currentenergylevel ~= nil then
        self.inst.currentenergylevel:set(new_charge)
    end
end

----------------------------------------------------------------
local function CLIENT_GetEnergyLevel(inst)
    if inst.components.upgrademoduleowner ~= nil then
        return inst.components.upgrademoduleowner.charge_level
    elseif inst.currentenergylevel ~= nil then
        return inst.currentenergylevel:value()
    else
        return 0
    end
end

local function get_plugged_module_indexes(inst)
    local upgrademodule_defindexes = {}
    for _, module in ipairs(inst.components.upgrademoduleowner.modules) do
        table.insert(upgrademodule_defindexes, module._netid)
    end

    -- Fill out the rest of the table with 0s
    while #upgrademodule_defindexes < TUNING.WX78_MAXELECTRICCHARGE do
        table.insert(upgrademodule_defindexes, 0)
    end

    return upgrademodule_defindexes
end

--local DEFAULT_ZEROS_MODULEDATA = {0, 0, 0, 0, 0, 0}
local DEFAULT_ZEROS_MODULEDATA = {}
for netvar_index = 1, TUNING.WX78_MAXELECTRICCHARGE do
    table.insert(DEFAULT_ZEROS_MODULEDATA, 0)
end
local function CLIENT_GetModulesData(inst)
    local data = nil

    if inst.components.upgrademoduleowner ~= nil then
        data = get_plugged_module_indexes(inst)
    elseif inst.upgrademodules ~= nil then
        data = {}
        for _, module_netvar in ipairs(inst.upgrademodules) do
            table.insert(data, module_netvar:value())
        end
    else
        data = DEFAULT_ZEROS_MODULEDATA
    end

    return data
end

local function CLIENT_GetDisplayNameWithEnergyLevelAndModulesData(inst)
    local displayname = inst:GetWXDisplayName()
    local energyleveldata = CLIENT_GetEnergyLevel(inst)
    displayname = displayname .. " " .. tostring(energyleveldata) .. "/" .. tostring(TUNING.WX78_MAXELECTRICCHARGE)
    local modulesdata = CLIENT_GetModulesData(inst)
    local module_prefabs = {}
    for _, module_netid in ipairs(modulesdata) do
        if module_netid > 0 and GetWX78ModuleByNetID(module_netid) ~= nil then
            if table.containskey(module_prefabs, GetWX78ModuleByNetID(module_netid).name) then
                module_prefabs[GetWX78ModuleByNetID(module_netid).name] = module_prefabs[GetWX78ModuleByNetID(module_netid).name] + 1
            else
                module_prefabs[GetWX78ModuleByNetID(module_netid).name] = 1
            end
        end
    end
    for module_prefab, counts in pairs(module_prefabs) do
        displayname = displayname.."\n"..STRINGS.NAMES[string.upper("wx78module_"..module_prefab)].." x"..tostring(counts)
    end
    return displayname
end

local function CLIENT_CanUpgradeWithModule(inst, module_prefab)
    if module_prefab == nil then
        return false
    end

    local slots_inuse = (module_prefab._slots or 0)

    if inst.components.upgrademoduleowner ~= nil then
        for _, module in ipairs(inst.components.upgrademoduleowner.modules) do
            local modslots = (module.components.upgrademodule ~= nil and module.components.upgrademodule.slots)
                or 0
            slots_inuse = slots_inuse + modslots
        end
    elseif inst.upgrademodules ~= nil then
        for _, module_netvar in ipairs(inst.upgrademodules) do
            local module_definition = GetWX78ModuleByNetID(module_netvar:value())
            if module_definition ~= nil then
                slots_inuse = slots_inuse + module_definition.slots
            end
        end
    else
        return false
    end

    return (TUNING.WX78_MAXELECTRICCHARGE - slots_inuse) >= 0
end

local function CLIENT_CanRemoveModules(inst)
    if inst.components.upgrademoduleowner ~= nil then
        return inst.components.upgrademoduleowner:NumModules() > 0
    elseif inst.upgrademodules ~= nil then
        -- Assume that, if the first module slot netvar is 0, we have no modules.
        return inst.upgrademodules[1]:value() ~= 0
    else
        return false
    end
end

----------------------------------------------------------------
local function OnUpgradeModuleAdded(inst, moduleent)
    local slots_for_module = moduleent.components.upgrademodule.slots
    inst._chip_inuse = inst._chip_inuse + slots_for_module

    local upgrademodule_defindexes = get_plugged_module_indexes(inst)

    inst:PushEvent("upgrademodulesdirty", upgrademodule_defindexes)
    if inst.upgrademodules ~= nil then
        local newmodule_index = inst.components.upgrademoduleowner:NumModules()
        inst.upgrademodules[newmodule_index]:set(moduleent._netid or 0)
    end
end

local function OnUpgradeModuleRemoved(inst, moduleent)
    inst._chip_inuse = inst._chip_inuse - moduleent.components.upgrademodule.slots

    -- If the module has 1 use left, it's about to be destroyed, so don't return it to the inventory.
    if moduleent.components.finiteuses == nil or moduleent.components.finiteuses:GetUses() > 1 then
        if moduleent.components.inventoryitem ~= nil and inst.components.inventory ~= nil then
            inst.components.inventory:GiveItem(moduleent, nil, inst:GetPosition())
        end
    end
end

local function OnOneUpgradeModulePopped(inst, moduleent)
    inst:PushEvent("upgrademodulesdirty", get_plugged_module_indexes(inst))
    if inst.upgrademodules ~= nil then
        -- This is a callback of the remove, so our current NumModules should be
        -- 1 lower than the index of the module that was just removed.
        local top_module_index = inst.components.upgrademoduleowner:NumModules() + 1
        inst.upgrademodules[top_module_index]:set(0)
    end
end

local function OnAllUpgradeModulesRemoved(inst)
    SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)

    inst:PushEvent("upgrademoduleowner_popallmodules")

    --[[if inst.upgrademodules ~= nil then
        inst.upgrademodules[1]:set(0)
        inst.upgrademodules[2]:set(0)
        inst.upgrademodules[3]:set(0)
        inst.upgrademodules[4]:set(0)
        inst.upgrademodules[5]:set(0)
        inst.upgrademodules[6]:set(0)
    end]]
    if inst.upgrademodules ~= nil then
        for _, module_netvar in ipairs(inst.upgrademodules) do
            module_netvar:set(0)
        end
    end
end

local function CanUseUpgradeModule(inst, moduleent)
    if (TUNING.WX78_MAXELECTRICCHARGE - inst._chip_inuse) < moduleent.components.upgrademodule.slots then
        return false, "NOTENOUGHSLOTS"
    else
        return true
    end
end

----------------------------------------------------------------------------------------

local function OnFrozen(inst)
    if inst.components.freezable == nil or not inst.components.freezable:IsFrozen() then
        SpawnPrefab("wx78_big_spark"):AlignToTarget(inst)

        if not inst.components.upgrademoduleowner:IsChargeEmpty() then
            inst.components.upgrademoduleowner:AddCharge(-TUNING.WX78_FROZEN_CHARGELOSS)
        end
    end
end

----------------------------------------------------------------------------------------
local HEATSTEAM_TICKRATE = 5
local function do_steam_fx(inst)
    local steam_fx = SpawnPrefab("wx78_heat_steam")
    steam_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    steam_fx.Transform:SetRotation(inst.Transform:GetRotation())

    inst.components.timer:StartTimer(HEATSTEAM_TIMERNAME, HEATSTEAM_TICKRATE)
end

-- Negative is colder, positive is warmer
local function AddTemperatureModuleLeaning(inst, leaning_change)
    inst._temperature_modulelean = inst._temperature_modulelean + leaning_change

    if inst._temperature_modulelean > 0 then
        inst.components.heater:SetThermics(true, false)

        if not inst.components.timer:TimerExists(HEATSTEAM_TIMERNAME) then
            inst.components.timer:StartTimer(HEATSTEAM_TIMERNAME, HEATSTEAM_TICKRATE, false, 0.5)
        end

        --inst.components.frostybreather:ForceBreathOff()
    elseif inst._temperature_modulelean == 0 then
        inst.components.heater:SetThermics(false, false)

        inst.components.timer:StopTimer(HEATSTEAM_TIMERNAME)

        --inst.components.frostybreather:ForceBreathOff()
    else
        inst.components.heater:SetThermics(false, true)

        inst.components.timer:StopTimer(HEATSTEAM_TIMERNAME)

        --inst.components.frostybreather:ForceBreathOn()
    end
end

local function ModuleBasedPreserverRateFn(inst, item)
    return (inst._temperature_modulelean > 0 and TUNING.WX78_PERISH_HOTRATE)
        or (inst._temperature_modulelean < 0 and TUNING.WX78_PERISH_COLDRATE)
        or 1
end

local function GetThermicTemperatureFn(inst, observer)
    return inst._temperature_modulelean * TUNING.WX78_HEATERTEMPPERMODULE
end

-----------------------
-- Timing Management --
-----------------------
local function OnTimerFinished(inst, data)
    if data.name == MOISTURETRACK_TIMERNAME then
        moisturetrack_update(inst)
    elseif data.name == CHARGEREGEN_TIMERNAME then
        do_chargeregen_update(inst)
    elseif data.name == HEATSTEAM_TIMERNAME then
        do_steam_fx(inst)
    elseif data.name == CLEAR_COLLISION_TIMERNAME then
        inst.Physics:ClearCollidesWith(COLLISION.OBSTACLES)
        inst.Physics:ClearCollidesWith(COLLISION.SMALLOBSTACLES)
        if inst.components.timer:TimerExists(RESTORE_COLLISION_TIMERNAME) then
            inst.components.timer:SetTimeLeft(RESTORE_COLLISION_TIMERNAME, 2)
        else
            inst.components.timer:StartTimer(RESTORE_COLLISION_TIMERNAME, 2)
        end
    elseif data.name == COLLISION_DEAMON_TIMERNAM then
        inst.components.timer:StopTimer(CLEAR_COLLISION_TIMERNAME)
    elseif data.name == RESTORE_COLLISION_TIMERNAME then
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    end
end

------------------------------
-- Storm Watcher Management --
------------------------------
local function UpdateSandstormWalkSpeed_Internal(self, level)
    if level and self.sandstormspeedmult < 1 then
        if level < TUNING.SANDSTORM_FULL_LEVEL or
            self.inst.components.inventory:EquipHasTag("goggles") or
            self.inst.components.rider:IsRiding() then
            self.inst.components.locomotor:RemoveExternalSpeedMultiplier(self.inst, "sandstorm")
        else
            self.inst.components.locomotor:SetExternalSpeedMultiplier(self.inst, "sandstorm", self.sandstormspeedmult)
        end
    end
end

local function UpdateMoonstormWalkSpeed_Internal(self, level)
    if level and self.moonstormspeedmult < 1 then
        if level < TUNING.SANDSTORM_FULL_LEVEL or
            self.inst.components.inventory:EquipHasTag("goggles") or
            self.inst.components.rider:IsRiding() then
            self.inst.components.locomotor:RemoveExternalSpeedMultiplier(self.inst, "moonstorm")
        else
            self.inst.components.locomotor:SetExternalSpeedMultiplier(self.inst, "moonstorm", self.moonstormspeedmult)
        end
    end
end

local function UpdateMiasmaWalkSpeed(self)
    if self.miasmaspeedmult < 1 then
        if not self.hasmiasmasource:Get() or
        self.inst.components.inventory:EquipHasTag("goggles") or
            self.inst.components.rider:IsRiding() then
            self.inst.components.locomotor:RemoveExternalSpeedMultiplier(self.inst, "miasma")
        else
            self.inst.components.locomotor:SetExternalSpeedMultiplier(self.inst, "miasma", self.miasmaspeedmult)
        end
    end
end

-----------------------
-- Outfit Management --
-----------------------
local function ApplyWXSkins(target, doer, skins)
    if skins ~= nil and skins.base ~= nil and target.components.skinner ~= nil then
        target.AnimState:AssignItemSkins(doer.userid, skins.base or "", skins.body or "", skins.hand or "", skins.legs or "", skins.feet or "")
        target.components.skinner:ClearAllClothing()
        target.AnimState:SetBuild(doer.AnimState:GetBuild())
        local skin_data = {}
        if skins.base ~= "" then
            local skin_prefab = Prefabs[skins.base] or nil
            if skin_prefab and skin_prefab.skins then
                for k, v in pairs(skin_prefab.skins) do
                    skin_data[k] = v
                end
            end
        end
        if skin_data.normal_skin ~= nil then
            target.components.skinner:SetSkinName(skins.base)
            target.components.skinner:SetClothing(skins.body)
            target.components.skinner:SetClothing(skins.hand)
            target.components.skinner:SetClothing(skins.legs)
            target.components.skinner:SetClothing(skins.feet)
        end

        local charactername = string.gmatch(skins.base, "[^_]+")()
        if charactername == nil then
            charactername = "wx78"
        end
        target.MiniMapEntity:SetIcon(charactername..".png")
        target.soundsname = doer.soundsname or charactername

        target:PushEvent("dressedup", { wardrobe = target, doer = doer, skins = skins })
    end
end

local function ActivateChanging(self, doer, skins)
    if skins == nil or
        next(skins) == nil or
        doer.sg.currentstate.name ~= "openwardrobe" or
        doer.components.skinner == nil then
        return false
    elseif self.canbedressed then
        doer.sg.statemem.ischanging = true
        doer.sg:GoToState("dressupwardrobe", function()
            if self.ondressupfn ~= nil then
                self.ondressupfn(self.inst, function() ApplyWXSkins(self.inst, doer, skins) end)
            else
                ApplyWXSkins(self.inst, doer, skins)
            end
        end)
        return true
    end
end

local function BeginChanging(self, doer)
    if not self.changers[doer] then
        local wasclosed = next(self.changers) == nil

        self.changers[doer] = true

        self.inst:ListenForEvent("onremove", self.onclosewardrobe, doer)
        self.inst:ListenForEvent("ms_closepopup", self.onclosepopup, doer)

        if doer.sg.currentstate.name == "opengift" then
            doer.sg.statemem.isopeningwardrobe = true
            doer.sg:GoToState("openwardrobe", { openinggift = true, target = doer })
        else
            doer.sg:GoToState("openwardrobe", { openinggift = false, target = doer })
        end

        if wasclosed then
            self.inst:StartUpdatingComponent(self)

            if self.onopenfn ~= nil then
                self.onopenfn(self.inst)
            end
        end
        return true
    end
    return false
end

local function ondressupfn(inst, cb)
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("none")

    if cb ~= nil then
        inst:DoTaskInTime(6*FRAMES, function() cb() end)
    end
end

---------------------------
-- Life Cycle Management --
---------------------------
local function onbuilt(inst)
    inst:DoTaskInTime(4 * FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        inst.components.talker:Say(GetString(inst, "ANNOUNCE_BUILT"))
    end)

    if not inst.components.upgrademoduleowner:ChargeIsMaxed() then
        inst.components.timer:StartTimer(CHARGEREGEN_TIMERNAME, TUNING.WX78_CHARGE_REGENTIME)
    end

    inst:AddComponent("skinner")
    inst.components.skinner:SetSkinName("wx78_none", true)
end

local function OnHammered(inst, worker)
    local inventory = inst.components.inventory
    if inventory ~= nil then
        for k, v in pairs(inventory.opencontainers) do
            k.components.container:Close(inst)
        end
    end
    inst.components.container:Close()
    inst.sg:GoToState("hammered")
end

local function OnHammeredFinished(inst, worker)
    if inst.components.sailor ~= nil and inst.components.sailor:IsSailing() and
        inst.components.sailor:GetBoat() ~= nil then
        inst.components.sailor:Disembark()
    end

    if inst.components.rider:IsRiding() then
        inst.components.rider:ActualDismount()
    end

    local inventory = inst.components.inventory
    if inventory ~= nil then
        for k, v in pairs(inventory.opencontainers) do
            k.components.container:Close(inst)
        end
    end
    inst.components.container:Close()

    inst.components.upgrademoduleowner:PopAllModules()
    inst.components.upgrademoduleowner:SetChargeLevel(0)
    inst.components.lootdropper:DropLoot()
    inst.components.inventory:DropEverything(false, false)

    stop_moisturetracking(inst)
    inst.components.timer:StopTimer(CHARGEREGEN_TIMERNAME)

    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function OnRemoveEntity(inst)
    if inst.components.follower.leader ~= nil then
        if inst.components.follower.leader.components.leader ~= nil then
            inst.components.follower.leader.components.leader:RemoveFollower(inst)
        end
        inst.components.follower.leader = nil
    end

    -- Remove follower from sentryward list
    for k, v in pairs(TheWorld.sentryward) do
        if v.server == inst then
            v.server = nil
        end
    end
    for k, v in pairs(TheWorld.shipyard) do
        if v.server == inst then
            v.server = nil
        end
    end

    -- Clean follower itself
    inst.components.wxnavigation.engaged = false
    inst.components.wxnavigation.navtarget = nil
    inst.components.wxnavigation.previousAP = nil
    if inst.sentryward_task ~= nil then
        inst.sentryward_task:Cancel()
        inst.sentryward_task = nil
    end
end

-----------------------------
-- Resurrection Management --
-----------------------------
local function OnHaunt(inst, haunter)
    if haunter.prefab == "wx78" then
        local rotation = inst.Transform:GetRotation()
        haunter.Transform:SetRotation(rotation)
        if haunter.components.skinner ~= nil then
            local skins = { base = "wx78_none", body = "", hand = "", legs = "", feet = "" }
            if inst.components.skinner ~= nil then
                skins = inst.components.skinner:GetClothing()
            end
            haunter.components.skinner:ClearAllClothing()
            if string.find(skins.base, "wx78") then
                haunter.components.skinner:SetSkinName(skins.base)
            end
            haunter.components.skinner:SetClothing(skins.body)
            haunter.components.skinner:SetClothing(skins.hand)
            haunter.components.skinner:SetClothing(skins.legs)
            haunter.components.skinner:SetClothing(skins.feet)
        end

        if inst.sentryward_task ~= nil then
            inst.sentryward_task:Cancel()
            inst.sentryward_task = nil
        end
        
        inst.components.talker:Say(GetString(inst, "ANNOUNCE_RESURRECTION_START"))
        inst.components.health:SetInvincible(true)

        if inst.components.rider:IsRiding() then
            inst.components.rider:ActualDismount()
        end

        local inventory = inst.components.inventory
        if inventory ~= nil then
            for k, v in pairs(inventory.opencontainers) do
                k.components.container:Close(inst)
            end
        end
        inst.components.container:Close()

        inst.components.upgrademoduleowner:PopAllModules()
        inst.components.upgrademoduleowner:SetChargeLevel(0)
        inst.components.inventory:DropEverything(false, false)

        stop_moisturetracking(inst)
        inst.components.timer:StopTimer(CHARGEREGEN_TIMERNAME)

        inst.Physics:Stop()
        inst.Physics:ClearCollisionMask()
        inst.Physics:ClearCollidesWith(COLLISION.CHARACTERS)
        inst.Physics:SetActive(false)
        inst.DynamicShadow:Enable(false)

        haunter.Physics:Stop()

        inst:ListenForEvent("rez_player", function(inst)
            if inst.components.talker ~= nil then
                inst.components.talker:ShutUp()
            end
            inst:DoTaskInTime(8 * FRAMES, function(inst)
                local fx = SpawnPrefab("collapse_small")
                fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
                fx:SetMaterial("none")
            end)
            inst:DoTaskInTime(14 * FRAMES, function(inst)
                inst:Remove()
            end)
        end)
        return true
    else
        return false
    end
end

local function OnDeath(inst)
    if inst.components.rider:IsRiding() then
        inst.components.rider:ActualDismount()
    end

    local inventory = inst.components.inventory
    if inventory ~= nil then
        for k, v in pairs(inventory.opencontainers) do
            k.components.container:Close(inst)
        end
    end
    inst.components.container:Close()

    inst.components.upgrademoduleowner:PopAllModules()
    inst.components.upgrademoduleowner:SetChargeLevel(0)
    inst.components.lootdropper:DropLoot()
    inst.components.inventory:DropEverything(false, false)

    stop_moisturetracking(inst)
    inst.components.timer:StopTimer(CHARGEREGEN_TIMERNAME)
end

---------------------
-- Save Management --
---------------------
local function OnSave(inst, data)
    data.skins = inst.components.skinner ~= nil and inst.components.skinner:GetClothing() or nil
    data.animbuild = inst.AnimState:GetBuild()
    data.soundsname = inst.soundsname

    if inst.components.skinner ~= nil then
        inst:RemoveComponent("skinner")
    end
end

local function OnLoad(inst, data)
    if inst.components.skinner == nil then
        inst:AddComponent("skinner")
    end

    local animbuild = data.animbuild
    if animbuild == nil or animbuild == "wx" then
        animbuild = "wx78"
    end

    local skins = data ~= nil and data.skins or nil
    if skins == nil or skins.base == nil or skins.base == "" then
        skins = { base = "wx78_none", body = "", hand = "", legs = "", feet = "" }
        animbuild = "wx78"
    end
    inst.components.skinner:SetSkinName(skins.base, true)
    inst.components.skinner:SetClothing(skins.body)
    inst.components.skinner:SetClothing(skins.hand)
    inst.components.skinner:SetClothing(skins.legs)
    inst.components.skinner:SetClothing(skins.feet)
    inst.AnimState:SetBuild(animbuild)

    inst.soundsname = data ~= nil and data.soundsname or "wx78"
end

-------------------
-- Main Function --
-------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Transform:SetFourFaced()

    inst.AnimState:SetBank("wilson")
    inst.AnimState:SetBuild("wx78")
    inst.AnimState:PlayAnimation("idle")

    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")
    inst.AnimState:Hide("HEAD_HAT")
    inst.AnimState:Hide("HEAD_HAT_NOHELM")
    inst.AnimState:Hide("HEAD_HAT_HELM")
    inst.AnimState:Show("HAIR_NOHAT")
    inst.AnimState:Show("HAIR")
    inst.AnimState:Show("HEAD")

    inst.AnimState:OverrideSymbol("fx_wipe", "wilson_fx", "fx_wipe")
    inst.AnimState:OverrideSymbol("fx_liquid", "wilson_fx", "fx_liquid")
    inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")
    inst.AnimState:OverrideSymbol("snap_fx", "player_actions_fishing_ocean_new", "snap_fx")

    --Additional effects symbols for hit_darkness animation
    inst.AnimState:AddOverrideBuild("player_hit_darkness")
    inst.AnimState:AddOverrideBuild("player_receive_gift")
    inst.AnimState:AddOverrideBuild("player_actions_uniqueitem")
    inst.AnimState:AddOverrideBuild("player_wrap_bundle")
    inst.AnimState:AddOverrideBuild("player_lunge")
    inst.AnimState:AddOverrideBuild("player_attack_leap")
    inst.AnimState:AddOverrideBuild("player_superjump")
    inst.AnimState:AddOverrideBuild("player_multithrust")
    inst.AnimState:AddOverrideBuild("player_parryblock")
    inst.AnimState:AddOverrideBuild("player_emote_extra")
    inst.AnimState:AddOverrideBuild("player_boat_plank")
    inst.AnimState:AddOverrideBuild("player_boat_net")
    inst.AnimState:AddOverrideBuild("player_boat_sink")
    inst.AnimState:AddOverrideBuild("player_oar")

    inst.AnimState:AddOverrideBuild("player_actions_fishing_ocean_new")
    inst.AnimState:AddOverrideBuild("player_actions_farming")
    inst.AnimState:AddOverrideBuild("player_actions_cowbell")

    inst.DynamicShadow:SetSize(1.3, .6)

    inst.MiniMapEntity:SetIcon("wx78.png")
    inst.MiniMapEntity:SetPriority(10)
    inst.MiniMapEntity:SetCanUseCache(false)
    inst.MiniMapEntity:SetDrawOverFogOfWar(true)

    inst.Light:Enable(false)
    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(0.75)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)

    MakeCharacterPhysics(inst, 75, .5)

    inst.isplayer = true

    inst:AddTag("character")
    inst:AddTag("wx")
    inst:AddTag("companion")
    inst:AddTag("chessfriend")
    inst:AddTag("lightningtarget")
    inst:AddTag("soulless")
    inst:AddTag("notraptrigger")
    inst:AddTag("scarytoprey")
    inst:AddTag("devourable")
    inst:AddTag("NOBLOCK")
    inst:AddTag("multiplayer_portal")

    inst.soundsname = "wx78"
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 35
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.offset = Vector3(0,-400,0)
    inst.components.talker:StopIgnoringAll()

    inst.currentenergylevel = net_smallbyte(inst.GUID, "upgrademodules.currentenergylevel", "upgrademoduleenergyupdate")
    --[[inst.upgrademodules = {
        net_smallbyte(inst.GUID, "upgrademodules.mods1", "upgrademoduleslistdirty"),
        net_smallbyte(inst.GUID, "upgrademodules.mods2", "upgrademoduleslistdirty"),
        net_smallbyte(inst.GUID, "upgrademodules.mods3", "upgrademoduleslistdirty"),
        net_smallbyte(inst.GUID, "upgrademodules.mods4", "upgrademoduleslistdirty"),
        net_smallbyte(inst.GUID, "upgrademodules.mods5", "upgrademoduleslistdirty"),
        net_smallbyte(inst.GUID, "upgrademodules.mods6", "upgrademoduleslistdirty"),
    }]]
    inst.upgrademodules = {}
    for netvar_index = 1, TUNING.WX78_MAXELECTRICCHARGE do
        table.insert(inst.upgrademodules, net_smallbyte(inst.GUID, "upgrademodules.mods"..tostring(netvar_index), "upgrademoduleslistdirty"))
    end

    inst.GetWXDisplayName = inst.GetDisplayName
    inst.GetDisplayName = CLIENT_GetDisplayNameWithEnergyLevelAndModulesData

    inst.entity:SetPristine()

    ----------------------------------------------------------------
    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetCanSleep(false)
    inst.Physics:SetCollisionCallback(oncollide)

    ----------------------------------------------------------------
    inst._chip_inuse = 0
    inst._moisture_steps = 0
    inst._temperature_modulelean = 0
    inst._num_frostybreath_modules = 0
    
    ----------------------------------------------------------------
    inst.spark_task = nil
    inst.spark_time = 0
    inst.spark_time_offset = 3

    ----------------------------------------------------------------
    inst.ShakeCamera = function(inst, mode, duration, speed, scale, source_or_pt, maxDist) end
    inst.AddCameraExtraDistance = function(inst, source, distance, key) end
    inst.RemoveCameraExtraDistance = function(inst, source, key) end

    ----------------------------------------------------------------
    inst:AddComponent("inspectable")

    inst:AddComponent("maprevealable")
    inst.components.maprevealable:AddRevealSource(inst, "wxtracker")
    inst.components.maprevealable:SetIconPriority(10)
    inst.components.maprevealable:SetIconPrefab("globalmapiconunderfog")
    inst:AddComponent("areaaware")
    inst.components.areaaware:SetUpdateDist(.45)

    inst:AddComponent("inventory")
    inst.components.inventory.maxslots = 15

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("wx")
    inst.components.container.slots = inst.components.inventory.itemslots
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.OnSave = function(self)
        local data = {items = {}}
        local references = {}
        return data, references
    end

    inst:AddComponent("trader")
    inst.components.trader.acceptnontradable = true
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem
    inst.components.trader.deleteitemonaccept = false

    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(10)
    inst.components.workable:SetOnFinishCallback(OnHammeredFinished)
    inst.components.workable:SetOnWorkCallback(OnHammered)

    inst:AddComponent("locomotor")
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor:SetSlowMultiplier(.6)
    inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED
    inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED
    inst.components.locomotor.fasteronroad = true
    inst.components.locomotor:SetTriggersCreep(true)
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")
    inst:AddComponent("drownable")

    inst:AddComponent("follower")
    inst.components.follower.leader = nil
    inst.components.follower:KeepLeaderOnAttacked()
    inst.components.follower.keepdeadleader = true
    inst.components.follower.keepleaderduringminigame = true

    inst:AddComponent("entitytracker")

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.WX78_HEALTH)
    inst.components.health.canheal = false

    inst:AddComponent("repairable")
    inst.components.repairable.repairmaterial = MATERIALS.GEARS
    inst.components.repairable.onrepaired = OnRepaired

    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "torso"
    inst.components.combat:SetDefaultDamage(TUNING.UNARMED_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.WILSON_ATTACK_PERIOD)
    inst.components.combat:SetRange(TUNING.DEFAULT_ATTACK_RANGE)
    inst.components.combat:SetRetargetFunction(2, retargetfn)
    inst.components.combat:SetKeepTargetFunction(keeptargetfn)
    inst.components.combat:SetNoAggroTags(NO_AGGRO_TAGS)

    inst:AddComponent("pinnable")

    ----------------------------------------------------------------
    inst:AddComponent("upgrademoduleowner")
    inst.components.upgrademoduleowner.onmoduleadded = OnUpgradeModuleAdded
    inst.components.upgrademoduleowner.onmoduleremoved = OnUpgradeModuleRemoved
    inst.components.upgrademoduleowner.ononemodulepopped = OnOneUpgradeModulePopped
    inst.components.upgrademoduleowner.onallmodulespopped = OnAllUpgradeModulesRemoved
    inst.components.upgrademoduleowner.canupgradefn = CanUseUpgradeModule
    inst.components.upgrademoduleowner._on_charge_level_changed = inst.components.upgrademoduleowner._["charge_level"][2]
    inst.components.upgrademoduleowner._["charge_level"][2] = function(self, new_charge, old_charge)
        self:_on_charge_level_changed(new_charge, old_charge)
        on_charge_level_changed(self, new_charge, old_charge)
    end
    inst.components.upgrademoduleowner:SetChargeLevel(3)

    inst:ListenForEvent("energylevelupdate", OnUpgradeModuleChargeChanged)

    -- Add the Sanity component only for the music module
    -- It is not checked in wx78_moduledefs.lua at line 501
    inst:AddComponent("sanity")
    inst:StopUpdatingComponent(inst.components.sanity)
    -- Empty LongUpdate function to prevent using LightWatcher
    inst.components.sanity.LongUpdate = function() end

    ----------------------------------------------------------------
    MakeLargeFreezableCharacter(inst, "torso")
    inst.components.freezable:SetResistance(4)
    inst.components.freezable:SetDefaultWearOffTime(TUNING.PLAYER_FREEZE_WEAR_OFF_TIME)
    inst.components.freezable.onfreezefn = OnFrozen

    inst:AddComponent("rider")
    inst:AddComponent("builder")

    inst:AddComponent("temperature")
    inst.components.temperature:SetFreezingHurtRate(0)
    inst.components.temperature:SetOverheatHurtRate(0)
    if GetGameModeProperty("no_temperature") then
        inst.components.temperature:SetTemp(TUNING.STARTING_TEMP)
    end

    inst:AddComponent("moisture")
    inst:AddComponent("sheltered")
    inst:AddComponent("stormwatcher")
    inst.GetStormLevel = function(inst) return inst.components.stormwatcher:GetStormLevel() end
    inst:AddComponent("sandstormwatcher")
    inst.components.sandstormwatcher.UpdateSandstormWalkSpeed_Internal = UpdateSandstormWalkSpeed_Internal
    inst:AddComponent("moonstormwatcher")
    inst.components.moonstormwatcher.UpdateMoonstormWalkSpeed_Internal = UpdateMoonstormWalkSpeed_Internal
    inst:AddComponent("miasmawatcher")
    inst.components.miasmawatcher.UpdateMiasmaWalkSpeed = UpdateMiasmaWalkSpeed
    inst.IsInMiasma = function(inst) return inst.components.miasmawatcher:IsInMiasma() end
    inst.IsInAnyStormOrCloud = function(inst)
        return inst.components.stormwatcher:GetStormLevel() >= TUNING.SANDSTORM_FULL_LEVEL or
            inst.components.miasmawatcher:IsInMiasma()
    end
    inst:AddComponent("acidlevel")
    inst:AddComponent("carefulwalker")

    inst:AddComponent("playerlightningtarget")
    inst.components.playerlightningtarget:SetHitChance(TUNING.WX78_LIGHTNING_TARGET_CHANCE)
    inst.components.playerlightningtarget:SetOnStrikeFn(OnLightningStrike)

    inst:AddComponent("timer")

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(ModuleBasedPreserverRateFn)

    inst:AddComponent("heater")
    inst.components.heater:SetThermics(false, false)
    inst.components.heater.heatfn = GetThermicTemperatureFn

    inst:AddComponent("wardrobe")
    inst.components.wardrobe.ActivateChanging = ActivateChanging
    inst.components.wardrobe.BeginChanging = BeginChanging
    inst.components.wardrobe.ondressupfn = ondressupfn
    inst.components.wardrobe:SetCanBeDressed(true)

    ----------------------------------------------------------------
    inst:AddComponent("wxtype")

    inst:AddComponent("wxmilitary")
    inst:AddComponent("wxnavigation")
    inst:AddComponent("astarpathfinding")
    inst:AddComponent("wxagriculture")
    inst:AddComponent("wxhorticulture")
    inst:AddComponent("wxarboriculture")
    inst:AddComponent("wxapiculture")
    inst:AddComponent("wxaquaculture")
    inst:AddComponent("wxmachineindustry")
    inst:AddComponent("wxminingindustry")
    inst:AddComponent("wxpastoralism")
    inst:AddComponent("wxfoodindustry")
    inst:AddComponent("wxmoonindustry")

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)

    -- Shipwercked
    if KnownModIndex:IsModEnabled("workshop-3435352667") then
        inst:AddComponent("sailor")
        inst:AddComponent("boatjumper")
        inst:AddComponent("drydrownable")
        inst:AddComponent("waveobstacle")
    end
    if KnownModIndex:IsModEnabled("workshop-1467214795") then
        inst:AddComponent("wxmariculture")
    end

    ----------------------------------------------------------------
    inst:SetBrain(brain)
    inst:SetStateGraph("SGwx")

    ----------------------------------------------------------------
    inst:ListenForEvent("onbuilt", onbuilt)
    inst:ListenForEvent("death", OnDeath)
    inst:ListenForEvent("attacked", OnAttacked)
    inst:ListenForEvent("weaponbroke", OnWeaponBroke)
    inst:ListenForEvent("itemranout", OnWeaponBroke)
    inst:ListenForEvent("armorbroke", OnArmorBroke)
    inst:ListenForEvent("moisturedelta", OnWetnessChanged)
    inst:ListenForEvent("dismount", OnDismount)
    inst:ListenForEvent("bucked", OnBucked)
    inst:ListenForEvent("timerdone", OnTimerFinished)

    -- Shipwercked
    inst:ListenForEvent("weaponfired", OnWeaponFired)

    ----------------------------------------------------------------
    inst.AddTemperatureModuleLeaning = AddTemperatureModuleLeaning
    inst.CanUpgradeWithModule = CLIENT_CanUpgradeWithModule
    inst.CanRemoveModules = CLIENT_CanRemoveModules

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    inst.OnRemoveEntity = OnRemoveEntity

    return inst
end

local function placer(inst)
    inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("HAT")
    inst.AnimState:Hide("HAIR_HAT")
    inst.AnimState:Show("HAIR_NOHAT")
    inst.AnimState:Show("HAIR")
    inst.AnimState:Show("HEAD")
    inst.AnimState:Hide("HEAD_HAT")
end

return Prefab("wx", fn, assets, prefabs),
    MakePlacer("wx_placer", "wilson", "wx78", "idle", nil, nil, nil, nil, TheCamera:GetHeadingTarget(), "four", placer)