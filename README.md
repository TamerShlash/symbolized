# symbolized

[![Build Status](https://travis-ci.org/TamerShlash/symbolized.svg?branch=master)](https://travis-ci.org/TamerShlash/symbolized)

Symbolized provides a Hash with indifferent access, but with keys stored internally as symbols.
This is particularly useful when you have a very big amount of hashes that share the same keys,
and it may become inefficient to keep all these identical keys as strings. An example of this
case is when you have data processing pipelines that process millions of hashes with the same
keys.

## Installation

Either install it manually:

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
symbolized_hash[:a] #=> 'b'
symbolized_hash.keys #=> [:a]

# Or use the Hash#to_symbolized_hash core extension:

h = { 'a' => 'b' }.to_symbolized_hash
h['a'] #=> 'b'
h[:a] #=> nil
