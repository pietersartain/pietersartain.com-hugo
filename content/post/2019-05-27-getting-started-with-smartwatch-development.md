---
title: "Getting started with smartwatch development"
date: 2019-05-27 14:30:00
categories: design diary, code
---

So the goal here is to have some fun hacking some watch face ideas together for personal use. I'm not looking to sell, or share. When working with embedded systems like these, there's two parts that we need to get working:

 1. Development/compilation environment
 2. Deploying code onto the device

Usually deployment is fairly easy and the IDEs are the hardest part to configure. In this case, the security model of the watch is such that there's a whole signing process to go through and the development environments provided by Samsung and Tizen are Java-based, which hurts on MacOS.

## Getting started

So [last time, I observed]({{< relref "2019-05-16-my-first-smartwatch.md" >}}) that getting started with smartwatch development would involve Java because the Tizen tools and watchface design tools are Eclipse-based. Now, I happen to have some professional experience hacking on Eclipse, so I'm well versed in how tricksy it can be. Infact, it was so tricksy I started this project on 18th May, sunk a whole weekend into it without success and moved on to reviewing how to [fix the TeslaBridge]({{< relref "2019-05-24-teslabridge-ii.md" >}}).

Let's just let that sink in a minute: I chose to stick my nose into Wireshark network logs for diagnostics over and above making some IDE work. In what world is this sane?

Anyway, if I wanted to literally just play with background images and rotating fancy parts with simple (battery, stepcount) complications I could use the [Galaxy Watch Designer](https://developer.samsung.com/galaxy-watch/design/watch-designer) or a 3rd party set of applications around [Watchmaker](https://watchmaker.haz.wiki/tips:start). However, I would quite like to experiment with putting all sorts of different things on to my watchface, not just a watchface, so my only choice is to use the generic Tizen development environment. The install-and-go version of this is [Tizen Studio 3.2](https://developer.tizen.org/ko/development/tizen-studio?langredirect=1), which is based on the Eclipse IDE. If you've ever had the misfortune of doing embedded device development with Eclipse and CDT, it smells a lot like that.

The only ["getting started" guide](https://www.tizenexperts.com/2015/12/how-to-deploy-to-gear-s2-smartwatch/) I could find looked a little old, but gave me a little confidence that what I was looking to do was possible but I needed to strap in for the long haul if I want to achieve my goal.

## Problem #1: Java

In a previous life, I'd make sure I'd grabbed the right VM version that was tested for the tools I was trying to use, and update the $PATH variable or point the `java` tools at the new install, and voila. The [prerequisites of Tizen Studio](https://developer.tizen.org/development/tizen-studio/download/installing-tizen-studio/prerequisites) says:

    You must install Oracle Java Development Kit (JDK) 8, JDK 9, or OpenJDK 10 to use the Tizen Studio.

However, Oracle just slammed up a license wall on older versions of the official JDK, which rules out JDK 8 and 9, and I've never worked with OpenJDK 10. The latest current official JDK is 12.

I started by trying to install Tizen Studio on MacOS with the latest official JDK 12.0.1, but I quickly discovered that wasn't going to fly. I managed to get a copy of JDK 10.0.2, which worked in some places, but only after I hacked a few of the MacOS startup scripts to ensure the apps were using that not the default 12.0.1 install. I'm sure there's a proper way of changing default java versions on MacOS, but while I was making progress, I was happy hacking around.

3 hours later I had Tizen Studio up, with the package manager, installed all the things I needed for Wearable 5.0 and downloaded some sample projects to poke at.

The emulator ran, the sample projects ran. The certificate manager did not, the emulator manager did not. Both failed with various Java errors.

I went round and round the houses on this, even going so far as to get this up and running on an Ubuntu VM, which was significantly easier. 18.0.2 LTS with OpenJDK 8 (openjdk-8-jdk). This process was nice: I downloaded Tizen Studio 3.2, and followed the instructions everytime it complained of a missing dependency:

 * apt-get install openjdk-8-jdk build-essential libwebkitgtk-1.0-0 rpm2cpio python2.7 libsdl1.2debian bridge-utils openvpn 
 * Install libpng12 manually: https://packages.ubuntu.com/xenial/amd64/libpng12-0/download (from [here](https://www.linuxuprising.com/2018/05/fix-libpng12-0-missing-in-ubuntu-1804.html))

This worked out great, bar some oddities with my VirtualBox install and it's graphics. Some screen sizes would just go black, sometimes it would rescale and disappear; very annoying.

Taking a small detour, I looked into [the differences between OpenJDK vs Oracle JDK](https://javapapers.com/java/oracle-jdk-vs-openjdk-and-java-jdk-development-process/) and came to the conclusion that if I was able to vote with my fingers and avoid the Oracle parts, then I should.

My theory with Ubuntu was that this should be easier, isolated, and consistent, but I failed to take one thing into account ...

## Problem #2: Nested virtualisation (and more Java)

The Tizen emulator is QEMU, so you can't run that under VirtualBox. After some experimentation and [this thread](https://stackoverflow.com/questions/19846569/need-guide-on-how-to-make-development-in-virtualbox-ubuntu-and-debug-with-an-emu) I figured out how to move the emulator part to the host OS and keep the dev environment in the VM. 

Except, I already had a working dev environment on my host OS, and the problem I had wasn't emulation or initial IDE setup (I'd already got both of those working locally), it was deployment, so this complex setup gained me exactly nothing.

I scrapped the Ubuntu VM that I'd put together and went back to MacOS, ensuring that at least the tooling I needed worked (sdb, certificate manager mostly). It didn't, so I went back 'round another couple of Java loops. Eventually discovering that I could install a non-Oracle JDK 8 with Homebrew (`brew cask install homebrew/cask-versions/adoptopenjdk8`). Although being unable to install an Oracle JDK via Homebrew is definitely [a recent issue](https://github.com/Homebrew/homebrew-cask-versions/issues/7253) that's still something of a WIP, having the option to use an open version (as previously discussed) was enough to get me off to the races with the tooling.

After some more poking around I found Galaxy Watch Active looks to be based on Tizen Watch 4.0. Clicking the right buttons to get that installed, I grabbed a sample watch to build (which did build!) and test out.

I'm basically now at the same state I was few paragraphs in: a working emulator and dev environment, but now I'd wasted nearly 10 hours going around in circles. Right. Let's focus.

## Problem #3: Device connection

So now I have the emulator and the environment running, time to test this on a real device.

Configure the watch:

 * BT off, WiFi on
 * Debug mode on
 * Developer mode: Settings > .. > Software Version (tap 5 times)
 * Reboot

One of the things that doing a lot of reading gave me during the previous steps was some keywords to investigate - like `sdb`, the Samsung equivalent of Android's `adb`.

I tried lots of different versions of `sdb connect ...` but got nothing but "device offline". I had some success with this with the open emulators, but nothing with the actual watch. Eventually, I pulled out nmap to check the open ports and low and behold, no open port on 26101 (the debug port that the emulators cared about).

The missing trick was off/on and enabling Developer Mode and making sure I `sdb kill-server` between attempts. I didn't see either that actually listed in the official Tizen documentation, but then, I guess it may be more Samsung docs that Tizen.

Okay, great, connection with the device, but now `sdb connect ...` returns device unauthorised! We're making progress.

## Problem #4: Certification

All the docs show an image of "click here to accept certificate" on the watch itself when you make the sdb connection. Finally, this showed up!

I've already accidentally made an author certificate by playing with Galaxy Watch Designer, and Tizen Studio has provided me a certificate profile for a Tizen device, so I `sdb install ...` the package and ... nothing.

I took a small side track and tried Galaxy Watch Designer - run on device actually worked! The thing loaded and away we went.

So okay, it's all possible, now what?

Closing and restarting everything, trying install again and actually it's throwing up a "Check certificate error". Some more searching and I find a need a [distributor certificate](https://resources.developer.samsung.com/040_Samsung_Developer_Program_FAQs/Galaxy_Watch_Designer_FAQs/What_is_a_distributor_certificate_and_how_is_it_used%3F) [for my device (with DUID) specifically](http://denvycom.com/blog/how-to-install-wgt-files-gear2/). When using the Watch Designer, the distributor certificate didn't ask for a password, but Tizen Studio's cert manager requires one.

Several searches later, I find the instructions for [creating a certificate in Tizen Studio](https://developer.samsung.com/galaxy-watch/develop/getting-certificates/create) and making sure I had the [certificate extensions installed](https://developer.samsung.com/galaxy-watch/develop/tech-doc/tizen-extension-sdk-guide), with my device ID, reset everything just in case.

Finally, after a good 16 hours of tinkering, work and not a bit of frustration, I've got a sample watch face built and loaded on to my actual device!

## Now I'm ready ...

My original goal was to hack a bit and have some fun. I wasn't expecting it to take quite so long, but reading back through the log, I'm not massively surprised it did.

All the instructions exist, they're peppered around various parts of both the Samsung site and the Tizen site. Were I doing this professionally, I would definitely be scouring the sites to build the definitive set of instructions to onboard my developers. In the process I may read things more thoroughly, I may discover everything was there all along ...

I do find myself skimming docs to discover the solutions, instead of sticking hard to the instructions. Hubris, really, thinking I know better somehow.

Anyway, I'm now ready to start tinkering at some future date.