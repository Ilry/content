

local _G = GLOBAL
local SHOW_RANGE_TIME = 30

local justlist =
{
    "dragonflyfurnace",
    "deerclopseyeball_sentryward",
    "mushroom_light",
    "mushroom_light2",
    "lunarthrall_plant",
	"eyeturret",
	"eyeturret_item",
	"lightning_rod"
}


local LUT =
{
    dragonflyfurnace            = { {scale = 1.233  , color = {255,   0,   0}} },   -- Dfly furnace      r=(9.5/6.2435)^0.5			/Red
    deerclopseyeball_sentryward = { {scale = 1.82127, color = {  0,   0, 255}} },   -- EyeCrystaleyezer  r=[(35/6.2435)^0.5]/1.3	/Blue
    mushroom_light              = { {scale = 1.2655 , color = {  0, 255, 255}} },   -- Mushlight         r=[(10/6.2435)^0.5]		/Cyan
    mushroom_light2             = { {scale = 1.2655 , color = {  0, 255, 255}} },   -- Same as Mushlight
    lunarthrall_plant           = { {scale = 1.3863 , color = {255, 255,   0}},     -- BrightShade       r=(12/6.2435)^0.5 and		/Yellow
                                    {scale = 2.192  , color = {  0, 255,   0}} },   --                   r=(30/6.2435)^0.5			/Green
	eyeturret	                = { {scale = 1.698  , color = {255, 0  , 255}} },	-- Houndius Shootius r=(18/6.2435)^0.5 			/Pink
	eyeturret_item				= { {scale = 1.698  , color = {255, 0  , 255}} },	-- Due to its placer is called eyeturret_item_placer, this is needed
	lightning_rod				= { {scale = 2.531  , color = {255, 255,   0}} },	-- Lightning 		 r=(40/6.2435)^0.5			/Yellow
    default                     = { {scale = 1.0    , color = {  0,   0,   0}} },
}


local function Inlist(sth, thelist)
    for i,v in ipairs(thelist) do
        if sth == v then
            return true
        end
    end
    return false
end


local function MakeC(sth, radius, color)
    local C = _G.CreateEntity()
    local tf = C.entity:AddTransform()
    local as = C.entity:AddAnimState()
    as:SetAddColour(color[1], color[2], color[3], 0)
    tf:SetScale(radius, radius, radius)

    as:SetBank("firefighter_placement")
    as:SetBuild("firefighter_placement")
    as:PlayAnimation("idle")
    as:SetOrientation(_G.ANIM_ORIENTATION.OnGround)
    as:SetLayer(_G.LAYER_BACKGROUND)
    as:SetSortOrder(3)
    C.persists = false

    C.entity:SetParent(sth.entity)
    C:AddTag("NOCLICK")
    return C
end


local function OnEnableHelper(inst, enabled)
    if enabled then
        if inst.helpers == nil then
            inst.helpers = {}

            local prefab = "default"
            for _,v in ipairs(justlist) do
                if inst.prefab == (v .. "_placer") then
                    prefab = v
                    break
                end
            end

            for i,v in ipairs(LUT[prefab] or {}) do
                local helper = _G.CreateEntity()

                --[[Non-networked entity]]
                helper.entity:SetCanSleep(false)
                helper.persists = false

                helper.entity:AddTransform()
                helper.entity:AddAnimState()

                helper:AddTag("CLASSIFIED")
                helper:AddTag("NOCLICK")
                helper:AddTag("placer")

                local PLACER_SCALE = v.scale
                helper.Transform:SetScale(PLACER_SCALE, PLACER_SCALE, PLACER_SCALE)

                helper.AnimState:SetBank("firefighter_placement")
                helper.AnimState:SetBuild("firefighter_placement")
                helper.AnimState:PlayAnimation("idle")
                helper.AnimState:SetLightOverride(1)
                helper.AnimState:SetOrientation(_G.ANIM_ORIENTATION.OnGround)
                helper.AnimState:SetLayer(_G.LAYER_BACKGROUND)
                helper.AnimState:SetSortOrder(1)
                helper.AnimState:SetAddColour(0, v.color[1], v.color[2], v.color[3])

                helper.entity:SetParent(inst.entity)
                table.insert(inst.helpers, helper)
            end
        end
    elseif inst.helpers ~= nil then
        for i,v in ipairs(inst.helpers) do
            v:Remove()
        end
        inst.helpers = nil
    end
end


-- https://www.sioe.cn/yingyong/yanse-rgb-16/
local function ShowRange(sth)

    if not sth.circles then
        -- Only if circles were not created, we create them.
        local prefab = Inlist(sth.prefab, justlist) and sth.prefab or "default"
        local circles = {}
        local c2 = nil
        -- TODO: Use prefab scale instead of magic number.
        -- local prefabScale = sth.Transform:GetScale()

        for i,v in ipairs(LUT[prefab] or {}) do
            local circle = MakeC(sth, v.scale, v.color)
            table.insert(circles, circle)
        end

        if SHOW_RANGE_TIME > 0 then
            for _,v in ipairs(circles) do
                v.remove_task = v:DoTaskInTime(SHOW_RANGE_TIME, function() v:Remove() end)
            end
        end
        sth.circles = circles
    else
        -- If circles were created, we remove them.
        for _,v in ipairs(sth.circles) do
            v.remove_task:Cancel()
            v:Remove()
        end
        sth.circles = nil
    end
end

local function Easy(master, num)
    return MakeC(master, num, {255,255,255})
end

local controller = _G.require "components/playercontroller"
local OnLeftClick_old = controller.OnLeftClick
function controller:OnLeftClick(down, ...)
    if (not down) and self:UsingMouse() and self:IsEnabled() and not _G.TheInput:GetHUDEntityUnderMouse() then
        local item = _G.TheInput:GetWorldEntityUnderMouse()
        if item then
            if Inlist(item.prefab, justlist) then
                ShowRange(item)
            end
        end
    end
    return OnLeftClick_old(self, down, ...)
end

local function IceFlingOnRemove(inst)
    local pos = _G.Point(inst.Transform:GetWorldPosition())
    local range_indicators = _G.TheSim:FindEntities(pos.x,pos.y,pos.z, 2, {"range_indicator"})
    for i,v in ipairs(range_indicators) do
        if v:IsValid() then
            v:Remove()
        end
    end
end

local function IceFlingOnShow(inst)
    local pos = _G.Point(inst.Transform:GetWorldPosition())
    local range_indicators_client = TheSim:FindEntities(pos.x,pos.y,pos.z, 2, {"range_indicator"})
    if #range_indicators_client < 1 then
        local range = _G.SpawnPrefab("range_indicator")
        range.Transform:SetPosition(pos.x, pos.y, pos.z)
    end
end

local function IceFlingPostInit(inst)
    inst:ListenForEvent("onremove", IceFlingOnRemove)
end

local function IceFlingPlacerPostInit(inst)
    --Dedicated server does not need deployhelper
    if not _G.TheNet:IsDedicated() then
        if not inst.components.deployhelper then
            inst:AddComponent("deployhelper")
            inst.components.deployhelper.onenablehelper = OnEnableHelper
        end
    end
end


-- 对这些prefab监听点击
for i,v in ipairs(justlist) do
    AddPrefabPostInit(v, IceFlingPostInit)
    AddPrefabPostInit(v .. "_placer", IceFlingPlacerPostInit)
end
