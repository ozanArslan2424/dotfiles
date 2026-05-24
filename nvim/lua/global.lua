local function combine(...)
	local args = { ... }
	local result = args[1] or {}

	for i = 2, #args do
		if args[i] then
			result = vim.tbl_deep_extend("force", result, args[i])
		end
	end

	return result
end

local function user_cmd(name, desc, fn, other)
	vim.api.nvim_create_user_command(name, fn, combine({ desc = desc }, other))
end

local auto_commands_group = vim.api.nvim_create_augroup("custom-config", {})
local function auto_cmd(when, desc, callback, other_opts)
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

	vim.api.nvim_create_autocmd(when, opts)
end

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

local function map(keys, fn, desc, mode)
	vim.keymap.set(mode or "n", keys, fn, { silent = true, noremap = true, desc = desc })
end

local function search_for_in_cwd(configs)
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

Do = {
	hl = hl,
	map = map,
	combine = combine,
	auto_cmd = auto_cmd,
	user_cmd = user_cmd,
	search_for_in_cwd = search_for_in_cwd,
}
