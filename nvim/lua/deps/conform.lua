local conform = require("conform")
local util = require("conform.util")

conform.setup({
	formatters_by_ft = {
		typescript = { "oxfmt", "prettier" },
		javascript = { "oxfmt", "prettier" },
		typescriptreact = { "oxfmt", "prettier" },
		javascriptreact = { "oxfmt", "prettier" },
		markdown = { "oxfmt", "prettier" },
		json = { "oxfmt", "prettier" },
		html = { "oxfmt", "prettier" },
		sh = { "shfmt" },
		go = { "goimports", "gofmt" },
		lua = { "stylua" },
	},
	default_format_opts = {
		lsp_format = "fallback",
		stop_after_first = true,
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
		async = false,
	},
	formatters = {
		oxfmt = {
			cwd = util.root_file({ ".git" }),
		},
		prettier = {
			cwd = util.root_file({ ".git" }),
		},
	},
	log_level = vim.log.levels.INFO,
	stop_after_first = true,
	notify_on_error = true,
	notify_no_formatters = true,
})
