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

local html_opts = {}

local json_opts = {}

local shopify_opts = {}

local oxlint_opts = {
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
}

local eslint_base_on_attach = vim.lsp.config["eslint"].on_attach
local eslint_opts = {
	on_attach = function(client, buffer)
		if not eslint_base_on_attach then
			return
		end
		eslint_base_on_attach(client, buffer)
	end,
}

local css_opts = {
	settings = {
		css = { validate = true, lint = { unknownAtRules = "ignore" } },
		scss = { validate = true, lint = { unknownAtRules = "ignore" } },
		less = { validate = true, lint = { unknownAtRules = "ignore" } },
	},
}

local go_opts = {
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = { unusedparams = true },
		},
	},
}

local lua_opts = {
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
				diagnostics = {
					globals = { "vim" },
				},
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
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
	settings = {
		Lua = {},
	},
}

local stylua_opts = {}

local markdown_opts = {}

local prisma_opts = {}

local pyright_opts = {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
}

local svelte_opts = {
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
}

local tailwind_opts = {
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
}

local toml_opts = {}

local typescript_opts = {
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
			suggest = {
				completeFunctionCalls = true,
			},
			tsserver = {
				useSeparateSyntaxServer = true,
				experimental = {
					enableProjectDiagnostics = true,
				},
				pluginPaths = { "./node_modules" },
			},
			preferences = {
				importModuleSpecifier = "non-relative",
			},
		},
	},
}

local yaml_opts = {}

local shell_opts = {
	filetypes = { "zsh", "bash", "sh" },
}

enable("html", html_opts)
enable("jsonls", json_opts)
enable("eslint", eslint_opts)
enable("oxlint", oxlint_opts)
enable("cssls", css_opts)
enable("gopls", go_opts)
enable("shopify_theme_ls", shopify_opts)
enable("lua_ls", lua_opts)
enable("stylua", stylua_opts)
enable("markdown_oxide", markdown_opts)
enable("prismals", prisma_opts)
enable("pyright", pyright_opts)
enable("svelte", svelte_opts)
enable("tailwindcss", tailwind_opts)
enable("taplo", toml_opts)
enable("vtsls", typescript_opts)
enable("yaml", yaml_opts)
enable("bashls", shell_opts)
