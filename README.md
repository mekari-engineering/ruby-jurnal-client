# JurnalApi

A Ruby wrapper for the Jurnal REST APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jurnal_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jurnal_api

## Usage
```
    $ bundle exec irb -I lib

    require 'jurnal_api'
    client = JurnalApi::Client.new(acces_token: ACCESS_TOKEN)
    client.products
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mekari/ruby-jurnal-client.
