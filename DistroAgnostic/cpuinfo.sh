#!/bin/bash

echo Enter an option from the following:
echo 1: lshw CPU Info
echo 2: lshw Memory Info
echo 3: /proc/cpuinfo
echo 4: /proc/meminfo
echo 5: dmidecode mobo info
echo

read option

if { $option -eq 1 }
then sudo lshw -C cpu | less
elif { $option -eq 2 }
then sudo lshw -C memory | less
elif { $option -eq 3 }
then less /proc/cpuinfo
elif { $option -eq 4 }
then less /proc/meminfo
elif { $option -eq 5 }
then  sudo dmidecode | less
else echo Invalid option

exit
