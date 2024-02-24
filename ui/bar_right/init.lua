local wibox = require("wibox")

return wibox.widget {
    widget = wibox.container.place,
    halign = "right",
    spacing = 15, -- TEMP
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = 20,
        require("ui.bar_right.net"),
        require("ui.bar_right.cpu"),
        require("ui.bar_right.ram"),
        wibox.widget.textclock("%H:%M %a %Y-%m-%d")
    }
}