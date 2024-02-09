local awful = require("awful")
local wibox = require("wibox")
local uiutils = require("ui.utils")
local gears   = require("gears")
local beautiful = require("beautiful")

local clock = wibox.widget.textclock("%R")

local function create_bar(s)
	local bar_inner_widget = wibox.widget {
		layout = wibox.layout.ratio.horizontal,
		require("ui.bar_left")(s),
		{
			widget = wibox.container.background,
			bg = "#202020",
			{
				widget = wibox.container.place,
				halign = "center",
				clock
			}
		},
		require("ui.bar_right")
	}
	bar_inner_widget:ajust_ratio(2, 0.44, 0.12, 0.44)


	local bar = awful.wibar {
		screen = s,
		position = "bottom",
		height = beautiful.bar_size,
		bg = "#000000"
	}
	bar:setup { bar_inner_widget, layout = wibox.layout.flex.horizontal }
end

return create_bar