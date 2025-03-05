vim.keymap.set("n", "<leader>o", "", { desc = 'Overseer' })

vim.keymap.set("n", "<leader>or", ":OverseerRun <CR>")
vim.keymap.set("n", "<leader>ot", ":OverseerToggle <CR>")

return {
    'stevearc/overseer.nvim',
    opts = {},
}
