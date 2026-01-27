return {
	{
		-- https://github.com/akinsho/toggleterm.nvim
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
				},
			})

			-- Terminal mode mappings
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			-- Custom terminal types
			local Terminal = require("toggleterm.terminal").Terminal

			-- Lazygit terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "curved",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})

			function _G.toggle_lazygit()
				lazygit:toggle()
			end

			-- Keymaps
			vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
			vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
			vim.keymap.set("n", "<leader>lg", "<cmd>lua toggle_lazygit()<cr>", { desc = "Lazygit" })
		end,
	},
}
