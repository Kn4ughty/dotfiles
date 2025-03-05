vim.keymap.set("n", "<leader>lg", ":lua Snacks.lazygit.open() <CR>")

vim.keymap.set("n", "<C-n>", ":lua Snacks.words.jump(1, true)<CR>")
vim.keymap.set("n", "<C-b>", ":lua Snacks.words.jump(-2, true)<CR>")

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {

        lazygit = { enabled = true },
        words = {
            enabled = true,
            debounce = 10, -- time in ms to wait before updating
        },
        bigfile = { enabled = true },

        terminal = { enabled = true },

        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- dashboard = { enabled = true },
        -- explorer = { enabled = true },
        -- indent = { enabled = true },
        -- input = { enabled = true },
        -- picker = { enabled = true },
        -- notifier = { enabled = true },
        -- quickfile = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
}
