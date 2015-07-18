require 'symbolized'

class Hash
  # Returns a <tt>Symbolized::SymbolizedHash</tt> out of its receiver:
  #
  #   { 'a' => 1 }.to_symbolized_hash[:a] # => 1
  def to_symbolized_hash
    Symbolized::SymbolizedHash.new_from_hash_copying_default(self)
  end

  # Called when object is nested under an object that receives
  # #to_symbolized_hash. This method will be called on the current object
  # by the enclosing object and is aliased to #to_symbolized_hash by
  # default. Subclasses of Hash may overwrite this method to return +self+ if
  # converting to a <tt>Symbolized::SymbolizedHash</tt> would not be desirable.
  #
  #   b = { 'b' => 1 }
  #   { a: b }.with_indifferent_access['a'] # calls b.nested_under_indifferent_access
  #   # => { :b => 1 }
  alias nested_under_symbolized_hash to_symbolized_hash
end
