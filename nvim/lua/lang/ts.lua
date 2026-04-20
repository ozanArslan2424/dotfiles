local function enable_tsls()
	Do.enable_lsp("ts_ls", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	})
end

local function enable_tsgo()
	Do.enable_lsp("tsgo", {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	})
end

local function enable_vtsls()
	Do.enable_lsp("vtsls", {
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
	})
end

if TypescriptLspOption == "vtsls" then
	enable_vtsls()
elseif TypescriptLspOption == "ts_ls" then
	enable_tsls()
elseif TypescriptLspOption == "tsgo" then
	enable_tsgo()
end

require("lang.linters")
