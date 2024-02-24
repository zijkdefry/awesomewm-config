local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears     = require("gears")

local function round_container(wgt)
    return wibox.widget {
        widget = wibox.container.background,
        bg = "#303030",
        shape = function (cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
        {
            widget = wibox.container.margin,
            left = 12, right = 12, top = 4, bottom = 4,
            {
                widget = wibox.container.place,
                halign = "center",
                wgt
            }
        }
    }
end

local sysinfo = {
    layout = wibox.layout.fixed.vertical,
    spacing = 10,
    {
        widget = wibox.container.place,
        halign = "center",
        round_container(require("ui.menu.clock"))
    },
    {
        layout = wibox.layout.flex.horizontal,
        round_container(require("ui.menu.volume")),
        round_container(require("ui.menu.backlight")),
        spacing = 10
    },
    round_container(require("ui.menu.wifi")),
    {
        layout = wibox.layout.flex.horizontal,
        round_container(require("ui.menu.usage").down),
        round_container(require("ui.menu.usage").up),
        spacing = 10
    },
}

local function create_sysmenu(s)
    local popup = awful.popup {
        screen = s,
        ontop = true,
        visible = false,
        placement = function(d) 
            return awful.placement.top_left(d, {
                offset = { x = 0, y = beautiful.bar_size }
            })
        end,
        widget = wibox.widget {
            widget = wibox.container.margin,
            margins = 10,
            {
                layout = wibox.layout.fixed.vertical,
                spacing = 20,
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = 20,
                    {
                        widget = wibox.container.constraint,
                        width = 300,
                        strategy = "exact",
                        sysinfo
                    },
                    require("ui.menu.calendar"),
                },
                {
                    widget = wibox.container.place,
                    halign = "left",
                    require("ui.menu.notifications")
                }
            }
        },
        border_width = 1,
        border_color = "#ffffff",
        fg = "#ffffff",
        bg = "#202020"
    }

    awesome.connect_signal("sysmenu::toggle", function()
        popup.visible = not popup.visible

        if popup.visible then
            awesome.emit_signal("sysmenu::show")
        else
            awesome.emit_signal("sysmenu::hide")
        end
    end)
end

return create_sysmenu