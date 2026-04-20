--- @class FlagDef
--- @field arg string CLI argument (e.g. "--border")
--- @field global string Global variable name to set

--- @class SequenceConfig
--- @field before? fun() Function to run before plugin processing
--- @field plugins? PluginSpec[] List of plugins to install
--- @field run? fun()

--- @param sq SequenceConfig
local function start(sq)
	if sq.before ~= nil then
		sq.before()
	end

	if sq.plugins ~= nil then
		local plugin_manager = require("start.plugins")
		plugin_manager.load(sq.plugins)
	end

	if sq.run ~= nil then
		sq.run()
	end

	if ColorScheme ~= nil then
		vim.cmd("colorscheme " .. ColorScheme)
	end
end

return start
