require("vim._core.ui2").enable({})
vim.g.node_host_prog = vim.env.HOME .. "/.bun/bin" .. "/neovim-node-host"

vim.cmd("aunmenu PopUp")
vim.cmd("autocmd! nvim.popupmenu")
vim.opt.isfname:append("@-@")

vim.g.border = "rounded"
vim.opt.winborder = "rounded" -- Use border in floating windows

-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- A
vim.opt.autoindent = true
vim.opt.autoread = true

-- B
vim.opt.background = "dark"
vim.opt.backspace = { "indent", "eol", "start" } -- Backspace behavior
vim.opt.breakindent = true -- Indent wrapped lines to match line start
vim.opt.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
vim.opt.backup = false

-- C
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true -- Enable current line highlighting
vim.opt.cursorlineopt = { "screenline", "number" } -- Show cursor line per screen line
vim.opt.complete = { ".", "w", "b", "kspell" } -- Use less sources
vim.opt.completeopt = "menuone,noinsert,fuzzy,nosort" -- Use custom behavior
vim.opt.colorcolumn = "0"
vim.opt.cmdheight = 0

-- E
vim.opt.expandtab = true

-- F
vim.opt.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.opt.foldmethod = "indent" -- Fold based on indent level
vim.opt.foldnestmax = 10 -- Limit number of fold levels
vim.opt.foldtext = "" -- Show text under fold with its highlighting

-- I
vim.opt.ignorecase = true -- Ignore case during search
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.infercase = true -- Infer case in built-in completion

-- L
vim.opt.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.opt.list = true -- Show helpful text indicators
vim.opt.listchars = { -- Define visible whitespace chars
	tab = "┋ ", -- Tab character
	trail = "·", -- Trailing spaces
	extends = "›", -- Line extends right
	precedes = "‹", -- Line extends left
	nbsp = "␣", -- Non-breaking spaces
}
vim.opt.laststatus = 3

-- M
vim.opt.mouse = "a" -- Enable mouse in all modes

-- N
vim.opt.number = true -- Show line numbers

-- P
vim.opt.pumheight = 10 -- Make popup menu smaller

-- R
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.ruler = false -- Don't show cursor coordinates

-- S
vim.opt.scrolloff = 10 -- Margin (line count) to scroll
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
vim.opt.shortmess = "CFOSWaco" -- Disable some built-in completion messages
vim.opt.showmode = false -- Don't show mode in command line
vim.opt.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.opt.smartindent = true -- Make indenting smart
vim.opt.smartcase = true -- Respect case if search pattern has upper case
vim.opt.splitbelow = true -- Horizontal splits will be below
vim.opt.splitright = true -- Vertical splits will be to the right
vim.opt.splitkeep = "screen" -- Reduce scroll during window split
vim.opt.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.opt.swapfile = false -- Disable swap files

-- T
vim.opt.tabstop = 4 -- Width of tab character
vim.opt.termguicolors = true -- Enable true color support
vim.opt.timeout = true -- Enable timeout for key sequences
vim.opt.timeoutlen = 500 -- Timeout length in milliseconds
vim.opt.ttimeoutlen = 30 -- Key code timeout length

-- U
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo" -- Set undo file directory
vim.opt.undofile = true -- Enable persistent undo

-- W
vim.opt.wrap = true -- Enable line wrapping
