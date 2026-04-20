return {
	setup = function(style)
		if style == "rounded" then
			return "rounded"
		elseif style == "double" then
			return { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
		elseif style == "single" then
			return "single"
		end
	end,
}
