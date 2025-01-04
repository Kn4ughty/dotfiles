vim.g.mapleader = " " -- Set leader key before Lazy

-- NvimTree requires this to be off
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")

vim.cmd.colorscheme("catppuccin")
vim.opt.termguicolors = true

-- TODO. Create a map to reload config
vim.keymap.set("n", "<leader>r", ":so $MYVIMRC<CR>")

-- Folding
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Text wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- Set up indenting with 4 spaces
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4


vim.opt.colorcolumn="80" -- column indicator

vim.opt.relativenumber = true -- Relative line numbers

vim.keymap.set("v", "<M-y>", "\"+y")    -- copy to system clipboard
vim.keymap.set("n", "<M-y>y", "\"+yy")
vim.keymap.set("n", "<M-p>", "\"+p")

-- Text movement with arrow keys
vim.keymap.set("n", "<Left>", "<<")
vim.keymap.set("n", "<Right>", ">>")
vim.keymap.set("n", "<Up>", "<cmd>m -2<CR>")
vim.keymap.set("n", "<Down>", "<cmd>m +1<CR>")

vim.keymap.set("v", "<Left>", "<gv")
vim.keymap.set("v", "<Right>", ">gv")
-- Could not get text shifting with visual mode working :(
-- vim.keymap.set("v", "<Up>",   "<cmd>m '<-2<CR>gv=gv")
-- vim.keymap.set("v", "<Down>", "<cmd>m '>+1<CR>gv=gv")

-- Add newlines with o binds
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-S-o>", "O<Esc>")


vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
            expr = true,
            replace_keycodes = false
          })
vim.g.copilot_no_tab_map = true

if vim.g.neovide then
	-- Do neovide things
	vim.o.guifont = "JetBrainsMono Nerd Font:h13"
	vim.g.neovide_transparency = 0.7
	vim.g.transparency = 0.5

	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0.5
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_vfx_mode = "ripple"
	vim.g.neovide_cursor_vfx_particle_density = 20
end
