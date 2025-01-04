return {
	"catppuccin/nvim",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			flavor = "mocha",
		})
	end

}
