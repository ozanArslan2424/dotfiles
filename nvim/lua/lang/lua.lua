Do.enable_lsp("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (
					vim.uv.fs_stat(path .. "/.luarc.json")
					or vim.uv.fs_stat(path .. "/.luarc.jsonc")
				)
			then
				return
			end
		end

		client.config.settings.Lua = Do.combine(client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				diagnostics = {
					globals = { "vim" },
				},
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
					"${3rd}/busted/library",
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

Do.enable_lsp("stylua", {})
