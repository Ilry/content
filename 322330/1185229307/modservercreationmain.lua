for i, v in ipairs({ "_G", "setmetatable", "rawget" }) do
	env[v] = GLOBAL[v]
end

setmetatable(env,
{
	__index = function(table, key) return rawget(_G, key) end
})

modpath = package.path:match("([^;]+)")
package.path = package.path:sub(#modpath + 2) .. ";" .. modpath

pcall(modinfo.SetLocaleMod, env)

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

local mem = setmetatable({}, { __mode = "v" })
local function argtohash(...) local str = ""; for i, v in ipairs(arg) do str = str .. tostring(v) end; return hash(str) end
local function memget(...) return mem[argtohash(...)] end
local function memset(value, ...) mem[argtohash(...)] = value end

Tykvesh =
{
	Dummy = function() end,

	Parallel = function(root, key, fn, lowprio)
		if type(root) == "table" then
			local oldfn = root[key]
			local newfn = oldfn and memget("PARALLEL", oldfn, fn)
			if not oldfn or newfn then
				root[key] = newfn or fn
			else
				if lowprio then
					root[key] = function(...) oldfn(...) return fn(...) end
				else
					root[key] = function(...) fn(...) return oldfn(...) end
				end
				memset(root[key], "PARALLEL", oldfn, fn)
			end
		end
	end,

	Branch = function(root, key, fn)
		if type(root) == "table" then
			local oldfn = root[key]
			if oldfn then
				local newfn = memget("BRANCH", oldfn, fn)
				if newfn then
					root[key] = newfn
				else
					root[key] = function(...) return fn(oldfn, ...) end
					memset(root[key], "BRANCH", oldfn, fn)
				end
			end
		end
	end,
}

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

local success, ModConfigurationScreen = pcall(require, "screens/redux/modconfigurationscreen")

if success and not ModConfigurationScreen._epichealthbarpatched then
	ModConfigurationScreen._epichealthbarpatched = true

	Tykvesh.Branch(ModConfigurationScreen, "_ctor", function(ctor, self, _modname, client_config, ...)
		if _modname == modname and not client_config then
			self._epichealthbardirty = true
			client_config = true
		end
		local screen = ctor(self, _modname, client_config, ...)
		if self._epichealthbardirty then
			self:MakeDirty(false)
		end
		return screen
	end)

	Tykvesh.Parallel(ModConfigurationScreen, "IsDefaultSettings", function(self)
		if self._epichealthbardirty then
			self:LoadConfigurationOptions()
		end
	end)

	Tykvesh.Parallel(ModConfigurationScreen, "Apply", function(self)
		if self._epichealthbardirty then
			KnownModIndex:SaveConfigurationOptions(Tykvesh.Dummy, self.modname, self:CollectSettings(), false)
		end
	end)

	function ModConfigurationScreen:LoadConfigurationOptions()
		local config = KnownModIndex:LoadModConfigurationOptions(self.modname)
		for _, option in ipairs(config or {}) do
			if not option.client and #option.options > 1 then
				local data = option.saved
				if data == nil then
					data = option.default
				end
				for i, v in ipairs(self.options) do
					if v.options == option.options then
						v.value = data
						break
					end
				end
			end
		end
	end
end