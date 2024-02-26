local wibox = require("wibox")
local awful = require("awful")
local config= require("config")

local menu_vol = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono SemiBold 10",
    text = "0"
}

local cmd = "if [[ $(pamixer --get-mute) == true ]]; then echo muted; else pamixer --get-volume; fi"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local volume = string.gsub(stdout, "\n", "")
        menu_vol.text = volume
    end)
end)

return {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    {
        widget = wibox.container.constraint,
        height = 25,
        strategy = "max",
        wibox.widget.imagebox(config.icons_dir .. "volume-icon.png")
    },
    menu_vol
}