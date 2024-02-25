local awful = require("awful")
local beautiful = require("beautiful")

local client_binds = require("binds.client")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_binds.keys,
            buttons = client_binds.buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    {
        rule_any = { instance = {"term-float"} },
        properties = {
            floating = true,
            placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
            width = 850,
            height = 450,
        }
    }
}