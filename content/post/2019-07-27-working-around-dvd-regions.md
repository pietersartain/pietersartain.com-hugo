---
title:  "Working around DVD regions"
date:   2019-07-27 14:00:00
categories: project log, experiments
---

Yesterday, what I really wanted to do was watch [3x3 Eyes](https://myanimelist.net/anime/300/3x3_Eyes). I own the DVD, so this should be a matter of plugging play ... except what I own is the NTSC Region 1 DVD "Collector's Edition" and I no longer have a Region 1 DVD player regularly in use under the television ...

So this could've turned into a post about how hard it can be to find older, less popular, works on streaming services but this is actually a post to remind myself how to get video from a Region 1 DVD to a decent digital rip with nice subtitles, and some of the things I learned along the way.

## Usual DVD ripping procedure

With other digitising efforts (I've encoding my whole DVD box set collection of Stargate SG-1) it's been simple:

 * Plug an el cheapo external USB dvd drive into my laptop
 * Pop the DVD in
 * Run [Handbrake](https://handbrake.fr/)
 * Type in episode names
 * Push the encode button

I don't want this to be the process, really. It's heavily manual and requires some investment of time to get all the bits setup (I want subtitles and I save all the extra features and shizz), but after a few minutes of typing and clicking you can push "Go" and come back 45 minutes later to a finished disk. I found I could complete a season or two a week without trying too hard, so I just sucked up the manual work. 

In an ideal world, I'd use something more like I wrote for ripping CDs: [mp3rip](https://github.com/pietersartain/mp3rip), and actually, I did start writing such a thing, but the number of different types of weirdness (all DRM-related) on DVDs meant that each one really needed to be hand rolled. CDs are trivial to rip, DVDs far harder.

## Handling the region problem

Problem one is that DVD players have [region encoding](https://en.wikipedia.org/wiki/DVD_region_code) burned into their firmware. That's right: the hardware itself gets confused when confronted with the wrong region.

Most DVD drives have a number of region changes (usually 5) they can go through before they get finally locked. The fastest way to set a region in OSX that I've found is by dropping the DVD I want to use into the drive, and then opening it using DVD Player. It complains about a region mismatch and then I just select the one I want: in this case, region 1.

Due to historic reasons, I happen to have 2 old IDE DVD players that have been through many computers and servers, and an external hard drive dock (intended to plug a bare HDD into) with an IDE power supply and socket on the front of the thing, so I can chain together this thing with an IDE drive to create the world's hackiest USB dvd drive.

Infact, I'd done this several times already so I had already set one of the drives to region 1 ... except that drive wouldn't read the disk. After somewhere around 10 years, I guess it's had enough!

Okay. So I set the other drive to region 1 and now I've got a thing that can read my DVDs.

## Ripping, encoding, mirroring

What I really wanted to do was just turn the DVD into an ISO and skip having to make a bunch of decisions *right now* about how best to encode the episodes, essentially turning the DVD into a region-free digital version of same.

My previous tactic for this has been to use [dvdbackup](http://dvdbackup.sourceforge.net/) (and some other tools wrapped up in my `dvdrip` package described above; source available nowhere right now) with it's mirror feature.

This didn't seem to work. Couldn't say why, didn't really care to look into it.

What did work, though, was asking dvdbackup to grab title 2, which seemed to contain all the actual content I cared about. The output from:

    dvdbackup -i /dev/disk4 -o /Users/pesartain/Desktop/3x3eyes/ -p -n 3x3eyes -t 2

Was a collection of vob files (capped a 1GB each) that played just fine in [VLC](https://www.videolan.org/vlc/), including offering both audio streams and the subtitles!

Handbrake couldn't see this folder as a DVD, so I couldn't use it to "rip", but then the thought struck me: I don't actually need this encoding. I just need this in a format that makes more sense than a pile of fixed length vob files.

MKV to the rescue.

## Packaging for consumption

MKV is a video container, rather than a video codec, that is quite happy to package up a bunch of different files and such for final consumption. 

My requirements were fairly simple:

 * No reencoding needed
 * Nice subtitles
 * Chapter headings or some way to split the video into chapters
 * Result must play on Plex

[MKVToolNix](https://gitlab.com/mbunkus/mkvtoolnix) allowed me to dump the vobs in there which sorted out the video and two audio streams, and gave me a way of writing in the chapter headings (using the chapter time data from a Handbrake info scan). It was more manual work, but 3x3 is only 2 DVDs and 7 episodes. What it didn't automatically do was give me subtitles.

Don't forget to save the chapters to the MKV file ... MKVToolNix is a collection of GUIs in one place, not the configure-and-write type program that I'm used to.

## Handling subtitles

After some reading around and observation, I finally realised what subtitles on DVDs are: pictures of words.

With that realisation I finally knew why the subtitles I'd done for SG-1 were shockingly bad, and why no matter how many DVD player upgrades I go through, the subtitles are always terrible! Pictures of words! Low resolution pictures of words! These are known as [VobSubs](https://www.matroska.org/technical/specs/subtitles/images.html).

But VLC (and Plex) both allow me to add in text-based subtitle files, and so the font and aliasing control can be done by the renderer instead of the originator of the DVD, taking into account new technologies like ... well, smaller pixels for a start.

So I need text files that I can add. These are [SRT subtitles](https://www.matroska.org/technical/specs/subtitles/srt.html), and while theoretically I could figuring out how to rip the words out of the pictures and make them, many people have already done the subtitling work for me. Enter https://subscene.com/ .

I found English subtitles for all 7 of the episodes I needed, so now it's just a case of including the subtitle into my MKVToolNix session, and boom, done.

The first subtitle file played just fine, English words appearing on screen in time with the Japanese soundtrack, but the others were totally out.

## Synchronising subtitles

Turns out SRT subtitle files expect to start running from the beginning of the file, and I have one big file, so I needed to go back and split the files out by timestamp, or create one subtitle file that included all of the words.

I decided the latter was easier.

My first stab was to use the timestamps generated by Handbrake (that I also copied into the chapter settings) to offset every timestamp in subsequent subtitle files using [SubShifter](https://subshifter.bitsnbites.eu/), which was easy enough. But still rendered some weirdness in how the subs showed up at the start of each episode: some were too late, some were too early.

With some assistance from [my very patient wife](https://certainlygeeky.blogspot.com), we managed to locate the timestamps in our actual video of when the first subtitle should arrive. Armed with that we did some ~~jiggery pokery~~ maths to figure out what the SubShifter number should be in relation to the start of the very long video, et voila!

Because working the maths out was a bit of a pain and we had to do the same things again and again, we made the [Subtitle Offset Calculator spreadsheet](https://docs.google.com/spreadsheets/d/1W40f29EQ51WmUPUd_nnx9oFobhXapKp_yoiDHZS_7tk/edit?usp=sharing).

Concatenating the files together and dropping it into MKVToolNix finally gave me a working, chapterised, beautifully rendered subtitled 3x3 Eyes disk one!

I did the other disk this morning in the same fashion, and now I can happily put the DVDs back on the shelf to collect dust while I enjoy their content digitally!

## Lessons

So pros: this process was pretty painless in the end, and the result feels fantastic. I also love the fact that I can tidy up the subtitles or reformat them if I want to. I haven't, but it's nice to know I could. Not being a video person, I really don't know what the best thing to do with vob files is, so just being able to dump them into one container lump is really nice. Additionally, not having to decide how to encode things for "the best" version of that content is fantastic, even if costs a bit more: 7.5GB / disk instead of maybe 500MB per episode (15GB for the series instead of 3.5GB). I would've picked an encoding that was visibly the same, but I would forever be worrying about if I picked the "right one". An extra 12GB for no anxiety? I'll buy another storage HDD, I'm good with that.

On the con side: I can name the single file to include all the episodes, but Plex doesn't know how to translate that into chapters and to start playing the file at the right chapter to make it appear like it's different files. This also means the watched/unwatched markers don't work like you'd really want them to. I also have a niggle about changing the subtitles, so I've kept the source material to make that change later ... another 15GB of it.

This definitely feels like the way to tackle region 1 editions of programmes that have small episode runs (like 3x3 Eyes or films). I'm grateful I don't have a whole library to do like this, but a small handful seems very reasonable!