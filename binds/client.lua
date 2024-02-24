local gears = require("gears")
local awful = require("awful")
local config = require("config")
local utils  = require("utils")

local mod = config.mod
local ctrl = config.ctrl

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

return {
    keys = client_keys,
    buttons = client_buttons
}