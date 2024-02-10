local wibox = require("wibox")

local date = wibox.widget.textclock("%F %A")

return wibox.widget {
    widget = wibox.container.place,
    halign = "right",
    spacing = 15,
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = 20,
        require("ui.bar_right.net"),
        require("ui.bar_right.cpu"),
        require("ui.bar_right.ram"),
        date
    }
}