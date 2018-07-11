---
layout:     post
title:      "Learn Functional Programming (1) - What, how and why?"
date:       2018-07-05
categories: programming functional fpp
---

End of procrastination! I want to learn **Functional programming** (FP). I want to learn neural networks, genetic algorithms. I want to develop my own programming language (No! Not another new language. I just want to know how these things works...). These are not easy tasks and I was procrastinating about them for too long. So just let's do it!

<!--more-->

This should be first (and hopefully not last) in a series of blog-posts about how I'm learning functional programming. I want to show you the process, thinking, struggles and little victories. It's also tool for me, to learn it better by explaining.

I can't do all things at once and in my limited free time I need some system. So lest learn FP first. Why anyone would want to learn FP? I'm trapped in objects of Java world and I think that FP can open new ways of thinking about problems. Yes, we have lambdas since Java 8, but let's be honest... it still looks like it's hacked inside (which it really is) and it's just tip of real FP. Few years ago I've been learning Scala. It's fully functional language, but it's also fully object oriented language. You can do anything in Scala, and in my opinion, it's the worst thing about Scala. It doesn't set you barriers and you can write same code in many different ways and you often don't know which one is better. Just to many options. I need something that is not as limited in FP as Java, and something that is not as limitless as Scala.

![clojure]({{site.url}}/assets/fp/1/clojure-logo10.png){:height="100px" style="float: right"} I need pure functional language. I want strict limits with no backups. I know *Lisp*[^1] and *Haskell*. Coming from Java world, let's go with *JVM Lisp* implementation - **Clojure**. Ok, I have a language. Now I need some way how to learn it. I can read some tutorials, do some online course, read a books... Tutorials might be clumsy and without clear structure and goal. You can also easily drop into procrastination while browsing web. Online courses quality differs and looking to videos is not the best way to learn. Books should provide compact package of knowledge and reading and trying is the most effective way to learn. Of course I'll need a good book. I want to do it properly so let's not focus just on the language. Choose something strong with as complete knowledge as possible, proven by time. What might be better than **[Structure and Interpretation of Computer Programs]**? It should have all qualities I want and as a bonus, it's free online. There's also this great [github repo], where the book is available in many formats.

[^1]: As I found out, Lisp is note pure functional language.

[Structure and Interpretation of Computer Programs]: https://mitpress.mit.edu/sites/default/files/sicp/index.html
[github repo]: https://github.com/sarabander
[pure functional language]: https://en.wikipedia.org/wiki/List_of_programming_languages_by_type#Pure