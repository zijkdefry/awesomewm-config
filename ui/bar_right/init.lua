local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local gears = require("gears")

return wibox.widget {
    widget = wibox.container.place,
    halign = "right",
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful.powerline_gap - beautiful.powerline_depth,
        utils.powerline_container(require("ui.bar_right.net"), "#7f007f", true),
        utils.powerline_container(require("ui.bar_right.cpu"), "#9f007f", true),
        utils.powerline_container(require("ui.bar_right.ram"), "#9f9f00", true),
        utils.powerline_container(require("ui.bar_right.layout_name"), "#3f7f00", true),
        {
            widget = wibox.container.background,
            bg = "#005f2f",
            shape = function(cr, w, h) gears.shape.rectangular_tag(cr, w, h, beautiful.powerline_depth) end,
            {
                widget = wibox.container.margin,
                right = beautiful.bar_screen_edge_gap,
                left = beautiful.powerline_margin,
                wibox.widget.textclock("%H:%M %a %Y-%m-%d")

            }
        }
    }
}