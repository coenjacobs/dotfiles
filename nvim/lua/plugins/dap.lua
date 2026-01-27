return {
	{
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		dependencies = {
			-- https://github.com/rcarriga/nvim-dap-ui
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			-- https://github.com/theHamsta/nvim-dap-virtual-text
			"theHamsta/nvim-dap-virtual-text",
			-- https://github.com/jay-babu/mason-nvim-dap.nvim
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue/Start" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
			{ "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Mason DAP setup
			require("mason-nvim-dap").setup({
				ensure_installed = { "js-debug-adapter", "php-debug-adapter" },
				automatic_installation = true,
				handlers = {},
			})

			-- DAP UI setup
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- Virtual text setup
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
			})

			-- DAP UI keymaps
			vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
			vim.keymap.set({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "Evaluate expression" })

			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- JavaScript/TypeScript adapter configuration
			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			-- PHP adapter configuration
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = {
					require("mason-registry").get_package("php-debug-adapter"):get_install_path() .. "/extension/out/phpDebug.js",
				},
			}

			dap.configurations.php = {
				{
					type = "php",
					request = "launch",
					name = "Listen for Xdebug",
					port = 9003,
					pathMappings = {
						["/var/www/html"] = "${workspaceFolder}",
					},
				},
			}

			-- Breakpoint signs
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
		end,
	},
}
