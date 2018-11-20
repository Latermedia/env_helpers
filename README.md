# EnvHelpers

A set of helpers to improve ENV functionality

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_helpers'
```

If you'd like to add the functionality directly to `ENV` you can add:

```ruby
gem 'env_helpers', require: 'env_helpers/ext/env'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_helpers

## Usage

You can find the on [rubdoc.info](https://www.rubydoc.info/github/Latermedia/env_helpers/master).

### Methods

`EnvHelpers` supplies the following helper methods:

-   `equal?`
-   `num`
-   `int`
-   `array`
-   `json`
-   `bool`
-   `true?`
-   `false?`

```ruby
require `env_helpers`

EnvHelpers.int('TEST_INT')
```

If you used the `ENV` extension, you can call any of these methods directly on `ENV`.

```ruby
require `env_helpers/ext/env`

ENV.int('TEST_INT')
```

### JSON

By default `EnvHelpers` swallows `JSON::ParserError` on invalid JSON when using `.json`. To change this behavior set `rescue_json` to be `false`.

```ruby
EnvHelpers.rescue_json = false
```

### Boolean Values

`EnvHelpers` does a case insensitive check for boolean values.

**True**

-   `true`
-   `t`
-   `1`

**False**

-   `false`
-   `f`
-   `0`

To modify `EnvHelpers` checks for `true` and `false`, a simple monkey patch will take care of things:

```ruby
module EnvHelpers
  class << self
    def true_value?(val)
      val == 'false'
    end

    def false_value?(val)
      val == 'true'
    end
  end
end
```

The methods `true_value?` and `false_value?` are meant to be modified in this manner to customize functionality.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `./run_specs` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Tests

Since parts of the functionality is optional and modifies other classes and objects, the specs aren't meant to be run all at the same time. This is to isolate the environment the tests are executing in.

To run the tests:

```bash
./run_specs
```

Tests are currently run against the following Ruby version:
- 2.5
- 2.4
- 2.3
- 2.2

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Latermedia/env_helpers. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EnvHelpers project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Latermedia/env_helpers/blob/master/CODE_OF_CONDUCT.md).
