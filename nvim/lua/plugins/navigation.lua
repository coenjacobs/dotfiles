return {
	{
		-- https://github.com/ThePrimeagen/harpoon
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
			vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

			vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
			vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
			vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
			vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
			vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon file 5" })
		end,
	},
	{
		-- https://github.com/folke/which-key.nvim
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk:setup({
				delay = 300,
			})

			wk.add({
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>g", group = "Git" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>m", group = "Make/Run" },
				{ "<leader>t", group = "Terminal" },
			})
		end,
	},
	{
		-- https://github.com/akinsho/bufferline.nvim
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					show_buffer_close_icons = false,
					show_close_icon = false,
					separator_style = "thin",
				},
			})

			vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
			vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
		end,
	},
}
