Do.enable_lsp("pyright", {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
})
Do.apply_config("opt", {
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true, -- PEP 8 uses spaces
})
