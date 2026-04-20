return {
	setup = function()
		local statusline = require("mini.statusline")

		local content = function()
			local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
			local git, dev_hl =
				statusline.section_git({ trunc_width = 120 }),
				"MiniStatuslineDevinfo"
			local diff = statusline.section_diff({ trunc_width = 75 })
			local diagnostics =
				statusline.section_diagnostics({ trunc_width = 75 })
			local filename, filename_hl =
				statusline.section_filename({ trunc_width = 140 }),
				"MiniStatuslineFilename"
			local fileinfo, file_hl =
				statusline.section_fileinfo({ trunc_width = 120 }),
				"MiniStatuslineFileinfo"
			local location = statusline.section_location({ trunc_width = 500 })
			local search = statusline.section_searchcount({ trunc_width = 75 })

			return statusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = file_hl, strings = { location, search } },
				{ hl = dev_hl, strings = { diagnostics } },
				"%<", -- Mark general truncate point
				{ hl = filename_hl, strings = { filename } },
				"%=", -- End left alignment
				{ hl = dev_hl, strings = { git, diff } },
				{ hl = file_hl, strings = { fileinfo } },
			})
		end

		statusline.setup({
			-- `:h statusline` and code of default contents (used instead of `nil`).
			content = {
				active = content,
				inactive = content,
			},
			use_icons = true,
		})
	end,
}
