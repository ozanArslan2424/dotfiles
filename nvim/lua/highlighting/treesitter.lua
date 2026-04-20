return {
	setup = function()
		local treesitter = require("nvim-treesitter")

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

		treesitter.install(languages, {
			summary = true,
		})

		local cmd_pattern = {}

		for _, lang in ipairs(languages) do
			local lang_filetypes = vim.treesitter.language.get_filetypes(lang)

			if lang_filetypes then
				for _, ft in ipairs(lang_filetypes) do
					table.insert(cmd_pattern, ft)
				end
			end
		end

		Do.auto_cmd(
			"FileType",
			"Start treesitter based on file type",
			function()
				vim.treesitter.start()

				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldmethod = "expr"
				vim.bo.indentexpr =
					"v:lua.require'nvim-treesitter'.indentexpr()"
			end,
			{
				pattern = cmd_pattern,
			}
		)
	end,
}
