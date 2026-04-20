Do.apply_config("g", {
	mapleader = " ", -- Set leader key to space
	maplocalleader = " ", -- Set local leader to space
	border = BorderStyle,
	-- mark netrw as loaded so it's not loaded at all.
	-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
	loaded_netrwSettings = 1,
	loaded_netrwFileHandlers = 1,
})

Do.apply_config("opt", {
	-- A
	autoindent = true,
	autoread = true,

	-- B
	background = "dark",
	backspace = { "indent", "eol", "start" }, -- Backspace behavior
	breakindent = true, -- Indent wrapped lines to match line start
	breakindentopt = "list:-1", -- Add padding for lists (if 'wrap' is set)

	-- C
	clipboard = "unnamedplus",
	cursorline = true, -- Enable current line highlighting
	cursorlineopt = { "screenline", "number" }, -- Show cursor line per screen line
	complete = { ".", "w", "b", "kspell" }, -- Use less sources
	completeopt = { "menuone", "noselect", "fuzzy", "nosort" }, -- Use custom behavior

	-- F
	foldlevel = 10, -- Fold nothing by default; set to 0 or 1 to fold
	foldmethod = "indent", -- Fold based on indent level
	foldnestmax = 10, -- Limit number of fold levels
	foldtext = "", -- Show text under fold with its highlighting

	-- I
	ignorecase = true, -- Ignore case during search
	incsearch = true, -- Show search matches while typing
	infercase = true, -- Infer case in built-in completion

	-- L
	linebreak = true, -- Wrap lines at 'breakat' (if 'wrap' is set)
	list = true, -- Show helpful text indicators
	listchars = { -- Define visible whitespace chars
		tab = "┋ ", -- Tab character
		trail = "·", -- Trailing spaces
		extends = "›", -- Line extends right
		precedes = "‹", -- Line extends left
		nbsp = "␣", -- Non-breaking spaces
	},

	-- M
	mouse = "a", -- Enable mouse in all modes

	-- N
	number = true, -- Show line numbers

	-- P
	pumheight = 10, -- Make popup menu smaller

	-- R
	relativenumber = true, -- Show relative line numbers
	ruler = false, -- Don't show cursor coordinates

	-- S
	scrolloff = 10, -- Margin (line count) to scroll
	shiftwidth = 4, -- Size of an indent
	shada = "'100,<50,s10,:1000,/100,@100,h", -- Limit ShaDa file (for startup)
	shortmess = "CFOSWaco", -- Disable some built-in completion messages
	showmode = false, -- Don't show mode in command line
	signcolumn = "yes", -- Always show signcolumn (less flicker)
	smartindent = true, -- Make indenting smart
	smartcase = true, -- Respect case if search pattern has upper case
	splitbelow = true, -- Horizontal splits will be below
	splitkeep = "screen", -- Reduce scroll during window split
	splitright = true, -- Vertical splits will be to the right
	spelloptions = "camel", -- Treat camelCase word parts as separate words
	swapfile = false, -- Disable swap files

	-- T
	tabstop = 4, -- Width of tab character
	termguicolors = true, -- Enable true color support
	timeout = true, -- Enable timeout for key sequences
	timeoutlen = 500, -- Timeout length in milliseconds
	ttimeoutlen = 30, -- Key code timeout length

	-- U
	undodir = vim.fn.stdpath("cache") .. "/undo", -- Set undo file directory
	undofile = true, -- Enable persistent undo

	-- W
	winborder = BorderStyle, -- Use border in floating windows
	wrap = true, -- Enable line wrapping
})
