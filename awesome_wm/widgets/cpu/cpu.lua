-- sudo pacman -S xorg-backlight light
-------------------------------------------------

local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local awful = require("awful")
-- local beautiful = require("beautiful")
local naughty = require("naughty")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir = script_path()
local cpu_logo = widget_dir .. "cpu.png"
local cpu_pamac = widget_dir .. "pamac1.png"
local cpu_term = widget_dir .. "terminal1.png"
local cpu_lxappearance = widget_dir .. "lxap1.png"

local CPU_CMD = 'bash -c "top -b -n 1 | grep Cpu"'

local cpu_text = wibox.widget.textbox()
-- cpu_text:set_font('Play 8')

cpu_icon = wibox.widget {
{
id      = "icon",
image   = cpu_logo,
-- resize  = false,
widget  = wibox.widget.imagebox,
  },
layout    = wibox.container.margin(_, _, _, 0),
set_image = function(self, path)
    self.icon.image = path
  end
}

cpu_widget = wibox.widget {
    cpu_icon,
    cpu_text,
    layout = wibox.layout.fixed.horizontal,
}

local menu_cpu = awful.menu({ items = { 
    { "  Lxtask", function () awful.spawn.with_shell("lxtask") end, cpu_logo },
    { "  Pamac Manager", function () awful.spawn.with_shell("pamac-manager") end, cpu_pamac },
    { "  Lxappearance", "lxappearance", cpu_lxappearance },
    { "  Lxterminal", function () awful.spawn.with_shell("lxterminal") end, cpu_term }
                                 },
    theme = { font = 'Play 9', width = 130, height = 18, border_color = '#6F6F6F', border_width = 2, bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' }
                      })

cpu_icon:connect_signal("button::press", function(_,_,_,button)
  if          (button == 3) then awful.spawn.with_shell ('lxterminal')
      elseif  (button == 1) then menu_cpu:toggle()
      elseif  (button == 2) then awful.spawn.with_shell ('lxtask')
  end
end)

local update_widget = function(widget, stdout, stderr, exitreason, exitcode)
                          local s_cpu = string.gsub(stdout, ',', '.')
                          local cpu_u = tonumber(string.sub (s_cpu, 10, 13))
                          local cpu_y = tonumber(string.sub (s_cpu, 19, 22))
                            local cpu_add = cpu_u + cpu_y.."%"
                        widget:set_text(cpu_add)
                      end

watch(CPU_CMD, 5, update_widget, cpu_text)

return cpu_widget
