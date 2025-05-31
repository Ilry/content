local data = require('core_lol_wp/data/player_timer')
local modid = 'lol_wp'
---@type number # 0~1
local cd_mult = TUNING[string.upper('CONFIG_'..modid..'special_settings_nocd')]
---@type boolean
local nocd_allow_all = TUNING[string.upper('CONFIG_'..modid..'special_settings_nocd_allitems')]

if nocd_allow_all then
    cd_mult = .2
end
-------------
for prefab,v in pairs(data.rechargeable.members) do
    AddPrefabPostInit(prefab,function (inst)
        inst:AddTag(prefab)
        if not TheWorld.ismastersim then
            return inst
        end
        if inst.components.rechargeable then
            local old_Discharge = inst.components.rechargeable.Discharge
            function inst.components.rechargeable:Discharge(chargetime,...)
                chargetime = chargetime * cd_mult
                if not inst.player_timer_rechargeable_do_orig_thing then
                    local owner = LOLWP_S:GetOwnerReal(inst)
                    if owner and owner.components.player_timer then
                        local allow = false
                        local only_allow_avatars = data.rechargeable.members[prefab].only_allow_avatars
                        if only_allow_avatars then
                            if only_allow_avatars[owner.prefab] then
                                allow = true
                            end
                        else
                            allow = true
                        end
                        if allow then
                            owner.components.player_timer:WhenItemCD('rechargeable',prefab,chargetime,inst)
                        end
                    end
                end
                return old_Discharge(self,chargetime,...)
            end
        end

        local flag_dropped_once_or_never_putininv = true
        inst:ListenForEvent('onputininventory',function ()
            if flag_dropped_once_or_never_putininv then
                flag_dropped_once_or_never_putininv = false
                local owner = LOLWP_S:GetOwnerReal(inst)
                if owner and owner.components.player_timer then
                    local allow = false
                    local only_allow_avatars = data.rechargeable.members[prefab].only_allow_avatars
                    if only_allow_avatars then
                        if only_allow_avatars[owner.prefab] then
                            allow = true
                        end
                    else
                        allow = true
                    end
                    if allow then
                        owner.components.player_timer:WhenGetItem('rechargeable',prefab,inst)
                    end
                end
            end
        end)
        inst:ListenForEvent('ondropped',function ()
            flag_dropped_once_or_never_putininv = true
        end)

    end)
end

AddComponentPostInit('rechargeable',
---comment
---@param self component_rechargeable
function (self)
    local old_Discharge = self.Discharge
    function self:Discharge(chargetime,...)
        if data.rechargeable.members[self.inst.prefab] then
        else
            chargetime = chargetime * (nocd_allow_all and cd_mult or 1)
        end
        return old_Discharge(self,chargetime,...)
    end
end)

--------------
for prefab,v in pairs(data.lol_wp_cd_itemtile.members) do
    AddPrefabPostInit(prefab,function (inst)
        if not TheWorld.ismastersim then
            return inst
        end
        if inst.components.lol_wp_cd_itemtile then
            local old_ForceStartCD = inst.components.lol_wp_cd_itemtile.ForceStartCD
            function inst.components.lol_wp_cd_itemtile:ForceStartCD(cd,...)
                -- if cd ~= nil then
                    cd = cd * cd_mult
                -- end
                if not inst.player_timer_lol_wp_cd_itemtile_do_orig_thing then
                    local owner = LOLWP_S:GetOwnerReal(inst)
                    if owner and owner.components.player_timer then
                        owner.components.player_timer:WhenItemCD('lol_wp_cd_itemtile',prefab,cd,inst)
                    end
                end
                return old_ForceStartCD(self,cd,...)
            end
        end

        local flag_dropped_once_or_never_putininv = true
        inst:ListenForEvent('onputininventory',function ()
            if flag_dropped_once_or_never_putininv then
                flag_dropped_once_or_never_putininv = false
                local owner = LOLWP_S:GetOwnerReal(inst)
                if owner and owner.components.player_timer then
                    owner.components.player_timer:WhenGetItem('lol_wp_cd_itemtile',prefab,inst)
                end
            end
        end)
        inst:ListenForEvent('ondropped',function ()
            flag_dropped_once_or_never_putininv = true
        end)

    end)
end

--------------
for prefab,v in pairs(data.gallop_brokenking_frogblade_cd.members) do
    AddPrefabPostInit(prefab,function (inst)
        if not TheWorld.ismastersim then
            return inst
        end
        if inst.components.gallop_brokenking_frogblade_cd then
            local old_StartCD = inst.components.gallop_brokenking_frogblade_cd.StartCD
            function inst.components.gallop_brokenking_frogblade_cd:StartCD(val,...)
                val = val * cd_mult
                if not inst.player_timer_gallop_brokenking_frogblade_cd_do_orig_thing then
                    local owner = LOLWP_S:GetOwnerReal(inst)
                    if owner and owner.components.player_timer then
                        owner.components.player_timer:WhenItemCD('gallop_brokenking_frogblade_cd',prefab,val,inst)
                    end
                end
                return old_StartCD(self,val,...)
            end
        end

        local flag_dropped_once_or_never_putininv = true
        inst:ListenForEvent('onputininventory',function ()
            if flag_dropped_once_or_never_putininv then
                flag_dropped_once_or_never_putininv = false
                local owner = LOLWP_S:GetOwnerReal(inst)
                if owner and owner.components.player_timer then
                    owner.components.player_timer:WhenGetItem('gallop_brokenking_frogblade_cd',prefab,inst)
                end
            end
        end)
        inst:ListenForEvent('ondropped',function ()
            flag_dropped_once_or_never_putininv = true
        end)
    end)
end



AddPlayerPostInit(function (inst)
    if not TheWorld.ismastersim then
        return inst
    end
    inst:AddComponent('player_timer')
end)