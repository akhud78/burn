# Notes

## Usage
### Set up your SD card

- Format the entire disk as FAT32.
- Copy the files to your SD Card:
    - `gk7205v300.scr`
    - `u-boot-gk7205v300-universal.bin`
    - `uImage.gk7205v300`
    - `rootfs.squashfs.gk7205v300`
- If necessary, сonvert the `gk7205v300.cmd` to `gk7205v300.scr` using `mkimage`:
```
$ sudo apt install u-boot-tools
$ mkimage -C none -A arm -T script -d gk7205v300.cmd gk7205v300.scr
```

### Burn
- Сonnect an Ethernet cable.
- Disconnect power from the device.
```
$ ./burn --chip gk7205v300 --file=u-boot/u-boot-gk7205v300-universal.bin --break; sleep 1; \
  echo 'fatload mmc 0:1 $baseaddr gk7205v300.scr;source $baseaddr' > /dev/ttyUSB0; screen -L /dev/ttyUSB0 115200
Trying open /dev/ttyUSB0
```
- Connect the power.
```
...
Welcome to OpenIPC
openipc-gk7205v300 login: root
Password: 12345


   .d88888b.                             8888888 8888888b.   .d8888b.
  d88P" "Y88b                              888   888   Y88b d88P  Y88b
  888     888                              888   888    888 888    888
  888     888 88888b.   .d88b.  88888b.    888   888   d88P 888
  888     888 888 "88b d8P  Y8b 888 "88b   888   8888888P"  888
  888     888 888  888 88888888 888  888   888   888        888    888
  Y88b. .d88P 888 d88P Y8b.     888  888   888   888        Y88b  d88P
   "Y88888P"  88888P"   "Y8888  888  888 8888888 888         "Y8888P"
              888
              888
              888                            local+build, 2024-06-21

 Please help the OpenIPC Project to cover the cost of development and
 long-term maintenance of what we believe is going to become a stable,
 flexible Open IP Network Camera Framework for users worldwide.

 Your contributions could help us to advance the development and keep
 you updated on improvements and new features more regularly.

 Please visit https://openipc.org/sponsor/ to learn more. Thank you.

root@openipc-gk7205v300:~# firstboot
...
Starting ntpd: OK
Starting dropbear: OK
Starting crond: OK
Loading vendor modules...
mmz_start: 0x42000000, mmz_size: 32M
goke: SENSOR: imx335
insert audio
Starting majestic: OK

Welcome to OpenIPC
openipc-gk7205v300 login:
```

### Set up Wi-Fi

- Open [http://192.168.1.10/cgi-bin/fw-network.cgi](http://192.168.1.10/cgi-bin/fw-network.cgi)
- Select `wlan0` from the pull-down menu in the `Network interface` field.
- Set up `WLAN SSID` and `WLAN Password` and press `Save Changes`.

![setup_wifi](setup_wifi.jpg)

- Open [http://192.168.1.10/cgi-bin/fw-settings.cgi](http://192.168.1.10/cgi-bin/fw-settings.cgi) and press `Restart Camera`.