local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_bar(s)
	local bar_inner_widget = wibox.widget {
		layout = wibox.layout.ratio.horizontal,
		require("ui.bar_left")(s),
		{ layout = wibox.layout.fixed.horizontal },
		require("ui.bar_right")
	}

	bar_inner_widget:ajust_ratio(2, 0.61, 0.02, 0.37)

	local bar = awful.wibar {
		screen = s,
		position = beautiful.bar_pos,
		height = beautiful.bar_size,
		bg = beautiful.bg_bar
	}
	bar:setup { bar_inner_widget, layout = wibox.layout.flex.horizontal }
end

return create_bar