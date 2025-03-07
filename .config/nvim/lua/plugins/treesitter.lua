-- Cool af vim motion here
-- Go over the nvim-treesitter dependency,
-- then type: `saib"`
--     "nvim-treesitter/nvim-treesitter",
--     dependencies = {nvim-treesitter/nvim-treesitter-context},
--     build = ":TSUpdate",


return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "html",
                "python",
                "typescript",
                "markdown"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })
    end
}
