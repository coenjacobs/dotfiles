return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
			"lua",
			"php",
			"html",
			"javascript",
			"typescript",
			"tsx",
			"css",
			"json",
			"yaml",
			"markdown",
			"bash",
			"vim",
			"vimdoc",
		},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
