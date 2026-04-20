if HighlightingOption == "treesitter" then
	require("highlighting.treesitter").setup()
else
	require("highlighting.native").setup()
end

require("highlighting.hipatterns").setup()
