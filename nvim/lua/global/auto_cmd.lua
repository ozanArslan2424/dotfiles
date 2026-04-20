local auto_commands_group = vim.api.nvim_create_augroup("custom-config", {})

return function(name, desc, callback, other_opts)
	local other = other_opts or {} -- Handle case where other is nil

	local opts = {
		desc = desc,
		group = other.group or auto_commands_group,
		callback = callback,
	}

	if other.pattern then
		opts.pattern = other.pattern
	end

	if other.once then
		opts.once = other.once
	end

	if other.nested then
		opts.nested = other.nested
	end

	vim.api.nvim_create_autocmd(name, opts)
end
