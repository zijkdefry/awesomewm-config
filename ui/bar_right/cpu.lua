---@diagnostic disable: cast-local-type

local wibox = require("wibox")
local awful = require("awful")
local utils = require("ui.utils")
local config= require("config")

local cpu = wibox.widget {
    widget = wibox.widget.textbox,
    text = "cpu 0.0%"
}

local user = 0
local sys = 0
local idle = 0
    
utils.watch(config.cpu_poll_interval, function()
    awful.spawn.easy_async_with_shell(
        [[ awk 'NR==1 {print $2, $4, $5}' /proc/stat ]],
        function (stdout)
            local match = string.gmatch(stdout, "[0-9]+")
            user_curr = tonumber(match())
            sys_curr = tonumber(match())
            idle_curr = tonumber(match())

            delta_user = user_curr - user
            delta_sys = sys_curr - sys
            delta_idle = idle_curr - idle

            user = user_curr
            sys = sys_curr
            idle = idle_curr

            local usage = (delta_user + delta_sys) * 100.0 / (delta_user + delta_sys + delta_idle)

            cpu.text = string.format("cpu %.1f%%", usage)
        end
    )
end)

return cpu