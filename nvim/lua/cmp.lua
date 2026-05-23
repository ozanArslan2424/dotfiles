local cmp = require("mini.completion")

cmp.setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = true,
	},
})

Do.auto_cmd("LspAttach", "MiniCompletion on attach", function(args)
	vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
end)

local imap_expr = function(keys, fn)
	vim.keymap.set("i", keys, fn, { expr = true })
end

imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])

imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

imap_expr("<CR>", function()
	if vim.fn.pumvisible() == 1 then
		local selected = vim.fn.complete_info({ "selected" }).selected
		-- If nothing selected, select first then accept
		if selected == -1 then
			return "\14\25" -- <C-n><C-y>
		end
		return "\25" -- <C-y>
	end
	return "\r"
end)

return cmp
