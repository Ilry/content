AddComponentPostInit('temperature',
---comment
---@param self component_temperature
function (self)
    local old_SetTemperature = self.SetTemperature
    function self:SetTemperature(value,...)
        if (self.inst and self.inst.components.inventory and self.inst.components.inventory:EquipHasTag('lol_wp_s20_frozenheart_armor')) or LOLWP_U:getEquipInEyeStone(self.inst,'lol_wp_s20_frozenheart_armor') ~= nil then

            local cur = math.floor(self:GetCurrent())
            if cur ~= TUNING.MOD_LOL_WP.lol_wp_s20_frozenheart_armor.skill_wintertouch.temperature then
                if old_SetTemperature ~= nil then
                    return old_SetTemperature(self,value,...)
                end
            else
                return
            end
        end
        return old_SetTemperature ~= nil and old_SetTemperature(self,value,...) or nil
    end
end)
