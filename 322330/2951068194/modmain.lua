---
--- @author zsh in 2023/3/8 8:48
---

GLOBAL.setmetatable(env, { __index = function(_, k)
    return GLOBAL.rawget(GLOBAL, k);
end });

if IsRail() then
    error("Ban WeGame");
end

TUNING.RT_BUTTONS_ON = true;

TUNING.RT_BUTTONS_TUNING = {
    MOD_CONFIG_DATA = {
        button_can_be_moved = env.GetModConfigData("button_can_be_moved");
        RB = {
            switch = env.GetModConfigData("rb_switch");
            cd = env.GetModConfigData("rb_cd");
            penalty = env.GetModConfigData("rb_penalty");
        },
        TB = {
            switch = env.GetModConfigData("tb_switch");
            consume = env.GetModConfigData("tb_consume");
            admin_delete = env.GetModConfigData("tb_admin_delete");
            announce = env.GetModConfigData("tb_announce");
        }
    }
};

local config_data = TUNING.RT_BUTTONS_TUNING.MOD_CONFIG_DATA;

do
    -- TEST
    --config_data.RB.cd = 20;
    --config_data.RB.penalty = 0.5;

    --config_data.TB.consume = 2;
end

if config_data.RB.switch then
    env.modimport("modmain/revive_button.lua");
end

if config_data.TB.switch then
    env.modimport("modmain/transfer_button.lua");
end

-- TODO：跨世界面板传送？但是又要写 UI 面板好麻烦啊。