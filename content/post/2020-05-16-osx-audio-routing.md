---
title: "Audio routing in OSX"
date: 2020-05-16 14:00:00
categories:
  - music
  - configuration
tags:
  - music
  - configuration
---

Once upon a time I used to collaborate online and make a lot of music. As I write this, the UK is in the 10th week or so of lockdown (although it's now "stay alert") and I find myself with a little more free time on my hands for things like music, but without a workflow to make the collaboration happen!

In the olden days, I had a shared Dropbox folder that handled the synchronisation of files between me and my collaborators. Occasionally I'd use a speaker and jam a bit live while discussing sounds, but most of the time I'd just bounce the mix under discussion down to mp3 and let the shared folder take care of it.

In this brave new world, however, I'm trying to do more live work, and even for those occasions I can be more asynchronous, [Dropbox is no longer part of my ecosystem]({{< relref "2020-02-03-replacing-dropbox.md" >}}).

This post tackles the live work portion of this. I've got half a thought regarding Resilio Sync for the async portion!

## Goals

After some failed experimentation with Soundflower (OSX 10.14), I found a great video from [Gabi Rose](https://www.youtube.com/watch?v=MtMgvkJGr2A) who breaks it down nicely.

The end goal for this is such that I can:

 * Sing / play an instrument in my DAW
 * Have the vocal / instrument signal pass through the effects chain and into video conf software
 * Be able to monitor my sounds
 * Be able to hear the other party in the same headset

There's a few key concepts that are needed to make this work:

 1. Aggregate audio devices. The ability to string together different audio devices and have them behave as one lump.
 2. Virtual sound devices. The special ingredient that acts as a transparent input and output device, and simply plays back what it hears on the input at the respective output.

## Setup

For our virtual sound device, as advised I snagged [BlackHole](https://github.com/ExistentialAudio/BlackHole) (I believe `brew cask install blackhole` also works). As Gabi says, Soundflower may work better for some people. It didn't for me.

Once you've got that, set your aggregate device up. For me, that means welding my USB device the BlackHole virtual sound device.

{{< figure src="/post/2020-05-16-osx-audio-routing/0 create aggregate device.png" title="Aggregate device setup" >}}

I set my DAW preferences (this is Reaper for me) to use the aggregate device, which meant I had access to all the I/O of my USB interface and the BlackHole device, and configured the master channel in my DAW to output to more than just the default channel ...

{{< figure src="/post/2020-05-16-osx-audio-routing/1 set master output to BH.png" title="Add the BlackHole outputs as a new hardware output" >}}

The result of this means that the DAW outputs on two separate devices, the USB interface and BlackHole channels 1-2.

{{< figure src="/post/2020-05-16-osx-audio-routing/2 set master output to BH.png" title="All hardware outputs on the master channel" >}}

Finally, I can just use BlackHole outputs in the video conf software inputs, and then I've effectively shoved my DAW in between my inputs and my video confs!

{{< figure src="/post/2020-05-16-osx-audio-routing/3 set video conf input to BH.png" title="Using BlackHole as the input to video conf" >}}

## Outcome

The net result is that any of the mix/mess I make in my DAW will end up in the video conf, and using separate audio out for my video conf, I can listen to other people on whatever device I chose without it routing weirdly back through my DAW.

One thing to note, though: there is no side channel or back channel with this method. Everything goes through the DAW, and I use the DAW to do the mixing/routing etc. So if I forget to enable a track for normal conversation in the DAW, then no one else will hear it!

Having tested this over an hour and some with friends recently, I can say it works, but after messing around a lot, they reported the sound got extremely distorted and wouldn't recover. Restarting my DAW and reconnecting to the conf call seemed to fix it though.

Happy musical conf'ing!