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
    client = JurnalApi::Client.new(access_token: ENV['COMPANY_API_KEY'], base_url: ENV['JURNAL_API_BASE_URL'])
    client.products
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mekari/ruby-jurnal-client.
