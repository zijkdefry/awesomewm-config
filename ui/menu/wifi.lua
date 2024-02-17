local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local config= require("config")

local menu_wifi = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono Bold 10",
    text = "wifi: N/A"
}

local cmd = config.scripts_dir .. "iwd-getwifi"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local wifi_name = string.gsub(stdout, "\n", "")
        menu_wifi.text = string.format("wifi: %s", wifi_name)
    end)
end)

return menu_wifi