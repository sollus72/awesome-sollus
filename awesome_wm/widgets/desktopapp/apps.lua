------------------------------------------------------------------------------------------
local awful   = require("awful")
local wibox   = require("wibox")
local spawn   = require("awful.spawn")
local gears = require("gears")


local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

local widget_dir   = script_path()

local desktop_icon = widget_dir .. "desktop1.png"
local apps_icon    = widget_dir .. "apps1.png"

local number_apps  = 1

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
					local ww = str:gsub('(.*/)',''):gsub("[.]d(.*)", "")
						desktop_apps_list[#desktop_apps_list + 1] = ww
		        end
		        		  -- table desktop applications
					      nets = {}
					        for i, c in pairs(desktop_apps_list) do
					          nets[i] =
					            { c, function() awful.spawn.with_shell('gtk-launch ' .. c) end, apps_icon }
					        end
end

-- Version without Wacher
desktop_app_widget:connect_signal("button::press", function(_,_,_,button) 
    if  (button == 1) then  
		if number_apps == 1 then
		    number_apps = 2
		    desktop_menu()
		    menu_apps = awful.menu({items = nets , 
					                  theme = { font = 'Play 10', 
					                  			width = 250, height = 19,
					                  			border_color = '#6F6F6F', border_width = 2,
					                  			bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' 
					                  		  }
									})
	  	else
		    number_apps = 1
	    end
		menu_apps:toggle()
      -- elseif  (button == 2) then show_menu_etc()
      -- elseif  (button == 3) then show_menu_etc()
      end
    end)

return desktop_app_widget
