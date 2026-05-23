local pick = require("mini.pick")
local extra = require("mini.extra")
extra.setup()

pick.setup({
	mappings = {
		move_down = "<C-ü>",
		move_up = "<C-ğ>",
	},
	options = {
		use_cache = true,
	},
	window = {
		prompt_caret = "▏",
		prompt_prefix = "?",
		config = function()
			local height, width, starts, ends
			local win_width = vim.o.columns
			local win_height = vim.o.lines

			if win_height <= 25 then
				height = math.min(win_height, 18)
				width = win_width
				starts = 1
				ends = win_height
			else
				width = math.floor(win_width * 0.5) -- 50%
				height = math.floor(win_height * 0.5) -- 30%
				starts = math.floor((win_width - width) / 2)
				ends = math.floor(win_height * 0.65)
			end

			return {
				col = starts,
				row = ends,
				height = height,
				width = width,
			}
		end,
	},
	source = {
		match = function(stritems, inds, query)
			local filtered_inds = {}

			for _, i in ipairs(inds) do
				local item = stritems[i]
				-- Skip items containing unwanted patterns
				if
					not item:match("node_modules")
					and not item:match("%.git")
					and not item:match("dist")
					and not item:match("%.next")
				then
					table.insert(filtered_inds, i)
				end
			end

			return pick.default_match(stritems, filtered_inds, query)
		end,
	},
})

vim.ui.select = pick.ui_select

Do.map("<leader><leader>", pick.builtin.files, "File Picker")

Do.map("<F1>", pick.builtin.help, "Picker Help")

Do.map("<leader>sb", pick.builtin.buffers, "[S]earch [B]uffers")

Do.map("<leader>sg", pick.builtin.grep_live, "[S]earch [G]rep")

Do.map("<leader>xx", extra.pickers.diagnostic, "Diagnostics")

Do.map("gd", function()
	extra.pickers.lsp({ scope = "definition" })
end, "[G]o to [D]efinition")

Do.map("gr", function()
	extra.pickers.lsp({ scope = "references" })
end, "[G]o to [R]eferences")

Do.map("gs", function()
	extra.pickers.lsp({ scope = "document_symbol" })
end, "[G]o to [S]ymbols")
