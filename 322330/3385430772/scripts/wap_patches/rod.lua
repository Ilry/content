--操纵杆


local rod_mute = GetModConfigData("rod_mute")
local rod_quick = GetModConfigData("rod_quick")
local rod_teleport = GetModConfigData("rod_teleport")

--操纵杆初始化
AddPrefabPostInit("wxdiviningrod", function(inst)
	--快速动作(未使用)
	-- if rod_quick then
		-- inst:AddTag("veryquickcast")
	-- end
	
	
	if not TheWorld.ismastersim then return inst end


	--去除机器人距离探测功能
	if rod_mute and inst.components.equippable then
		local oldonequipfn = inst.components.equippable.onequipfn or function() end
		inst.components.equippable.onequipfn = function(inst, owner, from_ground)
			oldonequipfn(inst, owner, from_ground)
			if inst.task ~= nil then
				inst.task:Cancel()
				inst.task = nil
			end
		end
	end

	--传送机器人到附近
	if rod_teleport and inst.components.spellcaster then
		local oldspell = inst.components.spellcaster.spell
		inst.components.spellcaster.spell = function(staff, target, pos, doer)
			if doer == target then
				if doer.components.leader then			
					for follower,_ in pairs(doer.components.leader.followers) do
						if follower.prefab == "wx" then
							local pt1 = doer:GetPosition()
							local pt2 = follower:GetPosition()
							local diff = (pt2 - pt1)
							local offset = diff:GetNormalized() * 0.1 * math.random(40,100)
							local x,y,z = pt1.x + offset.x, pt1.y, pt1.z + offset.z
							
							--尽量不传送到海上以及让位置不被阻挡
							local offset2 = 0
							for i = 1,10 do
								if TheWorld.Map:IsOceanAtPoint(x, 0, z) or TheWorld.Map:IsGroundTargetBlocked(Vector3(x, 0, z)) then
									offset = diff:GetNormalized() * 0.1 * math.random(15,30) * ((-1)^offset2)
									x,y,z = pt1.x + offset.x, pt1.y, pt1.z + offset.z
									offset2 = offset2 + 1
								else
									break
								end
							end

							--如果传送位置还是在海上或位置被阻挡,则不传送并提示
							if TheWorld.Map:IsOceanAtPoint(x, 0, z) then
								if doer.components.talker then
									doer.components.talker:Say("“警告：存在机器人传送失败”\n“原因：海洋”")
								end
							elseif TheWorld.Map:IsGroundTargetBlocked(Vector3(x, 0, z)) then
								if doer.components.talker then
									doer.components.talker:Say("“警告：存在机器人传送失败”\n“原因：障碍物”")
								end
							else
								follower.Transform:SetPosition(x, y, z)
								SpawnPrefab("spawn_fx_medium").Transform:SetPosition(x, y, z)
							end
						end
					end
				end
			else
				oldspell(staff, target, pos, doer)
			end
		end
	end
end)

--操纵杆快速动作
if rod_quick then

--施法时可移动
local function noBusy(sg, state)
	local oldonenter = sg.states[state].onenter
	sg.states[state].onenter = function(inst)
		oldonenter(inst)
		if inst:HasTag("player") and inst.replica.inventory then
			local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
			if item ~= nil and item.prefab == "wxdiviningrod" then
				inst:DoTaskInTime(0, function(inst)
					inst.sg:RemoveStateTag("busy")
					if inst.components.playercontroller then
						inst.components.playercontroller:Enable(true)
					end
				end)
			end
		end
	end
end

local function quickrodfn(sg)
	noBusy(sg, "castspell")
	noBusy(sg, "veryquickcastspell")

    if sg.actionhandlers ~= nil then
		local handler = sg.actionhandlers[ACTIONS.CASTSPELL] or {}
		local oldfn = handler.deststate or function() end
		handler.deststate = function(inst, act)
			if inst:HasTag("player") and inst.replica.inventory and act.target then
				local item = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
				if item ~= nil and item.prefab == "wxdiviningrod" then
					return "veryquickcastspell"
				end
			end
			return oldfn(inst, act)
		end
	end
end

AddStategraphPostInit("wilson", quickrodfn)
AddStategraphPostInit("wilson_client", quickrodfn)

end

