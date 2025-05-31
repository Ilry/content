for _,v in ipairs({
    'lol_wp_s9_guider',
    'lol_wp_s9_eyestone_low',
    'lol_wp_s9_eyestone_high',
}) do
    table.insert(Assets,Asset("ATLAS",'images/map_icons/'..v..'_minimap.xml'))
    AddMinimapAtlas('images/map_icons/'..v..'_minimap.xml')
    AddPrefabPostInit(v,function (inst)
        if inst.MiniMapEntity == nil then
            inst.entity:AddMiniMapEntity()
        end
        inst.MiniMapEntity:SetIcon(v.."_minimap.tex")
        if not TheWorld.ismastersim then
            return inst
        end
    end)
end