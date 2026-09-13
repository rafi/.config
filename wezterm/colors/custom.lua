-- github.com/rafi/.config

local rafi = {
	rosewater = '#f5e0dc',
	flamingo = '#f2cdcd',
	pink = '#EF4CDB',
	mauve = '#cba6f7',
	red = '#f38ba8',
	maroon = '#eba0ac',
	peach = '#fab387',
	yellow = '#f9e2af',
	green = '#a6e3a1',
	teal = '#94e2d5',
	sky = '#89dceb',
	sapphire = '#74c7ec',
	blue = '#89b4fa',
	lavender = '#b4befe',
	text = '#A0A0A0',
	subtext1 = '#bac2de',
	subtext0 = '#a6adc8',
	overlay2 = '#9399b2',
	overlay1 = '#7f849c',
	overlay0 = '#6c7086',
	surface2 = '#585b70',
	surface1 = '#45475a',
	surface0 = '#313244',
	base = '#232323', -- '#1f1f28',
	mantle = '#181825',
	crust = '#11111b',
}

local colorscheme = {
	foreground = rafi.text,
	background = rafi.base,
	cursor_bg = rafi.pink,
	cursor_border = rafi.pink,
	cursor_fg = rafi.crust,
	selection_bg = '#404040', -- mocha.surface2,
	selection_fg = '#eaeaea', -- mocha.text,
	ansi = {
		'#2A2A2A', -- black
		'#D370A3', -- red
		'#6D9E3F', -- green
		'#B58858', -- yellow
		'#6095C5', -- blue
		'#AC7BDE', -- magenta/purple
		'#3BA275', -- cyan
		'#FFFFFF', -- white
	},
	brights = {
		'#686868', -- black
		'#FFA7DA', -- red
		'#A3D572', -- green
		'#EFBD8B', -- yellow
		'#98CBFE', -- blue
		'#E5B0FF', -- magenta/purple
		'#75DAA9', -- cyan
		'#CFCFCF', -- white
	},
	tab_bar = {
		background = 'rgba(0, 0, 0, 0.4)',
		active_tab = {
			bg_color = rafi.base,
			fg_color = rafi.text,
		},
		inactive_tab = {
			bg_color = rafi.crust,
			fg_color = rafi.subtext1,
		},
		inactive_tab_hover = {
			bg_color = rafi.surface0,
			fg_color = rafi.text,
		},
		new_tab = {
			bg_color = rafi.base,
			fg_color = rafi.text,
		},
		new_tab_hover = {
			bg_color = rafi.mantle,
			fg_color = rafi.text,
			italic = true,
		},
	},
	visual_bell = rafi.surface0,
	indexed = {
		[16] = rafi.peach,
		[17] = rafi.rosewater,
	},
	scrollbar_thumb = rafi.surface2,
	split = rafi.overlay0,
	compose_cursor = rafi.flamingo, -- nightbuild only
}

return colorscheme
