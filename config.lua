local gears = require("gears")

return {
    dir = gears.filesystem.get_configuration_dir(),
    default_net_interface = "wlan0",

    mod = "Mod4",
    ctrl = "Control",
    shift = "Shift",
    
    terminal = "alacritty",

    none_focused_window_name = "i use arch btw",
    layout_names = { "tile", "float", "max" },

    cpu_poll_interval = 5,
    ram_poll_interval = 17,
    net_poll_interval = 4,
}