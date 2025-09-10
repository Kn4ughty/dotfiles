-- Thank you https://github.com/boltlessengineer/NativeVim/
-- TODO. Speed up install by putting all pack.adds into one function
local vim = vim -- hide errors stupidly
vim.o.relativenumber = true
vim.o.number = true

vim.o.cursorline = true
-- vim.o.cursorcolumn = true

vim.opt.scrolloff = 5

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.completeopt = "menu,menuone,popup,fuzzy" -- modern completion menu
vim.o.pumheight = 10                           -- max height of completion menu

vim.o.winborder = "rounded"
vim.o.splitright = true

vim.o.list = true     -- use special characters to represent things like tabs or trailing spaces
vim.opt.listchars = { -- NOTE: using `vim.opt` instead of `vim.o` to pass rich object
    tab = "▏ ",
    trail = "·",
    extends = "»",
    precedes = "«",
}

vim.o.undofile = true
vim.o.undolevels = 10000 -- 10x more undo levels

vim.o.ignorecase = true

vim.o.termguicolors = true

vim.o.signcolumn = "yes:1"

vim.g.netrw_banner = 1



-- Regular binds
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<cr>")

vim.keymap.set("n", "<leader>r", ":so<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

vim.api.nvim_set_keymap("t", "<C-Esc>", "<C-\\><C-n>", {noremap = true, silent = true})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        -- Alternate, use <C-w>d
        vim.keymap.set('n', 'gK', function()
            local new_config = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config({ virtual_lines = new_config })
        end, { desc = 'Toggle diagnostic virtual_lines' })

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'gp', '<cmd>lua line_diagnostics()<cr>', opts)

        vim.keymap.set('n', 'ln', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        vim.keymap.set('n', 'lp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    end,
})

-- Packages
-- -- Catppuccin
vim.pack.add({ "https://github.com/catppuccin/nvim" }, {
    flavour = "mocha" })

vim.cmd.colorscheme "catppuccin"

-- -- Snacks

vim.keymap.set("n", "<leader>e", ":lua Snacks.explorer()<CR>")
vim.keymap.set("n", "<leader>t", ":lua Snacks.terminal()<CR>")
vim.keymap.set("n", "<leader>g", ":lua Snacks.lazygit.open() <CR>")

vim.keymap.set("n", "<leader><space>", ":lua Snacks.picker.smart()<CR>", { desc = 'Smart' })
vim.keymap.set("n", "<leader>/", ":lua Snacks.picker.grep()<CR>", { desc = 'Grep' })

vim.keymap.set("n", "<leader>fr", ":lua Snacks.picker.recent()<CR>", { desc = 'Recent' })
vim.keymap.set("n", "<leader>fl", ":lua Snacks.picker.lines()<CR>", { desc = 'Lines' })
vim.keymap.set("n", "<leader>fb", ":lua Snacks.picker.buffers()<CR>", { desc = 'Buffers' })
vim.keymap.set("n", "<leader>fh", ":lua Snacks.picker.help()<CR>", { desc = 'Help' })
vim.keymap.set("n", "<leader>fp", ":lua Snacks.picker.projects()<CR>", { desc = 'Projects' })

vim.keymap.set("n", "<leader>fd", ":lua Snacks.diagnostics_buffer()<CR>", { desc = 'Diagnostics buffer' })

vim.pack.add({ "https://github.com/folke/snacks.nvim" }, {
    lazygit = {
        enabled = true,
    },
    words = {
        enabled = false,
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
        hidden = true,
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

-- Treesitter
vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- Dropbar
vim.pack.add({
    { src = "https://github.com/Bekaboo/dropbar.nvim",
}})

local dropbar_api = require('dropbar.api')
vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })

-- cmp
vim.pack.add({
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/hrsh7th/nvim-cmp',
})

local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    },
    {
        { name = 'buffer' },
    })
})
