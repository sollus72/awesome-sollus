-- Finding a file in your home directory
-- Dependencies:
-- xdg-utils (for xdg-open)
-- perl-file-mimeinfo
-- font - ttf-play (AUR) or use another

# Binding a hotkey to a function find_file()
# section globalkeys

globalkeys = gears.table.join(
...
awful.key({ modkey, }, "f", function () find_file() end,
          {description = "find file in homedir", group = "mykeys"}),
...
)
