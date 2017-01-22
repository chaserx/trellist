# trellist

A CLI tool for getting Trello card information in various
formats (default: markdown).

![](https://travis-ci.org/chaserx/trellist.svg?branch=master)

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

## Development

- `bundle install`
- `bundle exec bin/trellist cards`

## Contribution

Pull requests welcome. Please follow the [contribution guide](contributing.md).
