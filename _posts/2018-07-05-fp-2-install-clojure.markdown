---
layout:     post
title:      "Learn Functional Programming (2) - Install Clojure"
date:       2018-07-12
categories: functional programming clojure lisp windows
---

My language of choice to learn functional programming is **Lisp**, respectively it's JVM implementation **Clojure**. I'm using **Windows 10** as my main home desktop OS, so let's see how to get Clojure running on that. I might do a Linux one later.

<!--more-->

## Install and run

Official Clojure webpage in section [Installation on Windows] says *"Not yet available - see Leiningen or Boot instead."*[^1]. Hmmmm, not a good start. Let's check [Leiningen]. It's installable via [Chocolatey] with `choco install lein`. After that, command `lein` should be available. You can start REPL with `lein repl`

{% highlight bash %}
$ lein repl
nREPL server started on port 51471 on host 127.0.0.1 - nrepl://127.0.0.1:51471
REPL-y 0.3.7, nREPL 0.2.12
Clojure 1.8.0
OpenJDK 64-Bit Server VM 10.0.1.1-ojdkbuild+10
    Docs: (doc function-name-here)
          (find-doc "part-of-name-here")
  Source: (source function-name-here)
 Javadoc: (javadoc java-object-or-class-here)
    Exit: Control+D or (exit) or (quit)
 Results: Stored in vars *1, *2, *3, an exception in *e

user=> (+ 1 1)
2
{% endhighlight %}

## First project

*Leiningen* takes care of your *Clojure* project in similar way like *Maven* for your *Java* project. You can create new project with `lein new <name-of-the-project>`. This creates new folder with few files and simple directory structure. `project.clj` file is used as project descriptor, you can imagine it like *clojure's pom file*

{% highlight bash %}
$ lein new test-project
Generating a project called test-project based on the 'default' template.
The default template is intended for library projects, not applications.
To see other templates (app, plugin, etc), try `lein help new`.

$ ls test-project\
CHANGELOG.md  LICENSE  README.md  doc/  project.clj  resources/  src/  test/
{% endhighlight %}

{% highlight bash %}
$ cat test-project\project.clj
(defproject test-project "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.8.0"]])
{% endhighlight %}

Nothing unexpected there. `lein new` create library project by default[^2]. To make it runnable, we need to specify main namespace in `project.clj`. We can do that by adding new argument to `defproject` - `:main test-project.core`. Next thing we have to have is main function. Leiningen created some basic source and test files so we can use them. Our main function will be in `src/test_project/core.clj` and will look like `(defn -main [& args] (foo 4))`. It calls already defined function `foo`. Now run `lein run` and see what happens

{% highlight bash %}
$ lein run
4 Hello, World!
{% endhighlight %}

Cool, our first Clojure program!

## Testing

I wan't to look at one more thing, **testing**. I think it's as important as procution code itself. Tests can be run with `lein test`. Leiningen also created example test, which is now failing. Test looks like this:

{% highlight clojure %}
(ns test-project.core-test
  (:require [clojure.test :refer :all]
            [test-project.core :refer :all]))

(deftest a-test
  (testing "FIXME, I fail."
    (is (= 0 1))))
{% endhighlight %}

The assertion is this part `(is (= 0 1))`. It's asking whether `0 == 1`, which is not correct. We can fix it in two ways. We can test `0 != 1` with `(is (not (= 0 1)))`. Or we can test `1 == 1` (or different same integers) with `(is (= 1 1))`. Now the test should pass.


## Conclusion
That's it. We've looked at how to install and run Clojure on Windows. We can create, run and test simple project. It's straight-forward and nothing unexpected there. I'm happy with that as I know that I can test my little projects easily, which will be priceless in the process of learning a language and new paradigm.


[^1]: at the time of writing this post
[^2]: it can use [templates]

[Installation on Windows]: https://www.clojure.org/guides/getting_started#_installation_on_windows
[Leiningen]: https://leiningen.org/
[Chocolatey]: https://chocolatey.org/
[templates]: https://clojars.org/search?q=lein-template