--- @meta _

error('Cannot require a meta file')

cx = {}

--- @class THEME
THEME = { manager = {} }

--- @class Command
--- @field PIPED any
-- Command = function() end

--- @class Status
--- @field _tab table
--- @field style fun(self: Status)
--- @field mode fun(self: Status)
--- @field size fun(self: Status)
--- @field name fun(self: Status)
--- @field permissions fun(self: Status)
--- @field percentage fun(self: Status)
--- @field position fun(self: Status)
--- @field children_add fun(self: Status, fn, order: integer, side)
--- @field children_remove fun(self: Status, id: integer, side)
Status = {
	LEFT = 0,
	RIGHT = 1,

	_id = 'status',
	_inc = 1000,
}

--- @class Header
--- @field _tab table
--- @field cwd fun(self: Header)
--- @field flags fun(self: Header)
--- @field count fun(self: Header)
--- @field tabs fun(self: Header)
--- @field children_add fun(self: Header, fn, order: integer, side)
--- @field children_remove fun(self: Header, id: integer, side)
Header = {
	LEFT = 0,
	RIGHT = 1,

	_id = 'header',
	_inc = 1000,
}

--- @class ui
--- @field Layout table
--- @field Span fun(str: string)
--- @field Line fun(spans: table)
--- @field Paragraph table
--- @field Constraint table
ui = {}

--- --- @class Manager
--- --- @field area any
--- --- @field layout fun(self: Manager, area: any)
--- Manager = {}
---
--- --- @class Progress
--- --- @field render fun(area: any, width: number): table
--- Progress = {}

--- @class ya
--- @field clamp fun(min: number, x: number, max: number): number
--- @field round fun(value: number): number
--- @field user_name fun(uid: number): string
--- @field group_name fun(gid: number): string
--- @field target_family fun(): string
--- @field app_emit fun(event: string, args: table)
--- @field manager_emit fun(event: string, args: table)
--- @field err fun(error: string)
--- @field preview_widgets fun(self: ya, args: table)
--- @field preview_code fun(self: ya)
--- @field truncate fun(str: string, args: table)
ya = {}
