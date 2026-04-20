--- @alias PluginSpec string|{
--- src: string,
--- version?: string,
--- origin?: string,
--- depends?: string[],
--- ifg?: {[1]: string, [2]: string},
--- post_install?: fun(),
--- post_checkout?: fun()
--- }

local DEFAULT_ORIGIN = "https://github.com"

local function register_hook(name, kind, fn)
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			if ev.data.spec.name == name and ev.data.kind == kind then
				if not ev.data.active then
					vim.cmd.packadd(name)
				end
				fn()
			end
		end,
	})
end

local function resolve_origin(src)
	if src:match("^https?://") or src:match("^custom:") then
		return src
	else
		return DEFAULT_ORIGIN .. "/" .. src
	end
end

--- @param plugin PluginSpec
--- @param seen table<string, boolean>
--- @return table[]
local function normalize(plugin, seen)
	local result = {}

	if type(plugin) == "string" then
		local src = resolve_origin(plugin)
		if not seen[src] then
			seen[src] = true
			table.insert(result, src)
		end
		return result
	end

	if plugin.ifg and _G[plugin.ifg[1]] ~= plugin.ifg[2] then
		return result
	end

	if plugin.depends then
		for _, dep in ipairs(plugin.depends) do
			local dep_src = resolve_origin(dep)
			if not seen[dep_src] then
				seen[dep_src] = true
				table.insert(result, dep_src)
			end
		end
	end

	local src = resolve_origin(plugin.src)
	if not seen[src] then
		seen[src] = true
		local name = plugin.src:match("[^/]+$")
		if plugin.post_install then
			register_hook(name, "install", plugin.post_install)
		end
		if plugin.post_checkout then
			register_hook(name, "update", plugin.post_checkout)
		end
		table.insert(result, { src = src, version = plugin.version })
	end

	return result
end

--- @param plugins PluginSpec[] List of plugins to install
local function load(plugins)
	local specs = {}
	local seen = {}
	for _, plugin in ipairs(plugins) do
		for _, spec in ipairs(normalize(plugin, seen)) do
			table.insert(specs, spec)
		end
	end
	vim.pack.add(specs)
end

return {
	load = load,
}
