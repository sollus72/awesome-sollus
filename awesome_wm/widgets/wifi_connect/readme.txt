--[[
https://github.com/sollus72/awesome-sollus/tree/master/awesome_wm/widgets/wifi_connect
YouTube preview https://youtu.be/DGfTbgW_X6I

Dependencies:
sudo pacman -S iwd

git clone https://github.com/sollus72/awesome-sollus.git
mkdir -p ~/config/awesome/nets/
cp ~/awesome-sollus/awesome_wm/widgets/wifi_connect/* ~/config/awesome/nets/

add requiere to rc.lua
...
local wnet_widget = require("nets.wnet")
...

add wnet_widget to rc.lua
...
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
...
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
...
            wnet_widget,
...            

--]]
