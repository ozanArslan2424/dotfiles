return {
	setup = function(pick)
		local help = pick.builtin.help
		Do.map("<F1>", help, "Picker Help")
		return help
	end,
}
