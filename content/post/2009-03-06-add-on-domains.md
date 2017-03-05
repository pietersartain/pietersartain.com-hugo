---
title:  "Add on domains"
date:   2009-03-06 12:00:00
categories: web tech
---

The difference between addon domains and domain parking is important. Which is why I first titled this post "parking", 'cause I got 'em confused. You will, however, have to go elsewhere for [a different sort of parking](http://www.imdb.com/title/tt0088763/quotes).

An addon domain is a cheeky way to host multiple websites without the hassle of multiple hosting fees, or worse, a dedicated server.

Because I totally forgot how to set these up, these are specific instructions when you have a hosting plan with [lunarpages](http://www.lunarpages.com) and one or more domain names with [namesco](http://www.names.co.uk).

On Lunarpages (using cPanel):
 1.  Go to "Addon domains"
 2.  New domain name (minus the www)
 3.  New subdirectory (ensure this doesn't conflict with any directories in the root)
 4.  Password (for FTP)

This will create a subdirectory of $SUB, a subdomain of $SUB.pesartain.com, an ftp account of $SUB@pesartain.com and a password of $PASS.

On namesco:

 1.  Set the primary & secondary nameservers to ns6 and ns7.lunarpages.com.
 2.  Update the records to read:

    .$domain -- A record -- 74.50.26.50 (shared IP)
    www.$domain -- CNAME -- $domain

That should be it. Using the lunarpages nameservers, the addon domain is pointed to the subdomain, and no one is ever the wiser.
