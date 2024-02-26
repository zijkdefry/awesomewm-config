local wibox = require("wibox")
local awful = require("awful")
local config= require("config")

local menu_backlight = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono SemiBold 10",
    text = "100%"
}

local cmd = "brightnessctl -m | awk -F, '{print $4}'"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local brightness = string.gsub(stdout, "\n", "")
        menu_backlight.text = brightness
    end)
end)

return {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    {
        widget = wibox.container.constraint,
        height = 25,
        strategy = "max",
        wibox.widget.imagebox(config.icons_dir .. "backlight-icon.png")
    },
    menu_backlight
}