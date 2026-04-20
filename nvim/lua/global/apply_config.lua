return function(config_group, config)
	for key, value in pairs(config) do
		vim[config_group][key] = value
	end
end
