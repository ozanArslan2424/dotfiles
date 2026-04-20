local textobjects = require("mini.ai")
local extra = require("mini.extra")

textobjects.setup({
	search_method = "cover_or_nearest",
	custom_textobjects = {
		B = extra.gen_ai_spec.buffer(),
		F = textobjects.gen_spec.treesitter({
			a = "@function.outer",
			i = "@function.inner",
		}),
		o = textobjects.gen_spec.treesitter({
			a = { "@conditional.outer", "@loop.outer" },
			i = { "@conditional.inner", "@loop.inner" },
		}),
	},
})
