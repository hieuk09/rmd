# RMD

[![Gem Version](https://badge.fury.io/rb/rmd.svg)](http://badge.fury.io/rb/rmd)
[![Coverage Status](https://coveralls.io/repos/hieuk09/rmd/badge.png?branch=master)](https://coveralls.io/r/hieuk09/rmd?branch=master)
[![Build Status](https://travis-ci.org/hieuk09/rmd.svg?branch=master)](https://travis-ci.org/hieuk09/rmd)
[![Code Climate](https://codeclimate.com/github/hieuk09/rmd/badges/gpa.svg)](https://codeclimate.com/github/hieuk09/rmd)

This is a simple CLI music downloader for Vietnamese music site.

This gem support MacOS / Linux (I'm not sure if it can run on Windows).

## Installation

Install it as:

    $ gem install rmd

## Usage

```shell
Usage:
  rmd download [LINK]

  Options:
    -d, [--folder=FOLDER]  # Choose specific folder to put the downloaded file
    [--fast], [--no-fast]  # Use multithread to enable faster download, default: false
```

##### Download a song

```shell
$ rmd download http://www.nhaccuatui.com/bai-hat/dors-mon-ange-mozart-lopera-rock.dDXGBGls3Rik.html
Start processing http://www.nhaccuatui.com/bai-hat/dors-mon-ange-mozart-lopera-rock.dDXGBGls3Rik.html...
DorsMonAnge-MozartLoperaRock_4cxzy.mp3
Time: 00:00:02 ============================================================================================== 100% 1185 KB/sec
```

##### Download a playlist

```shell
$ rmd download http://www.nhaccuatui.com/playlist/fullmetal-alchemist-dang-cap-nhat.ekoGnMrFlQfA.html
Start processing http://www.nhaccuatui.com/playlist/fullmetal-alchemist-dang-cap-nhat.ekoGnMrFlQfA.html...
2 / 2 Songs ================================================================================================= 100%
DorsMonAnge-MozartLoperaRock_4cxzy.mp3
Time: 00:00:02 ============================================================================================== 100% 1185 KB/sec
LeBeinQiuFailMal-MozartLoperaRock_4asqw.mp3
Time: 00:00:03 ============================================================================================== 100% 902 KB/sec
```

##### Download in multithread

This will enhance your speed when download playlist with many songs.
However, the progress output for the songs will not really correct.

```shell
$ bundle exec rmd download http://mp3.zing.vn/playlist/dev-playlist-zid-sincepast/IO0E698Z.html --fast
Start processing http://mp3.zing.vn/playlist/dev-playlist-zid-sincepast/IO0E698Z.html...
2 / 2 Songs =====================================================================================
100%
Bird TV Size - Yuya Matsushita.mp3
sharp TV Size - Negoto.mp3
Time: 00:00:11 ======================================================================= 100% 143 KB/sec
Time: 00:00:21 ======================================================================== 100% 68 KB/sec
```

## Features

- [x] Download songs/playlists from NCT
- [x] Download songs/playlist from Zing MP3
- [x] Visual progress bar for download
- [x] Specify download folder
- [x] Multi-thread
- [ ] Cache data
- [ ] Read a file to get list of links to download

## Contributing

1. Fork it ( https://github.com/hieuk09/rmd/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
