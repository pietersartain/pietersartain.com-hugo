---
title: "Lessons in keeping music software up to date"
date: 2019-03-17 12:00:00
categories:
    - "Music"
    - "Recording"
tags: 
    - recording
    - notes
---

Back in 2015, when I wasn't working I was trying to make music. [I spent a lot of time and some money to assemble a set of tools to support my creativity]({{< relref "2015-04-20-recording-software-stack.md" >}}). It was a careful blend of the physical space, the recording and instrumental software and the hardware (both instruments and computer), and it worked great.

Life happened, however, and my setup was moved, reassembled and largely left behind while I upgraded my OS. Occassionally I've gotten the urge to plug a guitar in but with so many things having moved on, it's usually ended up spending an hour or so tinkering with software just to get back to the 5 minute jam I had wanted in the first place. "Often" became "sometimes" became "rarely" because of this accumulated friction.

Last year I tried to [understand my guitar tone]({{< relref "2018-01-24-understanding-guitar-tone.md" >}}), and actually built a couple of decent effects stacks with Revalver, but coming back to it today, neither my guitar nor my orchestra patches seem to be doing anything sensible.

# Guitar

Since the Mac upgrade in 2017, Peavey Revalver HP has been asking for reactivation on startup. For £7.50 though it's probably worth writing it off, because it's just making me so damn frustrated. I tried reactivating, I tried to changing the reactivation method, asking support, but it's just old. Instead of trying to fix the plugin, I've just replaced the elements I was using from Revalver, and created a replacement chain that looks like this:

Tuner       | ReaTune
TS          | TS-999, TSB-1 or TSE-808
Chorus      | BlueCat Audio
Reverb      | MVerb | ++delay | Legrange
PreAmp      | The Anvil, Poulin (Ignite Amps)
PowerAmp    | TPA-1
Cab         | LeCab2rev1
Noise Gate  | 
Compressor  | ReaComp

A couple of my SG and Gretsch patches use the Peavey Revalver HP's TubeScreamer and Classic 30 head, with some of the other random bits and bobs like the CS3 tube compressor and ACS-R2 Reverb, but most of them are now as above instead. I need to find a decent replacement chorus and implement a noise gate, but otherwise that should sort the Guitar out.

# Orchestra and synth

IK Multimedia's Miroslav Philharmonik (and the SampleTank, SonikSynth, SampleMoog and SampleTron) functionally works, but was last released around 2011, and is now 2 versions behind. It sometimes works, but the interface is a bit shonky and I'm having trouble plugging the midi back into it. I could upgrade: there's a new Philharmonik 2 (£300) available, but that's an expensive upgrade for something that I'm trying to get _back_ into, rather than something I'm actually half way through.

# Drums

XLN Audio's Addictive Drums 2 is still going strong and really working well. As is Reaper, although I'm currently running Reaper 5 but only licensed up to 4. Before I invest in another license, I need to make sure that my stack is up to date and working.

# Hardware

Focusrite Scarlett 8i6 also still working great, as are the mics and my instruments.

# Next steps

Identifying what it actually is that I need to do my hobby, boils down to three things:

 1. Instruments to create the noise.
 2. FX to change the noise.
 3. DAW to capture the noise.

DAW: Last things first: I'm really happy with Reaper as a DAW, and Addictive Drums 2 is working great for my vdrums.

FX: I am done with Revalver. I am competant enough in using the raw FX options that Reaper provides, but I'm missing out on having a chorus and delay effect that I actually enjoy using, so there's some work to be done there. [Positive Grid](https://www.positivegrid.com/) do a good-price Guitar FX / Amp sim setup called Grid, which needs further investigation. I should also take a look at what the other options look like (such as the Linux 6 Helix setups).

Instruments: Addictive Drums 2 covers my vdrum situation. I need some orchestral bits, a synth and some piano noises. I've got the demo of Addictive Keys to keep me going, and that's working really well, so I'd happily invest more in that if it comes to it. On the synth side of things I think looking into Native Instruments (Kontakt for sample-based, and Reaktor for modular) and iZotope are the right steps, but the orchestral piece is absent right now.

With the flakiness of the old IK Multimedia software, that needs to be removed from my system to save me the headache of having to deal with them.

# Lessons

The IK Multimedia pack for £63 was nearly an insta-regret, because the other option at the time was a "buy all the things including the guitar stuff" pack for £85 (or similar). Given the pain so far, however, not paying the extra £22 has saved me a ton of heartache with *nothing* at all working.

Today I write off the £63 for the IK Multimedia stuff, and the £7.50 for Peavey's Revalver and acknowledge the ecosystem I'm living in has moved on and I need to move on with it.

Interestingly, the thing I've spent the most money on and probably feel the most comfortable that will keep working is the Addictive Drums stuff. If I'd upgraded to SampleTank3 at the time, and then to 4 would I be in this state now? Is IK Multimedia's split focus just a bit too patchy for my liking?

More careful evaluation of entering an ecosystem is not an unreasonable ask, and that's the lesson I take away: find an ecosystem to be comfortable in, and keep up. For me I think it comes down to company focus: XLN Audio does really good sound sampling for instruments. Native Instruments Guitar Rig hasn't been updated for ages, because it's not really a synth, which is where their focus lays.

<!-- Note from 2020-08-15: This was posted today, just to capture some random notes I had bubbling around -->
