Do.user_cmd("BufferInfo", "Show Treesitter and LSP information", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = {}

	-- Treesitter info (with error handling)
	local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	local ts_info = parser_ok and parser and "Active" or "Not active"
	table.insert(lines, "🌳 TS: " .. ts_info)

	-- LSP info
	local attached_clients = vim.lsp.get_clients({ bufnr = bufnr })
	local attached_names = {}
	for _, client in ipairs(attached_clients) do
		---@diagnostic disable-next-line: undefined-field
		table.insert(attached_names, client.name)
	end

	table.insert(
		lines,
		"🚀 LSP: "
			.. (
				#attached_names > 0 and table.concat(attached_names, ", ")
				or "None"
			)
	)
	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
		title = "Buffer Status",
		timeout = 2000,
	})
end)
