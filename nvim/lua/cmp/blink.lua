return {
	setup = function()
		require("blink.cmp").setup({
			keymap = {
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			signature = { enabled = true },
			completion = {
				documentation = {
					auto_show = true,
				},
				menu = {
					auto_show = true,
					draw = {
						columns = {
							{ "label", "source_name", gap = 1 },
							{ "kind" },
						},
						components = {
							kind = {
								highlight = function(ctx)
									local icons = require("mini.icons")
									local _, hl = icons.get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
			},
		})
	end,
}
