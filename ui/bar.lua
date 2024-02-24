local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_bar(s)
	local bar_inner_widget = wibox.widget {
		layout = wibox.layout.ratio.horizontal,
		require("ui.bar_left"),
		{
			widget = wibox.container.place,
			halign = "center",
			valign = "top",
			{
				widget = wibox.layout.constraint,
				height = beautiful.bar_size,
				strategy = "exact",
				require("ui.taglist")(s)
			}
		},
		require("ui.bar_right")
	}

	bar_inner_widget:ajust_ratio(2, 0.45, 0.1, 0.45)


	local bar = awful.wibar {
		screen = s,
		position = beautiful.bar_pos,
		height = beautiful.bar_size,
		bg = beautiful.bg_bar
	}
	bar:setup { bar_inner_widget, layout = wibox.layout.flex.horizontal }
end

return create_bar