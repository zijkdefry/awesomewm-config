local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local config= require("config")

local function make_btn(text, fg, btn)
    return wibox.widget {
        widget = wibox.container.background,
        bg = "#303030",
        fg = fg,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        buttons = awful.button({}, 1, btn),
        {
            widget = wibox.container.margin,
            margins = 4,
            {
                widget = wibox.widget.textbox,
                font = "JetBrains Mono Bold 10",
                text = text
            }
        }
    }
end

local shutdown = make_btn("sd", "#ff8700", function()
    awful.spawn.easy_async_with_shell(config.rofi_scripts .. "confirmation 'Shutdown system'", function (stdout)
        if stdout:match("yes") then
            awful.spawn("systemctl poweroff")
        end
    end)
end)

local reboot = make_btn("rb", "#0087ff", function()
    awful.spawn.easy_async_with_shell(config.rofi_scripts .. "confirmation 'Reboot system'", function (stdout)
        if stdout:match("yes") then
            awful.spawn("systemctl reboot")
        end
    end)
end)

return {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    shutdown, reboot
}