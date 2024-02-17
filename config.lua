local gears = require("gears")

local home_dir = os.getenv("HOME") .. "/"

return {
    dir = gears.filesystem.get_configuration_dir(),
    scripts_dir = home_dir .. "scripts/",
    default_net_interface = "wlan0",

    mod = "Mod4",
    ctrl = "Control",
    shift = "Shift",
    
    terminal = "alacritty",

    none_focused_window_name = "i use arch btw",

    cpu_poll_interval = 5,
    ram_poll_interval = 17,
    net_poll_interval = 4,
}