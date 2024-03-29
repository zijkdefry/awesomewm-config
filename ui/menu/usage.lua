local wibox = require("wibox")
local awful = require("awful")
local config= require("config")

local mb = 1024 * 1024
local gb = 1024 * 1024 * 1024
local function humanise(bytes)
    if bytes < 100 * mb then
        return string.format("%.2fMB", bytes / mb)
    elseif bytes < gb then
        return string.format("%.1fMB", bytes / mb)
    else
        return string.format("%.2fGB", bytes / gb)
    end
end

local up = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono SemiBold 10",
    text = "0MB"
}

local down = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono SemiBold 10",
    text = "0MB"
}

local cmd = string.format(
    [[ awk '$1 == "%s:" { print $2, $10 }' /proc/net/dev ]],
    config.default_net_interface
)
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async_with_shell(cmd, function (stdout)
        local matches = string.gmatch(stdout, "[0-9]+")
        local rx = tonumber(matches())
        local tx = tonumber(matches())

        down.text = humanise(rx)
        up.text = humanise(tx)
    end)
end)

return function(cont)
    return wibox.widget {
        layout = wibox.layout.flex.horizontal,
        cont({
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            {
                widget = wibox.container.constraint,
                height = 25,
                strategy = "max",
                wibox.widget.imagebox(config.icons_dir .. "rx-icon.png")
            }, down
        }, "#3fafff"),
        cont({
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            {
                widget = wibox.container.constraint,
                height = 25,
                strategy = "max",
                wibox.widget.imagebox(config.icons_dir .. "tx-icon.png")
            }, up
        }, "#ff3fff"),
        spacing = 10
    }
end