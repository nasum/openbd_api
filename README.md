# OpenBD

[![Build Status](https://travis-ci.org/nasum/openbd.svg?branch=master)](https://travis-ci.org/nasum/openbd)

This gem wraps openBD Web API.

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

Like this.

```rb
require 'openbd_api'

# get
OpenBD.get '9784309226712'
OpenBD.get '9784309226712,9784309226729'
OpenBD.get [9784309226712,9784309226729]

# bulk_get
OpenBD.bulk_get '9784309226712'
OpenBD.bulk_get '9784309226712,9784309226729'
OpenBD.bulk_get [9784309226712,9784309226729]

# coverage
OpenBD.coverage

# schema
OpenBD.schema
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nasum/openbd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
