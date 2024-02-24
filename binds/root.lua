local awful = require("awful")
local gears = require("gears")
local config = require("config")
local utils  = require("utils")

local ctrl = config.ctrl
local shift = config.shift
local mod = config.mod

local global_keys = gears.table.join(
    awful.key({mod}, "Left", awful.tag.viewprev),
    awful.key({mod}, "Right", awful.tag.viewnext),
    awful.key({mod}, "l", function() awful.layout.inc(1) end),

    awful.key({mod, ctrl}, "n", awesome.quit),
    awful.key({mod, ctrl}, "m", awesome.restart),
    awful.key({mod}, "Return", function() awful.spawn(config.terminal) end),
    awful.key({mod}, "r", function() awful.spawn("rofi -show drun") end),
    awful.key({mod}, "w", function() awful.spawn("rofi -show window") end),
    awful.key({mod}, "Escape", function() awesome.emit_signal("sysmenu::toggle") end)
)

root.keys(global_keys)