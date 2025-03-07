return {
    "echasnovski/mini.ai",
    dependencies = { 'echasnovski/mini.surround', version = false },
    version = false,
    config = function()
        require('mini.ai').setup()
        require('mini.surround').setup()
    end
}
-- { 'echasnovski/mini.nvim', version = false },
