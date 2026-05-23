local treesitter = require("nvim-treesitter")
local hipatterns = require("mini.hipatterns")
local ibl = require("ibl")
local ibl_hooks = require("ibl.hooks")

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local languages = {
	"html",
	"css",
	"lua",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"javascript",
	"typescript",
	"tsx",
	"go",
	"json",
	"prisma",
	"sql",
	"svelte",
	"yaml",
	"java",
	"liquid",
}

treesitter.setup({
	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats =
				pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
})

treesitter.install(languages)

local cmd_pattern = {}

for _, lang in ipairs(languages) do
	local lang_filetypes = vim.treesitter.language.get_filetypes(lang)

	if lang_filetypes then
		for _, ft in ipairs(lang_filetypes) do
			table.insert(cmd_pattern, ft)
		end
	end
end

Do.auto_cmd("FileType", "Start treesitter based on file type", function(args)
	local buf = args.buf
	local ft = vim.bo[buf].filetype

	local lang = vim.treesitter.language.get_lang(ft)
	if not lang then
		return
	end

	local ok_add = pcall(vim.treesitter.language.add, lang)
	if not ok_add then
		return
	end

	pcall(function()
		vim.treesitter.start()
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo[0][0].foldmethod = "expr"
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end, buf, lang)
end, {
	pattern = "*",
})

Do.hl("ToDoColor", { bg = "#4FC1FF", fg = "#000000", bold = true })

hipatterns.setup({
	highlighters = {
		fixme = { pattern = "FIXME:", group = "ToDoColor" },
		todo = { pattern = "TODO:", group = "ToDoColor" },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
	Do.hl("GrayOne", { fg = "#606060" })
	Do.hl("GrayTwo", { fg = "#505050" })
	Do.hl("GrayThree", { fg = "#404040" })
	Do.hl("GrayFour", { fg = "#303030" })
	Do.hl("GrayFive", { fg = "#202020" })
end)

ibl_hooks.register(
	ibl_hooks.type.SCOPE_HIGHLIGHT,
	ibl_hooks.builtin.scope_highlight_from_extmark
)

ibl.setup({
	indent = {
		highlight = {
			"GrayOne",
			"GrayTwo",
			"GrayThree",
			"GrayFour",
			"GrayFive",
		},
		char = "",
	},
	scope = { enabled = false },
})
