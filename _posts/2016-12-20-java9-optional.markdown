---
layout:     post
title:      "Java 9 Optional new API"
date:       2016-12-20
comments:   true
categories: java9 optional api
---

**Optional** was introduced in Java8. It became very useful to define cleaner API, where we can define whether return value from method can be null. Another usage is alternative syntax to `if` statement and we would probably find some more. *Optional* has got 3 new methods in *Java9* so let's look what new we can do with it.

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

But I think that real power is in `Supplier` parameter. That means that if we call `or` on empty *Optional*, we can execute any code that gets us some *Optional*

{% highlight java %}
jshell> opt1.or(() -> { System.out.println("this is not executed"); return opt2; })
$5 ==> Optional[hello]

jshell> Optional.empty().or(() -> { System.out.println("this is executed"); return opt2; })
this is executed
$7 ==> Optional[world]
{% endhighlight %}

As you can see, in the first case, text is not printed. In second case, when it's called on empty *Optional* it's executed. For example we can call some other service to get the value.

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


So in these 2 cases, `NullPointerException` is thrown. 

But, if it's called on empty *Optional* and supplier return another empty *Optional*, it's perfectly valid code

{% highlight java %}
jshell> Optional.empty().or(() -> Optional.empty())
$11 ==> Optional.empty
{% endhighlight %}

## Stream\<T\> stream()

When you're familiar with stream, this one is easy. If *Optional* has a non-null value, you'll get stream with that one value, otherwise empty stream. Then you can use all stream methods as you're used to. It's same like if you have a collection with one or no element and call `stream()`.

{% highlight java %}
jshell> Optional.of("Hello").stream()
.filter(s -> s.length() > 2).forEach(s -> printf("%s", s))
Hello
jshell> Optional.of("Hello").stream()
.filter(s -> s.length() > 8).forEach(s -> printf("%s", s))

jshell> Optional<String> o = Optional.empty()
o ==> Optional.empty

jshell> o.stream().forEach(s -> printf("%s", s))

{% endhighlight %}

In first 2 examples I have an *Optional* with `"Hello"` string inside. I'm using stream with filter method. First case pass filter condition and prints `"Hello"`, second case don't pass through filter.

In last example I have empty *Optional* so even if I simply run `forEach` with print, nothing is printed and no exception is thrown, because stream is empty.

I see `.stream()` useful especially in case when you want to get collection of optionals so you can `flatMap` these optionals. Also joining streams of *Optionals* might be sometimes handy.

## ifPresentOrElse((element) -> ...), () -> ...))

This one I really missed in Java 8. You have an *Optional* and you want do something if value is present and something else if not. In my opinion very basic requirement I want from *Optional*. Typically when I get *Optional* from service and I want to do something with returned object and log in case of no object was found. So far I have to do something like this
{% highlight java %}
Optional<User> foundUser = service.findUser(id);
if (foundUser.isPresent()) {
    System.out.println(foundUser.get().getUsername());
} else {
    System.out.println("user [" + id + "] not found");
}
{% endhighlight %}

which doesn't add any value as simple `foundUser != null` would do the same job. But now it looks much better
{% highlight java %}
service.findUser(id).ifPresentOrElse(
    (u) -> System.out.println(u.getUsername()),
    () -> System.out.println("user [" + id + "] not found"));
{% endhighlight %}

I've got rid of unnecessary `Optional<User>` variable.

## Conclusion
*Optional* has got 3 new methods. I think most usage will find `ifPresentOrElse`, which I really missed in Java 8. `stream` and `or` are also nice enhancements, but in my opinion not so important as `ifPresentOrElse`. They'll be useful in more special cases.

[JShell]: {{ site.url }}/java9-jshell-1/

{% if page.comments %}
<div id="disqus_thread"></div>
<script>

/**
*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://sparkoo-github-io.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}