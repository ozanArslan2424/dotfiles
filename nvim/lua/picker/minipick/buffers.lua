return {
	setup = function(pick)
		local buffers = pick.builtin.buffers

		Do.map("<leader>sb", buffers, "[S]earch [B]uffers")

		return buffers
	end,
}
