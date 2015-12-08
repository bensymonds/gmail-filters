require 'when'

class Filter
  attr_reader :matches, :thens

  def initialize
    @matches = @thens = []
  end

  def to_xml
    out = ""
    builder = Builder::XmlMarkup.new(target: out)
    builder.category(term: "filter") {}
    @matches.each do |m|
      builder << m.to_xml
    end
    out
  end

  def match(&block)
    @matches << When.new.tap {|w| w.instance_eval(&block)}
  end

  def then(&block)
    Then.new.instance_eval(&block)
  end
end

def filter(&block)
  Filter.new.tap {|f| f.instance_eval(&block)}
end

f = filter do
  match do
    to "hello"
  end
end
puts f.to_xml

=begin
criteria
  from
  hasTheWord
  subject
  to
actions
  label
  shouldArchive

    <category term='filter'></category>
    <title>Mail Filter</title>
    <id>tag:mail.google.com,2008:filter:1393173374240</id>
    <updated>2015-12-08T20:23:21Z</updated>
    <content></content>
    <apps:property name='to' value='lmbc-alumni@srcf.net'/>
    <apps:property name='label' value='LMBC/Alumni'/>
    <apps:property name='shouldArchive' value='true'/>

filter {
  when {
    to "lmbc-alumni@srcf.net"
  }
  then {
    label "LMBC/Alumni"
    archive true
  }
end

=end
