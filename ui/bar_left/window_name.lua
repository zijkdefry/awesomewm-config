local wibox = require("wibox")
local config= require("config")

window_name = wibox.widget.textbox("-")
local function update_window_name()
    window_name.text = client.focus and client.focus.name or "-"
end
client.connect_signal("focus", update_window_name)
client.connect_signal("unfocus", update_window_name)
client.connect_signal("property::name", update_window_name)

return wibox.widget {
    widget = wibox.container.background,
    fg = "#7fafff",
    window_name
}