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

*   Older standard, almost everything supports it.
*   People know how to "listen to MP3's".
*   Supported by Mac and iOS.

### MP3 disadvantages

*   Dirty standard, several extensions are poorly implemented.
*   Fixed bitrate, uses the same bitrate even for moments of silence.
*   There is an extension for variable bitrate, but is not widely supported.
*   Proprietary standard.

### OGG advantages

*   Variable bitrate, uses less space for sparse songs.
*   Clean standard, there is no Frankenstein OGG (as with MP3s).
*   Open standard, no one will come after you asking for money.

### OGG disadvantages

*   Obscure to some people (not a problem if used from inside of a browser).
*   Not supported by Mac and iOS (their problem, not ours).

OGG is our winner!  Therefore we stick to 128kbps OGGs.  What follows is a set
of rules to convert songs to 128kbps OGG from the CLI:

    mpg123 -w song.wav song.mp3  # convert to PCM WAV
    oggenc -q 4 song.wav         # -q 4 is variable bitrate around 128kbps

    flac -d song.flac     # convert to PCM WAV
    oggenc -q 4 song.wav

    oggdec song.ogg       # to PCM WAV, e.g. a bloated 320kbps OGG
    oggenc -q 4 song.wav

Unfortunately `mpg123` has issues to deal with frankenstein tracks (tracks that
are somehow damaged or just badly encoded into MP3), a good solution for these
tracks is to re-encode the trank with `ffmpeg` instead of `mpg123`

    ffmpeg -i song.mp3 song.wav

### Naming convention

Music is published on albums which are made by artists, we shall include that
information in the song names.  One way to do it is with a directory structure
as follows

    artist/
         release-year~album/
            track-number~song-title~metadata.ogg

Common metadata is, for example, "live" meaning that the song was recorded on a
live performance rather than in a studio.  Often studio albums contain "live"
tracks, live albums often do not need this metadata since all tracks shall be
recorded from a live performance.

Example

    gamma-ray/
        2003~skeletons-in-the-closet/
            19~i-want-out~helloween-cover.ogg

## Images

Argument
:   Most people have two kinds of images: photos and drawings.  Photos are
    highly detailed whilst drawings shall have well defined lines.

Most photos are taken by digital cameras and are stored under JPEG compression.
Since JPEG compression is based on wavelets it is a good choice for scenes with
a lot of detail.  Storing photos as PNGs is unwise since the quality gain has
already been lost when the digital camera stored the image as JPG.

Drawings, on the other hand, have advantages on PNG storage.  A drawing never
saved to JPG retains all its data.  The only real disadvantage of PNGs is the
fact that finding the optimal PNG compression takes more resources than finding
the optimal JPEg compression (using `optipng` for example).  Still, drawing
already in JPEG will not benefit from a transition into PNG.

Resolution of images to be stored server-wise is a function of typical screen
sizes.  The most typical screen width is 1280 pixels, therefore we shall stick
to that for our images.  In essence, we shall convert all images wider than
1280px.  This might provoke issues with wide but short (in height) images, we
shall stipulate a height limit below which an image can be wider than 1280
pixels.

### JPEG quality

In an [experiment with several thousands of images][exp] we can see two
measures of JPEG quality that stand out:

*   Up until quality 80 the file size growth is linear.
*   Around the default for digital machines (90-92) the exponential growth
explodes.

[exp]: https://github.com/neptunepenguin/hath-scripts

Therefore we can argue that for high detail images a quality of **90** shall be
enough, moreover because we will never pump the digital camera's default (which
can be as low as 90).  And for drawings, a quality of **80** shall be a good
compromise between file size and quality.

### GIF (JIF, whatever you want to call it)

The GIF format is showing its age.  Several tools write out poorly formatted
GIFs and produce issues for readers.  The GIF format shall be avoided as much
as possible, and, since is it a lossy compression format, converted to JPG.

Animated GIFs cannot be converted to JPG, yet leaving them as GIFs has problems
of its own.  The WEBM format is a better standard that can be used in place of
GIFs.  Converting animated GIFs to WEBMs is a good solution, and it also saves
disk space.

### Parameter guesswork

That as far as we can go with pure arguments and experiments, the remaining
parameters we will need to guess.  The two guesses we need to perform are: when
to perform PNG to JPG conversion for drawings, and the height at which very
wide images shall not be resized to 1280px width.

If we are downsizing a drawing there is no real advantage in keeping it as a
PNG, therefore we can convert it to JPG.  PNGs shall be kept for images that
are used at full quality.

The height of the images can also be guessed from common screen sizes.  The
height for drawings shall be **1600px** and for photos **1920px**.

### Conversion

And following are quick copy-paste commands for the discussed parameters.  This
is good enough for hundreds of images, for thousands scripting things is
advisable.

A good identify to give and overlook of parameters

    identify -format '%wx%h %Q %r %m %i %b\n' *

Since the .jpeg extension is apple specific we shall organise these files

    rename .jpeg .jpg *.jpeg

For **photos** we can convert images as

    # good size jpg
    mogrify -strip -quality 90 *.jpg

    # good size png (rarely needed)
    for i in *.png; do j=`basename $i .png`; convert $i -strip -quality 90 $j.jpg; done

    # good size gif (rarely needed)
    for i in *.gif; do j=`basename $i .gif`; convert $i -strip -quality 90 $j.jpg; done

    # too large jpg
    mogrify -strip -resize '1280x1920>^' -quality 90 *.jpg

    # too large png (rarely used)
    for i in *.png; do j=`basename $i .png`; convert $i -strip -resize '1280x1920>^' -quality 90 $j.jpg; done

    # too large gif (rarely used)
    for i in *.gif; do j=`basename $i .gif`; convert $i -strip -resize '1280x1920>^' -quality 90 $j.jpg; done

For **drawings** we can do it instead as:

    # good size jpg
    mogrify -strip -quality 80 *.jpg

    # good size png
    for i in *.png; do j=`basename $i .png`; convert $i -strip -quality 80 $j.jpg; done

    # good size gif
    for i in *.gif; do j=`basename $i .gif`; convert $i -strip -quality 80 $j.jpg; done

    # too large jpg
    mogrify -strip -resize '1280x1600>^' -quality 80 *.jpg

    # too large png
    for i in *.png; do j=`basename $i .png`; convert $i -strip -resize '1280x1600>^' -quality 80 $j.jpg; done

    # too large gif
    for i in *.gif; do j=`basename $i .gif`; convert $i -strip -resize '1280x1600>^' -quality 80 $j.jpg; done

### Naming convention - Photos

Photos are taken to remember dates therefore they shall be organised in a time
fashion.  Albums of photos (CBT or CBZ) can be used instead of directories
containing images if the number of inodes is a concern.  A directory structure
as follows make it for easy search

    year/
        date~description.cbt

Example

    2016/
        20160312~someones-birthday.cbt

### Naming convention - Drawings

Drawings are made by someone and, therefore, that information shall be present
in the name of the file.  Similar to photos we can bundle several images into
archives (CBT or CBZ) to use a smaller number of inodes.  The date in drawings
is a tricky piece of metadata, most drawings are created at some point and even
published at some point.  Yet, publication dates might be different in
different places or even inexistent for internet born art.  Dates shall be
treated as extra metadata not major component in the naming convention.  One
way to name art/drawings can be

    artist-or-circle/
        artist~title~metadata.cbt

Contrary to photos drawing often contain text, and this text might be in
different languages.  Therefore, the most common piece of metadata is the
language the drawing is in.  This is most notable for comics.  For example

    rene-goscinny/
        rene-goscinny~01-the-advetures-of-asterix-the-gall~en.cbt

Often is useful to present the language metadata for translations whilst
keeping it out of the original.  Following the example above, the original
Asterix comics are in French not English.

## Videos

Argument
:   The videos will be streamed and seen in a browser.  If the video's quality
    is too high the network speed might be too little to watch it in realtime.

WEBM is the standard that shall be used for server-side video.  The only
competing standard is proprietary to apple and supported by themselves only,
which means it is their problem not ours.

For the question of audio we shall reuse our discussion about music above.  We
shall go with 128 KBs OGG, which means `libvorbis` `128k` for the WEBM.

Given the we already have 128k bytes per second of video stream we shall aim to
not use more than 1MB per second.  Counting the muxer frames we shall be about
200k bytes per second, therefore we shall use 512 KBs for the video encoding.
For shorter videos, that can pre-load in the browser before playing we shall be
safe with 1024 KBs.

### Conversion

We will use `ffmpeg` examples to convert videos into the WEBM format.  The
`-quality` parameter is a [webm parameter][webmp], `good` is enough for most
cases but but `best` can give slightly better results if you have the patience
to wait for it.

[webmp]: http://www.webmproject.org/docs/encoder-parameters/

A typical `ffmpeg` usage

    ffmpeg -i vid.avi \
      -c:v libvpx -b:v 512k \
      -c:a libvorbis -b:a 128k \
      -quality good \
      vid.webm

It can also be used to concatenate files into a single video

    echo file vid-1.avi >  vid.txt
    echo file vid-2.avi >> vid.txt
    ffmpeg -f concat -i vid.txt
      -c:v libvpx -b:v 512k \
      -c:a libvorbis -b:a 128k \
      -quality good \
      vid.webm

Audio and video sometimes are not in sync in the muxer frames, use `vsync` and
`async` to force a resample of the audio and video frames.

    # -async is equivalent to
    # -af aresample=async=1:min_hard_comp=0.100000:first_pts=0
    ffmpeg -i vid.avi \
      -c:v libvpx -b:v 512k \
      -c:a libvorbis -b:a 128k \
      -quality good \
      -qmin 30 -qmax 60 -vsync 2 -async 1 \
      vid.webm

For videos that are too large `-vf scale` can be used to reduce the resolution

    # -vf scale=-1:320 is width:height, -1 means keep ratio
    ffmpeg -i vid.avi \
      -vf scale=-1:320 \
      -c:v libvpx -b:v 512k \
      -c:a libvorbis -b:a 128k \
      -quality good \
      -qmin 30 -qmax 60 -vsync 2 -async 1 \
      vids.webm

For very bad sound you can change `-b:a 128k` to `-qscale:a 4` (just like
`oggenc -q 4`), this is often needed in cases of bad sample rates (non 44100).
Another option is to force the rate with `-ar 44100`, for example:

    ffmpeg -i travel-vid.avi \
      -c:v libvpx -b:v 1024k \
      -c:a libvorbis -ar 44100 -b:a 128k \
      -quality good \
      -qmin 30 -qmax 60 -vsync 2 -async 1 \
      travel-vid.webm

And if you do not care about the sound you can remove it altogether with `-an`
(`-vn` removes the video)

    ffmpeg -i travel-vid.avi \
      -c:v libvpx -b:v 1024k \
      -an \
      -quality best \
      -qmin 30 -qmax 60 -vsync 2 -async 1 \
      travel-vid.webm

### Naming convention

In general there are two types of videos: personal videos made on travels or
events and movies (long or short) which are an artistic from of expression.
Movies are often qualified by their origin, therefore naming them in this
fashion makes sense

    origin/
        movie.webm

For example

    america/
        a-clockwork-orange.webm

Personal videos are kept as photos, reminding of certain events that occurred
at a certain point in time.  These videos shall follow the same name convention
as for photos.

    year/
        date~description.cbt

Example

    2016/
        20160312~someones-birthday.webm

## Books

Argument
:   JavaScript is dangerous in XSS attacks, given that it can be present in
    PDFs it is better to be safe and remove it.  Some PDFs are encrypted and
    contain the keys as part of the file itself, that does not offer any
    additional security and wastes disk space.

Really, the PDF format is well optimised in terms of space and compression.
Just make sure that you remove any JavaScript from server-side PDF since that
is a trivial XSS possibility.  As for encrypted PDFs, do not encrypt them
unless you want to set some kind of password.  The possibility of encrypting
the PDF and keeping the keys within the file is likely an oversight of the PDF
standard and has no other usage than to waste disk space.

### Postscript

The Postscript standard is the predecessor of PDF, PDF can do everything that
can be achieved in Postscript and more.  Often PDF has a better compression.
There is not reason to keep books or papers in the Postscript format.

### Epub

The EPUB format is new and suffers from verbosity (it is, after all, based on
HTML), yet the format is deflated (compressed).  JavaScript cannot be added to
EPUBs as of this writing, which means no XSS worries.  In general EPUBs are too
young to be a strong format, although there is nothing particularly bad about
them (not counting DRM but that is another discussion).  It is a format
promising for the future, and, therefore there is no good reason to convert
them to PDF.

### Convert

The ghostscript command line utility is probably the most widely used PDF and
Postscript editor.  It might be rather complex to the not initiated but its
plethora of options is easy to remember after a couple of uses.

A good start with ghostscript is [Milan Kupcevic's article][mkgs], below i have
a summary and a couple of common commands but the article itself is better
written.

[mkgs]: http://milan.kupcevic.net/ghostscript-ps-pdf/

To convert Postscript to PDF you can

    gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=out.pdf in.ps

You can concatenate PDF and Postscript files (just like with `cat`)

    gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=out.pdf in1.ps in2.pdf

To extract a single page you shall use `-dFirstPage=` and `-dLastPage=`
pointing to the same page, to extract more pages give a range

    gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFirstPage=6 -dLastPage=6 -sOutputFile=out.pdf in.pdf

And here is a list of extra options from Kupcevic's article

    # optimization level
    -dPDFSETTINGS=/screen   (screen-view-only quality, 72 dpi images)
    -dPDFSETTINGS=/ebook    (low quality, 150 dpi images)
    -dPDFSETTINGS=/printer  (high quality, 300 dpi images)
    -dPDFSETTINGS=/prepress (high quality, color preserving, 300 dpi imgs)
    -dPDFSETTINGS=/default  (almost identical to /screen)

    # paper size
    -sPAPERSIZE=letter
    -sPAPERSIZE=a4
    -dDEVICEWIDTHPOINTS=w -dDEVICEHEIGHTPOINTS=h (point=1/72 of an inch)
    -dFIXEDMEDIA (force paper size over the PostScript defined size)

    # other options (including defaults)
    -dEmbedAllFonts=true
    -dSubsetFonts=false
    -dFirstPage=pagenumber
    -dLastPage=pagenumber
    -dAutoRotatePages=/PageByPage
    -dAutoRotatePages=/All
    -dAutoRotatePages=/None
    -dCompatibilityLevel=1.4
    -r1200 (resolution for pattern fills and fonts converted to bitmaps)
    -sPDFPassword=password

And a short usage of PDFmarks, for this create a file named "pdfmarks" with
this content:

    [ /Title (Document title)
      /Author (Author name)
      /Subject (Subject description)
      /Keywords (comma, separated, keywords)
      /ModDate (D:20061204092842)
      /CreationDate (D:20061204092842)
      /Creator (application name or creator note)
      /Producer (PDF producer name or note)
      /DOCINFO pdfmark

then combine the file with a Postscript or a PDF file

    gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=withmarks.pdf nomarks.ps pdfmarks

You can also add a couple of named destinations to the "pdfmarks" file

    [ /Dest /NamedDest1 /Page 1 /View [/XYZ 20 620 1.8] /DEST pdfmark
    [ /Dest /NamedDest2 /Page 2 /View [/FitH 15] /DEST pdfmark

or a few bookmarks

    [/Count -2 /Dest /NamedDest1 /Title (Preface) /OUT pdfmark
    [ /Action /GoTo /Dest /NamedDest1 /Title (Audience) /OUT pdfmark
    [ /Action /GoTo /Dest /NamedDest2 /Title (Content) /OUT pdfmark
    [/Count 3 /Page 2 /View [/XYZ 10 160 1.0] /Title (Part 1) /OUT pdfmark
    [ /Page 2 /View [/XYZ 10 160 1.0] /Title (A first one) /OUT pdfmark
    [ /Page 3 /View [/XYZ 0 500 NULL] /Title (The second one) /OUT pdfmark
    [ /Page 6 /View [/FitH 220] /Title (The third thing) /OUT pdfmark
    [ /PageMode /UseOutlines /DOCVIEW pdfmark

Therefore a decent way to convert books and papers should be

    gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite \
       -dPDFSETTINGS=/printer -dCompatibilityLevel=1.4 \
       -sOutputFile=out.pdf in.pdf

### Naming convention

Two kinds of publications are often stored as PDF or EPUB: books and papers
(the scientific or engineering kind).  For a book the most important
information shall be contained in its title, for example the general topic of
the book.  Papers on the other hand need to be easily found by reference, and
references are based on author's surname, therefore it the author is much more
important for a paper name.

We can argue to name a book as

    title~author.pdf

For example

    silence-on-the-wire~zalewski.pdf

And name a paper as

    author~title.pdf

For example

    avgerinos~automatic-exploit-generation.pdf

Organisation of books and papers into directories is a matter or topic
organisation.  The understanding of how to divide topics between themselves is
a very personal choice, therefore any division should be as good.

