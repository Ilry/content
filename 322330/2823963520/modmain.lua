GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

--[[
    local x,y,z = GetPlayer().Transform:GetWorldPosition() local ents = TheSim:FindEntities(x,y,z, 4) for i,v in ipairs(ents) do print(v.prefab) end
]]

PrefabFiles = {
    "wya_beefalo",
    "wya_lightninggoat",
    "wya_tumbleweed",
}

Assets = {
    Asset("ATLAS", "images/koalefant_summer.xml"),
    Asset("IMAGE", "images/koalefant_summer.tex"),

    Asset("ATLAS", "images/koalefant_winter.xml"),
    Asset("IMAGE", "images/koalefant_winter.tex"),

    Asset("ATLAS", "images/lightninggoat.xml"),
    Asset("IMAGE", "images/lightninggoat.tex"),

    Asset("ATLAS", "images/spat.xml"),
    Asset("IMAGE", "images/spat.tex"),
}

local function findEntity(prefab, multiple)
    local _ents = {}
    for k,v in pairs(Ents) do
        if v.prefab == prefab then
            table.insert(_ents, v)
            if not multiple then
                return _ents
            end
        end
    end
    return _ents
end

AddModRPCHandler("creaturewidget", "position", function(player, prefab, multiple)
    local _ents = findEntity(prefab, multiple)
    if #_ents > 0 then
        for i, ent in ipairs(_ents) do
            local x,y,z = player.Transform:GetWorldPosition()
            local angle = ent:GetAngleToPoint(x,y,z)
            local radius = -3
            local theta = (angle)*DEGREES
            local offset = Vector3(radius * math.cos( theta ), 0, -radius * math.sin( theta ))
            local base = SpawnPrefab("archive_resonator_base")
            base.Transform:SetPosition(x+offset.x,y,z+offset.z)
            base.Transform:SetRotation(angle+90)
            base.AnimState:PlayAnimation("beam_marker")
            base.AnimState:PushAnimation("idle_marker",true)
            base:DoTaskInTime(10, function(inst) inst:Remove() end)
        end
    else
        if player.components.talker then
            player.components.talker:Say("没找到\nNot found")
        end
    end
end)

local TEMPLATES = require "widgets/redux/templates"
local CreatureWidget = require "screens/creaturewidget"
AddClassPostConstruct("screens/playerhud", function(self)
    self.creturewidgetstatus = false
    self.wherebtn = self:AddChild(TEMPLATES.StandardButton(function()
        self:ShowCretureWidget()
    end , "Where?", {80, 40}))
    self.wherebtn:SetVAnchor(ANCHOR_BOTTOM)
    self.wherebtn:SetHAnchor(ANCHOR_LEFT)
    self.wherebtn:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.wherebtn:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.wherebtn:SetPosition(70, 40)

    self.ShowCretureWidget = function(_, attach)
        self.creturewidgetstatus = true
        self.creaturewidget = CreatureWidget(self.owner)
        self:OpenScreenUnderPause(self.creaturewidget)
        return self.creaturewidget
    end

    self.CloseCreatureWidget = function(_)
        if self.creaturewidget then
            self.creturewidgetstatus = false
            self.creaturewidget:Close()
            self.creaturewidget = nil
        end
    end

    local _OnUpdate = self.OnUpdate
    self.OnUpdate = function(self, dt)
        _OnUpdate(self, dt)

        local openbuttonscale = self.wherebtn:GetScale()
        self.wherebtn:SetPosition(math.abs(70*openbuttonscale.y), math.abs(40 * openbuttonscale.y))
    end
end)

local hotkey = GetModConfigData("hotkey")
if hotkey > 0 then
    TheInput:AddKeyHandler(function(key, down)
        if down then
            if down and TheFrontEnd ~= nil and TheFrontEnd:GetActiveScreen() ~= nil and TheFrontEnd:GetActiveScreen().name ~= nil
                and (TheFrontEnd:GetActiveScreen().name == "HUD" or TheFrontEnd:GetActiveScreen().name == "CreatureWidget") then
                if key == hotkey and ThePlayer and ThePlayer.HUD then
                    if ThePlayer.HUD.creturewidgetstatus == true then
                        ThePlayer.HUD:CloseCreatureWidget()
                    else
                        ThePlayer.HUD:ShowCretureWidget()
                    end
                end
            end
        end
    end)
end

---------------------------------------设置牛在地图上显示图标-------------------------------------------
local function UpdateDomestication(inst)
    if inst.components.domesticatable:IsDomesticated() then
        inst.components.herdmember:Enable(false)
        inst:SetTendency("domestication")
        inst.MiniMapEntity:SetEnabled(true)
    else
        inst.components.herdmember:Enable(true)
        inst:SetTendency("feral")
    end
    inst.MiniMapEntity:SetEnabled(true)
end
AddPrefabPostInit("beefalo", function(inst)
    if not TheWorld.ismastersim then return inst end
    inst:DoTaskInTime(FRAMES, function(inst)
        inst.UpdateDomestication = UpdateDomestication
    end)
end)

-- AddPrefabPostInit("beefaloherd", function(inst)
--     inst.entity:AddNetwork()
--     -- inst.entity:SetPristine()

--     if not TheWorld.ismastersim then return inst end

--     inst:DoTaskInTime(FRAMES, function(inst)
--         local fx = SpawnPrefab("wya_beefalo")
--         fx.entity:SetParent(inst.entity)
--     end)
-- end)
-----------------------------------------------------------------------------------------------------

---------------------------------------设置羊群刷新点在地图上显示-------------------------------------------
AddPrefabPostInit("lightninggoatherd", function(inst)
    inst.entity:AddNetwork()
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then return inst end

    inst:DoTaskInTime(FRAMES, function(inst)
        local fx = SpawnPrefab("wya_lightninggoat")
        fx.entity:SetParent(inst.entity)
    end)
end)
-----------------------------------------------------------------------------------------------------

---------------------------------------设置风滚草刷新点在地图上显示-------------------------------------------
AddPrefabPostInit("tumbleweedspawner", function(inst)

    if not TheWorld.ismastersim then return inst end

    inst:DoTaskInTime(FRAMES, function(inst)
        if inst.wya_spawner == nil or inst.wya_spawner == false then
            local fx = SpawnPrefab("wya_tumbleweed")
            fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst.wya_spawner = true
        end
    end)

    local onsave = inst.OnSave
    inst.OnSave = function(inst, data)
        if onsave then onsave(inst, data) end
        data.wya_spawner = inst.wya_spawner
    end

    local onload = inst.OnLoad
    inst.OnLoad = function(inst, data)
        if onload then onload(inst, data) end
        if data and data.wya_spawner then
            inst.wya_spawner = data.wya_spawner
        end
    end

end)
-----------------------------------------------------------------------------------------------------

local minimapicon = {
    "koalefant_summer",
    "koalefant_winter",
    "lightninggoat",
    "spat",
}

for i, v in pairs(minimapicon) do
    AddMinimapAtlas("images/"..v..".xml")
    AddPrefabPostInit(v, function(inst)
        inst.entity:AddMiniMapEntity()
        inst.MiniMapEntity:SetIcon(v..".tex")
    end)
end

-----------------------------------------------------------------------------------------------------