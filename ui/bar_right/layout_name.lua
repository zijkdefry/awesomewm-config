local awful = require("awful")
local wibox = require("wibox")
local config= require("config")

local layout_name = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    buttons = awful.button({}, 1, function()
        awful.layout.inc(1)
    end)
}

local function update_layout_info()
    local layout = awful.layout.get(awful.screen.focused())
    layout_name.text = layout.name
end
update_layout_info()

tag.connect_signal("property::layout", update_layout_info)
tag.connect_signal("property::selected", update_layout_info)

return {
    spacing = 5,
    layout = wibox.layout.fixed.horizontal,
    {
        widget = wibox.widget.imagebox,
        image = config.icons_dir .. "layout-icon.png",
    },
    layout_name
}