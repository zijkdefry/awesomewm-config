local wibox = require("wibox")
local awful = require("awful")
local config= require("config")

local menu_wifi = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono SemiBold 10",
    text = "N/A"
}

local cmd = config.scripts_dir .. "iwd-getwifi"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local wifi_name = string.gsub(stdout, "\n", "")
        menu_wifi.text = wifi_name
    end)
end)

return {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    buttons = awful.button({}, 1, function()
        awful.spawn(config.rofi_scripts .. "wifi-menu")
    end),
    {
        widget = wibox.container.constraint,
        height = 25,
        strategy = "max",
        wibox.widget.imagebox(config.icons_dir .. "wifi-icon.png")
    },
    menu_wifi
}