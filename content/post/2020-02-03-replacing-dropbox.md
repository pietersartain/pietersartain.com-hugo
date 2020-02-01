---
title: "My second digital life: replacing Dropbox"
date: 2020-02-03 12:00:00
categories: life design, second digital life
---

*Part of an ongoing series exploring my digital life, starting with ["Designing my digital life (again)"]({{< relref "2019-06-27-designing-my-digital-life.md" >}})*

With Dropbox positioning themselves as a collaboration platform, rather than just a synchronisation service, I find their products and my needs are diverging. As mentioned in the opening post, this observation about Dropbox and their intentions was one of the core drivers to reevaluating what services I was using and where I’d gotten to with my digital life. 

It was about mid-2019 when I initially discovered service costs were going up. I knew I would need to find some sort of replacement for file syncing before 2020, but I was busy thinking about what all this stuff meant, until December when the email about costs going up arrived. Here was the catalyst I needed to attempt some experiments!

After an afternoon of sorting files and cleaning up my Dropbox folder, December 20th 2019 became the day I uninstalled Dropbox.

## Needs analysis

What I wanted was a way to synchronise whole folders of files between three devices: laptop, phone and tablet. Some folders are bi-directional, some are simply replicated from the laptop. I already have a two-tier backup situation in place for the files themselves, and each device has enough physical space to store the whole folders, so I didn’t need an always-on server.

## Viable Dropbox replacements

Throughout 2019, while I was never compelled enough to take strong action, I did occasionally think about what my options might be. I looked into some of the direct Dropbox replacements, and even got as far as trying out a [NextCloud](https://nextcloud.com/) virtual machine locally, but I kept getting stuck on fact it wanted a server.

With the impetus to make a thing work *now*, and without a server, I decided to go all in on the decentralised sharing approach. This came down to two options:

 * [Syncthing](https://syncthing.net/)
 * [Resilio Sync (nee Bittorrent Sync)](https://www.resilio.com/individuals/)

I liked the idea of having a properly open-source decentralised sync solution, but after trying Syncthing in anger I had to rule it out because it doesn’t play nice with SD cards on Android, which is the only way I’ve got enough space to synchronise everything on my phone and tablet. While this is a well known issue for them, unfortunately, I didn’t get the sense this was going to be fixed any time soon.

The other decentralised tool I’d been using for a bit, on and off, was Resilio Sync (nee Bittorrent Sync). This isn’t an open implementation, but I knew the software, and I’d had some success with it already. That said, even this needed some finagling to get SD card write access on Android.

## Implementation and results

Setting up was fairly painless - configure bidirectional sync on photo folders, notes folders, etc, and one way sync for music, book, audiobook libraries. While the smaller folders worked great as bidirectional, the larger ones like music (70,000 files and folders over 90GB, all told) never quite finished syncing.

This was a problem, because while Resilio Sync is active and attempting to sync, it burns through battery life.

## Reflections 

The irony of picking an open source project, discovering a known bug as a blocker and then trying a different closed tech instead isn’t lost on me.

The current implementation is functional, but has some bugs in, so I have some experimentation to do later to try and work those kinks out. While I’ve got the sync services on Android to idle, so they don’t drain battery life, I’ve had to disable some folders manually (some of the one-way larger folders).

This means that I have to remember to turn the sync on when I need to pull changes from the laptop. Kinda defeating the point of an automated service. That said, these are also infrequently changed folders and the most frequently changed folders like the pictures and my notes (stored in markdown, obvs).

On a more personal note, unlike the [Brave and DDG switch]({{< relref "2020-02-02-trying-brave-and-ddg.md" >}}), this was more direct and focussed, but also a harder to make. I’d known this was coming for months, but it was only when the email arrived that the constraint became real and I was forced into making some change.

Since I’ve got no active collaborators using Dropbox, uninstalling it wasn’t a big problem initially. However, my wife and I had a shared folder, which got occasional use. Needless to say, she tried to share something with me in January which highlighted a bit of a feature gap in my implementation. Most of the time emailing or using our shared Google Drive folder might be enough, but I don’t use Drive the same way as I used Dropbox. I could ask her to use Resilio Sync, but it doesn’t matter to her like it does to me. I may end up reinstalling Dropbox just for that kinda sharing, especially since she’s still sticking with Dropbox for now.

Finally, I don't regret the loss of Dropbox. I've downgraded my account to a non-paying version and excised most of the dependency, and most of the time the whole sync situation is completely invisible to me. The sign of some good tech is when you stop thinking about it to me.