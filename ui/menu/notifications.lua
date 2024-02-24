local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local config= require("config")

local N = 3

local function create_notif_container()
    local time_wgt = wibox.widget {
        widget = wibox.widget.textbox,
        text = "",
        font = "JetBrains Mono Regular 8"
    }

    local appname_wgt = wibox.widget {
        widget = wibox.widget.textbox,
        text = "",
        font = "JetBrains Mono Bold 8"
    }

    local summ_wgt = wibox.widget {
        widget = wibox.widget.textbox,
        text = "",
        font = 'JetBrains Mono Regular 10',
    }

    local function set_notif(time, appname, summ)
        time_wgt.text = time
        appname_wgt.text = appname
        summ_wgt.text = summ
    end

    local function clear_notif()
        time_wgt.text = ""
        appname_wgt.text = ""
        summ_wgt.text = "-"
    end
    clear_notif()

    return {
        wgt = wibox.widget {
            widget = wibox.container.background,
            bg = "#303030",
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 8) end,
            {
                widget = wibox.container.margin,
                margins = 8,
                {
                    widget = wibox.container.constraint,
                    width = 475,
                    strategy = "exact",
                    {
                        layout = wibox.layout.fixed.vertical,
                        {
                            layout = wibox.layout.align.horizontal,
                            appname_wgt,
                            nil,
                            time_wgt
                        },
                        {
                            widget = wibox.container.constraint,
                            height = 88,
                            strategy = "max",
                            summ_wgt
                        }
                    }
                }
            }
        },
        setn = set_notif,
        clrn = clear_notif
    }
end

notifs = {
    layout = wibox.layout.fixed.vertical,
    spacing = 10
}

notifs[1] = wibox.widget {
    widget = wibox.widget.textbox,
    text = "Latest Notifications",
    font = "JetBrains Mono Bold 10"
}

setns = {}
clrns = {}

for i = 1, N do
    local cont = create_notif_container()
    notifs[i + 1] = cont.wgt
    setns[i] = cont.setn
    clrns[i] = cont.clrn
end

local latest_notifs_cmd = "python " .. config.scripts_dir .. "pydunst-wrapper.py latest " .. tostring(N)
awesome.connect_signal("sysmenu::show", function()
    awful.spawn.easy_async(latest_notifs_cmd, function(stdout)
        for line in stdout:gmatch("([^\n]*)\n?") do
            local has_notif = line:sub(1, 1) == "y"
            local idx = tonumber(line:sub(2, 2))

            if not has_notif then
                clrns[idx + 1]()
            else
                local t, app, summ = line:match("%w%d#(%d%d:%d%d)#([^#]*)#(.*)")
                setns[idx + 1](t, app, summ)
            end
        end
    end)
end)

return wibox.widget(notifs)