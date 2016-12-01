---
layout:     post
title:      "Java9 - jshell"
date:       2016-11-29
categories: java9
---

Many languages has it's own [REPL](Read–Eval–Print loop). Now time grows to have one in java. It will come with Java 9 under [JEP222]. What does it mean for us, developers? Many of us have already met with REPL in languages like Scala, Clojure, Groovy, Python, Ruby and many more. For the rest of you, it's basically a command line, where you can enter commands for specific programming language.

### Why should I want it?
 - **microtesting** - We always try to get as quick response loop as possible. Now shortest loop is probably _unit test_ or write simple class with main and run. With **JShell** we'll get tool to short and simplify this loop for experimenting.
 - **teach** - You want to show your mom what you do 10 hours a day in front of a computer. So you create a java file and start writing some strange words like `package`, `public`, `void`, `String` and many `(`, `)`, `;`... it's just too much and we didn't event get to compilation. With Java 9 this will get much easier. You write `4+9` hit enter and it prints `13`, easy!

### How it works ###
JShell is new executable binary in `bin` folder. Run simply like this:

{% highlight bash %}
mvala[~/sw/jdk9/bin] λ ./jshell 
|  Welcome to JShell -- Version 9-internal
|  For an introduction type: /help intro


jshell> 
{% endhighlight %}

Now JShell is ready to accept my commands. So let's start simple:
{% highlight java %}
jshell> 1 + 2
$1 ==> 3
{% endhighlight %}

as expected, it can add two numbers. `$1 ==> 3` means that result of previous operation is implicitly stored in variable `$1`. If I explicitly define variable name, it is used instead:
{% highlight java %}
jshell> int i = 2 * 3
i ==> 6
{% endhighlight %}

Now I can work with these variables:
{% highlight java %}
jshell> $1 + i
$3 ==> 9
{% endhighlight %}

[REPL]: https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop
[JEP222]: http://openjdk.java.net/jeps/222