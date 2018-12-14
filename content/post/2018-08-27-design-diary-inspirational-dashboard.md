---
title:  "Design diary: inspirational dashboard"
date:   2018-08-27 17:00:00
categories: personal development, code, making, design diary
---

I love [Momentum](https://momentumdash.com/), the Chrome plugin, that welcomes me to each tab I open. I don't use all the bells and whistles it offers, but I really really value the calming image and inspirational quote, along with the welcome reminder.

I'm spending more and more time on small screen Android devices these days, though, and I really wanted to carry this idea over to those devices. Unfortunately, you can't use Chrome plugins on Android!

So I spent some time building a simple homage version of this called Impulse. You can find the code in the [Impulse repo on Github](https://github.com/pietersartain/impulse).

This is a bit of a design diary to capture some of the thoughts I had as I was making this, and note a key practical lessons to remember for those real projects when they swing by!

## Design goals

The intent wasn't a complete duplicate of Momentum's functionality, but just the backgrounds, the quotes and the time. It needed to be fast to load and easy to host.

Things I didn't care about included live configuration, background/quote history or even an ever expanding list of quotes.

## Design thoughts

The obvious design is a server-side clone of Momentum, which opens up all sorts of exciting development possibilities working with APIs and full projects and so on ...

... but means lots of moving parts, increased complexity, additional hosting costs and doesn't even meet the stated design goals! So lots of fun but not necessarily practical.

Various thoughts ran through my brain about serverless options, but it still seemed like a lot of complexity for the original goal.

After some more mulling, it seemed the most sensible option was to aim for a single page that could be sent as one hit down the wire. Once this page is cached locally, it should be super-fast for every other retrieval, and we can use localStorage to figure out if the day has changed and we need to load different images.

This meant I was making some sort of static page, probably out of templates, and I needed to embed the list of quotes and a batch of images somehow. This would require some code to assemble all the pieces (compile?) into a single html file that could be deployed somewhere.

## Lists of things

I started my investigation with images, because this felt like the biggest unknown factor for me. I knew I needed a bigish list because I didn't want to feel like I was going over a 5 day loop. 365 would be about the right number. My initial thought was to use the static set of images from something like the Chromecast, which is floating around, but it was just one more thing to host and it felt like I'd be better off putting them up somewhere and pulling them in more dynamically when I needed, relying on the local browser cache not to burn through bandwidth of external services.

My two problems (sets of images and external hosting) were solved pretty quick when I found that a) Flickr can be used as a photo hosting site (with various methods of retrieving the images) and b) the awesome Momentum people have some lovely galleries, already on Flickr!

I started investigating the Flickr public RSS feeds and parsing them from XML to JSON with Yahoo's YQL ... and then realised that the public feeds can be configured to just spit out JSON directly. Alas, I was only getting a handful of photos, and it seemed hard to extend if I wanted more, potentially from different sources in the future.

I looked at using the API directly from Javascript, but I didn't like the idea of constantly hitting an API for every request if I didn't have to, and leaving API keys lying around in public spaces makes me feel ick.

Unfortunately to use the API I needed an account, which is a shame, because I deleted mine when I heard about the Yahoo breaches a few years ago. Nevermind.

The quotes was slightly easier, because text. [fortune](https://github.com/bmc/fortunes) is a good option. I scraped from a few different sources, and nabbed some of the Momentum ones for good measure, dumping into a text file. They're all the same format, so easily parsable later.

## Site generator

[make.py](https://github.com/pietersartain/impulse/blob/master/make.py) is made of 3 key parts:

 * Quote files parser
 * Flickr API scraper
 * HTML template parser

The idea behind this is that I only want ONE page to upload somewhere. It doesn't do anything except on page load, so should be little more than an elaborate Hello World!

Given the intermediary goal of building some data that I could dump into the pages, my plan was to dump everything into Javascript and handle that onload. So the first two parts with the quotes and Flickr API are all about creating some Javascript objects that I can literally dump in the page and let the JS do all the work.

Where in most projects I'd have separate files for CSS (in order to use a preprocessor like SASS) and Javascript (just to keep my templates tidy), here I found the amount of both wasn't big enough to worry about. I wrote all the CSS and JS directly into the [template](https://github.com/pietersartain/impulse/blob/master/impulse.tmpl.html) to save bothering about dragging those in.

So, now I've got one file with most of what I need in except the lists to draw from to create the random image and random picture.

That's where the third part, the HTML template parser, comes in. To convert all these disparate parts into one single file. I went through a few iterations of building this, narrowly avoiding concatenating temporary files together with shell script, which is the crazy state I found myself in early on. Somewhere in me I knew that I'd have to suck it up and use a template library eventually, but I found it hard to commit. When I finally got there, I settled on stealing a bunch of Python code and figuring out how to use jinja2 to render the template.

I chucked some switches in make.py to let me resume broken scrapes or use other files I made for testing, and it all came together in the end. The scraping from Flickr isn't super quick, but it's only done once!

I added a spinner in there at some point, which works great on faster connections, but on slower ones really suffers. I think it's because the javascript code that's downloading the Flickr image is running in the same thread as the SVG spinner transform, and so the transform gets stuck. I suspect (but don't know yet) that an animated gif version would work better.

## Lessons

The big lesson I took away here is that the software and code is just a smaller part of my whole experience. Most of the effort goes into maintaining and curating lists (quotes, photos).

To everyone who curates lists and keeps things in neat collections: cheers to you.

On the tech side, as always less is more. The best code is the code that's never written, so trying to kill off every temptation to expand the project or make it more than exactly what I needed was the key to making this work. I'm pleased I focused on the list-building and static-generation parts of the site instead of getting lost down the dynamic API route.

Was the project a success? Sort of. While the actual site generator was very effective and I like the way it all hangs together to deploy as a single page, I couldn't figure out how to set a custom homepage on new tab opening in Chrome! I could get it to open the site on the first new window in an empty browser, but not a new tab!

This makes it somewhat challenging to really declare this project a customer success (even if I am the customer ... ), but I do leave that first tab open, and when I'm feeling like I need a bit of a pick me up, hit the refresh button and enjoy the image, the quote, and the feeling of accomplishment that comes with using something I made.
