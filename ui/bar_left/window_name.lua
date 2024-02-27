local wibox = require("wibox")
local config= require("config")
local awful = require("awful")
local gears = require("gears")

window_name = wibox.widget.textbox("-")
winicon = gears.surface(config.icons_dir .. "win-icon.png")
icon = wibox.widget {
    widget = wibox.widget.imagebox,
    image = winicon,
    buttons = awful.button({}, 1, function()
        awful.spawn("rofi -show window")
    end)
}

local function update_window_name()
    window_name.text = client.focus and client.focus.name or "-"
end

local function update_window_icon()
    icon.image = client.focus and client.focus.icon or winicon
end

client.connect_signal("focus", function()
    update_window_name()
    update_window_icon()
end)
client.connect_signal("unfocus", function()
    update_window_name()
    update_window_icon()
end)
client.connect_signal("property::name", update_window_name)
client.connect_signal("property::icon", update_window_icon)

return wibox.widget {
    widget = wibox.container.background,
    fg = "#7fafff",
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
        icon,
        window_name
    }
}