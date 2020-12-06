---
title: "Personal virtual computing pt 1: the beginning"
date: 2020-08-05 12:00:00
categories:
  - "Computing"
---

_This is a series about my journey in building a multipurpose PC using virtualisation technology and RGB strips. This is part 1, which is mostly made of self-indulgent history. If you just care about the hardware and tech, [start at part 2]({{< relref "2020-08-15-personal-virtual-computing-ii.md" >}})._

5 years ago I upgraded to a brand new Mac Book Pro, and it's done me proud. However, between development on [Android apps](https://github.com/pietersartain/shiori-android-app), [doing more with my music]({{< relref "2020-06-25-remote-music-making.md" >}}) and some experimentation with 3D modelling, I'm starting to ask just a bit too much of the poor thing.

So, it's time for a hardware upgrade. I could do the same again, jump up to a 2020 MBP, but I'd really like access to a Windows machine. Actually, a Linux box would be really handy too.

Before we get into why I want to take a small step out of OSX-land; it's story time.

# My history with operating systems

I built my first computer around 1999 - 2000 with money I earned from working in the IT department of a boarding school over the summer holidays. I look back on that job extremely fondly, not just because of the finances, but because of the opportunity to take this "computer hobby" and see how it felt to do something in that arena as a living.

It felt good.

This was Windows 98-era, and while I didn't love 98, it ran fine and got me off to the races when I bought my own hardware. I went to university soon after, and a new friend was kind enough to help me out with a copy of Windows 2000. Much more stable than 98, but I seem to recall had some quirks with some programs.

It wasn't long before I took a dive down the Linux rabbit hole. I bought a Toshiba Portege 7020CT, and it was cool, but it was also "spare", so I figured ... why not Linux it! Yes, my first Linux experience was on a laptop in 2002 (back when kernel 2.4 was the new hotness). Trial by fire. It was a nightmare to get going, but damn I learned so much.

Working at the boarding school reimaging laptops, fixing printers and running network cable was one thing, but suddenly being exposed to init systems, having to compile kernel modules and really having the opportunity to explore how a single computer was put together was pretty darn magical.

I can't imagine I looked like I was enthralled with Linux at the time - all red faced and frustrated that nothing worked - but coupled with the university courses I was taking, the amount of knowledge it consolidated for me was huge.

I ran with a Linux system at work (and a very similar system at home - Slackware, and Slamd64!) for the next few years, before I moved out of academia and into commercial world, where I ended up on Windows XP. No more OS choices for me, I guess! I'd sold the Toshbia laptop and picked up a late PPC model Mac Book Pro which I'd been experimenting with for a while, just playing and getting used to it. I liked having Linux servers and desktops, but OSX on the MBP was just so much more stable and responsive (with actually useful ACPI suspend options).

The new job necessitated moving house, so it was time to reevaluate the computing situation. Having built up confidence in the laptop form factor and in OSX, and kinda desiring to just get on with actually producing things (music, documents, code) and not tinkering around with the OS anymore, I got a newer Intel model MBP and moved wholly into OSX for home stuff. I eventually sold or donated pretty much all the desktop midi-tower machines, monitors and anything else that wasn't attached to the laptop.

I ended up back with Linux at work for a bit, and more recently even had OSX at work, but I was OSX full time at home.

Which brings us to now. I've been with MacOS (OSX) full time since somewhere around 2009, and I've loved using it. It's mostly gotten out of my way and let me focus on just Doing The Thing - be that writing, music, art, programming or watching way too much YouTube. It's got me through a whole ton of life administration and enabled me to keep in touch with loved ones.

So if OSX has been so great, why go elsewhere?

At the start of this year, I had completely fallen out of love with computers, and everything that entailed. I was getting to the point where I didn't want anything to do with them, and when you've built a career out of "computer stuff", that's not a great place to be. Full disclosure, a good part of that disillusion was as likely to stem from my job role as Head of Software Development as it was from the operating system I was running at home and work, but there's more.

The wonderful thing about OSX is it gets out of the way. If you want to do something, it'll either just be there and work, or you have to go through some hoop jumping exercises found on the internet. It's not really meant to be tinkered with, and while [Homebrew](https://brew.sh) and [MacPorts](https://www.macports.org) are super cool and bridge most of the OSX <-> Linux gap, it's never felt quite the same. Those days of tinkering, exploring, learning and thinking creatively about how to make things work were long gone, but a series of events sparked some ideas in my brain about what to do next: starting with a head crash on my USB backup drive, but more on that much later.

# Upgrade inspiration

For reasons I don't even remember, I was watching a lot of [Linus Tech Tips](https://www.youtube.com/user/LinusTechTips) and other PC-building enthusiasts, and wow, the builds are really clean and cases have definitely moved on. And they glow now! So pretty! It was a different but similar world from the one I'd left in 2002. It was exciting to see what had changed, what had stayed the same, and it was nice to go back to my roots a bit. Once upon a time I enjoyed making PCs and tinkering around, and seeing how pretty these could be, maybe that would be fun to play with as part of the upgrade path?

While watching RAM glow is fun, watching them build a [Virtualised Gaming NAS](https://www.youtube.com/watch?v=dpXhSrhmUXo) and later doing some crazy things with a [Household Server](https://www.youtube.com/watch?v=jvzeZCZluJ0) was a real eye-opener. I was astonished to see virtualisation at home using actual hardware working for games, but also other things, like NAS. I'd always considered "real" virtualisation to be the exclusive domain of work, and never thought about it beyond the occasional boot into Virtualbox for home.

Additionally, things like:

 * Being at home more is a significant incentive to kit out a real office, desks 'n' all, which means I can think about going beyond a single laptop.
 * OSX is increasingly getting locked down, eventually Homebrew will probably cease working, I need to understand what my other choices are and start diversifying again; just like I did a decade ago.
 * Apple are switching to Arm processors. Good news if you're a Raspberry Pi owner; you're about to find a ton more Docker images available for you. I've been through PPC -> Intel. I don't want to go through this again just yet.
 * I've got a load of Steam games that I'd love to put some time into, just to see if I care about them. Not a great use of my life I grant you, but some times it's nice to just play and not think so much!
 * Building PCs looks like fun, I'd love to give it another go with some newer stuff.

So I've got all these different things coming together in a project to build an upgrade machine. Not just any upgrade machine, however. I want a machine based on a hypervisor, so I could run multiple virtual machines on my single piece of hardware.

Oh, and I want it to glow. That was non-negotiable, even though [Matt](https://www.eightbitraptor.com/) thinks I'm a dirty gamer with no class.

The future is here, and it's RGB rainbow tinted. Live with it.

_[Part 2]({{< relref "2020-08-15-personal-virtual-computing-ii.md" >}}) is all about the design choices, and whatever research I did. Spoiler for part 4: I did not do enough research._