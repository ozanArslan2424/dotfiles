return {
	setup = function(pick)
		local files = pick.builtin.files

		Do.map("<leader><leader>", files, "File Picker")

		return files
	end,
}
