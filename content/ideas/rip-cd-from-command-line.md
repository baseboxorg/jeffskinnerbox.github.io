# HOWTO: Ripping CDs From the Command Line in Linux
I have a habit of buying the [Compact Disc (CD)][06] albums of the music I love,
ripping the CDs to my digital music library
(i.e. on my desktop PC which is synched with or accessable by my Squeezebox, iPod, Smartphone, etc.)
and then storing the CD away for safe keeping.
I foresee the day when these little plastic disks may not be sold
since all music will be distributed via the cloud.
Maybe this will never come to pass, but it's what I do!

So what I need is a quick and simple way to rip the CDs and file them away in my music library.
Of course, there are may programs that can help but most have graphic user interface,
meaning they are manual, not scripted.
I what to script / automate the process as much as possible.
I have a standard way to name and organize my music library,
and since the process is the same for any CD, it could be scripted,
at least in large part.

## Basic Procedure for Ripping
In this great multi-part video tutorial,
"[Command Line: CD Ripping and Encoding][01]"
the author explain how to rip the audio tracks off a music CD,
and then encode that data into ready to play format.
This is all done from the command line using standard command line utilities like [cdparanoia][02]
from the [Vorbis] [03]tool set.
cdparanoia retrieves audio tracks from CDROM drives.
The data can be saved to a file or directed to standard output in WAV, AIFF, AIFF-C or raw format.
(MPEG Audio Layer III, generally know as MP3,
is the most widely used encode scheme in use, but it is not open source,
technically you need to provide a royalty fee to use the format.
`[lame`][13] is a program which can be used to create MP3 file.)

First, lets install all the tools you'll need and discribed below:

```bash
sudo apt-get install cdparanoia sox cd-discid abcde ripit
```

You can see what is on the CD by querying and printing the table of contents with
`cdparanoia -d /dev/cdrom --query`.
To begin the ripping process, do the following:

```bash
# rip the whole CD to a temporary working directory
cd $HOME/tmp
mkdir newcd
cd newcd
cdparanoia -d /dev/cdrom -B
```

To test to see if you don't have garbage,
try playing one of the tracks.
To do this, use the `sox` utility `play`.

```
# test a track to make sure it works
play track01.cdda.wav
```

To encode the WAV files in OGG format from [Vorbis][03], use the following command:

```bash
# encode wav file into ogg format using the highest quality encoding
oggenc -q 10 track01.cdda.wav -o track01.ogg

# test to see if it worked
ogg123 track01.ogg
```

Song tags can be added to the encode file

```bash
# encoding a wav to ogg with tags
oggenc -a "Joe Walash" -G "Rock" -d "1973" -N "1" -t "Rocky Mountain Way" -l "The Smoker You Drink, The Player You Get" -q 10 track01.cdda.wav -o "Rocky Mountain Way.ogg"

# to test if the tags are right, use Rhythmbox 
rhythmbox Rocky Mountain Way.ogg
```

```bash
oggenc -q 10 \
-a "Joe Walash" -G "Rock" -d "1973" -l "The Smoker You Drink, The Player You Get" \
-N "1" -t "Rocky Mountain Way" track01.cdda.wav \
-N "2" -t "Book Ends" track02.cdda.wav \
-N "3" -t "Wolf" track03.cdda.wav \
-n "%t.ogg"
```

## Getting Tags
This is great script, but you still need to manual provide the track titles, artist, etc.
You may have observed that if you putting your CD into an Internet-enabled device,
the computer is accessing an online database
([Gracenote][08], [freeDB][09], [MusicBrainz][11] or [AllMusic][10])
with information that matches your CD
(check out [this site][12] for more infomation).
It’s not actually taking the song information from the physical CD itself, but done via CDDB.
[CDDB, short for Compact Disc Database][04],
is a database for software applications to look up audio CD (compact disc) information over the Internet.
This is performed by a client which calculates a (nearly) unique disc ID and then queries the database.
As a result, the client is able to display the artist name, CD title, track number, etc.
CDDB was designed around the task of identifying entire CDs, not merely single tracks.
The identification process involves creating a "discid", a sort of "fingerprint"
of a CD created by performing calculations on the track duration information
stored in the table-of-contents of the CD.
This discid is used with the Internet database,
typically either to download track names for the whole CD or to submit track names for a newly identified CD.

[`cd-discid`][05] is an utility to get CDDB information for a CD-ROM disc.
The multi-field string that is returned then can be used to query a CDDB database.
That query can be done via the tool [`cddb-tool`][07].

```bash
CDDB_ID=`cd-discid /dev/cdrom`                      # Disc ID for query of CDDB
SERVER="http://freedb.freedb.org/~cddb/cddb.cgi"    # query this CDDB database
USER=`whoami`                                       # who is the user making the query
HOST=`hostname`                                     # who is the host making the query

# get the genre of the album
GENRE=`cddb-tool query $SERVER 5 $USER $HOST $CDDB_ID | awk '{ print $2 }'`

# print the albums title, year, genre, and track titles
cddb-tool read $SERVER 5 $USER $HOST $GENRE $CDDB_ID

# parse out the title of the first track 
cddb-tool read $SERVER 5 $USER $HOST $GENRE $CDDB_ID | grep TTITLE0 | sed 's/TTITLE0=//'
```

## Automating the Process
[`ripit`][14] is a command line audio CD ripper that puts all the above steps into a nice script.

[Rip Your CDs At The Command Line](http://www.maketecheasier.com/rip-cds-at-command-line/)

## Other Useful Tools
[`id3`][] is an ID3 v1.1 tag editor.
ID3 tags are traditionally put at the end of compressed streamed audio files to denote information about the audio contents.

[`id3v2`][] is an ID3 v2 tag editor.
ID3 tags are traditionally put at the end of compressed streamed audio files to denote information about the audio contents. Using this command line software you can add/modifiy/delete id3v2 tags and optionally convert id3v1 tags to id3v2.

## Sources
* [HOWTO: Convert music CDs to MP3 using the Command Line](http://ubuntuforums.org/showthread.php?t=535950)
* [Rip Your CDs At The Command Line](http://www.maketecheasier.com/rip-cds-at-command-line/)
* [CD ripping and burning from the command prompt Howto](http://linuxreviews.org/howtos/cdrecording/#toc4)
* [HowTo: Linux Rip and Encode Audio CDs](http://www.cyberciti.biz/faq/linux-ripping-and-encoding-audio-files/)
* []()
* []()

http://www.linuxquestions.org/questions/linux-general-1/how-to-do-a-freedb-query-220956/
http://gadgetweb.de/linux/cd-ripping-with-lame-cdda2wav-and-cddb-data.html

[01]:https://www.youtube.com/playlist?list=PL2BE016DE79CAF1EC&app=desktop
[02]:https://www.xiph.org/paranoia/
[03]:http://www.vorbis.com/
[04]:http://en.wikipedia.org/wiki/CDDB
[05]:http://manpages.ubuntu.com/manpages/precise/man1/cd-discid.1.html
[06]:http://en.wikipedia.org/wiki/Compact_disc
[07]:http://manpages.ubuntu.com/manpages/trusty/man1/cddb-tool.1.html
[08]:http://www.gracenote.com/
[09]:http://www.freedb.org/
[10]:http://www.allmusic.com/
[11]:https://musicbrainz.org/
[12]:http://www.mp3developments.com/article9.php
[13]:http://lame.sourceforge.net/
[14]:http://www.suwald.com/ripit/install.php
[15]:
[16]:
[17]:
[18]:
[19]:
[20]:
