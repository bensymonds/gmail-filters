require 'property'

class Action
  include Property
  extend Property
  fields :label, :shouldArchive
end
