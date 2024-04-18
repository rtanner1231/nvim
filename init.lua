vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup({ { import = "usr/plugins" }, { import = "usr/plugins.lsp" } }, {
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects/nvimplugins",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = { "rtanner1231" }, -- For example {"folke"}
		fallback = true, -- Fallback to git when local plugin doesn't exist
	},
	checker = {
		enabled = true,
		notify = false,
	},
})
require("user.options")
require("user.keymaps")
--require "user.colorscheme"
--require "user.cmp"
-- require "user.lsp"
require("user.telescope")
--require "user.treesitter"
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
--require "user.nvim-tree-config"
require("user.bufferline")
require("user.toggleterm")
require("user.lualine")
require("user.project")
--require "user.rainbow-delimiter"
--require "user.custom.formatsql"
--require "user.custom.sdf"
--require "user.harpoon"
--require("luasnip.loaders.from_vscode").lazy_load({ paths = {"./lua/user.snippets.suitescript" }})
--
--require "user.custom.nsconn"
