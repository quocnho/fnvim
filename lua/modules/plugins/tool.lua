local tool = {}
tool["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}
-- only for im_select user who uses non-English language during coding
tool["mg979/vim-visual-multi"] = {
	lazy = true,
	keys = {
		"<C-n>",
		"<C-N>",
		"<M-n>",
		"<S-Down>",
		"<S-Up>",
		"<M-Left>",
		"<M-i>",
		"<M-Right>",
		"<M-D>",
		"<M-Down>",
		"<C-d>",
		"<C-Down>",
		"<C-Up>",
		"<S-Right>",
		"<C-LeftMouse>",
		"<M-LeftMouse>",
		"<M-C-RightMouse>",
	},
	event = "BufReadPost",
	config = function()
		vim.g.VM_mouse_mappings = 1
		vim.g.VM_silent_exit = 0
		vim.g.VM_show_warnings = 1
		vim.g.VM_default_mappings = 1

		vim.cmd([[
    let g:VM_maps = {}
    let g:VM_maps['Select All'] = '<C-M-n>'
    let g:VM_maps["Add Cursor Down"] = '<M-Down>'
    let g:VM_maps["Add Cursor Up"] = "<M-Up>"
    let g:VM_maps["Mouse Cursor"] = "<M-LeftMouse>"
    let g:VM_maps["Mouse Word"] = "<M-RightMouse>"
    let g:VM_maps["Add Cursor At Pos"] = '<M-i>'
  ]])
	end,
}
tool["gnikdroy/projections.nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	keys = {
		{
			"<leader>fp",
			function()
				local telescope_status, telescope = pcall(require, "telescope")

				if not telescope_status then
					vim.notify("projections: cannot open telescope", vim.log.levels.ERROR)

					return
				end

				if not package.loaded["telescope._extensions.projections"] then
					telescope.load_extension("projections")
				end

				telescope.extensions.projections.projections()
			end,
			desc = "General: [f]ind the workspace [p]rojects",
		},
	},
	init = function()
		-- If vim was started with arguments, do nothing
		-- If in some project's root, attempt to restore that project's session
		-- If not, restore last session
		-- If no sessions, do nothing
		local Session = require("projections.session")
		vim.api.nvim_create_user_command("StoreProjectSession", function()
			Session.store(vim.loop.cwd())
		end, {})

		vim.api.nvim_create_user_command("RestoreProjectSession", function()
			Session.restore(vim.loop.cwd())
		end, {})
		-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
		-- 	callback = function()
		-- 		if vim.fn.argc() ~= 0 then
		-- 			return
		-- 		end
		-- 		local session_info = Session.info(vim.loop.cwd())
		-- 		if session_info == nil then
		-- 			Session.restore_latest()
		-- 		else
		-- 			Session.restore(vim.loop.cwd())
		-- 		end
		-- 	end,
		-- 	desc = "Restore last session automatically",
		-- })
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function(ev)
				if
					vim.tbl_contains({
						"git",
						"gitcommit",
						"gitrebase",
					}, vim.api.nvim_get_option_value("filetype", { buf = ev.buf }))
				then
					return
				end

				require("projections.session").store(vim.loop.cwd())
			end,
		})
		-- Autostore session on VimExit
		vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
			callback = function()
				Session.store(vim.loop.cwd())
			end,
		})

		-- Switch to project if vim was started in a project dir
		local switcher = require("projections.switcher")
		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function()
				if vim.fn.argc() == 0 then
					switcher.switch(vim.loop.cwd())
				end
			end,
		})
	end,
	config = function()
		require("projections").setup({
			workspaces = {
				{ "D:\\OneDrive - dada\\Projects", { ".git" } },
				{ "~/Developer/workspace/code", { ".git", "package.json" } },
			},
			patterns = { ".git", "package.json" },
			store_hooks = {
				pre = function()
					-- nvim-tree
					local nvim_tree_present, api = pcall(require, "nvim-tree.api")
					if nvim_tree_present then
						api.tree.close()
					end

					-- neo-tree
					if pcall(require, "neo-tree") then
						vim.cmd([[Neotree action=close]])
					end
				end,
			},
		})
	end,
}
tool["keaising/im-select.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = function()
		require("im_select").setup({
			disable_auto_restore = 0,
		})
	end,
}
tool["monaqa/dial.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	keys = {
		{
			"<C-a>",
			function()
				return require("dial.map").inc_normal()
			end,
			expr = true,
			desc = "Increment",
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_normal()
			end,
			expr = true,
			desc = "Decrement",
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.bool,
				augend.semver.alias.semver,
			},
		})
	end,
}
tool["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = require("tool.nvim-tree"),
}
tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("tool.toggleterm"),
}
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
tool["nvim-neorg/neorg"] = {
	lazy = true,
	config = require("tool.neorg"),
	ft = "norg",
	cmd = { "Neorg" },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-neorg/neorg-telescope" },
		{ "max397574/neorg-contexts" },
		{ "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } },
		{
			"lukas-reineke/headlines.nvim",
			dependencies = "nvim-treesitter/nvim-treesitter",
			ft = { "markdown", "norg" },
			config = function()
				require("headlines").setup({
					norg = {
						headline_highlights = {
							"Headline1",
							"Headline2",
							"Headline3",
							"Headline4",
							"Headline5",
							"Headline6",
						},
						codeblock_highlight = { "NeorgCodeBlock" },
					},
				})
			end,
		},
	},
}
tool["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = false,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = "BufReadPost",
			config = require("tool.project"),
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- { "nvim-telescope/telescope-frecency.nvim", dependencies = {
		-- 	{ "kkharji/sqlite.lua" },
		-- } },
		-- { "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-hop.nvim" },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = require("tool.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = require("tool.dap.dapui"),
		},
	},
}

return tool
