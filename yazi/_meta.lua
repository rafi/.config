--- @meta _

error("Cannot require a meta file")

--- @class cx
cx = { active = {} }

--- @class Linemode
Linemode = { _file = {} }

--- @class th
th = { git = {} }

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

	_id = "status",
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

	_id = "header",
	_inc = 1000,
}

--- @class ui
--- @field Layout table
--- @field Span fun(str: string)
--- @field Line fun(spans: table)
--- @field Paragraph table
--- @field Constraint table
ui = {}

--- @class ya
--- @field user_name fun(uid: number): string
--- @field group_name fun(gid: number): string
--- @field target_family fun(): string
--- @field readable_size fun(size: number)
ya = {}
