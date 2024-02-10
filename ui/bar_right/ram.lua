local wibox = require("wibox")
local utils = require("utils")
local awful = require("awful")
local config= require("config")

local ram = wibox.widget {
    widget = wibox.widget.textbox,
    text = "ram 0.00GB"
}

utils.watch(config.ram_poll_interval, function()
    awful.spawn.easy_async_with_shell("free -m | awk 'NR==2 {print $3}'", function(stdout)
        local mb = tonumber(stdout)
        ram.text = string.format("ram %.2fGB", mb / 1024.0)
    end)
end)

return ram