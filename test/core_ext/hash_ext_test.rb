require 'test_helpers'
require 'symbolized/core_ext/object/deep_dup'
require 'symbolized/core_ext/hash/symbolized_hash'

class HashExtTest < Symbolized::TestCase
  class IndifferentHash < Symbolized::SymbolizedHash
  end

  class SubclassingArray < Array
  end

  class SubclassingHash < Hash
  end

  class NonIndifferentHash < Hash
    def nested_under_symbolized_hash
      self
    end
  end

  class HashByConversion
    def initialize(hash)
      @hash = hash
    end

    def to_hash
      @hash
    end
  end

  def setup
    @strings = { 'a' => 1, 'b' => 2 }
    @nested_strings = { 'a' => { 'b' => { 'c' => 3 } } }
    @symbols = { :a  => 1, :b  => 2 }
    @nested_symbols = { :a => { :b => { :c => 3 } } }
    @mixed   = { :a  => 1, 'b' => 2 }
    @nested_mixed   = { 'a' => { :b => { 'c' => 3 } } }
    @fixnums = {  0  => 1,  1  => 2 }
    @nested_fixnums = {  0  => { 1  => { 2 => 3} } }
    @illegal_symbols = { [] => 3 }
    @nested_illegal_symbols = { [] => { [] => 3} }
    @upcase_strings = { 'A' => 1, 'B' => 2 }
    @nested_upcase_strings = { 'A' => { 'B' => { 'C' => 3 } } }
    @string_array_of_hashes = { 'a' => [ { 'b' => 2 }, { 'c' => 3 }, 4 ] }
    @symbol_array_of_hashes = { :a => [ { :b => 2 }, { :c => 3 }, 4 ] }
    @mixed_array_of_hashes = { :a => [ { :b => 2 }, { 'c' => 3 }, 4 ] }
    @upcase_array_of_hashes = { 'A' => [ { 'B' => 2 }, { 'C' => 3 }, 4 ] }
  end

  def test_methods
    h = {}
    assert_respond_to h, :transform_keys
    assert_respond_to h, :transform_keys!
    assert_respond_to h, :deep_transform_keys
    assert_respond_to h, :deep_transform_keys!
    assert_respond_to h, :symbolize_keys
    assert_respond_to h, :symbolize_keys!
    assert_respond_to h, :deep_symbolize_keys
    assert_respond_to h, :deep_symbolize_keys!
    assert_respond_to h, :stringify_keys
    assert_respond_to h, :stringify_keys!
    assert_respond_to h, :deep_stringify_keys
    assert_respond_to h, :deep_stringify_keys!
    assert_respond_to h, :to_options
    assert_respond_to h, :to_options!
  end

  def test_stringify_keys_for_symbolized_hash
    assert_instance_of Hash, @strings.to_symbolized_hash.stringify_keys
    assert_equal @strings, @strings.to_symbolized_hash.stringify_keys
    assert_equal @strings, @symbols.to_symbolized_hash.stringify_keys
    assert_equal @strings, @mixed.to_symbolized_hash.stringify_keys
  end

  def test_deep_stringify_keys_for_symbolized_hash
    assert_instance_of Hash, @nested_symbols.to_symbolized_hash.deep_stringify_keys
    assert_equal @nested_strings, @nested_strings.to_symbolized_hash.deep_stringify_keys
    assert_equal @nested_strings, @nested_symbols.to_symbolized_hash.deep_stringify_keys
    assert_equal @nested_strings, @nested_mixed.to_symbolized_hash.deep_stringify_keys
  end

  def test_stringify_keys_bang_for_symbolized_hash
    assert_raise(NoMethodError) { @strings.to_symbolized_hash.dup.stringify_keys! }
    assert_raise(NoMethodError) { @symbols.to_symbolized_hash.dup.stringify_keys! }
    assert_raise(NoMethodError) { @mixed.to_symbolized_hash.dup.stringify_keys! }
  end

  def test_deep_stringify_keys_bang_for_symbolized_hash
    assert_raise(NoMethodError) { @nested_strings.to_symbolized_hash.deep_dup.deep_stringify_keys! }
    assert_raise(NoMethodError) { @nested_symbols.to_symbolized_hash.deep_dup.deep_stringify_keys! }
    assert_raise(NoMethodError) { @nested_mixed.to_symbolized_hash.deep_dup.deep_stringify_keys! }
  end

  def test_symbolize_keys_for_symbolized_hash
    assert_instance_of Symbolized::SymbolizedHash, @symbols.to_symbolized_hash.symbolize_keys
    assert_equal @symbols, @strings.to_symbolized_hash.symbolize_keys
    assert_equal @symbols, @symbols.to_symbolized_hash.symbolize_keys
    assert_equal @symbols, @mixed.to_symbolized_hash.symbolize_keys
  end

  def test_deep_stringify_keys_for_symbolized_hash
    assert_instance_of Symbolized::SymbolizedHash, @nested_symbols.to_symbolized_hash.deep_symbolize_keys
    assert_equal @nested_symbols, @nested_strings.to_symbolized_hash.deep_symbolize_keys
    assert_equal @nested_symbols, @nested_symbols.to_symbolized_hash.deep_symbolize_keys
    assert_equal @nested_symbols, @nested_mixed.to_symbolized_hash.deep_symbolize_keys
  end

  def test_symbolize_keys_bang_for_symbolized_hash
    assert_instance_of Symbolized::SymbolizedHash, @symbols.to_symbolized_hash.dup.symbolize_keys!
    assert_equal @symbols, @strings.to_symbolized_hash.dup.symbolize_keys!
    assert_equal @symbols, @symbols.to_symbolized_hash.dup.symbolize_keys!
    assert_equal @symbols, @mixed.to_symbolized_hash.dup.symbolize_keys!
  end

  def test_deep_symbolize_keys_bang_for_symbolized_hash
    assert_instance_of Symbolized::SymbolizedHash, @nested_symbols.to_symbolized_hash.dup.deep_symbolize_keys!
    assert_equal @nested_symbols, @nested_strings.to_symbolized_hash.deep_dup.deep_symbolize_keys!
    assert_equal @nested_symbols, @nested_symbols.to_symbolized_hash.deep_dup.deep_symbolize_keys!
    assert_equal @nested_symbols, @nested_mixed.to_symbolized_hash.deep_dup.deep_symbolize_keys!
  end

  def test_symbolize_keys_preserves_keys_that_cant_be_symbolized_for_symbolized_hash
    assert_equal @illegal_symbols, @illegal_symbols.to_symbolized_hash.symbolize_keys
    assert_equal @illegal_symbols, @illegal_symbols.to_symbolized_hash.dup.symbolize_keys!
  end

  def test_deep_symbolize_keys_preserves_keys_that_cant_be_symbolized_for_symbolized_hash
    assert_equal @nested_illegal_symbols, @nested_illegal_symbols.to_symbolized_hash.deep_symbolize_keys
    assert_equal @nested_illegal_symbols, @nested_illegal_symbols.to_symbolized_hash.deep_dup.deep_symbolize_keys!
  end

  def test_symbolize_keys_preserves_fixnum_keys_for_symbolized_hash
    assert_equal @fixnums, @fixnums.to_symbolized_hash.symbolize_keys
    assert_equal @fixnums, @fixnums.to_symbolized_hash.dup.symbolize_keys!
  end

  def test_deep_symbolize_keys_preserves_fixnum_keys_for_symbolized_hash
    assert_equal @nested_fixnums, @nested_fixnums.to_symbolized_hash.deep_symbolize_keys
    assert_equal @nested_fixnums, @nested_fixnums.to_symbolized_hash.deep_dup.deep_symbolize_keys!
  end

  def test_nested_under_symbolized_hash
    foo = { "foo" => SubclassingHash.new.tap { |h| h["bar"] = "baz" } }.to_symbolized_hash
    assert_kind_of Symbolized::SymbolizedHash, foo["foo"]

    foo = { "foo" => NonIndifferentHash.new.tap { |h| h["bar"] = "baz" } }.to_symbolized_hash
    assert_kind_of NonIndifferentHash, foo["foo"]

    foo = { "foo" => IndifferentHash.new.tap { |h| h["bar"] = "baz" } }.to_symbolized_hash
    assert_kind_of IndifferentHash, foo["foo"]
  end

  def test_indifferent_assorted
    @strings = @strings.to_symbolized_hash
    @symbols = @symbols.to_symbolized_hash
    @mixed   = @mixed.to_symbolized_hash

    assert_equal :a, @strings.__send__(:convert_key, 'a')

    assert_equal 1, @strings.fetch(:a)
    assert_equal 1, @strings.fetch('a'.to_sym)
    assert_equal 1, @strings.fetch('a')

    hashes = { :@strings => @strings, :@symbols => @symbols, :@mixed => @mixed }
    method_map = { :'[]' => 1, :fetch => 1, :values_at => [1],
      :has_key? => true, :include? => true, :key? => true,
      :member? => true }

    hashes.each do |name, hash|
      method_map.sort_by { |m| m.to_s }.each do |meth, expected|
        assert_equal(expected, hash.__send__(meth, 'a'),
                     "Calling #{name}.#{meth} 'a'")
        assert_equal(expected, hash.__send__(meth, :a),
                     "Calling #{name}.#{meth} :a")
      end
    end

    assert_equal [1, 2], @strings.values_at('a', 'b')
    assert_equal [1, 2], @strings.values_at(:a, :b)
    assert_equal [1, 2], @symbols.values_at('a', 'b')
    assert_equal [1, 2], @symbols.values_at(:a, :b)
    assert_equal [1, 2], @mixed.values_at('a', 'b')
    assert_equal [1, 2], @mixed.values_at(:a, :b)
  end

  def test_indifferent_reading
    hash = SymbolizedHash.new
    hash["a"] = 1
    hash["b"] = true
    hash["c"] = false
    hash["d"] = nil

    assert_equal 1, hash[:a]
    assert_equal true, hash[:b]
    assert_equal false, hash[:c]
    assert_equal nil, hash[:d]
    assert_equal nil, hash[:e]
  end

  def test_indifferent_reading_with_nonnil_default
    hash = SymbolizedHash.new(1)
    hash["a"] = 1
    hash["b"] = true
    hash["c"] = false
    hash["d"] = nil

    assert_equal 1, hash[:a]
    assert_equal true, hash[:b]
    assert_equal false, hash[:c]
    assert_equal nil, hash[:d]
    assert_equal 1, hash[:e]
  end

  def test_indifferent_writing
    hash = SymbolizedHash.new
    hash[:a] = 1
    hash['b'] = 2
    hash[3] = 3

    assert_equal hash['a'], 1
    assert_equal hash['b'], 2
    assert_equal hash[:a], 1
    assert_equal hash[:b], 2
    assert_equal hash[3], 3
  end

  def test_indifferent_update
    hash = SymbolizedHash.new
    hash[:a] = 'a'
    hash['b'] = 'b'

    updated_with_strings = hash.update(@strings)
    updated_with_symbols = hash.update(@symbols)
    updated_with_mixed = hash.update(@mixed)

    assert_equal updated_with_strings[:a], 1
    assert_equal updated_with_strings['a'], 1
    assert_equal updated_with_strings['b'], 2

    assert_equal updated_with_symbols[:a], 1
    assert_equal updated_with_symbols['b'], 2
    assert_equal updated_with_symbols[:b], 2

    assert_equal updated_with_mixed[:a], 1
    assert_equal updated_with_mixed['b'], 2

    assert [updated_with_strings, updated_with_symbols, updated_with_mixed].all? { |h| h.keys.size == 2 }
  end

  def test_update_with_to_hash_conversion
    hash = SymbolizedHash.new
    hash.update HashByConversion.new({ :a => 1 })
    assert_equal hash['a'], 1
  end

  def test_indifferent_merging
    hash = SymbolizedHash.new
    hash[:a] = 'failure'
    hash['b'] = 'failure'

    other = { 'a' => 1, :b => 2 }

    merged = hash.merge(other)

    assert_equal SymbolizedHash, merged.class
    assert_equal 1, merged[:a]
    assert_equal 2, merged['b']

    hash.update(other)

    assert_equal 1, hash[:a]
    assert_equal 2, hash['b']
  end

  def test_merge_with_to_hash_conversion
    hash = SymbolizedHash.new
    merged = hash.merge HashByConversion.new({ :a => 1 })
    assert_equal merged['a'], 1
  end

  def test_indifferent_replace
    hash = SymbolizedHash.new
    hash[:a] = 42

    replaced = hash.replace(b: 12)

    assert hash.key?('b')
    assert !hash.key?(:a)
    assert_equal 12, hash[:b]
    assert_same hash, replaced
  end

  def test_replace_with_to_hash_conversion
    hash = SymbolizedHash.new
    hash[:a] = 42

    replaced = hash.replace(HashByConversion.new(b: 12))

    assert hash.key?('b')
    assert !hash.key?(:a)
    assert_equal 12, hash[:b]
    assert_same hash, replaced
  end

  def test_indifferent_merging_with_block
    hash = SymbolizedHash.new
    hash[:a] = 1
    hash['b'] = 3

    other = { 'a' => 4, :b => 2, 'c' => 10 }

    merged = hash.merge(other) { |key, old, new| old > new ? old : new }

    assert_equal SymbolizedHash, merged.class
    assert_equal 4, merged[:a]
    assert_equal 3, merged['b']
    assert_equal 10, merged[:c]

    other_indifferent = SymbolizedHash.new('a' => 9, :b => 2)

    merged = hash.merge(other_indifferent) { |key, old, new| old + new }

    assert_equal SymbolizedHash, merged.class
    assert_equal 10, merged[:a]
    assert_equal 5, merged[:b]
  end

  def test_indifferent_reverse_merging
    hash = SymbolizedHash.new key: :old_value
    hash.reverse_merge! key: :new_value
    assert_equal :old_value, hash[:key]

    hash = SymbolizedHash.new('some' => 'value', 'other' => 'value')
    hash.reverse_merge!(:some => 'noclobber', :another => 'clobber')
    assert_equal 'value', hash[:some]
    assert_equal 'clobber', hash[:another]
  end

  def test_indifferent_deleting
    get_hash = proc{ { :a => 'foo' }.to_symbolized_hash }
    hash = get_hash.call
    assert_equal hash.delete(:a), 'foo'
    assert_equal hash.delete(:a), nil
    hash = get_hash.call
    assert_equal hash.delete('a'), 'foo'
    assert_equal hash.delete('a'), nil
  end

  def test_indifferent_select
    hash = Symbolized::SymbolizedHash.new(@strings).select {|k,v| v == 1}

    assert_equal({ :a => 1 }, hash)
    assert_instance_of Symbolized::SymbolizedHash, hash
  end

  def test_indifferent_select_returns_a_hash_when_unchanged
    hash = Symbolized::SymbolizedHash.new(@strings).select {|k,v| true}

    assert_instance_of Symbolized::SymbolizedHash, hash
  end

  def test_indifferent_select_bang
    indifferent_symbols = Symbolized::SymbolizedHash.new(@symbols)
    indifferent_symbols.select! {|k,v| v == 1}

    assert_equal({ :a => 1 }, indifferent_symbols)
    assert_instance_of Symbolized::SymbolizedHash, indifferent_symbols
  end

  def test_indifferent_reject
    hash = Symbolized::SymbolizedHash.new(@symbols).reject {|k,v| v != 1}

    assert_equal({ :a => 1 }, hash)
    assert_instance_of Symbolized::SymbolizedHash, hash
  end

  def test_indifferent_reject_bang
    indifferent_symbols = Symbolized::SymbolizedHash.new(@symbols)
    indifferent_symbols.reject! {|k,v| v != 1}

    assert_equal({ :a => 1 }, indifferent_symbols)
    assert_instance_of Symbolized::SymbolizedHash, indifferent_symbols
  end

  def test_indifferent_to_hash
    # Should convert to a Hash with Symbol keys.
    assert_equal @symbols, @mixed.to_symbolized_hash.to_hash

    # Should preserve the default value.
    mixed_with_default = @mixed.dup
    mixed_with_default.default = '1234'
    roundtrip = mixed_with_default.to_symbolized_hash.to_hash
    assert_equal @symbols, roundtrip
    assert_equal '1234', roundtrip.default

    # Ensure nested hashes are not HashWithIndiffereneAccess
    new_to_hash = @nested_mixed.to_symbolized_hash.to_hash
    assert_not new_to_hash.instance_of?(SymbolizedHash)
    assert_not new_to_hash[:a].instance_of?(SymbolizedHash)
    assert_not new_to_hash[:a][:b].instance_of?(SymbolizedHash)
  end

  def test_lookup_returns_the_same_object_that_is_stored_in_symbolized_hash
    hash = SymbolizedHash.new {|h, k| h[k] = []}
    hash[:a] << 1

    assert_equal [1], hash[:a]
  end

  def test_symbolized_hash_has_no_side_effects_on_existing_hash
    hash = {content: [{:foo => :bar, 'bar' => 'baz'}]}
    hash.to_symbolized_hash

    assert_equal [:foo, "bar"], hash[:content].first.keys
  end

  def test_indifferent_hash_with_array_of_hashes
    hash = { "urls" => { "url" => [ { "address" => "1" }, { "address" => "2" } ] }}.to_symbolized_hash
    assert_equal "1", hash[:urls][:url].first[:address]

    hash = hash.to_hash
    assert_not hash.instance_of?(SymbolizedHash)
    assert_not hash[:urls].instance_of?(SymbolizedHash)
    assert_not hash[:urls][:url].first.instance_of?(SymbolizedHash)
  end

  def test_should_preserve_array_subclass_when_value_is_array
    array = SubclassingArray.new
    array << { "address" => "1" }
    hash = { "urls" => { "url" => array }}.to_symbolized_hash
    assert_equal SubclassingArray, hash[:urls][:url].class
  end

  def test_should_preserve_array_class_when_hash_value_is_frozen_array
    array = SubclassingArray.new
    array << { "address" => "1" }
    hash = { "urls" => { "url" => array.freeze }}.to_symbolized_hash
    assert_equal SubclassingArray, hash[:urls][:url].class
  end

  def test_stringify_and_symbolize_keys_on_indifferent_preserves_hash
    h = SymbolizedHash.new
    h[:first] = 1
    h = h.stringify_keys
    assert_equal 1, h['first']
    h = SymbolizedHash.new
    h['first'] = 1
    h = h.symbolize_keys
    assert_equal 1, h[:first]
  end

  def test_deep_stringify_and_deep_symbolize_keys_on_indifferent_preserves_hash
    h = SymbolizedHash.new
    h[:first] = 1
    h = h.deep_stringify_keys
    assert_equal 1, h['first']
    h = SymbolizedHash.new
    h['first'] = 1
    h = h.deep_symbolize_keys
    assert_equal 1, h[:first]
  end

  def test_to_options_on_indifferent_preserves_hash
    h = SymbolizedHash.new
    h['first'] = 1
    h.to_options!
    assert_equal 1, h['first']
  end

  def test_to_options_on_indifferent_preserves_works_as_hash_with_dup
    h = SymbolizedHash.new({ a: { b: 'b' } })
    dup = h.dup

    dup[:a][:c] = 'c'
    assert_equal 'c', h[:a][:c]
  end

  def test_indifferent_sub_hashes
    h = {'user' => {'id' => 5}}.to_symbolized_hash
    ['user', :user].each {|user| [:id, 'id'].each {|id| assert_equal 5, h[user][id], "h[#{user.inspect}][#{id.inspect}] should be 5"}}

    h = {:user => {:id => 5}}.to_symbolized_hash
    ['user', :user].each {|user| [:id, 'id'].each {|id| assert_equal 5, h[user][id], "h[#{user.inspect}][#{id.inspect}] should be 5"}}
  end

  def test_indifferent_duplication
    # Should preserve default value
    h = SymbolizedHash.new
    h.default = '1234'
    assert_equal h.default, h.dup.default

    # Should preserve class for subclasses
    h = IndifferentHash.new
    assert_equal h.class, h.dup.class
  end

  def test_assert_valid_keys
    assert_nothing_raised do
      { :failure => "stuff", :funny => "business" }.assert_valid_keys([ :failure, :funny ])
      { :failure => "stuff", :funny => "business" }.assert_valid_keys(:failure, :funny)
    end
    # not all valid keys are required to be present
    assert_nothing_raised do
      { :failure => "stuff", :funny => "business" }.assert_valid_keys([ :failure, :funny, :sunny ])
      { :failure => "stuff", :funny => "business" }.assert_valid_keys(:failure, :funny, :sunny)
    end

    exception = assert_raise ArgumentError do
      { :failore => "stuff", :funny => "business" }.assert_valid_keys([ :failure, :funny ])
    end
    assert_equal "Unknown key: :failore. Valid keys are: :failure, :funny", exception.message

    exception = assert_raise ArgumentError do
      { :failore => "stuff", :funny => "business" }.assert_valid_keys(:failure, :funny)
    end
    assert_equal "Unknown key: :failore. Valid keys are: :failure, :funny", exception.message

    exception = assert_raise ArgumentError do
      { :failore => "stuff", :funny => "business" }.assert_valid_keys([ :failure ])
    end
    assert_equal "Unknown key: :failore. Valid keys are: :failure", exception.message

    exception = assert_raise ArgumentError do
      { :failore => "stuff", :funny => "business" }.assert_valid_keys(:failure)
    end
    assert_equal "Unknown key: :failore. Valid keys are: :failure", exception.message
  end

  def test_assorted_keys_not_stringified
    original = {Object.new => 2, 1 => 2, [] => true}
    indiff = original.to_symbolized_hash
    assert(!indiff.keys.any? {|k| k.kind_of? String}, "A key was converted to a string!")
  end

  def test_store_on_symbolized_hash
    hash = SymbolizedHash.new
    hash.store(:test1, 1)
    hash.store('test1', 11)
    hash[:test2] = 2
    hash['test2'] = 22
    expected = { :test1 => 11, :test2 => 22 }
    assert_equal expected, hash
  end

  def test_constructor_on_symbolized_hash
    hash = SymbolizedHash[:foo, 1]
    assert_equal 1, hash[:foo]
    assert_equal 1, hash['foo']
    hash[:foo] = 3
    assert_equal 3, hash[:foo]
    assert_equal 3, hash['foo']
  end

  def test_reverse_merge
    defaults = { :a => "x", :b => "y", :c => 10 }.freeze
    options  = { :a => 1, :b => 2 }
    expected = { :a => 1, :b => 2, :c => 10 }

    # Should merge defaults into options, creating a new hash.
    assert_equal expected, options.reverse_merge(defaults)
    assert_not_equal expected, options

    # Should merge! defaults into options, replacing options.
    merged = options.dup
    assert_equal expected, merged.reverse_merge!(defaults)
    assert_equal expected, merged

    # Should be an alias for reverse_merge!
    merged = options.dup
    assert_equal expected, merged.reverse_update(defaults)
    assert_equal expected, merged
  end

  def test_new_with_to_hash_conversion
    hash = SymbolizedHash.new(HashByConversion.new(a: 1))
    assert hash.key?('a')
    assert_equal 1, hash[:a]
  end

  def test_dup_with_default_proc
    hash = SymbolizedHash.new
    hash.default_proc = proc { |h, v| raise "walrus" }
    assert_nothing_raised { hash.dup }
  end

  def test_dup_with_default_proc_sets_proc
    hash = SymbolizedHash.new
    hash.default_proc = proc { |h, k| k + 1 }
    new_hash = hash.dup

    assert_equal 3, new_hash[2]

    new_hash.default = 2
    assert_equal 2, new_hash[:non_existant]
  end

  def test_to_hash_with_raising_default_proc
    hash = SymbolizedHash.new
    hash.default_proc = proc { |h, k| raise "walrus" }

    assert_nothing_raised { hash.to_hash }
  end

  def test_new_from_hash_copying_default_should_not_raise_when_default_proc_does
    hash = Hash.new
    hash.default_proc = proc { |h, k| raise "walrus" }

    assert_nothing_raised { SymbolizedHash.new_from_hash_copying_default(hash) }
  end
end
