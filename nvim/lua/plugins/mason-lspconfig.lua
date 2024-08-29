return {
	{
		-- https://github.com/williamboman/mason.nvim
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- https://github.com/williamboman/mason-lspconfig.nvim
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "tsserver", "phpactor" },
			})
		end,
	},
	{
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})
			-- js/ts
			lspconfig.tsserver.setup({
				capabilities = capabilities
			})
			-- php
			lspconfig.phpactor.setup({
				capabilities = capabilities
			})

			-- keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
