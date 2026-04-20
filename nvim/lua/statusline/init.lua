if StatuslineOption == "mini" then
	return require("statusline.mini").setup()
elseif StatuslineOption == "native" then
	return require("statusline.native").setup()
end
