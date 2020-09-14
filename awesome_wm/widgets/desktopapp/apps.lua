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

local awful   = require("awful")
local wibox   = require("wibox")
local spawn   = require("awful.spawn")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir      = script_path()

local desktop_icon    = widget_dir .. "desktop1.png"
local apps_icon       = widget_dir .. "apps1.png"

-- Section widget_imagebox
local desktop_app_widget = wibox.widget {
											{
											id      = "icon",
											image   = desktop_icon,
											-- resize = false,
											widget  = wibox.widget.imagebox,
											},
											layout    = wibox.container.margin(_, _, _, 1),
                         				}
-- Retrieving all Desktop filenames -->> nets table
function desktop_menu ()
		local f1 = io.popen('ls /usr/share/applications/*.desktop')
		      desktop_apps_list = {}
		        for str in f1:lines() do

					-- local pos1, pos2 = string.find(str,"[.]desktop")
					-- local w = string.sub(str,1,pos1-1) .. string.sub(str,pos2+1)
					local w = string.gsub(str, "[.]desktop", "")

					-- local pos1, pos2 = string.find(str,"/usr/share/applications/")
					-- local ww = string.sub(w,1,pos1-1) .. string.sub(w,pos2+1)
					local ww = string.gsub(w, "/usr/share/applications/", "")

						desktop_apps_list[#desktop_apps_list + 1] = ww
		        end
		        		  -- table desktop applications
					      nets = {}
					        for i, c in pairs(desktop_apps_list) do
					          nets[i] =
					            { c, function() awful.spawn.with_shell('gtk-launch ' .. c) end, apps_icon }
					        end
end

-- call application list menu
     desktop_app_widget:buttons(awful.util.table.join(
	      awful.button({ }, 1, function () desktop_menu() 
	      awful.menu({items = nets , 
		                  theme = { font = 'Play 10', 
		                  			width = 300, height = 19,
		                  			border_color = '#6F6F6F', border_width = 2,
		                  			bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' 
		                  		  }
        			}):toggle() end)
   	))

return desktop_app_widget
