#!/usr/bin/env bash
set -e

# lightnux by @k01e
# https://github.com/k01e-01/lightnux
# copyright (c) 2024 k01e.alm07@gmail.com
# under MIT license :3

input_devices="$1"    # "/dev/input/event0:/dev/input/event1"
output_device="$2"    # "kbd_backlight"
max_brightness="$3"   # "100%"
timeout="$4"          # "30"

if [ $# -eq 0 ] || [ "$1" = "--help" ]; then
  echo "usage: $0 [options] (params)"
  echo "needs to be run as root to access input devices due to the security "
  echo "risk of unpriveleged users accessing raw keyboard input (passwords, eek!)"
  echo ""
  echo "options:"
  echo "  --help : you're looking at it!"
  echo ""
  echo "params:"
  echo "  input_devices   : colon seperated list of devices (under /dev/input)"
  echo "  output_device   : an output device, check brightnessctl --list for a list of them"
  echo "  max_brightness  : a max brightness between '0%' and '100%'"
  echo "  timeout         : the number of seconds before the the backlight fades out"
  echo ""
  echo "examples:"
  echo "  $0 --help"
  echo "  sudo $0 /dev/input/event0:/dev/input/event1 kbd_backlight 100% 30"
  exit 0
fi

if [ $EUID -ne 0 ]; then
  echo "needs to run as root to access input devices, see $0 --help, sorryyyy :/"
  exit 1
fi

graceful_exit() {
  pkill -P "$$" || :
  exit 0
}

trap graceful_exit SIGINT

start_timeout() {
  sleep 0.05
  brightnessctl set -d $output_device $max_brightness
  sleep $timeout
  while [ $(brightnessctl get -d $output_device) -ne "0" ]; do
    brightnessctl set -d $output_device 1-
  done
}

evtests() {
  for device in "${dev_list[@]}"; do
    evtest "$device" &
  done
}

evtests | while read line; do
  kill "$lastpid" 2>/dev/null || :
  start_timeout >/dev/null &
  lastpid=$!
done

