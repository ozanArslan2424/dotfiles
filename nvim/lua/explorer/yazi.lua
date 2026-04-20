return {
	setup = function()
		local yazi = require("yazi")

		yazi.setup({
			open_for_directories = true,
		})

		return function()
			yazi.yazi()
		end
	end,
}
