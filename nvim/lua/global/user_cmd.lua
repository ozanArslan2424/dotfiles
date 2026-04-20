return function(name, desc, fn)
	vim.api.nvim_create_user_command(name, fn, { desc = desc })
end
