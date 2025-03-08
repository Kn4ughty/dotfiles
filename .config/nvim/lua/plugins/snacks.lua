-- https://github.com/folke/snacks.nvim

vim.keymap.set("n", "<leader>g", ":lua Snacks.lazygit.open() <CR>")

vim.keymap.set("n", "<C-n>", ":lua Snacks.words.jump(1, true)<CR>")
vim.keymap.set("n", "<C-b>", ":lua Snacks.words.jump(-2, true)<CR>")


vim.keymap.set("n", "<leader>fr", ":lua Snacks.picker.recent()<CR>")


-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "<leader><space>", ":lua Snacks.picker.smart()<CR>")
vim.keymap.set("n", "<leader>fl", ":lua Snacks.picker.lines()<CR>")
vim.keymap.set("n", "<leader>fb", ":lua Snacks.picker.buffers()<CR>")
vim.keymap.set("n", "<leader>fh", ":lua Snacks.picker.help()<CR>")


return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {

        lazygit = {
            enabled = true,
        },

        words = {
            enabled = true,
            debounce = 10, -- time in ms to wait before updating
        },

        bigfile = { enabled = true },

        terminal = { enabled = true },

        image = { enabled = true },

        indent = {
            enabled = true,
            animate = {
                enabled = vim.fn.has("nvim-0.10") == 1,
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

        quickfile = { enabled = true },

        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    -- { icon = " ", key = "p", desc = "Projects", action = "<leader>fp" },
                    -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                    -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
                header = [[Neovim!]]
            },
        },
        -- explorer = { enabled = true },
        -- indent = { enabled = true },
        -- input = { enabled = true },
        picker = { enabled = true },
        -- notifier = { enabled = true },
        -- scope = { enabled = true },
        -- scroll = { enabled = true },
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
}
