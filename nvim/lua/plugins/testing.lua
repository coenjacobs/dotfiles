return {
	{
		-- https://github.com/tpope/vim-dispatch
		"tpope/vim-dispatch",
		cmd = { "Dispatch", "Make", "Focus", "Start" },
		keys = {
			{ "<leader>mm", "<cmd>Make<cr>", desc = "Run make" },
			{ "<leader>md", ":Dispatch ", desc = "Run command" },
		},
		config = function()
			-- vim-dispatch uses makeprg by default
			-- You can set project-specific makeprg in .nvim.lua or via autocmds
		end,
	},
}
