---@diagnostic disable: cast-local-type

local wibox = require("wibox")
local awful = require("awful")
local utils = require("utils")
local config = require("config")

local function humanise(rate)
    if rate < 1024 then
        return string.format("%.0fB/s", rate)
    elseif rate < 100 * 1024 then
        return string.format("%.1fkB/s", rate / 1024)
    elseif rate < 1024 * 1024 then
        return string.format("%.0fkB/s", rate / 1024)
    elseif rate < 100 * 1024 * 1024 then
        return string.format("%.1fMB/s", rate / 1024 / 1024)
    else  
        return string.format("%.0fMB/s", rate / 1024 / 1024)
    end
end

net_cmd_template = [[ awk '$1 == "%s:" { print $2, $10 }' /proc/net/dev ]]
net_cmd = string.format(net_cmd_template, config.default_net_interface)

local up_total = 0
local down_total = 0
local initial_poll = true

local down = wibox.widget.textbox("0B/s")
local up = wibox.widget.textbox("0B/s")

utils.watch(config.net_poll_interval, function()
    awful.spawn.easy_async_with_shell(net_cmd, function (stdout)
        local match = string.gmatch(stdout, "[0-9]+")
        down_curr = tonumber(match())
        up_curr = tonumber(match())

        down_diff = down_curr - down_total
        up_diff = up_curr - up_total

        down_total = down_curr
        up_total = up_curr

        if (initial_poll) then
            initial_poll = false
            return
        end

        up.text = humanise(up_diff / config.net_poll_interval)
        down.text = humanise(down_diff / config.net_poll_interval)
        
    end)
end)

return {
    layout = wibox.layout.fixed.horizontal,
    up,
    {
        widget = wibox.widget.imagebox,
        image = config.icons_dir .. "up-down.png",
    },
    down
}