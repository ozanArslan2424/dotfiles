return {
	setup = function(pick)
		local grep = pick.builtin.grep_live

		Do.map("<leader>sg", grep, "[S]earch [G]rep")

		return grep
	end,
}
