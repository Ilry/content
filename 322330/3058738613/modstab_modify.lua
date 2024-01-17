--------------------------------------------------------------------------
--[[ 加载本mod将要执行的逻辑 ]] 
--------------------------------------------------------------------------
-- 自主汉化功能 方案不成熟。
-- local old_LoadModConfigurationOptions = KnownModIndex.LoadModConfigurationOptions
-- KnownModIndex.LoadModConfigurationOptions = function(self, modname, client_config)
-- 	local config = old_LoadModConfigurationOptions(self, modname, client_config)
-- 	if self.showothers == nil then
-- 		self.showothers = {}
-- 		local filename = "CHINESE_DATA_FILE"
-- 		--加载文件数据
-- 		TheSim:GetPersistentString(filename, function(load_success, str)
-- 			if load_success == true then
-- 				local success, savedata = RunInSandboxSafe(str)
-- 				if success and string.len(str) > 0 then
-- 					self.showothers = savedata.data
-- 					print("读取成功", savedata.data)
-- 				else
-- 					print("读取汉化内容失败")
-- 				end
-- 			else
-- 				print("没有对应汉化文件")
-- 			end
--         end)
-- 	end
-- 	-- local function find(t, v) --查找汉化的对应项
-- 	-- 	for _, data in ipairs(t or {}) do
-- 	-- 		if data.name == v.name then
-- 	-- 			return data
-- 	-- 		end
-- 	-- 	end
-- 	-- end
-- 	-- local function replace(t1,t2) --替换对应项为汉化内容
-- 	-- 	if t2 == nil or type(t2)~="table" then return end
-- 	-- 	t1.label = t2.label or t1.label
-- 	-- 	t1.hover = t2.hover or t1.hover
-- 	-- 	for i, v in ipairs(t1.options or {}) do
-- 	-- 		v.description = t2.options and  t2.options[i] and t2.options[i].description or v.description
-- 	-- 		v.hover = t2.options and  t2.options[i] and t2.options[i].hover or v.hover
-- 	-- 	end
-- 	-- end
-- 	if self.showothers[modname] then
-- 		return self.showothers[modname][1]
-- 	end
-- 	-- 直接替换无法换回去，还是判断一下是否变化了，变化了让玩家重新配置
-- 	return config
-- end


-------------------------
-- ui显示额外内容
local TarnsferPanel = require("widgets/zdymodspresetpanel") --自定义面板
local function MakeMenuButton(self)
	if self.subscreener.menu.items[4] then
		self.subscreener.menu.items[4]:Show()
	else
	    self.quickconfiguration = self:AddChild(TarnsferPanel(self))

		local bnt = self.subscreener:MenuButton("快速配置", "quickconfiguration", "快速配置记录mod设置", self.tooltip)
	    bnt.hover_overlay:SetSize(260,68)
	    bnt.hover_overlay:SetPosition(-90,0)
	    bnt.bg:ScaleToSize(140,68)
	    bnt.bg:SetPosition(-55,0)
	    bnt.text:SetRegionSize(140,40)
	    bnt.text:SetPosition(-55,0)
	    bnt.text_shadow:SetRegionSize(140,40)
	    bnt.text_shadow:SetPosition(-55,0)

	    self.subscreener.menu:AddCustomItem(bnt)
		self.subscreener.sub_screens["quickconfiguration"] = self.quickconfiguration
		self.subscreener.sub_screens["quickconfiguration"]:Hide()
	end
	self.subscreener.menu:SetPosition(-444, 135)
end

--------------------------------------------------------------------------
--[[ 加载mod ]] 
--------------------------------------------------------------------------

--每次加载时执行一次。判断前端是否存在 且判断是否存在服务器创建屏幕。
--勾选mod重新加载时，此时服务器创建屏幕已经创建完毕。mods_tab已经存在了。
local IsTheFrontEnd = rawget(_G, "TheFrontEnd") --前端
if IsTheFrontEnd then
	local CurrentScreen = TheFrontEnd:GetActiveScreen()
	if CurrentScreen.name == "ServerCreationScreen" then
		MakeMenuButton(CurrentScreen.mods_tab) --为mods界面菜单添加内容
	end
end

--通过ModsScreen屏幕加载了此mod后，再新建存档时，创建服务器创建屏幕时执行。
local ServerCreationScreen = require("screens/redux/servercreationscreen")
local old_MakeModsTab = ServerCreationScreen.MakeModsTab
ServerCreationScreen.MakeModsTab = function(self)
	local w = old_MakeModsTab(self)
	MakeMenuButton(self.mods_tab)
	return w
end

--------------------------------------------------------------------------
--[[ 卸载本mod ]] 
--------------------------------------------------------------------------
local function UnloadMod(modname)
	local CurrentScreen = TheFrontEnd:GetActiveScreen() --判断所在屏幕
	if CurrentScreen.name == "ServerCreationScreen" then --不是通过ModsScreen屏幕卸载mod
		--恢复原来的方法
		ServerCreationScreen.MakeModsTab = old_MakeModsTab --快速配置ui
		-- KnownModIndex.LoadModConfigurationOptions = old_LoadModConfigurationOptions --汉化部分

		if CurrentScreen.mods_tab.subscreener.menu.items[4] then
			CurrentScreen.mods_tab.subscreener.menu.items[4]:Kill()
			CurrentScreen.mods_tab.subscreener.menu.items[4] = nil
			CurrentScreen.mods_tab.subscreener.menu:SetPosition(-444, 170)
		end
	end
end

local old_Disable = KnownModIndex.Disable
KnownModIndex.Disable = function(self, modname)
	old_Disable(self, modname)
	if modinfo and self.savedata.known_mods[modname].modinfo.name == modinfo.name then
		UnloadMod()
		-- KnownModIndex.Disable = old_Disable
	end
end
--------------------------------------------------------------------------
--[[ mods表更新内容 ]] 
--------------------------------------------------------------------------
local ModsTab = require("widgets/redux/modstab")

local old_UpdateForWorkshop = ModsTab.UpdateForWorkshop
ModsTab.UpdateForWorkshop = function(self, force_refresh)
	if self.quickconfiguration then
		self.quickconfiguration:Refresh()
	end
	old_UpdateForWorkshop(self, force_refresh)
end