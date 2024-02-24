local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local this_date = os.date("*t")
local view_month = { month = this_date.month, year = this_date.year }
local calendar = wibox.widget.calendar.month(this_date, "JetBrains Mono Regular 10")

local function cal_month(wgt)
    wgt.font = "JetBrains Mono Bold 10"

    return wibox.widget {
        widget = wibox.container.place,
        halign = "center",
        {
            widget = wibox.container.background,
            bg = "#303030",
            shape = gears.shape.rounded_bar,
            {
                widget = wibox.container.margin,
                left = 14, right = 14,
                top = 4, bottom = 4,
                wgt
            }
        }
    }
end

local function cal_weekday(wgt)
    wgt.font = "JetBrains Mono Bold 10"
    local weekend = wgt.text == "Sa" or wgt.text == "Su"

    return wibox.widget {
        widget = wibox.container.constraint,
        width = 30,
        height = 30,
        strategy = "exact",
        {
            widget = wibox.container.background,
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end,
            bg = "#303030",
            fg = weekend and "#ffa030" or "#4090e0",
            {
                widget = wibox.container.place,
                halign = "center",
                wgt
            }
        }
    }
end

local function cal_day(wgt, day, today)
    if day < 10 then
        wgt.text = tostring(day)
    end

    return wibox.widget {
        widget = wibox.container.constraint,
        width = 30,
        height = 30,
        strategy = "exact",
        {
            widget = wibox.container.background,
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end,
            shape_border_color = "#80c0ff",
            shape_border_width = today and 2 or 0,
            bg = "#303030",
            fg = today and "#80c0ff" or "#ffffff",
            {
                widget = wibox.container.place,
                halign = "center",
                wgt
            }
        }
    }
end

function calendar.fn_embed(wgt, flag, date)
    if flag == "normal" then return cal_day(wgt, date.day, false)
    elseif flag == "focus" then return cal_day(wgt, date.day, true)
    elseif flag == "weekday" then return cal_weekday(wgt)
    elseif flag == "header" then return cal_month(wgt)
    else return wgt end
end

local function update_view()
    if view_month.month == this_date.month and view_month.year == this_date.year then
        calendar.date = {
            day = this_date.day,
            month = this_date.month,
            year = this_date.year
        }

        return
    end

    calendar.date = { month = view_month.month, year = view_month.year }
end

local function cal_button(text, fg, btn)
    return wibox.widget {
        widget = wibox.container.background,
        bg = "#303030",
        fg = fg,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end,
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

local minc = cal_button("+M", "#00ff80", function()
    view_month.month = view_month.month + 1
    if view_month.month > 12 then
        view_month.month = 1
        view_month.year = view_month.year + 1
    end
    update_view()
end)

local mdec = cal_button("-M", "#ff4000", function()
    view_month.month = view_month.month - 1
    if view_month.month < 1 then
        view_month.month = 12
        view_month.year = view_month.year - 1
    end
    update_view()
end)

local yinc = cal_button("+Y", "#00ff80", function()
    view_month.year = view_month.year + 1
    update_view()
end)

local ydec = cal_button("-Y", "#ff4000", function()
    view_month.year = view_month.year - 1
    update_view()
end)

local reset = cal_button("now", "#ffffff", function()
    view_month.month = this_date.month
    view_month.year = this_date.year
    calendar.date = { day = this_date.day, month = this_date.month, year = this_date.year }
end)


return {
    layout = wibox.layout.fixed.vertical,
    spacing = 10,
    calendar,
    {
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
        ydec, mdec, reset, minc, yinc
    }
}