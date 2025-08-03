local builtin = require('telescope.builtin')

require('telescope').load_extension('projects')

-- vim.keymap.set('n', '<leader>fp', ":lua require 'telescope'.extensions.projects.projects {}<CR>")
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

return {
    -- 'nvim-telescope/telescope.nvim',
    -- tag = '0.1.8',
    -- -- or                              , branch = '0.1.x',
    -- dependencies = { 'nvim-lua/plenary.nvim' }
}
