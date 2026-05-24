require("mini.comment").setup()
require("mini.diff").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("flutter-tools").setup()
local cmp = require("cmp")

local cmp_caps = cmp.get_lsp_capabilities()
local default_caps = vim.lsp.protocol.make_client_capabilities()
local capabilities = Do.combine(default_caps, cmp_caps)
local caps = { capabilities = capabilities }

local function enable(server_name, custom_opts)
	local def_opts = vim.lsp.config[server_name]
	local opts = Do.combine(def_opts, caps, custom_opts)
	vim.lsp.config(server_name, opts)
	vim.lsp.enable(server_name)
end

local lsps = {
	html = {},
	jsonls = {},
	yaml = {},
	taplo = {},
	eslint = {},
	shopify_theme_ls = {},
	stylua = {},
	markdown_oxide = {},
	prismals = {},
	oxlint = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
			"astro",
		},
		root_markers = {
			".oxlintrc.json",
			".oxlintrc.jsonc",
			"oxlint.config.ts",
			"vite.config.ts",
		},
	},
	cssls = {
		settings = {
			css = { validate = true, lint = { unknownAtRules = "ignore" } },
			scss = { validate = true, lint = { unknownAtRules = "ignore" } },
			less = { validate = true, lint = { unknownAtRules = "ignore" } },
		},
	},
	gopls = {
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = { unusedparams = true },
			},
		},
	},
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (
						vim.uv.fs_stat(path .. "/.luarc.json")
						or vim.uv.fs_stat(path .. "/.luarc.jsonc")
					)
				then
					return
				end
			end
			client.config.settings.Lua = Do.combine(client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					diagnostics = { globals = { "vim" } },
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					},
				},
			})
		end,
		settings = { Lua = {} },
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "workspace",
				},
			},
		},
	},
	svelte = {
		filetypes = { "svelte" },
		on_attach = function(client, bufnr)
			if client.name == "svelte" then
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts", "*.svelte" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
					end,
				})
			end
			if vim.bo[bufnr].filetype == "svelte" then
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts", "*.svelte" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
					end,
				})
			end
		end,
	},
	tailwindcss = {
		filetypes = {
			"astro",
			"html",
			"liquid",
			"css",
			"scss",
			"less",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
		},
		settings = {
			tailwindCSS = {
				classAttributes = {
					"class",
					"className",
					"class:list",
					"classList",
					"ngClass",
					".+ClassName",
				},
			},
		},
	},
	vtsls = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		settings = {
			refactor_auto_rename = true,
			complete_function_calls = true,
			vtsls = {
				enableMoveToFileCodeAction = true,
				autoUseWorkspaceTsdk = true,
				experimental = {
					completion = {
						enableServerSideFuzzyMatch = true,
						entriesLimit = 20,
					},
				},
			},
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = { completeFunctionCalls = true },
				tsserver = {
					useSeparateSyntaxServer = true,
					experimental = { enableProjectDiagnostics = true },
					pluginPaths = { "./node_modules" },
				},
				preferences = { importModuleSpecifier = "non-relative" },
			},
		},
	},
	bashls = { filetypes = { "zsh", "bash", "sh" } },
}

for key, value in pairs(lsps) do
	enable(key, value)
end
