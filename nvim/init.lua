local start = require("start")

ColorScheme = "tokyonight-night"

-- "rounded" or "double" or "single"
BorderStyleOption = "rounded"

-- "vtsls" or "ts_ls" or "tsgo"
TypescriptLspOption = "vtsls"

-- "mini" or "native"
StatuslineOption = "mini"

-- "lf" or "mini" or "yazi"
ExplorerOption = "yazi"

-- "mini" or "blink"
CmpOption = "blink"

-- "mini" or "telescope"
PickerOption = "mini"

-- "native" or "treesitter"
HighlightingOption = "treesitter"

start({
	run = function()
		require("global")
		require("options")
		require("commands")
		require("deps.icons")
		require("deps.notify")
		require("deps.tabline")
		require("deps.buffers")
		require("statusline")
		require("deps.diagnostic")
		require("deps.textobjects")
		require("deps.conform")
		require("highlighting")
		require("cmp")
		require("picker")
		require("explorer")
		require("lang")
		require("deps.starter")

		require("mini.comment").setup()
		require("mini.diff").setup()
		require("mini.pairs").setup()
	end,

	plugins = {
		-- broken plugin, maybe contribute
		-- "landerson02/ghostty-theme-sync.nvim",
		"ember-theme/nvim",
		"folke/tokyonight.nvim",
		"webhooked/kanso.nvim",
		"blazkowolf/gruber-darker.nvim",
		"nvim-mini/mini.nvim",
		"neovim/nvim-lspconfig",
		"folke/which-key.nvim",
		"stevearc/conform.nvim",
		"lukas-reineke/indent-blankline.nvim",
		{
			src = "nvim-telescope/telescope.nvim",
			depends = { "nvim-lua/plenary.nvim" },
			ifg = { "PickerOption", "telescope" },
		},
		{
			src = "saghen/blink.cmp",
			version = "v1.7.0",
			ifg = { "CmpOption", "blink" },
		},
		{
			src = "nvim-treesitter/nvim-treesitter",
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
		{
			src = "mikavilpas/yazi.nvim",
			depends = { "nvim-lua/plenary.nvim" },
			ifg = { "ExplorerOption", "yazi" },
		},
		{
			src = "nvim-pack/nvim-spectre",
			depends = { "nvim-lua/plenary.nvim" },
		},
		{
			src = "lmburns/lf.nvim",
			depends = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
			ifg = { "ExplorerOption", "lf" },
		},
		{
			src = "nvim-flutter/flutter-tools.nvim",
			depends = { "nvim-lua/plenary.nvim" },
		},
	},
})
