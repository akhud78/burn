# Notes

## Usage
### Burn
```
$ ./burn --chip gk7205v300 --file=u-boot/u-boot-gk7205v300-universal.bin --break; sleep 1; \
  echo 'fatload mmc 0:1 $baseaddr gk7205v300.scr;source $baseaddr' > /dev/ttyUSB0; screen -L /dev/ttyUSB0 115200 
...
In:    serial
Out:   serial
Err:   serial
RAM size: 128MB
Net:   eth0
Warning: eth0 (eth0) using random MAC address - 32:10:e6:cc:24:69

Press Ctrl-c to stop autoboot... 2
OpenIPC # <INTERRUPT>
OpenIPC # <INTERRUPT>
OpenIPC # <INTERRUPT>

```
- Firstboot
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

```
- Reset u-boot default environment
```
root@openipc-gk7205v300:~# reboot 
...
Press Ctrl-c to stop autoboot... 2
OpenIPC # <INTERRUPT>
...
# env default -a; saveenv; reset
...
Press Ctrl-c to stop autoboot... 2
OpenIPC # <INTERRUPT>
# run setnor16m
...
root@openipc-gk7205v300:~# firstboot
```
- Check memory
```
# free
              total        used        free      shared  buff/cache   available
Mem:         124508       56484       53816          92       14208       65356
```


### Setup Wi-Fi

![setup_wifi](setup_wifi.jpg)