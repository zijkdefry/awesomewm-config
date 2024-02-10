local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local config= require("config")

beautiful.init(config.dir .. "theme.lua")

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.max,
}

local function set_wallpaper(s)
	if beautiful.wallpaper then
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end
screen.connect_signal("property::geometry", set_wallpaper)

local create_bar = require("ui.bar")
awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)
	awful.tag(
		{"1", "2", "3", "4", "5", "6", "7", "8", "9"},
		s, awful.layout.layouts[1]
	)
	create_bar(s)
end)