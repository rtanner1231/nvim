-- Autocommand that reloads neovim whenever you save the plugins.lua file
--[[ vim.cmd [[ ]]
--[[   augroup packer_user_config ]]
--[[     autocmd! ]]
--[[     autocmd BufWritePost plugins.lua source <afile> | PackerSync ]]
--[[   augroup end ]]
--[[ [[ ]]
--[[]]

-- Install your plugins here
return {
	-- My plugins here
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim", -- Easily comment stuff
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-web-devicons",
	--'kyazdani42/nvim-tree.lua',
	"akinsho/bufferline.nvim",
	"moll/vim-bbye",
	"akinsho/toggleterm.nvim",
	"nvim-lualine/lualine.nvim",
	"ahmedkhalf/project.nvim",
	--"statico/vim-javascript-sql",
	"christoomey/vim-tmux-navigator",
	--Colorscheme
	"lunarvim/darkplus.nvim",
	"folke/tokyonight.nvim",
	"Mofiqul/vscode.nvim",
	"rebelot/kanagawa.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- cmp plugins
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	-- "neovim/nvim-lspconfig", -- enable LSP
	-- "williamboman/mason.nvim", -- simple to use language server installer
	-- "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
	-- 'nvimtools/none-ls.nvim', -- LSP diagnostics and code actions

	-- Telescope
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-media-files.nvim",
	"smartpde/telescope-recent-files",
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		commit = "d94e1ad9575cc211b5726f09b28ca9454aba22fe",
	},
	--'JoosepAlviste/nvim-ts-context-commentstring',
	"HiPhish/rainbow-delimiters.nvim",
	"nvim-treesitter/playground",

	-- Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",

	--"haydenmeade/neotest-jest",
}
