-- 用于查看某个函数的调用位置. 注意: 发布版本不启用.
-- * 调试 * 钩子 *

if SaveIndex then

local function packstring(...)
    local str = ""
    local n = select('#', ...)
    local args = toarray(...)
    for i=1,n do
        str = str..tostring(args[i]).."\t"
    end
    return str
end

for k,v in pairs(SaveIndex)do
	if type(v) == "function" then
		SaveIndex[k] = function(a,...)
			local info = debug.getinfo(2, "Sl")
			if info.currentline == -1 then
				info = debug.getinfo(3, "Sl")
			end
			if info.source ~= MODROOT.."modmain/save.lua" then
				TheSim:LuaPrint("** SaveIndex:"..k.." is called by "..info.source.."("..info.currentline..") with params: " ..
				packstring(...))
			end
			return v(a,...)
		end
	end
end

for k,v in pairs(ShardIndex)do
	if type(v) == "function" then
		ShardIndex[k] = function(a,...)
			local info = debug.getinfo(2, "Sl")
			if info.currentline == -1 then
				info = debug.getinfo(3, "Sl")
			end
			if info.source ~= MODROOT.."modmain/save.lua" then

				TheSim:LuaPrint("** ShardIndex:"..k.." is called by "..info.source.."("..info.currentline..") with params: " ..
				packstring(...))
			end
			return v(a,...)
		end
	end
end

for k,v in pairs(ShardSaveIndex)do
	if type(v) == "function" then
		ShardSaveIndex[k] = function(a,...)
			local info = debug.getinfo(2, "Sl")
			if info.currentline == -1 then
				info = debug.getinfo(3, "Sl")
			end
			TheSim:LuaPrint("** ShardSaveIndex:"..k.." is called by "..info.source.."("..info.currentline..") with params:")
			TheSim:LuaPrint("  "..packstring(...))
			return v(a,...)
		end
	end
end

end