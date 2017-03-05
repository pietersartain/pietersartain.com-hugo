---
title:  "Power saving"
date:   2009-05-25 12:00:00
categories: computer tech
---

Since moving to a server/client network architecture at home, I'm finding the electricity bills are going nowhere but up! There are many reasons to have made the move to this sort of network architecture, and I'm still not quite there (web development is done on my main box), but it's so nice not to lose access to media when I turn my machine off for whatever reason.

Anyway, power saving ...

So an instant fix was to start suspending her machine. With Windows, of course, suspend to ram didn't seem to be too much trouble.

3 months later, the next bill arrives. It's still a whopper. Now I definitely need to do something with my own machine (and maybe eventually the server too). I remembered reading a request for testing on [LQ.org](http://www.linuxquestions.org) from [rworkman](http://rlworkman.net) about [pm-utils](http://pm-utils.freedesktop.org/wiki/), which got me thinking about power management on a desktop machine.

xscreensaver does a pretty good job of turning off the monitors, and I know I could use various laptop packages to spin down the hard drives, but I'm very good at turning off monitors and if I'm sitting at my PC, I'm using it. So I don't actually need to preserve battery power, so much as metaphorically close the lid on my PC.

~~I wrote rather a lot on the topic, and decided it would be better placed off the blog. You can find my notes on suspend to ram and CPU frequency scaling here.~~

Now time to wait for the next bill and see if this has helped!

[Note from 2017-03-05: The linked piece has been copied into below, for posterity.]

# Power Saving

This isn't intended to be a how-to, more an aide-memoire. If you get something useful out of it, however, all the better.

## Kernel config

The kernel must be aware of what hardware you're trying to operate on, and so you could do with setting the following:

      - Processor type and features
        - Processor family (to unlock any specific extensions)
        - Power management options
          - ACPI (as many options here as you have items on your motherboard)
          - CPU frequency scaling (ditto - make sure you get the right processor driver)

In my case the motherboard is a Abit KV8 Pro - this a socket 754 running a Athlon64 2GHz processor with a VIA KT8T800 Pro / VT8237 chipset. I end up with powernow-k8 driver enabled for CPU frequency scaling and a ton of ACPI features.

## Suspend to ... what?

Suspend to disk (hibernate, S4) or suspend to ram (standby, S3)?

Hibernate writes the system state to your disk (over the swap partition) and places a marker so that during next boot the state will be resumed and you'll have your swap space returned to you, then shuts down the hardware. The key point here is that you must got through a normal BIOS boot procedure and partial Linux boot load before it'll resume. This actually isn't a significantly shorter boot procedure than turning the damn thing off in the first place.

Standby does the same thing, except doesn't write any data to the disk, preferring to keep it in RAM. Matthew Garret could explain much better than I, and infact, has already done so. The key point with standby is that there is no partial boot process, so many of your devices are likely to be uninitialised on resume.

Suspend to ram is, however, what I need. I want to shut the lid on my desktop and have the system pop back up later on when I've woken up.

Like others, I found that there are a plethora of methods for suspend to ram, but after a few false starts with a kernel recompile, the easiest one turned out to be manipulating the power state from the sysfs.

Adding "resume=/dev/sda3", where sda3 is my swap partition, to lilo's append line allows all this to work. There is a default option in the kernel config that may be used to set this also.

To see what states are available to set this way:

    ~$ cat /sys/power/state
    mem disk

If you're using an nVidia card like I am, beware that the 180 series of drivers cause some headaches with resuming (see ThinkWiki link below).

Finally:

    ~# echo -n "mem" > /sys/power/state

Will suspend to ram just fine. When all's said and done, it's that easy if I'm in X (which I mostly am).

Video comes up fine. Sound works fine, although any flash players with sound will need refreshing in the browser. Network card needs reenabling through rc.inet1 eth0_restart - that's really a job for a hook, which is precisely why pm-utils should be preferred in this case over just echoing the command into sysfs.

## CPU frequency scaling

Plenty of information to be obtained from sysfs again:

    ~$ ls /sys/devices/system/cpu/cpu0/cpufreq/
    affected_cpus     ondemand/                      scaling_driver    stats/
    cpuinfo_cur_freq  scaling_available_frequencies  scaling_governor
    cpuinfo_max_freq  scaling_available_governors    scaling_max_freq
    cpuinfo_min_freq  scaling_cur_freq               scaling_min_freq

There are five governors:

  * performance - max freq
  * powersave - min freq
  * ondemand - hard ramp between min and max
  * conservative - soft ramp between min and max, better for laptops
  * userspace - custom speed

Setting the governor to ondemand is just fine for me, so the CPU will idle at 1GHz but ramp up to 2GHz during heavy load.

    ~# echo -n "ondemand" /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

To fix that so it'll be that way every boot:

  ~$ echo -n "echo -n ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> /etc/rc.d/rc.local

## User-end Work

As Robby notes in his readme regarding pm-utils and automating the process of suspend:

<blockquote>
A better option is to use a power manager daemon, but unless you happen to be running gnome or one of the pre-release xfce-4.6 builds, that's not an option.
</blockquote>

More to come on possible solutions to this.

## Links

 * [Mini How-To: Hibernate and resume](http://www.linuxquestions.org/linux/answers/Hardware/Mini_HOW_TO_Hibernate_and_resume_0) - cwwilson
 * [How Linux suspend and resume works in the ACPI age](http://www.advogato.org/article/913.html) - Matthew Garret
 * [/sys/power/state](http://acpi.sourceforge.net/documentation/sleep.html) - Linux acpi sleep documentation
 * [Display remaining black after resume](http://www.thinkwiki.org/wiki/Problem_with_display_remaining_black_after_resume) - ThinkWiki
 * [CPU frequency governers](http://www.mjmwired.net/kernel/Documentation/cpu-freq/governors.txt) - Linux kernel documentation
