return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		local wk = require("which-key")
		local builtin = require("telescope.builtin")

		wk.register({
			v = {
				name = "splits",
				v = { "<cmd>vsplit<cr>", "Vertical Split" },
				h = { "<cmd>split<cr>", "Horizontal Split" },
				c = { "<C-w>c", "Close current split" },
				o = { "<cmd>on<cr>", "Close other splits" },
			},
			m = {
				name = "Harpoon",
				m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Toggle Menu" },
				a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
				h = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Previous Mark" },
				l = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next Mark" },
				["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Nav to file 1" },
				["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Nav to file 2" },
				["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Nav to file 3" },
				["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Nav to file 4" },
				["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Nav to file 5" },
				["6"] = { "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Nav to file 6" },
				["7"] = { "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Nav to file 7" },
				["8"] = { "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Nav to file 8" },
				["9"] = { "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Nav to file 9" },
			},
			s = {
				name = "SuiteQL",
				s = { ":SuiteQL FormatQuery<cr>", "Format SuiteQL under cursor" },
				a = { ":SuiteQL FormatFile<cr>", "Format all SuiteQL in file" },
				e = { ":SuiteQL ToggleEditor<cr>", "Toggle SuiteQL editor" },
				w = { ":SuiteQL EditQuery<cr>", "Edit the query under the cursor" },
				c = { ":NSConn SelectProfile<cr>", "Change the active profile" },
				h = { ":SuiteQL History<cr>", "View the query history" },
				q = { ":SuiteQL ShowTablePicker<cr>", "Show the table picker" },
				k = { ":SuiteQL ShowFieldPicker<cr>", "Show the field picker for the last table" },
				l = { ":SuiteQL ShowLastTableFieldPicker<cr>", "Show the field picker for the last table" },
			},
			d = {
				name = "Suitecloud",
				p = { ":SDF Deploy<cr>", "Run suitecloud deploy" },
				c = { ":SDF SelectAccount<cr>", "Select SDF Account" },
				l = { ":SDF DeployCurrentFolder<cr>", "Deploy all files in current file's directory" },
				f = { ":SDF DeployCurrentFile<cr>", "Deploy current buffer file" },
				d = { ":SDF Menu<cr>", "Show deploy menu" },
			},
			f = {
				name = "Telescope",
				f = {
					"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>",
					"Find Files",
				},
				--d={"<cmd>Telescope frecency workspace=CWD<cr>","Frecency"},
				h = { "<cmd> Telescope help_tags<cr>", "Help Tags" },
				r = { "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>", "Recent Files" },
				t = { builtin.live_grep, "Search by Grep" },
				k = { builtin.keymaps, "Search Keymaps" },
				["."] = { builtin.resume, "Resume Search" },
				w = { builtin.grep_string, "Search current word" },
			},
			["/"] = {
				function()
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				"Search Current buffer",
			},
			x = {
				name = "Nvim dev",
				x = { ":source %<cr>", "Run current file" },
			},
			o = {
				name = "Obsidian",
				o = { "<cmd>ObsidianQuickSwitch<cr>", "Search notes" },
				s = { "<cmd>ObsidianTags<cr>", "Search Tags" },
				b = { "<cmd>ObsidianBacklinks<cr>", "Search backlinks" },
				p = { "<cmd>ObsidianOpen<cr>", "Open note" },
				n = { "<cmd>ObsidianNew<cr>", "New Note" },
				t = { "<cmd>ObsidianToday<cr>", "Todays Note" },
			},
			g = {
				name = "Git",
				l = { "<cmd>lua lazygit_toggle()<CR>", "Open lazygit" },
				b = { "<cmd>BlameToggle window<cr>", "Open git blame window" },
				v = { "<cmd>BlameToggle virtual<cr>", "Show git blame virtual" },
			},
		}, { prefix = "<leader>" })
		-- wk.register({
		--         s={
		--             q={':echo "aaa"<cr>'}
		--         }
		--     },{prefix="<C>",mode="i"})
	end,
}
