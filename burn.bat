@echo OFF
rem burn.bat COM3
set com=%1
set "soc=gk7205v300"
set "adr=0x42000000"
python burn --chip %soc% --file=u-boot/u-boot-%soc%-universal.bin -p %com% --break && echo fatload mmc 0:1 %adr% %soc%.scr; source %adr% | plink -serial %com% -sercfg 115200,8,n,1,N
