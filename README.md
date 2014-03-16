mediathekview2podcast
=====================

This XSL Template converts your [MediathekView][1]-subscriptions ("Abos") in a
merged podcast. The suggested workflow is:

1.  **Find, maintain and update** your Mediathek subscriptions with the
    excellent MediathekView. The app stores the links to your subscriptions in a
    XML file named mediathek.xml.

2.  **Create a podcast** with the file mediathek.xml and this XSLT. The actual
    videos don't need to be downloaded; they can be streamed live from the
    broadcasting corporations.



Any XSLT 1.0 processor should be appropriate. Designed to work with
[xsltproc][2]:

1.  `xsltproc -o <podcast>.xml mediathekview2podcast.xslt
~/.mediathek3/mediathek.xml`



Pitfalls
========

-   After a refresh, MediathekView needs to be closed in order to update
    mediathek.xml.

-   Some stations sometimes publish videos with a future timestamp. These videos
    will be ignored in the podcast.




[1]: <http://zdfmediathk.sourceforge.net/>
[2]: <https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/xsltproc.1.html>