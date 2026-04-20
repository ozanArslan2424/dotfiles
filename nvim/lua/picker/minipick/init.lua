return {
	setup = function()
		local pick = require("picker.minipick.pick").setup()
		local extra = require("mini.extra")
		extra.setup()

		require("picker.minipick.files").setup(pick)
		require("picker.minipick.grep").setup(pick)

		require("picker.minipick.help").setup(pick)
		require("picker.minipick.dev").setup(pick)
		require("picker.minipick.buffers").setup(pick)
		require("picker.minipick.projects").setup(pick)

		require("picker.minipick.diagnostics").setup(extra)
	end,
}
