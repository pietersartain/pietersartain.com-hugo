---
title: 'The uncertainty continuum'
date: 2018-07-04 23:37:00
categories: mental models, agile
---

# The uncertainty continuum

We're sitting in a meeting room having another conversation about the project, and for the 3rd time someone says "but what about ...?", which leads us predictably back to the start of the meeting. Finally, after an hour or so, we give up going round in circles and dejectedly head back to our desks to execute on some small stories that we did manage to scope out, but without any of the real enthusiasm that this exciting project should offer. As the product owner you're frustrated that progress isn't being made, and the rest of your team are frustrated they can't get anything productive done.

If that story sounds familiar, you might have a team who are stuck trying to make sense of a vague project.

## Deer in headlights

We know that our companies can conjure up all sorts of things they'd like to try, and when first moving a team to agile or when you have an immature team, you tend to start small and chunk up the work to be done into lumps that are neat and gift wrapped.

These projects are probably iterations of an existing product, so your team have a pretty good handle on what needs to be done to add your checkbox, tweak the upload process or otherwise squeeze in the extra functionality you know will make your customers happy.

So you do a few of these, your team is flying, knocking it out the park, and then you think, let's go for something bigger. Big enough that you don't really know how to chunk it up, and so you enlist the help of your team (not least of which because they've been complaining they want something juicier to work on!) ... who promptly turn into deer in the headlights when confronted with conflicting, uncertain, requirements and no clear route forward.

Unfortunately, you've run into a learning curve problem, that will clash with some basic expectations, to create a morale issue:

1. By chunking up easy work without exposing your team to how the project has gotten to that state, you've taught them to expect things neatly packaged, and so they haven't had to learn how to deal with large uncertainty or how to create a plan from nothing.
2. Software teams like building things with software. This is what they're trained to do, what they're good at and what in most cases we need them to do. Make changes, execute on ideas. Vague projects are about everything *except* building things, and especially not the software things they're used to.

So, the team will desperately be looking to you to help them figure out what to build, but you don't know either. So they'll be disappointed, and slowly disengage, which is exactly the opposite of what you were hoping for out of an open ended project!

This sets up a feedback loop, where the more you try to help, the vaguer the project gets (because you don't know the answers!), the less engaged your team, the more you try to help ...

Thankfully, this cycle is very breakable, once everyone knows what their job actually is.

## Project types

Enter the uncertainty continuum. I don't know exactly where this came from or how the name got coined, but it's been a useful tool to help engineers who are stuck, visualise where they are on the path to getting to build something.

So the typical packaged project (what you might call a "high clarity" project) looks much like this, as far as proportions of work go:

 Existing knowledge  Learning Building
|-------------------|--------|---------|
                   70%  100%  0%   100%

At worst, the team knows around 70% of what's needed to get going, so they only have a 30% of learning to do during your project, and the rest of it is about building.

Note that the learning and building phases are about the same size, so in real terms this is a project where 50% of your sprint time is taken up by spikes to answer some tricky questions, probably technical ones, because this is a low maturity team who maybe don't know how to frame other kinds of questions.

Think about the last time you spent that much time investigating compared to just tweaking and implementing your new feature!

If that's a best case, what does an uncertain project (also: vague or "low clarity") look like in this model?

 Existing  Learning            Building
|--------|--------------------|---------|
      30%               100% 0%   100%

Yikes. Nearly twice as much clarification as there is building. No wonder your team is frustrated by the lack of building!

## If you wanted to get to there, you wouldn't start here

Broadly, a high clarity project has only two steps, that you're familiar with because you've done them a lot:

1. Include some spikes in the backlog to figure out some details before you start building
2. Start building, figure out the rest as you go

Step 1 gets the team from 70% known to 85% known, say, and step 2 does the rest.

In a low clarity situation, however, to start a normal project you need to bridge the gap between the 30% of what you do know and the 70% of what you need to know.

Performing this is something of a different exercise, but the goal in this low clarity situation is simple: to articulate a problem that can be solved by the team's normal methods. Eg: get back to what we know!

Remember at school, writing a history essay, but you didn't really know what the question was so you wrote your own question and then answered that because you knew it? Or more topically, when a politician doesn't answer the question posed by a reporter, but he states a different question in his response and then answers that?

This is like that.

1. *Assess the appetite for scope.* The problem is vague, so probably big and hairy, but how far does the business really want to go with this? If you only have 3 months to do something before the market changes, this will change your view pretty quickly. This also often isn't made clear up front, so you can end up with a team who see a deadline but aren't moving, so you have to drive them ("oh, we're being told what to do again") instead of a team who have another engineering constraint to work with.
2. *Identify conflicts.* Vagueness can sometimes also take the form of having many things to do at once, or there being some other requirements that need to run in parallel. This is where priority gets surfaced, and you should start seeing not just one big vague problem, but several distinct problems, which can each be solved separately.
3. *Gather and cull definitions of the "vague project".* You know if this is a 3 month or 12 month investment and you've got some clues as to which part is which, so you can start to think about what the _question_ should be that you're attempting to answer, or what the statement about what you're doing is. It could be one thing, it could be many things, but either way gather a ton of ideas for it, and discard most of them based on whatever constraints you do know. The trick here is to remember that a) you're looking at a bigger jigsaw puzzle than you're used to and b) you don't need the answers yet, just the questions.
4. *Play back the plan.* Get the team to articulate what questions they plan on answering to address that original need. Now we have a collection of projects, which all interlink, and you can talk about priority of each of those pieces.

Whew. Finally we're on familiar territory. Now all we have to do to get back to what we know is ...

5. Include some spikes in the backlog to figure out some details before you start building.
6. Start building, and figure out the rest as you go.

The trick to doing this successfully is that you want to constantly ask how this ties back to the original vague starting point, and you might discover that actually, it wasn't the right way of thinking about it. You know what though? That's okay. Redefine the questions until you've got something that represents your intent.

One final note: as you move through the continuum from low clarity to higher clarity your tools will change. During the build phase you'll be all about your IDE and the code. Before the build phase, at that 70% learning phase, you might be busy with a debugger and Jira, working out scoping and tinkering with some technology. But before all that, in low clarity situations, you and your team need to understand that it's about paper, pens, and other people. Write everything down, get ideas together, destroy them together, and talk to everyone you can think of who might be able to answer your questions.

If you still don't have an answer to a question that you need before you start in on the building, you might need to design an experiment, but that's a discussion for another day.

