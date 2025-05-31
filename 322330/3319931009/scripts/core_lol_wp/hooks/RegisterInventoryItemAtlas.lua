
for _,v in ipairs({
    -- S7
    'lol_wp_s7_cull',
    'lol_wp_s7_obsidianblade',
    'lol_wp_s7_doranblade',
    'lol_wp_s7_doranshield',
    'lol_wp_s7_doranring',
    'lol_wp_s7_tearsofgoddess',

    'lol_wp_trinity',
    'lol_wp_sheen',
    'lol_wp_divine',
    'lol_wp_overlordbloodarmor',
    'lol_wp_demonicembracehat',
    'lol_wp_warmogarmor',
    --s8
    'lol_wp_s8_deathcap',
    'lol_wp_s8_uselessbat',
    'lol_wp_s8_lichbane',
    --s9
    'lol_wp_s9_guider',
    'lol_wp_s9_eyestone_low',
    'lol_wp_s9_eyestone_high',
    --s10
    'lol_wp_s10_guinsoo',
    'lol_wp_s10_blastingwand',
    'lol_wp_s10_sunfireaegis',
    'lol_wp_s10_sunfireaegis_armor',
    -- s11
	'lol_wp_s11_amplifyingtome',
	'lol_wp_s11_darkseal',
	'lol_wp_s11_mejaisoulstealer',
    -- s12
    'lol_wp_s12_eclipse',
    'lol_wp_s12_malignance',
    -- 'alchemy_chainsaw',
	-- s13
	'lol_wp_s13_infinity_edge',
	'lol_wp_s13_statikk_shiv',
	'lol_wp_s13_statikk_shiv_charged',
	'lol_wp_s13_collector',
	'lol_wp_s13_infinity_edge_amulet',
	-- s14
    'lol_wp_s14_bramble_vest',
	'lol_wp_s14_thornmail',
	'lol_wp_s14_hubris',

    "lol_wp_s15_crown_of_the_shattered_queen",
    "lol_wp_s15_stopwatch",
    "lol_wp_s15_zhonya",
    "lol_wp_s16_potion_hp",
    "lol_wp_s16_potion_compound",
    "lol_wp_s16_potion_corruption",
    "lol_wp_s17_luden",
    "lol_wp_s17_liandry",
    "lol_wp_s17_lostchapter",
    "lol_wp_s18_bloodthirster",
    "lol_wp_s18_stormrazor",
    "lol_wp_s18_krakenslayer",
    "lol_wp_s19_archangelstaff",
    "lol_wp_s19_muramana",
    "lol_wp_s19_muramana_upgrade",
    "lol_wp_s19_fimbulwinter_armor",
    "lol_wp_s19_fimbulwinter_armor_upgrade",
    -- s20
    'lol_wp_s20_iceborngauntlet_shield',
    'lol_wp_s20_wardenmail_armor',
    'lol_wp_s20_frozenheart_armor',
}) do
    RegisterInventoryItemAtlas("images/inventoryimages/"..v..".xml", v..".tex")
end