local wibox = require("wibox")

window_name = wibox.widget.textbox("i use arch btw")
local function update_window_name()
    window_name.text = client.focus and (client.focus.name) or "i use arch btw"
end
client.connect_signal("focus", update_window_name)
client.connect_signal("unfocus", update_window_name)
client.connect_signal("property::name", update_window_name)

return window_name