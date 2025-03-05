vim.keymap.set("n", "<leader>g", ":lua Snacks.lazygit.open() <CR>")

vim.keymap.set("n", "<C-n>", ":lua Snacks.words.jump(1, true)<CR>")
vim.keymap.set("n", "<C-b>", ":lua Snacks.words.jump(-2, true)<CR>")

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {

        lazygit = {
            enabled = true,
            configure = true,
            -- extra configuration for lazygit that will be merged with the default
            -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
            -- you need to double quote it: `"\"test\""`
            config = {
                os = { editPreset = "nvim-remote" },
                gui = {
                    -- set to an empty string "" to disable icons
                    nerdFontsVersion = "3",
                },
            },
            -- theme_path = svim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
            -- Theme for lazygit
            theme = {
                [241]                      = { fg = "Special" },
                activeBorderColor          = { fg = "MatchParen", bold = true },
                cherryPickedCommitBgColor  = { fg = "Identifier" },
                cherryPickedCommitFgColor  = { fg = "Function" },
                defaultFgColor             = { fg = "Normal" },
                inactiveBorderColor        = { fg = "FloatBorder" },
                optionsTextColor           = { fg = "Function" },
                searchingActiveBorderColor = { fg = "MatchParen", bold = true },
                selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
                unstagedChangesColor       = { fg = "DiagnosticError" },
            },
            win = {
                style = "lazygit",
            },

        },
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
