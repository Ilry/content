local ShardProxy = Class(function(self, inst)
	self.inst = inst
	self.data = {}
end)

function ShardProxy:OnDaywalkerDefeated(world)
	print("Call OnDaywalkerDefeated", tostring(world), self.inst.worldprefab)
	local world = world or self.inst.worldprefab
	self.data["msg_daywalkerdefeated"] = world

	local shard = TheWorld.shard.components.shard_daywalkerspawner
	if shard then
		shard:SetLocation(world == "forest" and "cavejail" or "forestjunkpile")
	end
end

function ShardProxy:OnSave()
	return self.data
end

function ShardProxy:OnLoad(data)
	if data then
		self.data = data
	end
end

function ShardProxy:OnSaveProxyData()
	local data = {}
	if self.data["msg_daywalkerdefeated"] == self.inst.worldprefab then
		data["msg_daywalkerdefeated"] = self.data["msg_daywalkerdefeated"]
	end
	return data
end

function ShardProxy:OnPostInit()
	local data = ShardGameIndex.dsa_extradata and ShardGameIndex.dsa_extradata.dsa_shard_proxy
	if data then
		if data["msg_daywalkerdefeated"] then
			self.data["msg_daywalkerdefeated"] = data["msg_daywalkerdefeated"]
			self:OnDaywalkerDefeated(data["msg_daywalkerdefeated"])
		end
	end

	-- daywalkerspawner polyfill
	self.inst:DoTaskInTime(0.5, function()
		if self.inst.components.daywalkerspawner 
			and self.inst.components.daywalkerspawner.daywalker == nil -- defeated or not spawned
			and self.data["msg_daywalkerdefeated"] ~= self.inst.worldprefab then
			self:OnDaywalkerDefeated(self.data["msg_daywalkerdefeated"])
		end
	end)
end

return ShardProxy