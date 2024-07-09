local assets = {
	Asset("ANIM", "anim/book_fossil.zip"),
	Asset("ANIM", "anim/swap_book_fossil.zip"),
	Asset("ATLAS", "images/inventoryimages/book_fossil.xml"),
	Asset("IMAGE", "images/inventoryimages/book_fossil.tex"),
}

local prefabs = {}

local function onread(inst, reader)
	local x, y, z = reader.Transform:GetWorldPosition()
	local range = TUNING.BOOK_PETRIFYINGTOME_RANGE
	local ents = TheSim:FindEntities(x, y, z, range, nil, nil, {"petrifiable"}) 

	if #ents == 0 then
		return false, "NOSLEEPTARGETS"
	end

	for i, tree in ipairs(ents) do
		tree:DoTaskInTime(TUNING.BOOK_PETRIFYINGTOME_DELAY * math.random(), function(tree)
			if tree:IsValid() and tree.components.petrifiable then 
				tree.components.petrifiable:Petrify(true)
			end 
		end)
	end
	
	return true
end

local function onperuse(inst, reader)
	if reader.components.talker then 
		reader.components.talker:Say(GetString(reader, "ANNOUNCE_READ_BOOK","BOOK_BRIMSTONE"))
    end 
    return true 
end 

local function book_petrifyingtome()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank"book_fossil"
	inst.AnimState:SetBuild"book_fossil"
	inst.AnimState:PlayAnimation"book_fossil"
	
	inst:AddTag"book"
	inst:AddTag"bookcabinet_item"

	MakeInventoryFloatable(inst, "med", nil, 0.75)

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then return inst end
	
	inst:AddComponent"inspectable"
	inst.components.inspectable.nameoverride = "book_fossil"
	
	inst:AddComponent"book"
	inst.components.book.onread = onread
	inst.components.book.onperuse = onperuse
	
    inst.components.book:SetReadSanity(TUNING.BOOK_PETRIFYINGTOME_READ_SANITY)
    inst.components.book:SetPeruseSanity(TUNING.BOOK_PETRIFYINGTOME_PERUSE_SANITY)
	inst.components.book:SetFx("fx_book_sleep", "fx_book_sleep_mount")

	inst:AddComponent"inventoryitem"
	inst.components.inventoryitem.imagename = "book_fossil"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/book_fossil.xml"

	inst:AddComponent"finiteuses"
	inst.components.finiteuses:SetMaxUses(TUNING.BOOK_PETRIFYINGTOME_USES)
	inst.components.finiteuses:SetUses(TUNING.BOOK_PETRIFYINGTOME_USES)
	inst.components.finiteuses:SetOnFinished(inst.Remove)

	inst:AddComponent"fuel"
	inst.components.fuel.fuelvalue = TUNING.MED_FUEL

	MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
	MakeSmallPropagator(inst)

	MakeHauntableLaunch(inst)
	
	return inst
end

return Prefab("book_petrifyingtome", book_petrifyingtome, assets, prefabs)
