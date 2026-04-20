Do.enable_lsp("tailwindcss", {
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
})
