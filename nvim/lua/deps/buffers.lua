local bufremove = require("mini.bufremove")

bufremove.setup()

local del_other_bufs = function()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if
			buf ~= current_buf
			and vim.api.nvim_buf_is_valid(buf)
			and vim.bo[buf].buflisted
		then
			bufremove.delete(buf)
		end
	end
end

Do.map("<leader>bn", ":bnext<CR>", "[B]uffer [N]ext")
Do.map("<leader>bp", ":bprevious<CR>", "[B]uffer [P]revious")
Do.map("<leader>bd", bufremove.delete, "[B]uffer [D]elete")
Do.map("<leader>bo", del_other_bufs, "[B]uffer close [O]thers")
