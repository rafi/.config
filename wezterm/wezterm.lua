-- Wezterm
-- See https://wezfurlong.org/wezterm/config/lua/general.html

-- local config = wezterm.config_builder()
local config = {}

-- require('utils.backdrops'):set_files():random()

require('events.status').setup()
require('events.tabtitle').setup()
-- require('events.newtab').setup()

local function append(t)
	for k, v in pairs(t) do
		config[k] = v
	end
end

-- Machine-local, not in version control.
local ok, domains = pcall(require, 'config.domains')
if ok then
	append(domains)
end

append(require('config.fonts'))
append(require('config.ui'))
append(require('config.keymaps'))
append(require('config.general'))
append(require('config.launch'))

return config
