vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	virtual_text = { prefix = "●", hl_mode = "combine" },
})

local ignore_patterns = {
	"/node_modules/",
	"/%.next/",
	"/dist/",
}

local function path_ignored(path)
	for _, pat in ipairs(ignore_patterns) do
		if path:match(pat) then
			return true
		end
	end
	return false
end

-- Intercept publishDiagnostics before they hit vim.diagnostic
local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(
	err,
	result,
	ctx,
	config
)
	if result and result.uri and path_ignored(vim.uri_to_fname(result.uri)) then
		result.diagnostics = {}
	end
	return orig(err, result, ctx, config)
end

Do.map("üü", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, "Next diagnostic")

Do.map("ğğ", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, "Previous diagnostic")

Do.map("K", vim.lsp.buf.hover, "Show hover documentation")

Do.map("<leader>k", vim.diagnostic.open_float, "Show diagnostic at cursor")

Do.map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions", { "n", "v" })

Do.map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

Do.map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
