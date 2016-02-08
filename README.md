# FactoryWoman

This gem is a layer on top of [factory_girl](https://github.com/thoughtbot/factory_girl) to allow you to create dependencies on your model easily

If your dependencies look like:
```ruby
class User < ActiveRecord::Base; end

class Blog < ActiveRecord::Base
  belongs_to :user
  alias_attribute :user_alias_id, :user_id
end

class Article < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user, foreign_key: :author_id
end
```

Running `FactoryWoman.create(:article)` will create a blog entry (and then a user that possesses this blog), and another user fot the author.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_woman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_woman

## Usage

Just require it in your `rails_helper.rb`:

```ruby
require 'factory_woman'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factory_woman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credits

Original idea by @gsabran
