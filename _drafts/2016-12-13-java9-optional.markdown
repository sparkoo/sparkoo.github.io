---
layout:     post
title:      "Java 9 Optional improvements"
date:       2016-12-13
categories: java9 optional api
---

**Optional** was introduced in Java8. It became very useful to define cleaner APIs, where we can define whether return value from method can be null. Another usage is alternative syntax to `if` statement and we would find more. *Optional* has got 3 new methods in *Java9* so let's look what new we can do with it.

<!--more-->

![optional]({{ site.url }}/assets/j9-optional/optional_doc.png)

## Optional\<T\> or(() -> ...)

`public Optional<T> or(Supplier<? extends Optional<? extends T>> supplier)` is whole declaration of method. What does it mean?

First of all, it returns `Optional<T>` so we don't get value but another *Optional*. To simplify it, we could rewrite it with ternary operator

{% highlight java %}
Optional<String> resultOpt = opt1.isPresent() ? opt1 : opt2;
{% endhighlight %}

Now we can do this
{% highlight java %}
Optional<String> resultOpt = opt1.or(() -> opt2);
{% endhighlight %}

If `opt1` is empty, in `opt2` is stored to the `resultOpt`. In case it isn't empty, `opt1` is stored there. Let's try it in [JShell]

{% highlight java %}
jshell> Optional<String> opt1 = Optional.of("hello")
opt1 ==> Optional[hello]

jshell> Optional<String> opt2 = Optional.of("world")
opt2 ==> Optional[world]

jshell> opt1.or(() -> opt2)
$3 ==> Optional[hello]

jshell> Optional.empty().or(() -> opt2)
$4 ==> Optional[world]
{% endhighlight %}

So it's little shorter and cleaner, nice. 

But I think that real power is in `Supplier` parameter. That means that if we call `or` on empty *Optional*, we can execute any code that gets us some *Optional* and of course it's executed lazily

{% highlight java %}
jshell> opt1.or(() -> { System.out.println("this is never executed"); return opt2; })
$5 ==> Optional[hello]

jshell> Optional.empty().or(() -> { System.out.println("now it is executed"); return opt2; })
now it is executed
$7 ==> Optional[world]
{% endhighlight %}

As you can see, in the first case, text is not printed so that potentially time consuming computation isn't executed when not needed. In second case, when it's called on empty *Optional* it's executed.

### NullPointerException

`or` method throws `NullPointerException` in few situations so lets check that.

**1]** when parameter is `null`. It doesn't matter whether it's called on non-empty *Optional*

{% highlight java %}
jshell> opt1.or(null)
|  java.lang.NullPointerException thrown: 
|        at Objects.requireNonNull (Objects.java:221)
|        at Optional.or (Optional.java:292)
|        at (#8:1)

jshell> Optional.empty().or(null)
|  java.lang.NullPointerException thrown: 
|        at Objects.requireNonNull (Objects.java:221)
|        at Optional.or (Optional.java:292)
|        at (#12:1)
{% endhighlight %}


**2]** when provided `Supplier` returns `null` and it's called on empty *Optional*

{% highlight java %}
jshell> Optional.empty().or(() -> null)
|  java.lang.NullPointerException thrown: 
|        at Objects.requireNonNull (Objects.java:221)
|        at Optional.or (Optional.java:298)
|        at (#10:1)
{% endhighlight %}

It's ok if `Supplier` returns `null` when called on non-empty *Optional*

{% highlight java %}
jshell> opt1.or(() -> null)
$9 ==> Optional[hello]
{% endhighlight %}


In these 2 cases, `NullPointerException` is thrown. If it's called on empty *Optional* and supplier return another empty *Optional*, it's perfectly valid code

{% highlight java %}
jshell> Optional.empty().or(() -> Optional.empty())
$11 ==> Optional.empty
{% endhighlight %}

## Stream\<T\> stream()

[JShell]: {{ site.url }}/java9-jshell-1/