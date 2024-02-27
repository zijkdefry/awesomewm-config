local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local config = require("config")

beautiful.init(config.dir .. "theme.lua")
awesome.set_preferred_icon_size(beautiful.bar_size)

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.max,
}

awful.layout.layouts[1].name = "Tiling"
awful.layout.layouts[2].name = "Floating"
awful.layout.layouts[3].name = "Maximised"
local idx_max = 3

local function update_client_window_borders(c)
	local max = awful.layout.get_tag_layout_index(c.first_tag) == idx_max

	c.border_width = max and 0 or beautiful.border_width
end

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

client.connect_signal("manage", function (c)
	update_client_window_borders(c)

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
client.connect_signal("tagged", update_client_window_borders)
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

local function set_wallpaper(s)
	if beautiful.wallpaper then
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	set_wallpaper(s)
	awful.tag(
		{"1", "2", "3", "4", "5", "6", "7", "8", "9"},
		s, awful.layout.layouts[1]
	)
	require("ui.bar")(s)
	require("ui.sysmenu")(s)
end)