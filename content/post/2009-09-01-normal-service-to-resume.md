---
title:  "Normal service to resume"
date:   2009-09-01 12:00:00
categories: computer tech
---

While the hob is still laying outside in pieces, I am at least back up and running with my PC. Most importantly, with all my data still intact, just where I left it.

So what had happened? I'm still guessing as to the exact cause of the failure, but the problem was a blank partition table on the disk, and a corrupted MBR. Under a hexdump, the ascii in the boot loader looked really wrong, and more like a snippet of my Xorg start up log than lilo, but the real killer was the fact that where the partition table should have been was just a lot of zeros, meaning I couldn't mount any of the partitions to rerun lilo to fix the bootloader.

I ummed and arred a lot last night and this morning, but figured that I needed to investigate this problem more before I could go ahead with any sensible course of action.

The first stop, after failing to boot with slackware and slamd64 DVDs, was to fish up knoppix and start poking around for ideas. I couldn't get anything mounted, and knoppix mis-detected the whole disk. cfdisk couldn't see anything. fdisk couldn't see anything. So, it can't see any partitions ... let's have a look at the partition table:

    ~# hexdump -C /dev/sda | head -n 100 | less

Empty. Full of zeros. Unconcerned with the MBR (I know I can rebuild that with lilo), I've previously managed to rebuild a partition table by recreating the partitions with something like cfdisk. Only this time, I cannot for the life of me remember what the layout's supposed to be.

Next step is to see what information I can pull off disk diagnostics. My copy is a bit old now, but still, the Ultimate Boot CD contains a nice selection of hard disk utilities for Western Digital drives, including one called Data Lifeguard. In there was an option to show me what it thought was on the disk. 4 partitions, with some CHS (cylinder/head/sector) start and end points. If this had detected that information perfectly, then I could've used cfdisk to rebuild the table. But no way was my 200GB disk made up of four partitions that were 600,800,200 and 1000GB respectively.

Back to google for "partition recovery". Bunch of windows tools, a lot of expensive items, oh, and [TestDisk](http://www.cgsecurity.org/wiki/TestDisk).

After a couple of false starts (should run it as root), I got into the drive and low and behold! My partitions! My data! Whoah, some data I'd deleted ages back! It even came with a nice button which used the detected information to recreate the table for me.

Push the button, reboot with a slamd64 disk with my salvaged root, run lilo. Whew.

Another reboot. Lilo shows up, boots the kernel, but can't manage to mount one of the partitions and fails to initialise the swap space.

Just as I was about to go into meltdown again, I checked fstab vs cfdisk. Somehow during the recreation, sda3 and sda4 got swapped around. Update fstab, run the mounts and it's all good!

Finally, fsck my /home mount and startx to write this lengthy blog post.

Thank you TestDisk, I'm off to buy some more drives to raid in the server.

