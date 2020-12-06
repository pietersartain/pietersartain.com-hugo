---
title: "Personal virtual computing pt 2: the design"
date: 2020-08-05 12:00:00
categories:
  - "Computing"
tags:
---

_This is a series about my journey in building a multipurpose PC using virtualisation technology and RGB strips. This is part 2, which is about some of the research and design choices I made. If you want some self-indulgent history, try [part 1]({{< relref "2020-08-05-personal-virtual-computing.md" >}}), if you want to read about the construction, start at [part 3]({{< relref "2020-08-27-personal-virtual-computing-iii.md" >}})._

I'm trying to accomplish two things with one machine:

 * A recording / 3D design / gaming rig. This is "upgrade my laptop".
 * Part-NAS for longer term storage of data, digital assets and backups. This is "replace my USB backup drive".

So in my mind this takes the form of a "gaming NAS" ala [LTT's Gaming NAS](https://www.youtube.com/watch?v=dpXhSrhmUXo) also linked off of [part 1]({{< relref "2020-08-05-personal-virtual-computing.md" >}}) of this discussion. Fair warning, I'm going to capture some of the thoughts I had on each of these sections, but this wasn't a linear research process for me. I had half an idea, and read up a lot before consolidating that idea. I'll talk more about the pros and cons of that process at the end.

Let's get going with some idea of what we're aiming at ...

# Build goals

 * Access to a "native" Windows VM for gaming and probably recording and 3D design work.
 * Able to run VMs and Docker containers for NAS-type services.
 * Able to act as a backup server for my laptop.
 * Should be aesthetically pleasing, and not a rehash of things I've done in the past (no more black boxen!).

Some things I don't care about much:

 * Sharing with the internet.
 * Sharing with my wife.
 * Connecting to a TV downstairs.

It's a very personal build, for fixed emplacement in my office, and although I care deeply for my wife in many ways, when it comes to computers and storage and such, over the years we've found she rarely uses anything I offer without me anyway. So no need to concern myself with a multi-user NAS. She's got her own backup setup and keeps most of her important things off site.

# Hardware design

Hardware/software co-design is an art unto itself. Although I'm not doing that here (I'm not making ASICs and code), the resultant usable rig will be impacted by choices I make in both hardware and software. Because I had only a vague notion of what I was doing on the software side, I needed to pin some things down to work through the research on the software, so I decided to start with the hardware.

## Form factor

I entertained the notion of going full server rig, putting my PC in the garage and dragging cables around the house (again inspired by Linus Tech Tips). I thought about building multiple boxes for the different purposes envisioned. In the end I settled on aiming for a small to mid, quiet box. I had a niggle I needed two graphics cards, which meant two PCIe 16x-sized slots, so this was going to end up full ATX form factor.

I watched a lot of YouTube, especially [Gamer's Nexus](https://www.youtube.com/channel/UChIs72whgZI9w6d6FhwGGHA), looking at cases and lots of airflow and volume graphs. I went back and forth on the Lian-Li 011-Dynamic and the Be!Quiet Pure Base 500DX, eventually settling on the 011D and then changing my mind at the very last minute just as I was putting the shopping list together.

Both white and black PB500DX look great, but I was actually really taken with Be!Quiet's [beauty shot of the white 500DX](https://www.bequiet.com/admin/ImageServer.php?ID=faafca30289@be-quiet.net&omitPreview=true&.jpg) which is totally my white and orange colour scheme. I figured why not lean into that.

## Processing

If I want to run many things, I'd like to have many places to run things. This rig isn't going to be optimised for gaming. Reviewing the price/core ratio of CPUs (and hearing the interwebs talk about it a lot), The 12-core Ryzen 9 3900X came out really well. The 3950X would've netted me 4 more cores (8 more threads) but at a 30% increase in price/core over 3900X.

I figured 32GB memory for two VMs at least, but 64 would be better. 128 would probably be overkill.

In order to make some of the virtualisation work the motherboard needs to support some ... things ... ? At time of writing I know much more about this, but at time of research, I knew it was going to be an ATX, probably "enthusiast grade", motherboard. This wasn't a very interesting decision to me, although I feel like I got a little lucky with some guides that confirmed my decision. In the end the right motherboard was key to making the virtualisation all work.

Graphics card. Ugh. So many model numbers. After some poking around it looked like the nVidia 2060 Super was pretty good value for an amazing GPU, although I'm sure the 3000 series would be better, but I wanted a PC now. Not in 4 months' time. All the reading I'd done suggested I might need two graphics cards, one for the host, and one for the VM, so I was a bit concerned that I needed two of the same cards.

The more I thought about it, though, the less sensible that got. Even if I have multiple desktop VMs, I'm probably only running one at a time, so I need one decent graphics card and a question-mark over a second one.

Something that might be important to me (much) later is [ensuring this is VR-ready](https://www.techradar.com/how-to/computing/how-to-build-a-pc-ready-for-virtual-reality-1312449), so I wanted to bear it mind, without it dominating this part of the research. 2060 Super seemed to be okay with VR.

## Cooling

This is an area where I was super excited to play in. I'd never done watercooling, and all these fans had fancy lights on now, so that's exciting!

Watercooling was fun, but started looking a lot like hassle and playing-for-playing's sake, rather than actually moving the project forward. I looked hard at the all-in-one pre-filled block/radiator/pump combos (referred to as AIOs), which were kinda cool, but weren't significantly better performance-wise and were significantly worse price-wise.

I didn't feel I was getting great value out of watercooling or AIOs, and also, figured this was an area I could upgrade later if I decided that was really important to me.

I settled on air cooling. This decision helped refine the case decision above, too.

## Storage

Enough space for some local disk redundancy, to feel comfortable that my "long term storage" isn't just going to disappear into the ether.

I can't really figure this out until I know what I'm putting on this box, so this is one that's going to be deferred into the software section below.

## Monitor

Just as I was assembling the shopping list, I saw the [Samsung G7 27"](https://www.youtube.com/watch?v=d7ai4u8KrQs) reviews show up and very nearly just put the preorder down. The thing that stopped me was the curvature. It's a tight curve, and where I wanted a large flat surface for Reaper or programming, I was worried that curve was going to cause me problems.

It probably would've been fine.

When I sat and thought about what was important to me, it was really about crispness and display quality. This turned out to be something like a 4K/UHD monitor with dual input. PIP would be nice, but maintaining the pixel density of the MBP's Retina Display as much I can was more important to me.

I did a lot of figuring out what that meant from a pixel point of view (yes, I have spreadsheets), and learned that the "PPI" in "220 PPI" is the number of pixels in an inch line, not the numbers of pixels per square inch, like I originally thought. Consequently, 28" 4K/UHD monitors will end up with a 158 PPI.

I was limited by the physical space the monitor was to reside in. The space was enough to accomodate a 27" 16x9 monitor, so my PPI is slightly higher than 158, but nowhere near the 220. Even 28" 5k monitors are still only 210 PPI. Although, at this distance, it looks great.

## Aesthetic choices

I want enough RGB to glow orange. Beyond that, actually, it's not important to me. The case should look good, the cables should be managed. All of this is largely part of the build. As long as I get some decent enough looking parts, this should just happen ... which is nice!

# Software design

With a fair handle on the shape of the hardware, next I needed to figure out some idea about what I was doing from a software perspective. I mean, I could just buy the hardware and hope for the best, but I wanted to make sure I hadn't got any obvious incompatibilities in form factor or component choices.

## Baremetal OS / hypervisor

The LTT crew built their gaming NAS and virtualised systems around [Unraid](https://unraid.net), which is a NAS OS. In addition to Unraid, I found some alternatives for virtualisation:

1.  FreeNAS, which uses [bhyve](https://bhyve.org/).
2.  Virtualisation on a newer Linux distro (Fedora seemed the popular choice)
3.  VMWare's ESXi with free license (plus [some restrictions](https://www.altaro.com/vmware/esxi-free/))
4.  [Proxmox](https://proxmox.com/), which the [Homelab Reddit](https://www.reddit.com/r/homelab/) crowd seem to enjoy.

Sidenote: it's so interesting to find a whole group of people who are into home servers and typical "sysadmin" type duties but for home. I hope they accept me into their tribe, because previously I'd never had a name for this thing!

My choice in the end was fairly arbitrary. There seemed to be plenty of people doing what I was trying to do with both Proxmox and Fedora, but Proxmox was meant to do what I was trying, so I based further investigations off using Proxmox.

## Filesystems

I know I want some redundancy for storage, but I don't really want to build an mdraid system. And I _really_ don't want to build a 4+ disk array. I have to compromise based on case size.

What else?

I know that using the motherboard RAID chip is a single point of failure and if it blows up or otherwise needs to be migrated, I've probably lost that data, so that's out.

Strictly speaking the filesystem is a software problem, but it has an impact on the hardware decisions I'm making, so I need to get at least a cursory handle on how they're related.

I'd seen a [couple](https://arstechnica.com/information-technology/2014/02/ars-walkthrough-using-the-zfs-next-gen-filesystem-on-linux/2/) of [articles](https://arstechnica.com/information-technology/2020/05/zfs-101-understanding-zfs-storage-and-performance/) about ZFS on Ars Technica, and that was enough to start reading around on what it does. I was rather taken with the idea of a filesystem that's a bit more proactive with looking after my data, and one that seemed to crop up a lot in the NAS and hypervisor spaces.

Doing some reading around on copy-on-write filesystems, [BTRFS showed up](https://www.reddit.com/r/linuxquestions/comments/f890e4/should_i_use_btrfs_or_zfs_in_2020/) as a competitor to ZFS. Having used BTRFS in the past professionally, I remember it had some [pretty cool features](https://markmcb.com/2020/01/07/five-years-of-btrfs/), but it's "just another filesystem" and so would need to be backed by mdraid if I wanted to do something with mirrors or parity.

Both [filesystems had their proponents](https://forum.proxmox.com/threads/proxmox-with-zfs-or-btrfs.50962/), but after a cursory read around, it seemed like there were enough resources out there to proceed. With BTRFS having just been removed from OpenSuSE, I'm less confident in BTRFS' future. Additionally, I've seen plenty of usecases with ZFS supporting [VMs on Proxmox](https://pve.proxmox.com/wiki/Storage) and it's the default on FreeNAS so to stop me going 'round and 'round in circles, I'm making the assumption I'm using ZFS, and I can figure out the [exact tuning](https://martin.heiland.io/2018/02/23/zfs-tuning/) required later.

So, what physical disk configuration do I need for:

 * High performance VMs (maybe 2 running at once, at most)
 * Docker containers' non-volatile storage
 * "raw" file storage (to replace my 4TB drive)

Breaking it down a bit more into :

 * Proxmox OS
   - After initial boot, unlikely to do much, so speed may not be super critical.
 * Windows OS disk
   - Initial boot critical, so fast is necessary.
 * Linux VM OS disks
    - Initial boot pretty critical, so fast is nice.
 * Video (music/photo) storage
   - Streaming, slow media is fine.
 * "Documents" storage
   - Recording projects are fairly small
   - F360 projects could be larger
   - Faster storage would be better, but non-essential

This was the point that I could finally see that I really didn't need to overthink this one. Remember, at this point I'm still trying to decide what hardware to buy. I can always change my mind later.

Net outcome is aiming for a 2TB mirrored SSD for VMs and fast access, and an 8TB mirrored HDD for raw storage.

## Service planning

We're getting close. I've got some hardware, I now have a bit more of a picture of the machine setup. Question is can I run all the things I want to run in a sane way. This is a very quick feasibility study rather than a deep dive.

### Backup
I pay $60/year to back up the Mac to Backblaze. I could stump up another $60/year for the Windows machine (although maybe that should be sacrificial and store no permanent data?), and probably again ~$50 for the NAS part if I wanted to go all out.

What I can't do, unfortunately, is use one Backblaze subscription to [backup from Linux](https://help.backblaze.com/hc/en-us/articles/217664628-Is-Backblaze-going-to-offer-Linux-support-) using the "unlimited plan". I'd have to pay for the storage differently, using B2. I may do this anyway.

To back up the Mac to this system, Netatalk (Linux's AFP implementation) can be used for time machine backups, and [exists as a Docker container](https://hub.docker.com/r/servercontainers/netatalk).

### Synchronisation
[Resilio Sync also exists as Docker container](https://hub.docker.com/r/resilio/sync).

There is an open question over what exactly needs to sync with what. I use this currently to synchronise music, books, audiobooks and comics between my laptop, phone and tablet. In my mind I can continue doing this, but also could keep some data synchronised between laptop and desktop.

### Media server
[Plex exists as a Docker container](https://hub.docker.com/r/plexinc/pms-docker). Cool!

### NAS server
[Samba exists as a Docker container](https://hub.docker.com/r/servercontainers/samba). I did not see that coming, actually.

Something that's going to need more attention is that [Resilio Sync and SMB shares don't necessarily play together well](https://help.resilio.com/hc/en-us/articles/207755736-Sync-and-SMB-file-share).

That said, if I've got everything configured via Sync Pro (eg my own internal Dropbox), and I've got Plex running to serve outside things, what am I using SMB for exactly?

How does Resilio Sync play with the multiple virtual machine setup I'm envisioning?

# Lessons in research

The 2300-odd words above represents the better part of 6 weeks of poking at the internet, reading articles and making lists of keywords to look up later, all with the goal of trying to convert a vague vision and feeling into a concrete list of components to go out and buy. And I still didn't manage that! I had some ideas of components, but very few actual SKUs to reach for.

With previous PC builds I've done, the process has been: 1. put the components together, 2. install the OS, 3. enjoy my new PC.

The design of this system, although it ended up looking just "enthusiast spec", was significantly more challenging. I didn't know much about building systems based on hypervisors. I had no idea how core component choices would practically impact the final result of what I was building.

While articles like [this](https://heiko-sieger.info/creating-a-windows-10-vm-on-the-amd-ryzen-9-3900x-using-qemu-4-0-and-vga-passthrough/) gave me a lot of confidence that the principal of what I was doing (Windows 10 passthrough under Linux) was sound, no article could help me with the disk choices. As can be seen by the word count, I found that by far the stickiest part of the whole problem. It got a lot easier once I spelled out the workloads, mind you.

There is an argument to be made that I spent too long doing the research. Writing this up and looking back on the process, I think it ended up taking longer than it needed to because partly I wasn't fully committed to buying a new PC yet. I abstractly liked the idea of it, but wasn't convinced yet I _needed_ it. Going to leave that thought there, because I want to come back to it in the conclusion to this series.

The other reason it may have taken longer was because it was just fun to do the research. Reading around, learning about things, putting just enough of it into my head to gain some confidence in the direction of travel, and refining the project and idea was just *fun*!

That was the thing that gave me enough of a push to proceed. I enjoyed working through the spec'ing of a PC, and I was excited to actually build it and see how it worked.

So let's do that. Now it's time to actually get the components and see if practice matches theory. More spoilers: it doesn't.

_[Part 3]({{< relref "2020-08-20-personal-virtual-computing-iii.md" >}}) is  about deciding exactly what parts, buying them, putting them together and getting something working._