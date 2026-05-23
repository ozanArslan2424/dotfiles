local start = require("start")

ColorScheme = "tokyonight-night"

-- "mini" or "native"
StatuslineOption = "mini"

-- "lf" or "mini" or "yazi"
ExplorerOption = "yazi"

-- "mini" or "blink"
CmpOption = "mini"

-- "native" or "treesitter"
HighlightingOption = "treesitter"

start({
	run = function()
		require("global")
		require("options")
		require("keymaps")
		require("commands")
		require("ui")
		require("cmp")
		require("picker")
		require("explorer")
		require("lsp")
		require("formatting")
		require("diagnostic")
		require("highlighting")
		require("textobjects")
	end,

	native_packs = {
		"nvim.undotree",
	},

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
		-- { src = "saghen/blink.cmp", version = "v1.7.0", ifg = { "CmpOption", "blink" }, },
		{
			src = "nvim-treesitter/nvim-treesitter",
			ifg = { "HighlightingOption", "treesitter" },
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
			src = "nvim-flutter/flutter-tools.nvim",
			depends = { "nvim-lua/plenary.nvim" },
		},
	},
})
