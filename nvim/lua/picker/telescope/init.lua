return {
	setup = function()
		local pick = require("picker.telescope.pick").setup()

		require("picker.telescope.files").setup(pick)
		require("picker.telescope.grep").setup(pick)

		require("picker.telescope.help").setup(pick)
		require("picker.telescope.dev").setup(pick)
		require("picker.telescope.buffers").setup(pick)
		require("picker.telescope.projects").setup(pick)

		require("picker.telescope.diagnostics").setup(pick)
	end,
}
