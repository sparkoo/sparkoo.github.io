---
layout:     post
title:      "Java9 - jshell"
date:       2016-11-29
categories: java9
---

Many languages has it's own [REPL](Read–Eval–Print loop). Now time comes to have REPL in java. It will come with Java 9 under [JEP222][JEP222]. What does it mean for us, developers? Many of us have already met with REPL in languages like Scala, Clojure, Groovy, Python, Ruby and many more. For the rest of you, it's basically a command line, where you can enter commands for specific programming language.

### Why should I want it?
It is great for _microtesting_. We always try to get as quick response loop as possible. Now shortest loop is probably **unit test** or write simple class with main and run. With **JShell** we'll get tool to short and simplify this loop for experimenting.

### How it works ###
JShell is new executable binary in `bin` folder. Run simply like this:

{% highlight bash %}
mvala[~/sw/jdk9/bin] λ ./jshell 
|  Welcome to JShell -- Version 9-internal
|  For an introduction type: /help intro


jshell> 
{% endhighlight %}

Now JShell is ready to accept my commands.

[REPL]: https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop
[JEP222]: http://openjdk.java.net/jeps/222