local wibox = require("wibox")

return function (screen)
    return wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 20, -- TEMPORARY
        require("ui.bar_left.taglist")(screen),
        require("ui.bar_left.layout_name"),
        require("ui.bar_left.window_name")
    }
end