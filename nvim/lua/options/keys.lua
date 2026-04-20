Do.map("vv", "0v$", "[V]isual Entire Line")

Do.map("dag", "ggdG", "[D]elete [A]round [G]lobal")
Do.map("yag", "ggyG", "[Y]ank [A]round [G]lobal")
Do.map("vag", "<Esc>gg0VG", "[V]isual [A]round [G]lobal")

Do.map("gcac", function()
	vim.cmd("normal! gg0VG")
	vim.cmd("normal gc")
end, "Comment everything")

Do.map("<Tab>", ">>", "Indent line right")
Do.map("<S-Tab>", "<<", "Indent line left")
Do.map("<Tab>", ">gv", "Indent selection right", "v")
Do.map("<S-Tab>", "<gv", "Indent selection left", "v")

Do.map("<Esc>", "<cmd>nohlsearch<CR><Esc>", "Clear search highlights")

Do.map("<leader>wv", "<C-w>v", "[W]indow [V]ertical")
Do.map("<leader>wh", "<C-w>s", "[W]indow [H]orizontal")
Do.map("<leader>wd", "<C-w>c", "[W]indow [D]elete")
Do.map("<leader>we", "<C-w>=", "[W]indows [E]qual")
Do.map("<leader>w<Left>", "<C-w>h", "[W]indow [Left]")
Do.map("<leader>w<Down>", "<C-w>j", "[W]indow [Down]")
Do.map("<leader>w<Up>", "<C-w>k", "[W]indow [Up]")
Do.map("<leader>w<Right>", "<C-w>l", "[W]indow [Right]")
