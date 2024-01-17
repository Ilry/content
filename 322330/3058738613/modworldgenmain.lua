GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

--------------------------------------------------------------------------
--[[ KnownModIndex内添加应用方法 ]] 
--------------------------------------------------------------------------
KnownModIndex.ApplyPreset = function(self, id)
	if id == nil then return end
	local preset = self:GetPresetsModsData(id)
	local questionable = {} --有问题的mod数量
	self:LoadPresetsMods(id) --加载预设数据

	if preset then
		for modname, data in pairs(preset.data or {}) do
			self:Enable(modname)
			--前端加载 会加载modworldgenmain.lua文件
	        ModManager:FrontendLoadMod(modname) --(比较耗时)
	        --设置依赖项列表
	        self:SetDependencyList(modname, self:GetModDependencies(modname))
			if self:ApplyModData(modname, data) then
				table.insert(questionable, modname)
			end
		end
	end
	--刷新一下mod页面
	if TheFrontEnd:GetActiveScreen().DirtyFromMods then
		TheFrontEnd:GetActiveScreen():DirtyFromMods(4)
	end
	return questionable
end
--关闭全部启用的服务器mod
KnownModIndex.DisableAllServerMod = function(self)
	for _, modname in ipairs(self:GetEnabledServerModNames()) do
		-- ModManager:FrontendUnloadMod(modname) --卸载mod加载的内容 (比较耗时)
		-- 还是不卸载这部分内容 可能有mod前端写的有问题 会导致崩
		self:Disable(modname)
	end
	--刷新一下mod页面
	if TheFrontEnd:GetActiveScreen().DirtyFromMods then
		TheFrontEnd:GetActiveScreen():DirtyFromMods(4)
	end
end
--应用mod数据
KnownModIndex.ApplyModData = function(self, name, data)
	local function give(t1, t)
		local opt = {}
		local t2 = deepcopynometa(t)
		for k1, v1 in ipairs(t1 or {}) do
			for k2,v2 in ipairs(t2) do
				if v2.same and v1.name == v2.name then
					table.insert(opt, {v1,v2.current}) --不要直接赋值
					-- v1.saved = v2.current
					v2.same = false
				end
			end
		end
		for k2,v2 in ipairs(t2) do
			if v2.same then --说明 有项有问题
				t.same = false
				return true
			end
		end
		-- 说明没有问题了 可以覆盖设置
		for _,v in ipairs(opt) do
			v[1].saved = v[2]
		end
	end
	for modname, _ in pairs(self.savedata.known_mods) do
		if name == modname then
			local confi = _.modinfo.configuration_options
			--已经检查出问题了
			if not data.same or give(confi, data) then
				-- print("有问题的模组")
				return true
			end
		end
	end
end

--通过id从预设列表移除对应预设
KnownModIndex.ErasePresetsModsData = function(self, id)
	for k, v in ipairs(self.presets) do
		if v.id == id then
			return table.remove(self.presets, i)
		end
	end
end

--检查预设中的内容是否一样
KnownModIndex.InspectPreset = function(self, mods)
	if mods == nil then return end
	local function view(v1,t2)
		for k2,v2 in ipairs(t2) do
			-- 没有检查过的项 再判断名字是否一致
			if v2.same and v1.name == v2.name then
				 --先判断已经保存过的mod设置项结果是否一致
				if v1.saved == v2.current then
					-- print("保存的设置一致",v1.name, v2.current)
					v2.same = false
					return true
				else
					--再找选项中是否有结果一样的
					for _, option in ipairs(v1.options or {}) do
						if option.data == v2.current then
							-- print("设置选项有一个一致",v1.name, v2.current)
							v2.same = false
							return true
						end
					end
				end
			end
		end
		return false
	end
	local function compare(t1, t)
		local t2 = deepcopynometa(t) --复制一张表
		for k1, v1 in ipairs(t1 or {}) do
			if not view(v1, t2) then --只要有一项不一样的
				t.same = false
				return 
			end
		end
	end
	-- print("检查预设的数据合理性")
	for modname, _ in pairs(self.savedata.known_mods) do
		if mods[modname] then
			local data = _.modinfo.configuration_options
			compare(data, mods[modname])
		end
	end
end
--------------------------------------------------------------------------
--[[ KnownModIndex内添加获取数据的方法 ]] 
--------------------------------------------------------------------------
--获取已启用的服务器mod名称
KnownModIndex.GetEnabledServerModNames = function(self)
	local names = {}
	for modname,_ in pairs(self.savedata.known_mods) do
		if self:IsModEnabled(modname) and not self:GetModInfo(modname).client_only_mod then
			table.insert(names, modname)
		end
	end
	return names
end
--获取已启用的服务器mod数据
KnownModIndex.GetEnabledServerModData = function(self)
	local presetdata = {}
	for modname, _ in pairs(self.savedata.known_mods) do
		if self:IsModEnabled(modname) and not self:GetModInfo(modname).client_only_mod then
			-- presetdata[modname] = {_.modinfo.configuration_options} --这样保存不好吧
			presetdata[modname] = {}
			local options = _.modinfo.configuration_options
			for k, option in ipairs(options or {}) do
				table.insert(presetdata[modname], {
					name = option.name,
					current = option.saved,
					same = true, --该版本的设置数据没问题
				})				
			end
			presetdata[modname].same = true --这个mod的数据没有问题
		end
	end
	return presetdata
end


--获取已启用的客户端mod名称
KnownModIndex.GetEnabledClientModNames = function(self)
	local names = {}
	for modname,_ in pairs(self.savedata.known_mods) do
		if self:IsModEnabled(modname) and self:GetModInfo(modname).client_only_mod then
			table.insert(names, modname)
		end
	end
	return names
end
--获取已启用的客户端mod数据
KnownModIndex.GetEnabledClientModData = function(self)
	local data = {}
	for modname,_ in pairs(self.savedata.known_mods) do
		if self:IsModEnabled(modname) and self:GetModInfo(modname).client_only_mod then
			-- data[modname] = {_.modinfo.configuration_options}
			presetdata[modname] = {}
			local options = _.modinfo.configuration_options
			for k, option in ipairs(options or {}) do
				table.insert(presetdata[modname], {
					name = option.name,
					current = option.saved,
					same = true, --该版本的设置数据没问题
				})				
			end
			presetdata[modname].same = true --这个mod的数据没有问题
		end
	end
	return data
end
--通过预设id获取预设列表索引
KnownModIndex.GetPresetsModsData = function(self, id)
	for k, v in ipairs(self.presets) do
		if v.id == id then
			return v, k
		end
	end
end

--通过id获取预设内容
KnownModIndex.GetPresetsModsNames = function(self, id)
	if id == nil then return end
	local preset = self:GetPresetsModsData(id)
	local names = {}
	if preset then
		for modname, v in pairs(preset.data or {}) do
			table.insert(names, {modname = modname, same = v.same})
		end
	end
	return names
end
--------------------------------------------------------------------------
--[[ KnownModIndex内添加保存与加载数据的方法 ]] 
--------------------------------------------------------------------------
local filename = "PRESETS_DATA_FILE"
local mod_config_path = "world_presets/"
KnownModIndex.LoadMyData = function(self, force)
	if force or self.presets == nil then
		self.presets = {}
		--加载文件数据
		TheSim:GetPersistentString(filename, function(load_success, str)
			if load_success then
				local success, savedata = RunInSandboxSafe(str)
				if success and string.len(str) > 0 then
					self.presets = savedata
					-- print("读取预设序列文件成功", savedata)
					-- 进行加载预设文件的数据
					for k,v in ipairs(self.presets) do
						print(v.id)
						self:LoadPresetsMods(v.id)
					end
				else
					print("读取预设序列文件内容失败")
				end
			else
				print("没有对应预设序列文件")
			end
        end)
	end
end
KnownModIndex.LoadPresetsMods = function(self, id)
	if id == nil then return end
	local preset = self:GetPresetsModsData(id)
	if preset == nil or preset.data then --不存在预设 或者 已经添加了数据
		-- self:InspectPreset(preset and preset.data or nil) --检查合理性
		return
	end
	TheSim:GetPersistentString(id, function(load_success, str)
		if load_success == true then
			local success, savedata = RunInSandboxSafe(str)
			if success and string.len(str) > 0 then
				preset.data = savedata
				-- print("读取成功", savedata)
				self:InspectPreset(preset.data) --检查预设数据合理性
			else
				print("读取预设文件内容失败")
			end
		else
			print("没有对应预设文件")
			self:ErasePresetsModsData(id)
		end
    end)
end
KnownModIndex.SaveMyData = function(self, force)
	local savedata = {}
	for k,v in ipairs(self.presets) do
		savedata[k] = {}
		savedata[k].id = v.id
		savedata[k].text = v.text
		savedata[k].settings_desc = v.settings_desc
	end
	local data = DataDumper(savedata, nil, false) --转换为存储的数据
	TheSim:SetPersistentString(filename, data, false, function(save_success)
		if save_success then
			print("保存模组预设完成")
		else
			print("保存模组预设失败")
		end
	end) --保存为本地文件
end


--------------------------------------------------------------------------
--[[ 执行数据的加载 ]] 
--------------------------------------------------------------------------
if TheSim then --因为再生成世界时会执行一次，但是已经不需要了。生成世界应该是新线程执行的。
	KnownModIndex:LoadMyData()
	--向mods菜单上的按钮新增按钮。
	modimport("modstab_modify.lua") 
end

--[[
main.lua 文件
很早就加载mainfunctions.lua 文件。

mainfunctions.lua 文件
在这个文件里，创建了全局函数Start，其中先创建了TheFrontEnd屏幕管理器，再执行了加载gamelogic.lua文件

gamelogic.lua 文件
不是ps4且非专服时，会加载ui MainScreen屏幕文件
在ForceAuthenticationDialog函数中，创建屏幕，并显示屏幕。

MainScreen屏幕
就是点击游戏看到的第一个屏幕, 有一个【开始游戏!】按钮，点击事件和推送该屏幕时 进入验证阶段 （是否离线嘿）是一样的。
验证通过后，会反序列化本地玩家数据，并在淡出当前屏幕时，创建并推送新MultiplayerMainScreen屏幕。

MultiplayerMainScreen屏幕
玩家第二个看到的屏幕，也是主要活动的，在左中侧一列菜单按钮，浏览游戏，创建游戏等。
点击创建游戏按钮，会创建并推送ServerSlotScreen屏幕。（选择存档列表屏幕）

ServerSlotScreen屏幕
点击创建世界按钮，会创建并推送PlaystyleSelectScreen屏幕。（选择服务器的游戏风格屏幕）


PlaystyleSelectScreen屏幕
任意点击游戏风格按钮，都会创建并推送ServerCreationScreen屏幕。（游戏模式设置、世界设置、mod设置等屏幕）


创建时会执行，加载存档也是应该会执行的。
1、ServerCreationScreen屏幕中点击创建世界或者加入世界按钮, 触发该屏幕的Create函数
2、在Create函数里，进行一系列判断, 是否启用离线存档、离线中无法启用联机存档、未安装依赖mod、启用了上次崩而禁用过的mod、启用当前过期mod、成功进入创建。
3、成功进入创建了，将当前存档的模式数据、世界设置数据、启用mod数据等准备好。 再判断是否加洞穴,是创建LaunchingServerPopup弹窗, 并开启专用服务器, 让玩家等待。
4、没有加洞穴, 则通过DoLoadingPortal函数来执行StartNextInstance函数创建世界。淡出屏幕并加载创建世界函数, 实际表现为黄的空白屏幕，之后是生成或加载屏幕。


StartNextInstance函数
在其他地方都用到, 比如c_reset()重新加载函数在本地执行的也是StartNextInstance函数，服务器投票回滚世界也是执行StartNextInstance函数。
StartNextInstance函数中，在服务器上会执行NotifyLoadingState通知加载函数（状态是Loading），再执行TheSim:SetInstanceParameters设置实例参数后，执行TheSim:Reset()重置

NotifyLoadingState函数
新世界生成的执行流程应该是：
1、StartNextInstance函数触发的 状态为Loading;
2、DoGenerateWorld函数创建并推送WorldGenScreen屏幕, 在WorldGenScreen屏幕推送时, 触发状态为 Generating;
3、在WorldGenScreen屏幕弹出时, 触发状态为 DoneGenerating;
4、DoInitGame函数触发的 状态为 DoneLoading.

DoInitGame函数
先进行存档数据处理、mod定义地皮加载等，
再通过PopulateWorld函数来执行SpawnPrefab创建世界且创建其他物品以及铺设地皮等等一系列操作。
最后NotifyLoadingState函数通知完成加载。
]]