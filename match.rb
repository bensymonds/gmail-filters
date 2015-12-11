require 'property'
require 'byebug'

class Match
  include Property
  extend Property
  fields :to, :hasTheWord, :subject, :from
end
