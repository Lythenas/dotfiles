#!/bin/bash

xrandr --output eDP1 --primary \
	--output DP1 --pos 0x0 --above eDP1 --auto \
	--output HDMI1 --pos 0x0 --above eDP1 --auto \
	--output DP2 --pos 0x0 --above eDP1 --auto \
	--output HDMI2 --pos 0x0 --above eDP1 --auto
