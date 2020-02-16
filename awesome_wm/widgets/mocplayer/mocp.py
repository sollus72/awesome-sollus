#!/usr/bin/env python3

import os

# State: PAUSE
# State: PLAY
# State: STOP
# FATAL_ERROR: The server is not running!
# Count = 1 - include
# Count = 0 - No present

s_stop = 'STOP'
s_play = 'PLAY'
s_pause = 'PAUSE'
s_error = 'ERROR'

s = os.popen("mocp -i").read()
if s.count(s_stop) == 1:
    print(s_stop)
elif s.count(s_play) == 1:
    print(s_play)
elif s.count(s_pause) == 1:
    print(s_pause)
else:
    print(s_error)
