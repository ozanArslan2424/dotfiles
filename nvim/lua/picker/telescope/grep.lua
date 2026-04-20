return {
	setup = function(pick)
		local grep = pick.builtin.live_grep

		Do.map("<leader>sg", grep, "[S]earch [G]rep")

		return grep
	end,
}
