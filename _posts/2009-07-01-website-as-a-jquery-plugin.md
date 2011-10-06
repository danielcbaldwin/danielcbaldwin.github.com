---
layout: post
title: Website as a jQuery Plugin
category: technology
---
I recently had to build a site that ran mainly off of jQuery and I had the whole thing working from one script.js file that just had a lot of functions in it with some global functions defined at the top. The more I looked at this mess of a file the more I felt disappointed with myself that I had allowed myself to code so horribly.

So I went on a mission to turn the entire site into an object. I tried many different ways, including Javascript’s built in prototyping, but nothing seemed to turn out as nicely as I would have hoped. So I had the crazy idea of turning the entire site’s code into a jQuery plugin. Well it has worked out very well and even though it is a it of a weird thing to do I have taken to making site that use a lot of javascript into jQuery plugins.

The problem for me is that what was outlined on the jQuery documentation wasn’t all that helpful and I found that using existing plugins to figure out how the plugins were being built was a lot more helpful but also confusing as there seems to be a nearly unlimited amount of ways to make a plugin. So after searching around for a while and a bunch of trial and error this is what I ended up with:

<script src="https://gist.github.com/373211.js?file=gistfile1.js"></script>

I find that I like to call the plugin after the site, e.g. jquery.danielbaldwin.js, and I name the function accordingly. I have found that having all the javascript for a site in one object has helped me to build sites that are more complex, can have persistent variables easily, I can set settings that can be changed just by changing a 1 to a 0, and I feel like my code within the object becomes so much cleaner and more legible.