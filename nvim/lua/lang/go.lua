Do.enable_lsp("gopls", {
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = { unusedparams = true },
		},
	},
})

Do.apply_config("opt", {
	tabstop = 8, -- Width of tab character
})
