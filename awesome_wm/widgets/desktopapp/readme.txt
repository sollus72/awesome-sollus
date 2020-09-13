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
