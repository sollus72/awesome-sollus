--[[Finding a file in your home directory
Dependencies:
xdg-utils (for xdg-open)
perl-file-mimeinfo
font - ttf-play (AUR) or use another
--]]
function find_file()
    awful.prompt.run {
        prompt       = '<b>Find Name: </b>',
        bg_cursor    = '#FFFF00',   -- yellow
        textbox      = mouse.screen.mypromptbox.widget,
        exe_callback = function(input)
            if not input or #input == 0 then return end
                naughty.notify{ text = 'Find Name: '..input, timeout = 0, hover_timeout = 0.1 }

                local f1 = io.popen('cd  ${XDG_HOME:-$HOME} && find . -iname ' .. '"*' .. input .. '*"')
                
                    local words = {}
                    for w in f1:lines() do
                      local ww = string.sub(w, 3)
                    words[#words + 1] = ww
                    end
                      
                      local nets = {}
                      for i, c in pairs(words) do
                        nets[i] =
                          { c, function() awful.spawn.with_shell('xdg-open ${XDG_HOME:-$HOME}/' .. '"' .. c .. '"' ) end, find_icon }
                      end
                
                awful.menu({items = nets , 
                        theme = { font = 'Play 10', 
                                  width = 1400, 
                                  height = 19,
                                  border_color = '#6F6F6F', border_width = 2,
                                  bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' 
                              }
                        }):toggle()

            end
                    }

end
