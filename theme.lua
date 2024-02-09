local themes_path = "/home/zijk/.config/awesome/themes/"

local theme = {}

-- theme.font = "Inconsolata Bold 10"
theme.font = "Jetbrains Mono Bold 8"
-- theme.font = "Fira Code Bold 8"

theme.wallpaper = "/home/zijk/Downloads/wallpaperflare.com_wallpaper.jpg"

theme.bg_normal     = "#141414"
theme.bg_focus      = "#303030"
theme.bg_urgent     = "#ff0000"

theme.fg_normal     = "#cccccc"
theme.fg_focus      = "#cccccc"
theme.fg_urgent     = "#cccccc"
theme.fg_minimize   = "#cccccc"

theme.bar_size = 26
theme.powerline_depth = 9
theme.tag_flat_margin = 7
theme.powerline_major_margin = theme.powerline_depth + theme.tag_flat_margin
theme.powerline_minor_margin = theme.powerline_depth
theme.underline_thickness = 2
theme.taglist_left_right_margins = 5
theme.powerline_gaps = 3

theme.useless_gap   = 4
theme.border_width  = 2
theme.border_normal = "#303030"
theme.border_focus  = "#22aadd"
theme.border_marked = "#ff0000"

theme.taglist_bg_occupied = "#00000000"
theme.taglist_bg_focus = "#ffffff20"
theme.taglist_underline_unfocus = "#00000000"
theme.taglist_underline_focus = "#ffffff"

return theme
