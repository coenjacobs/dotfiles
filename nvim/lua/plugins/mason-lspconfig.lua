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
				ensure_installed = { "lua_ls", "ts_ls", "phpactor", "cssls", "html" },
			})
		end,
	},
	{
		-- https://github.com/neovim/nvim-lspconfig
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Configure LSP servers using the new vim.lsp.config API
			vim.lsp.config('lua_ls', { capabilities = capabilities })
			vim.lsp.config('ts_ls', { capabilities = capabilities })
			vim.lsp.config('phpactor', { capabilities = capabilities })
			vim.lsp.config('cssls', { capabilities = capabilities })
			vim.lsp.config('html', { capabilities = capabilities })

			-- Enable the servers
			vim.lsp.enable({ 'lua_ls', 'ts_ls', 'phpactor', 'cssls', 'html' })

			-- LSP keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- Diagnostic keymaps
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

			-- Diagnostic display settings
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
