local PersistentData = Class(function(self, file)
	self.file = file:lower()
	self.data = nil
end)

function PersistentData:Set(data_or_key, value)
	if value ~= nil or type(data_or_key) ~= "table" then
		self:Get()[data_or_key] = value
	else
		self.data = data_or_key
	end
	TheSim:SetPersistentString(self.file, json.encode(self.data))
end

function PersistentData:Get(key)
	if self.data == nil then
		TheSim:GetPersistentString(self.file, function(success, string)
			if success then
				self.data = json.decode(string)
			elseif key ~= nil then
				self.data = {}
			end
		end)
	end
	if key ~= nil then
		return self.data[key]
	end
	return self.data
end

function PersistentData:Erase()
	self.data = nil
	TheSim:ErasePersistentString(self.file)
end

function PersistentData:GetDebugString()
	if type(self.data) ~= "table" then
		return "data: " .. tostring(self.data)
	elseif next(self.data) ~= nil then
		return "data: " .. json.encode(self.data)
	else
		return "data: nil"
	end
end

return PersistentData