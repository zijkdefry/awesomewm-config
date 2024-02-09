local gears = require("gears")

local uiutils = {}

function uiutils.create_right_tag(cr, w, h, d)
	cr:move_to(0, 0)
	cr:line_to(w - d, 0)
	cr:line_to(w, h/2)
	cr:line_to(w - d, h)
	cr:line_to(0, h)

	cr:close_path()
end

function uiutils.underline(thickness)
	return function(cr, w, h)
		cr:move_to(0, h)
		cr:line_to(w, h)
		cr:line_to(w, h - thickness)
		cr:line_to(0, h - thickness)

		cr:close_path()
	end
end

function uiutils.watch(timeout, callback)
    gears.timer {
        timeout = timeout,
        call_now = true,
        autostart = true,
        callback = callback
    }
end

return uiutils