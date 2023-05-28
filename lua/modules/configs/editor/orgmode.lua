return function()
	vim.cmd("set foldlevel=2")

	require("orgmode").setup_ts_grammar()
	require("nvim-treesitter.configs").setup({
		-- If TS highlights are not enabled at all, or disabled via `disable` prop,
		-- highlighting will fallback to default Vim syntax highlighting
		highlight = {
			enable = true,
			-- Required for spellcheck, some LaTex highlights and
			-- code block highlights that do not have ts grammar
			additional_vim_regex_highlighting = { "org" },
		},
		ensure_installed = { "org" }, -- Or run :TSUpdate org
	})
	require("orgmode").setup({
		org_agenda_files = { "~/OneDrive/Documents/org/*", "~/OneDrive/Documents/my-orgs/**/*" },
		org_default_notes_file = "~/OneDrive/Documents/org/refile.org",
		-- mappings = {
		--   -- global = {
		--   --   org_agenda = { "gA", "<Leader>oa" },
		--   --   org_capture = { "gC", "<Leader>oc" },
		--   -- },
		--   -- agenda = {
		--   --   org_agenda_later = ">",
		--   --   org_agenda_earlier = "<",
		--   --   org_agenda_goto_today = { ".", "T" },
		--   -- },
		--   -- capture = {
		--   --   org_capture_finalize = "<Leader>w",
		--   --   org_capture_refile = "R",
		--   --   org_capture_kill = "Q",
		--   -- },
		--   --
		--   -- note = {
		--   --   org_note_finalize = "<Leader>w",
		--   --   org_note_kill = "Q",
		--   -- },
		-- },
		org_todo_keywords = {
			"TODO",
			"WIP",
			"|",
			"DONE",
			"WAITING",
			"PENDING",
			"HOLD",
			"CANCELLED",
			"ASSIGNED",
		},
		org_todo_keyword_faces = {
			WAITING = ":foreground yellow",
			TODO = ":foreground coral",
			DONE = ":foreground chartreuse",
			WIP = ":foreground cyan", -- overrides builtin color for `TODO` keyword
			HOLD = ":foreground ivory", -- overrides builtin color for `TODO` keyword
			PENDING = ":foreground yellow", -- overrides builtin color for `TODO` keyword
			ASSIGNED = ":foreground lightgreen", -- overrides builtin color for `TODO` keyword
			CANCELLED = ":foreground darkgreen", -- overrides builtin color for `TODO` keyword
			-- DELEGATED = ':background #FFFFFF :slant italic :underline on :forground #000000',
		},
		org_capture_templates = {
			v = {
				description = "Visual todo (reg v)",
				template = '* TODO %(return vim.fn.getreg "v")\n %u',
			},
			m = {
				description = "Meeting notes",
				template = "#+TITLE: %?\n#+AUTHER: Ray\n#+TAGS: @metting \n#+DATE: %t\n\n*** %^{PROMPT|Meeting|LOGGING WGM} %U \n - %?\n<%<%Y-%m-%d %a %H:%M>>",
			},
			r = {
				description = "Ritual",
				template = '* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string "%<<%Y-%m-%d %a .+1d/3d>>")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n',
				target = string.format("~/OneDrive/Documents/org/meeting/%s.org", vim.fn.strftime("%Y-%m-%d")),
			},
			n = {
				description = "Notes",
				template = "#+TITLE: %?\n#+AUTHER: Ray\n#+TAGS: @note \n#+DATE: %t\n",
				target = string.format("~/OneDrive/Documents/org/notes/%s.org", vim.fn.strftime("%Y-%m-%d")),
			},
			j = {
				description = "Journal",
				template = "#+TITLE: %?\n#+TAGS: @journal \n#+DATE: %t\n",
				target = string.format("~/OneDrive/org/journal/%s.org", vim.fn.strftime("%Y-%m-%d")),
			},
		},
		notifications = {
			reminder_time = { 0, 1, 5, 10 },
			repeater_reminder_time = { 0, 1, 5, 10 },
			deadline_warning_reminder_time = { 0 },
			cron_notifier = function(tasks)
				for _, task in ipairs(tasks) do
					local title = string.format("%s (%s)", task.category, task.humanized_duration)
					local subtitle = string.format("%s %s %s", string.rep("*", task.level), task.todo, task.title)
					local date = string.format("%s: %s", task.type, task.time:to_string())

					if vim.fn.executable("notify-send") then
						vim.loop.spawn("notify-send", {
							args = {
								"--icon=~/AppData/local/nvim-data/lazy/orgmode/assets/orgmode_nvim.png",
								string.format("%s\n%s\n%s", title, subtitle, date),
							},
						})
					end
				end
			end,
		},
	})
	vim.opt.conceallevel = 2
	vim.cmd("set foldlevel=2")
end
