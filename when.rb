require 'property'
require 'byebug'

class When
  include Property
  extend Property
  fields :to, :has_the_word, :subject, :from
end
