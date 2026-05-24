local conform = require("conform")
local conform_util = require("conform.util")

local function has_config(filenames)
	return function(_, ctx)
		return vim.fs.find(filenames, { upward = true, path = ctx.dirname })[1] ~= nil
	end
end

conform.setup({
	formatters_by_ft = {
		typescript = { "oxfmt", "prettier" },
		javascript = { "oxfmt", "prettier" },
		typescriptreact = { "oxfmt", "prettier" },
		javascriptreact = { "oxfmt", "prettier" },
		markdown = { "oxfmt", "prettier" },
		json = { "oxfmt", "prettier" },
		html = { "oxfmt", "prettier" },
		css = { "oxfmt", "prettier" },
		liquid = { "prettier_liquid" },
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
			condition = has_config({ ".oxfmtrc.json" }),
		},
		prettier = {
			condition = has_config({
				".prettierrc",
				".prettierrc.json",
				".prettierrc.js",
				".prettierrc.cjs",
				".prettierrc.mjs",
				".prettierrc.yaml",
				".prettierrc.yml",
				".prettierrc.toml",
				"prettier.config.js",
				"prettier.config.cjs",
				"prettier.config.mjs",
			}),
			-- still nice to have so prettier picks up the config:
			cwd = conform_util.root_file({
				".prettierrc",
				"package.json",
			}),
		},
		prettier_liquid = {
			command = "prettier",
			args = {
				"--plugin="
					.. vim.env.HOME
					.. "/.bun/install/global/node_modules/@shopify/prettier-plugin-liquid/dist/index.js",
				"--parser=liquid-html",
				"--use-tabs",
				"--stdin-filepath",
				"$FILENAME",
			},
			stdin = true,
			cwd = conform_util.root_file({ ".git", "package.json" }),
		},
	},
	log_level = vim.log.levels.INFO,
	notify_on_error = true,
	notify_no_formatters = true,
})
