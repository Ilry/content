AddPrefabPostInit("eyemaskhat", function(inst)
    if inst.components.armor then
        inst.components.armor.SetCondition = 
            function(self, amount)
                if self.indestructible then
                    return
                end

                self.condition = math.min(amount, self.maxcondition)
                if self.condition <= 0
                then
                    self.condition = 0
                    self:SetAbsorption(0)
                else
                    self:SetAbsorption(TUNING.ARMOR_FOOTBALLHAT_ABSORPTION)
                end
                self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
            end
    end
end)

AddPrefabPostInit("shieldofterror", function(inst)
    if inst.components.armor then
        inst.components.armor.SetCondition = 
            function(self, amount)
                if self.indestructible then
                    return
                end

                self.condition = math.min(amount, self.maxcondition)
                if self.condition <= 0
                then
                    self.condition = 0
                    self:SetAbsorption(0)
                else
                    self:SetAbsorption(TUNING.SHIELDOFTERROR_ABSORPTION)
                end
                self.inst:PushEvent("percentusedchange", { percent = self:GetPercent() })
            end
    end
end)