local explorer

if ExplorerOption == "yazi" then
	explorer = require("explorer.yazi").setup()
elseif ExplorerOption == "lf" then
	explorer = require("explorer.lf").setup()
else
	explorer = require("explorer.mini").setup()
end

Do.user_cmd("Explorer", "Open File Explorer", function()
	explorer()
end)

Do.map("<leader>e", "<cmd>Explorer<cr>", "[E]xplorer")

return explorer
