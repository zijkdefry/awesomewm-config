local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")
local config= require("config")
local awful = require("awful")

return function(s) 
    return wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 15,
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            require("ui.bar_left.taglist")(s),
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    widget = wibox.widget.imagebox,
                    image = config.icons_dir .. "apps-icon.png",
                    buttons = awful.button({}, 1, function() awful.spawn("rofi -show drun") end),
                },
                {
                    widget = wibox.widget.imagebox,
                    image = config.icons_dir .. "dropdown-icon.png",
                    buttons = awful.button({}, 1, function() awesome.emit_signal("sysmenu::toggle") end),
                }
            }
        },
        require("ui.bar_left.window_name")
    }
end