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

local idx_max = 3
local function update_window_gaps_and_borders(t)
	local max = awful.layout.get_tag_layout_index(t) == idx_max

	t.gap = max and 0 or beautiful.useless_gap

	local clients = t:clients()
	if #clients > 0 then
		for _, c in pairs(clients) do
			c.border_width = max and 0 or beautiful.border_width
		end
	end
end

tag.connect_signal("property::layout", update_window_gaps_and_borders)
tag.connect_signal("property::selected", update_window_gaps_and_borders)


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