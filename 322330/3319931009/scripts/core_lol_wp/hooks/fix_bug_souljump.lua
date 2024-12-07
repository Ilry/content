local WEAPONS_NOT_ALLOW_SOUL_JUMP = {
	-- 处理bug
	gallop_breaker = true, -- 破舰者
	gallop_bloodaxe = true, -- 渴血战斧
	nashor_tooth = true, -- 纳什之牙
	gallop_brokenking = true, -- 破败王者之刃
	gallop_ad_destroyer = true, -- 挺进破坏者

	-- 处理优先级
	lol_wp_s7_doranshield = true, -- 多兰之盾
}

AddPlayerPostInit(function(inst)
	inst:DoTaskInTime(0,function()
		if inst.prefab == "wortox" then
			if inst.components.playeractionpicker ~= nil then
				local old_fn = inst.components.playeractionpicker.pointspecialactionsfn
				inst.components.playeractionpicker.pointspecialactionsfn = function(inst, pos, useitem, right,...)
					local wp = inst.replica.inventory and inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
					local wp_prefab = wp and wp.prefab
					if WEAPONS_NOT_ALLOW_SOUL_JUMP[wp_prefab] then
						return {}
					end
					local res = old_fn ~= nil and {old_fn(inst, pos, useitem, right,...)} or {}
					return  unpack(res)
				end
			end
		end
	end)
end)