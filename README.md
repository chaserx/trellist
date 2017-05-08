# trellist

A CLI tool for getting Trello card titles and links in various
formats (default: markdown).

[![travis build](https://travis-ci.org/chaserx/trellist.svg?branch=master)](https://travis-ci.org/chaserx/trellist)

## Usage

The following [Trello API](https://developers.trello.com/) credentials are
required from your account:

- TRELLO_DEVELOPER_PUBLIC_KEY
- TRELLO_MEMBER_TOKEN

Run the following command to create a config file

`trellist initconfig`

Supply your Trello creds to that `~/.trellist` file in your home directory.
Otherwise you'll need to supply your key and token as flags such as:

`trellist -k TRELLO_DEVELOPER_PUBLIC_KEY -t TRELLO_MEMBER_TOKEN -b TRELLO_BOARD_ID cards`

`trellist help` to display help.

### Getting list cards as links

- `trellist cards` **mardown format**
- `trellist cards --format=markdown` **same as above**
- `trellist cards --format=plain` **just links**
- `trellist cards --format=html` **html**
- `trellist cards --format=titles-only` **titles only**

#### Link prefix and suffix

You can supply optional prefix and suffix flags to alter the output. However, prefix and suffix only work for markdown and HTML formats. 

example. `trellist cards --format=markdown --prefix='* '` will return

`* [Card Title](https://trello.com/c/1moT1m3)`

Similar with suffix. 

#### Filtering cards

You can filter cards by their labels. 

example. `trellist cards --label='foo'`

## Development

- `bundle install`
- `bundle exec ./bin/trellist cards` you have to use bundle exec in development mode

Run `rake -T` to view helpful build and release tasks. 

## Contribution

Pull requests welcome. Please follow the [contribution guide](contributing.md).
