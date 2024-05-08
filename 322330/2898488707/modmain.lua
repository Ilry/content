GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {"mark_arrow"}

local clockworks = {"knight_nightmare", "rook_nightmare", "bishop_nightmare"}

local function initfn(inst)
	if inst.components.playerprox == nil then
		inst:AddComponent("playerprox")
		inst.components.playerprox:SetDist(63,64)
		inst.components.playerprox.onnear = function(inst)
			if inst.mark_base == nil then
				local arrow = SpawnPrefab("mark_arrow")
				arrow.Transform:SetPosition(inst.Transform:GetWorldPosition())

				inst.mark_base = arrow
			end
		end
		inst.components.playerprox.onfar = function(inst)

		end
	end
end

for _, v in pairs(clockworks) do
	AddPrefabPostInit(v, initfn)
end


































