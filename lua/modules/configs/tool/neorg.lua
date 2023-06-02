return function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {
				config = {
					icon_preset = "diamond",
				},
			},
			["core.keybinds"] = {
				config = {
					default_keybinds = true,
					neorg_leader = ",",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						log = "~/OneDrive/Documents/neorg/log",
						projects = "~/OneDrive/Documents/neorg/projects",
						wiki = "~/OneDrive/Documents/neorg/wiki",
					},
					default_workspace = "wiki",
				},
			},
			["core.journal"] = {
				config = {
					workspace = "notes",
					journal_folder = "journal",
					strategy = "nested",
				},
			},
			["core.export"] = {},
			["core.export.markdown"] = {
				config = {
					extensions = "all",
				},
			},
			["core.integrations.telescope"] = {},
			["core.completion"] = { config = { engine = "nvim-cmp" } },
			["core.presenter"] = { config = { zen_mode = "zen-mode" } },
			["external.context"] = {},
			["external.templates"] = {},
		},
	})
end
