# OpenBD

[![Gem Version](https://badge.fury.io/rb/openbd_api.svg)](https://badge.fury.io/rb/openbd_api)
[![Build Status](https://travis-ci.org/nasum/openbd_api.svg?branch=master)](https://travis-ci.org/nasum/openbd_api)

This gem wraps [openBD](https://openbd.jp/) Web API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openbd_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openbd_api

## Usage

### Library

Like this.

```rb
require 'openbd_api'

# create instance
client = OpenBD::Client.new

# get
client.get 9784309226712
client.get '9784309226712'
client.get '9784309226712,9784309226729'
client.get [9784309226712,9784309226729]
client.get ['9784309226712','9784309226729']

# bulk_get
client.bulk_get 9784309226712
client.bulk_get '9784309226712'
client.bulk_get '9784309226712,9784309226729'
client.bulk_get [9784309226712,9784309226729]
client.bulk_get ['9784309226712','9784309226729']

# coverage
client.coverage

# schema
client.schema
```

### CLI

`openbd` executable calls `OpenBD` `s methods.

```
$ openbd get 9784309226712
$ openbd bulk_get 9784309226712 9784309226729
$ openbd coverage
$ openbd schema
$ openbd --help
Usage: openbd <method> [arguments] [options]

Supported <method>:
  get       Find book data by ISBN(s)
  bulk_get  Find book data by ISBN(s)
  coverage  Show all ISBNs in openBD
  schema    Show the JSON Schema of openBD

    -v, --version  print the version
    -h, --help     print help
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nasum/openbd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
