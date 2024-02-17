local wibox = require("wibox")
local awful = require("awful")

local menu_backlight = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono Bold 10",
    text = "bkl: 42%"
}

local cmd = "brightnessctl -m | awk -F, '{print $4}'"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local brightness = string.gsub(stdout, "\n", "")
        menu_backlight.text = string.format("bkl: %s", brightness)
    end)
end)

return menu_backlight