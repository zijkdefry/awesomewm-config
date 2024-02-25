local config = require("config")

return {
    -- font = "Inconsolata Bold 10",
    -- font = "Fira Code Bold 8"
    font = "Jetbrains Mono Bold 8",

    wallpaper = config.dir .. "wallpaper.jpg",

    bg_bar = "#000000",
    bar_pos = "top",

    bg_normal = "#141414",
    bg_focus = "#303030",
    bg_urgent = "#ff0000",

    fg_normal = "#ffffff",
    fg_focus = "#ffffff",
    fg_urgent = "#ffffff",
    fg_minimize = "#ffffff",

    bar_size = 26,

    underline_thickness = 2,
    taglist_left_right_margins = 5,

    powerline_depth = 10,
    powerline_gap = 7,
    powerline_margin = 14,
    bar_screen_edge_gap = 8,

    useless_gap = 4,
    border_width = 2,
    border_normal = "#303030",
    border_focus  = "#22aadd",
    border_marked = "#ff0000",

    taglist_bg_empty = "#000000",
    taglist_fg_empty = "#808080",
    taglist_bg_occupied = "#000000",
    taglist_fg_occupied = "#80e0e0",
    taglist_bg_focus = "#202020",
    taglist_fg_focus = "#ffffff",
    taglist_bg_urgent = "#400000",
    taglist_fg_urgent = "#ffffff",
    taglist_underline_unfocus = "#00000000",
    taglist_underline_focus = "#ffffff",
}