
local assets =
{
    Asset("ANIM", "anim/hclr_pzgz.zip"),
}

local items = {
	"hclr_pzgz",
}

local function builditem(name)

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		
		inst.Transform:SetScale(0.8, 0.8, 0.8)

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("idle")

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

		inst:AddComponent("hclr_gaizao")
		inst.components.hclr_gaizao.targetprefab = "hclr_mdlpzs"
		
        return inst
    end
    return Prefab(name, fn, assets)
end

local t = {}

for _,v in ipairs(items) do
	table.insert(assets, Asset("ATLAS", "images/inventoryimages/"..v..".xml"))
	table.insert(t, builditem(v))
end
return unpack(t)
