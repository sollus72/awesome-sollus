---------------------------------------------------------------------------------
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

-- local status_bin_cmd = "mocp -i"
local status_bin_cmd = "python /home/sollus/.config/awesome/mocplayer/mocp.py"

local widget_dir     = script_path()

--Section beautiful_icon
local mocp_off = widget_dir .. "mocp_off.png"
local mocp_stop = widget_dir .. "mocp_stop.png"
local mocp_play = widget_dir .. "mocp_play.png"
local mocp_pause = widget_dir .. "mocp_pause.png"

-- Section widget
local mocp_widget = wibox.widget {
{
id      = "icon",
image   = mocp_off,
--resize = false,
widget  = wibox.widget.imagebox,
  },
layout    = wibox.container.margin(_, _, _, 0),
set_image = function(self, path)
    self.icon.image = path
            end
}

-- Section for Watcher
local function update(widget, stdout, stderr, exitreason, exitcode)
  local status = stdout
  if string.find(status, "STOP", 1, true) then
    widget:set_image(mocp_stop)
  elseif string.find(status, "PLAY", 1, true) then
    widget:set_image(mocp_play)
  elseif string.find(status, "PAUSE", 1, true) then
    widget:set_image(mocp_pause)
  elseif string.find(status, "ERROR", 1, true) then
    widget:set_image(mocp_off)
  end
end

-- Section buttons
mocp_widget:connect_signal("button::press", function(_,_,_,button)
  if          (button == 1) then awful.spawn.with_shell("mocp -G")              -- Toggle between playing and paused
      elseif  (button == 2) then awful.spawn.with_shell("mocp -x")              -- Exit mocplayer
      elseif  (button == 4) then awful.spawn.with_shell("mocp -r")              -- Play the previous song
      elseif  (button == 5) then awful.spawn.with_shell("mocp -f")              -- Play the next song
      elseif  (button == 3) then awful.spawn.with_shell("lxterminal -e mocp")   -- start MOCplayer
  end
end)

watch(status_bin_cmd, 1, update, mocp_widget)

return mocp_widget
