local wezterm = require 'wezterm';
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha";

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_max_width = 50


config.harfbuzz_features = {
    'clig=1'
}

return config
