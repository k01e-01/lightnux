# lightnux

a flexible keyboard and monitor backlight auto-dimmer for linux

## installation

at the moment, lightnux is not avaliable on any package managers, but i may put it on the aur eventually

simply clone the repo, and run makepkg -si

```bash
git clone https://github.com/k01e-01/lightnux.git && cd lightnux
makepkg -si
```

once its installed, you can configure your desktop environment to automatically start it in the background, please see your de's docs for how to do this

if your de does not run its config file as root, like in swaywm, you may need to create a systemd service, here's a simple example of how you could do this

```
# /etc/systemd/system/lightnux.service

[Unit]
Description=lightnux service
After=multi-user.target

[Service]
ExecStart=/usr/bin/lightnux /dev/input/event0:/dev/input/event1 kbd_backlight 100% 30
User=root
Type=simple
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

## usage

lightnux needs to be run as root to access input devices due to the security risk of unpriveledged users accessing raw keyboard input (passwords, eek!)

```bash
lightnux [options] (params)
```

### options

- `--help`: usage information (you're reading it :D)

### parameters

1. `input_devices`: colon separated list of input devices (under /dev/input)
2. `output_device`: output device for controlling the backlight (use `brightnessctl --list` for a list of available devices)
3. `max_brightness`: maximum brightness level specified as a percentage (e.g. "100%")
4. `timeout`: timeout in seconds before the backlight fades out

### examples

```
lightnux --help
sudo lightnux /dev/input/event0:/dev/input/event1 kbd_backlight 100% 30
```

