# Zoney

This gem allows you to communicate with the [MonoPrice 6 Zone
Amplifier](https://www.monoprice.com/product?p_id=10761) via a serial port
connection

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zoney'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zoney

## Usage

```ruby
# Initialize an instance of Zoney::Zone
zoney = Zoney::Zone.new

# This instance is defaulted to 1 amplifier using the /dev/ttyUSB0 port. If you
# would like to change this you can override these in the initialize call:
zoney = Zoney::Zone.new(port: "/dev/ttyUSB1", number_of_amplifiers: 3)

# Get all the zone information:
zoney.all

# Get a specific zone's information
zoney.find(zone_number: 14)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kenyonj/zoney. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Zoney project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kenyonj/zoney/blob/master/CODE_OF_CONDUCT.md).
