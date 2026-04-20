return {
	setup = function(extra)
		local go_to_definition = function()
			extra.pickers.lsp({ scope = "definition" })
		end

		local go_to_references = function()
			extra.pickers.lsp({ scope = "references" })
		end

		local go_to_document_symbol = function()
			extra.pickers.lsp({ scope = "document_symbol" })
		end

		Do.map("<leader>xx", extra.pickers.diagnostic, "Diagnostics")
		Do.map("gd", go_to_definition, "[G]o to [D]efinition")
		Do.map("gr", go_to_references, "[G]o to [R]eferences")
		Do.map("gs", go_to_document_symbol, "[G]o to [S]ymbols")
	end,
}
