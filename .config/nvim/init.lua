-- Thank you https://github.com/boltlessengineer/NativeVim/

vim.o.relativenumber = true
vim.o.number = true

vim.opt.scrolloff = 5

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.completeopt = "menu,menuone,popup,fuzzy" -- modern completion menu
vim.o.pumheight = 10        -- max height of completion menu

vim.o.winborder = "rounded"
vim.o.splitright = true

vim.o.list = true           -- use special characters to represent things like tabs or trailing spaces
vim.opt.listchars = {       -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
    tab = "▏ ",
    trail = "·",
    extends = "»",
    precedes = "«",
}

vim.o.undofile = true
vim.o.undolevels = 10000 -- 10x more undo levels

vim.o.termguicolors = true

vim.o.signcolumn = "yes:1"

vim.g.netrw_banner = 1

-- Regular binds
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

vim.keymap.set("n", "<leader>r", ":so<CR>")

-- Packages
-- -- Catppuccin
vim.pack.add({"https://github.com/catppuccin/nvim"}, {
	flavour = "mocha"})

vim.cmd.colorscheme "catppuccin"

-- -- Snacks

vim.keymap.set("n", "<leader>e", ":lua Snacks.explorer()<CR>")
vim.keymap.set("n", "<leader>t", ":lua Snacks.terminal()<CR>")
vim.keymap.set("n", "<leader>g", ":lua Snacks.lazygit.open() <CR>")

vim.keymap.set("n", "<leader><space>", ":lua Snacks.picker.smart()<CR>", {desc = 'Smart'})
vim.keymap.set("n", "<leader>/", ":lua Snacks.picker.grep()<CR>", {desc = 'Grep'})

vim.keymap.set("n", "<leader>fr", ":lua Snacks.picker.recent()<CR>", {desc = 'Recent'})
vim.keymap.set("n", "<leader>fl", ":lua Snacks.picker.lines()<CR>", {desc = 'Lines'})
vim.keymap.set("n", "<leader>fb", ":lua Snacks.picker.buffers()<CR>", {desc = 'Buffers'})
vim.keymap.set("n", "<leader>fh", ":lua Snacks.picker.help()<CR>", {desc = 'Help'})
vim.keymap.set("n", "<leader>fp", ":lua Snacks.picker.projects()<CR>", {desc = 'Projects'})

vim.keymap.set("n", "<leader>fd", ":lua Snacks.diagnostics_buffer()<CR>", {desc = 'Diagnostics buffer'})

vim.pack.add({"https://github.com/folke/snacks.nvim"}, {
    lazygit = {
        enabled = true,
    },
    words = {
        enabled = true,
        debounce = 10, -- time in ms to wait before updating
    },
    indent = {
        enabled = true,
        animate = {
            -- enabled = vim.fn.has("nvim-0.10") == 1,
            enabled = false,
            style = "out",
            easing = "linear",
            duration = {
                step = 20,   -- ms per step
                total = 500, -- maximum duration
            },
            -- style = "out",
            -- easing = "quart"
        }
    },
    explorer = { enabled = true },
    picker = {
        hidden= true,
        enabled = true,
        optional = true,
        sources = {
            explorer = {
            },
            files = {}
        }
    },
    terminal = { enabled = true },
    -- indent = { enabled = true },
    -- bigfile = { enabled = true },
    -- image = { enabled = true },
    -- input = { enabled = true },
    -- dashboard = { enabled = true },
    -- notifier = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
})

require("snacks").setup()
Snacks.indent.enable()
Snacks.words.enable()
-- Snacks.explorer.enable()

-- -- Lspconfig
vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})

-- -- Mason
vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
})
require("mason").setup()

-- -- -- Mason lsp
vim.pack.add({
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

require("mason-lspconfig").setup()
