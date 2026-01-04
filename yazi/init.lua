-- Yazi config init.

-- State synchronization between multiple Yazi instances
require("session"):setup({
	sync_yanked = true,
})

-- Show user/group of files in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	})
end, 300, Status.RIGHT)

local function render_date(spans, ts, prefix, color)
	local time = math.floor(ts)
	local ok, fmt = pcall(os.date, "%Y-%m-%d %H:%M", time)
	if ok then
		table.insert(spans, ui.Span(prefix .. " "))
		table.insert(spans, ui.Span(fmt .. " "):fg(color))
	end
end

-- Custom date in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h then
		return ""
	end

	local spans = {}
	render_date(spans, h.cha.btime, "c", "blue")
	if math.abs(h.cha.mtime - h.cha.btime) > 600 then
		render_date(spans, h.cha.mtime, "m", "yellow")
	end
	if math.abs(h.cha.mtime - h.cha.atime) > 600 then
		render_date(spans, h.cha.atime, "a", "green")
	end
	return ui.Line(spans)
end, 200, Status.RIGHT)

-- Extension for 'linemode' (yazi.toml)
function Linemode:size_and_mtime()
	local mtime = math.floor(self._file.cha.mtime or 0)
	local time
	if mtime == 0 then
		time = ""
	elseif os.date("%Y", mtime) == os.date("%Y") then
		time = os.date("%b %d %H:%M", mtime)
	else
		time = os.date("%b %d  %Y", mtime)
	end

	local size = self._file:size()
	return string.format("%s %s", time, size and ya.readable_size(size) or "-")
end
