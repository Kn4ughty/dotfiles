#!/usr/bin/env python3
'''
This program cycles through a list of keyboard brighness percentage values.
Created for if you only have a single brighness key on your keyboard

Change the states var if you want a differnt set of values You can change the
cycle order by chaging the sort_order var to be ±1

Based on an example script from the archwiki available here
[[https://wiki.archlinux.org/title/Keyboard_backlight]]

# How it works
Gets the keyboard backlight as an object.  Then goes through the list of states
to find the closest value to account for rounding the final percentage to an
int.

Then if the new value is going to wrap around, it then goes to the other side
of the array depending on the sort order variable

Then it converts the new percentage from the states array to an interger and
sets the brightness to that. Also logs a bunch of stuff.
- Modifed by Kn4ughty 15/8/2024 - '''

import dbus


states = [0, 25, 50, 75, 100]

# set to -1 to move down the array and vice versa
# Must be -1 or 1
sort_order = +1


def cycle_lights():
    bus = dbus.SystemBus()
    kbd_backlight_proxy = bus.get_object(
        'org.freedesktop.UPower', '/org/freedesktop/UPower/KbdBacklight')
    kbd_backlight = dbus.Interface(
        kbd_backlight_proxy, 'org.freedesktop.UPower.KbdBacklight')

    current = kbd_backlight.GetBrightness()
    maximum = kbd_backlight.GetMaxBrightness()
    percent = 100 * current / maximum

    # Find closest match
    dif = 10000
    index = 0
    for i in range(len(states)):
        d = abs(percent - states[i])
        if d < dif:
            dif = d
            index = i
    print(f"closest = {states[index]}")
    # Wrap around if at end of states in either direction
    if sort_order == 1:
        if index == len(states) - 1:
            print("wrapped around too high")
            index = 0
            next = states[index]
        else:
            next = states[index + sort_order]
    elif sort_order == -1:
        print("backward sort")
        if index == 0:
            index = len(states) - 1
            next = states[index]
        else:
            next = states[index + sort_order]
    else:
        Exception("Invalid sort")
        next = states[index]

    print(f"new index: {index}")

    print(f"real:    {percent}")

    # Convert percentage to numeric
    new = int(maximum * next / 100)
    print(f"new chosen val = {new}")
    print(f"max was {maximum}")
    print(f"next was {next}")
    kbd_backlight.SetBrightness(new)


if __name__ == '__main__':
    cycle_lights()
