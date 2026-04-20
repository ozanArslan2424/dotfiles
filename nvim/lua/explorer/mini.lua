return {
	setup = function()
		local files = require("mini.files")

		files.setup({
			mappings = {
				close = "q",
				go_in_plus = "<Right>",
				go_out_plus = "<Left>",
				go_in = "L",
				go_out = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "<cr>",
				trim_left = "<",
				trim_right = ">",
			},
			windows = {
				preview = true,
				width_preview = 80,
			},
		})

		return function()
			if not files.close() then
				files.open(vim.api.nvim_buf_get_name(0))
			end
		end
	end,
}
