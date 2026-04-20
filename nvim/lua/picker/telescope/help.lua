return {
	setup = function(pick)
		local help = pick.builtin.help_tags
		Do.map("<F1>", help, "Picker Help")
		return help
	end,
}
