local platform = require('utils.platform')
local wezterm = require('wezterm')

local font = 'PragmataPro'
-- local font = 'JetBrainsMono Nerd Font'
-- local font = 'GeistMono Nerd Font'
local font_size = platform().is_mac and 17 or 14

return {
	font = wezterm.font(font),
	font_size = font_size,

	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'

	adjust_window_size_when_changing_font_size = false,

	-- TODO:
	-- allow_square_glyphs_to_overflow_width = 'Never',
	-- anti_alias_custom_block_glyphs = true,
	-- bold_brightens_ansi_colors = true,
}
