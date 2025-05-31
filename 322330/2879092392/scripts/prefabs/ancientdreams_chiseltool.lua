local assets =
{
    Asset("ANIM", "anim/ancientdreams_chiseltool.zip"),

    Asset("IMAGE", "images/inventoryimages/ancientdreams_chiseltool.tex"),
    Asset("ATLAS", "images/inventoryimages/ancientdreams_chiseltool.xml"),
    Asset("ATLAS_BUILD", "images/inventoryimages/ancientdreams_chiseltool.xml",256),
}


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("ancientdreams_chiseltool")
    inst.AnimState:SetBuild("ancientdreams_chiseltool")
    inst.AnimState:PlayAnimation("idle")

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})
    inst:AddTag("donotautopick")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "chisel_flint"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ancientdreams_chiseltool.xml"

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(10)
    inst.components.finiteuses:SetUses(10)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("mineralchiseler")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("ancientdreams_chiseltool", fn, assets)