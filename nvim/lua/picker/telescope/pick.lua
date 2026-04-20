return {
	setup = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local finders = require("telescope.finders")
		local pickers = require("telescope.pickers")
		local conf = require("telescope.config").values
		local action_state = require("telescope.actions.state")
		local previewers = require("telescope.previewers")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-ü>"] = actions.move_selection_next,
						["<C-ğ>"] = actions.move_selection_previous,
					},
				},
				file_ignore_patterns = {
					"node_modules",
					"%.git/",
					"dist/",
					"%.next/",
				},
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.55,
						results_width = 0.45,
						width = 0.70,
						height = 0.75,
					},
				},
				prompt_prefix = "? ",
				selection_caret = "▏",
				cache_picker = {
					num_pickers = 5,
				},
			},
		})

		return {
			telescope = telescope,
			actions = actions,
			builtin = builtin,
			finders = finders,
			pickers = pickers,
			conf = conf,
			action_state = action_state,
			previewers = previewers,
		}
	end,
}
