local colors = require('colors.custom')
-- local gpu_adapters = require('utils.gpu_adapter')
local wezterm = require('wezterm')

local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

return {
	animation_fps = 10,
	max_fps = 60,
	-- front_end = 'WebGpu',
	-- webgpu_power_preference = 'HighPerformance',
	-- webgpu_preferred_adapter = gpu_adapters:pick(),

	-- color scheme
	colors = colors,

	-- background
	background = {
		-- {
		-- 	source = { File = wezterm.GLOBAL.background },
		-- },
		{
			source = { Color = colors.background },
			height = '100%',
			width = '100%',
			opacity = 0.96,
		},
	},

	-- scrollbar
	enable_scroll_bar = true,

	-- tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	-- show_tabs_in_tab_bar = false,
	tab_max_width = 25,
	show_tab_index_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,

	-- window
	window_decorations = 'RESIZE',
	window_padding = {
		-- left = 5,
		-- right = 10,
		-- top = 12,
		-- bottom = 7,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = 'NeverPrompt',
	window_frame = {
		active_titlebar_bg = '#090909',
		-- font = wezterm.font('GeistMono Nerd Font'),
		-- font_size = 12,
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.65,
	},
}
