local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_bar(s)
	local bar_inner_widget = wibox.widget {
		layout = wibox.layout.flex.horizontal,
		require("ui.bar_left")(s),
		--nil,
		require("ui.bar_right")
	}

	local bar = awful.wibar {
		screen = s,
		position = beautiful.bar_pos,
		height = beautiful.bar_size,
		bg = beautiful.bg_bar
	}
	bar:setup { bar_inner_widget, layout = wibox.layout.flex.horizontal }
end

return create_bar