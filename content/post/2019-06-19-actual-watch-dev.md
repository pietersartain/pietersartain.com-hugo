---
title:  "Experiment: smart watch reminders - 15 minute vibra-chime"
date:   2019-06-19 22:00:00
categories: project log, code, making, experiments
---

This post is mostly for me. It's not a design diary, it's not a retrospective. Using embedded development tools is tricky and so this represents some notes on the use of the tooling (more of a project log, and because I will forget!) on the two experiments I ran to start hacking around before I get deep into a complex original piece of work.

## Introduction

Eventually I managed to set up the [smartwatch development environment]({{< relref "2019-05-27-getting-started-with-smartwatch-development.md" >}}) ready to begin some hacking. It wasn't an easy task, and I took a break from trying to make Java work to [fix up my special guest wifi]({{< relref "2019-05-24-teslabridge-ii.md" >}}), but having got there, now it's time to actually try some stuff.

One of the things that I discovered that I really liked about having a smart watch (see [previous entry]({{<relref "2019-05-16-my-first-smartwatch.md" >}}))was that notifications are now much more personal and don't have to be visual.

I spend a lot of time in my day job talking to people, and while I've gotten better at being mindful of time, I still don't like to cut people off or check my phone/watch/clock too often. Having a feel-based notification for the passing of time would be like a super power in those situations, so my goal is for a reliable 15m reminder that buzzes.

Even though I'd successfully deployed a trial app to the phone, it was several weeks ago and I hadn't tried it in anger yet, and certainly hadn't tried to debug anything.

## Experiment 1: Javascript timers

I picked a web-based watch face to hack on, making sure it'd deploy properly and then bolted in a Javascript hook timer to trigger after every 15s. Deployed, this worked perfectly. My ropey code made a nice buzz every 15s!

Oh, only while the screen is on ... hmm.

Ah, need to [toggle the run-in-background button](https://stackoverflow.com/questions/27650206/tizen-wearable-invisible-background-app-adding-gestures#27732891)! Okay, great now that works.

The buzz was a bit harsh though, so I hacked around some more looking for the "right" buzz. Belatedly I realised there's a buzz-demo app that would've saved the trial and error approach, but the POWERON buzz felt right.

I extended the Javascript timer to 15 * 60000 and went to bed. This will work, I was confident! So I went to work the following day and nope, not even a little bit. Some reading around, and I find the watchface is probably put to sleep to save power and doesn't trigger. Hmm. Time for a new plan.

## Experiment 2: Using alarms

So the theory here is to set an absolute alarm to relaunch the app at the specified time, and then hook against that to cause a buzz. Remarkably, this actually mostly worked. It certainly seemed pretty reliable at 2 minute intervals, but after some experimentation, the 15 minute alarms don't seem to be guarenteed. Although 80% is better than 0%, so this might have to be good enough for now.

During this experiment I found it very possible to break the app. For reference, in order to get web simulator / debugger up in MacOS I needed to pass the whole path for Chrome (past Chrome.app/MacOS/...) into Tizen Studio, not just the Chrome.app part.

## Next steps: watchface design

So now I have a watchface that will mostly buzz every 15 minutes, that part has proven to work, what next?

Time to step away from the code and start drawing. For this I will probably put together a more significant design diary later, but the two key steps here are:

 1. Actually design a watch face. Make a drawing and decide what to put on it.
 2. Run some experiments using HTML5 Canvas to replicate the design above.

## Lessons

The big one here is that the cost of setting up the dev tools triggered a strong impulse in me to get started and go for broke and do all the things. Ignoring that impulse just to focus on one simple experiment (spiking) to remove some unknowns - like exactly how difficult is this watch dev malarky? - has given me two things:

 1. A working prototype that is actually useful in my day-to-day, meeting (however roughly) my original goal of getting a super power to track the passage of time.
 2.  A huge boost of confidence that some of the things I want to have the option of building are possible!

Never underestimate the power of experimentation to build a little confidence and gain some clarity. Especially when the final ideas aren't fully fleshed out yet. Since the prototype can be used, it's a great way of just "letting it sit" to establish the next most important thing.

## Appendix 1: Deploying an app or watchface to the device

### Prepping the watch to recieve a new watchface/app

 * BT off, WiFi on
 * Debug mode on
 * Developer mode: Settings > .. > Software Version (tap 5 times)
 * Reboot

### Build apps ready to load

 * Tizen Studio
 * Right Click project -> "Build Signed Package"
 * Output will be <somethingsomething>.wgt

### Using Tizen Studio to load apps to watch

 * Top of Tizen Studio, in device dropdown menu
 * "Launch remote device manager"
 * Make sure watch is connected
 * Select watch from device dropdown menu
 * Right click project -> "Run as Tizen web application"

### Using CLI to load apps to the watch

    cd ~/Applications/tizen-studio/tools/sdb
    cd <whereevery ChronographWatch.wgt is 

~/Applications/tizen-studio/tools/sdb kill-server
~/Applications/tizen-studio/tools/sdb connect 192.168.1.29 [watch IP]
~/Applications/tizen-studio/tools/sdb devices
~/Applications/tizen-studio/tools/sdb install ChronographWatch.wgt

### Properly testing the results

Should deploy to watch and then be an app that's running in the front of the thing

Push back to back out of having the watchface be an active app over the top of another face

Push & hold face of device to go to select new watchface, pick the new one.

Trial.

## Appendix 2: API references

 * https://developer.samsung.com/galaxy-watch/develop/api-reference
 * https://developer.tizen.org/ko/development/api-references/web-application?redirect=https://developer.tizen.org/dev-guide/5.0.0/org.tizen.web.apireference/html/device_api/mobile/tizen/feedback.html
 * https://developer.tizen.org/ko/development/guides/web-application/personal-data/calendar?langredirect=1
 * https://img-developer.samsung.com/onlinedocs/gear/native/group__CAPI__REMOTE__APP__CONTROL__FRAMEWORK.html
 * https://developer.tizen.org/ko/development/guides/native-application/applications/ui-application/efl-applications/basic-ui-application?langredirect=1#state_trans
 * https://developer.samsung.com/galaxy-watch/design/watch-face/watch
 * https://developer.tizen.org/development/articles/how-use-tizen-notification-api?langswitch=fr
