local awful = require("awful")
local gears = require("gears")
local config = require("config")

local ctrl = config.ctrl
local shift = config.shift
local mod = config.mod

local global_keys = gears.table.join(
    awful.key({mod}, "Left", awful.tag.viewprev),
    awful.key({mod}, "Right", awful.tag.viewnext),
    awful.key({mod}, "l", function() awful.layout.inc(1) end),

    awful.key({mod, ctrl}, "n", awesome.quit),
    awful.key({mod, ctrl}, "m", awesome.restart),
    awful.key({mod}, "Return", function() awful.spawn(config.terminal_cmd) end),
    awful.key({mod}, "r", function() awful.spawn(config.rofi_drun_cmd) end),
    awful.key({mod}, "w", function() awful.spawn(config.rofi_window_cmd) end)
)

root.keys(global_keys)