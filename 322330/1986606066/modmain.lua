Assets = { Asset('SOUNDPACKAGE', 'sound/silence.fev'), Asset('SOUND', 'sound/silence.fsb') }

local function Hook(config_name, ...)
  if not GetModConfigData(config_name) then return end
  for _, event in ipairs({ ... }) do
    RemapSoundEvent(event, 'silence/second/one') -- replace with 1s of silence
  end
end

--------------------------------------------------------------------------------
-- Most Annoying

Hook('Flies', 'dontstarve/common/flies')
Hook('Friendly Fruit Fly', 'farming/creatures/fruitfly/LP', 'farming/creatures/fruitfly/sleep')
Hook(
  'Glommer',
  'dontstarve_DLC001/creatures/glommer/flap',
  'dontstarve_DLC001/creatures/glommer/idle_voice',
  'dontstarve_DLC001/creatures/glommer/vomit_voice',
  'dontstarve_DLC001/creatures/glommer/vomit_liquid',
  'dontstarve_DLC001/creatures/glommer/bounce_voice',
  'dontstarve_DLC001/creatures/glommer/bounce_ground',
  'dontstarve_DLC001/creatures/glommer/sleep_voice'
)
Hook('Menu', GLOBAL.FE_MUSIC)
Hook(
  'Pets Hunger Cry',
  'dontstarve_DLC001/creatures/together/kittington/disstress', -- critter_kitten / Kittykit / 浣猫崽
  'dontstarve/creatures/together/pupington/bark', -- critter_puppy / Vargling / 小座狼
  'dontstarve/creatures/together/sheepington/angry', -- critter_lamb / Ewelet / 小钢羊
  'dontstarve_DLC001/creatures/together/dragonling/angry', -- critter_dragonling / Broodling / 小龙蝇
  'dontstarve_DLC001/creatures/together/glomling/vomit_voice', -- critter_glomling / Glomglom / 小格罗姆
  'dontstarve_DLC001/creatures/together/puft/vomit_voice', -- critter_glomling skin: Puft / 喷浮飞鱼
  'dontstarve/creatures/together/perdling/distress', -- critter_perdling / Giblet / 小火鸡
  'dontstarve/creatures/together/perdling/distress_long',
  'dontstarve/creatures/together/rooster/distress', -- critter_perdling skin: Rooslet / 公鸡
  'dontstarve/creatures/together/rooster/distress_long',
  'turnoftides/creatures/together/lunarmothling/distress', -- critter_lunarmothling / Mothling / 小蛾子
  'terraria1/mini_eyeofterror/distress', -- critter_eyeofterror / Friendly Peeper / 友好窥视者
  'dontstarve/characters/walter/woby/small/bark' -- wobysmall / Woby / 沃比
)
Hook('Sawhorse', 'rifts3/sawhorse/proximity_lp', 'rifts3/sawhorse/proximity_lp_pst', 'rifts3/sawhorse/use')

--------------------------------------------------------------------------------
-- Ambience

Hook('Astral Detector', 'grotto/common/archive_resonator/idle_LP')
Hook('Bird Trap', 'dontstarve/common/birdtrap_rustle')
Hook('Celestial Orb', 'dontstarve/common/together/celestial_orb/idle_LP')
Hook('Craft Menu', 'dontstarve/HUD/research_available', 'dontstarve/HUD/recipe_ready')
Hook(
  'Daily Fight Music',
  'dontstarve/music/music_danger_ruins',
  'dontstarve/music/music_danger_cave',
  'dontstarve/music/music_danger', -- autumn
  'dontstarve/music/music_danger_winter',
  'dontstarve_DLC001/music/music_danger_spring',
  'dontstarve_DLC001/music/music_danger_summer'
)
Hook('Dock Walk', 'monkeyisland/dock/run_dock')
Hook('Dwarf Star & Polar Light', 'dontstarve/common/staff_star_LP', 'dontstarve/common/staff_coldlight_LP')
Hook(
  'Fire Consuming Shadow Hand',
  'dontstarve/sanity/shadowhand_snuff',
  'dontstarve/sanity/shadowhand_creep',
  'dontstarve/sanity/shadowhand_retreat'
)
Hook('Gloomthorn', 'meta4/ancienttree/nightvision/sway_lp', 'meta4/ancienttree/nightvision/sway_lp_nofruit')
Hook(
  'Insane & Enlightened',
  'dontstarve/sanity/sanity',
  'dontstarve/sanity/gonecrazy_stinger',
  'turnoftides/sanity/lunacy_LP',
  'dontstarve/sanity/lunacy_stinger'
)
Hook('Midsummer Cawnival', 'summerevent/music/1')
Hook('Nightberry Pulse Sound', 'meta4/ancienttree/nightvision/effect_LP')
Hook(
  'Overheating & Freezing',
  'dontstarve_DLC001/common/HUD_hot_level1',
  'dontstarve_DLC001/common/HUD_hot_level2',
  'dontstarve_DLC001/common/HUD_hot_level3',
  'dontstarve_DLC001/common/HUD_hot_level4',
  'dontstarve/winter/freeze_1st',
  'dontstarve/winter/freeze_2nd',
  'dontstarve/winter/freeze_3rd',
  'dontstarve/winter/freeze_4th'
)
Hook('Polar Bearger Bin', 'rifts3/bearger_sack/open_f5_loopstart', 'rifts3/bearger_sack/close')
Hook(
  'Queen of Moon Quay',
  'monkeyisland/monkeyqueen/receive_item',
  'monkeyisland/monkeyqueen/happy',
  'monkeyisland/monkeyqueen/channel_magic_pre',
  'monkeyisland/monkeyqueen/channel_magic_lp',
  'monkeyisland/monkeyqueen/remove_curse_success',
  'monkeyisland/monkeyqueen/remove_curse_fail',
  'monkeyisland/monkeyqueen/sleep_pre',
  'monkeyisland/monkeyqueen/sleep_lp',
  'monkeyisland/monkeyqueen/sleep_post',
  'monkeyisland/monkeyqueen/unimpressed'
)
Hook('Sandstorm', 'dontstarve/common/together/sandstorm')
Hook(
  'Season Wave Sound',
  'dontstarve/AMB/waves', -- autumn and spring
  'dontstarve/AMB/waves_winter',
  'dontstarve_DLC001/AMB/waves_summer'
)
Hook('Shadow Dimension Storage Space', 'maxwell_rework/shadow_magic/storage_void_LP')
Hook('Shell Beach Turf', 'hookline_2/amb/hermit_island')
Hook('Spark Ark (Full)', 'grotto/common/archive_security_desk/leave_LP')
Hook('Sproutrock', 'meta4/ancienttree/gemfruit/sway_lp')
Hook('Thunder', 'dontstarve/rain/thunder_close', 'dontstarve/rain/thunder_far')
Hook('Tree Growth', 'dontstarve/forest/treeGrowFromWilt', 'dontstarve/forest/treeGrow', 'dontstarve/forest/treeWilt')
Hook('Umbralla Dome', 'meta2/voidcloth_umbrella/barrier_lp', 'meta2/voidcloth_umbrella/barrier_amb')
Hook('Worm Hole', 'dontstarve/common/teleportworm/idle')
Hook(
  'W.O.B.O.T.',
  'qol1/collector_robot/pickup',
  'qol1/collector_robot/dropoff',
  'qol1/collector_robot/idle_small',
  'qol1/collector_robot/idle_med',
  'qol1/collector_robot/idle',
  'qol1/collector_robot/walk_small',
  'qol1/collector_robot/walk_med',
  'qol1/collector_robot/walk',
  'qol1/collector_robot/neutral_voice_small',
  'qol1/collector_robot/neutral_voice_med',
  'qol1/collector_robot/neutral_voice',
  'qol1/collector_robot/pickup_voice_small',
  'qol1/collector_robot/pickup_voice_med',
  'qol1/collector_robot/pickup_voice',
  'qol1/collector_robot/dropoff_voice_small',
  'qol1/collector_robot/dropoff_voice_med',
  'qol1/collector_robot/dropoff_voice'
)

--------------------------------------------------------------------------------
-- Characters

Hook('Abigail', 'dontstarve/characters/wendy/abigail/howl', 'meta5/abigail/gestalt_abigail_idle')
Hook('Battle Saddle Music', 'dontstarve/music/music_wigfrid_valkyrie')
Hook(
  'Bernie',
  'dontstarve/creatures/together/bernie/idle',
  'dontstarve/creatures/together/bernie/taunt',
  'dontstarve/creatures/together/bernie/hit',
  'dontstarve/creatures/together/bernie/death',
  'dontstarve/creatures/together/bernie/sit_up',
  'dontstarve/creatures/together/bernie/sit_down',
  'dontstarve/creatures/together/bernie/walk',
  'dontstarve/creatures/together/bernie_big/vo_atk_pre',
  'dontstarve/creatures/together/bernie_big/attack_pre',
  'dontstarve/creatures/together/bernie_big/attack',
  'dontstarve/creatures/together/bernie_big/vo_atk',
  'dontstarve/creatures/together/bernie_big/vo_taunt',
  'dontstarve/creatures/together/bernie_big/taunt',
  'dontstarve/creatures/together/bernie_big/hit',
  'dontstarve/creatures/together/bernie_big/footstep',
  'dontstarve/creatures/together/bernie_big/vo_death_drop',
  'dontstarve/creatures/together/bernie_big/death',
  'dontstarve/creatures/together/bernie_big/vo_death_collapse',
  'dontstarve/creatures/together/bernie_big/activate',
  'dontstarve/creatures/together/bernie_big/deactivate',
  'dontstarve/creatures/together/bernie_big/vo_run_start'
)
Hook('Bio Scanalyzer Chirp', 'WX_rework/scanner/ping')
Hook('Charged Elding Spear', 'meta3/wigfrid/spear_wathrithr_lightning_charged')
Hook('Chorusbox Circuit', 'WX_rework/module/musicmodule_lp')
Hook('Lucy the Axe', 'dontstarve/characters/woodie/lucytalk_LP')
Hook('Mourning Glory', 'dontstarve/characters/wendy/small_ghost/wisp')
Hook('Pipspook', 'dontstarve/characters/wendy/small_ghost/howl', 'dontstarve/characters/wendy/small_ghost/joy')
Hook('Portable Grinding Mill', 'dontstarve/common/together/portable/blender/proximity_LP')
Hook('Walter', 'dontstarve/characters/walter/talk_LP', 'dontstarve/characters/walter/carol')
Hook('Weregoose', 'dontstarve/characters/woodie/goose/flap', 'dontstarve/characters/woodie/goose/honk_LP')
Hook(
  "Winona's Catapult",
  'dontstarve/common/together/catapult/ratchet_LP',
  'dontstarve/common/together/catapult/rock_hit',
  'meta4/winona_catapult/shadow_projectile_explode',
  'meta4/winona_catapult/shadow_projectile_hit',
  'meta4/winona_catapult/lunar_projectile_explode',
  'meta4/winona_catapult/lunar_projectile_hit',
  'meta4/winona_catapult/lunar_shadow_combo_explode',
  'meta4/winona_catapult/lunar_shadow_combo_hit'
)
Hook(
  "Winona's Generator & G.E.M.erator",
  'dontstarve/common/together/battery/on_LP',
  'dontstarve/common/together/spot_light/electricity',
  'meta4/winona_battery/nightmarefuel_powered',
  'meta4/winona_battery/purebrillance_powered',
  'meta4/winona_battery/purebrillance_overloaded_lp'
)
Hook(
  'W.I.N.bot',
  'meta4/winbot/idle_lp',
  'meta4/winbot/run_lp',
  'meta4/winbot/poweron',
  'meta4/winbot/poweroff',
  'meta4/winbot/pickup',
  'meta4/winbot/dropoff'
)

--------------------------------------------------------------------------------
-- Creatures

Hook('Batilisk', 'dontstarve/creatures/bat/flap', 'dontstarve/creatures/bat/sleep', 'dontstarve/creatures/bat/taunt')
Hook(
  'Bee',
  'dontstarve/bee/bee_takeoff',
  'dontstarve/bee/bee_fly_LP',
  'dontstarve/bee/killerbee_takeoff',
  'dontstarve/bee/killerbee_fly_LP'
)
Hook(
  'Beefalo',
  'dontstarve/beefalo/walk',
  'dontstarve/beefalo/grunt',
  'dontstarve/beefalo/yell',
  'dontstarve/beefalo/tail_swish',
  'dontstarve/beefalo/curious',
  'dontstarve/beefalo/angry',
  'dontstarve/beefalo/sleep',
  'dontstarve/beefalo/beg',
  'dontstarve/beefalo/eat_treat',
  'dontstarve/beefalo/chew'
)
Hook(
  'Birds',
  'dontstarve/birds/flyin',
  'dontstarve/birds/chirp_crow', -- Crow & Polly Roger / 乌鸦、波莉·罗杰
  'dontstarve/birds/takeoff_crow',
  'dontstarve/birds/chirp_robin', -- Red Bird / 红雀
  'dontstarve/birds/takeoff_robin',
  'dontstarve/birds/chirp_junco', -- Snowbird / 雪雀
  'dontstarve/birds/takeoff_junco',
  'dontstarve/birds/chirp_canary', -- Canary / 金丝雀
  'dontstarve/birds/takeoff_canary',
  'turnoftides/birds/chirp_puffin', -- Puffin / 海鹦鹉
  'turnoftides/birds/takeoff_puffin',
  'moonstorm/creatures/mutated_robin/chirp', -- Misshapen Bird / 奇形鸟
  'moonstorm/creatures/mutated_robin/take_off',
  'moonstorm/creatures/mutated_crow/chirp', -- Moonblind Crow / 月盲乌鸦
  'moonstorm/creatures/mutated_crow/take_off'
)
Hook('Bulbous Lightbug', 'grotto/creatures/light_bug/fly_LP')
Hook('Buzzard', 'dontstarve_DLC001/creatures/buzzard/hurt')
Hook(
  'Carrat',
  'turnoftides/creatures/together/carrat/idle',
  'turnoftides/creatures/together/carrat/sleep',
  'turnoftides/creatures/together/carrat/emerge',
  'turnoftides/creatures/together/carrat/submerge',
  'turnoftides/creatures/together/carrat/stunned',
  'turnoftides/creatures/together/carrat/reaction'
)
Hook(
  'Catcoon',
  'dontstarve_DLC001/creatures/catcoon/swipe_tail',
  'dontstarve_DLC001/creatures/catcoon/hiss_pre',
  'dontstarve_DLC001/creatures/catcoon/hiss',
  'dontstarve_DLC001/creatures/catcoon/pickup',
  'dontstarve_DLC001/creatures/catcoon/hairball_hack',
  'dontstarve_DLC001/creatures/catcoon/hairball_vomit',
  'dontstarve_DLC001/creatures/catcoon/pounce_pre',
  'dontstarve_DLC001/creatures/catcoon/pounce',
  'dontstarve_DLC001/creatures/catcoon/jump',
  'dontstarve_DLC001/creatures/catcoon/yawn',
  'dontstarve_DLC001/creatures/catcoon/sleep'
)
Hook('Chester', 'dontstarve/creatures/chester/pant', 'dontstarve/creatures/chester/boing')
Hook('Dust Moth', 'grotto/creatures/dust_moth/mumble')
Hook(
  'Frog',
  'dontstarve/frog/grunt',
  'dontstarve/frog/walk',
  'rifts3/mutated_frog/grunt', -- Bright-Eyed Frog / 明眼青蛙
  'rifts3/mutated_frog/walk'
)
Hook('Gobbler', 'dontstarve/creatures/perd/gobble', 'dontstarve/creatures/perd/sleep')
Hook(
  'Grass Gekko',
  'dontstarve/creatures/together/grass_gekko/tail_off',
  'dontstarve/creatures/together/grass_gekko/tail_regrow',
  'dontstarve/creatures/together/grass_gekko/sleep_pre',
  'dontstarve/creatures/together/grass_gekko/sleep'
)
Hook(
  'Hutch',
  'dontstarve/creatures/together/hutch/pant',
  'dontstarve/creatures/together/hutch/bounce',
  'dontstarve/creatures/together/hutch/clap'
)
Hook('Koalefant Snoring', 'dontstarve/creatures/koalefant/grunt')
Hook('Mandrake', 'dontstarve/creatures/mandrake/walk')
Hook(
  'Moleworm',
  'dontstarve_DLC001/creatures/mole/sleep',
  'dontstarve_DLC001/creatures/mole/emerge',
  'dontstarve_DLC001/creatures/mole/emerge_voice',
  'dontstarve_DLC001/creatures/mole/sniff',
  'dontstarve_DLC001/creatures/mole/pickup',
  'dontstarve_DLC001/creatures/mole/jump',
  'dontstarve_DLC001/creatures/mole/retract',
  'dontstarve_DLC001/creatures/mole/move'
)
Hook('Mosquito', 'dontstarve/creatures/mosquito/mosquito_fly_LP')
Hook('Pengull', 'dontstarve/creatures/pengull/idle')
Hook(
  'Rabbit',
  'dontstarve/rabbit/hop',
  'dontstarve/rabbit/scream',
  'dontstarve/rabbit/beardscream',
  'dontstarve/rabbit/winterscream'
)
Hook('Skittersquid Run', 'hookline/creatures/squid/run')
Hook(
  'Smallbird',
  'dontstarve/creatures/smallbird/blink',
  'dontstarve/creatures/smallbird/chirp',
  'dontstarve/creatures/smallbird/chirp_short',
  'dontstarve/creatures/smallbird/scratch_ground',
  'dontstarve/creatures/smallbird/wings',
  'dontstarve/creatures/smallbird/sleep',
  'dontstarve/creatures/smallbird/wakeup'
)
Hook('Smallish Tallbird', 'dontstarve/creatures/teenbird/blink', 'dontstarve/creatures/teenbird/chirp')
Hook(
  'Spiders',
  -- prefabs/spider.lua:SoundPath() and stategraphs/SGspider.lua
  'dontstarve/creatures/spider/scream',
  'dontstarve/creatures/spider/walk_spider',
  'dontstarve/creatures/spiderwarrior/scream', -- Spider Warrior, Dangling Depth Dweller / 蜘蛛战士、穴居悬蛛
  'dontstarve/creatures/spiderwarrior/walk_spider',
  'dontstarve/creatures/cavespider/scream', -- Cave Spider， Spitter / 洞穴蜘蛛、喷射蜘蛛
  'dontstarve/creatures/cavespider/walk_spider',
  'turnoftides/creatures/together/spider_moon/scream', -- Shattered Spider / 破碎蜘蛛
  'turnoftides/creatures/together/spider_moon/walk_spider',
  'webber1/creatures/spider_cannonfodder/scream', -- Nurse Spider / 护士蜘蛛
  'webber1/creatures/spider_cannonfodder/walk_spider',
  -- stategraphs/SGspider_water.lua
  'waterlogged1/creatures/spider_water/scream', -- Sea Strider / 海黾
  'waterlogged1/creatures/spider_water/walk_spider',
  'waterlogged1/creatures/spider_water/walk_water'
)
Hook('Tentacle', 'dontstarve/tentacle/tentacle_rumble_LP')
Hook('Wobster & Lunar Wobster Swim', 'hookline_2/creatures/wobster/step')

--------------------------------------------------------------------------------
-- Equipment

Hook('Bone Armor', 'dontstarve/movement/foley/bone')
Hook('Brightshade Armor', 'dontstarve/movement/foley/lunarplantarmour_foley')
Hook('Krampus Sack', 'dontstarve/movement/foley/krampuspack')
Hook('Morning Star', 'dontstarve_DLC001/common/morningstar')
Hook('Night Armor', 'dontstarve/movement/foley/nightarmour')
Hook('Thulecite Suit & W.A.R.B.I.S. Armor', 'dontstarve/movement/foley/metalarmour')

--------------------------------------------------------------------------------
-- Structure

Hook('Alchemy Engine', 'dontstarve/common/researchmachine_lvl2_idle_LP')
Hook('Bee Box', 'dontstarve/bee/bee_box_LP')
Hook('Brightsmithy', 'rifts/forge/proximity_lp', 'rifts/forge/proximity_pst', 'rifts/forge/use')
Hook(
  'Florid Postern & Celestial Portal',
  'dontstarve/common/together/spawn_vines/spawnportal_idle_LP',
  'dontstarve/common/together/spawn_vines/spawnportal_jacob',
  'dontstarve/common/together/spawn_vines/spawnportal_blink',
  'dontstarve/common/together/spawn_vines/vines'
)
Hook('Ice Crystaleyezer', 'rifts3/oculus_ice_radius/ambient_lp')
Hook(
  'Ice Flingomatic',
  'dontstarve_DLC001/common/firesupressor_idle',
  'dontstarve_DLC001/common/firesupressor_chuff',
  'dontstarve_DLC001/common/firesupressor_spin',
  'dontstarve_DLC001/common/firesupressor_shoot',
  'dontstarve_DLC001/common/firesupressor_impact' -- on snowball hit ground
)
Hook(
  'Moon Dial',
  'dontstarve/common/together/moondial/full_LP',
  'dontstarve/common/together/moondial/fill',
  'dontstarve/common/together/moondial/water_movement'
)
Hook('Night Light', 'dontstarve/common/nightlight')
Hook('Scaled Furnace', 'dontstarve/common/together/dragonfly_furnace/fire_LP')
Hook('Shadow Manipulator', 'dontstarve/common/researchmachine_lvl3_idle_LP')
Hook(
  'Shadowcraft Plinth',
  'rifts2/shadow_forge/proximity_lp',
  'rifts2/shadow_forge/proximity_pst',
  'rifts2/shadow_forge/use'
)
Hook('Tackle Receptacle', 'hookline/common/tackle_station/proximity_LP')
Hook('Telelocator Focus', 'dontstarve/common/telebase_hum')
Hook('Terra Firma Tamper', 'grotto/common/turf_crafting_station/prox_LP')
Hook('Think Tank', 'turnoftides/common/together/seafaring_prototyper/LP')
