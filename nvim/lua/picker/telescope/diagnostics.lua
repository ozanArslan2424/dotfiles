return {
	setup = function(pick)
		local builtin = pick.builtin

		Do.map("<leader>xx", builtin.diagnostics, "Diagnostics")
		Do.map("gd", builtin.lsp_definitions, "[G]o to [D]efinition")
		Do.map("gr", builtin.lsp_references, "[G]o to [R]eferences")
		Do.map("gs", builtin.lsp_document_symbols, "[G]o to [S]ymbols")
	end,
}
