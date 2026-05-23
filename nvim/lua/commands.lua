Do.auto_cmd("TextYankPost", "Highlight when yanking text", function()
	vim.hl.on_yank()
end)

Do.user_cmd(
	"PackAdd",
	"Add plugins (:PackAdd user/repo1 user/repo2)",
	function(opts)
		vim.pack.add(opts.fargs)
	end,
	{ nargs = "+" }
)

Do.user_cmd(
	"PackDel",
	"Delete plugins (:PackDel plugin1 plugin2)",
	function(opts)
		vim.pack.del(opts.fargs)
	end,
	{ nargs = "+" }
)

Do.user_cmd("PackUpdate", "Update all plugins or specific ones", function(opts)
	-- checks if any argument is passed
	if opts.args:match("%S") then
		-- update specific plugins
		local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		-- update only specified plugins
		vim.pack.update(plugins)
	else
		-- update all
		vim.pack.update()
	end
end, { nargs = "*" })

Do.user_cmd("BufferInfo", "Show Treesitter and LSP information", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = {}

	-- Treesitter info (with error handling)
	local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	local ts_info = parser_ok and parser and "Active" or "Not active"
	table.insert(lines, "🌳 TS: " .. ts_info)

	-- LSP info
	local attached_clients = vim.lsp.get_clients({ bufnr = bufnr })
	local attached_names = {}
	for _, client in ipairs(attached_clients) do
		---@diagnostic disable-next-line: undefined-field
		table.insert(attached_names, client.name)
	end

	table.insert(
		lines,
		"🚀 LSP: "
			.. (
				#attached_names > 0 and table.concat(attached_names, ", ")
				or "None"
			)
	)
	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
		title = "Buffer Status",
		timeout = 2000,
	})
end)

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
Do.user_cmd("Floaterminal", "Floating terminal", toggle_terminal)
