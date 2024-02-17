local wibox = require("wibox")
local gears = require("gears")

local menu_clock = wibox.widget {
    widget = wibox.widget.textbox,
    font = "JetBrains Mono Bold 12",
    text = "00:00:00"
}

local function update_clock()
    menu_clock.text = os.date("%H:%M:%S")
end
local timer = gears.timer {
    timeout = 1,
    callback  = update_clock
}

awesome.connect_signal("sysmenu::show", function()
    update_clock()
    timer:start()
end)
awesome.connect_signal("sysmenu::hide", function()
    timer:stop()
end)

return menu_clock