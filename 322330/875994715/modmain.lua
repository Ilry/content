for i, v in ipairs({ "_G", "setmetatable", "rawget" }) do
	env[v] = GLOBAL[v]
end

setmetatable(env,
{
	__index = function(table, key) return rawget(_G, key) end
})

modpath = package.path:match("([^;]+)")
package.path = package.path:sub(#modpath + 2) .. ";" .. modpath

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

PrefabFiles = {}
Assets = {}
Modules = { "modutil", "dragonfurnace" }

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

	Sequence = function(root, key, fn, noselect)
		if type(root) == "table" then
			local oldfn = root[key] or Tykvesh.Dummy
			local newfn = memget("SEQUENCE", oldfn, fn)
			if newfn then
				root[key] = newfn
			else
				if noselect then
					root[key] = function(...)
						local ret = { oldfn(...) }
						for i, v in pairs({ fn(ret, ...) }) do
							ret[i] = v
						end
						return unpack(ret)
					end
				else
					root[key] = function(...)
						local ret = { oldfn(...) }
						for i, v in pairs({ fn(ret[1], ...) }) do
							ret[i] = v
						end
						return unpack(ret)
					end
				end
				memset(root[key], "SEQUENCE", oldfn, fn)
			end
		end
	end,

	Browse = function(table, ...)
		for i, v in ipairs(arg) do
			if type(table) ~= "table" then
				return
			end
			table = table[v]
		end
		return table
	end,

	Merge = function(to, from)
		for k, v in pairs(from) do
			if type(v) == "table" and type(to[k]) == "table" then
				Tykvesh.Merge(to[k], v)
			else
				to[k] = v
			end
		end
	end,
}

if rawget(_G, "Tykvesh") == nil then
	rawset(_G, "Tykvesh", Tykvesh)
else
	for name, data in pairs(Tykvesh) do
		_G["Tykvesh"][name] = data
	end
	Tykvesh = _G["Tykvesh"]
end

for index, module in ipairs(Modules) do
	local result = kleiloadlua(MODROOT .. "scripts/" .. module .. ".lua")
	if type(result) == "function" then
		RunInEnvironment(result, env)
	elseif IsInFrontEnd() then
		print("XXX", result or "Error in " .. module .. " module!")
	elseif AddLocalPlayerPostInit ~= nil then
		AddLocalPlayerPostInit(function(inst)
			inst:DoTaskInTime(1, function() Networking_SystemMessage(result or "Error in " .. module .. " module!") end)
		end)
	end
end