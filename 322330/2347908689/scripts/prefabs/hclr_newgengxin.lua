
local assets =
{
    Asset("ANIM", "anim/hc_newgengxin.zip"),
}

local items = {
	hclr_icelevel2 = "hclr_superice2",
    hclr_icelevel1 = "hclr_superice1" ,
    hclr_mulevel1 = "hclr_supermu1" ,
    hclr_mulevel2 = "hclr_supermu2",
    hclr_kjk = "hclr_kjk",
}

local function builditem(name,target)

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		
		inst.Transform:SetScale(0.8, 0.8, 0.8)

        inst.AnimState:SetBank("hc_newgengxin")
        inst.AnimState:SetBuild("hc_newgengxin")
        inst.AnimState:PlayAnimation(name)

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"

        if name ~= "hclr_kjk"  then
		    inst:AddComponent("hclr_gaizao")
		    inst.components.hclr_gaizao.targetprefab = target
        else
            inst:AddComponent("lrhc_wxnj_use")
        end
		
        return inst
    end
    return Prefab(name, fn, assets)
end

local t = {}

for k,v in pairs(items) do
	table.insert(assets, Asset("ATLAS", "images/inventoryimages/"..k..".xml"))
	table.insert(t, builditem(k,v))
end
return unpack(t)
