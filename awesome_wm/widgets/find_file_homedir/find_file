function find_file()
    awful.prompt.run {
        prompt       = '<b>Find Name: </b>',
        -- text         = 'default command',
        -- bg_cursor    = '#ff0000',
        bg_cursor    = '#FFFF00',   -- yellow
        -- To use the default rc.lua prompt:
        textbox      = mouse.screen.mypromptbox.widget,
        -- textbox      = atextbox,
        exe_callback = function(input)
            if not input or #input == 0 then return end
            naughty.notify{ text = 'The input was: '..input, timeout = 0, hover_timeout = 0.1 }

            local f1 = io.popen('cd  ${XDG_HOME:-$HOME} && find . -iname ' .. '"*' .. input .. '*"')
                
                words = {}
                for w in f1:lines() do
                  local ww = string.sub(w, 3)
                words[#words + 1] = ww
                end
                      
                      nets = {}
                      for i, c in pairs(words) do
                        nets[i] =
                          { c, function() awful.spawn.with_shell('xdg-open ${XDG_HOME:-$HOME}/' .. '"' .. c .. '"' ) end, find_icon }
                      end
                
                awful.menu({items = nets , 
                            theme = { font = 'Play 10', 
                                      width = 800, 
                                      height = 19,
                                      border_color = '#6F6F6F', border_width = 2,
                                      bg_normal = '#3F3F3F', bg_focus = '#6F6F6F' 
                                  }
                            }):toggle()

            end
                    }

end
