GLOBAL.setmetatable(GLOBAL.getfenv(1), {__index = function(self, index)
	return GLOBAL.rawget(GLOBAL, index)
end})
