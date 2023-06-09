local editor = {}

editor["rainbowhxch/accelerated-jk.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("editor.accelerated-jk"),
}
-- editor["rmagatti/auto-session"] = {
-- 	tag = "v2.0.1",
-- 	lazy = true,
-- 	cmd = { "SessionSave", "SessionRestore", "SessionDelete" },
-- 	config = require("editor.auto-session"),
-- }
-- editor["nvim-orgmode/orgmode"] = {
-- 	lazy = true,
-- 	ft = "org",
-- 	dependencies = {
-- 		{
-- 			"akinsho/org-bullets.nvim",
-- 			lazy = true,
-- 			config = function()
-- 				require("org-bullets").setup()
-- 			end,
-- 		},
-- 	},
-- 	config = require("editor.orgmode"),
-- }

-- editor["joaomsa/telescope-orgmode.nvim"] = {
-- 	lazy = true,
-- }
editor["tpope/vim-repeat"] = {
	event = { "CmdlineEnter" },
	keys = { "<Plug>(RepeatDot)", "<Plug>(RepeatUndo)", "<Plug>(RepeatRedo)" },

	init = function()
		vim.fn["repeat#set"] = function(...)
			vim.fn["repeat#set"] = nil
			require("lazy").load({ plugins = { "vim-repeat" } })
			return vim.fn["repeat#set"](...)
		end
	end,
	lazy = true,
}
editor["lukas-reineke/headlines.nvim"] = {
	lazy = true,
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("editor.headlines"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}
editor["max397574/better-escape.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.better-escape"),
}
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	event = "BufReadPost",
}
editor["rhysd/clever-f.vim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("editor.cleverf"),
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["junegunn/vim-easy-align"] = {
	lazy = true,
	cmd = "EasyAlign",
}
editor["phaazon/hop.nvim"] = {
	lazy = true,
	branch = "v2",
	event = "BufReadPost",
	config = require("editor.hop"),
}
editor["luukvbaal/stabilize.nvim"] = {
	lazy = true,
	event = "BufReadPost",
}
editor["RRethy/vim-illuminate"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.vim-illuminate"),
}
editor["romainl/vim-cool"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
}
editor["windwp/nvim-spectre"] = {
	lazy = true,
	module = "spectre",
	config = function()
		require("spectre").setup()
	end,
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	config = require("editor.suda"),
}

----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command("TSUpdate")
		end
	end,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.treesitter"),
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "nvim-treesitter/nvim-treesitter-context" },
		{ "mrjones2014/nvim-ts-rainbow" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "mfussenegger/nvim-treehopper" },
		{ "andymass/vim-matchup" },
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua",
			config = require("editor.colorizer"),
		},
		{
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
	},
}

return editor
