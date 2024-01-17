-- This module convert dsa save file back to official save file.

-- 1. Duplicate current save to a new slot (Thank you klei :)
-- 2. Run the new save slot as multiply level mode
-- 3. Load player in newest snapshot in [Master] *
-- 4. Serialize player
-- 5. Save world and truncate all snapshots

local function LoadMeta(slot, shard, file)
	local clock = nil
	local flag = false
	local load_success = false
	TheSim:GetPersistentStringInClusterSlot(slot, shard, file..".meta", function(success, str)
		if success and str ~= nil and #str > 0 then
	        local _, data = RunInSandbox(str)
	        if type(data) == "table" then
	            clock = data.clock
	            flag = data.dsa_copied_flag == true
	            load_success = true
	        end
	    end
	end)
	if flag == true or clock ~= nil then
		return {clock = clock, dsa_copied_flag = flag}
	end
	TheSim:GetPersistentStringInClusterSlot(slot, shard, file, function(success, str)
		if success and str ~= nil and #str > 0 then
			local _, data = RunInSandbox(str)
	        if type(data) == "table" and data.world_network and data.world_network.persistdata then
                data = data.world_network.persistdata
                clock = data.clock or clock
                load_success = true
            end
        end
    end)
    if load_success == false then
    	print(string.format("[DSA] WARNING: Failed to load meta data from [%s] [%s] [%s]",
    		tostring(slot), tostring(shard), tostring(file)))
    end
    return {clock = clock, dsa_copied_flag = flag}
end

function IsDSASave(slot)
	-- 判定一个存档是否为DSA单人存档 (需要转换)
    local master = ShardSaveGameIndex:GetShardIndex(slot, "Master")
    local caves = ShardSaveGameIndex:GetShardIndex(slot, "Caves")
    local masterid = master and master:GetSession()
    local cavesid = caves and caves:GetSession()
    if masterid == nil then
    	return false, "MASTER_NOT_EXISTS"
    elseif cavesid == nil then
    	return false, "CAVES_NOT_EXISTS"
    end

    local masterfile = TheNet:GetWorldSessionFileInClusterSlot(slot, "Master", masterid)
    local cavesfile = TheNet:GetWorldSessionFileInClusterSlot(slot, "Master", cavesid)
    local cavesfile_src = TheNet:GetWorldSessionFileInClusterSlot(slot, "Caves", cavesid)
	
	if masterfile == nil then
		return false, "MASTER_FILE_NOT_EXISTS"
	elseif cavesfile == nil then
		-- return false, "CAVES_FILE_NOT_EXISTS"
		return false, "IN_SYNC"
	end

	local caves_meta = LoadMeta(slot, "Master", cavesfile)
	local master_meta = LoadMeta(slot, "Master", masterfile)
	-- if caves_meta.dsa_copied_flag == true then
	-- 	return false, "IN_SYNC"
	-- end

	return true, {
		shard = {master, caves},
		shardid = {masterid, cavesid},
		meta = {master_meta, caves_meta},
		cavesfile_src_writable = cavesfile_src ~= nil, -- 2023.4.12 检查原始洞穴路径能否写入
	}
end

local function ValidateClock(clock)
    if clock ~= nil
        and clock.cycles ~= nil
        and clock.phase ~= nil
        and clock.segs ~= nil
        and clock.remainingtimeinphase ~= nil
        and clock.totaltimeinphase ~= nil then
        return true
    end
end

local function GetRecoveryData(slot, master_meta, caves_meta)
	-- 获取恢复存档需要的一些信息, 包括:
	-- * 世界运行时间, 计算时间差, 滞后的世界需要执行LongUpdate
	-- * 玩家位置, 这里只读取DSA的玩家位置信息, 因为官方的可以让他们自己解析
	-- 
	-- 这些信息将通过override带入世界
	local master_time = 0
	local caves_time = 0
	if ValidateClock(master_meta.clock) then
		master_time = GetTotalTime(master_meta.clock, true)
	end
	if ValidateClock(caves_meta.clock) then
		caves_time = GetTotalTime(caves_meta.clock, true)
	end

if DEBUG then
	print(json.encode(master_meta.clock), master_time)
	print(json.encode(caves_meta.clock), caves_time)
end

	local data = {
		slot = slot, -- 当前存档序号
		shard = GetPlayerSnapshotShard(slot) or "Master", -- 需要加载玩家的存档位置 (slot/Master/session)
		modname = modname,
	}
	if master_time >= caves_time then
		data.caves_longupdate = master_time - caves_time
		data.master_longupdate = -1
	else
		data.caves_longupdate = -1
		data.master_longupdate = caves_time - master_time
	end

	return data
end

local RecoveryPanel = require "screens/dsa_recovery_panel"

function AddConvertUI(self)
	-- 为启动界面添加一个恢复按钮
	local Widget = require "widgets/widget"
	local TextButton = require "widgets/textbutton"
	local PopupDialogScreen = require "screens/redux/popupdialog"
	local TEMPLATES = require "widgets/redux/templates"

	local root = self:AddChild(Widget("dsa_recovery_button_root"))
	root:SetPosition(300,0)

	local enabled, data_or_error = IsDSASave(self.save_slot)
	if enabled then
		local meta = data_or_error.meta
		self.dsa_recovery_data = GetRecoveryData(self.save_slot, unpack(meta))
		self.dsa_recovery_data.cavesid = data_or_error.shardid[2]
	end

	local function onclick_enabled()
		-- 先检测mod是否启动
		if not KnownModIndex:IsModEnabled(modname) then
			TheFrontEnd:PushScreen(PopupDialogScreen(S.WARNING,
				S.RECOVERY_MOD_DISABLED,
				{{
					text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY,
					cb = function() TheFrontEnd:PopScreen() end
				}}))
			return
		end

		local dialog
		dialog = RecoveryPanel(S.RECOVERY_SAVE_TITLE,
        {
            {
                text = S.RECOVERY_RUN,
                cb = function()
                	dialog:StartProcessing()
                end
            },
            {
                text = STRINGS.UI.SERVERCREATIONSCREEN.CANCEL,
                cb = function()
                    TheFrontEnd:PopScreen(dialog)
                end
            }
        }, S.RECOVERY_SAVE_DESC, MODROOT.."images/hud/dsa_processing_anim.xml")

        local serverdata = ShardSaveGameIndex:GetSlotServerData(self.save_slot)
        dialog.servercreationscreen = self
        dialog.S = S
        self.dsa_recovery_panel = dialog
        dialog.servername = serverdata.name
        dialog:OverrideText(subfmt(S.RECOVERY_SAVE_NAME, serverdata))
        dialog.processing_desc = S.RECOVERY_SAVE_PROCESSING
        dialog.success_desc = S.RECOVERY_SAVE_SUCCESS
        dialog.error_desc = S.RECOVERY_SAVE_ERROR
        dialog.error_btn = S.RECOVERY_SAVE_ERRORBTN
        TheFrontEnd:PushScreen(dialog)
        dialog.edit_text:SetForceEdit(true)
	    dialog.edit_text:OnControl(CONTROL_ACCEPT, false)
	end

	local function onclick_disabled()
		local dialog = PopupDialogScreen(S.RECOVERY_SAVE_TITLE, 
			string.format(S.RECOVERY_SAVE_DESC_DISABLED.MAIN, 
				S.RECOVERY_SAVE_DESC_DISABLED[data_or_error],
				data_or_error),
			{
				{text = STRINGS.UI.CUSTOMIZATIONSCREEN.OKAY, cb = function()
	            TheFrontEnd:PopScreen() end},
			})
		TheFrontEnd:PushScreen(dialog)
	end

	local button = self.world_config_tabs:AddChild(TEMPLATES.IconButton("images/button_icons.xml", "survivor_filter_off.tex",
		S.RECOVERY_SAVE_TITLE, nil, nil,
		enabled and onclick_enabled or onclick_disabled, 
		{size = 40}))
    button:SetScale(.8)
    if enabled then
	    button.image:SetTint(.5,1,.7,1)
	else
		button.image:SetTint(.4,.4,.4,1)
	end
    button.icon:ScaleToSize(44,44)
    button:SetPosition(460, 0)
    button.hovertext:SetSize(28)
    button.hovertext_bg:SetScale(1.2)

	root.button = button

	self.dsa_recovery_button_root = root -- for other mods

	-- methods
	function self:DSA_StartRecoveryServer(slot, name)
		assert(slot, "slot number not provided.")
		assert(name, "slot name not provided.")
		self.dsa_recovery_flag = true
		self.dsa_recovery_slot = slot
		self.dsa_recovery_name = name
		self:Create(
			true, -- warnedOffline
			true, -- warnedDisabledMods
			true  -- warnedOutOfDateMods
		)
	end
end

-- [new]
-- 将洞穴存档资料拷贝到Caves目录
function ShardSaveIndex:CopySessionToCaves(slot)
    print("[DSA-RE] CopySessionToCaves (slot = "..slot..")")
    local caves = self:GetShardIndex(slot, "Caves")
    local master = self:GetShardIndex(slot, "Master")

    if caves ~= nil and master ~= nil then
        local cavesid = caves:GetSession()
        local masterid = master:GetSession()

        local cavesfile = cavesid ~= nil and TheNet:GetWorldSessionFileInClusterSlot(slot, "Master", cavesid) or nil
        if cavesfile ~= nil then
            print("  > start copying: "..cavesfile)

            local savedata, metadataStr
            TheSim:GetPersistentStringInClusterSlot(slot, "Master", cavesfile, function(success, str)
                if success then
                    savedata = str
                end
            end)
            TheSim:GetPersistentStringInClusterSlot(slot, "Master", cavesfile..".meta", function(success, str)
                if success then
                    metadataStr = str
                end
            end)
            if savedata then
            	-- 注: 这里清除一部分洞穴镜像, 防止极端情况下触发洞穴的自动回滚 (autosaver)
            	local list = TheNet:ListSnapshotsInClusterSlot(slot, "Master", masterid, true, 1)
            	local snapshot_id = list and list[1] and list[1].snapshot_id
            	if snapshot_id then
	            	TheNet:TruncateSnapshotsInClusterSlot(slot, "Caves", cavesid, snapshot_id)
	            end
                -- saved in slot|Caves|cavesid
                local filepath = TheNet:GetWorldSessionFileInClusterSlot(slot, "Caves", cavesid)
                if filepath == nil then
                	print(" > failed. (cave save filepath is nil)")
                	return false
                else
	                print("  > to Caves-"..slot.." "..filepath)
	                TheSim:SetPersistentStringInClusterSlot(slot, "Caves", filepath, savedata)
	                TheSim:SetPersistentStringInClusterSlot(slot, "Caves", filepath..".meta", metadataStr)
	                print("  > finish.")
	                return true
	            end
            else
                print("  > failed. (savedata is nil)")
                return false
            end
        end
    end

    return false
end

if TheNet and TheNet:IsDedicated() and TheNet:GetServerMaxPlayers() == 2 then
	-- 判定恢复多人存档的运行环境
	-- 需要: 处于洞穴档, 双进程, 最大玩家数不为1 (目前先设置为2)
	print("[DSA-RE] Recovery mode is on.")
	RECOVERY_MODE = true
	-- print(not TheShard:IsSecondary())
else
	return
end

-- 恢复模式钩子
local function InsertUserID(savedata)
    print("[DSA-RE] InsertUserID")
    local userid = TheNet:GetUserID()
    savedata.snapshot = savedata.snapshot or {players = {}}
    savedata.snapshot.players = savedata.snapshot.players or {}
    if not table.contains(savedata.snapshot.players, userid) then
        print("\tinserted "..tostring(userid))
        table.insert(savedata.snapshot.players, userid)
    end
end

local old_load = ShardIndex.Load
function ShardIndex:Load(callback, ...)
	local function cb()
		local overrides = self.world.options.overrides
		local data = overrides and overrides.dsa_recovery_data
		assert(data, "dsa_recovery_data not provided.")
		assert(data.slot, "data.slot not provided.")
		assert(data.cavesid, "data.cavesid not provided.")
		assert(data.modname, "data.modname not provided.")
		self.dsa_recovery_data = data

		if data.shard == "Master" and not TheShard:IsSecondary() then
			self.dsa_insert_flag = true
		elseif data.shard == "Caves" and TheShard:IsSecondary() then
			self.dsa_insert_flag = true
		end

		-- 将玩家锁定到地面
		if DEVFLAG.RECOVREY_TO_MASTER then
			self.dsa_insert_flag = not TheShard:IsSecondary()
			self.dsa_player_shard = data.shard
		end

		if callback ~= nil then
			callback()
		end
	end
	return old_load(self, cb, ...)
end

function ShardIndex:CheckWorldFile()
	return true
end

local old_getsave = ShardIndex.GetSaveData
function ShardIndex:GetSaveData(cb)
	-- print("[DSA-RE] Run GetSaveData", self.dsa_recovery_data.cavesfile_src_writable, not TheShard:IsSecondary())
	local session_id = self:GetSession()
	if self.dsa_recovery_data.cavesfile_src_writable or not TheShard:IsSecondary() then
		return old_getsave(self, cb)
	end

	local file = TheNet:GetWorldSessionFile(session_id)
	if file ~= nil then
		return old_getsave(self, cb)
	end

	print("[DSA-RE] GetSaveData: file is nil, redirect to master folder.")
	-- 注意: 这里对原始代码进行了直接的覆写
	-- 为了提高兼容性可以换成metadata hook
	local file = TheNet:GetWorldSessionFileInClusterSlot(self.dsa_recovery_data.slot, "Master", session_id)
    if file ~= nil then
    	self.dsa_redirect_savefile = file
        self:GetSaveDataFile(file, cb)
    else
    	error("[DSA-RE] CRITICAL: Failed to get cave savedata (in both Master and Caves).")
    end
end

local old_getsave = ShardIndex.GetSaveDataFile
function ShardIndex:GetSaveDataFile(file, callback)
	local sim__index = getmetatable(TheSim).__index
	local old_get = sim__index.GetPersistentString
	if self.dsa_redirect_savefile ~= nil then
		sim__index.GetPersistentString = function(sim, path, cb)
			if file == path then
				sim:GetPersistentStringInClusterSlot(self.dsa_recovery_data.slot, "Master", path, cb)
			end
		end
	end

	local function cb(savedata)
		sim__index.GetPersistentString = old_get
		if self.dsa_insert_flag then
			InsertUserID(savedata)
		end
		if callback ~= nil then
			callback(savedata)
		end
	end
	return old_getsave(self, file, cb)
end

local old_save = ShardIndex.SaveCurrent
function ShardIndex:SaveCurrent(...)
	print("[DSA-RE] SaveCurrent: remove modname from save: "..self.dsa_recovery_data.modname)
	self.enabled_mods[self.dsa_recovery_data.modname] = nil

	if self:GetSession() ~= self.dsa_recovery_data.cavesid then
		TheNet:DeleteSession(self.dsa_recovery_data.cavesid)
	end

	if not TheShard:IsSecondary() then
		ClearAllData()
		if DEVFLAG.RECOVREY_TO_MASTER then
			-- 删除savelocation
			local file = TheNet:GetUserSessionFile(self:GetSession(), TheNet:GetUserID())
			if file then
				local _, _, dir = file:find("(.*/)%d+")
				if dir then
					file = dir .. "savelocation"
					print("[DSA] Delete savelocation file: ", file)
					TheSim:ErasePersistentString(file)
				end
			end
		end
	end

	return old_save(self, ...)
end

local remove_irreplaceable = false

local function OnDrop(_, data)
	if data and data.item and data.item:IsValid() and data.item:HasTag("irreplaceable") then
		data.item:Remove()
	end
end
AddComponentPostInit("inventory",  function(self)
	local old_drop = self.DropEverythingWithTag
	function self:DropEverythingWithTag(tag, ...)
		if self.inst:HasTag("player") and remove_irreplaceable and tag == "irreplaceable" then
			self.inst:ListenForEvent("dropitem", OnDrop)
			print("[DSA-RE] Remove irreplaceable items in cave save.")
		end
		return old_drop(self, tag, ...)
	end
end)
AddComponentPostInit("container", function(self)
	local old_drop = self.DropEverythingWithTag
	function self:DropEverythingWithTag(tag, ...)
		if remove_irreplaceable and tag == "irreplaceable" then
			self.inst:ListenForEvent("dropitem", OnDrop)
		end
		return old_drop(self, tag, ...)
	end
end)

local old_restore = RestoreSnapshotUserSession
function GLOBAL.RestoreSnapshotUserSession(sessionid, userid, ...)
	print("[DSA-RE] RestoreSnapshotUserSession", sessionid, userid)
	if userid == TheNet:GetUserID() then
	 	local data = ShardGameIndex.dsa_recovery_data
	 	local slot = data.slot
	 	local shard = data.shard
        local online_mode = ShardGameIndex.server.online_mode ~= false
        local encode_user_path = ShardGameIndex:GetServerData().encode_user_path == true

	 	if shard == "Caves" then
	 		sessionid = data.cavesid
	 	end

	 	local net__index = getmetatable(TheNet).__index
	 	local old_get = net__index.GetUserSessionFile
	 	local old_deserialize = net__index.DeserializeUserSession
	 	net__index.GetUserSessionFile = function(net)
	 		print("[DSA-RE] GetUserSessionFile - Redirected -> ", sessionid)
	 		return net:GetUserSessionFileInClusterSlot(slot, "Master", sessionid, nil, online_mode, encode_user_path)
	 	end
	 	net__index.DeserializeUserSession = function(net, file, cb)
	 		print("[DSA-RE] DeserializeUserSession - Redirected -> ", slot, "Master")
	 		return net:DeserializeUserSessionInClusterSlot(slot, "Master", file, cb)
	 	end
	 	if ShardGameIndex.dsa_player_shard == "Caves" and not TheShard:IsSecondary() then
	 		-- 在恢复的时候, 直接移除带有irreplaceable标签的物品
	 		remove_irreplaceable = true
	 	end
	 	old_restore(sessionid, userid, ...)
	 	remove_irreplaceable = false
	 	net__index.GetUserSessionFile = old_get
	 	net__index.DeserializeUserSession = old_deserialize
	else
		old_restore(sessionid, userid, ...)
	end
end

AddComponentPostInit("dsa_clocksync", function(self)
	-- 将时间同步组件切换到恢复模式 (仍将读取时间并触发长更新)
	self.OnWorldNetLoad = self.OnWorldNetLoad_Recovery
	self.OnPostInit 	= self.OnPostInit_Recovery
end)


