return {
	setup = function()
		vim.g.loaded_nvim_treesitter = 1 -- This prevents treesitter from loading
		vim.g.skip_ts_context = true

		vim.cmd([[
  syntax on
  syntax enable
  syntax sync fromstart
  filetype on
  filetype plugin on
  filetype indent on

  set termguicolors
  set background=dark

  set synmaxcol=300  " Only highlight first 300 chars of line (performance)
  set redrawtime=10000  " More time for redrawing
  set lazyredraw  " Don't redraw during macros

  set autoread
  au FocusGained,BufEnter * :silent! !
]])

		Do.apply_config("opt", {
			syntax = "on",
			hlsearch = true, -- Highlight search results
			incsearch = true, -- Incremental search highlighting
		})

		Do.auto_cmd(
			"FileType",
			"Set up filetype-specific highlighting",
			function()
				-- You can add filetype-specific tweaks here
				local ft = vim.bo.filetype
				if ft == "javascript" or ft == "typescript" then
					vim.cmd("syntax sync fromstart") -- Better JS/TS sync
				elseif ft == "markdown" then
					vim.bo.conceallevel = 2 -- Better markdown display
				end
			end,
			{
				group = vim.api.nvim_create_augroup(
					"CustomTreesitter",
					{ clear = true }
				),
				pattern = "*",
			}
		)
	end,
}
