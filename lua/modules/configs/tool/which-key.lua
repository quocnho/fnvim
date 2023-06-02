return function()
	local which_key = require("which-key")

	local setup = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		-- operators = { gc = "Comments" },
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "none", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "center", -- align columns left, center or right
		},
		ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", ":", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		triggers = "auto", -- automatically setup triggers
		-- triggers = {"<leader>"} -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
	}

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		["a"] = { ":Alpha", "Dashboard" },
		["R"] = { ":%d+<cr>", "Remove All Text" },
		["y"] = { ":%y+<cr>", "Yank All Text" },
		["e"] = { ":NvimTreeToggle<cr>", "Tree Explorer" },

		b = {
			name = "Buffer",
			p = { "<Cmd>bprevious<cr>", "Previous buffer" },
			n = { "<Cmd>bnext<cr>", "Next buffer" },
			k = { "<Cmd>BufDel<Cr>", "Kill current buffer" },
			K = { "<cmd>BufDelOthers<cr>", "Kill all buffers except current" },
			b = { "<cmd>Telescope buffers<cr>", "Buffer List" },
		},

		p = {
			name = "Package Manager",
			x = { ":Lazy clean<cr>", "Clean" },
			C = { ":Lazy check<cr>", "Check" },
			d = { ":Lazy debug<cr>", "Debug" },
			i = { ":Lazy install<cr>", "Install" },
			s = { ":Lazy sync<cr>", "Sync" },
			l = { ":Lazy log<cr>", "Log" },
			h = { ":Lazy home<cr>", "Home" },
			H = { ":Lazy help<cr>", "Help" },
			p = { ":Lazy profile<cr>", "Profile" },
			u = { ":Lazy update<cr>", "Update" },
		},

		f = {
			name = "Find",
			a = { ":Telescope autocommands<cr>", "Autocommmands" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
			f = {
				"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
				"Files",
			},
			p = { "<cmd>Telescope projects <CR>", "Projects" },
			b = { "<cmd>Telescope buffers<cr>", "Buffers" },
			h = { "<cmd>Telescope help_tags<cr>", "Help" },
			r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
			d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		},

		c = {
			name = "Code",
			a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
			e = { ":Jaq<cr>", "Execute Code" },
			x = { ":TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
			X = { ":TroubleToggle document_diagnostics<cr>", "Current buffer Diagnostics" },
			R = { ":Lspsaga rename ++project<cr>", "Rename in Project" },
			r = { ":Lspsaga rename<cr>", "Rename in current buffer" },
			o = { ":Lspsaga outline<cr>", "Code Outline" },
			f = { ":lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
			n = {
				":Lspsaga diagnostic_jump_next<cr>",
				"Next Diagnostic",
			},
			p = {
				":Lspsaga diagnostic_jump_prev<cr>",
				"Prev Diagnostic",
			},
		},

		r = {
			name = "Replace",
			r = { "<cmd>lua require('spectre').open()<cr>", "Replace in path" },
			w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
			b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace in the current Buffer" },
		},

		j = {
			name = "Java",
			t = {
				"<Cmd>lua require'jdtls'.test_nearest_method({ config = { console = 'console' }})<CR>",
				"Test Method (without Maven)",
			},
			T = {
				"<Cmd>lua require'jdtls'.test_class({ config = { console = 'console' }})<CR>",
				"Test Class (without Maven)",
			},
			u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
			d = { "<Cmd>JdtRefreshDebugConfigs<CR>", "Refresh debug config" },
			r = { "<Cmd>Jaq<CR>", "Execute Java" },
			R = { "<cmd>JdtWipeDataAndRestart<cr>", "Wipe project data and Restart server" },
			x = { "<cmd>JdtRestart<cr>", "Restart server" },
			v = { "<cmd>JdtSetRuntime<cr>", "Set runtime" },
			s = {
				":lua require('jdtls').setup_dap({ hotcodereplace = 'auto' })<cr>; :lua require'jdtls.dap'.setup_dap_main_class_configs()<cr>",
				"Setup DAP Debugger",
			},
		},

		s = {
			name = "Search String",
			b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "In current Buffer" },
			p = { "<cmd>Telescope live_grep_args theme=ivy<cr>", "In Project" },
			l = { "<cmd>Telescope resume<cr>", "Last Search" },
		},

		g = {
			name = "Git",
			g = { ":LazyGit<cr>", "Lazygit" },
			G = { ":Git<cr>", "Git Fugitive" },
			n = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
			p = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
			l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
			P = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
			r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
			R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
			s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
			u = {
				":lua require 'gitsigns'.undo_stage_hunk()<cr>",
				"Undo Stage Hunk",
			},
			o = { ":Telescope git_status<cr>", "Open changed file" },
			b = { ":Telescope git_branches<cr>", "Checkout branch" },
			c = { ":Telescope git_commits<cr>", "Checkout commit" },
			d = {
				":DiffviewOpen<cr>",
				"Open Diff",
			},
			D = {
				":DiffviewClose<cr>",
				"Close Diff",
			},
		},

		l = {
			name = "LSP - Language",
			f = { ":lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
			i = { ":LspInfo<cr>", "Info" },
			m = { ":Mason<cr>", "Install Language" },
		},

		d = {
			name = "Debug",
			c = { ":lua require'dap'.continue()<cr>", "Start/Continue" },
			o = { ":lua require'dap'.step_over()<cr>", "Step Over" },
			i = { ":lua require'dap'.step_into()<cr>", "Step Into" },
			u = { ":lua require'dap'.step_out()<cr>", "Step Out" },
			b = { ":lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
			r = { ":lua require'dap'.repl.open()<cr>", "Repl Console" },
			d = { ":lua require'dapui'.toggle()<cr>", "Dap UI" },
			t = { ":lua require'dap'.terminate()<cr>", "Terminate session" },
		},

		o = {
			name = "Open",
			f = { ":ToggleTerm direction=float<cr>", "Float Terminal" },
			t = { ":ToggleTerm size=16 direction=horizontal<cr>", "Horizontal Terminal" },
			v = { ":ToggleTerm size=50 direction=vertical<cr>", "Vertical Terminal" },
		},

		t = {
			name = "Toggle",
			w = { '<cmd>lua require("modules.utils.functions").toggle_option("wrap")<cr>', "Wrap Text" },
			r = {
				'<cmd>lua require("modules.utils.functions").toggle_option("relativenumber")<cr>',
				"Relative Code Line Numbers",
			},
			a = {
				'<cmd>lua require("modules.utils.functions").toggle_option("number")<cr>',
				"Absolute Code Line Numbers",
			},
			s = { ":FormatToggle<cr>", "Auto format on save" },
			c = { "<cmd>let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>", "ConcealLevel" },
		},

		w = {
			name = "Window",
			w = { "<C-w>w", "Last window" },
			q = { "<cmd>q!<cr>", "Kill window" },
		},
	}

	which_key.setup(setup)
	which_key.register(mappings, opts)
end
