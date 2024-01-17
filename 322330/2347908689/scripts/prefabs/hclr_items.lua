
local assets =
{
    Asset("ANIM", "anim/hclr_items_action.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/hclr_items.zip"),
	Asset("PKGREF", "anim/dynamic/hclr_items.dyn"),	
}

local items = {
	"hclr_thc","hclr_dragonpie","hclr_hcds","hclr_meatballs",
	"hclr_perogies","hclr_trailmix","hclr_xdhd",
}

local function builditem(name)

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)
		
		inst.Transform:SetScale(0.8, 0.8, 0.8)

        inst.AnimState:SetBank("hclr_items")
        inst.AnimState:SetBuild("hclr_items")
        inst.AnimState:PlayAnimation(name.."_item")

        MakeInventoryFloatable(inst)

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
		inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name.."_item.xml"

		inst:AddComponent("hclr_gaizao")
		inst.components.hclr_gaizao.targetprefab = name
		
        return inst
    end
    return Prefab(name.."_item", fn, assets)
end

local t = {}

for _,v in ipairs(items) do
	table.insert(assets, Asset("ATLAS", "images/inventoryimages/"..v.."_item.xml"))
	table.insert(t, builditem(v))
end
return unpack(t)
