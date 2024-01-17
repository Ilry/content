local TheNet = GLOBAL.TheNet

local IsServer = TheNet:GetIsServer() or TheNet:IsDedicated()

local TUNING = GLOBAL.TUNING
local cleancycle = GetModConfigData("CLEANDAYS")

local need_clean = GetModConfigData("clean")

local Unit_hound = GetModConfigData("hound")
local Unit_firehound= GetModConfigData("firehound")
local Unit_spider = GetModConfigData("spider")
local Unit_flies = GetModConfigData("flies")
local Unit_bee = GetModConfigData("bee")
local Unit_frog = GetModConfigData("frog")
local Unit_beefalo = GetModConfigData("beefalo")
local Unit_deer = GetModConfigData("deer")
local Unit_slurtle = GetModConfigData("slurtle")
local Unit_rocky = GetModConfigData("rocky")
local Unit_evergreen_sparse = GetModConfigData("evergreen_sparse")
local Unit_twiggytree = GetModConfigData("twiggytree")
local Unit_marsh_tree = GetModConfigData("marsh_tree")
local Unit_rock_petrified_tree = GetModConfigData("rock_petrified_tree")
local Unit_skeleton_player = GetModConfigData("skeleton_player")
local Unit_spiderden = GetModConfigData("spiderden")
local Unit_burntground = GetModConfigData("burntground")
local Unit_seeds = GetModConfigData("seeds")
local Unit_log = GetModConfigData("log")
local Unit_pinecone = GetModConfigData("pinecone")
local Unit_cutgrass = GetModConfigData("cutgrass")
local Unit_twigs = GetModConfigData("twigs")
local Unit_rocks = GetModConfigData("rocks")
local Unit_nitre = GetModConfigData("nitre")
local Unit_flint = GetModConfigData("flint")
local Unit_poop = GetModConfigData("poop")
local Unit_guano = GetModConfigData("guano")
local Unit_manrabbit_tail = GetModConfigData("manrabbit_tail")
local Unit_silk = GetModConfigData("silk")
local Unit_spidergland = GetModConfigData("spidergland")
local Unit_stinger = GetModConfigData("stinger")
local Unit_houndstooth = GetModConfigData("houndstooth")
local Unit_mosquitosack = GetModConfigData("mosquitosack")
local Unit_glommerfuel = GetModConfigData("glommerfuel")
local Unit_slurtleslime = GetModConfigData("slurtleslime")
local Unit_spoiled_food = GetModConfigData("spoiled_food")
local Unit_festival = GetModConfigData("festival")
local Unit_blueprint = GetModConfigData("blueprint")
local Unit_axe = GetModConfigData("axe")
local Unit_torch = GetModConfigData("torch")
local Unit_pickaxe = GetModConfigData("pickaxe")
local Unit_hammer = GetModConfigData("hammer")
local Unit_shovel = GetModConfigData("shovel")
local Unit_razor = GetModConfigData("razor")
local Unit_pitchfork = GetModConfigData("pitchfork")
local Unit_bugnet = GetModConfigData("bugnet")
local Unit_fishingrod = GetModConfigData("fishingrod")
local Unit_spear = GetModConfigData("spear")
local Unit_earmuffshat = GetModConfigData("earmuffshat")
local Unit_winterhat = GetModConfigData("winterhat")
local Unit_heatrock = GetModConfigData("heatrock")
local Unit_trap = GetModConfigData("trap")
local Unit_birdtrap = GetModConfigData("birdtrap")
local Unit_compass = GetModConfigData("compass")
local Unit_driftwood_log = GetModConfigData("driftwood_log")
local Unit_spoiled_fish = GetModConfigData("spoiled_fish")
local Unit_rottenegg = GetModConfigData("rottenegg")
local Unit_feather = GetModConfigData("feather")
local Unit_pocket_scale = GetModConfigData("pocket_scale")
local Unit_oceanfishingrod = GetModConfigData("oceanfishingrod")
local Unit_sketch = GetModConfigData("sketch")
local Unit_tacklesketch = GetModConfigData("tacklesketch")




if IsServer then
    -- 需要清理的物品
    -- @max        地图上存在的最大数量
    -- @stack      标识为true时表示仅清理无堆叠的物品
    -- @reclean    标识为数字,表示超过第n次清理时物品还存在则强制清理(第一次找到物品并未清理的计数为1)
    local function GetLevelPrefabs()
        local levelPrefabs = {
            ------------------------  生物  ------------------------
            hound           = { max = Unit_hound },		-- 狗
            firehound       = { max = Unit_firehound },		-- 火狗
            spider_warrior  = { max = Unit_spider },		-- 蜘蛛战士
            spider          = { max = Unit_spider },		-- 蜘蛛
            flies           = { max = Unit_flies },		-- 苍蝇
            mosquito        = { max = Unit_flies },		-- 蚊子
            bee             = { max = Unit_bee },		-- 蜜蜂
            killerbee       = { max = Unit_bee },		-- 杀人蜂
            frog            = { max = Unit_frog },		-- 青蛙
            beefalo         = { max = Unit_beefalo },		-- 牛
            deer            = { max = Unit_deer },		-- 鹿
            slurtle         = { max = Unit_slurtle },		-- 鼻涕虫
            snurtle         = { max = Unit_slurtle },		-- 蜗牛
			rocky			= { max = Unit_rocky },		-- 石虾
			
			

            ------------------------  地面物体  ------------------------
            evergreen_sparse    = { max = Unit_evergreen_sparse },                      -- 常青树
            twiggytree          = { max = Unit_twiggytree },                      -- 树枝树
            marsh_tree          = { max = Unit_marsh_tree },                      -- 针刺树
            rock_petrified_tree = { max = Unit_rock_petrified_tree },                      -- 石化树
            skeleton_player     = { max = Unit_skeleton_player },                       -- 玩家尸体
            spiderden           = { max = Unit_spiderden },                       -- 蜘蛛巢
            burntground         = { max = Unit_burntground },                       -- 陨石痕跡
			
			

            ------------------------  可拾取物品  ------------------------
            seeds           = { max = Unit_seeds, stack = true, reclean = 3 },         -- 种子
            log             = { max = Unit_log, stack = true, reclean = 3 },       -- 木头
            pinecone        = { max = Unit_pinecone, stack = true, reclean = 3 },       -- 松果
            cutgrass        = { max = Unit_cutgrass, stack = true, reclean = 3 },       -- 草
            twigs           = { max = Unit_twigs, stack = true, reclean = 3 },       -- 树枝
            rocks           = { max = Unit_rocks, stack = true, reclean = 3 },       -- 石头
            nitre           = { max = Unit_nitre, stack = true, reclean = 3 },       -- 硝石
            flint           = { max = Unit_flint, stack = true, reclean = 3 },       -- 燧石
            poop            = { max = Unit_poop , stack = true, reclean = 3 },       -- 屎
            guano           = { max = Unit_guano , stack = true, reclean = 3 },       -- 鸟屎
            manrabbit_tail  = { max = Unit_manrabbit_tail , stack = true, reclean = 3 },       -- 兔毛
            silk            = { max = Unit_silk , stack = true, reclean = 3 },       -- 蜘蛛丝
            spidergland     = { max = Unit_spidergland , stack = true, reclean = 3 },       -- 蜘蛛腺体
            stinger         = { max = Unit_stinger , stack = true, reclean = 3 },       -- 蜂刺
            houndstooth     = { max = Unit_houndstooth , stack = true, reclean = 3 },       -- 狗牙
            mosquitosack    = { max = Unit_mosquitosack , stack = true, reclean = 3 },       -- 蚊子血袋
            glommerfuel     = { max = Unit_glommerfuel , stack = true, reclean = 3 },       -- 格罗姆粘液
            slurtleslime    = { max = Unit_slurtleslime , stack = true, reclean = 3 },       -- 鼻涕虫粘液
            slurtle_shellpieces = { max = Unit_slurtleslime, stack = true, reclean = 3 },   -- 鼻涕虫壳碎片

            spoiled_food    = { max = Unit_spoiled_food },                                  -- 腐烂食物

            winter_ornament_plain1 = { max = Unit_festival, stack = true, reclean = 3 }, -- 节日小饰品
            winter_ornament_plain2 = { max = Unit_festival, stack = true, reclean = 3 },
            winter_ornament_plain4 = { max = Unit_festival, stack = true, reclean = 3 },
            winter_ornament_plain5 = { max = Unit_festival, stack = true, reclean = 3 },
            winter_ornament_plain6 = { max = Unit_festival, stack = true, reclean = 3 },
            winter_ornament_plain7 = { max = Unit_festival, stack = true, reclean = 3 },
            winter_ornament_plain8 = { max = Unit_festival, stack = true, reclean = 3 },

            trinket_3   = { max = Unit_festival, stack = true, reclean = 3 },            -- 戈尔迪乌姆之结
            trinket_4   = { max = Unit_festival, stack = true, reclean = 3 },
            trinket_6   = { max = Unit_festival, stack = true, reclean = 3 },
            trinket_8   = { max = Unit_festival, stack = true, reclean = 3 },

            blueprint   = { max = Unit_blueprint },    -- 蓝图
            axe         = { max = Unit_axe },    -- 斧子
            torch       = { max = Unit_torch },    -- 火炬
            pickaxe     = { max = Unit_pickaxe },    -- 镐子
            hammer      = { max = Unit_hammer },    -- 锤子
            shovel      = { max = Unit_shovel },    -- 铲子
            razor       = { max = Unit_razor },    -- 剃刀
            pitchfork   = { max = Unit_pitchfork },    -- 草叉
            bugnet      = { max = Unit_bugnet },    -- 捕虫网
            fishingrod  = { max = Unit_fishingrod },    -- 鱼竿
            spear       = { max = Unit_spear },    -- 矛
            earmuffshat = { max = Unit_earmuffshat },    -- 兔耳罩
            winterhat   = { max = Unit_winterhat },    -- 冬帽
			heatrock    = { max = Unit_heatrock },    -- 热能石
            trap        = { max = Unit_trap },   -- 动物陷阱
            birdtrap    = { max = Unit_birdtrap },   -- 鸟陷阱
            compass     = { max = Unit_compass },    -- 指南針

            --chesspiece_deerclops_sketch     = { max = Unit_festival },    -- 四季 boss 棋子图
            --chesspiece_bearger_sketch       = { max = Unit_festival },
            --chesspiece_moosegoose_sketch    = { max = Unit_festival },
            --chesspiece_dragonfly_sketch     = { max = Unit_festival },

            winter_ornament_boss_bearger    = { max = Unit_festival },    -- 四季 boss 和蛤蟆、蜂后的挂饰
            winter_ornament_boss_beequeen   = { max = Unit_festival },
            winter_ornament_boss_deerclops  = { max = Unit_festival },
            winter_ornament_boss_dragonfly  = { max = Unit_festival },
            winter_ornament_boss_moose      = { max = Unit_festival },
            winter_ornament_boss_toadstool  = { max = Unit_festival },

			
			------------------------  added by yuuuuuxi  ------------------------
			driftwood_log			= { max = Unit_driftwood_log },		--浮木桩
			spoiled_fish			= { max = Unit_spoiled_fish  },		--变质的鱼
			spoiled_fish_small		= { max = Unit_spoiled_fish  },		--坏掉的小鱼
			rottenegg				= { max = Unit_rottenegg  },		--腐烂的蛋
			feather_crow			= { max = Unit_feather  },		--黑色羽毛
			feather_robin			= { max = Unit_feather  },		--红色羽毛
			feather_robin_winter	= { max = Unit_feather  },		--白色羽毛
			feather_canary			= { max = Unit_feather  },		--金色羽毛
			slurper_pelt			= { max = Unit_feather  },		--啜食兽毛皮
			pocket_scale			= { max = Unit_pocket_scale },		--弹簧秤
			oceanfishingrod			= { max = Unit_oceanfishingrod },		--海钓竿
			
			
			sketch					= { max = Unit_sketch },							--所有boss草图
			tacklesketch			= { max = Unit_tacklesketch },					--所有广告

			
			--万圣节糖果--
			halloweencandy_1		= { max = Unit_festival },		--苹果糖
			halloweencandy_2		= { max = Unit_festival },		--玉米糖
			halloweencandy_3		= { max = Unit_festival },		--似糖非糖玉米
			halloweencandy_4		= { max = Unit_festival },		--黏黏的蜘蛛
			halloweencandy_5		= { max = Unit_festival },		--卡通糖果
			halloweencandy_6		= { max = Unit_festival },		--葡萄干
			halloweencandy_7		= { max = Unit_festival },		--葡萄干（有包装）
			halloweencandy_8		= { max = Unit_festival },		--幽灵糖
			halloweencandy_9		= { max = Unit_festival },		--果冻虫
			halloweencandy_10		= { max = Unit_festival },		--触须棒糖
			halloweencandy_11		= { max = Unit_festival },		--巧克力猪
			halloweencandy_12		= { max = Unit_festival },		--糖果虱
			halloweencandy_13		= { max = Unit_festival },		--末世硬糖
			halloweencandy_14		= { max = Unit_festival },		--熔岩胡椒
			
			--万圣节玩具--
			trinket_32				= { max = Unit_festival },		--方晶锆石球
			trinket_33				= { max = Unit_festival },		--蜘蛛戒指
			trinket_34				= { max = Unit_festival },		--猴爪
			trinket_35				= { max = Unit_festival },		--空的万能药
			trinket_36				= { max = Unit_festival },		--人造尖牙
			trinket_37				= { max = Unit_festival },		--折断的棍子
			trinket_38				= { max = Unit_festival },		--双筒望远镜
			trinket_39				= { max = Unit_festival },		--单只手套
			trinket_40				= { max = Unit_festival },		--蜗牛尺
			trinket_41				= { max = Unit_festival },		--笨蛋罐
			trinket_42				= { max = Unit_festival },		--玩具蛇
			trinket_43				= { max = Unit_festival },		--玩具鳄鱼
			trinket_44				= { max = Unit_festival },		--坏掉的玻璃容器
			trinket_45				= { max = Unit_festival },		--老收音机
			trinket_46				= { max = Unit_festival },		--坏掉的吹风机
			
			--冬季盛宴食物--
			winter_food1			= { max = Unit_festival },		--姜饼人曲奇饼
			winter_food2			= { max = Unit_festival },		--糖屑曲奇饼
			winter_food3			= { max = Unit_festival },		--拐杖糖
			winter_food4			= { max = Unit_festival },		--永恒水果蛋糕
			winter_food5			= { max = Unit_festival },		--巧克力木头蛋糕
			winter_food6			= { max = Unit_festival },		--李子布丁
			winter_food7			= { max = Unit_festival },		--苹果酒
			winter_food8			= { max = Unit_festival },		--热可可
			winter_food9			= { max = Unit_festival },		--天堂蛋酒
			
			--冬季盛宴小饰品（8种不规则形状）--
			winter_ornament_fancy1	= { max = Unit_festival },
			winter_ornament_fancy2	= { max = Unit_festival },
			winter_ornament_fancy3	= { max = Unit_festival },
			winter_ornament_fancy4	= { max = Unit_festival },
			winter_ornament_fancy5	= { max = Unit_festival },
			winter_ornament_fancy6	= { max = Unit_festival },
			winter_ornament_fancy7	= { max = Unit_festival },
			winter_ornament_fancy8	= { max = Unit_festival },
			

			
        }

        return levelPrefabs
    end

    local function RemoveItem(inst)
        if inst.components.health ~= nil and not inst:HasTag("wall") then
            if inst.components.lootdropper ~= nil then
                inst.components.lootdropper.DropLoot = function(pt) end
            end
            inst.components.health:SetPercent(0)
        else
            inst:Remove()
        end
    end

    local function Clean(inst, level)
        if GetModConfigData("lang") then
            TheNet:Announce("清理中...")
        else
            TheNet:Announce("Now cleaning...")
        end
        print("清理内容:")
        local this_max_prefabs = GetLevelPrefabs()
        local countList = {}

        for _,v in pairs(GLOBAL.Ents) do
            if v.prefab ~= nil then
                repeat
                    local thisPrefab = v.prefab
                    if this_max_prefabs[thisPrefab] ~= nil then
                        if v.reclean == nil then
                            v.reclean = 1
                        else
                            v.reclean = v.reclean + 1
                        end

                        local bNotClean = true
                        if this_max_prefabs[thisPrefab].reclean ~= nil then
                            bNotClean = this_max_prefabs[thisPrefab].reclean > v.reclean
                        end

                        if this_max_prefabs[thisPrefab].stack and bNotClean and v.components and v.components.stackable and v.components.stackable:StackSize() > 1 then break end
                    else break end

                    -- 不可见物品(在包裹内等)
                    if v.inlimbo then break end

                    if countList[thisPrefab] == nil then
                        countList[thisPrefab] = { name = v.name, count = 1, currentcount = 1 }
                    else
                        countList[thisPrefab].count = countList[thisPrefab].count + 1
                        countList[thisPrefab].currentcount = countList[thisPrefab].currentcount + 1
                    end

                    if this_max_prefabs[thisPrefab].max >= countList[thisPrefab].count then break end

                    if (v.components.hunger ~= nil and v.components.hunger.current > 0) or (v.components.domesticatable ~= nil and v.components.domesticatable.domestication > 0) then
                        break
                    end

                    RemoveItem(v)
                    countList[thisPrefab].currentcount = countList[thisPrefab].currentcount - 1
                until true
            end
        end

        for k,v in pairs(this_max_prefabs) do
            if countList[k] ~= nil and countList[k].count > v.max then
				if GetModConfigData("ANNOUNCE_MODE") then
					TheNet:Announce(string.format("清理了   %s(%s)   %d   %d   %d", countList[k].name, k, countList[k].count, countList[k].count - countList[k].currentcount, countList[k].currentcount))
					print(string.format("清理了   %s(%s)   %d   %d   %d", countList[k].name, k, countList[k].count, countList[k].count - countList[k].currentcount, countList[k].currentcount))
				else
					print(string.format("清理了   %s(%s)   %d   %d   %d", countList[k].name, k, countList[k].count, countList[k].count - countList[k].currentcount, countList[k].currentcount))
				end
            end
        end
    end

    local function CleanDelay(inst)
        if need_clean then
            if GetModConfigData("lang") then
                TheNet:Announce("本房间将于 5 秒后清理！")
            else
                TheNet:Announce("5s until server clean.")
            end
            inst:DoTaskInTime(5, Clean)
        end
    end
	
	
	if GetModConfigData("test_mode") then
		cleancycle_ultimate = 10
	else
		cleancycle_ultimate = cleancycle * TUNING.TOTAL_DAY_TIME
	end	

	
    AddPrefabPostInit("world", function(inst)

	
        inst:DoPeriodicTask( cleancycle_ultimate , CleanDelay)
    end)
end