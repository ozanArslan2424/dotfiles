return {
	setup = function()
		vim.opt.statusline = table.concat({
			"%t",
			"%r",
			"%m",
			"%=",
			"%{&filetype}",
			" •",
			"%3l:%-2c ",
			"• ",
			"%{v:lua.os.date('%d/%m %a %H:%M')} ",
		}, "")
	end,
}
