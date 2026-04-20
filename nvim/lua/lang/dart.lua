require("flutter-tools").setup({
	ui = {
		border = BorderStyle,
	},
})

Do.apply_config("opt", {
	shiftwidth = 8, -- Size of an indent
	tabstop = 8, -- Width of tab character
})
