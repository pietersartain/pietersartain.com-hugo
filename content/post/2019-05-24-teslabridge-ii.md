---
title:  "TeslaBridge II - live in the wild"
date:   2019-05-24 18:00:00
categories:
    - "Design diary"
    - "Computering"
tags: 
    - making
    - raspberrypi
    - networking
    - retrospective
---

A couple of months ago, I detailed the construction of a [special guest wifi]({{< relref "2019-03-31-design-diary-special-guest-wifi.md" >}}) for my car, and ended the post having successfully got the car to connect to the bridge and appear, and first blush, to work.

Over the last month I've watched and noted the car not staying connected over night, and not reconnecting when I get home from work. Early in the process I checked the logs and could see things being a bit wafty, but this time it was time to get serious and figure out what was going on.

## Breaking into the TeslaBridge

Step 1: return to the Pi. Except I'd forgotten my user/pass. I wasn't prepared to go through the setup steps again, because the system was perfectly functional ... if I just get into it!

This wouldn't be the first time I've had to break into a Linux box (last time was when I started a new job) so I felt pretty confident, but the last time I had the benefit of a CD drive that I could boot disk!

I can actually go one better here, since I can just pull the SD card and mount it somewhere else to inspect the content. Except I could not figure out how to get Virtualbox to see the Apple SD card socket.

Abandoning that process, I dumped the Pi SD card to an image file, copied image to a Linux VM and [mounted the image as directed](https://major.io/2010/12/14/mounting-a-raw-partition-file-made-with-dd-or-dd_rescue-in-linux/). I really loved the offset trick to mount a single partition in loopback on a whole disk image. So cool.

Great, so now I've effectively got root access to the hard drive. What else do we know? Well ...

    /etc/passwd has the usernames
    /etc/shadow has the passwords (because shadow-utils is keeps the user and pass separated)

On very old Linux systems, the password hash can be found in `/etc/passwd`, but now we use `/etc/shadow` to separated the user from the pass storage, and offer some access control. I didn't really think about it much last time, but now I've just got a long string of alphanumerics. Checking out [this lovely article](https://www.slashroot.in/how-are-passwords-stored-linux-understanding-hashing-shadow-utils) gives me some insight into what shadow-utils is, and how the hashing works in there. So when I go poking around, field $6 tells me what algorithm is in there.

[Some more poking around ](https://unix.stackexchange.com/questions/81240/manually-generate-password-for-etc-shadow#81248) and the collective wisdom of StackExchange tells me how to produce a new shadow password with the right hashing algorithm.

... which is useless if I can't change the password on the device.

Goodness, how simple it should be! Except the files I'm modifying are dumped images on a VM on my laptop, and there's a lot of hoops to jump through to get the modified image back onto the SDCard!

So, I do what I should've done in the first place, be more systematic with my password attempts. And I finally get lucky. Blergh. But at least I knew what the username was.

Now I write down the user/pass so I don't lose it. And write down the SSID/pass while I'm there. And the hostname. Just in case.

Finally, I can get back into the device to actually look at what the problem is ...

## Dissecting the traffic

There's a couple of things I know, and a couple of things I suspect.

I know that there's some weird stuff in the logs. I worry it's due to unintended leakage of DNLA or similar.

I pop open `tmux` and run both `tshark -i wlan0` to look at network traffic and `tail -f /var/log/syslog` for the system logs. And then I strap in and get some serious waiting time done.

Checking the network traffic back in after an hour or so shows up nothing much out of the ordinary, except I can't see any OpenVPN activity either, which seems to be a key part of how Tesla vehicles handle telemetry.

Moving on to checking the system logs shows up some interesting behaviour though:

May 25 12:34:51 teslabridge hostapd: wlan0: STA 90:3a:e6:11:9a:ff WPA: group key handshake completed (RSN)
May 25 12:44:51 teslabridge hostapd: wlan0: STA 90:3a:e6:11:9a:ff WPA: group key handshake completed (RSN)
May 25 12:54:51 teslabridge hostapd: wlan0: STA 90:3a:e6:11:9a:ff WPA: group key handshake completed (RSN)
May 25 13:04:51 teslabridge hostapd: wlan0: STA 90:3a:e6:11:9a:ff WPA: group key handshake completed (RSN)

Every 10 minutes, very regularly, hostapd seems to indicate the connection reconnecting. Hmm. Smells suspicious. It doesn't seem like the car is doing the reconnection. Maybe it's on the Pi side? Mostly on a whim, I check [the default settings of hostapd](https://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf) looking for things that are in 10 minute or 600 second intervals.

And find `wpa_group_rekey` as a possible suspect. Some careful searching and once again the wonderful community at [StackOverflow have run into something that smells like my problem](https://stackoverflow.com/questions/46264537/hostapd-client-re-authenticates-regularly-without-appearing-to-have-been-deauth).

`wpa_group_rekey=600` by default (every 10 minutes ...), so let's set `wpa_group_rekey` up to 86400 seconds (1 day). My hypothesis, when I started thinking about it was that if the connection is being dropped my end every 10 minutes, I'm resetting some internal timer on the car, preventing the handshaking and initiation of OpenVPN.

Having got this far, I left it sitting for another hour or so and checked back in with a `tshark` dump file, looking for [OpenVPN details](https://wiki.wireshark.org/OpenVPN).

I find plenty of references to 104.199.64.55, which is a Google Cloud IP, a pile of [M-SEARCH packets](https://serverfault.com/questions/64884/network-flooded-with-m-search-packets-what-does-it-mean), and finally some to 205.234.31.53 which is a Tesla IP!

Checking the dump file details themselves, we have success! I can finally see OpenVPN activity occurring!

Another hour later and the connection is still doing stuff, which seems much more promising than where it was sitting, doing a couple of things and then reconnecting.

I don't precisely know why resetting every 10 minutes would cause such a difficulty, but with a fixed reset now occurring only daily, the chances of success seem much higher.

## Mid-June update: the real test

An update to the car! We actually got an update through the TeslaBridge! This was fundamentally my root desire in the first instance, to ensure the car was connected to wifi to get updates as soon as possible.

## Lessons

The initial setup was a technical success, but customer failure. It "worked" in that it ticked all the acceptance criteria (isolating network bridge, access point, connection to main network) but didn't hit the user story ("as a Tesla owner I want my car to get updates over wifi").

I was pretty disappointed with the initial one day build (all one day builds take at least two days) when it didn't work. I didn't have the focus to fix and improve it at the time but I did think that I'd get back to it faster than I did. When I came back to this, I wasn't expecting to spend a few hours having to break into it. Write down the darn passwords.

The key lesson here: keep a rough build log and include that stuff. Even if you think it's only going to be 24 hours between build sessions.

I had also geared myself up to spend a long time figuring out what exactly was going on with the network traffic, and in the end, it took an hour to collect some initial data, make a few tweaks, and then confirmation was practically instantaneous. I'd made some assumptions that stopped me getting started and created inertia to experimenting. Perhaps more dedication with a project log or journal would allow a quick piece of experimentation instead of having to psyche myself out for the next step.

Ultimately, I'm waking up each morning now to find the car connected to the wifi, and have successfully received an update through this process, so functionally I have solved my initial problem! The only thing left is some kind of case, rather than leaving it sitting out bare on the windowsil, but that's a different kind of one day build, for a different day.
