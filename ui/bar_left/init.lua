local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")

local function make_right_tag(cr, w, h, d)
    cr:move_to(0, 0)
	cr:line_to(w - d, 0)
	cr:line_to(w, h/2)
	cr:line_to(w - d, h)
	cr:line_to(0, h)

	cr:close_path()
end

return wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.powerline_gap - beautiful.powerline_depth,
    {
        widget = wibox.container.background,
        bg = "#870000",
        shape = function(cr, w, h) make_right_tag(cr, w, h, beautiful.powerline_depth) end,
        {
            widget = wibox.container.margin,
            left = beautiful.bar_screen_edge_gap,
            right = beautiful.powerline_margin,
            require("ui.bar_left.layout_name"),
        }
    },
    utils.powerline_container(require("ui.bar_left.window_name"), "#002f87", false)
}