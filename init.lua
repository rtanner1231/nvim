local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.g.mapleader=' '
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup('plugins')
require "user.options"
require "user.keymaps"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
require "user.nvim-tree-config"
require "user.bufferline"
require "user.toggleterm"
require "user.lualine"
require "user.project"
require "user.rainbow-delimiter"
--require("luasnip.loaders.from_vscode").lazy_load({ paths = {"./lua/user.snippets.suitescript" }})
