---------------------------------------------------------------------------
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local awful   = require("awful")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir = script_path()

-- local audio_logo = widget_dir .. "audio1.svg"

local GET_audio_CMD = "python /home/sollus/.config/awesome/volume/audio.py"
local INC_audio_CMD = 'amixer -D pulse sset Master 5%+'
local DEC_audio_CMD = 'amixer -D pulse sset Master 5%-'
local TOG_VOLUME_CMD = 'mocp -G'
local NXT_VOLUME_CMD = 'mocp -f'
local PRV_VOLUME_CMD = 'mocp -r'

local audio_text = wibox.widget.textbox()
-- audio_text:set_font('Play 8')

local audio_icon = wibox.widget {
{
id      = "icon",
image   = audio_logo,
-- resize  = false,
widget  = wibox.widget.imagebox,
  },
layout    = wibox.container.margin(_, _, _, 0),
set_image = function(self, path)
    self.icon.image = path
  end
}


local audio_widget = wibox.widget {
    audio_icon,
    audio_text,
    layout = wibox.layout.fixed.horizontal,
}

local update_widget = function(widget, stdout, stderr, exitreason, exitcode)
    local audio_level = stdout
    widget:set_text(audio_level)
end,

watch(GET_audio_CMD, 1, update_widget, audio_text)

      audio_widget:buttons(awful.util.table.join(
      awful.button({ }, 1, function () mocp_info() end),
      awful.button({ }, 2, function () spawn.with_shell(PRV_VOLUME_CMD, false) end),
      awful.button({ }, 3, function () spawn.with_shell(NXT_VOLUME_CMD, false) end),
      awful.button({ }, 4, function () spawn.with_shell(INC_audio_CMD, false) end),
      awful.button({ }, 5, function () spawn.with_shell(DEC_audio_CMD, false) end)
      -- awful.button({ }, 5, spawn.with_shell(DEC_audio_CMD, false))

      ))

return audio_widget
