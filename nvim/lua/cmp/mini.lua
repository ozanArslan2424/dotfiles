return {
	setup = function()
		require("mini.completion").setup({
			window = {
				info = { border = "rounded" },
				signature = { border = "rounded" },
			},
			lsp_completion = {
				source_func = "omnifunc",
			},
		})

		local on_attach = function(args)
			vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		end
		vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })

		local imap_expr = function(lhs, rhs)
			vim.keymap.set("i", lhs, rhs, { expr = true })
		end
		imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

		vim.keymap.set("i", "<CR>", function()
			-- If there is selected item in popup, accept it with <C-y>
			if vim.fn.complete_info()["selected"] ~= -1 then
				return "\25"
			end
			-- Fall back to plain `<CR>`. You might want to customize according
			-- to other plugins. For example if 'mini.pairs' is set up, replace
			-- next line with `return MiniPairs.cr()`
			return "\r"
		end, { expr = true })
	end,
}
