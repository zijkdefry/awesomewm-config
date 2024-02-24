local awful = require("awful")
local gears = require("gears")
local config = require("config")
local beautiful = require("beautiful")
local wibox = require("wibox")
local utils = require("utils")

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({config.mod}, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end)
)

local function update_taglist(self, t, _, _)
    self:get_children_by_id("underline")[1].bg =
        t.selected
            and beautiful.taglist_underline_focus
            or beautiful.taglist_underline_unfocus
end

local function create_taglist(s)
    return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
        widget_template = {
            layout = wibox.layout.stack,
            {
                widget = wibox.container.background,
                id = "background_role",
                {
                    widget = wibox.container.margin,
                    bottom = beautiful.underline_thickness,
                    left = beautiful.taglist_left_right_margins,
                    right = beautiful.taglist_left_right_margins,
                    {
                        widget = wibox.widget.textbox,
                        id = "text_role",
                    }
                }
            },
            {
                widget = wibox.container.background,
                bg = beautiful.fg_normal,
                id = "underline",
                shape = utils.underline(beautiful.underline_thickness),
                { layout = wibox.layout.fixed.horizontal }
            },
            update_callback = update_taglist,
            create_callback = update_taglist,
        }
	}
end

return create_taglist