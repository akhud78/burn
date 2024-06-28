echo --- Flash bootloader ---
mw.b ${baseaddr} 0xff 0x50000
sf probe 0; sf lock 0; sf erase 0x0 0x50000
fatload mmc 0:1 ${baseaddr} u-boot-gk7205v300-universal.bin
sf write ${baseaddr} 0x0 ${filesize}

echo --- Flash kernel --- 
mw.b ${baseaddr} 0xff 0x1000000
sf probe 0; sf erase 0x50000 0x300000
fatload mmc 0:1 ${baseaddr} uImage.${soc}
sf write ${baseaddr} 0x50000 ${filesize}

echo --- Flash root filesystem ---
mw.b ${baseaddr} 0xff 0x1000000
sf probe 0; sf erase 0x350000 0xa00000
fatload mmc 0:1 ${baseaddr} rootfs.squashfs.${soc}
sf write ${baseaddr} 0x350000 ${filesize}

echo --- Reset camera settings ---
sf probe 0; sf erase 0xd50000 0x2b0000

echo --- Reset default environment ---
env default -a

echo --- setnor16m ---
run mtdpartsnor16m; setenv bootcmd ${bootcmdnor};

echo --- fix bootargs ---
setenv bootargs 'mem=128M console=ttyAMA0,115200 panic=20 rootfstype=squashfs root=/dev/mtdblock3 init=/init mtdparts=${mtdparts} mmz_allocator=cma mmz=anonymous,0,0x42000000,96M'
saveenv
reset
