# Notes

## Set up your SD card

- Download zipped repository from [burn](https://github.com/akhud78/burn) project.
    - Above the list of files, click  **Code**.
    - Click  **Download ZIP**
- Format the entire disk as FAT32.
- Copy the files from [u-boot](https://github.com/akhud78/burn/tree/master/u-boot) directory to your SD Card:
    - `gk7205v300.scr`
    - `u-boot-gk7205v300-universal.bin`
    - `uImage.gk7205v300`
    - `rootfs.squashfs.gk7205v300`

## Burn
- Disconnect power from the device.
- Сonnect an Ethernet cable.
- Insert the SD card in the memory card slot.
- Connect device UART with PCB clip (1-TX, 2-GND, 3-RX).

![yucheng_2](yucheng_2.jpg)


### Linux
```
$ cd burn/
$ SOC=gk7205v300 DEV='/dev/ttyUSB0'
$ ./burn --chip $SOC --file=u-boot/u-boot-$SOC-universal.bin --break; sleep 1; \
  echo 'fatload mmc 0:1 $baseaddr' "$SOC.scr;" 'source $baseaddr' > $DEV; \
  screen -L $DEV 115200

Trying open /dev/ttyUSB0
```
### Windows

For reference, you can see [Notes on installing OpenIPC using Burn](https://github.com/OpenIPC/wiki/blob/master/en/burn-example.md) for Windows.

- Install [Python for Windows](https://www.python.org/downloads/windows/)
- Install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
- Open a command shell
    - Click `Start > Run` or press `Windows + R` key.
    - Type `cmd` and click `OK`.
```
> cd burn
> burn.bat COM3

Trying open COM3
```


### Run
- Connect the power 🔌
```
Welcome to boot-mode

{'name': 'hi3516ev200', 'DDRSTEP0': [4, 224, ...
Sending u-boot/u-boot-gk7205v300-universal.bin ...
Send DDRSTEP frame...
Send HEAD frame...
Send TAIL frame...
Send HEAD frame...
Send DATA frame[================================================]24576 of 24576
Send TAIL frame...
Send HEAD frame...
Send DATA frame[==============================================]258375 of 258375
Send TAIL frame...
Done

Sending Ctrl-C

Exiting...
fatload mmc 0:1 0x42000000 gk7205v300.scr; source 0x42000000
1079 bytes read in 2 ms (526.4 KiB/s)
## Executing script at 42000000
--- Reset default environment ---
## Resetting to default environment
--- Flash bootloader ---
unlock all block.
Erasing at 0x50000 -- 100% complete.
SF: 327680 bytes @ 0x0 Erased: OK
258375 bytes read in 12 ms (20.5 MiB/s)
device 0 offset 0x0, size 0x3f147
Writing at 0x3f147 -- 100% complete.
SF: 258375 bytes @ 0x0 Written: OK
--- Flash kernel ---
Erasing at 0x350000 -- 100% complete.
SF: 3145728 bytes @ 0x50000 Erased: OK
1860137 bytes read in 80 ms (22.2 MiB/s)
device 0 offset 0x50000, size 0x1c6229
Writing at 0x216229 -- 100% complete.
SF: 1860137 bytes @ 0x50000 Written: OK
--- Flash root filesystem ---
Erasing at 0xd50000 -- 100% complete.
SF: 10485760 bytes @ 0x350000 Erased: OK
6434816 bytes read in 270 ms (22.7 MiB/s)
device 0 offset 0x350000, size 0x623000
Writing at 0x973000 -- 100% complete.
SF: 6434816 bytes @ 0x350000 Written: OK
--- Reset camera settings ---
Erasing at 0x1000000 -- 100% complete.
SF: 2818048 bytes @ 0xd50000 Erased: OK
--- setnor16m ---
--- fix bootargs ---
Saving Environment to SPI Flash...
Erasing SPI flash...Writing to SPI flash...done
resetting ...

System startup

Uncompress Ok!

U-Boot 2016.11-g852b5be (Jan 22 2024 - 21:08:32 +0300)gk7205v300

Relocation Offset is: 0772c000
Relocating to 47f2c000, new gd at 47eebef0, sp at 47eebed0
SPI Nor:  Check Flash Memory Controller v100 ... Found
SPI Nor ID Table Version 1.0
SPI Nor(cs 0) ID: 0xc8 0x40 0x18
Block:64KB Chip:16MB Name:"GD25Q128/GD25Q127"
SPI Nor total size: 16MB
NAND:  0 MiB
MMC:   sdhci: 0 (SD)
In:    serial
Out:   serial
Err:   serial
RAM size: 128MB
Net:   eth0
Warning: eth0 (eth0) using random MAC address - 5a:12:64:2a:ea:7b

Press Ctrl-c to stop autoboot... 2
device 0 offset 0x50000, size 0x300000

SF: 3145728 bytes @ 0x50000 Read: OK
## Booting kernel from Legacy Image at 42000000 ...
   Image Name:   Linux-4.9.37-gk7205v300
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1860073 Bytes = 1.8 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Loading Kernel Image ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
...
...
Starting ntpd: OK
Starting dropbear: OK
Starting crond: OK
Loading vendor modules...
mmz_start: 0x42000000, mmz_size: 32M
rmmod: can't unload module 'gk7205v200_isp': No such file or directory
rmmod: can't unload module 'gk7205v200_base': Resource temporarily unavailable
goke: Get data from ipcinfo and set SENSOR as imx335
goke: Writing imx335 to U-Boot ENV
insmod: can't insert 'gk7205v200_base.ko': File exists
insert audio
Starting majestic: OK

Welcome to OpenIPC
openipc-gk7205v300 login:
```
- Press `Ctrl-C`to exit.
```
Завершить выполнение пакетного файла [Y(да)/N(нет)]? Y
```

## Set up Wi-Fi
- Open [http://root:12345@192.168.1.10/cgi-bin/tool-console.cgi](http://root:12345@192.168.1.10/cgi-bin/tool-console.cgi)
    - Enter command: `firstboot` and press `Run`.
- Open [http://192.168.1.10/cgi-bin/fw-network.cgi](http://192.168.1.10/cgi-bin/fw-network.cgi)
    - Select `wlan0` from the pull-down menu in the `Network interface` field.
    - Set up `WLAN SSID` and `WLAN Password` and press `Save Changes`.

![setup_wifi](setup_wifi.jpg)

- Open [http://192.168.1.10/cgi-bin/fw-settings.cgi](http://192.168.1.10/cgi-bin/fw-settings.cgi) and press `Restart Camera`.
