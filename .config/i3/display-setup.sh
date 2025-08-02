#!/bin/bash

xrandr \
  --output "DP-0" --mode 1920x1080 --rate 143 --primary --pos 0x0 --rotate normal \
  --output "DP-2" --mode 1920x1080 --rate 60 --pos 1920x0 --rotate right
