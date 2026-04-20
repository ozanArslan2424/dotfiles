Do.user_cmd(
	"Config",
	"Change working directory to Neovim config and open file explorer",
	function()
		-- vim.fn.chdir(vim.fn.expand("~/.config/nvim"))
		vim.cmd("cd ~/.config/nvim")
		vim.schedule(function()
			vim.cmd("Explorer")
		end)
	end
)
