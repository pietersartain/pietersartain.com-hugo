---
title:  "Turbulence"
date:   2009-07-21 12:00:00
categories: web tech
---

What started out as killing time at work has actually gone past the "That's cool" barrier and into something practical. To start at the end first, the template you're now looking at is in a Git repository that's linked to my local development version. Two clicks and I can have what I'm actually working on synchronised and deployed to this shared host without trying to remember what files have been changed and what I can skip uploading again.

It's been a long project because I've had to completely change the way I work and the organisation of 9 years' worth of code.

 1.  Move all the dokuwiki installations into to a farm to centralise the plugins and templates
 2.  Create a local dokuwiki farm and mirror the data from pesartain.com into it
 3.  Rearrange the fileserver to place repositories (git, svn) and content (http, ftp) in sane locations
 4.  Clean up local web content, removing redundant dokuwiki installations
 5.  Create Git repos of the plugins and templates
 6.  Create bare git repos on the fileserver
 7.  Link the fileserver to the development machine with post-commit and post-update hooks (ensuring the fileserver is always up to date)
 8.  Write a web interface for git to pull from my local fileserver

And that's just the shortest path. Along the way I sorted out my hosts file to give me some sensible PC names, fixed up the fileserver's share directories, added a second SSH server to the fileserver (one for internal, one for external) and did the washing up.

A huge thanks to Matt H for his help with cleaning up my act and getting going with Git, and his writeup on multiple SSHD servers. He is a very patient man who deserves more beer.

I have a more in depth writeup on it's way, and then it's on to some of the next projects, using this new super slick work flow.

Enjoy the template!

