vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader>ef", "<cmd>Neotree focus<CR>")

-- set current root dir to working file
vim.keymap.set("n", "<leader>e.", ":Neotree dir=%:p:h reveal=false<CR>")


return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },

    config = function()
        require("neo-tree").setup({
            window = {
                width = 30,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                },
                always_show = {
                    ".",
                    "..",
                },
            },

        })
    end
}
