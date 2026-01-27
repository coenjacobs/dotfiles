return {
	{
		-- https://github.com/tpope/vim-fugitive
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gstatus", "Gblame", "Gdiff" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
		},
	},
	{
		-- https://github.com/lewis6991/gitsigns.nvim
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 500,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then return "]h" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })

					map("n", "[h", function()
						if vim.wo.diff then return "[h" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, { expr = true, desc = "Previous hunk" })

					-- Actions
					map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
					map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
					map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
					map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
					map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
				end,
			})
		end,
	},
	{
		-- https://github.com/sindrets/diffview.nvim
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
			{ "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
		},
		config = function()
			require("diffview").setup({
				use_icons = true,
			})
		end,
	},
}
