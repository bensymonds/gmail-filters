require 'builder'
require 'filter'

class FilterList
  attr_reader :filters

  def initialize
    @filters = [Filter.new, Filter.new]
  end

  def to_xml
    builder = Builder::XmlMarkup.new(target: STDOUT, indent: 2)
    builder.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    builder.feed do |b|
      filters.each do |filter|
        b.entry do |b|
          b << filter.to_xml
          b << "\n"
        end
      end
    end
  end
end
