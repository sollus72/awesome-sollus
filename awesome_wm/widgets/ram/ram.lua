-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir = script_path()
local RAM_CMD = 'bash -c "free -h | grep Mem"'
local ram_logo = widget_dir .. "mem.png"
local ram_text = wibox.widget.textbox()
-- ram_text:set_font('Play 8')

local ram_icon = wibox.widget {
{
id      = "icon",
image   = ram_logo,
-- resize  = false,
widget  = wibox.widget.imagebox,
  },
layout    = wibox.container.margin(_, _, _, 0),
set_image = function(self, path)
    self.icon.image = path
  end
}

local ram_widget = wibox.widget {
    ram_icon,
    ram_text,
    layout = wibox.layout.fixed.horizontal,
}

local update_w = function(widget, stdout)
                    ram_level = string.sub(stdout, 27, 31)
                    widget:set_text(ram_level)
                 end

watch(RAM_CMD, 10, update_w, ram_text)

return ram_widget
