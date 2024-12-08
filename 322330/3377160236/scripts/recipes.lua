AddRecipe2(
        "sisters_stories",
        {Ingredient("papyrus", 3), Ingredient("ghostflower", 3)}, TECH.NONE,
        {
            atlas="images/inventoryimages/sisters_stories.xml",
            image="sisters_stories.tex",
            builder_skill="wendy_sisters_stories"
        },
        {"CHARACTER", "MAGIC"}
)

local function fn(recipe)
    recipe.builder_tag = "wendy_ori"
end

AddRecipePostInit("ghostlyelixir_attack", fn)

AddRecipe2(
        "ghostlyelixir_attack_enhance",
        {Ingredient("stinger", 1), Ingredient("ghostflower", 1)}, TECH.NONE,
        {
            product = "ghostlyelixir_attack",
            numtogive = 1,
            builder_skill="wendy_elixir_enhance"
        },
        {"CHARACTER"}
)

AddRecipe2(
        "medical_box",
        {Ingredient("log", 2), Ingredient("rope", 3), Ingredient("ghostflower", 3)}, TECH.NONE,
        {
            atlas="images/inventoryimages/medical_box.xml",
            image="medical_box.tex",
            builder_skill="wendy_elixir_bag"
        },
        {"CHARACTER", "CONTAINERS"}
)
