local gears = require("gears")
local awful = require("awful")

local utils = {}

function utils.create_right_tag(cr, w, h, d)
	cr:move_to(0, 0)
	cr:line_to(w - d, 0)
	cr:line_to(w, h/2)
	cr:line_to(w - d, h)
	cr:line_to(0, h)

	cr:close_path()
end

function utils.underline(thickness)
	return function(cr, w, h)
		cr:move_to(0, h)
		cr:line_to(w, h)
		cr:line_to(w, h - thickness)
		cr:line_to(0, h - thickness)

		cr:close_path()
	end
end

function utils.watch(timeout, callback)
    gears.timer {
        timeout = timeout,
        call_now = true,
        autostart = true,
        callback = callback
    }
end

local all_tags = nil
local function go_to_tag(tag_idx)
	if (not all_tags) then all_tags = root.tags() end

	all_tags[tag_idx]:view_only()
end

local function move_client_to_tag(client, tag_idx)
	if (not all_tags) then all_tags = root.tags() end
	client:move_to_tag(all_tags[tag_idx])
end

all_tags_str = "1\\n2\\n3\\n4\\n5\\n6\\n7\\n8\\n9"
function utils.rofi_go_to_tag()
	local cmd = string.format(
		[[ echo -e "%s" | rofi -dmenu -p tag -theme atheme-tag.rasi -mesg "Select Tag"]],
		all_tags_str
	)
	awful.spawn.easy_async_with_shell(cmd, function (stdout)
		if stdout == "" then return end
		go_to_tag(tonumber(stdout))
	end)
end

function utils.rofi_move_client_to_tag(client)
	local cmd = string.format(
		[[ echo -e "%s" | rofi -dmenu -p tag -theme atheme-tag.rasi -mesg "Select Tag"]],
		all_tags_str
	)
	awful.spawn.easy_async_with_shell(cmd, function (stdout)
		if stdout == "" then return end
		move_client_to_tag(client, tonumber(stdout))
	end)
end

return utils