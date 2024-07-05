local _G = GLOBAL
_G.setmetatable(env, {__index = function(t, k) return _G.rawget(_G, k) end})

_G.CONFIG_IRG = {
    -- LANGUAGE = GetModConfigData("language"),
    STRINGENCY = GetModConfigData("stringency"),
    BALANCING = GetModConfigData("balancing"),
}

-- if _G.CONFIG_IRG.LANGUAGE == "Chinese_s" then
--     modimport("scripts/languages/stringsCh")
-- else
--     modimport("scripts/languages/stringsEn")
-- end

local function onskilltreereset(inst)
	local owner = inst.components.inventoryitem.owner
    local skilltreeupdater = owner.components.skilltreeupdater
    if skilltreeupdater then
        local skilldefs = require("prefabs/skilltree_defs").SKILLTREE_DEFS[owner.prefab]
        if skilldefs ~= nil then
            for skill, data in pairs(skilldefs) do
                skilltreeupdater:DeactivateSkill(skill)
            end
        end
        skilltreeupdater:AddSkillXP(9999999)
        owner.sg:GoToState("dochannelaction")
        owner.SoundEmitter:PlaySound("dontstarve/characters/"..owner.prefab.."/pose")
        inst:Remove()
    end
end

local function OnUseMoonRockIdol(inst)
	if inst.components.toggleableitem then
		inst.components.toggleableitem:SetOnToggleFn(OnUseMoonRockIdol)
	end
	if inst.components.useableitem then
		inst.components.useableitem:SetOnUseFn(OnUseMoonRockIdol)
	end
	if _G.CONFIG_IRG.BALANCING == true then
	    local x, y, z = inst.Transform:GetWorldPosition()
		local MOONPORTALKEY_TAG = { "moonportal" }
	    for i, v in ipairs(TheSim:FindEntities(x, y, z, 8, MOONPORTALKEY_TAG)) do
			return onskilltreereset(inst)
    	end
        local owner = inst.components.inventoryitem.owner
        owner.AnimState:PlayAnimation("emote_shrug")
        owner.SoundEmitter:PlaySound("dontstarve/characters/"..owner.prefab.."/pose")
		return nil
	else
		return onskilltreereset(inst)
	end
end

AddPrefabPostInit("moonrockidol", function(inst)
    if not _G.TheWorld.ismastersim then
        return
    end
    if _G.CONFIG_IRG.STRINGENCY == "low" then
        if not inst.components.toggleableitem then
            inst:AddComponent("toggleableitem")
        end
        inst.components.toggleableitem:SetOnToggleFn(OnUseMoonRockIdol)
    else
        if not inst.components.equippable then
            inst:AddComponent("equippable")
            inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
        end
        if not inst.components.useableitem then
            inst:AddComponent("useableitem")
        end
        inst.components.useableitem:SetOnUseFn(OnUseMoonRockIdol)
    end
end)

