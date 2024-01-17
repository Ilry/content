-- 一些杂项, 包括和某些mod的兼容性补丁

-- fix container owner
AddComponentPostInit("container", function(self)
	local old_open = self.Open
	function self:Open(doer, ...)
		if doer == ThePlayer then
			self.opener = ThePlayer
		else
			self.opener = nil
		end
		return old_open(self, doer, ...)
	end
end)

-- fix perishable
AddComponentPostInit("perishable", function(self)
	TheWorld.components.dsa_clocksync:AddPerishable(self.inst)
end)

local function saferequire(path)
	local success, module = pcall(function() return require(path) end)
	if success then
		print("[DSA] saferequire(\""..path.."\") -> success.")
		return module
	else
		print("[DSA] saferequire(\""..path.."\") -> skip.")
		return nil
	end
end

-- fix minimap
AddSimPostInit(function()
	print("[DSA] Minimap fix.")
	for k,v in pairs{
		-- Smallmap (1226663453)
		saferequire("widgets/smallmap"),
		-- Minimap HUD (345692228)
		saferequire("widgets/minimapwidget"),
	}do
		local old_UpdateTexture = v.UpdateTexture
		function v:UpdateTexture()
			if GetTick() <= 4 then
				print("[DSA] Conflict fix with minimap mod (0->0.5), see modmain/misc.lua")
				self.inst:DoTaskInTime(.5, function()
					local w, h = self.img:GetSize()
					old_UpdateTexture(self)
					self.img:SetSize(w, h)
				end)
			else
				return old_UpdateTexture(self)
			end
		end
	end
end)

-- fix wx sanity component (2678400698)
AddPrefabPostInit("wx", function(inst)
	if inst:HasTag("wx") and inst:HasTag("character") then
		if inst.components.sanity then
			inst.components.sanity.LongUpdate = function() 
				print("[DSA] wx fix: dummy LongUpdate, see modmain/misc.lua")
			end
		end
	end
end)

-- fix targettracker of wagpunk_xxx
AddComponentPostInit("targettracker", function(self)
	local old_longupdate = self.LongUpdate
	function self:LongUpdate(dt)
		if GetTick() == 0 then
			return
		else
			return old_longupdate(self, dt)
		end
	end
end)
