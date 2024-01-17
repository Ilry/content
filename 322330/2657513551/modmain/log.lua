-- 日志重定向, 将报错日志输出到存档目录

if ONE_PLAYER_MODE then

local function WriteLog(res)
	local session_id = ShardGameIndex:GetSession()
	local slot = ShardGameIndex:GetSlot()
	local id = os.date("dsa.crash.%Y-%m-%d.%H-%M-%S")
	TheSim:SetPersistentStringInClusterSlot(slot, "Master", "session/"..session_id.."/"..id,
		"DSA Crash Log:\n\n"..table.concat( res, "\n" ))
end

AddSimPostInit(function()
	local old_fn = getdebugstack
	rawset(GLOBAL, "DSA_ORI_getdebugstack", old_fn) -- for other mods
	if getdebugstack ~= nil then
		function GLOBAL.getdebugstack(res, start, top, bottom, ...)
			start = (start or 1) + 2
			local skip = false
			for i = 1, 10 do
				local info = debug.getinfo(i + start)
				if info and info.name == "StackTraceToLog" then
					skip = true
					break
				end
			end
			local res = old_fn(res, start, top, bottom, ...)
			if not skip then
				pcall(WriteLog, res)
			end
			return res
		end
	end
end)

end
