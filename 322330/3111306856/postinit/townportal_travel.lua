GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

GLOBAL.AllTownportals = {}

local function MergeTownportalInfo()
    if not TheWorld.ismastersim then
        return
    end

    local merge_info = ""
    for townportal_index, townportal in pairs(AllTownportals) do
        townportal.townportal_index:set(townportal_index)
        local writeable = townportal.components.writeable
        if writeable then
            local name = writeable.text or ""
            merge_info = merge_info .. townportal_index .. "\t" .. name .. "\n"
        end
    end
    TheWorld.net.townportal_infopcak:set(merge_info)
end

local function RemoveTownportal(inst)
    if not TheWorld.ismastersim then
        return
    end

    for townportal_index, townportal in ipairs(AllTownportals) do
        if townportal.GUID == inst.GUID then
            AllTownportals[townportal_index] = nil
        end
    end

    inst:DoTaskInTime(0, MergeTownportalInfo)
end

local writeables = require("writeables")
writeables.AddLayout("townportal", {
    prompt = "", -- Unused
    animbank = "ui_board_5x3",
    animbuild = "ui_board_5x3",
    menuoffset = Vector3(6, -70, 0),

    cancelbtn = {
        text = STRINGS.BEEFALONAMING.MENU.CANCEL,
        cb = nil,
        control = CONTROL_CANCEL
    },

    acceptbtn = {
        text = STRINGS.BEEFALONAMING.MENU.ACCEPT,
        cb = nil,
        control = CONTROL_ACCEPT
    },
})

local TravelScreen = require "screens/travelscreen"
AddClassPostConstruct("screens/playerhud", function(self, anim, owner)
    self.ShowTravelScreen = function(_, attach)
        if not attach or not attach:IsValid() or not attach.townportal_index then
            return
        else
            self.travelscreen = TravelScreen(self.owner, attach)
            self:OpenScreenUnderPause(self.travelscreen)
            return self.travelscreen
        end
    end

    self.CloseTravelScreen = function(_)
        if self.travelscreen then
            self.travelscreen:Close()
            self.travelscreen = nil
        end
    end
end)

local Teleporter = require("components/teleporter")
Teleporter.traveltarget = {}

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end


local function NoPlayersOrHoles(pt)
    return not (IsAnyPlayerInRange(pt.x, 0, pt.z, 2) or TheWorld.Map:IsPointNearHole(pt))
end

function Teleporter:TravelTeleport(obj, userid)
    if self.traveltarget[userid] ~= nil then
        local target_x, target_y, target_z = self.traveltarget[userid].Transform:GetWorldPosition()
        local offset = self.traveltarget[userid].components.teleporter ~= nil and
            self.traveltarget[userid].components.teleporter.offset or 0

        local is_aquatic = obj.components.locomotor ~= nil and obj.components.locomotor:IsAquatic()
        local allow_ocean = is_aquatic or obj.components.amphibiouscreature ~= nil or obj.components.drownable ~= nil

        if self.traveltarget[userid].components.teleporter ~= nil and self.traveltarget[userid].components.teleporter.trynooffset then
            local pt = Vector3(target_x, target_y, target_z)
            if FindWalkableOffset(pt, 0, 0, 1, true, false, NoPlayersOrHoles, allow_ocean) ~= nil then
                offset = 0
            end
        end

        if offset ~= 0 then
            local pt = Vector3(target_x, target_y, target_z)
            local angle = math.random() * 2 * PI

            if not is_aquatic then
                offset =
                    FindWalkableOffset(pt, angle, offset, 8, true, false, NoPlayersOrHoles, allow_ocean) or
                    FindWalkableOffset(pt, angle, offset * .5, 6, true, false, NoPlayersOrHoles, allow_ocean) or
                    FindWalkableOffset(pt, angle, offset, 8, true, false, NoHoles, allow_ocean) or
                    FindWalkableOffset(pt, angle, offset * .5, 6, true, false, NoHoles, allow_ocean)
            else
                offset =
                    FindSwimmableOffset(pt, angle, offset, 8, true, false, NoPlayersOrHoles) or
                    FindSwimmableOffset(pt, angle, offset * .5, 6, true, false, NoPlayersOrHoles) or
                    FindSwimmableOffset(pt, angle, offset, 8, true, false, NoHoles) or
                    FindSwimmableOffset(pt, angle, offset * .5, 6, true, false, NoHoles)
            end

            if offset ~= nil then
                target_x = target_x + offset.x
                target_z = target_z + offset.z
            end
        end

        local ocean_at_point = TheWorld.Map:IsOceanAtPoint(target_x, target_y, target_z, false)
        if ocean_at_point then
            if not allow_ocean then
                local terrestrial = obj.components.locomotor ~= nil and obj.components.locomotor:IsTerrestrial()
                if terrestrial then
                    return
                end
            end
        else
            if is_aquatic then
                return
            end
        end

        if obj.Physics ~= nil then
            obj.Physics:Teleport(target_x, target_y, target_z)
        elseif obj.Transform ~= nil then
            obj.Transform:SetPosition(target_x, target_y, target_z)
        end
    end
end

function Teleporter:Travel(doer, userid)
    if self.onActivate ~= nil then
        self.onActivate(self.inst, doer, self.migration_data)
    end

    self:TravelTeleport(doer, userid)

    if self.traveltarget[userid].components.teleporter ~= nil then
        if doer:HasTag("player") then
            self.traveltarget[userid].components.teleporter:ReceivePlayer(doer, self.inst)
        elseif doer.components.inventoryitem ~= nil then
            self.traveltarget[userid].components.teleporter:ReceiveItem(doer, self.inst)
        end
    end

    if doer.components.leader ~= nil then
        for follower, v in pairs(doer.components.leader.followers) do
            self:TravelTeleport(follower, userid)
        end
    end

    --special case for the chester_eyebone: look for inventory items with followers
    if doer.components.inventory ~= nil then
        for k, item in pairs(doer.components.inventory.itemslots) do
            if item.components.leader ~= nil then
                for follower, v in pairs(item.components.leader.followers) do
                    self:TravelTeleport(follower, userid)
                end
            end
        end
        -- special special case, look inside equipped containers
        for k, equipped in pairs(doer.components.inventory.equipslots) do
            if equipped.components.container ~= nil then
                for j, item in pairs(equipped.components.container.slots) do
                    if item.components.leader ~= nil then
                        for follower, v in pairs(item.components.leader.followers) do
                            self:TravelTeleport(follower, userid)
                        end
                    end
                end
            end
        end
    end

    self.traveltarget[userid] = nil
    return true
end

local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end

local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local states = {
    State {
        name = "entertownportal_travel",
        tags = { "doing", "busy", "nopredict", "nomorph", "nodangle" },

        onenter = function(inst, data)
            ToggleOffPhysics(inst)
            inst.Physics:Stop()
            inst.components.locomotor:Stop()

            inst.sg.statemem.target = data.teleporter
            inst.sg.statemem.teleportarrivestate = "exittownportal_pre"

            inst.AnimState:PlayAnimation("townportal_enter_pre")

            inst.sg.statemem.fx = SpawnPrefab("townportalsandcoffin_fx")
            inst.sg.statemem.fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end,

        timeline =
        {
            TimeEvent(8 * FRAMES, function(inst)
                inst.sg.statemem.isteleporting = true
                inst.components.health:SetInvincible(true)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(false)
                end
                inst.DynamicShadow:Enable(false)
            end),


            TimeEvent(18 * FRAMES, function(inst)
                inst:Hide()
            end),

            TimeEvent(26 * FRAMES, function(inst)
                if inst.sg.statemem.target ~= nil and inst.sg.statemem.target.components.teleporter ~= nil and
                    inst.sg.statemem.target.components.teleporter:Travel(inst, inst.userid) then
                    inst:Hide()
                    inst.sg.statemem.fx:KillFX()
                else
                    inst.sg:GoToState("exittownportal")
                end
            end)
        },

        onexit = function(inst)
            inst.sg.statemem.fx:KillFX()

            if inst.sg.statemem.isphysicstoggle then
                ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                inst.components.health:SetInvincible(false)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
                inst:Show()
                inst.DynamicShadow:Enable(true)
            end
        end,
    }
}

for _, state in pairs(states) do
    AddStategraphState("wilson", state)
end

AddClientModRPCHandler("item_change", "Travel_UI", function(townportal)
    if ThePlayer and ThePlayer.HUD and townportal:IsValid() then
        ThePlayer.HUD:ShowTravelScreen(townportal)
    end
end)

local need_num = 0
AddModRPCHandler("item_change", "Travel", function(player, start_index, target_index)
    if player and player.sg and start_index and target_index then
        local inventory = player.components.inventory
        if inventory then
            if inventory:Has("townportaltalisman", need_num) then
                local need_items = table.invert(inventory:GetItemByName("townportaltalisman", need_num))
                for num, items in pairs(need_items) do
                    for i = 1, num do
                        local item = inventory:RemoveItem(items)
                        if item then
                            item:Remove()
                        end
                    end
                end

                local teleporter = AllTownportals[start_index].components.teleporter
                if teleporter then
                    teleporter.traveltarget[player.userid] = AllTownportals[target_index]
                    player.sg:GoToState("entertownportal_travel", { teleporter = teleporter.inst })
                end
            else
                local talker = player.components.talker
                if talker then
                    talker:Say(en_zh("或许我该多准备一些沙石"))
                end
            end
        end
    end
end)

AddAction("TRAVEL", "传送", function(act)
    MergeTownportalInfo()
    if act.doer and act.target then
        SendModRPCToClient(CLIENT_MOD_RPC["item_change"]["Travel_UI"], act.doer.userid, act.target)
        return true
    end
end)
ACTIONS.TRAVEL.priority = 0

AddComponentAction("SCENE", "teleporter", function(inst, doer, actions, right)
    if not right then
        if inst and inst.townportal_index and inst.townportal_index:value() then
            table.insert(actions, ACTIONS.TRAVEL)
        end
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TRAVEL, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TRAVEL, "give"))



AddAction("NAME_TOWNPORTAL", "命名", function(act)
    local doer, target, invobject = act.doer, act.target, act.invobject
    if doer and target and target:HasTag("townportal_name") and invobject then
        local writeable = target.components.writeable
        if writeable then
            if writeable:IsBeingWritten() then
                return false, "INUSE"
            end

            doer.tool_prefab = invobject.prefab
            if invobject.components.stackable then
                invobject.components.stackable:Get():Remove()
            else
                invobject:Remove()
            end

            writeable:BeginWriting(doer)
            return true
        end
    end
end)
ACTIONS.NAME_TOWNPORTAL.priority = 1

AddComponentAction("USEITEM", "drawingtool", function(inst, doer, target, actions, right)
    if not right then
        if target and target:HasTag("townportal_name") then
            table.insert(actions, ACTIONS.NAME_TOWNPORTAL)
        end
    end
end)

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.NAME_TOWNPORTAL, "doshortaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.NAME_TOWNPORTAL, "doshortaction"))


--------------------------------------------------------------------------------------------------


local function OnWritten(inst, text, doer)
    if not text then
        if doer.tool_prefab then
            doer.components.inventory:GiveItem(SpawnPrefab(doer.tool_prefab), nil, inst:GetPosition())
        end
    else
        inst.SoundEmitter:PlaySound("dontstarve/common/together/draw")
    end

    inst:DoTaskInTime(0, MergeTownportalInfo)
end

AddPrefabPostInit("townportal", function(inst)
    inst.townportal_index = net_byte(inst.GUID, "townportal.index")

    inst:AddTag("townportal_name")

    if not TheWorld.ismastersim then
        return
    end

    table.insert(AllTownportals, inst)
    inst:DoTaskInTime(0, MergeTownportalInfo)

    inst:AddComponent("writeable")
    inst.components.writeable:SetOnWrittenFn(OnWritten)

    inst:ListenForEvent("onremove", RemoveTownportal)
end)

AddPrefabPostInit("forest_network", function(inst)
    inst.townportal_infopcak = net_string(inst.GUID, "townportal.infopcak")
end)

AddPrefabPostInit("cave_network", function(inst)
    inst.townportal_infopcak = net_string(inst.GUID, "townportal.infopcak")
end)
