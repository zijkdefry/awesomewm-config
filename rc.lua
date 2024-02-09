local naughty = require("naughty")
local awful = require("awful")

if awesome.startup_errors then
	naughty.notify {
		preset = naughty.config.presets.critical,
		title = "An error occured at startup",
		text = awesome.startup_errors,
	}
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		if in_error then return end
		in_error = true

		naughty.notify {
			preset = naughty.config.presets.critical,
			title = "An error occured",
			text = tostring(err)
		}
		
		in_error = false
	end)
end

require("setup")
require("binds")
require("rules")
