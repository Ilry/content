GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
AddSimPostInit(function() 
    --LootTables["hound_fire"]
    if LootTables and LootTables.hound_fire then
        for i = #LootTables.hound_fire, 1 , -1 do
            if LootTables.hound_fire[i] and LootTables.hound_fire[i][1] == "houndfire" then
                table.remove(LootTables.hound_fire,i)
            end
        end
    end
end)
