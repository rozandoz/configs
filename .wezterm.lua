local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- window
config.window_decorations = 'TITLE|RESIZE'
config.hide_tab_bar_if_only_one_tab = true;
config.window_frame = { font_size = 13.0 }
config.color_scheme = 'OneDark (base16)'

-- fonts
config.font = wezterm.font('JetBrains Mono')
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = 14;

-- shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'powershell.exe', '-NoLogo' }
end

-- binds
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    { key = 't', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
    { key = 'v', mods = 'CTRL',   action = wezterm.action.PasteFrom 'Clipboard' },
}

-- plugins
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

return config
