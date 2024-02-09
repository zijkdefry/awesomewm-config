local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local config = require("config")

local mod = config.mod

local client_keys = gears.table.join(
    awful.key({mod}, "space", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),
    awful.key({mod}, "q", function(c) c:kill() end)
)

local client_buttons = gears.table.join(
    awful.button({}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({mod}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({mod}, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }
}

client.connect_signal("manage", function (c)
    if not awesome.startup then
        awful.client.setslave(c)
    end
    
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position
    then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)