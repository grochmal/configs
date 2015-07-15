# Random recommendations for media files

Just a set of lousy arguments I've heard around.  Most of it is likely biased.
Still, it helps in keeping media files on a server in a manageable space.

Note that these are recommendations for server-wise storage, most people would
argue that storage is cheap and you shall always keep media to the better
quality you can.  That argument is true for personal computers where you can
attach an HDD and backup your files.  On a server you're more concerned about
the persistence of the data (e.g. RAID) and the cost of space (e.g. if you run
on VPS machines).

## Music

Argument
:   The common human can hear about 150 KBs of distinct information per second.
    Several people can hear more than that whilst others less than that.

It is obvious that using PCM WAV is not a good solution for storage, instead we
shall go for MP3, OGG or FLAC.  FLAC is for your personal computer if you care
way too much about sound quality (e.g. if you're a musician), if you're setting
up a webserver you shall go for MP3 or OGG.  Moreover HMTL5 supports MP3 and
OGG in the <audio> element.

Given that we do not need to go above 150kbps to have a decent quality for most
people we shall use 128kbps or 160kbps.  In the early 2000s there was a mania
of encoding every piece of music into 128kbps MP3s and some of those files are
still alive today.  As there is no advantage of re-encoding a 128kbps song into
a 160kbps song, we shall stick to 128kbps.

### MP3 advantages

* Older standard, almost everything supports it.
* People know how to "listen to MP3's".
* Supported by Mac and iOS.

### MP3 disadvantages

* Dirty standard, several extensions are poorly implemented.
* Fixed bitrate, uses the same bitrate even for moments of silence.
* There is an extension for variable bitrate, but is not widely supported.
* Proprietary standard.

### OGG advantages

* Variable bitrate, uses less space for sparse songs.
* Clean standard, there is no Frankenstein OGG (just MP3).
* Open standard, no one will come after you asking for money.

### OGG disadvantages

* Obscure to some people (not a problem if used from inside of a browser).
* Not supported by Mac and iOS (their problem, not ours).

OGG is a winner!  Therefore we stick to 128kbps OGGs.  What follows is a set of
rules to convert songs to 128kbps OGG from the CLI:

    mpg123 -w song.wav song.mp3  # convert to PCM WAV
    oggenc -q 4 song.wav         # -q 4 is variable bitrate around 128kbps

    flac -d song.flac     # convert to PCM WAV
    oggenc -q 4 song.wav

    oggdec song.ogg       # to PCM WAV, e.g. a bloated 320kbps OGG
    oggenc -q 4 song.wav

Unfortunately `mpg123` has issues to deal with frankenstein tracks (tracks that
are somehow damaged or just badly encoded into MP3) TODO

