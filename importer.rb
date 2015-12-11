require 'nokogiri'
require 'match'
require 'action'
require 'filter'
require 'filter_list'

class Importer
  HEADER = %w(
    to
    hasTheWord
    subject
    from
    label
    shouldArchive
  )

  def initialize(filename)
    @doc = File.open(filename) { |f| Nokogiri::XML(f) }
    @doc.remove_namespaces!
  end

  def filter_list
    filter_list = FilterList.new
    @doc.css("entry").each do |e|
      filter = Filter.new
      filter_list << filter
      e.css("property").each do |p|
        case p["name"]
        when *Match.fields
          filter.match.send("#{p["name"]}=", p["value"])
        when *Action.fields
          filter.action.send("#{p["name"]}=", p["value"])
        end
      end
    end

    filter_list
  end
end
puts Importer.new("/Users/ben/temp/mailFilters.xml").filter_list.to_csv
