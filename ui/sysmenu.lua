local awful = require("awful")
local wibox = require("wibox")

local function create_popup(s)
    local popup = awful.popup {
        widget = {
            widget = wibox.widget.textbox,
            text = "HELLO WORLD POPUP"
        },
        screen = s,
        visible = false,
        ontop = true,
        placement = function (d) 
            return awful.placement.top(d, { honor_workarea = true })
        end
    }

    local function toggle_visible()
        popup.visible = not popup.visible
    end

    return toggle_visible
end

return create_popup