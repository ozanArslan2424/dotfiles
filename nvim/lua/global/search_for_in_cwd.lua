return function(configs)
	local cwd = vim.fn.getcwd()
	for _, config in ipairs(configs) do
		local path = cwd .. "/" .. config
		local stat = vim.loop.fs_stat(path)
		if stat and stat.type == "file" then
			return true
		end
	end
	return false
end
