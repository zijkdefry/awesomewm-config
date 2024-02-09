local wibox = require("wibox")
local utils = require("ui.utils")
local awful = require("awful")

local ram = wibox.widget {
    widget = wibox.widget.textbox,
    text = "mem 0.00GB"
}

utils.watch(17, function()
    awful.spawn.easy_async_with_shell("free -m | awk 'NR==2 {print $3}'", function(stdout)
        local mb = tonumber(stdout)
        local ramf = string.format("mem %.2fGB", mb / 1024.0)

        ram.text = ramf
    end)
end)

return ram