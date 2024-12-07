local assets = {
    Asset("ANIM", "anim/wonderbox.zip"),
    Asset("ANIM", "anim/wonderbox_green.zip"),
    Asset("ANIM", "anim/wonderbox_red.zip"),
    Asset("ANIM", "anim/wonderbox_purple.zip"),
    Asset("ANIM", "anim/wonderbox_white.zip"),
    Asset("ATLAS", "images/inventoryimages/why_wonderbox.xml"),
    Asset("IMAGE", "images/inventoryimages/why_wonderbox.tex"),
    Asset("ATLAS", "images/inventoryimages/wonderbox_green.xml"),
    Asset("IMAGE", "images/inventoryimages/wonderbox_green.tex"),
    Asset("ATLAS", "images/inventoryimages/wonderbox_red.xml"),
    Asset("IMAGE", "images/inventoryimages/wonderbox_red.tex"),
    Asset("ATLAS", "images/inventoryimages/wonderbox_purple.xml"),
    Asset("IMAGE", "images/inventoryimages/wonderbox_purple.tex"),
    Asset("ATLAS", "images/inventoryimages/wonderbox_white.xml"),
    Asset("IMAGE", "images/inventoryimages/wonderbox_white.tex"),
}

--Ilaskus: Open/Close sounds are placeholders. If it is to be kept, please delete this comment.
local function onopen(inst)
    inst.SoundEmitter:PlaySound("hookline_2/characters/hermit/tacklebox/large_open")
    inst.AnimState:PlayAnimation("open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("close")
    inst.SoundEmitter:PlaySound("hookline_2/characters/hermit/tacklebox/large_close")
end

local function onpicked(inst)
    inst.components.container:Close()
    inst.AnimState:PlayAnimation("closed", false)
end

local function ondropped(inst)
    inst.AnimState:PlayAnimation("close")
    inst.AnimState:PushAnimation("closed", false)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, "med", 0.1, 0.70)
    inst.AnimState:SetBank("wonderbox")
    inst.AnimState:SetBuild("wonderbox")
    inst.AnimState:PlayAnimation("closed")

    inst.entity:SetPristine()

    inst:AddTag("portablestorage")

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = function(inst)
            inst.replica.container:WidgetSetup("why_wonderbox")
        end
        return inst
    end

    inst:AddComponent("inspectable")
    inst.AnimState:PlayAnimation("closed")
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("why_wonderbox")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container.droponopen = true

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "why_wonderbox"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/why_wonderbox.xml"
    inst.components.inventoryitem:SetOnPutInInventoryFn(onpicked)
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)

    MakeHauntableLaunch(inst)

    return inst
end
local name1
if TUNING.WHY_LANGUAGE == "spanish" then
    name1 = "El Tesoro Del Señor"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name1 = "主的宝藏"
else
    name1 = "Lord's Treasure"
end
WonderAPI.MakeItemSkin("why_wonderbox","wonderbox_red",{
    name = name1,
    atlas = "images/inventoryimages/wonderbox_red.xml",
    image = "wonderbox_red",
    build = "wonderbox_red",
    rarity = "Elegant",
    bank =  "wonderbox_red",
    basebuild = "wonderbox",
    basebank =  "wonderbox",
})

local name2
if TUNING.WHY_LANGUAGE == "spanish" then
    name2 = "El Tesoro Del Señor"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name2 = "深渊克拉肯"
else
    name2 = "Abyssal Krakenchest"
end
WonderAPI.MakeItemSkin("why_wonderbox","wonderbox_purple",{
    name = name2,
    atlas = "images/inventoryimages/wonderbox_purple.xml",
    image = "wonderbox_purple",
    build = "wonderbox_purple",
    rarity = "Spiffy",
    bank =  "wonderbox_purple",
    basebuild = "wonderbox",
    basebank =  "wonderbox",
})

local name
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "Tortuga Afortunada"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name = "招财龟"
else
    name = "Green Treasury"
end
WonderAPI.MakeItemSkin("why_wonderbox","wonderbox_green",{
    name = name,
    atlas = "images/inventoryimages/wonderbox_green.xml",
    image = "wonderbox_green",
    build = "wonderbox_green",
    rarity = "Loyal",
    bank =  "wonderbox_green",
    basebuild = "wonderbox",
    basebank =  "wonderbox",
})

local name3
if TUNING.WHY_LANGUAGE == "spanish" then
    name = "Tortuga Afortunada"
elseif TUNING.WHY_LANGUAGE == "chinese" then
    name3 = "琉璃双头羊"
else
    name3 = "Deux chèvres de verre"
end
WonderAPI.MakeItemSkin("why_wonderbox","wonderbox_white",{
    name = name3,
    atlas = "images/inventoryimages/wonderbox_white.xml",
    image = "wonderbox_white",
    build = "wonderbox_white",
    rarity = "Distinguished",
    bank =  "wonderbox_white",
    basebuild = "wonderbox",
    basebank =  "wonderbox",
})

return Prefab("why_wonderbox", fn, assets)