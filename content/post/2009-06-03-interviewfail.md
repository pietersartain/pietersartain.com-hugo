---
title:  "Interviewfail?"
date:   2009-06-03 12:00:00
categories: interview
---

Interview over. I walked out feeling like that was a total fail. It didn't help that I got a bad case of the nerves just an hour before I was due to start.

Anyway, the technical test was interesting. Turns out I revised all the wrong topics. There was a confusing recursive program (as they always are) which contained a snippet similar to:

<pre>
{% highlight c %}
if (a == 1)
	if (b == 1)
		printf("[1] a: %d / b: %d\n");
		return;
	else
		printf("[2] a: %d / b: %d\n");
		return;
if (b == 1) 
	...
{% endhighlight %}
</pre>

Having just written a test procedure to see exactly what happens, I can say with reasonable authority that this will fail to compile. The else has no braces. Unlike my thinking which went something along the lines of "if a one-line *if* executes the line below, and that's a one-line *else*, so which *if* does it apply to? " which is clearly wrong.

Fail number two and three were related to "what are ... " questions:


*  What is a union? [Struct vs union](http://technopark02.blogspot.com/2004/10/cc-structure-vs-union.html.html)

*  Explain re-entrant. [Re-entrant code](https://en.wikipedia.org/wiki/Reentrancy_(computing))

Nyeah. I got neither of those right. I had expected to discuss the test, but it turned out it was an exam style and someone was going to look at those answers at some future date.

The best fail was the "Please explain why you want to work here and how your experiences and attributes can contribute to our company."

I was a sentence in and my time was up (45 minutes for a C test and a horrendously long application form), and just as I started the second sentence my brain reminded me that this was an interview and you were keeping the interviewer waiting.

I wrote complete gibberish.

The personal section was okay. We discussed a lot about my current place of work and how that operated. The CTO who ran the interview was an extremely good poker player, and keen to probe me on how I work and what sort of modus operandi I have regarding learning things. The biggest comment was the lack of commercial experience I had, however, he did admit that was a chicken and egg situation and that sooner or later someone has to give me that experience.

The agent was keen to reassure me that they play their cards very close to their chest and regardless how it may seem all was not lost.

What did I learn from this experience? Technical knowledge and past history is something that you need to be truthful about, because you will be asked about it. Not new knowledge, but worth being reminded of it. More important than that for job hunting is that you need to be enthusiastic about the post you're applying for. If you're not prepared to say yes to an offer, then don't apply.

This little snippet of understanding is following on the heels of what another agent has talked to me about before, that it's worth being picky with the jobs you apply for, because otherwise you'll end up with a CV full of 6-month posts.

My 6-month stint with my current employer doesn't look great on my CV, but people understand when I explain I've been with the same group since I left university.

I won't hear about this position for another week at the earliest. So time to get back in the saddle and find something that looks really cool.
