# Rmd

This is a simple CLI music downloader for Vietnamese music site.

This gem support MacOS / Linux (I'm not sure if it can run on Windows).

## Installation

Install it as:

    $ gem install rmd

## Usage

```shell
Commands:
  rmd download [LINK]  # Dowload your music from a specific link
  rmd help [COMMAND]   # Describe available commands or one specific command
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

## Features

- [x] Download songs/playlists from NCT
- [ ] Download songs/playlist from Zing MP3
- [ ] Read a file to get list of links to download
- [x] Visual progress bar for download
- [ ] Specify download folder
- [ ] Cache data

## Contributing

1. Fork it ( https://github.com/hieuk09/rmd/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
