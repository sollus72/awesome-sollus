------------------------------------------------------------------
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
-----------------------------------------------------------------

local awful   = require("awful")
local wibox   = require("wibox")
local gears   = require("gears")
local naughty = require("naughty")
local string  = require("string")
local watch   = require("awful.widget.watch")
local spawn   = require("awful.spawn")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir        = script_path()
local status_bin_cmd    = "ping -c 1 8.8.8.8"

local args = args or {}
local timeout = args.timeout or 3

local number_net = 1

local wnet_idle     = widget_dir .. "wnet-idle.svg"
local wnet_x        = widget_dir .. "wnet-x.svg"
local wnet_x2       = widget_dir .. "wnet-x2.svg"

-- local networks_icon    = widget_dir .. "networks1.svg"
local wifi_icon     = widget_dir .. "wifi1.svg"


local wnet_widget   = wibox.widget {
{
id      = "icon",
image   = wnet_x,
--resize = false,
--icon_size = 16,
widget  = wibox.widget.imagebox,
  },
layout    = wibox.container.margin(_, _, _, 0),
set_image = function(self, path)
    self.icon.image = path
  end
}
local function update(widget, stdout, stderr, exitreason, exitcode)

  local status = stdout

  if string.find(status, "ping statistics", 1, true) then
    widget:set_image(wnet_idle)
  elseif string.find(status, "", 1, true) then
    widget:set_image(wnet_x)
  end
end

local notification
function show_wnet_status()
    awful.spawn.easy_async([[bash -c 'iwctl station wlan0 show | grep Connected']],
        function(stdout, _, _, _)
            notification = naughty.notify {
                text = stdout,
                icon = widget_dir .. "wnet-idle.svg",
                --icon_size = 24,
                title = "WIFI status",
                timeout = 20,
                hover_timeout = 0.1,
                --width = 400,
            }
        end)
end

function known_networks()
    awful.spawn.easy_async([[bash -c 'iwctl known-networks list | grep psk']],
        function(stdout, _, _, _)
            notification = naughty.notify {
                text = stdout,
                position = "top_middle",
                icon = widget_dir .. "wnet-idle.svg",
                --icon_size = 24,
                title = "WIFI Known Networks" .. '\n',
                timeout = 20,
                hover_timeout = 0.1,
                --width = 400,
            }
        end)
end

function network_menu ()
      local f1 = io.popen('iwctl station wlan0 scan && iwctl station wlan0 get-networks | grep psk')
      local nets1 = {}
        for w in f1:lines() do
            local ww = string.sub(w, 5, 25)
            nets1[#nets1 + 1] = ww
              if ww:find('m>') then
                table.remove(nets1, nets1[#nets1 +1])
              end            
        end

      nets = {}
        for i, c in pairs(nets1) do
          nets[i] =
            { c,
             function()  notification = naughty.notify {
                    text = c,
                    font = 'Play 10',
                    -- position = top_middle,
                    icon = wifi_icon,
                    icon_size = 18,
                    border_color = '#6F6F6F', 
                    border_width = 2, 
                    bg_normal = '#3F3F3F',
                    bg_focus = '#6F6F6F',
                    fg = '#00ff00',
                    title = "Try Network Connect to:",
                    timeout = 0,
                    hover_timeout = 0.1,
                    -- height = 43,
                    -- width = 200,
                                                       },
                      awful.prompt.run {
                          prompt       = '<b>Enter Password: </b>',
                          bg_cursor    = '#FFFF00',   -- yellow
                          textbox      = mouse.screen.mypromptbox.widget,
                          exe_callback = function(input)
                              if not input or #input == 0 then return end
                                io.popen('iwctl --passphrase ' .. input .. ' station wlan0 connect ' .. c)
                              end
                                      }

             end,
             wifi_icon
            }
        end
end

function forget_network()
      local f1 = io.popen('iwctl known-networks list | grep psk')
      local nets1 = {}
        for w in f1:lines() do
            local ww = string.sub(w, 3, 18)
            nets1[#nets1 + 1] = ww
        end

      nets2 = {}
        for i, c in pairs(nets1) do
          nets2[i] =
            { c,
             function()  notification = naughty.notify {
                    text = c,
                    font = 'Play 10',
                    -- position = top_middle,
                    icon = wifi_icon,
                    icon_size = 18,
                    border_color = '#6F6F6F', 
                    border_width = 2, 
                    bg_normal = '#3F3F3F',
                    bg_focus = '#6F6F6F',
                    fg = '#00ff00',
                    title = "The network to be forgotten:",
                    timeout = 0,
                    hover_timeout = 0.1,
                    -- height = 43,
                    -- width = 200,
                                                       },
                      awful.prompt.run {
                          prompt       = '<b>Forget Network? (y/n): </b>',
                          bg_cursor    = '#FFFF00',   -- yellow
                          textbox      = mouse.screen.mypromptbox.widget,
                          exe_callback = function(input)
                              if not input or #input == 0 then return end
                                  if input == 'y' then 
                                io.popen('iwctl known-networks ' .. c .. ' forget')
                                  end
                              end
                                      }
             end,
             wnet_x2
            }
        end
end
  
 --Section menu
 -- menu option
  local theme  = { font = 'Play 10', 
                            width = 170, height = 19,
                            border_color = '#6F6F6F', border_width = 2,
                            bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' }

      local menu_wifi = awful.menu({ items = { 
                                            { "Disconnect WIFI", function () awful.spawn.with_shell ('iwctl station wlan0 disconnect') end, wnet_x },
                                            { "Known Networks",  function () known_networks() end, wnet_idle },
                                            { "Forget Network",  function () forget_network()
                                                                    awful.menu({items = nets2 , theme = theme }):show() end, wnet_x2 },
                                                           
                                            { "WIFI Status",  function () show_wnet_status() end, wnet_idle },
                                            { "WIFI connect", function ()
                                                                if number_net == 1 then
                                                                    number_net = 2
                                                                    network_menu()
                                                                    menu_net = awful.menu({items = nets , 
                                                                                        theme = theme
                                                                              })
                                                                  else
                                                                    number_net = 1
                                                                end
                                                                    menu_net:toggle()
                                                              end, 
                                                            wnet_idle },
                                              },
                                   -- theme = theme
                                   theme = { width = 140, height = 18, border_color = '#6F6F6F', border_width = 2, bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' }
                            })

-- wnet_widget menu call functions
wnet_widget:connect_signal("button::press", function(_,_,_,button)
  if          (button == 1) then menu_wifi:toggle()
      elseif  (button == 2) then known_networks()
      elseif  (button == 3) then show_wnet_status()
  end
  spawn.easy_async(status_bin_cmd, function(stdout, stderr, exitreason, exitcode) update(wnet_widget, stdout, stderr, exitreason, exitcode) end)
end)

watch(status_bin_cmd, timeout, update, wnet_widget)
return wnet_widget
