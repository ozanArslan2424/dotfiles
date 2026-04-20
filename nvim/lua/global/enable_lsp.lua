local combine = require("global.combine")

local cmp = require("blink.cmp")
local cmp_caps = cmp.get_lsp_capabilities()

local default_caps = vim.lsp.protocol.make_client_capabilities()

local capabilities = combine(default_caps, cmp_caps)

local set_caps = { capabilities = capabilities }

return function(server_name, custom_opts)
	local def_opts = vim.lsp.config[server_name]
	local opts = combine(def_opts, set_caps, custom_opts)
	vim.lsp.config(server_name, opts)
	vim.lsp.enable(server_name)
end
