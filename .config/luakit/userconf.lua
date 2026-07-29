--[[
# Keybinds/Commands
":tabopen URL"
"o" switch to command mode with open already typed
    if path is not url, then opens in search bar
"O" open with current url

"d" close tab
"u" undo
"B" Bookmark current page
"gb" goto bookmarks
"f" easymotion links
--]]

require "vertical_tabs"
-- require "usertheme.lua"


local engines = settings.window.search_engines
engines.duck         = "https://duckduckgo.com/?q=%s"
engines.aur          = "https://aur.archlinux.org/packages?K=%s"
engines.default = engines.duck
