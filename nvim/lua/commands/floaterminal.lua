local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(custom_opts)
	local opts = custom_opts or {}

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Create the floating window
	local width = opts.width or math.floor(vim.o.columns * 0.6)
	local col = math.floor((vim.o.columns - width) / 2)

	local height = opts.height or math.floor(vim.o.lines * 0.6)
	local row = math.floor((vim.o.lines - height) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "win",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- only option available
		border = BorderStyle,
	})

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

Do.map("<esc><esc>", "<c-\\><c-n>", "Exit terminal mode", "t")
Do.map("<leader>ct", toggle_terminal, "Toggle Floating Terminal")
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
