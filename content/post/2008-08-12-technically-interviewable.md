---
title:  "Technically interviewable"
date:   2008-08-12 12:00:00
categories: interview
---

Turns out I made a decent enough impression on the phone interview to warrant the travel expenses and face to face. I can see why you'd want to check someone out beforehand - with two interviewers and 3 hours out of their day!

There were plenty of things I think I missed, and equally plenty of things I could have done better. The technical questions came in three parts: a dodgy bit of C code in the style of "what does this do?" and "why is it broken?"; an empty flow-chart representing an ISR with a pre- and post-FIFO action area, again in the style of "if you had to guess, what does this do?" and "why do we use a FIFO buffer?" followed by "how would you implement a buffer?"; then finally a pretty naked GUI and "how would you go about debugging this and ensuring that it works properly?".

The C was interesting, ditto the FIFO. I did not excel at either, but I learnt a lot (always make a point of saying how much you'd like to learn - I didn't).

<pre>
{% highlight c %}
int m;
...
m = orange("Hello world",0);
...
int orange(char* input,n) {

if (*input == A_CHAR)
  return n;

return orange(input++,n++);
}
{% endhighlight %}
</pre>

Using a tail (?) recursion to iterate through a string to locate a match with A_CHAR (some constant, could be A, could o ... we talked it through with e). What's interesting is that I didn't pick up the faults when I read the code. input++, for example should be ++input, and the will actually cause a stack overflow. To say nothing of the fact that using recursion for a problem like this is a silly idea, I think I gave the "right" answer when I said I'd be using a for loop.

Interestingly enough, a ring buffer works similarly. When you increment the pointer past it's maximum value, it causes an overflow and loops around.

Ring buffers are used where us hardware guys use FIFOs, to relieve pressure on the processor. Not to cross clock domains, which I said very proudly.

All in all it went as well is it could do. Some notes to take away from this:


*  If you put "fluent in web design" on your CV you better damn well have a portfolio to back it up.

*  Writing down "good at lateral thinking" is tantamount to wearing a T-shirt saying "Lateral Thinker" and "ask me what I've done!".

*  Ditto anything to do with tradeoffs.

*  Always express the reason for moving companies as "because I'm not growing there" or "because I feel there's so much I could learn". Never "because the moneys running out".

The latter may or may not be true, but having reflected on the process I've just been through, I would remember less cringe-worthy moments if I abided by that.

Still, as they say, practice makes perfect! Let's see if I get in to round 3.
