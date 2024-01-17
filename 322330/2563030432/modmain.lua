local obc_eagleMode = 0
-- 0 : 默认
-- 1 ：高空
-- 2 ：鹰眼

local nightsightMode = false
local lastFov = 35
local CIRCLE_STATE = nil
local G = GLOBAL

local showTip = GetModConfigData("cheat_tip")


local function TIP(stat, green, content)
	if showTip then
		if green then
			G.ThePlayer.HUD.controls.networkchatqueue:PushMessage(stat, content, {0.196, 0.804, 0.196, 1})
		else
			G.ThePlayer.HUD.controls.networkchatqueue:PushMessage(stat, content, {1, 0.388, 0.278, 1})
		end
	end
end

local function MakeCircle(inst, n, scale)
	local circle = G.CreateEntity()

	circle.entity:SetCanSleep(false)
	circle.persists = false

	circle.entity:AddTransform()
	circle.entity:AddAnimState()

	circle:AddTag("CLASSIFIED")
	circle:AddTag("NOCLICK")
	circle:AddTag("placer")

	circle.Transform:SetRotation(n)
	-- 大小
	circle.Transform:SetScale(scale, scale, scale)

	circle.AnimState:SetBank("firefighter_placement")
	circle.AnimState:SetBuild("firefighter_placement")
	circle.AnimState:PlayAnimation("idle")
	circle.AnimState:SetLightOverride(1)
	circle.AnimState:SetOrientation(G.ANIM_ORIENTATION.OnGround)
	circle.AnimState:SetLayer(G.LAYER_BACKGROUND)
	circle.AnimState:SetSortOrder(3.1)
	-- 颜色
	circle.AnimState:SetAddColour(0, 255, 0, 0)

	circle.entity:SetParent(inst.entity)
	return circle
end



local function IsDefaultScreen()
	local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
	local screenName = screen and screen.name or ""
	return screenName:find("HUD") ~= nil and GLOBAL.ThePlayer ~= nil
end

local function SetCamera(zoomstep, mindist, maxdist, mindistpitch, maxdistpitch, distance, distancetarget)
	if GLOBAL.TheCamera ~= nil then
		local camera = GLOBAL.TheCamera
		camera.zoomstep = zoomstep or camera.zoomstep
		camera.mindist = mindist or camera.mindist
		camera.maxdist = maxdist or camera.maxdist
		camera.mindistpitch = mindistpitch or camera.mindistpitch
		camera.maxdistpitch = maxdistpitch or camera.maxdistpitch
		camera.distance = distance or camera.distance
		camera.distancetarget = distancetarget or camera.distancetarget
	end
end
local function SetDefaultView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(4, 15, 35, 25, 40, 25, 25)
		else
			SetCamera(4, 15, 50, 30, 60, 30, 30)
		end
	end
end

local function SetAerialView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(10, 10, 180, 25, 40, 80, 80)
		else
			SetCamera(10, 10, 180, 30, 60, 80, 80)
		end
	end
end

function SetVerticalView()
	if GLOBAL.TheWorld ~= nil then
		if GLOBAL.TheWorld:HasTag("cave") then
			SetCamera(10, 10, 180, 90, 90, 80, 80)
		else
			SetCamera(10, 10, 180, 90, 90, 80, 80)
		end
	end
end

-- 鹰眼
local function EagleViewMode()
	local player = G.ThePlayer
    if IsDefaultScreen() then
        if (obc_eagleMode == 0) then
            obc_eagleMode = 1
            SetAerialView()
			GLOBAL.TheCamera.fov = lastFov
            TIP("视角", true, "大视野")
        elseif (obc_eagleMode == 1) then
			obc_eagleMode = 2
            lastFov = GLOBAL.TheCamera.fov
			SetVerticalView()
			GLOBAL.TheCamera.fov = 165
			-- 画圆
			CIRCLE_STATE = {}
			table.insert(CIRCLE_STATE, MakeCircle(player, 0, 2))
			table.insert(CIRCLE_STATE, MakeCircle(player, 2, 2))
			TIP("视角", false, "鹰眼")
		else
			obc_eagleMode = 0
			SetDefaultView()
			GLOBAL.TheCamera.fov = lastFov
			-- 画圆
			for _,circle in pairs(CIRCLE_STATE) do circle:Remove() end
			CIRCLE_STATE = nil
			TIP("视角", true, "标准")
		end
	end
end


-- 智能夜视


local function TurnOnNightVision(player)
	player.light = player.entity:AddLight()
	player.light:SetFalloff(0.5)
	player.light:SetIntensity(player.lightx)
	player.light:SetRadius(10^4)
	player.light:SetColour(255/255, 225/255, 255/255)
	player.light:Enable(true)
	player:DoTaskInTime(1, function() TIP("提示", true, "夜晚到来, 请准备光源") end)
end



local function TurnOffNightVision(player)
	player.light = player.entity:AddLight()
	player.light:SetFalloff(0.5)
	player.light:SetIntensity(0)
	player.light:SetRadius(0)
	player.light:SetColour(255/255, 225/255, 255/255)
	player.light:Enable(false)
end


local function TurnOffDelay(player)
	player:DoTaskInTime(5, function() TurnOffNightVision(player) end)
end

local function NightSight()
    if GLOBAL.ThePlayer and not GLOBAL.ThePlayer.HUD:IsChatInputScreenOpen() and not GLOBAL.ThePlayer.HUD:IsConsoleScreenOpen() and not GLOBAL.ThePlayer.HUD.writeablescreen then
        local player = G.ThePlayer
		nightsightMode = not nightsightMode
		if nightsightMode then
			player.lightx = player.lightx or 1
			player:WatchWorldState("startday",TurnOffDelay)
			player:WatchWorldState("startnight",TurnOnNightVision)
			if G.TheWorld.state.isday or G.TheWorld.state.isdusk then
				TIP("开启", true, "智能夜视已开启, 夜晚将会自动启用")
			else
				TIP("开启", true, "智能夜视已开启")
				TurnOnNightVision(player)
			end
		else
			if G.TheWorld.state.isnight then
				TurnOffNightVision(player)
			end
			player:WatchWorldState("startnight",TurnOffNightVision)
			TIP("关闭", false, "智能夜视已关闭")
		end

	end
end


GLOBAL.TheInput:AddKeyDownHandler(GetModConfigData("cheat_fullmap"), EagleViewMode)
GLOBAL.TheInput:AddKeyDownHandler(GetModConfigData("cheat_nightversion"), NightSight)