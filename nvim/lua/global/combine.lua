return function(...)
	local args = { ... }
	local result = args[1] or {}

	for i = 2, #args do
		if args[i] then
			result = vim.tbl_deep_extend("force", result, args[i])
		end
	end

	return result
end
