---
title: "Building a wireless printer server"
date: 07-07-2020
draft: true
---

# Version 1: RasPi

https://bugs.archlinux.org/task/47718
https://unix.stackexchange.com/questions/276736/cups-adding-printer-fails-with-unable-to-get-list-of-printer-drivers-success
https://bbs.archlinux.org/viewtopic.php?id=193591
https://raspberrypi.stackexchange.com/questions/40722/how-to-install-cups-driver-gutenprint
https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=99474

# Version 2: Mini9

Debian i386
https://cdimage.debian.org/debian-cd/current/i386/iso-dvd/

"Server" install with BalenaEtcher

Setup/install wifi (BCM4312)
https://wiki.debian.org/bcm43xx
(firmware-b43-installer)

Static IP configuration
https://wiki.debian.org/NetworkConfiguration

Disable lid suspend with:
https://wiki.debian.org/Suspend

Turn off monitor, full stop, with:
https://askubuntu.com/questions/62858/turn-off-monitor-using-command-line

Install cups, make sure everything is enabled for remote work
https://www.cups.org/doc/sharing.html

Setup configure printers, and print some shizz.
Yay test prints.

Configuration on Mac was trivial. Add new printer ... Bonjour found them immediately. Done.