---
title:  "A musical interlude"
date:   2009-09-24 12:00:00
categories: music, computer tech
---

Being a natural born tinkerer isn't a good attribute when what you really want to do is finish something. The past few weeks I've been working fairly hard on music and trying to get some recording done. So far I've managed 3 minutes. That's about a minute a week, or 0.0099% of one week. Fair enough, I do multitrack recordings, so my actual play time is song time * tracks, but even if I had 15 tracks, that's still only 15 minutes a week.

I spent 7 hours today hitting my snare drum, attempting to synchronise Audacity tracks, but like others before me, I failed.

I have 3 distinct problems with my recording setup at this time:

## Front panel line in

Kernel 2.6.18.8 is the last version with ALSA drivers that see, by default, the line2/mic input on the front panel of my Audigy 2 Platinum. Since I've primarily been using that for recording, it's a bit of a nuisance that Ubuntu Studio comes with 2.6.28-rt and thus I can't see the capture information for line2/mic in alsamixer.

While I'm far from the only person to have this issue, the only resolution I've seen has been from [Mike Arthur](http://mikearthur.co.uk/2008/07/using-asoundrc-to-remap-alsa-channels-for-audacity/), who came up trumps. A quick test (at 11pm, I can't do more than mumble into the mic a bit) shows that it's at least functional.

## Audacity track synchronisation

For many reasons that no one cares about, I like Audacity as a recording program. It's not got a lot of fancy real-time effect features, but like the gimp, with some perseverance you can create the same beveled edge text you made with Photoshop back before you dropped Windows. Oh? Just me then? Well, right, anyway, the problem is that no matter how many variations on sample rate, sample format or latency correction I try, I cannot reliably overdub. The problem is erratic, but in all cases disappears with a sample rate of less than 16KHz - that's telephone quality, and not VoIP either.

## Audible artifacts

When I can get sound reliably in, and in time, it often suffers from artifacts. Some sound rather like I'm tapping a mic with my palm, while others are more like the clicks and scratches you hear from powering up or down an amp or mixer. I can't hear any below 16KHz, but the quality's bad enough by then that I doubt I'd notice if there were. It seems to get easier on the ears if I drop to mono tracks, but it's by no means guaranteed.

To top it all off, I have one very messy audacity project with the major test-song in that I don't think is helping at all - some mono, some stereo, almost all different sampling rates.

To my friends who have been helping me out with trying to get this all set up and working: thank you. I will invariably speak to you all more before this is over - the beer's on me for this one, be sure of it.

So what's the solution? Off to the drawing board and start from the top, working methodically through all the combinations of sample rate, format, latency, buffer and I/O. Tabulate the results and then perhaps we'll be able to draw some conclusions.

My biggest worry is that the hardware is failing, in which case, maybe time for a new PC. Stay tuned.
