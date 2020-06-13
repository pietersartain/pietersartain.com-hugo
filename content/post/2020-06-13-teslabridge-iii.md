---
title: "TeslaBridge III - keeping up to date"
date: 2020-06-13 14:00:00
categories:
  - "Design diary"
  - "Computering"
tags:
    - making
    - raspberrypi
    - networking
    - upgrades
---

Early last year, I detailed the construction of a [special guest wifi access point]({{< relref "2019-03-31-design-diary-special-guest-wifi.md" >}}) for my car. Then how I had to [fix it to make it work]({{< relref "2019-05-24-teslabridge-ii.md" >}}). Until recently, this was working just fine: my car connected, software updates were downloading, everything was happy. I stopped thinking about what I'd built and started relying on the service it provided. I don't know exactly when things stopped, since we've all been [spending less time in the car](https://en.wikipedia.org/wiki/COVID-19_pandemic_lockdowns), but a few weeks ago there was a software update available but I should "connect to wifi to download it". "Huh," I thought, "I'm sure I should already be connected ... "

## Initial investigation

The car could see the access point, but wouldn't connect and kept bouncing me back to ask for a new password. My phone and laptop could see the access point, but wouldn't connect. SSHing into the raspberrypi worked sometimes, but not every time ...

Turn it all off, plug it into the TV for monitoring and watch the kernel explode as I try to connect to the AP with my phone. Great.

So, I do what I normally do when things just stop:

> ~$ sudo apt-get update && sudo apt-get upgrade

In hindsight maybe I should've stopped to fix the problem before changing the nature of the problem. However, now I can see it reliably kernel panicking every time I try to connect to the AP.

## Reading around

Considering the system booted and worked fine until the AP had an incoming connection, this smelt very kernel driver related, so that's where I focused my efforts.

I use a tiny Edimax USB wireless adapter, that reports using the Realtek RTL8188CUS chipset:

> ~$ lsusb
> Bus 001 Device 004: ID 7392:7811 Edimax Technology Co., Ltd EW-7811Un 802.11n Wireless Adapter [Realtek RTL8188CUS]

What my searches came back with was a lot about this chipset from 5 - 7 years ago.

 * [Installing a rtl8188cus driver on Ubuntu](https://askubuntu.com/questions/236617/how-to-install-driver-for-rtl8188cus-wireless-adaptor)
 * [Hosting an AP on Debian](https://charlesz-p.blogspot.com/2015/07/hosting-wi-fi-access-point-on-debian.html)
 * [Wifi AP on RaspPi](http://raspberry-at-home.com/hotspot-wifi-access-point/)
 
I found a bug that sounded similar to what I had: [Kernel panic with Wifi AP](https://github.com/raspberrypi/linux/issues/3167), but no information or resolution. Finally, this bug exhibited all of the behaviours I was seeing: [Hostapd + 4.19.40 + Edimax EW-7811Un fails to accept client connections
](https://github.com/raspberrypi/linux/issues/2979).

## Trying some stuff and testing the fix

In amongst trying to remember where all the logs were, I tried to follow some of the older guides, to see if I could reinstall the drivers as directed. Failure. They wouldn't compile under the more recent toolchain and ABIs. Using specially crafted `hostapd` binaries didn't work either. Older versions and all that.

Pondering the relationships between what I was seeing, it seems that this chipset has been a bit shonky over the years, and that there's a two key moving parts - the kernel driver for the hardware to be visible to the system, and then a hostapd binary (the access point deamon) that knows how to talk the right language to the driver.

The last bug suggested a fix being to use the driver we blacklisted in the past:

> ~$ rm /etc/modprobe.d/blacklist-rtl8192cu.conf

So, upgrading the kernel broke the driver we were using (8192cu), and the fix was to use the original driver that now works.

"[Seems to me 8192cu module never worked as an access point with a 4.19.xx kernel](https://github.com/raspberrypi/linux/issues/2979#issuecomment-497272873)".

Phone now connects as expected, and I can see the car connecting just fine too.

## Lessons learned

Changing stuff before diagnosing problems is generally a bad plan. In this instance I don't think it made much difference, but it is curious as to why things broke in the first place. Did some autoupgrade happen with the kernel? I found reference that about mid-2019 (a month after I finished playing with TeslaBridge the last time), Raspbian upgraded it's base version from Debian 9 Stretch to 10 Buster, which uses a 4.19 kernel.

It also looks like the upgrade I performed brought the 4.19 kernel into the Stretch install I had, and that's consistent with the bug reported and the problems I saw.

When I found the service was broken, I rushed to get it back running instead of stopping and looking at it properly. It only took an hour or two of "proper" investigation to sort it out, but I easily wasted another hour randomly futzing with it.

Slow down, disable non-essential services, triage and prioritise, then get back up and running. Hopefully this'll keep working for another year or two before I rebuild the whole Pi!
