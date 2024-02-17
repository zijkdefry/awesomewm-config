local wibox = require("wibox")
local awful = require("awful")

local menu_vol = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono Bold 10",
    text = "vol: 42"
}

local cmd = "if [[ $(pamixer --get-mute) == true ]]; then echo muted; else pamixer --get-volume; fi"
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local volume = string.gsub(stdout, "\n", "")
        menu_vol.text = string.format("vol: %s", volume)
    end)
end)

return menu_vol