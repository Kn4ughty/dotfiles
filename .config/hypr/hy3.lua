local hy3 = hl.plugin.hy3

-- all factories return dispatcher functions and dispatchers return no values
-- option tables are optional except for focus_tab

hy3.make_group("h" | "v" | "tab" | "opposite", {
	toggle = true | false,              -- default: false
	ephemeral = true | false | "force", -- default: false
})

hy3.change_group("h" | "v" | "tab" | "untab" | "toggletab" | "opposite")

hy3.set_ephemeral(true | false | "true" | "false")

hy3.move_focus("l" | "r" | "u" | "d" | "left" | "right" | "up" | "down", {
	visible = true | false, -- default: false
	warp = true | false,    -- default: follows cursor:no_warps
})

hy3.toggle_focus_layer({
	warp = true | false, -- default: true
})

hy3.warp_cursor()

hy3.move_window("l" | "r" | "u" | "d" | "left" | "right" | "up" | "down", {
	once = true | false,    -- default: false
	visible = true | false, -- default: false
})

hy3.move_to_workspace("<workspace>", {
	follow = true | false, -- default: false
	warp = true | false,   -- default: follows cursor:no_warps when follow = true
})

hy3.change_focus("top" | "bottom" | "raise" | "lower" | "tab" | "tabnode")

-- direction and index are mutually exclusive
hy3.focus_tab({
	direction = "l" | "r" | "left" | "right",
	mouse = "ignore" | "prioritize_hovered" | "require_hovered", -- default: "ignore"
	wrap = true | false, -- default: false
})

hy3.focus_tab({
	index = <number>,
	mouse = "ignore" | "prioritize_hovered" | "require_hovered", -- default: "ignore"
	wrap = true | false, -- default: false
})

hy3.set_swallow(true | false | "true" | "false" | "toggle")

hy3.kill_active()

hy3.expand("expand" | "shrink" | "base" | "maximize" | "fullscreen", {
	fullscreen = "" | "intermediate_maximize" | "fullscreen_maximize" | "maximize_only",
})

hy3.lock_tab(nil | "" | "toggle" | "lock" | "unlock")

hy3.equalize({
	scope = "" | "group" | "workspace", -- default: "group"
	workspace = true | false,           -- overrides scope if present
	recursive = true | false,           -- overrides workspace if present
})

hy3.debug_nodes()
