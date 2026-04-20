return {
	setup = function()
		local hipatterns = require("mini.hipatterns")
		local ibl = require("ibl")
		local ibl_hooks = require("ibl.hooks")

		Do.hl("ToDoColor", { bg = "#4FC1FF", fg = "#000000", bold = true })

		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "FIXME:", group = "ToDoColor" },
				todo = { pattern = "TODO:", group = "ToDoColor" },
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
			Do.hl("GrayOne", { fg = "#606060" })
			Do.hl("GrayTwo", { fg = "#505050" })
			Do.hl("GrayThree", { fg = "#404040" })
			Do.hl("GrayFour", { fg = "#303030" })
			Do.hl("GrayFive", { fg = "#202020" })
		end)

		ibl_hooks.register(
			ibl_hooks.type.SCOPE_HIGHLIGHT,
			ibl_hooks.builtin.scope_highlight_from_extmark
		)

		ibl.setup({
			indent = {
				highlight = {
					"GrayOne",
					"GrayTwo",
					"GrayThree",
					"GrayFour",
					"GrayFive",
				},
				char = "",
			},
			scope = { enabled = false },
		})
	end,
}
