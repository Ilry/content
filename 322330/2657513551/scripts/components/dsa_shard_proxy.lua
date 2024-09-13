local ShardProxy = Class(function(self, inst)
	self.inst = inst
	self.data = {}
	self.mermkingdata = {} -- mermking buff from other shard
end)

function ShardProxy:OnDaywalkerDefeated(world)
	-- print("Call OnDaywalkerDefeated", tostring(world), self.inst.worldprefab)
	local world = world or self.inst.worldprefab
	self.data["msg_daywalkerdefeated"] = world

	local shard = TheWorld.shard.components.shard_daywalkerspawner
	if shard then
		shard:SetLocation(world == "forest" and "cavejail" or "forestjunkpile")
	end
end

function ShardProxy:OnMermKingBuff(type, exists)
	if type == "exists"
		or type == "trident"
		or type == "crown"
		or type == "pauldron" then

		self.data["msg_mermking"..type] = exists
	end
end

function ShardProxy:HasKingShard(type)
	return self.mermkingdata["msg_mermking"..type]
end

function ShardProxy:OnSave()
	local data = { mermkingdata = self.mermkingdata }
	for k,v in pairs(self.data)do
		data[k] = v
	end
	return data
end

function ShardProxy:OnLoad(data)
	if type(data) == "table" then
		self.mermkingdata = data.mermkingdata or {}
		self.data = data
		self.data.mermkingdata = nil
	end
end

function ShardProxy:OnSaveProxyData()
	local data = { from = self.inst.worldprefab }
	if self.data["msg_daywalkerdefeated"] == self.inst.worldprefab then
		data["msg_daywalkerdefeated"] = self.data["msg_daywalkerdefeated"]
	end
	for k,v in pairs(self.data)do
		if k:find("mermking") and v then
			data[k] = v
		end
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
		if data.from ~= TheWorld.worldprefab then
			local mermkingdata = {}
			for k,v in pairs(data)do
				if k:find("mermking") then
					mermkingdata[k] = v
				end
			end
			self.mermkingdata = mermkingdata
		end
	end

	self.inst:DoTaskInTime(0.5, function()
		-- daywalkerspawner polyfill
		if self.inst.components.daywalkerspawner 
			and self.inst.components.daywalkerspawner.daywalker == nil -- defeated or not spawned
			and self.data["msg_daywalkerdefeated"] ~= self.inst.worldprefab then
			self:OnDaywalkerDefeated(self.data["msg_daywalkerdefeated"])
		end

		-- mermking
		local fake_shard_id = 114514
		local prefix = "msg_mermking"
		Shard_SyncMermKingExists(self.mermkingdata[prefix.."exists"], fake_shard_id)
		Shard_SyncMermKingTrident(self.mermkingdata[prefix.."trident"], fake_shard_id)
		Shard_SyncMermKingCrown(self.mermkingdata[prefix.."crown"], fake_shard_id)
		Shard_SyncMermKingPauldron(self.mermkingdata[prefix.."pauldron"], fake_shard_id)
	end)
end

return ShardProxy