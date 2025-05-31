local DEPLOY_DICT = {
    ["carnivaldecor_figure_kit"] = "carnivaldecor_figure",
    ["moonbutterfly"] = "moonbutterfly_sapling",
    ["portablecookpot_item"] = "portablecookpot",
    ["asparagus_seeds"] = "farm_plant_asparagus",
    ["boat_magnet_kit"] = "boat_magnet",
    ["carnivaldecor_lamp_kit"] = "carnivaldecor_lamp",
    ["eggplant_seeds"] = "farm_plant_eggplant",
    ["carnivalgame_puckdrop_kit"] = "carnivalgame_puckdrop_station",
    ["carnivalcannon_confetti_kit"] = "carnivalcannon_confetti",
    ["yotr_fightring_kit"] = "yotr_fightring",
    ["yotc_carrat_scale_item"] = "yotc_carrat_scale",
    ["boat_item"] = "boat",
    ["carnivaldecor_plant_kit"] = "carnivaldecor_plant",
    ["mast_malbatross_item"] = "mast_malbatross",
    ["dug_berrybush2"] = "collapse_small",
    ["carnivaldecor_eggride4_kit"] = "carnivaldecor_eggride4",
    ["boat_bumper_shell_kit"] = "boat_bumper_shell",
    ["boat_cannon_kit"] = "boat_cannon",
    ["minisign_drawn"] = "minisign",
    ["yotc_carrat_gym_direction_item"] = "yotc_carrat_gym_direction",
    ["durian_seeds"] = "farm_plant_durian",
    ["lureplantbulb"] = "lureplant",
    ["yotc_carrat_race_checkpoint_item"] = "yotc_carrat_race_checkpoint",
    ["fossil_piece"] = "fossil_stalker",
    ["yotr_decor_2_item"] = "yotr_decor_2",
    ["carnival_plaza_kit"] = "carnival_plaza",
    ["carnivaldecor_eggride1_kit"] = "carnivaldecor_eggride1",
    ["dug_sapling_moon"] = "sapling_moon",
    ["dug_trap_starfish"] = "trap_starfish",
    ["carnivaldecor_banner_kit"] = "carnivaldecor_banner",
    ["fence_item"] = "fence",
    ["seeds"] = "farm_plant_randomseed",
    ["carnivalgame_wheelspin_kit"] = "carnivalgame_wheelspin_station",
    ["kitcoondecor1_kit"] = "kitcoondecor1",
    ["dug_marsh_bush"] = "marsh_bush",
    ["boat_grass_item"] = "boat_grass",
    ["anchor_item"] = "anchor",
    ["yotb_stage_item"] = "yotb_stage",
    ["yotc_carrat_race_start_item"] = "yotc_carrat_race_start",
    ["carnivaldecor_figure_kit_season2"] = "carnivaldecor_figure_season2",
    ["onion_seeds"] = "farm_plant_onion",
    ["minisign_item"] = "minisign",
    ["farm_plow_item"] = "farm_plow",
    ["pinecone"] = "pinecone_sapling",
    ["carnivaldecor_eggride3_kit"] = "carnivaldecor_eggride3",
    ["watermelon_seeds"] = "farm_plant_watermelon",
    ["dug_sapling"] = "sapling",
    ["wall_moonrock_item"] = "wall_moonrock",
    ["boat_bumper_kelp_kit"] = "boat_bumper_kelp",
    ["yotc_carrat_gym_reaction_item"] = "yotc_carrat_gym_reaction",
    ["yotb_post_item"] = "yotb_post",
    ["wall_stone_2_item"] = "wall_stone_2",
    ["garlic_seeds"] = "farm_plant_garlic",
    ["yotr_decor_1_item"] = "yotr_decor_1",
    ["yotc_carrat_race_finish_item"] = "yotc_carrat_race_finish",
    ["yotb_sewingmachine_item"] = "yotb_sewingmachine",
    ["wx78_scanner_item"] = "wx78_scanner",
    ["carnivalgame_memory_kit"] = "carnivalgame_memory_station",
    ["rock_avocado_fruit_sprout"] = "rock_avocado_fruit_sprout_sapling",
    ["fence_gate_item"] = "fence_gate",
    ["beefalo_groomer_item"] = "beefalo_groomer",
    ["kitcoondecor2_kit"] = "kitcoondecor2",
    ["palmcone_seed"] = "palmcone_sapling",
    ["butterfly"] = "flower",
    ["fossil_piece_clean"] = "fossil_stalker",
    ["wall_ruins_2_item"] = "wall_ruins_2",
    ["wall_ruins_item"] = "wall_ruins",
    ["wall_wood_item"] = "wall_wood",
    ["acorn"] = "acorn_sapling",
    ["potato_seeds"] = "farm_plant_potato",
    ["carrot_seeds"] = "farm_plant_carrot",
    ["corn_seeds"] = "farm_plant_corn",
    ["pepper_seeds"] = "farm_plant_pepper",
    ["pumpkin_seeds"] = "farm_plant_pumpkin",
    ["dragonfruit_seeds"] = "farm_plant_dragonfruit",
    ["tomato_seeds"] = "farm_plant_tomato",
    ["yotc_carrat_gym_stamina_item"] = "yotc_carrat_gym_stamina",
    ["bullkelp_root"] = "bullkelp_plant",
    ["wall_hay_item"] = "wall_hay",
    ["trap_teeth_maxwell"] = "trap_teeth_maxwell",
    ["portabletent_item"] = "portabletent",
    ["carnivaldecor_eggride2_kit"] = "carnivaldecor_eggride2",
    ["marblebean"] = "marblebean_sapling",
    ["steeringwheel_item"] = "steeringwheel",
    ["carnival_prizebooth_kit"] = "carnival_prizebooth",
    ["spidereggsack"] = "spiderden",
    ["dug_berrybush_juicy"] = "berrybush_juicy",
    ["portablespicer_item"] = "portablespicer",
    ["twiggy_nut"] = "twiggy_nut_sapling",
    ["dug_rock_avocado_bush"] = "rock_avocado_bush",
    ["wall_stone_item"] = "wall_stone",
    ["archive_resonator_item"] = "archive_resonator",
    ["carnivalgame_feedchicks_kit"] = "carnivalgame_feedchicks_station",
    ["beemine"] = "beemine",
    ["carnivalgame_herding_kit"] = "carnivalgame_herding_station",
    ["mast_item"] = "mast",
    ["carnivalcannon_sparkle_kit"] = "collapse_small",
    ["trap_bramble"] = "trap_bramble",
    ["carnivalgame_shooting_kit"] = "carnivalgame_shooting_station",
    ["boat_rotator_kit"] = "boat_rotator",
    ["pomegranate_seeds"] = "farm_plant_pomegranate",
    ["kitcoonden_kit"] = "kitcoonden",
    ["carnivalcannon_streamer_kit"] = "carnivalcannon_streamer",
    ["yotc_carrat_gym_speed_item"] = "yotc_carrat_gym_speed",
    ["eyeturret_item"] = "eyeturret",
    ["dug_monkeytail"] = "monkeytail",
    ["portableblender_item"] = "portableblender",
    ["livingtree_root"] = "livingtree_sapling",
    ["dock_woodposts_item"] = "dock_woodposts",
    ["dug_bananabush"] = "bananabush",
    ["dug_grass"] = "grass",
    ["dug_berrybush"] = "berrybush",
    ["ocean_trawler_kit"] = "ocean_trawler",
    ["trap_teeth"] = "trap_teeth",
}

DEPLOY_DICT.bspj_cmd = [[
    local d = {};
    local ex = { quagmire_parkspike = 1, quagmire_parkspike_short = 1 };
    local n = 0;
    local pt = Vector3(100, 0, 100)
    for k, v in pairs(Prefabs) do
        if v.fn and ex[k] ~= 1 then
            local inst = SpawnPrefab(k);
            if inst and inst:IsValid() and inst.components.deployable and string.find(k, 'turf_') == nil then
                local r = inst.components.deployable:DeploySpacingRadius()
                n = n + 1;
                if inst.components.deployable.ondeploy then
                    inst.components.deployable.ondeploy(inst, pt, nil, 0)
                end
                local entities = TheSim:FindEntities(pt.x, pt.y, pt.z, 1)
                local target
                if #entities > 0 then
                    target = entities[1].prefab
                end
                for _, ent in ipairs(entities) do
                    ent:Remove()
                end
                inst:Remove();
                table.insert(d, { k, r, target });
            end
        end
    end
    print(n, #d);
    local file = io.open('unsafedata/' .. 'deployable_prefabs.json', 'w');
    file:write(json.encode(d));
    file:close();
]]

return DEPLOY_DICT
