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
            left = 8, right = 8,
            {
                widget = wibox.container.place,
                halign = "center",
                wgt
            }
        }
    }
end

local function create_sysmenu(s)
    local usage = require("ui.menu.usage")
    local menu_inner_widget = {
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
            round_container(usage.down),
            round_container(usage.up),
            spacing = 10
        },
    }

    local popup = awful.popup {
        screen = s,
        ontop = true,
        visible = false,
        placement = function(d) 
            return awful.placement.top(d, {
                offset = {
                    x = 0, y = beautiful.bar_size + beautiful.sysmenu_bar_gap
                }
            })
        end,
        widget = wibox.widget {
            widget = wibox.container.constraint,
            width = 300,
            strategy = "exact",
            {
                widget = wibox.container.margin,
                margins = 10,
                menu_inner_widget
            }
        },
        border_width = 2,
        border_color = "#cccccc",
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