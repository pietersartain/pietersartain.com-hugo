---
title: Understanding guitar tone
date: 2020-01-24 12:00:00
categories:
    - "Music"
    - "Recording"
tags: 
    - learning
    - guitar
    - notes
---

This post is about a hobby I haven't written about for a long while: music. It's been a significant part of my life since I've been born, and I've been making music on and off since about 1997. Despite that, I've never done a deep dive on electric guitar tone. Mostly this is just reference, to document what I've learned in my explorations so far.

One day I might swap the ASCII art out for actual images, but one problem at a time :)

# My history

I haven't been big on performing for years, but I still love the creation and recording processes. One of the things that I've done over the years is slimmed down my musical hardware to be mostly physical instruments, a couple of nice mics and a USB audio interface. This allows me to do nearly all of my recording work "in the box", using software.

A consequence of this is that I've ended up with a few virtual instruments for drums, synths and pianos, and a pile of individual guitar effects. The instruments have tended to sound really crisp and inspiring out of the box, and they sit so easily in a recorded mix, but the guitar effects have often left me disappointed with my overall guitar tone.

The virtual pianos and drums have software that's intuitive to understand what the equivalent real recording situation would be, and the acoustic guitar really only has a couple of recording options. The signal path in both cases (real and virtual) is simple: instrument generates sound waves -> mic records soundwaves (plus appropriate room sounds). So recording is just a case of moving the mic around to get the desired tone.

By comparison, there are significantly more elements in the signal chain of an electric guitar (or electric bass) and the more I think about it, the more I realise I have no real understanding or mental model of what part of the chain is contributing to what part of the sound!

# 1. Examining the signal chain

The signal chain to creating noises with an electric guitar looks like this:

```
Guitar -> Pickups -> Effects -> Preamp -> Poweramp -> Cabinet
```

After messing around for a while (and doing some reading around), I found, to my ears, each element contributed in roughly the following the proportions:

```
| Guitar     | The guitar string rotates, generating a magnetic field in the
| 15% (pure) | pick ups. The "tone wood" and style of guitar will have some
|  5% (dist) | impact on the way the strings wobble around, but then it hits
|            | the pickups.
```

```
| Pickups    | Changing the way the pickups work will change the way the
| 20% (pure) | signal is captured (like crude AD converters).
| 10% (dist) |
```

```
| Effects    | Waveforms go into this and get changed, and tweaked, and
| --- (pure) | generally futzed with, so this has the possibility of changing
| 20% (dist) | the tone significantly.
```

```
| Preamp     | The preamp is where the EQ lives, so this makes a bunch of
| --- (pure) | differences to the tonal quality of the output, but also can
| 20% (dist) | be pushed with a hotter signal to create distortion here.
```

```
| Poweramp   | The power amp levels the signal out (although it can do some EQ
| 15% (pure) | stuff), ready for the cabinet.
| 10% (dist) |
```

```
| Cabinet    | This has by far the biggest impact on the tone - moving the 
| 50% (pure) | mics and fiddling with the impulse responses just change the
| 40% (dist) | sound so much. (Currently this also includes the "mic" 
|            | position and type)
```

A key lesson for me here is that when I switch up to distortion I need to make sure there's a cabinet to audibly "soften" the signal from a preamp, otherwise it sounds awful and grindy. It's no wonder that I've abandoned loads of the VST amps in favour of more complete racks - as soon as you strap a cab simulator next to them they work brilliantly.

# 2. How (my) guitars work

Inspecting the mechanics of the instrument a bit closer, I identified the following aspects:

 * Guitar strings resonate, and the amplitude of the resonance (eg how much the string moves in rotation when plucked) is what the pickup measures in the magnetic field; this translates to the amplitude of the electrical signal.
 * A string plucked at the bridge rotates less than plucked at the neck, therefore bridge pickups are more powerful to pick up the weaker signal.
 * The bridge pickup is also therefore more naturally trebl-y.
 * The pickup selector is connecting the jack to either of the the individual 
pickups, or to both of them (in parallel).

More concretely, I've got two electric guitars to play with. Looking at the instructions and playing a bit myself, they work like this:

## Gibson SG Standard
This is a two humbucker setup, with tone and volume knobs per pickup and a selector switch to use only the neck, only the bridge, or both.

Guitar layout:

```
   ______    ___
  /      \__/   \
 |   ||  ||    ============
 |   ||  ||    ============
  \______/  \___/
 
   Bridge    Neck
```

Pickup depths:

```
---------------------------------------
       |     |       |_____|
       |_____|
        Bridge        Neck
```

Volume and tone knobs, and the selector switch:

```
    Neck
  Tone     Volume
    +        +       _ Rhythm (Neck)
                   _/
  +       +      Treble (Bridge)
 Tone   Volume
    Bridge
```

## Gretsch G6118T-LTV 130th Anniversary Jr
This is also a two humbucker setup, but the guitar is a hollow-bodied affair, and the wiring is significantly different to the SG.

Guitar layout:

```
   ______    ___
  /      \__/   \
 |   ||  ||    ============
 |   ||  ||    ============
  \______/  \___/
 
   Bridge    Neck
```

Volume and tone knobs, and the two neck selector switches:

```
                 _     _
                 /_    /_
               _/    _/
               1     2
 
  +    +             +
  5    4             3
```

1. Pickup Selector: Switch for selecting the pickup position (front for body’s exterior, center for mixed, and rear for interior).

2. Master Tone Selector: Tone control switch. The exterior of the body
is deep, the center is bypass (Tone 0), and the interior is shallow, so that the tone can be selected from three levels.

3. Master Volume: for adjusting overall volume.

4. Front Pickup Volume: for controlling the front pickup volume.

5. Rear Pickup Volume: for controlling the rear pickup volume.

# 3. Tonal components of the signal chain

With somewhere between 15% and 35% of the sound being made by the actual electric guitar itself, the remaining proportion is built of the effects, the amplifiers and then the cabinet (and by extension the room sound out of the cabinet).

## 3.1 Effects chains

From "[Understanding pedal order](https://www.youtube.com/watch?v=_Xl19g3zK8g)", a typical pedal ordering (between guitar & amp) might look like this:

 * Wah
 * Compressor
 * Gain (distortion / overdrive)
 * Volume ("boost")
 * Modulation (chorus)
 * Time-based (delays)

The parts of this chain I understand the least is the gain and volume, which are broken down more broadly as "drive" pedals. [Types of drive pedals](https://www.youtube.com/watch?v=VQXaCFr8ePU) suggests there are four key types:

 * boost - boosts guitar level going into amp
 * overdrive - boosts guitar level into amp beyond the amp's breakup threshold (TubeScreamer)
 * distortion - distorts the signal itself
 * fuzz - distorts the signal in a particular way (Big Muff)

[Distortion vs overdrive](http://www.gibson.com/News-Lifestyle/Features/en-us/effects-explained-overdrive-di.aspx) breaks this down a bit more.

Drive pedals are designed to push the incoming signal from the guitar past the maximum headroom on a tube amp, causing breakup, which gives that distorted sound.

From a signal point of view, overdrive is a soft-clipping pedal (eg it doesn't distort the signal on it's own, just pushes the front of the amp harder) where distortion is a hard-clipping pedal (eg "they generally filth [the signal] up and slap their own notion of the ideal heavy rock or metal EQ all over your tone’s backside.")

In overdrive, silicon diodes are hard-clipping, germanium diodes are much softer-clipping.

Fuzz makes the sound fuzzy. Big muff is fuzz.

## 3.2 Amplifier

Amps seem to have 2 parts to them: [a preamp and a poweramp](https://www.ultimate-guitar.com/lessons/the_guide_to/the_quick_and_dirty_guide_to_preamps_and_power_amps.html).

The key to understanding the root of electric guitar "distortion" is to understand that valves (or vacuum tubes) have a non-linear output response past their breakup point when used as an amplifier. So, distortion / overdrive is created by pushing the preamp (the "front" of the amp) past that breaking point to get the right noise, and then just using the power amp to amplify the result.

Most of the tone is generated in the preamp, because that's where all the EQ knobs are wired into. The power amp usually only has a volume and maybe a "presence" (bit of a tone control) twiddler.

You can overdrive a power amp, but it would be at ear-splittingly loud volumes in a lot of cases.

>"Drive coming from the power amp is gnarly, greasy, and has a harder break-up. Different types of power tubes can also have a huge tonal impact. A 6L6 power tube, for example, has a deeper, more pronounced low section and harsher, less even break-up. EL34 power tubes, on the other hand, have more pronounced mids and highs, and a smoother distortion that generally yields more gain. "
> -- [Setting up your amp for distortion pedals](https://www.youtube.com/watch?v=CdKjhXWpjq8)

Doing some searching around, it looks like 12AX7 is a preamp tube and EL34 is a power amp tube, and many of the bands I enjoy use amps with EL34-style tubes in.

## 3.3 Cabinet

The final part of the tonal puzzle is the cabinet. Power amps push sound into the cab, which is what makes the noise. The final tone of the output is shaped by the type of speakers and the cabinet itself (shape, enclosure, and material), and ultimately the shape of the room. Celestion seem to be the speakers of choice, in most cases.

Recorded cabinets of speakers (in rooms) are modelled in software using a cool trick called "impulse responses". An easy collection of these that I found is [God's Cab](https://wilkinsonaudio.com/products/gods-cab) which is a 2x2 MESA cab, recorded using multiple mics and at multiple locations:

 * Dynamic:   SM57, SM57b
 * Diaphragm: U87, C414
 * Capsule:   NT5, MD421

```
     (Speaker)
      ______
 |___/__UU__\___|
         |||| Cone far
         |||  Cone near
         ||   Edge
         |    Cap
       ->|--|<- 4 inches
```

So each impulse response is the same cab recorded using a specific mic, at a specific distance from the speaker, and in a specific location off-axis.

# Lessons learned

The main lesson for me here is that I should've done this years ago. Spending a few hours doing a deep(ish) dive on a specific topic, leaning into using my analytical mind to form a better mental model on the topic is so valuable, but has for a long time felt like a waste of time. I'm not creating, I'm not moving anything forward, I'm just standing still.

Except I'm not, I'm learning; I'm building a model I can use to move something forward later more efficiently and more pleasingly.

I was astonished at the difference the cab sim made to the VST amps I had. Suddenly everything sits in the mix so much better and sounds significantly better.

Armed with this knowledge I went looking around at what equipment bands and songs I enjoy use (you can find this in Appendix B), and it was nice to see some consistency in the sounds that were appealing to me in those genres.

I'm really pleased I've done this, and I hope that I remember that actively learning (instead of trying to push ahead with progress) is valuable to me and that I do this more often. I guess only time will tell.

### Appendix A: Controlled guitar tone test

Ear training [guitar tone](https://www.youtube.com/watch?v=HoXlNibDzMo).

Using a Les Paul (deep tone naturally) playing classic blues rock through:

 * Mesa-Boogie
 * Marshall
 * Orange
 * Black Star

Everything on rhythm except Marshall sounds wrong to me.

### Appendix B: Guitar tone 

Evaluating songs and bands I like against the equipment they use, to help create starting points for my own tones.

#### Aaron Marshall - Intervals
2016 edition - https://www.youtube.com/watch?v=t9WP55ZIM6w
PRS Custom 50, clean channel
Seymore Duncan pedals

PRS 50 <- 805 <- Vise Grip <- Tuner <- Guitar
(Amp)     (TS)   (Compressor)

2016 Shape of Colour tour - https://www.youtube.com/watch?v=WzZtVIbFo4w
Aristides guitar

2019 edition - https://www.premierguitar.com/articles/29790-rig-rundown-intervals

#### Default / It Only Hurts
https://hornface.com/default-guitarist-jeremy-hora-on-music-longevity-and-the-declining-guitar-solo/
"Egnater Rebel 20 for dirty and Tweaker for clean, two 4X12 cabs"

#### Tantric / After We Go
https://orangeamps.com/artist/tommy-gibbons-of-tantric/
Rockerverb 50 MKII

Turns out they use Orange. They are really bass heavy, "dark midrange" when they kick in. Not sure it's a tone I like.

#### Band-Maid / Just Bring It
4-Stroke 500 (https://orangeamps.com/4-stroke/) for bass
https://www.instagram.com/p/Bd-Ev_wgHxl/?taken-by=kanami_bandmaid
Looks like a Mesa Triple Rectifier for guitar.

#### Skillet / Comatose
Duel rectifier.

#### Exies / Different From You
Sounds like a Marshall, pushed into the mids.

#### Metallica / Enter Sandman
https://www.mixonline.com/recording/classic-tracks-metallicas-enter-sandman-366232
https://shredaddict.com/metallica-amp-settings/

"I could put an SSL compressor across the drums and bass, and I could leave the guitars uncompressed, which is James’ sound. That’s really the biggest part of how the Metallica album sounds; that’s why it has that weight."

Typically a Mesa-Boogie head (Dual Rectifier), with Marshall cab.

#### Megadeth / Youthanasia
https://youtubemusicsucks.com/what-gear-does-dave-mustaine-use/
https://www.thegearpage.net/board/index.php?threads/megadeths-gear.518486/
http://equipboard.com/pros/dave-mustaine

Jackson King V (bridge/neck humbucker pickups)
Bunch of rack mount gear (tonally it's toward the Marshall tube gear)
    Custom Audio Electronics 3+ Preamp
    VHT 2150 (tube) Power Amp

Reports suggest the preamp could be mimicked with a Marshall JMP-1 and the poweramp could be a Marshall EL34 100/100 Dual Monobloc.

#### Exit Ten / Life
http://prod.mi-pro.co.uk/news/read/soundalikes-joe-ward-exit-ten/015968

Strat with Seymour Duncan Alnico ii Pro Zebra bridge pickup
Tele with humbuckers
Line 6 Rotomachine, Boss BD-2 Blues Driver as a lead boost (gain low, level high), delay & reverb
Blackstar Series One 100 amp
Celestion Vintage 30 (12" speakers in typical Marshall cabs)

<!-- Note from 2020-08-15: This was posted today, just to capture some random notes I had bubbling around -->