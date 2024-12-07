AddTile(
        "WHY_CHURCH_TURF_BLUE",
        "LAND",
        {ground_name = "why_church_turf_blue"},
        {
            name="meteor",
            atlas="meteor.xml",
            noise_texture="why_church_turf.tex",
            runsound="turnoftides/movement/run_meteor",
            walksound="turnoftides/movement/run_meteor",
            snowsound="dontstarve/movement/run_ice",
            mudsound="dontstarve/movement/run_mud",
        },
        {
            name="map_edge",
            atlas="meteor.xml",
            noise_texture="why_church_turf",
        },
        {
            name = "why_church_turf",
            anim = "why_church_turf_blue",
            bank_build = "why_church_turf_blue",
            pickupsound = "gem",
        }
)

AddTile(
        "WHY_CHURCH_TURF_PINK",
        "LAND",
        {ground_name = "why_church_turf_pink"},
        {
            name="meteor",
            atlas="meteor.xml",
            noise_texture="why_church_turf_pink.tex",
            runsound="turnoftides/movement/run_meteor",
            walksound="turnoftides/movement/run_meteor",
            snowsound="dontstarve/movement/run_ice",
            mudsound="dontstarve/movement/run_mud",
        },
        {
            name="map_edge",
            atlas="meteor.xml",
            noise_texture="why_church_turf_pink",
        },
        {
            name = "why_church_turf_pink",
            anim = "why_church_turf_pink",
            bank_build = "why_church_turf_pink",
            pickupsound = "gem",
        }
)

AddTile(
        "WHY_CHURCH_TURF_RED",
        "LAND",
        {ground_name = "why_church_turf_red"},
        {
            name="meteor",
            atlas="meteor.xml",
            noise_texture="why_church_turf_red.tex",
            runsound="turnoftides/movement/run_meteor",
            walksound="turnoftides/movement/run_meteor",
            snowsound="dontstarve/movement/run_ice",
            mudsound="dontstarve/movement/run_mud",
        },
        {
            name="map_edge",
            atlas="meteor.xml",
            noise_texture="why_church_turf_red",
        },
        {
            name = "why_church_turf_red",
            anim = "why_church_turf_red",
            bank_build = "why_church_turf_red",
            pickupsound = "gem",
        }
)

AddTile(
        "WHY_CHURCH_TURF_GREEN",
        "LAND",
        {ground_name = "why_church_turf_green"},
        {
            name="meteor",
            atlas="meteor.xml",
            noise_texture="why_church_turf_green.tex",
            runsound="turnoftides/movement/run_meteor",
            walksound="turnoftides/movement/run_meteor",
            snowsound="dontstarve/movement/run_ice",
            mudsound="dontstarve/movement/run_mud",
        },
        {
            name="map_edge",
            atlas="meteor.xml",
            noise_texture="why_church_turf_green",
        },
        {
            name = "why_church_turf_green",
            anim = "why_church_turf_green",
            bank_build = "why_church_turf_green",
            pickupsound = "gem",
        }
)

AddTile(
        "WHY_CHURCH_TURF_PURPLE",
        "LAND",
        {ground_name = "why_church_turf_purple"},
        {
            name="meteor",
            atlas="meteor.xml",
            noise_texture="why_church_turf_purple.tex",
            runsound="turnoftides/movement/run_meteor",
            walksound="turnoftides/movement/run_meteor",
            snowsound="dontstarve/movement/run_ice",
            mudsound="dontstarve/movement/run_mud",
        },
        {
            name="map_edge",
            atlas="meteor.xml",
            noise_texture="why_church_turf_purple",
        },
        {
            name = "why_church_turf_purple",
            anim = "why_church_turf_purple",
            bank_build = "why_church_turf_purple",
            pickupsound = "gem",
        }
)



ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_BLUE,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_BLUE,GLOBAL.WORLD_TILES.MUD)
ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_RED,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_RED,GLOBAL.WORLD_TILES.MUD)
ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_PINK,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_PINK,GLOBAL.WORLD_TILES.MUD)
ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_RED,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_RED,GLOBAL.WORLD_TILES.MUD)
ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_GREEN,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_GREEN,GLOBAL.WORLD_TILES.MUD)
ChangeTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_PURPLE,GLOBAL.WORLD_TILES.MUD)
ChangeMiniMapTileRenderOrder(GLOBAL.WORLD_TILES.WHY_CHURCH_TURF_PURPLE,GLOBAL.WORLD_TILES.MUD)

AddPrefabPostInit("turf_why_church_turf",function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/why_church_turf.xml"
        inst.components.inventoryitem.imagename = "why_church_turf"
    end
end)

AddPrefabPostInit("turf_why_church_turf_pink",function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/why_church_turf_pink.xml"
        inst.components.inventoryitem.imagename = "why_church_turf_pink"
    end
end)

AddPrefabPostInit("turf_why_church_turf_red",function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/why_church_turf_red.xml"
        inst.components.inventoryitem.imagename = "why_church_turf_red"
    end
end)

AddPrefabPostInit("turf_why_church_turf_green",function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/why_church_turf_green.xml"
        inst.components.inventoryitem.imagename = "why_church_turf_green"
    end
end)

AddPrefabPostInit("turf_why_church_turf_purple",function(inst)
    if not TheWorld.ismastersim then
        return inst
    end
    if inst.components.inventoryitem ~= nil then
        inst.components.inventoryitem.atlasname = "images/inventoryimages/why_church_turf_purple.xml"
        inst.components.inventoryitem.imagename = "why_church_turf_purple"
    end
end)
