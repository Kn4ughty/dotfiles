vim.g.mapleader = " " -- Set leader key before Lazy

require("config.lazy")

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")


-- Folding
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- vim.opt.clipboard = "unnamedplus"

-- Text wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- scroll buffer above and below cursor
vim.opt.scrolloff = 5

-- Allow incrementing characters. ex. ia<Esc><C-a> a -> b
vim.opt.nrformats = "alpha"

-- Set up indenting with 4 spaces
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.colorcolumn = "120"    -- column indicator
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.number = true
-- left side padding to fix lsp resizing things
vim.opt.signcolumn = "yes:1"

-- Mapping to exit terminal with control + escape
-- tnoremap <Esc> <C-\><C-n>
-- This mess stolen from https://github.com/niyabits/nvy/blob/main/lua/utils.lua
local M = {}

function M.noremap(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end

function M.nnoremap(lhs, rhs) M.noremap('n', lhs, rhs) end

function M.tnoremap(lhs, rhs) M.noremap('t', lhs, rhs) end

M.tnoremap("<C-Esc>", "<C-\\><C-n>")

-- TODO. Create a map to reload config
vim.keymap.set("n", "<leader>r", ":so $MYVIMRC<CR>", { desc = "Reload vimrc" })

vim.keymap.set("v", "<M-y>", "\"+y") -- copy to system clipboard
vim.keymap.set("n", "<M-y>y", "\"+yy")
vim.keymap.set("n", "<M-p>", "\"+p")

vim.keymap.set("i", "<C-V>", "\"+p")

-- Text movement with arrow keys
vim.keymap.set("n", "<Left>", "<<")
vim.keymap.set("n", "<Right>", ">>")
vim.keymap.set("n", "<Up>", "<cmd>m -2<CR>")
vim.keymap.set("n", "<Down>", "<cmd>m +1<CR>")

vim.keymap.set("v", "<Left>", "<gv")
vim.keymap.set("v", "<Right>", ">gv")


-- Add newlines with o binds
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-S-o>", "O<Esc>")

-- Toggle spellcheck


vim.keymap.set("n", "<leader>s", ":setlocal spell spelllang=en_au<CR>", { desc = "Turn on spellchecl" })


vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- Do neovide things
if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h11"
    vim.g.neovide_scale_factor = 1.0

    vim.keymap.set("n", "<C-+>", ":lua vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor + 0.1)<CR>")
    vim.keymap.set("n", "<C-_>", ":lua vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor - 0.1)<CR>")

    vim.g.transparency = 0.5

    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.5
    vim.g.neovide_cursor_animate_command_line = false

    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_cursor_vfx_particle_density = 1.0
    vim.g.neovide_cursor_vfx_opacity = 200.0

    local pad = 0
    vim.g.neovide_padding_top = pad
    vim.g.neovide_padding_bottom = pad
    vim.g.neovide_padding_right = pad
    vim.g.neovide_padding_left = pad

    local blur = 5
    vim.g.neovide_floating_blur_amount_x = blur
    vim.g.neovide_floating_blur_amount_y = blur
end

require('overseer').setup()
