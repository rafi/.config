local M = {}

--    : https://wezfurlong.org/wezterm/config/lua/window-events/format-window-title.html
-- ref: https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
---@param s string|number
function M.basename(s)
	return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

return M
