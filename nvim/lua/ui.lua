local icons = require("mini.icons")
local notify = require("mini.notify")
local bufremove = require("mini.bufremove")
local starter = require("mini.starter")
local sessions = require("mini.sessions")
local tabline = require("mini.tabline")
local cmdline = require("mini.cmdline")

icons.setup()
icons.mock_nvim_web_devicons()
icons.tweak_lsp_kind()

notify.setup()
vim.notify = notify.make_notify()

bufremove.setup()

local del_other_bufs = function()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
			bufremove.delete(buf)
		end
	end
end

Do.map("<leader>bn", ":bnext<CR>", "[B]uffer [N]ext")
Do.map("<leader>bp", ":bprevious<CR>", "[B]uffer [P]revious")
Do.map("<leader>bd", bufremove.delete, "[B]uffer [D]elete")
Do.map("<leader>bo", del_other_bufs, "[B]uffer close [O]thers")

starter.setup({
	header = table.concat({
		"           _                          ",
		"           `*-.                       ",
		"            )  _`-.                   ",
		"           .  : `. .                  ",
		"           : _   '                    ",
		"           ; *` _.   `*-._            ",
		"           `-.-'          `-.         ",
		"             ;       `       `.       ",
		"             :.       .               ",
		"             .   .   :   .-'    .     ",
		"             '  `+.;  ;  '      :     ",
		"             :  '  |    ;       ;-.   ",
		"             ; '   : :`-:     _.`* ;  ",
		"    [bug] .*' /  .*' ; .*`- +'  `*'   ",
		"          `*-*   `*-*  `*-*'          ",
	}, "\n"),
})

sessions.setup({
	autoread = true,
	autowrite = true,
})

local mode_map = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	[""] = "V-BLOCK",
	c = "COMMAND",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	t = "TERMINAL",
	no = "OP-PENDING",
}
_G.statusline_mode = function()
	return mode_map[vim.fn.mode()] or vim.fn.mode():upper()
end

local function hl(group, fg, bg, bold)
	vim.api.nvim_set_hl(0, group, { fg = fg, bg = bg, bold = bold })
end
hl("StlModeNormal", "#1e1e2e", "#89b4fa", true)
hl("StlModeInsert", "#1e1e2e", "#a6e3a1", true)
hl("StlModeVisual", "#1e1e2e", "#f9e2af", true)
hl("StlModeReplace", "#1e1e2e", "#f38ba8", true)
hl("StlModeCommand", "#1e1e2e", "#fab387", true)
hl("StlModeOther", "#1e1e2e", "#cba6f7", true)
hl("StlFile", "#cdd6f4", "#313244", false)
hl("StlInfo", "#bac2de", "#45475a", false)

_G.statusline_mode_hl = function()
	local m = vim.fn.mode()
	if m == "n" then
		return "%#StlModeNormal#"
	end
	if m == "i" then
		return "%#StlModeInsert#"
	end
	if m == "v" or m == "V" or m == "" then
		return "%#StlModeVisual#"
	end
	if m == "R" then
		return "%#StlModeReplace#"
	end
	if m == "c" then
		return "%#StlModeCommand#"
	end
	return "%#StlModeOther#"
end

vim.opt.statusline = table.concat({
	"%{%v:lua.statusline_mode_hl()%}",
	" %{v:lua.statusline_mode()} ",
	"%#StlFile# %t%r%m ",
	"%#StlInfo#",
	"%=",
	" %{&filetype} ",
	"%#StlFile# %3l:%-2c ",
	"%#StlInfo# %{v:lua.os.date('%d/%m %a %H:%M')} ",
}, "")

tabline.setup({
	format = function(buf_id, label)
		local prefix = vim.bo[buf_id].modified and " +" or ""
		return prefix .. tabline.default_format(buf_id, label)
	end,
})

cmdline.setup()
