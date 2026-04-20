local function combine(...)
	local args = { ... }
	local result = args[1] or {}

	for i = 2, #args do
		if args[i] then
			-- Deep merge tables
			local function deep_merge(target, source)
				for k, v in pairs(source) do
					if type(v) == "table" and type(target[k]) == "table" then
						deep_merge(target[k], v)
					else
						target[k] = v
					end
				end
				return target
			end

			local merged = {}
			for k, v in pairs(result) do
				merged[k] = v
			end
			result = deep_merge(merged, args[i])
		end
	end

	return result
end

local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.colors = combine(wezterm.color.load_base16_scheme(wezterm.config_dir .. "/colors/xcode.yaml"), {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
})

config.use_fancy_tab_bar = true

return config
