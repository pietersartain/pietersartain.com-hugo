---
title: "Making music remotely"
date: 2020-06-25 12:00:00
categories:
  - music
  - configuration
---

With the need for social distancing, the internet is full of remote shows. Take That got in on the action, as did [Dua Lipa on James Corden](https://www.youtube.com/watch?v=D6sf0LNrDss), and countless others.

Prompted by the questions of "how do they do that?" and "what are my options?" I wanted to dig into the state of the nation regarding remote collaboration tools, especially with regards to music. As it happened, my good friend [Richard](http://www.argyllrb.co.uk/) was also interested in poking around remote recording.

Here's what we came up with.

## 1. Idea generation and creation

If this is my goal, I'll be reaching for the "usual" tools: video conferencing, emails, shared folders full of stuff, phone calls.

This is mostly how I collaborated in the past: my collaborators and I would be on a call while we kicked around ideas and wrote the song - taking it in turns to perform our ideas to the other person(s). In order to turn the idea into a real song, I'd either record the parts myself, or get my collaborators to record their parts and send me the files to handle mixing at my leisure.

Mechanically this is just using normal DAWs, and file synchronisation tools. Our tool of choice at the time was a shared Dropbox folder. We often did little bits of recording during ideation, and file synchronisation tended to happen while we were in discussion, so the collaboration felt more live. Our collaborations could've just as easily been done via email, and the process would have stayed the same.

## 2. Unstructured jamming

Promoting a slightly different workflow for the same sort of activity, we found a collection of tools that had server/client models and allowed people to jump in and play with you. These all had a "delay by measure" approach - so fixing the delay at a musical interval, instead of just whatever your ping happens to be. This allows everyone involved to hear the last thing that was laid down, but delayed by some musically appropriate amount.

 * [Jammr](https://jammr.net/)
 * [Ninjam](https://www.cockos.com/ninjam/) 
 * [JamTaba](https://jamtaba-music-web-site.appspot.com/)
 * [JamWhenever](https://jamwhenever.com/)

Neither Richard nor I cared much about this concept, so we didn't actually play with these, but the idea came up often enough during web searches that it might be an interesting experiment in the future.

I got some articles by [Reverb](https://reverb.com/news/ways-to-collaborate-on-music-remotely) and [ask.audio](https://ask.audio/articles/how-to-play-your-rehearsals-live-online).

## 3. Live rehearsals, gigs

This was the thing I was most interested in exploring, because it seemed so impossible, and yet also was made to appear to be working!

We started with some tests of Google Meet and Zoom, and found they had delays north of 500ms between systems, making it absolutely impossible to play together using these. I knew it didn't work, but didn't know how badly it didn't work ... now I do.

We did, however, find some lower-latency services that promised live jamming possibilities.

 * [JamKazam](https://www.jamkazam.com/)
 * [Jamulus](http://llcon.sourceforge.net/)
 * [Soundjack](https://soundjack.eu/)

We tried JamKazam and Jamulus, which both did the same thing, in slightly different ways: connect to your audio interface, stream audio to a server, and play that audio back to all the clients. With a low enough latency, which shouldn't be completely ludicrous in this day and age, maybe it was possible to do live jamming now?

JamKazam's interface was annoying but highlighted really clearly why doing anything like this over wifi was just a non-starter: the consistency of packet transfers over a wire is just so much tighter than wifi. I feel like I knew this academically, but seeing the delay bounce around like nobodies' business really landed the point home. I bought a USB ethernet adaptor the same day to take out an extra variable in the testing. Jamulus was the same idea, but a much lighter weight interface.

Both of them had broadly the same results: with me in the south of England and Richard in Scotland, at best we got a 60 - 80ms delay on each side. As a drummer, I know that significantly above 10ms makes playing a bit of a nightmare.

Just for completeness, we wrangled our networks and ran a ping test: 50ms average ping time between us. When viewed in that light, I think Jamulus was actually doing a damn fine job - only adding 10ms or so on top of the network latency for processing.

There was one more thing I found but didn't try, and that's [JamLink hardware](https://store.musicianlink.com/). Given our round-trip latency was already more than the established minimum viable 30ms, I can't see any hardware improving that, but I like the idea of wiring up instruments with ethernet cables.

Okay, so with all of this, how are people like [Take That](https://www.youtube.com/watch?v=avb1NCjwLaw) and [Anamanaguchi](https://www.youtube.com/watch?v=iWi_wNtYq5g&t=872s) performing together, as the videos make it appear?

Our (boring) conclusion was that these are "faked" live videos made of a few components. The Take That situation was probably the closest to live we saw, and we think the setup is as follows:

 1. A live video uplink for everyone to talk to each other between songs.
 2. A backing track for each performer to play along with, ideally centrally sourced.
 3. A central recording point to mix the whole thing together.

In effect, this is the same sort of process that podcasters go through: each person records their part separately and the multiple vocal channels are mixed together after the fact for the final production.

This strategy only sort of works with music. So long as the performers weren't playing off each other, but to a central thing, you'd be able to assemble something that looks live, but isn't.

Disappointing, but not unexpected.

## 4. Remote tracking / recording

This was an area of investigation that I didn't know I cared about, but Richard definitely did.

The big version of this was the [SessionWire](https://www.sessionwire.com/) product which aims to create a bridge between two DAWs, allowing synchronisation of a whole porject to happen in the background, while pushing lower quality audio between clients for more "live"ish work.

Richard, however, had a bunch of other really interesting ideas including streaming bots for recording from Discord (at surprisingly high quality!) and [AudioMover's ListenTo](https://listento.audiomovers.com/) 

ListenTo was the most interesting of these endeavours for me, allowing streaming between two DAWs with send and receive VST plugins. And streaming at super high quality too, we managed to get two 24bit stereo PCM streams running concurrently but we got some distortion and breakup in the stream. Downgrading this to two mono streams worked fine, and we could even do this bidirectionally. Quality-wise a far cry from compressing the tracks - Richard could hear the difference, although I didn't do any of my own tests. I was just excited to see my DAW meters bouncing when Richard pushed play!

Using this process, Richard could record me and mess with those tracks on his side, play them back to me and I could hear what he was doing at equally high quality. In theory, I could've recorded his playback as a bounce-down track, and either layered some more up things my side or sent a whole bunch more over to him to mess with.

I can't quite wrap my head around what exactly my workflow might look like with this, but it was so extremely satisfying, I am definitely inclined to play with it again!

So that's where we are! Live gigs on the internet are lies, and there's some pretty cool software out there to move audio around.
