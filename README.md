# ResourceNameValidator
[![Build Status](https://travis-ci.org/kurotaky/resource_name_validator.svg?branch=master)](https://travis-ci.org/kurotaky/resource_name_validator)

defined resources validator for Rails Application.
validate name in accordance with current defined resources.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resource_name_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resource_name_validator

## Usage

```ruby
# app/models/user.rb
class User < ActiveRecord::Base
  validates :name, resource_name: true
end
```

## Examples
```sh
irb(main):001:0> Rails.application.routes.routes.collect {|r| r.path.spec.to_s }.include? '/admin(.:format)'
=> false

user = User.new(name: 'admin')
user.valid? #=> false
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kurotaky/resource_name_validator.
