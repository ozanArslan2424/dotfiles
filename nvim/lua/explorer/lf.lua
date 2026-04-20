return {
	setup = function()
		local lf = require("lf")

		Do.apply_config("g", {
			lf_netrw = 1,
		})

		lf.setup({
			winblend = 0,
			highlights = { NormalFloat = { guibg = "NONE" } },
			border = nil,
			escape_quit = true,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "Lf",
			callback = function(ev)
				vim.api.nvim_buf_set_keymap(
					ev.buf,
					"t",
					"q",
					"q",
					{ nowait = true }
				)
			end,
		})

		return function()
			-- Check if we're in a valid directory context
			local path
			local bufnr = vim.api.nvim_get_current_buf()
			local bufname = vim.api.nvim_buf_get_name(bufnr)

			-- If we have a valid file, use its directory
			if bufname and bufname ~= "" then
				path = vim.fn.fnamemodify(bufname, ":p:h")
			else
				-- Otherwise use current working directory
				path = vim.fn.getcwd()
			end

			-- Validate the path exists and is a directory
			if vim.fn.isdirectory(path) == 0 then
				path = vim.fn.getcwd()
			end

			lf.start(path)
		end
	end,
}
