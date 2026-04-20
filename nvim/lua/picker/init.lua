if PickerOption == "mini" then
	return require("picker.minipick").setup()
else
	return require("picker.telescope").setup()
end
