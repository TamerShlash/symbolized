# Symbolized

[![Build Status](https://travis-ci.org/TamerShlash/symbolized.svg?branch=master)](https://travis-ci.org/TamerShlash/symbolized)

Symbolized provides a Hash with indifferent access, but with keys stored internally as symbols.
This is particularly useful when you have a very big amount of hashes that share the same keys,
and it may become inefficient to keep all these identical keys as strings. An example of this
case is when you have data processing pipelines that process millions of hashes with the same
keys.

## Installation

You can either install it manually:

    % [sudo] gem install symbolized

Or include it in your Gemfile:

    gem 'symbolized'

And then run `bundle install`.

## Usage

```ruby
require 'symbolized'

# You can create a SymbolizedHash directly:

symbolized_hash = SymbolizedHash.new
symbolized_hash['a'] = 'b'
symbolized_hash['a'] #=> 'b'
symbolized_hash[:a]  #=> 'b'
symbolized_hash.keys #=> [:a]

# Or initialize it with a normal hash:

symbolized_hash = SymbolizedHash.new({'a' => 'b'})
symbolized_hash['a'] #=> 'b'
symbolized_hash[:a]  #=> 'b'
symbolized_hash.keys #=> [:a]

# Or use the Hash#to_symbolized_hash core extension:

h = { 'a' => 'b' }
h['a'] #=> 'b'
h[:a]  #=> nil
h.keys #=> ['a']

symbolized_hash = h.to_symbolized_hash
symbolized_hash['a'] #=> 'b'
symbolized_hash[:a]  #=> 'b'
symbolized_hash.keys #=> [:a]

```

The gem provides almost the same methods and functionality provided by ActiveSupport's `HashWithIndifferentAccess`, while storing keys internally as Symbols.

## `ActiveSupport` Compatibility

This gem is built with intent to be as much as possible compatible with ActiveSupport. You can include both `Symbolized` and `ActiveSupport`, and you are guaranteed to get ActiveSupport functionality and core extensions, and still have `Symbolized` core extension and class.

## Testing

Checkout [travis.yml](.travis.yml) to see which Ruby versions the gem has been tested against. Alternatively, if you want to test it yourself, you can clone the repo, run `bundle install` and then run `rake test`.

## Suggestions, Discussions and Issues

Please propose suggestions, open discussions, or report bugs and issues [here](https://github.com/TamerShlash/symbolized/issues).

## Contributing

1. Fork the [repo](https://github.com/TamerShlash/symbolized)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

The current code of this gem is heavily based on [ActiveSupport 4.2 HashWithIndifferentAccess](https://github.com/rails/rails/tree/4-2-stable/activesupport). Some parts are direct clones, other parts have been modified and/or refactored.

## License

Copyright (c) 2015 [Tamer Shlash](https://github.com/TamerShlash) ([@TamerShlash](https://twitter.com/TamerShlash)). Released under the MIT [License](LICENSE).
