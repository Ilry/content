local TheWorld = GLOBAL.TheWorld
local keyidalishi = GetModConfigData("keyidalishi")
local diaosusanjilao = GetModConfigData("diaosusanjilao")
local taolundiaosu = GetModConfigData("taolundiaosu")
local jutoulingzhu = GetModConfigData("jutoulingzhu")
local tiantizuzhuang = GetModConfigData("tiantizuzhuang")
local bolidiaosu = GetModConfigData("bolidiaosu")
local qitadiaosu = GetModConfigData("qitadiaosu")
local yanshi = GetModConfigData("yanshi")
local tubiao_keyidalishi = GetModConfigData("tubiao_keyidalishi")
local tubiao_dalishi = GetModConfigData("tubiao_dalishi")
local tubiao_tiantizuzhuang = GetModConfigData("tubiao_tiantizuzhuang")
local tubiao_tiantishengdian = GetModConfigData("tubiao_tiantishengdian")
local tubiao_tiantijipin = GetModConfigData("tubiao_tiantijipin")
local tubiao_diwangxie = GetModConfigData("tubiao_diwangxie")
local tubiao_shuizhongmu = GetModConfigData("tubiao_shuizhongmu")
local tubiao_xietianweng = GetModConfigData("tubiao_xietianweng")
local tubiao_xietianweng1 = GetModConfigData("tubiao_xietianweng1")
local tubiao_yuangukeji = GetModConfigData("tubiao_yuangukeji")
local tubiao_chanchu = GetModConfigData("tubiao_chanchu")
local tubiao_yuangudamen = GetModConfigData("tubiao_yuangudamen")
if not (GLOBAL.TheNet:GetIsServer() or GLOBAL.TheNet:IsDedicated()) then return end
local jutoulingzhu_ming = {"chesspiece_moosegoose","chesspiece_bearger","chesspiece_deerclops","chesspiece_dragonfly","chesspiece_crabking","chesspiece_malbatross","chesspiece_toadstool","chesspiece_stalker","chesspiece_klaus","chesspiece_beequeen","chesspiece_antlion","chesspiece_minotaur","chesspiece_guardianphase3"}
local keyidalishi_ming = {"sculpture_rooknose","sculpture_bishophead","sculpture_knighthead"}
local diaosusanjilao_ming = {"chesspiece_rook","chesspiece_bishop","chesspiece_knight"}
local taolundiaosu_ming = {"chesspiece_hornucopia","chesspiece_pipe"}
local tiantizuzhuang_ming = {"moon_altar_idol","moon_altar_glass","moon_altar_seed","moon_altar_crown","moon_altar_ward","moon_altar_icon"}
local bolidiaosu_ming = {"glassspike_short","glassspike_med","glassspike_tall","glassspike","glassblock"}
local qitadiaosu_ming = {"chesspiece_twinsofterror","chesspiece_eyeofterror","chesspiece_catcoon","chesspiece_beefalo","chesspiece_kitcoon","chesspiece_formal","chesspiece_muse","chesspiece_pawn","chesspiece_claywarg","chesspiece_clayhound","chesspiece_anchor","chesspiece_butterfly","chesspiece_moon","chesspiece_carrat",}
local yanshi_ming = {"cavein_boulder"}
local xietianweng_ming = {"malbatross","oceanfish_shoalspawner"}
local function diaosufn(inst,xuanxiang)
	if not inst.components.inventoryitem then inst:AddComponent("inventoryitem") end
	inst.components.inventoryitem.cangoincontainer = true
	inst.components.inventoryitem.canbepickedup = true
	inst.components.inventoryitem.canonlygoinpocket = true
	if xuanxiang then if inst.components.equippable then inst:RemoveComponent("equippable") end
	else if inst.components.equippable then inst.components.equippable.walkspeedmult = 1 end end
end
if jutoulingzhu then for _,v in pairs(jutoulingzhu_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,jutoulingzhu == 2) end) end end
if keyidalishi then for _,v in pairs(keyidalishi_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,keyidalishi == 2) end) end end
if diaosusanjilao then for _,v in pairs(diaosusanjilao_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,diaosusanjilao == 2) end) end end
if taolundiaosu then for _,v in pairs(taolundiaosu_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,taolundiaosu == 2) end) end end
if tiantizuzhuang then for _,v in pairs(tiantizuzhuang_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,tiantizuzhuang == 2) end) end end
if bolidiaosu then for _,v in pairs(bolidiaosu_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,bolidiaosu == 2) end) end end
if qitadiaosu then for _,v in pairs(qitadiaosu_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,qitadiaosu == 2) end) end end
if yanshi then for _,v in pairs(yanshi_ming) do AddPrefabPostInit(v,function(inst) diaosufn(inst,yanshi == 2) end) end end
local function tubiao_diaosufn(inst) if not inst:HasTag("maprevealer") then inst:AddTag("maprevealer") end if not inst.components.maprevealer then inst:AddComponent("maprevealer") end end
if tubiao_keyidalishi then for _,v in pairs(keyidalishi_ming) do AddPrefabPostInit(v,tubiao_diaosufn) end end
if tubiao_tiantizuzhuang then for _,v in pairs(tiantizuzhuang_ming) do AddPrefabPostInit(v,tubiao_diaosufn) end end
if tubiao_tiantishengdian then
	for i,v in pairs({"moon_altar_astral_marker_1","moon_altar_astral_marker_2"}) do AddPrefabPostInit(v,function(inst)
		local ming = i == 1 and "icon" or "ward"
		if not inst.MiniMapEntity then inst.entity:AddMiniMapEntity() end inst.MiniMapEntity:SetIcon("moon_altar_"..ming.."_piece.png")--inst.MiniMapEntity:SetDrawOverFogOfWar(true)--inst.MiniMapEntity:SetCanUseCache(false)
		--if not inst.AnimState then inst.entity:AddAnimState() end inst.AnimState:SetBank("moon_altar_pieces") inst.AnimState:SetBuild("swap_altar_"..ming.."piece") inst.AnimState:PlayAnimation("anim") inst.components.maprevealer.revealperiod = 10 
		tubiao_diaosufn(inst) inst.components.maprevealer.revealperiod = 1
	end) end
end
if tubiao_tiantijipin then
	for i,v in pairs({"moon_altar_rock_glass","moon_altar_rock_idol","moon_altar_rock_seed"}) do AddPrefabPostInit(v,function(inst)
		local ming = i == 1 and "glass" or i == 2 and "idol" or "seed"
		if not inst.MiniMapEntity then inst.entity:AddMiniMapEntity() end inst.MiniMapEntity:SetIcon("moon_altar_"..ming.."_piece.png")
		tubiao_diaosufn(inst)
	end) end
end
local function xietianfn(inst) if inst.prefab == "malbatross" then if not inst.MiniMapEntity then inst.entity:AddMiniMapEntity() end inst.MiniMapEntity:SetIcon(tubiao_xietianweng1..".png") end tubiao_diaosufn(inst) if inst.prefab == "malbatross" then inst.components.maprevealer.revealperiod = 1 end end
if tubiao_diwangxie then AddPrefabPostInit("crabking",tubiao_diaosufn) end
if tubiao_shuizhongmu then AddPrefabPostInit("watertree_pillar",tubiao_diaosufn) end
if tubiao_yuangukeji then AddPrefabPostInit("ancient_altar",tubiao_diaosufn) end
if tubiao_chanchu then AddPrefabPostInit("toadstool_cap",tubiao_diaosufn) end
if tubiao_yuangudamen then AddPrefabPostInit("atrium_gate",tubiao_diaosufn) end
if tubiao_dalishi then AddPrefabPostInit("sculpture_rookbody",tubiao_diaosufn) end
if tubiao_xietianweng == 1 then AddPrefabPostInit("malbatross",xietianfn) elseif tubiao_xietianweng == 2 then for _,v in pairs(xietianweng_ming) do AddPrefabPostInit(v,xietianfn) end end
