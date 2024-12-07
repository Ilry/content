AddComponentPostInit('combat',function (self)
    LOLWP_S:hookFn(self,'GetAttacked',function (self,attacker,damage,weapon,stimuli,spdamage, ...)
        local victim = self.inst
        if victim and attacker and attacker:HasTag("player") then
            local equips,found = LOLWP_S:findEquipments(attacker,'lol_wp_s9_guider')
            if found then

                if victim and victim.components.locomotor then
                    victim.components.locomotor:SetExternalSpeedMultiplier(victim,'lol_wp_s9_guider_debuff',TUNING.MOD_LOL_WP.GUIDER.SKILL_GUIDE.ATK_SPEEDDOWN)
                end
                if victim.taskintime_lol_wp_s9_guider_debuff then
                    victim.taskintime_lol_wp_s9_guider_debuff:Cancel()
                    victim.taskintime_lol_wp_s9_guider_debuff = nil
                end
                victim.taskintime_lol_wp_s9_guider_debuff = victim:DoTaskInTime(TUNING.MOD_LOL_WP.GUIDER.SKILL_GUIDE.LAST,function()
                    if victim and victim.components.locomotor then
                        victim.components.locomotor:RemoveExternalSpeedMultiplier(victim,'lol_wp_s9_guider_debuff')
                    end
                end)

                for _,v in pairs(equips) do
                    if v.components.rechargeable then
                        v.components.rechargeable:Discharge(TUNING.MOD_LOL_WP.GUIDER.SKILL_GUIDE.CD)
                    end
                end
            end
        end
    end)
end)