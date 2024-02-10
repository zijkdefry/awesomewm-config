local awful = require("awful")
local wibox = require("wibox")
local config = require("config")

local layout_name = wibox.widget {
    widget = wibox.widget.textbox,
    text = "",
    buttons = awful.button({}, 1, function()
        awful.layout.inc(1)
    end)
}

local function update_layout_info(t)
    local layout = config.layout_names[awful.layout.get_tag_layout_index(t)]
    layout_name.text = layout
end

local current_tag = awful.screen.focused().selected_tag
update_layout_info(current_tag)

tag.connect_signal("property::layout", update_layout_info)
tag.connect_signal("property::selected", update_layout_info)

return layout_name