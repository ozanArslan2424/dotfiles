return function(keys, fn, desc, mode)
	vim.keymap.set(
		mode or "n",
		keys,
		fn,
		{ silent = true, noremap = true, desc = desc }
	)
end
