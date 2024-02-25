local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local gears = require("gears")

return wibox.widget {
    widget = wibox.container.place,
    halign = "right",
    {
        widget = wibox.container.constraint,
        height = beautiful.bar_size,
        strategy = "exact",
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = beautiful.powerline_gap - beautiful.powerline_depth,
            utils.powerline_container(require("ui.bar_right.net"), "#8f3f00", true),
            utils.powerline_container(require("ui.bar_right.cpu"), "#005f5f", true),
            utils.powerline_container(require("ui.bar_right.ram"), "#005f00", true),
            {
                widget = wibox.container.background,
                bg = "#5f005f",
                shape = function(cr, w, h) gears.shape.rectangular_tag(cr, w, h, beautiful.powerline_depth) end,
                {
                    widget = wibox.container.margin,
                    right = beautiful.bar_screen_edge_gap,
                    left = beautiful.powerline_margin,
                    wibox.widget.textclock("%H:%M %a %Y-%m-%d"),
                }
            }
        }
    }
}