local wibox = require("wibox")
local awful = require("awful")
local utils = require("ui.utils")

local cpu = wibox.widget {
    widget = wibox.widget.textbox,
    text = "cpu 0.0%"
}

local cpu_helper = { user = 0, sys = 0, idle = 0 }
    
utils.watch(5, function()
    awful.spawn.easy_async_with_shell(
        [[ awk 'NR==1 {print $2, $4, $5}' /proc/stat ]],
        function (stdout)
            local match = string.gmatch(stdout, "[0-9]+")
            user_curr = tonumber(match())
            sys_curr = tonumber(match())
            idle_curr = tonumber(match())

            delta_user = user_curr - cpu_helper.user
            delta_sys = sys_curr - cpu_helper.sys
            delta_idle = idle_curr - cpu_helper.idle

            cpu_helper.user = user_curr
            cpu_helper.sys = sys_curr
            cpu_helper.idle = idle_curr

            local usage = (delta_user + delta_sys) * 100.0 / (delta_user + delta_sys + delta_idle)

            local cpuf = string.format("cpu %.1f%%", usage)
            cpu.text = cpuf
        end
    )
end)

return cpu