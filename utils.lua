local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local utils = {}

function utils.underline(thickness)
	return function(cr, w, h)
		cr:move_to(0, h)
		cr:line_to(w, h)
		cr:line_to(w, h - thickness)
		cr:line_to(0, h - thickness)

		cr:close_path()
	end
end

function utils.watch(timeout, callback)
    gears.timer {
        timeout = timeout,
        call_now = true,
        autostart = true,
        callback = callback
    }
end

function utils.powerline_container(wgt, bg, right)
	local d = right and -beautiful.powerline_depth or beautiful.powerline_depth

	return {
        widget = wibox.container.background,
        bg = bg,
        shape = function(cr, w, h) gears.shape.powerline(cr, w, h, d) end,
        {
            widget = wibox.container.margin,
            left = beautiful.powerline_margin,
            right = beautiful.powerline_margin,
            wgt,
        }
    }
end

return utils