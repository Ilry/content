-- 世界创建逻辑修改
-- 采用覆盖的方法, 将原本的世界创建过程修改为[独行长路]的单人优化模式
-- * 兼容性警告 *
local WorldSettingsTab = require "widgets/redux/worldsettings/worldsettingstab"
local HeaderTabs = require "widgets/redux/headertabs"
local LaunchingServerPopup = require "screens/redux/launchingserverpopup"
local ModsTab = require "widgets/redux/modstab"
local OnlineStatus = require "widgets/onlinestatus"
local PopupDialogScreen = require "screens/redux/popupdialog"
local Screen = require "widgets/screen"
local ServerSettingsTab = require "widgets/redux/serversettingstab"
local SnapshotTab = require "widgets/redux/snapshottab"
local Subscreener = require "screens/redux/subscreener"
local TEMPLATES = require "widgets/redux/templates"
local TextListPopup = require "screens/redux/textlistpopup"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local TextButton = require "widgets/textbutton"
local function fn(self)

local ServerCreationScreen = self

-- 保证钩子只触发一次
if self.dsa_hooked_flag then
	return
else
	self.dsa_hooked_flag = true
end

print("[DSA] Hook servercreation at slot = ", self.save_slot)

local function BuildTagsStringHosting(self, worldoptions)
    if TheNet:IsDedicated() then
        --Should be impossible to reach here right?
        --Dedicated servers don't start through this screen
        return
    end

    --V2C: ughh... well at least try to keep this in sync with
    --     networking.lua UpdateServerTagsString()

    local tagsTable = {}

    table.insert(tagsTable, GetGameModeTag(self.server_settings_tab:GetGameMode()))

    if self.server_settings_tab:GetPVP() then
        table.insert(tagsTable, STRINGS.TAGS.PVP)
    end

    if self.server_settings_tab:GetPrivacyType() == PRIVACY_TYPE.FRIENDS then
        table.insert(tagsTable, STRINGS.TAGS.FRIENDSONLY)
    elseif self.server_settings_tab:GetPrivacyType() == PRIVACY_TYPE.CLAN then
        table.insert(tagsTable, STRINGS.TAGS.CLAN)
    elseif self.server_settings_tab:GetPrivacyType() == PRIVACY_TYPE.LOCAL then
        table.insert(tagsTable, STRINGS.TAGS.LOCAL)
    end

    local worlddata = worldoptions[1]
    if worlddata ~= nil and worlddata.location ~= nil then
        local locationtag = STRINGS.TAGS.LOCATION[string.upper(worlddata.location)]
        if locationtag ~= nil then
            table.insert(tagsTable, locationtag)
        end
    end

    return BuildTagsStringCommon(tagsTable)
end

-- 修改回滚逻辑 -> modmain/snapshot.lua
if self.snapshot_tab ~= nil then
    SnapshotTabPostConstruct(self.snapshot_tab)
end

-- 提示箭头
local starthint = function() end
local stophint  = function() end
local updatetemphint = function() end --!!
local max_players = self.server_settings_tab ~= nil and self.server_settings_tab.max_players
local savetype_mode = self.server_settings_tab ~= nil and self.server_settings_tab.savetype_mode
if max_players ~= nil and savetype_mode ~= nil then --!!
    local root = max_players:AddChild(Widget("dsa_arrow_root"))
    root:SetPosition(-210, 0)

    local hint = root:AddChild(Text(NEWFONT,40,"→", {189/255,163/255,100/255,1}))
    hint:Hide()

    -- temporay, may remove in future!!!!
    -- 临时警告
    local root2 = savetype_mode:AddChild(Widget("dsa_temp_root(Dont use!)"))
    root2:SetPosition(-20,0)
    local temp_hint = root2:AddChild(TextButton())
    temp_hint:SetText("󰀕")
    temp_hint:SetTextSize(30)
    temp_hint:Hide()
    updatetemphint = function(v)
        if (v == true or savetype_mode.spinner:GetSelectedData() == true) and KnownModIndex:IsModEnabled(modname) then
            temp_hint:Show()
        else
            temp_hint:Hide()
        end
    end
    temp_hint.inst:DoTaskInTime(0, updatetemphint)
    temp_hint.OnGainFocus = function() root2:SetScale(1.2) end
    temp_hint.OnLoseFocus = function() root2:SetScale(1) end
    temp_hint:SetOnClick(function()
        TheFrontEnd:PushScreen(PopupDialogScreen(S.WARNING, S.CLOUD_SAVE_WARNING, {
        {text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY, cb = function()
            TheFrontEnd:PopScreen()
        end}}))
    end)
    local old_change = savetype_mode.spinner.onchangedfn
    savetype_mode.spinner.onchangedfn = function(v, ...)
        updatetemphint(v)
        return old_change(v, ...)
    end
    -- END --------------

    function starthint()
        stophint()
        hint:Show()
        hint.movetask = hint.inst:DoStaticPeriodicTask(0, function()
            hint:SetPosition((math.sin(GetTick()*0.16)+2)*16, 0)
        end)
    end

    function stophint()
        hint:Hide()
        if hint.movetask ~= nil then
            hint.movetask:Cancel()
            hint.movetask = nil
        end
    end

    -- local old_refresh = self.server_settings_tab.RefreshPrivacyButtons
    -- function self.server_settings_tab:RefreshPrivacyButtons(...)
    --     old_refresh(self, ...)
    --     if self.max_players.spinner:GetSelectedData() <= 1 then
    --         stophint()
    --     end
    -- end

    local old_pre = max_players.spinner.Prev
    function max_players.spinner:Prev(...)
        if hint.shown then
            self.selectedIndex = 2
        end
        if self.selectedIndex <= 2 then
            stophint()
        end
        return old_pre(self, ...)
    end

    if self.server_settings_tab:GetMaxPlayers() > 1 then
        starthint()
    end
end

if DEVFLAG.RECOVRE_MODE then
    AddConvertUI(self)
end

-- 修改切换tab函数, 额外触发一些事件
-- * 钩子 *
local old_select = self.tabscreener.OnMenuButtonSelected
function self.tabscreener:OnMenuButtonSelected(...)
    updatetemphint()
    return old_select(self, ...)
end

-- 修改创建世界/载入存档的函数
-- * 钩子 * 覆盖 *
local old_Create = self.Create
function self:Create(warnedOffline, warnedDisabledMods, warnedOutOfDateMods, ...)
    -- 恢复模式标记, see modmain/recovery.lua
    local recovery = self.dsa_recovery_flag
    self.dsa_recovery_flag = nil

    -- 检查模组是否确实被启用
	if not KnownModIndex:IsModEnabled(modname) then
		print("[DSA] Mod disabled, skip.")
        assert(not recovery, "Not allow to enter recovery mode when mod is disabled.")

        -- 转换警告
        if self.dsa_recovery_data ~= nil then
            local hint = PopupDialogScreen(S.WARNING, S.SUGGEST_RECOVERY, {
                {text = S.OK, cb = function() TheFrontEnd:PopScreen() end},
                {text = S.START_ANYWAY, cb = function()
                    TheFrontEnd:PopScreen()
                    old_Create(self, true, true, true)
                end},
            })
            TheFrontEnd:PushScreen(hint)
            return
        end
		return old_Create(self, warnedOffline, warnedDisabledMods, warnedOutOfDateMods, ...)
	end

    -- 检查玩家数量, 提示将玩家数量修改为1
    if recovery then
        -- 恢复模式下不需要检查
	elseif self.server_settings_tab:GetMaxPlayers() > 1 then
		print("[DSA] More than one player, block starting.")
        local hint = PopupDialogScreen(S.WARNING, S.ONE_PLAYER_STRICT, {
            {text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY, cb = function()
                TheFrontEnd:PopScreen()
                self:SetTab("settings")
                starthint()
            end}
        })
		TheFrontEnd:PushScreen(hint)
		return
	end

    -- 检查洞穴是否开启
	local hascave = self.world_tabs[2] and self.world_tabs[2]:IsLevelEnabled()
	if not hascave then
		print("[DSA] No cave, skip.")
        assert(not recovery, "Not allow to enter recovery mode when cave is absent.")
		return old_Create(self, warnedOffline, warnedDisabledMods, warnedOutOfDateMods, ...)
	end

    if BAN_CLOUDSAVE and self.save_slot > CLOUD_SAVES_SAVE_OFFSET then
        print("[DSA] BAN_CLOUDSAVE flag enabled, block starting. (slot = "..self.save_slot..")")
        local hint = PopupDialogScreen(S.WARNING, S.BAN_CLOUDSAVE, {
            {text = S.OK, cb = function() TheFrontEnd:PopScreen() end},
            {text = S.VIEW_DETAIL, cb = function() VisitURL("https://dont-starve-mod.github.io/zh/dsa_cloudsave", true) end},
        })
        TheFrontEnd:PushScreen(hint)
        return
    end

	print("[DSA] Passed all checks, run `ServerCreationScreen:Create()`")
    if recovery then
        print("[DSA] Recovery mode is ON.")
    end

	-- updated at 2023.2.7
    local function onCreate()
        -- 单人模式下才触发的专用创建世界函数
        -- * 覆盖 *
        footprint(">> onCreate() self.save_slot = ", self.save_slot)

        self.server_settings_tab:SetEditingTextboxes(false)

        local serverdata = self.server_settings_tab:GetServerData()
        local worldoptions = {}
        local copyoptions = {}
        local Customize = require("map/customize")
        local masteroptions = Customize.GetMasterOptions()
        for i,tab in ipairs(self.world_tabs) do
            worldoptions[i] = tab:CollectOptions()

            if worldoptions[i] ~= nil then
                if i == 1 then
                    if worldoptions[1].overrides then
                        for override, value in pairs(worldoptions[1].overrides) do
                            if masteroptions[override] then
                                copyoptions[override] = value
                            end
                        end
                    end
                else
                    if worldoptions[i].overrides == nil then
                        worldoptions[i].overrides = {}
                    end
                    for override, value in pairs(copyoptions) do
                        worldoptions[i].overrides[override] = value
                    end
                end
            end
        end

        -- 插入恢复模式参数到overrides表
        if recovery then
            assert(self.dsa_recovery_data, "recovery data not provided.")
            if worldoptions[1] ~= nil then
                worldoptions[1].overrides.dsa_recovery_data = self.dsa_recovery_data
            end
            if worldoptions[2] ~= nil then
                worldoptions[2].overrides.dsa_recovery_data = self.dsa_recovery_data
            end
        end

        local world1datastring = ""
        if worldoptions[1] ~= nil then
            local world1data = worldoptions[1]
            world1datastring = DataDumper(world1data, nil, false)
        end
        
        local world2datastring = ""
        if worldoptions[2] ~= nil then
            local world2data = worldoptions[2]
            world2datastring = DataDumper(world2data, nil, false)
        end

        -- 手动储存洞穴世界预设, 参考 ServerCreationScreen:SaveChanges()
        local function SaveCaveChanges()
            local i = 2
            local options = worldoptions[2]
            -- local tab = self.world_tabs[i]
            -- local options = tab:CollectOptions()
            -- ShardSaveGameIndex:SetSlotGenOptions(self.save_slot, "Caves", options)
            -- ShardSaveGameIndex:Save()
            ShardSaveGameIndex.slot_cache[self.save_slot] = nil
            local caves = ShardSaveGameIndex:GetShardIndex(self.save_slot, "Caves")
            local wasmaster = caves.ismaster 
            caves.ismaster = true -- bypass Caves shard protection (see shardindex.lua@ShardIndex:SetGenOptions())
            caves:SetGenOptions(options)
            caves.ismaster = wasmaster -- recover
            
            caves:Save()
        end
        
        -- Apply the mod settings
		if self.mods_enabled then
			self.mods_tab:Apply()
        else
            ShardSaveGameIndex:Save()
		end

        -- Fill serverInfo object
        local cluster_info = {}

        local mod_data = DataDumper(ShardSaveGameIndex:GetSlotEnabledServerMods(self.save_slot), nil, false)
        --print("V v v v v v v v v v v v v v v v")
        --print(mod_data)
        --print("^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^")
        cluster_info.mods_config                             = mod_data
        cluster_info.world1gen                               = world1datastring
        cluster_info.world2gen                               = world2datastring
        cluster_info.friends_only                            = serverdata.privacy_type == PRIVACY_TYPE.FRIENDS

        cluster_info.settings                                = {}
        cluster_info.settings.NETWORK                        = {}
        cluster_info.settings.NETWORK.cluster_name           = serverdata.name
        cluster_info.settings.NETWORK.cluster_password       = serverdata.password
        cluster_info.settings.NETWORK.cluster_description    = serverdata.description
        cluster_info.settings.NETWORK.lan_only_cluster       = tostring(serverdata.privacy_type == PRIVACY_TYPE.LOCAL)
        cluster_info.settings.NETWORK.cluster_intention      = serverdata.intention -- @@@@ 测试是否需要删除
        cluster_info.settings.NETWORK.offline_cluster        = tostring(not serverdata.online_mode)
        cluster_info.settings.NETWORK.cluster_language       = LOC.GetLocaleCode()

        cluster_info.settings.GAMEPLAY                       = {}
        cluster_info.settings.GAMEPLAY.game_mode             = serverdata.game_mode
        cluster_info.settings.GAMEPLAY.pvp                   = tostring(serverdata.pvp)

        local gamemode_max_players = GetGameModeMaxPlayers(serverdata.game_mode)
        cluster_info.settings.GAMEPLAY.max_players           = tostring(gamemode_max_players ~= nil and math.min(serverdata.max_players, gamemode_max_players) or serverdata.max_players)

        if serverdata.privacy_type == PRIVACY_TYPE.CLAN then
            cluster_info.settings.STEAM                      = {}
            cluster_info.settings.STEAM.steam_group_only     = tostring(serverdata.clan.only)
            cluster_info.settings.STEAM.steam_group_id       = tostring(serverdata.clan.id)
            cluster_info.settings.STEAM.steam_group_admins   = tostring(serverdata.clan.admin)
        end

        -- 插入恢复模式特殊值
        if recovery then
            -- 注: 单人模式只允许1名玩家, 因此使用1以上的数字代表存档恢复模式, 这个变量会在加载过程中被检测
            cluster_info.settings.GAMEPLAY.max_players = tostring(2) -- see modmain/recovery.lua

            cluster_info.settings.NETWORK.cluster_name = self.dsa_recovery_name
        end

        local function onsaved()
            self:Disable()

            local is_multi_level = world2datastring ~= ""
            local encode_user_path = serverdata.encode_user_path == true
            local use_legacy_session_path = serverdata.use_legacy_session_path == true
            local launchingServerPopup = nil

            -- 不启用专服, 下方代码直接跳过

            -- if is_multi_level then
            --     ShowLoading()
            --     launchingServerPopup = LaunchingServerPopup({},
            --         function()
            --             local start_worked = TheNet:StartClient(DEFAULT_JOIN_IP, 10999, -1, serverdata.password)
            --             if start_worked then
            --                 DisableAllDLC()
            --             end
            --         end,
            --         function()
            --             if IsSteam() then
            --                 OnNetworkDisconnect("ID_DST_DEDICATED_SERVER_STARTUP_FAILED", false, false, {help_button = {text=STRINGS.UI.MAINSCREEN.GETHELP, cb = function() VisitURL("https://support.klei.com/hc/en-us/articles/4407489414548") end}})
            --             else
            --                 OnNetworkDisconnect("ID_DST_DEDICATED_SERVER_STARTUP_FAILED", false, false)
            --             end
            --             TheSystemService:StopDedicatedServers()
            --         end)

            --     TheFrontEnd:PushScreen(launchingServerPopup)
            -- end

            local save_to_cloud = self.save_slot > CLOUD_SAVES_SAVE_OFFSET
            local use_zip_format = Profile:GetUseZipFileForNormalSaves()

            -- 检查地面和洞穴是否已创建
            ShardSaveGameIndex.slot_cache[self.save_slot] = nil
            local master = ShardSaveGameIndex:GetShardIndex(self.save_slot, "Master")
            local caves = ShardSaveGameIndex:GetShardIndex(self.save_slot, "Caves")
            local master_exists = master and not master:IsEmpty()
            local caves_exists = caves and not caves:IsEmpty()

            local function EnterSingleShard()
                -- 启动单个服务器, 使玩家位于主机
            	if TheSystemService:StartDedicatedServers(self.save_slot, false, cluster_info, encode_user_path, use_legacy_session_path, save_to_cloud, use_zip_format) then
            		local function onsaved()
	                    ShardSaveGameIndex.slot_cache[self.save_slot] = nil
	                    assert(ShardSaveGameIndex:GetShardIndex(self.save_slot, "Master"), "failed to save shardindex.")
                        
                        TheNet:SetServerPlaystyle(serverdata.playstyle or PLAYSTYLE_DEFAULT)
	                    TheNet:SetServerTags(BuildTagsStringHosting(self, worldoptions))
	                    DoLoadingPortal(function()
                            SaveClusterInfo(self.save_slot, cluster_info, {encode_user_path, use_legacy_session_path, save_to_cloud, use_zip_format})
	                        StartNextInstance({ reset_action = RESET_ACTION.LOAD_SLOT, save_slot = self.save_slot, --[[new key ->]] one_player_mode = true, launch_timestamp = time})
	                    end)
	                end
                    SaveCaveChanges()
                    ShardSaveGameIndex.slot_cache[self.save_slot] = nil -- clear cache
	                local masterShardGameIndex = ShardSaveGameIndex:GetShardIndex(self.save_slot, "Master", true)
	                local defaultserverdata = GetDefaultServerData()
	                defaultserverdata.encode_user_path = encode_user_path
	                defaultserverdata.use_legacy_session_path = use_legacy_session_path
	                masterShardGameIndex:SetServerShardData(nil, defaultserverdata, onsaved)
            	else
            		self:Enable()
            	end
            end

            if recovery then
                -- 恢复模式, 启动专服
                if self.dsa_recovery_panel then
                    self.dsa_recovery_panel:OnLaunchServer()
                end

                if not TheSystemService:StartDedicatedServers(self.dsa_recovery_slot, true, cluster_info, encode_user_path, use_legacy_session_path, use_zip_format) then
                    -- 显示错误, 询问是否删掉存档
                    self.dsa_recovery_panel:OnError()
                    self:Enable()
                end
            elseif master_exists and caves_exists then
                -- 世界已创建, 直接进入
            	EnterSingleShard()
            else
                -- 世界未创建, 启动子进程进行地图的生成
            	ShowLoading()
                launchingServerPopup = LaunchingServerPopup({},
                    function()
                        TheSystemService:StopDedicatedServers()
                        -- PopSnapshotInClusterSlot(self.save_slot) -- remove in v-1.2.02
                        EnterSingleShard()
                    end,
                    function()
                        OnNetworkDisconnect("ID_DST_DEDICATED_SERVER_STARTUP_FAILED", false, false)
                        TheSystemService:StopDedicatedServers()
                    end)

                TheFrontEnd:PushScreen(launchingServerPopup)

                -- Launch two child process to generate new world
                if not TheSystemService:StartDedicatedServers(self.save_slot, true, cluster_info, encode_user_path, use_legacy_session_path, save_to_cloud, use_zip_format) then
	                launchingServerPopup:SetErrorStartingServers()
	                self:Enable()
                end
            end
        end

        if ShardSaveGameIndex:IsSlotEmpty(self.save_slot) then
            local starts = Profile:GetValue("starts") or 0
            Profile:SetValue("starts", starts + 1)
            Profile:Save(onsaved)
        else
            onsaved()
        end

        --V2C: NO MORE CODE HERE!
        --     onsaved callback may trigger StartNextInstance!
    end

    -- 以下均为游戏源码: servercreationscreen (2023.2.7)
    -- all copy from scripts/redux/servercreationscreen.lua

    local function BuildOptionalModLink(mod_name)
        if PLATFORM == "WIN32_STEAM" or PLATFORM == "LINUX_STEAM" or PLATFORM == "OSX_STEAM" then
            local link_fn, is_generic_url = ModManager:GetLinkForMod(mod_name)
            if is_generic_url then
                return nil
            else
                return link_fn
            end
        else
            return nil
        end
    end
    local function BuildModList(mod_ids)
        local mods = {}
        for i,v in ipairs(mod_ids) do
            table.insert(mods, {
                    text = KnownModIndex:GetModFancyName(v) or v,
                    -- Adding onclick with the idea that if you have a ton of
                    -- mods, you'd want to be able to jump to information about
                    -- the problem ones.
                    onclick = BuildOptionalModLink(v),
                })
        end
        return mods
    end

    if not self:ValidateSettings() then
        -- popups are handled inside validate
        return
    end

    -- Build the list of mods that are newly disabled for this slot
    local disabledmods = {}
    if not warnedDisabledMods then
        disabledmods = self:CheckForDisabledMods()
    end

    -- Build the lost of mods that are enabled and also out of date
    local outofdatemods = {}
    if not warnedOutOfDateMods and self.mods_enabled then
        outofdatemods = self.mods_tab:GetOutOfDateEnabledMods()
    end

    -- Warn if they're starting an offline game that it will always be offline
    if warnedOffline ~= true and not self.server_settings_tab:GetOnlineMode() then
        local offline_mode_body = ""
        if not ShardSaveGameIndex:IsSlotEmpty(self.save_slot) then
            offline_mode_body = TheInventory:HasSupportForOfflineSkins() and STRINGS.UI.SERVERCREATIONSCREEN.OFFLINEMODEBODYRESUME_CANSKIN or STRINGS.UI.SERVERCREATIONSCREEN.OFFLINEMODEBODYRESUME
        else
            offline_mode_body = TheInventory:HasSupportForOfflineSkins() and STRINGS.UI.SERVERCREATIONSCREEN.OFFLINEMODEBODYCREATE_CANSKIN or STRINGS.UI.SERVERCREATIONSCREEN.OFFLINEMODEBODYCREATE
        end

        local confirm_offline_popup = PopupDialogScreen(STRINGS.UI.SERVERCREATIONSCREEN.OFFLINEMODETITLE, offline_mode_body,
                            {
                                {text=STRINGS.UI.SERVERCREATIONSCREEN.OK, cb = function()
                                    -- If player is okay with offline mode, go ahead
                                    TheFrontEnd:PopScreen()
                                    self:Create(true)
                                end},
                                {text=STRINGS.UI.SERVERCREATIONSCREEN.CANCEL, cb = function()
                                    TheFrontEnd:PopScreen()
                                end}
                            },
                            nil,
                            "big")
        self.last_focus = TheFrontEnd:GetFocusWidget()
        TheFrontEnd:PushScreen(confirm_offline_popup)

    -- Can't start an online game if we're offline
    elseif self.server_settings_tab:GetOnlineMode() and (not TheNet:IsOnlineMode() or TheFrontEnd:GetIsOfflineMode()) then
        local body = STRINGS.UI.SERVERCREATIONSCREEN.ONLINEONLYBODY
        if IsRail() then
            body = STRINGS.UI.SERVERCREATIONSCREEN.ONLINEONLYBODY_RAIL
		elseif IsConsole() then
			body = STRINGS.UI.SERVERCREATIONSCREEN.ONLINEONLYBODY_PS4
        end
        local online_only_popup = PopupDialogScreen(STRINGS.UI.SERVERCREATIONSCREEN.ONLINEONYTITLE, body,
                            {
                                {text=STRINGS.UI.SERVERCREATIONSCREEN.OK, cb = function()
                                    TheFrontEnd:PopScreen()
                                end}
                            })
        self.last_focus = TheFrontEnd:GetFocusWidget()
        TheFrontEnd:PushScreen(online_only_popup)
    -- Can't start a game with mods whose dependencies aren't installed
    elseif not KnownModIndex:GetModDependenciesEnabled() then
        local dependent_mods_popup = PopupDialogScreen(STRINGS.UI.MODSSCREEN.REQUIRED_MODS_DOWNLOADING_TITLE,
            STRINGS.UI.MODSSCREEN.REQUIRED_MODS_DOWNLOADING,
            {
                {text=STRINGS.UI.SERVERCREATIONSCREEN.OK, cb = function()
                    TheFrontEnd:PopScreen()
                end}
            })
        self.last_focus = TheFrontEnd:GetFocusWidget()
        TheFrontEnd:PushScreen(dependent_mods_popup)
    -- Warn if starting a server with mods disabled that were previously enabled on that server
    elseif warnedDisabledMods ~= true and #disabledmods > 0 then
        self.last_focus = TheFrontEnd:GetFocusWidget()
        TheFrontEnd:PushScreen(TextListPopup(BuildModList(disabledmods),
                            STRINGS.UI.SERVERCREATIONSCREEN.MODSDISABLEDWARNINGTITLE,
                            STRINGS.UI.SERVERCREATIONSCREEN.MODSDISABLEDWARNINGBODY,
                            {
                                {text=STRINGS.UI.SERVERCREATIONSCREEN.CONTINUE,
                                cb = function()
                                    TheFrontEnd:PopScreen()
                                    self:Create(true, true)
                                end,
                                controller_control=CONTROL_MENU_MISC_1},
                            }))

    -- Warn if starting a server with mods enabled that are currently out of date
    elseif warnedOutOfDateMods ~= true and #outofdatemods > 0 then
        self.last_focus = TheFrontEnd:GetFocusWidget()
        local warning = TextListPopup(BuildModList(outofdatemods),
                            STRINGS.UI.SERVERCREATIONSCREEN.MODSOUTOFDATEWARNINGTITLE,
                            STRINGS.UI.SERVERCREATIONSCREEN.MODSOUTOFDATEWARNINGBODY,
                            {
                                {text=STRINGS.UI.SERVERCREATIONSCREEN.CONTINUE,
                                cb = function()
                                    TheFrontEnd:PopScreen()
                                    self:Create(true, true, true)
                                end,
                                controller_control=CONTROL_MENU_MISC_1},
                                {text=STRINGS.UI.MODSSCREEN.UPDATEALL,
                                cb = function()
                                    TheFrontEnd:PopScreen()
                                    self.mods_tab:UpdateAllButton(true)
                                    self:SetTab("mods")
                                end,
                                controller_control=CONTROL_MENU_MISC_2},
                            })
        TheFrontEnd:PushScreen(warning)
    -- We passed all our checks, go ahead and create
    else
        onCreate()
    end
end

end


---------------------------------------------------------------
-- 修改创建世界界面, 这里需要延迟1帧等待界面生成, 由modworldgenmain触发
if rawget(GLOBAL, "TheFrontEnd") ~= nil then
    -- Delay one frame to wait ServerCreationScreen to create.
	scheduler:ExecuteInTime(0, function()
		for _, screen in ipairs(GLOBAL.TheFrontEnd.screenstack) do
			if screen.name == "ServerCreationScreen" then
				fn(screen)
				break
			end
		end
	end)
end