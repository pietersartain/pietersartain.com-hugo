---
title:  "Design diary: special guest wifi"
date:   2019-03-31 18:00:00
categories: personal development, code, making, design diary
---

In late 2017 I bought the best toy I have ever had the pleasure of playing with: a Tesla Model S. I'm not a car-person, so I didn't have to overcome the loss of a combustion engine, and I mostly do a 30 mile round-trip commute, so range anxiety was something that wasn't a huge deal for me. This post isn't about my experiences of the car, this is about getting the car on the wifi.

It should be simple enough - just get the car on the drive, and connect. Boom. Done. For most people this works just fine, but for a few of us, it's not so simple.

After some reading around, it seems like the car doesn't like DNLA because it gets in the way of the VPN the car is trying to make via UPnP. Or something like that[[1](https://teslamotorsclub.com/tmc/threads/tesla-wifi-sux.89032/page-3)][[2](https://teslamotorsclub.com/tmc/threads/tesla-vehicle-wireless-network-software-glitch-initializing-loop.90976/)][[3](https://forums.tesla.com/forum/forums/wi-fi-connection-keep-re-initializing)]. I have Chromecasts and Sonos speakers in the house, along with occasional Plex servers (on my laptop), pinging multicast and DLNA messages around the network, and basically nothing is hardwired so it's fairly hostile network environment if you've got a fragile networking stack.

The solution generally seems to be to use a separate guest wifi that's a bit more isolated. Which I tried. I use a Netgear Orbi system because we've got 16+ wifi devices and the poor Virgin HomeHub just didn't cut it any longer, which comes with a Guest Wifi option ...

... except it doesn't actually give you a separate VLAN it just bridges the two networks together, so you can still connect to your main network, and the broadcast packets are still bouncing around.

So the theory here is to create a separate, isolated, network just for the car. Welcome to 2019. Here's the design diary.

## The problem to solve

I need something to plug into the main wifi that doesn't bridge the two networks, and doesn't receive broadcast packets from the main network. This is a router by any definition. So the aim here is:

    -- Modem -- Orbi -- Main SSID --* *-- my internal network
                 \
                  \-- TeslaBridge -- Other SSID --* *-- isolated network (car)

So I need this TeslaBridge system to do a few things:

 * Do some routing between two networks, probably with some kind of small computer.
 * Offer a a wifi access point to the car.
 * Connect to the main Orbi router.

## Initial thoughts

When it comes to small computers these days, Raspberry Pi is the name that springs to mind, and I happen to have a couple of spare Raspberry Pi B+s with little Edimax N150 wifi adapters not really doing anything currently. So that's a tiny Linux box with network connectivity, that doesn't need to host many many devices, so it'll probably be perfect.

As for the access point, I do have some older hardware access points available, but they don't work without crossover cables directly into an host ethernet port, so I need to combine one of those with a switch (which I also have), but now we've got need of 2 plug sockets, plus the Pi's USB socket, a bunch of cables and ... ugh.

Some quick searching established that it's possible to run the little Edimax USB adapters as an access point itself, so that seems like a perfect option if the range is enough.

Theoretically I could connect to the Pi to the Orbi via a second wifi adaptor (which I have), but to start with I decided to go leave it plugged in via network cable. This is another cable in the house, but one less set of configuration, which from a project delivery point of view is great.

So the two pieces left are:

 1. How to make the access point stuff work?
 2. How to selectively bridge the two networks together?

Tackling the second point first was my biggest unknown. Curiously, this sort of isolated network routing is very much the same shape as if you wanted to do security research and leave a honeypot connected to your internet without risking your main network. More searching and I found this rather wonderful article on [erratasec.com](https://blog.erratasec.com/2016/10/configuring-raspberry-pi-as-router.html#.XJ_Y3uv7TOQ) describing all that needs to be done for a honeypot setup, especially the network bridging. The major differences between his setup and mine is that he's using two hardwired ethernet ports, and I need to build a wireless access point into mine, but at this point all you're doing is configuring iptables rules between interfaces, and it shouldn't matter what type of interfaces you're using.

The second point was easier, because building a wifi access point out of a Raspberry Pi is a common enough request that the lovely people at the RaspPi consortion have written [a whole page about it](https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md).

Now I know it's theoretically possible, time to get to building.

## Getting started

I first tried using the Pi as it was out of the drawer. It had a preinstalled Noobs setup, which installed Raspbian Wheezy which was really smooth (I haven't had much experience using Noobs, so this was great!) but unfortunately [networking changes between Wheezy and Jessie (and Stretch)](https://raspberrypi.stackexchange.com/questions/39785/differences-between-etc-dhcpcd-conf-and-etc-network-interfaces) make following tutorials just more complex than they need to be. In theory I could probably do enough research and dredge my memory on how all the networking fits together in Debian, but that's not been my core skill set (if it ever was!) for years now and I don't want to this project to hang around too long. I started doing some updates on the existing system, but after half hour realised that it'd just be much faster to [download](https://www.raspberrypi.org/downloads/raspbian/) and [install](https://www.raspberrypi.org/documentation/installation/installing-images/README.md) a modern version of Raspbian and start again. So I did that.

Up came the box, and [default access](https://www.raspberrypi.org/documentation/remote-access/ssh/unix.md) was granted with user "pi" and password "raspberry", and we should be on a DHCP lease. The only last piece to do is to enable SSH because I don't have any monitors except the TV and Pam is trying to play PS4 ...

`raspi-config` sorts out SSH, password change and hostname. `apt-get update && apt-get upgrade` gets us into a comfortable place from an updates perspective. I'm especially keen to make sure all the wireless and networking tools are up to date. At time of writing this is running Debian Stretch.

So, once I have a booted running system, I need to do 3 things:

 1. Configure the ethernet side to be nice and static - futz with dhcpcd config.
 2. Configure the Wifi side to be an access point - hostapd and more dhcpcd config.
 3. Bridge the networks in a specific way - play with iptables rules.

## 1. Configure static ethernet

As noted above, the networking changes between Wheezy and Jessie were enough to make a mess of the tutorials. It looks like Jessie to Stretch also brought a second wave of changes that at least tidies some leftover parts up, but adds even more confusion over [how to restart the network](https://www.reddit.com/r/debian/comments/7nw98g/seriously_restarting_network_interfaces/). I thought [this Stackoverflow answer](https://raspberrypi.stackexchange.com/a/74428) was a nice explanation of what was going on of at least some of it, so I started tinkering with the dhcpcd.conf file to convert my connection to static.

And promptly stopped. Did I actually need this to be static? What benefit was I gaining? This is the internet-facing-side of the router, and other than ssh'ing in I wasn't going to be binding or pointing anything at the IP address. Great! That's a whole chunk of work I didn't have to do. I abandoned this step in favour of actually making some progress on the project, and moved straight to ...

## 2. Configure wifi as an access point

Back to the [RaspPi docs](https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md) to install and configure dnsmasq, hostapd and the AP as a static interface. While it should've been as simple as just following the instructions, there was a couple of hiccups, which lead to a fairly core realisation for me.

Some steps didn't work like in the docs, but as complete as the docs were, they're totally unverifiable. I have no way of knowing (at each step) what the expected output is, what state the system is supposed to be in and at what point I can actually move on to the next step, so I have to follow the instructions blindly and hope that at some point everything comes together.

Little bit stressful, tbh, but I found a few things out:

 * There's no change to wlan0's network address after having configured a static IP using dhcpcd, no matter how many times you restart things. This kinda makes sense, because we want hostapd (the access point software) to manage this interface, so it'll be the one to bring it up and assign the address, not the usual networking parts.
 * No need to use the older Edimax chipset driver (rtl871xdrv), we can just use the the default nl80211 when configuring hostapd.
 * When it comes to starting it up, you can check the hostapd config is going to be alright by running `sudo hostapd -d /etc/hostapd/hostapd.conf`. Errors will show up nice and visibly.
 * For reasons I don't fully understand, hostapd was masked (eg disabled as far as systemctl is concerned) by default, so you need to `systemctl unmask ... && systemctl enable` before `systemctl start hostapd`.
 * hostapd is what gives you an access point to start with, and it's dnsmasq that provides the DHCP server, you can test the hostapd part separately from dnsmasq.
 * Log files for both services are in /var/log/syslog, so `tail -f ...` away.

I ended up using the main dnsmasq.conf and adding in the requisite line at the end, so I could enable a couple of other options around not forwarding weird DNS requests.

Once hostapd was running, I grabbed my mobile phone and connected while watching the log. Good, it shows up, but doesn't do anything. This highlighted some areas in dnsmasq that needed attention, but mostly I'd forgotten to reload the configuration, so a few restarts later and boom, I now had my phone connected to a wireless access point ... without internet.

## 3. Bridge the networks

So now I have an access point that's dishing out IP addresses, and an interface that's connected to the router. Time to connect the two pieces together.

This part turned out to be much much easier than I was expecting, and compared to getting the right network subsystem incantations in place above, came together very fast. I followed the instructions from Rob on [erratasec.com](https://blog.erratasec.com/2016/10/configuring-raspberry-pi-as-router.html#.XJ_Y3uv7TOQ), enabling net.ipv4.ip_forward and then substituting his interface names for my own for the iptables rules:

Our internet interface is eth0 (the one facing the internet)
Our internal interface is wlan0 (the one that should be isolated)

    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT

As he says, these configuration change aren't persistent so a quick `apt-get install iptables-persistent` fixes that. I got the initial setup wrong, and so a small detour led me to learn that these rules get stored in /etc/iptables/rules.v4 in very plain text. This also meant I could edit them where I went wrong, which was neat.

Picking up the phone again, I can see this gives me full internet access, but also bridges to eth0 so I can access 192.168.1.1 (eg the internal network).

To restrict the guest network from seeing our network, we  drop all traffic from the wlan0 interface heading to our private internal network.

    iptables -I FORWARD -d 192.168.1.0/24 -i wlan0 -j DROP

So this should be good enough, I can test both sides with devices that things aren't visible (various types of ping and webpage look ups) but I was frustrated with the lack of verification earlier with the access point setup, and I want to do a bit more investigation rather than just blinding plugging the car into the new wifi and hoping for the best.

Since my internal network has no knowledge of the 10.0.1.0/24 range of the new special guest wifi, I can't ping it or perform lookups on it, so no one else should, however, I want to make sure. I happen to have some experience with Wireshark (a packet capture and analysis tool), but this Pi isn't running desktop software. Luckily, they have a command line version called [`tshark`](https://www.wireshark.org/docs/wsug_html_chunked/AppToolstshark.html) so let's use that to actually watch some traffic and make sure that it does what I expected.

First off, let's inspect the internet-facing side, and see what sort of madness is being received:

    sudo tshark -i eth0 -a duration:20 -f "net 192.168.1.5"

For me, 192.168.1.5 is a Chromecast. Looking at the output I can see MDNS requests (multicast packets) are hitting this interface. So we've definitely got some multicast packets going on. `-f "..."` is for the [libpcap filtering](https://wiki.wireshark.org/CaptureFilters.

Checking the guest wifi side (this grabs 20 seconds of network traffic from the wlan0 interface and dumps to stdout):

    sudo tshark -i wlan0 -a duration:20

I don't see any activity multicast activity at all, and nothing from the Chromecast.

## Final installation

The final test of course is checking it with the car, and yes, it worked. At this point, however, I've got cabling strewn all over the living room, so there's one last piece which is to figure out a more permanent (or at least temporarily permanent) home for this.

I'm still constrained by an ethernet cable and a USB socket, but the both the Orbi router and satellite have ethernet and USB 2.0 sockets, so in theory I can just plug both into one of them, which seems nice and neat.

My first thought was to plug into the satellite which is upstairs in a room overlooking the drive way. While the RaspPi was happy being powered and got nicely hidden under my desk, the car didn't get a strong enough signal for that to be worth it.

My second effort was to relocate the whole lot back downstairs and maneuvre the Pi onto the bay window. With the wifi aerial in the right-hand mirror of the car, my parking with the bay on my right, this seems like a good combo. 

Success! With two bars in the car, it seemed good enough for a first pass. A tiny bit of cable routing care later and I've verified the car has connected (/var/log/syslog) and checked using the car's browser that I can actually get to websites.

Special guest wifi! The TeslaBridge is live.

## Lessons

The whole project from inception to completion took place over this weekend, in about 10 hours. I got the Pi and the other bits of hardware down Saturday afternoon, and spent most of the afternoon doing the research to get the instructions together, and then most of the evening unsucessfully trying to follow them. Doing some more reading on the Debian networking situation on Sunday morning after breakfast convinced me that actually trying to follow this stuff with an old version of software was just going to be pain, so I started from scratch and then it probably took about 4 hours on and off to variously do the installs, updates, diagnostics and final checks.

I had a really clear idea of what I wanted, and knew most of the constituent parts were possible, before I began. I sketched some of this post and the design while waiting for various things to load on Saturday night, but the whole idea was largely in my head (not my project notebook) and I basically just started. I think finding the two really good pieces of documentation on access points and on isolated networks really early in the process gave me the confidence to jump right in. Other people had definitely done all the hard work here, I just had to do a little integration work.

The research to get those docs was invaluable, and definitely time well spent. Historically I would've been frustrated by a lack of progress after that first night, but I unearthed enough material quick enough that I learned not to try and progress and just abandoned the old version (and the static networking stuff). Once again, less is more, and not doing some stuff made this a [one day build](https://www.tested.com/search/?term=One+Day+Builds).

I learned that unverifiable documentation irks me. Not knowing what state the system should be in, or what to look for to determine step-wise success was an interesting realisation for me.

It's gratifying to have completed this over such a short period of time, and it's definitely dusted off some old Linux skills that I was worried I've been losing. It seems to be a success, but at the time of writing this post it's only been a couple of hours since I finished, and the car probably hasn't needed to update itself, but in theory: job's a goodun!

