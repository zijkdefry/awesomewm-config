local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_bar(s, toggle_sysmenu_visibility)
	local bar_inner_widget = wibox.widget {
		layout = wibox.layout.ratio.horizontal,
		require("ui.bar_left")(s),
		{
			widget = wibox.container.background,
			bg = "#202020",
			{widget = wibox.container.place,
			halign = "center",
			wibox.widget.textclock("%R")},
			buttons = awful.button({}, 1, toggle_sysmenu_visibility)
		},
		require("ui.bar_right")
	}

	bar_inner_widget:ajust_ratio(2, 0.46, 0.08, 0.46)


	local bar = awful.wibar {
		screen = s,
		position = beautiful.bar_pos,
		height = beautiful.bar_size,
		bg = beautiful.bg_bar
	}
	bar:setup { bar_inner_widget, layout = wibox.layout.flex.horizontal }
end

return create_bar