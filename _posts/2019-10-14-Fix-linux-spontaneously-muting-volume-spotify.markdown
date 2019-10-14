---
layout:     post
title:      "Fix of linux spontaneously muting Spotify volume"
date:       2019-10-14
categories: fix linux fedora volume spotify
---

I use Spotify client on Fedora Linux. Last few weeks, my volume control keeps muting the Spotify (actually move volume to 0%).

<!--more-->

![Volume control]({{ site.url }}/assets/2019-10-14-Fix-linux-spontaneously-muting-volume-spotify/volume.png)

I couldn't find any reason on pattern. By googling it, it looks like it's caused by some pulseaudio module, that can mute audio sources when some more important audio, like phone call, happens. It is probably caused by some recent package update. I don't know about anything like that happening at my desktop and to be honest I don't care. I just like to listen music on Spotify so fixing this by disabling the module is enough for me.

To do that, edit `/etc/pulse/default.pa` and comment out line `load-module module-role-cork`. Now you can listen Spotify peacfully.

{% highlight bash %}
# /etc/pulse/default.pa

...
### Cork music/video streams when a phone stream is active
# load-module module-role-cork
...
{% endhighlight %}