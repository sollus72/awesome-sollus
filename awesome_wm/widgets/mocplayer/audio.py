#!/usr/bin/env python3

import os

"""


"""


def getVolume():
    memlist = []
    for i in os.popen("amixer -D pulse sget Master").read().split(" "):
        if i != "":
            memlist.append(i)
    volume_level = (memlist[-2])
    volume_level = int(volume_level[1:3])
    return volume_level


def getSound():
    memlist = []
    for i in os.popen("amixer -D pulse sget Master").read().split(" "):
        if i != "":
            memlist.append(i)
    sound_level = (memlist[-1])
    sound_level = (sound_level[1:3])
    return sound_level


volume_level = getVolume()
sound_level = getSound()
if sound_level == "of":
    volume_level = 0

print(volume_level)
