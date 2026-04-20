return {
	setup = function(pick)
		local files = pick.builtin.find_files

		Do.map("<leader><leader>", files, "File Picker")

		return files
	end,
}
