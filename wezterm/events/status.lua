-- WezTerm right status
-- Nerdfonts: https://github.com/wez/wezterm/blob/e5ac32f297cf3dd8f6ea280c130103f3cac4dddb/docs/config/lua/wezterm/nerdfonts.md

local wezterm = require('wezterm')
local nf = wezterm.nerdfonts
local umath = require('utils.math')
local M = {}

local SEPARATOR_CHAR = nf.oct_dash .. ' '
local CELL_MAX_WIDTH = 20

local discharging_icons = {
	nf.md_battery_10,
	nf.md_battery_20,
	nf.md_battery_30,
	nf.md_battery_40,
	nf.md_battery_50,
	nf.md_battery_60,
	nf.md_battery_70,
	nf.md_battery_80,
	nf.md_battery_90,
	nf.md_battery,
}
local charging_icons = {
	nf.md_battery_charging_10,
	nf.md_battery_charging_20,
	nf.md_battery_charging_30,
	nf.md_battery_charging_40,
	nf.md_battery_charging_50,
	nf.md_battery_charging_60,
	nf.md_battery_charging_70,
	nf.md_battery_charging_80,
	nf.md_battery_charging_90,
	nf.md_battery_charging,
}

local colors = {
	k8s_fg = '#304a2e',
	k8s_bg = 'rgba(0, 0, 0, 0.4)',
	date_fg = '#5b3e2c',
	date_bg = 'rgba(0, 0, 0, 0.4)',
	battery_fg = '#7c7157',
	battery_bg = 'rgba(0, 0, 0, 0.4)',
	separator_fg = '#4f88a1',
	separator_bg = 'rgba(0, 0, 0, 0.4)',
}

-- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)
local __cells__ = {}

---@param text string
---@param icon string
---@param fg string
---@param bg string
---@param separate boolean
local _push = function(text, icon, fg, bg, separate)
	table.insert(__cells__, { Foreground = { Color = fg } })
	table.insert(__cells__, { Background = { Color = bg } })
	table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
	table.insert(__cells__, { Text = ' ' .. icon .. ' ' .. text .. ' ' })

	if separate then
		table.insert(__cells__, { Foreground = { Color = colors.separator_fg } })
		table.insert(__cells__, { Background = { Color = colors.separator_bg } })
		table.insert(__cells__, { Text = SEPARATOR_CHAR })
	end
end

local _set_date = function()
	local date = wezterm.strftime(' %a %H:%M')
	_push(date, nf.fa_calendar, colors.date_fg, colors.date_bg, true)
end

local _set_battery = function()
	-- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/battery_info.html

	local charge = ''
	local icon = ''

	for _, b in ipairs(wezterm.battery_info()) do
		local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
		charge = string.format('%.0f%%', b.state_of_charge * 100)

		if b.state == 'Charging' then
			icon = charging_icons[idx]
		else
			icon = discharging_icons[idx]
		end
	end

	_push(charge, icon, colors.battery_fg, colors.battery_bg, false)
end

local _set_k8s_context = function(max_width)
	local success, stdout, stderr =
		wezterm.run_child_process({ 'kubectl', 'config', 'current-context' })
	if success and stderr == '' then
		local context = stdout:gsub('%s+', ''):gsub('_', '/')
		if #context > max_width then
			context = '…' .. context:sub(-max_width)
		end
		context = ' ' .. context
		_push(context, nf.fa_cube, colors.k8s_fg, colors.k8s_bg, true)
	end
end

M.setup = function()
	---@diagnostic disable-next-line: unused-local
	wezterm.on('update-right-status', function(window, _pane)
		__cells__ = {}
		_set_k8s_context(CELL_MAX_WIDTH)
		_set_date()
		_set_battery()

		window:set_right_status(wezterm.format(__cells__))
	end)
end

return M
