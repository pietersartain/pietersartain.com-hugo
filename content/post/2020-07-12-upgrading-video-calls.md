---
title: "Upgrading video calls"
date: 2020-07-12 12:00:00
categories:
  - "Video"
  - "Configuration"
---

I've already written about [routing audio from different sources into video confs]({{< relref "2020-05-16-osx-audio-routing.md" >}}), and waxed a little lyrical about my history, and the present, of [remote music collaboration]({{< relref "2020-06-25-remote-music-making.md" >}}).

A recent generous offer to join in with a remote roleplay game ([City of Mist](https://www.cityofmist.co/)) being run by a friend gave me just the excuse I was looking for to experiment with streaming technology for video conferences. My hypothesis is that there's a lot of benefit to be had by being at least familiar with the streaming tools that are now basically plug and play.

What I've discovered, through some experimentation, is that there are three levels of upgrade here, starting with a basic screen overlay, and increasing in complexity to include multiple scenes and then using a remote control. Finally, I found a bonus upgrade with the addition of a sound board, but that's strictly audio, hence the bonus status.

# Upgrading video calls for roleplaying

For those who don't know what roleplaying looks like, typically, a bunch of people sit around a table and pretend to be someone else for a few hours. There's often one person at the head of the table playing "the world" (so all the other characters, and anything else that can happen), but our players are the stars. There's a few "gamey" bits, and different games have different mechanics, but usually this boils down to some character statistics and some dice rolls.

For anyone who does know what pen-and-paper tabletop roleplaying looks like. I'm really sorry my description above didn't do it justice. It's a wonderful time of both socialising and make-believe, with incredibly low entry requirements of basically pen, paper, maybe some dice and your full attention for a few hours.

So my goal here is to try and bring some added value without diluting or overwhelming the game being played. This is not dissimilar in intent to [painting boardgame pieces](http://www.randomnerdery.com/2018/08/guest-post-brighten-up-your-tabletop.html): I want any change to be add to the enjoyment of the game, rather than making the pieces less useful, or detracting from the experience.

## Video overlay

I started by thinking a little bit about what might add to the experience, and settled on a sort of "visual novel" idea. Some name plates to add to our talking heads.

While there's other software out there that will do this, I decided I wanted to use the same stuff that the streamers do, which is [Open Broadcaster Software](https://obsproject.com/). Since OBS is designed with streaming in mind, not video conf software, I had to install a OBS virtual camera plugin, which is available [for Windows](https://github.com/Fenrirthviti/obs-virtual-cam) and [for OSX](https://github.com/johnboiles/obs-mac-virtualcam). This lets me select the output of OBS as a webcam, mostly. There's a small snag with Zoom and Teams on OSX where you've got to disable the signature, but that's one terminal command away from being fixed:

> sudo codesign --remove-signature /Applications/zoom.us.app/

Ultimately, jump through enough hoops and OBS virtual camera will show up as a webcam you can just plumb in.

{{< figure src="/post/2020-07-12-upgrading-video-calls/01 video overlay.png" title="Putting PNG files over webcam with OBS" >}}

## Multiple scenes

So that's cool. Now I've got some PNGs over the top of my webcam!

Following the visual novel thought through, the next thing one would need would be fancy backdrops to talk over, or at, or on ... or something.

Having wired OBS to virtual cam, most of the technical work is done, and now it's down to artistry to assemble the different sorts of scenes you might want to be in ...

{{< figure src="/post/2020-07-12-upgrading-video-calls/02 background scene.png" title="A diner overlay for two players on one webcam" >}}

... like a diner!

I took the opportunity to put two webcams into the frame so both me and my wife get our own nameplates and spaces.

OBS lets you layer up scenes as well as other media. I built an "OnLocation" scene that contains two webcams and the image overlays, so I can use the same OnLocation scene with new backdrop images. In this case, diner.png.

At time of writing, I've spent a couple of glorious afternoons finding character art and assembling background images and nameplates, and have extended that to ensuring there are borders to the backdrops and so on.

Clicking the links on the left hand side (Office, Diner, NightStreets, etc) will transition to a new scene.

## Remote control (via OSC)

Multiple scenes is great, but now I have to keep OBS on screen while I'm playing, and that seems like a crazy distraction. So, remote control to the rescue!

OBS itself has a variety of apps for remote control, but I knew I wanted a more general solution for control that I could scale to a sound board, too. The general solution to the sound board situation is MIDI or for me, a network capable similar thing called [OSC](http://opensoundcontrol.org/introduction-osc).

There are three parts to making my OSC remote work:

 1. [OBS web socket plugin](https://github.com/Palakis/obs-websocket) - this provides a socket address to control OBS, but doesn't talk OSC.
 2. [ObSC OSC to web socket daemon](https://github.com/dillwishlist/ObSC) - this provides an OSC server that connects to the OBS websocket above, and translates incoming OSC messages to OBS websocket messages.
 3. [TouchOSC Android interface](https://hexler.net/products/touchosc) - finally, the actual remote control interface to put on a phone, tablet or other remote device, to send OSC messages to control OBS.

{{< figure src="/post/2020-07-12-upgrading-video-calls/03 touch osc remote.png" title="TouchOSC interface in the editor" >}}

I've only worked with TouchOSC a little bit, but I love the editor and the workflow between that and my phone. I can make a few tweaks, push the sync button, head to my phone and pull the layout file straight over!

I started with just 4 scenes and 4 sounds, but as you can see, I had a lot of fun expanding my collection of buttons!

## Integrating sound

While I can attach media and sounds to each of the OBS scenes (which I may yet do), what I wanted to start with was a push-button-make-noise soundboard. Punches, doors opening, telephone rings, for on demand foley to our adventures

After some tinkering, and a great steer from theatre pro Richard, I constructed this monstrosity in [Reaper](http://reaper.fm/).

{{< figure src="/post/2020-07-12-upgrading-video-calls/04 reaper soundboard.png" title="A sound board made of Reaper and macros" >}}

I've pulled a bunch of different sounds from [freesound.org]() and spaced them out with markers on the timeline. I have some slightly complicated routing where most of the sounds go through Blackhole and my laptop speaker (as per [the routing audio post]({{< relref "2020-05-16-osx-audio-routing.md" >}})), but the talkback channel at the bottom is taken out of the general routing, and routes directly to blackhole only, so I don't get weird localised feedback.

The trick to making the soundboard is in another three parts:

 1. Custom actions that set the transport to a specific marker, then plays.
 2. Using a Reaper feature that allows triggering actions on markers to trigger "Stop" on the next marker in the sequence.
 3. An OSC bind to the custom action from TouchOSC.

In my most recent upgrade of this, I've also added some effects to the talkback channel, and connected them to the TouchOSC with toggles, so I can toggle "vocal effects". I'm not sure exactly if this is the right thing to do or not yet, since I can't hear the effect.

In general though this works really well, and lets me trigger on demand sounds as I want.

## Wiring sound and audio together

The final trick is connecting one OSC client to two OSC servers simultaneously, since OSC is only a point-to-point protocol. If you have a spare router or a Raspberry Pi, you could leave one of these things setup fairly trivially with some network routing rules, but you can also use a neat utility called [OSCRouter](https://github.com/ETCLabs/OSCRouter) to act a server, and split or span OSC messages to multiple clients.

So that's it. TouchOSC on the phone connects to OSCRouter, which pipes OSC messages through to Reaper on one side for the sounds, and OBS on the other (via ObSC and OBS Web sockets) for the scenes, then all of this is output via Blackhole for audio and OBS virtual cam for video to a video conference of your choice!

{{< figure src="/post/2020-07-12-upgrading-video-calls/05 full setup.png" title="Everything running on one screen" >}}


Easy, right?

# Where next?

So the setup is a bit complex and involves a fair few moving parts. For a game we play a few hours a month, it's probably excessive. That said, much of the energy investment has been in learning and building the infrastructure. Were someone to come to me tomorrow and ask about setting this up for a different roleplaying game, the hardest part would be doing the artwork. Unless the soundboard needed to be extremely different, I'd probably just add to it.

I unveiled the first version of this to the rest of the group two weeks ago, careful that I didn't want to turn the whole session into The Piete Show, and the response was overwhelmingly positive. The GM commented that having the character names on the screen was helpful, having the sets was really nice to anchor the group, and my fellow players enjoyed the extra pieces of the experience.

I took some feedback away from that session, but most of it was in what effects and sets I didn't have, rather than anything to do with the concept itself. It would be easy to fill spaces with lots of fun technology, so be concious of introducing this to a group who really don't need the extra distractions. I feel like it may have even helped that I was doing this as a player, not the GM, so I he wasn't getting distracted from the story with the tools.

Improvements that I'd like to make to the setup over time:

 * Easier setup, maybe more dedicated soundboard software (although I love getting use of Reaper).
 * Cooler sets and frames, more artwork.
 * Consider the use of animations and media in OBS (opening doors with sound effects) - this could slim down the soundboard foley as well.
 * Integrate my character sheet or other adhoc visuals into the stream (you've found a key - here it is).

In general I am however extremely pleased with the addition. It's exciting without being overwhelming, and it doesn't get in the way of the game. Time will tell if it becomes just the way we play, or if it's actually more hassle than it's worth.

While this was obviously angled for entertainment, the other question in my mind is "how could this be useful/used for remote work in my company?". I have no answers to that yet, but it seems like there's plenty of tech out there and I'm excited by the opportunity!
