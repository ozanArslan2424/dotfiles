Do.auto_cmd("TextYankPost", "Highlight when yanking (copying) text", function()
	vim.hl.on_yank()
end)
