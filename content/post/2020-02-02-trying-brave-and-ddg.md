---
title: "My second digital life: trying Brave and Duck Duck Go"
date: 2020-02-02 17:17:00
categories: life design, privacy, security, second digital life
---

*Part of an ongoing series exploring my digital life, starting with ["Designing my digital life (again)"]({{< relref "2019-06-27-designing-my-digital-life.md" >}})*

Thinking about privacy and surveillance as I did [here]({{< relref "2019-10-10-privacy.md" >}}) began as an emotional reaction to [Inbox being shut down](https://killedbygoogle.com/), but the approach I took with the privacy topic could also be viewed as a somewhat academic exercise to explore an idea.

As a more practical exercise to understand what “let Google see less of me” looks like, I figured I would try to make changes to *ensure* that Google sees less of me.

So in early June just before I sketched out the wider vision of this project, I made a deliberate switch away from Chrome and Google Search and over to Brave and Duck Duck Go. The small remnant of scientist in me isn’t wild about changing multiple variables at the same time, but I’m not interested in performing a rigorous study on the technical impact of browser and search switching, only how it makes me feel.

## Prepping for the changes

Making the decision to move was pretty easy once I'd internalised the desire to spread my digital footprint out a bit, and after a brief cruise around (via Google Search, of course) I chose to try a self-purported “privacy-focussed browser” in the form of [Brave](https://brave.com/), from Brendan Eich of Firefox fame. It helps a lot that it’s based on [Chromium](https://www.chromium.org/), which makes everything very familiar and the plugins perfectly compatible, but without as much Google lurking in the background.

What I knew was that I use tabs. I have a collection of bookmarks. I use the profiles feature with different profiles for work and home. This links nicely with bookmark syncing and tab syncing, and gives me a way to connect personal browsing on my work laptop and where I need to, connect work browsing on my home laptop.

In an ideal world there exists a nice connection between my personal laptop browsing and my personal mobile browsing as well, such that I can share tabs between devices. In reality I found sharing tabs between laptop and phone a bit wafty, although the bookmarking share was pretty reliable.

Installation imported my bookmarks, setting up profiles gave me the same bookmark isolation between personal and work as I had in Chrome. I took the opportunity to reevaluate the plugins I’d installed in Chrome, and transferred only a handful.

## Reflections

Having gotten everything ready, time to take the plunge and actually try and use Brave and DDG in real life.

### Tab and bookmark synchronisation

I tried to set up bookmark sync, but it just failed miserably. While I liked the decentralised nature of the sync chain (ala Resilio Sync) over creating more accounts on other people’s services, the chain between home laptop, work laptop and phone just didn’t hold together and I ended up with bookmarks showing up after I deleted them, or folders of bookmarks getting moved around.

Tab synchronisation is not yet a thing in Brave, although there is [an open feature request](https://github.com/brave/brave-browser/issues/4412) for it, it’s just not there.

I have looked at a few different stackoverflow posts on how to manually export bookmarks for syncing with a 3rd party solution like Resilio Sync, and there are some ways of doing it, but it wasn’t important enough to go through the development activities to get it right.

### Replacing Google Search

I thought I’d have trouble living without Google Search, but having been running with [DuckDuckGo](https://duckduckgo.com/) for 6 months, I can honestly say I haven’t felt any difference. The interface is clean, with fewer top-line adverts, but the neat features like maps when you search for places and checking out images all work. DDG doesn’t have the suggestions that Google offers up, but I haven’t missed them, and I don’t mind not having a piece of tech try to second guess what I’m looking for.

It feels very much like the Google Search I knew from 10 - 15 years ago, which I am not unhappy about. Wow, now I feel old.

### Ad blocking and Brave Rewards

The ad blocker seems fairly effective, and it’s been nice not to have everything in my face anymore, but that’s not a uniquely Brave feature. More interesting (and more controversial) is the idea that the browser can make payments to content creators based on your attention to that creator. This is the premise behind [Brave rewards](https://brave.com/brave-rewards/).

Adverts (and data tracking) on the internet are a practice that’s not exactly new, and the attention economy (or surveillance capitalism) is big business (a [$240 billion](https://www.industryarc.com/Research/Online-Advertising-Market-Research-500626) in internet marketing and advertising). The spectrum of views on this span from vehemently against ads and tracking on philosophical grounds (the internet should always be free!) to vehemently desiring free speech on practical grounds (ads are a reality and I should be able to put ads on things I control!).

I come from an internet that was predominantly volunteer work, and server hosting costs were small enough for the amount of traffic I was dealing with that it didn’t leave much of a mark, so while I get well managed and structured inline adverts, I find pop-overs, interstitials and the more obnoxious ads very unpalatable. I’ve already written about my feelings on targetted adverts and in general, I find them less annoying than I thought I would, but with the ad-blocker turned on it was glorious not having a ton of extraneous boxes cluttering up pages and articles I was reading. Even more so when those boxes are animated in the middle of some textual flow.

There are people who are very strong in their beliefs that [Brave is a terrible thing](https://github.com/lobsters/lobsters-ansible/issues/45), and Brave rewards are the antithesis of a free internet. Following the [links offered](https://news.ycombinator.com/item?id=18734999) makes the case more and more compelling that swapping the existing ad ecosystem for a new one isn’t the way forward. But it’s a complex, multidimensional problem, and there’s [some support for attempting to change the status quo](https://news.ycombinator.com/item?id=21525592).

A friend shared this [great article](https://practicaltypography.com/the-cowardice-of-brave.html) that dissects the issue, and the author’s [view of adverts](https://practicaltypography.com/vote-with-your-wallet.html), even from 2015, articulates some of the complexities of ads and publishing.

I am so very conflicted in my beliefs here. On the one hand I believe information should be free and not hidden behind paywalls, such that any individual with a sufficient amount of curiosity can learn unbounded. On the other hand, it costs money to educate and inform and I believe everyone should be able to be paid for their efforts. How can I have my cake and eat it? I’m so used to the web being free, and I’ve been brought up to be frugal, it’s hard to reconcile the conflict between my personal integrity and habit; so I end up doing nothing because it’s easy.

This whole area is definitely one to return to later while rebuilding my digital life.

### Home pages and stats

At home I use the wonderful [Momentum dashboard](https://momentumdash.com/) as the new tab window, but by default Brave has a little dashboard of it’s own. It displays most-often opened sites and some stats including number of ads and trackers blocked, number of HTTPS upgrades performed and even how many minutes you’ve saved. It’s been quite fun to see the stats over time!

## Results and next steps

An interesting side effect of doing this is that I have found it really useful to have two separate browsers for personal and work things when running on the work laptop. You end up with two icons in the task bar, and it’s much easier to avoid any unintended leakage between the work and personal domain, in both directions. When at work I know that using my work browser means doing my work, and I can close, hide, or move the personal browser out the way, and at home, I just don’t go near the work browser. Sandboxes for browser applications like [Shift](https://tryshift.com/) are extensions of that idea, and [“browser compartmentalisation”](https://www.fastcompany.com/90311396/incognito-mode-wont-keep-you-private-try-browser-compartmentalization) is one of the original articles that sparked some of this project.

Finally, this experiment has taught me a few things:

 * I didn’t miss Google Search or Chrome as much as I thought I would.
 * I will need to reconcile the competing concepts of information-should-be-free and publishers-should-be-paid, mixed with my inherent laziness eventually.
 * Data makes me feel good, I should do some work on gathering data that’s important to me.
 * Browser compartmentalisation has been a useful part of how I work.

During this writeup I got pointed to the [the NY Times Privacy Project](https://www.nytimes.com/interactive/2019/opinion/internet-privacy-project.html) which looks like a really great resource that I’ll be diving into. I’ll definitely continue to use DDG, but I’m not shying away from Google Maps. It’s not all or nothing here. Browser exploration is definitely on the cards since I’m just not quite sold on Brave Rewards. So I need to evaluate some alternative browsers (I hear good things about [Vivaldi](https://vivaldi.com/)). I’d also love to understand the pros/cons of compartmentalisation with respect to adverts, tracking and my workflows.

*Continuing gratitude to my friends who are accompanying me on this journey for their consultation, proof-reading and additional research.*