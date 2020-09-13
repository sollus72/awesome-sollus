-------------------------------------------------------------------------
-- Dependencies:
-- gtk-launch
-- font = Play 10 or change

-- Usage

-- cp desktopapp/* ~/.config/awesome/

-- add in rc.lua require
-- 		...
-- 		local desktop_app_widget = require("desktopapp.apps")
-- 		...

-- add in rc.lua desktop_app_widget
-- 		...
-- 	    Create the wibox
-- 	    s.mywibox = awful.wibar({ position = "top", height = 20, screen = s })

-- 	    Add widgets to the wibox
-- 	    s.mywibox:setup {
--         layout = wibox.layout.align.horizontal,
--         { -- Left widgets
--             desktop_app_widget,
--  			...
--             s.mypromptbox,
--         },
--         s.mytasklist, -- Middle widget
--         { -- Right widgets
--             ...
-------------------------------------------------------------------------
-- Usage hotkeys
-- add in rc.lua
...
    awful.key({ modkey,           }, "a", function () desktop_menu() 
        awful.menu({items = nets , 
                      theme = { font = 'Play 10', 
                            width = 300, height = 19,
                            border_color = '#6F6F6F', border_width = 2,
                            bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' 
                            }
              }):toggle() end, 
              {description = "Desktop Apps", group = "mykeys"}),
...
