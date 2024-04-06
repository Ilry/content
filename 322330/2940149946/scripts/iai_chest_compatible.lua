
local chest = {
	"iai_rubbishbox",
}

for _,v in pairs(chest) do
	-- 兼容showme
	-- 如果他优先级比我高，这一段生效
	for _,mod in pairs(ModManager.mods) do
		-- 遍历已开启的mod
		-- 因为showme的modmain的全局变量里有 SHOWME_STRINGS 所以有这个变量的应该就是showme
		if mod and mod.SHOWME_STRINGS then
			-- 箱子的寻物已经加上去了
			if mod.postinitfns and mod.postinitfns.PrefabPostInit and mod.postinitfns.PrefabPostInit.treasurechest then
				mod.postinitfns.PrefabPostInit[v] = mod.postinitfns.PrefabPostInit.treasurechest
			end
		end
	end
	-- 如果他优先级比我低，那下面这一段生效
	TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
	TUNING.MONITOR_CHESTS[v] = true
	
	-- 兼容智能小木牌
	AddPrefabPostInit(v, function(inst)
		if TUNING.SMART_SIGN_DRAW_ENABLE then
			SMART_SIGN_DRAW(inst)
		end
	end)
end
