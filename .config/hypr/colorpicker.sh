#!/bin/sh

color="$(hyprpicker)"
wl-copy "$color"
notify-send "$color copied to clipboard"
