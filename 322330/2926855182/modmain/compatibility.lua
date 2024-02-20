---
--- @author zsh in 2023/2/1 11:06
---

--[[ Show Me ]]
do
    local comm = { "treasurechest", true };
    ---@type table<string,table[]>
    local t = {
        ["critter_kitten"] = comm,
        ["critter_lamb"] = comm,
        ["critter_puppy"] = comm,
        ["critter_glomling"] = comm,
        ["critter_eyeofterror"] = comm,
    };

    --遍历已开启的 mod
    for _, mod in pairs(ModManager.mods) do
        if mod and mod.SHOWME_STRINGS then
            for k, v in pairs(t) do
                if v[2] then
                    mod.postinitfns.PrefabPostInit[k] = mod.postinitfns.PrefabPostInit[v[1]];
                end
            end
        end
    end

    TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {};
    for k, v in pairs(t) do
        if v[2] then
            TUNING.MONITOR_CHESTS[k] = true;
        end
    end
end



--[[ 能力勋章 ]]
do
    STRINGS.NAMES[("pets_buff_critter_puppy"):upper()] = "小座狼攻伐之力";
    STRINGS.NAMES[("pets_buff_sanityregenbuff"):upper()] = "小格罗姆糖豆之力";
    STRINGS.NAMES[("pets_buff_critter_glomling_sanity_against"):upper()] = "小格罗姆御守之力";
    STRINGS.NAMES[("pets_buff_critter_eyeofterror_molehat"):upper()] = "友好窥视者明目之力";
end