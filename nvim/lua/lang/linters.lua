local eslint_base_on_attach = vim.lsp.config["eslint"].on_attach

Do.enable_lsp("eslint", {
	on_attach = function(client, buffer)
		if not eslint_base_on_attach then
			return
		end

		eslint_base_on_attach(client, buffer)
	end,
})

Do.enable_lsp("oxlint", {
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
})
