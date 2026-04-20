if CmpOption == "blink" then
	return require("cmp.blink").setup()
elseif CmpOption == "mini" then
	return require("cmp.mini").setup()
end
