local backdrops = require('utils.backdrops')
local wezterm = require('wezterm')
local act = wezterm.action

-- wezterm show-keys --lua

local keys = {
	{ key = 'q', mods = 'CMD', action = act.QuitApplication },

	-- copy/paste
	{ key = 'c', mods = 'CMD', action = act.CopyTo('Clipboard') },
	{ key = 'v', mods = 'CMD', action = act.PasteFrom('Clipboard') },

	-- navigation
	{ key = 'h', mods = 'CMD', action = act.ActivateTabRelative(-1) },
	{ key = 'l', mods = 'CMD', action = act.ActivateTabRelative(1) },
	{ key = 'j', mods = 'CMD', action = act.SendKey({ key = 'j', mods = 'ALT' }) },
	{ key = 'k', mods = 'CMD', action = act.SendKey({ key = 'k', mods = 'ALT' }) },

	-- misc/useful
	{ key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
	{ key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
	{ key = 'F3', mods = 'NONE', action = act.ShowLauncher },
	{
		key = 'F7',
		mods = 'NONE',
		action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }),
	},
	{
		key = 'F8',
		mods = 'NONE',
		action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
	},
	-- toggle fullscreen
	{ key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
	{ key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },

	{
		key = 'f',
		mods = 'SUPER',
		action = act.Search({ CaseInSensitiveString = '' }),
	},
	{
		key = 'u',
		mods = 'SUPER',
		action = wezterm.action.QuickSelectArgs({
			label = 'open url',
			patterns = {
				'https?://\\S+',
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info('opening: ' .. url)
				wezterm.open_with(url)
			end),
		}),
	},

	-- tabs
	{ key = 't', mods = 'SUPER', action = act.SpawnTab('DefaultDomain') },
	{
		key = 'w',
		mods = 'SUPER',
		action = act.CloseCurrentTab({ confirm = false }),
	},

	-- tabs: navigation
	{ key = '[', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
	{ key = ']', mods = 'SUPER', action = act.ActivateTabRelative(1) },
	{ key = '[', mods = 'SUPER|CTRL', action = act.MoveTabRelative(-1) },
	{ key = ']', mods = 'SUPER|CTRL', action = act.MoveTabRelative(1) },

	-- window
	{ key = 'n', mods = 'SUPER', action = act.SpawnWindow },

	-- background controls
	{
		key = [[/]],
		mods = 'SUPER',
		action = wezterm.action_callback(function(window, _)
			backdrops:random(window)
		end),
	},
	{
		key = [[,]],
		mods = 'SUPER',
		action = wezterm.action_callback(function(window, _)
			backdrops:cycle_back(window)
		end),
	},
	{
		key = [[.]],
		mods = 'SUPER',
		action = wezterm.action_callback(function(window, _)
			backdrops:cycle_forward(window)
		end),
	},
	{
		key = [[/]],
		mods = 'SUPER|CTRL',
		action = act.InputSelector({
			title = 'Select Background',
			choices = backdrops:choices(),
			fuzzy = true,
			fuzzy_description = 'Select Background: ',
			---@diagnostic disable-next-line: unused-local
			action = wezterm.action_callback(function(window, _pane, idx)
				---@diagnostic disable-next-line: param-type-mismatch
				backdrops:set_img(window, tonumber(idx))
			end),
		}),
	},

	-- panes
	-- panes: split panes
	{
		key = 'v',
		mods = 'LEADER',
		action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
	},
	{
		key = 'g',
		mods = 'LEADER',
		action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
	},

	-- panes: zoom+close pane
	{ key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

	-- panes: navigation
	-- { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection('Up') },
	-- { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection('Down') },
	-- { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection('Left') },
	-- { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection('Right') },

	{
		key = 'p',
		mods = 'SUPER|CTRL',
		action = act.PaneSelect({
			alphabet = '1234567890',
			mode = 'SwapWithActiveKeepFocus',
		}),
	},

	-- copy mode
	{ key = '[', mods = 'LEADER', action = 'ActivateCopyMode' },

	-- key-tables
	-- resizes fonts
	{
		key = 'f',
		mods = 'LEADER',
		action = act.ActivateKeyTable({
			name = 'resize_font',
			one_shot = false,
			timemout_miliseconds = 1000,
		}),
	},
	-- resize panes
	{
		key = 'p',
		mods = 'LEADER',
		action = act.ActivateKeyTable({
			name = 'resize_pane',
			one_shot = false,
			timemout_miliseconds = 1000,
		}),
	},
}

local key_tables = {
	resize_font = {
		{ key = 'k', action = act.IncreaseFontSize },
		{ key = 'j', action = act.DecreaseFontSize },
		{ key = 'r', action = act.ResetFontSize },
		{ key = 'Enter', action = 'PopKeyTable' },
		{ key = 'Escape', action = 'PopKeyTable' },
		{ key = 'q', action = 'PopKeyTable' },
	},
	resize_pane = {
		{ key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
		{ key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
		{ key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
		{ key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
		{ key = 'Enter', action = 'PopKeyTable' },
		{ key = 'Escape', action = 'PopKeyTable' },
		{ key = 'q', action = 'PopKeyTable' },
	},
}

local mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.OpenLinkAtMouseCursor,
	},
}

-- for _, key in ipairs(require('plugins.smartsplits').keys) do
-- 	table.insert(keys, key)
-- end

return {
	disable_default_key_bindings = true,
	leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}
