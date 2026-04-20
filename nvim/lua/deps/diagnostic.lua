vim.diagnostic.config({
	float = { border = BorderStyle },
	severity_sort = true,
	update_in_insert = false,
	virtual_text = { prefix = "●", hl_mode = "combine" },
})

local next_diagnostic = function()
	vim.diagnostic.jump({ count = 1, float = true })
end

local prev_diagnostic = function()
	vim.diagnostic.jump({ count = -1, float = true })
end

Do.map("ğğ", prev_diagnostic, "Previous diagnostic")
Do.map("üü", next_diagnostic, "Next diagnostic")

Do.map("K", vim.lsp.buf.hover, "Show hover documentation")
Do.map("<leader>k", vim.diagnostic.open_float, "Show diagnostic at cursor")

Do.map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions", { "n", "v" })
Do.map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
Do.map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
