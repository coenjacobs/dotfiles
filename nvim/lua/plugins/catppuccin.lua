return {
	-- https://github.com/catppuccin/nvim
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1001,
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
