require 'minitest/autorun'

module Symbolized
  class TestCase < Minitest::Test
    # test/unit backwards compatibility methods
    alias :assert_raise :assert_raises
    alias :assert_not_empty :refute_empty
    alias :assert_not_equal :refute_equal
    alias :assert_not_in_delta :refute_in_delta
    alias :assert_not_in_epsilon :refute_in_epsilon
    alias :assert_not_includes :refute_includes
    alias :assert_not_instance_of :refute_instance_of
    alias :assert_not_kind_of :refute_kind_of
    alias :assert_no_match :refute_match
    alias :assert_not_nil :refute_nil
    alias :assert_not_operator :refute_operator
    alias :assert_not_predicate :refute_predicate
    alias :assert_not_respond_to :refute_respond_to
    alias :assert_not_same :refute_same

    # Fails if the block raises an exception.
    #
    #   assert_nothing_raised do
    #     ...
    #   end
    def assert_nothing_raised(*args)
      yield
    end

    # Assert that an expression is not truthy. Passes if <tt>object</tt> is
    # +nil+ or +false+. "Truthy" means "considered true in a conditional"
    # like <tt>if foo</tt>.
    #
    #   assert_not nil    # => true
    #   assert_not false  # => true
    #   assert_not 'foo'  # => Expected "foo" to be nil or false
    #
    # An error message can be specified.
    #
    #   assert_not foo, 'foo should be false'
    def assert_not(object, message = nil)
      message ||= "Expected #{mu_pp(object)} to be nil or false"
      assert !object, message
    end
  end
end
