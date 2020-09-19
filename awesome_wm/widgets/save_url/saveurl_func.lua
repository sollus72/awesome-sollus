--[[
-- globalkeys = gears.table.join(
-- ...
      awful.key({ modkey,           }, "i", saveUrl,
              {description = "Save URL", group = "mykeys"}),
-- ...
                             -- )
--]]

function saveUrl()

    -- io.popen("mkdir -p ${XDG_HOME:-$HOME}/Onedrive/Downloads/URL")
        local get_buffer = io.popen('xclip -o')

        local save_url_table = { "[InternetShortcut]", "URL=", }

                for w in get_buffer:lines() do
                    save_url_table[#save_url_table + 1] = w
                end

    awful.prompt.run {
        prompt       = '<b>Name URL: </b>',
        bg_cursor    = '#FFFF00',   -- yellow
        textbox      = mouse.screen.mypromptbox.widget,
        exe_callback = function(input)
            if not input or #input == 0 then return end
            naughty.notify{ text = 'URL saves as: ' .. '\n' .. 'Onedrive/Downloads/URL' .. '\n' ..input, timeout = 0, hover_timeout = 0.1 }
        
        -- directory where the file-url is written
        -- user = sollus
        local file = io.open('/home/sollus/OneDrive/Downloads/URL/' .. '' .. input .. '' .. '.url' , "w")

             file:write( save_url_table[1] .. '\n' )
             file:write( save_url_table[2] .. save_url_table[3] .. '\n' )

               io.close( file )
            end
                    }
end
