APIARY = {
    SHOULDHARVEST = GetModConfigData("harvest") or false,
    HARVESTPROTECTION = GetModConfigData("protection") or false,
    PRESERVABLE = {
        bee = true, killerbee = true, petals = true, petals_evil = true, honey = true, royal_jelly = true,
        cherry_bee = true, cherry_honey = true, -- Cherry Forest
        medal_withered_royaljelly = true, -- Functional Medal
    },
    WORKER = { "bee", "killerbee", "cherry_bee", }, -- HasTag("bee")
    PETALS = { "petals", "petals_evil", },
    FEED = { "petals", "petals_evil", "honey", "cherry_honey", },
    -- PERMANENT = { "honey", "royal_jelly", "cherry_honey", "medal_withered_royaljelly", }, -- HasTag("honeyed")
}
