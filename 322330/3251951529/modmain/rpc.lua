local MateUtils = require("mym_mateutils")

AddModRPCHandler("MyMate", "SetMateSet", function(player, mate, data)
    if not data or not mate or not mate.components.mym_mate then return end
    data = json.decode(data)

    for set, d in pairs(data) do
        mate.components.mym_mate:Set(set, d.enable, player, d.isSkill, true)
    end

    if not mate:HasTag("mym_mate") and mate.mym_commandrange then
        -- 玩家的便捷指令
        local range = mate.mym_commandrange:value()
        local ents
        if range == 0 then
            ents = {}
            for _, v in pairs(Ents) do
                if v:HasTag("player") and v:HasTag("mym_mate") then
                    table.insert(ents, v)
                end
            end
        else
            ents = MateUtils.FindMate(player, range * 8, false, true)
        end

        for _, v in ipairs(ents) do
            local leader = v.components.follower and v.components.follower.leader
            if not leader or leader == player then --只对无跟随的和自己的队友起效
                for set, d in pairs(data) do
                    local coommandData = MateUtils.GetData(player.prefab, set, false)
                    if v.components.mym_mate.sets[set] ~= d.enable
                        or (coommandData and coommandData.notoggle) --不会对已经生效的再生效
                    then
                        v.components.mym_mate:Set(set, d.enable, player, d.isSkill, true)
                        if not v:IsAsleep() then
                            SpawnPrefab("spider_heal_target_fx").Transform:SetPosition(v.Transform:GetWorldPosition())
                        end
                    end
                end
            end
        end
    end
end)

-- 设置便捷指令的范围
AddModRPCHandler("MyMate", "CommandRangeAdd", function(player)
    if player.mym_commandrange then
        player.mym_commandrange:set((player.mym_commandrange:value() + 1) % 5) --[0,4]
    end
end)

----------------------------------------------------------------------------------------------------
